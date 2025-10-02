from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

books = [
    {"name": "Book A", "author": "Author A", "price": 10.99},
    {"name": "Book B", "author": "Author B", "price": 12.50},
]

@app.route("/books", methods=["GET"])
def get_books():
    return jsonify(books)

@app.route("/books", methods=["POST"])
def add_book():
    data = request.get_json()
    if not data.get("name") or not data.get("author") or not data.get("price"):
        return jsonify({"error": "Missing fields"}), 400
    books.append(data)
    return jsonify(data), 201

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)


# from flask import Flask, request, jsonify
# import mysql.connector

# app = Flask(__name__)

# db = mysql.connector.connect(
#     host="10.0.2.XXX",  # Replace with private IP of DB
#     user="root",
#     password="yourpassword",
#     database="bookdb"
# )

# @app.route('/books')
# def get_books():
#     cursor = db.cursor(dictionary=True)
#     cursor.execute("SELECT * FROM book")
#     return jsonify(cursor.fetchall())

# @app.route('/add_book', methods=['POST'])
# def add_book():
#     data = request.json
#     cursor = db.cursor()
#     cursor.execute("INSERT INTO book (name, author, price) VALUES (%s, %s, %s)", (data["name"], data["author"], data["price"]))
#     db.commit()
#     return jsonify({"message": "Book added"})

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=80)

