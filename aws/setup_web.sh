#!/bin/bash
set -euo pipefail

if [ $# -lt 4 ]; then
  echo "Usage: sudo $0 <DB_HOST> <DB_USER> <DB_PASSWORD> <DB_NAME>"
  exit 1
fi

DB_HOST="$1"
DB_USER="$2"
DB_PASSWORD="$3"
DB_NAME="$4"

echo "--- Installing Python3 + dependencies ---"
yum update -y
yum install -y python3 git

python3 -m pip install --upgrade pip
pip3 install flask pymysql gunicorn

# Create app dir
APP_DIR=/home/ec2-user/app
mkdir -p "${APP_DIR}"
chown ec2-user:ec2-user "${APP_DIR}"

# Expect app.py and requirements.txt were copied to /home/ec2-user/app
if [ ! -f "${APP_DIR}/app.py" ]; then
  echo "Please copy app.py to ${APP_DIR} before running this script."
  echo "Exiting."
  exit 1
fi

# Create environment file for systemd
ENV_FILE=/etc/flask_app.env
echo "DB_HOST=${DB_HOST}" > "${ENV_FILE}"
echo "DB_USER=${DB_USER}" >> "${ENV_FILE}"
echo "DB_PASSWORD=${DB_PASSWORD}" >> "${ENV_FILE}"
echo "DB_NAME=${DB_NAME}" >> "${ENV_FILE}"
chmod 600 "${ENV_FILE}"

# Find gunicorn path and create a safe symlink
GUNICORN_BIN=$(which gunicorn || true)
if [ -z "${GUNICORN_BIN}" ]; then
  echo "gunicorn not found in PATH"
  exit 1
fi
ln -sf "${GUNICORN_BIN}" /usr/local/bin/gunicorn

# Create systemd service
SERVICE_FILE=/etc/systemd/system/flaskapp.service
cat > "${SERVICE_FILE}" <<EOF
[Unit]
Description=Gunicorn instance to serve Flask app
After=network.target

[Service]
User=ec2-user
Group=ec2-user
WorkingDirectory=${APP_DIR}
EnvironmentFile=${ENV_FILE}
ExecStart=${GUNICORN_BIN} --workers 3 --bind 0.0.0.0:80 app:app

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now flaskapp

echo "Flask app service started (port 80)."
