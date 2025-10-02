# 📚 Books Project (React + Flask)

This project is a simple **full-stack application** consisting of:
- **Frontend**: React app to view and add books
- **Backend**: Flask API serving `/books` endpoint

---

## 🚀 Quick Start

### 1. Clone and Extract
```bash
unzip books_project.zip
cd books_project
```

### 2. Start Backend (Flask)
```bash
cd backend
python -m venv venv
venv\Scripts\activate   # Windows
source venv/bin/activate  # Linux/Mac
pip install -r requirements.txt
python app.py
```
Backend will run at: **http://localhost:5000/books**

---

### 3. Start Frontend (React)
Open a new terminal:
```bash
cd frontend
npm install
npm run dev
```
Frontend will run at: **http://localhost:5173**

---

## 📡 API Endpoints

### GET /books
Returns all books.

### POST /books
Add a new book.

Example body:
```json
{
  "name": "Book C",
  "author": "Author C",
  "price": 9.99
}
```

---

## 📝 Notes
- Ensure backend is running **before** using the frontend.
- Both frontend and backend are set to work on localhost by default.
- CORS is enabled in Flask backend.


# 📚 Books React Frontend

This is a simple React app (built with Vite) that connects to a Flask backend to **view** and **add** books.

---

## 🚀 Setup Instructions

### 1. Create React project with Vite

From the `frontend` folder, run:

```bash
npm create vite@latest .
```

* Choose **React**
* Choose **JavaScript**

This will generate a `package.json` with the correct scripts.

---

### 2. Install dependencies

```bash
npm install
```

---

### 3. Replace files

* Overwrite `src/App.jsx` with the provided `App.jsx`
* Add `src/index.css` with the provided styles

---

### 4. Run development server

```bash
npm run dev
```

App runs at:

```
http://localhost:5173
```

---

## 📡 Backend Requirement

This app expects a backend running at:

```
http://localhost:5000/books
```

The backend should support:

* `GET /books` → return list of books
* `POST /books` → add a new book
