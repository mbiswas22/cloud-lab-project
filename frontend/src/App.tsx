import React, { useEffect, useState } from "react";
import "./index.css";

export default function App() {
  const [books, setBooks] = useState([]);
  const [newBook, setNewBook] = useState({ name: "", author: "", price: "" });

  useEffect(() => {
    fetch("http://localhost:5000/books")
      .then((res) => res.json())
      .then((data) => setBooks(data))
      .catch((err) => console.error(err));
  }, []);

  const handleAddBook = () => {
    fetch("http://localhost:5000/books", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(newBook),
    })
      .then((res) => res.json())
      .then((book) => setBooks([...books, book]))
      .catch((err) => console.error(err));
  };

  return (
    <div className="p-6">
      <div className="mt-6 p-4">
        <h2 style={{ fontWeight: "bold" }}>Add a Book</h2>
        <input
          className="border p-2 mr-2"
          placeholder="Book Name"
          value={newBook.name}
          onChange={(e) => setNewBook({ ...newBook, name: e.target.value })}
        />
        <input
          className="border p-2 mr-2"
          placeholder="Author"
          value={newBook.author}
          onChange={(e) => setNewBook({ ...newBook, author: e.target.value })}
        />
        <input
          className="border p-2 mr-2"
          placeholder="Price"
          type="number"
          value={newBook.price}
          onChange={(e) => setNewBook({ ...newBook, price: e.target.value })}
        />
        <button
          onClick={handleAddBook}
          className="bg-blue-500 text-white px-4 py-2 rounded"
        >
          Add Book
        </button>

        <div className="p-6" style={{ marginTop: "50px" }}>
          <h1 className="text-2xl font-bold mb-6 text-center">Books Table</h1>
          <div className="overflow-x-auto">
            <table className="min-w-full border border-gray-300 shadow-md rounded-lg overflow-hidden">
              <thead className="bg-blue-500 text-white">
                <tr>
                  <th className="px-6 py-3 text-left text-sm font-semibold uppercase">
                    Name
                  </th>
                  <th className="px-6 py-3 text-left text-sm font-semibold uppercase">
                    Author
                  </th>
                  <th className="px-6 py-3 text-left text-sm font-semibold uppercase">
                    Price ($)
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200 bg-white">
                {books.length > 0 ? (
                  books.map((book, index) => (
                    <tr key={index} className="hover:bg-gray-100 transition">
                      <td className="px-6 py-4 text-gray-800">{book.name}</td>
                      <td className="px-6 py-4 text-gray-600">{book.author}</td>
                      <td className="px-6 py-4 text-gray-600">{book.price}</td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td
                      colSpan={3}
                      className="text-center px-6 py-4 text-gray-500 italic"
                    >
                      No books available
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>

        {/* <h1 className="text-2xl font-bold mb-4">Books List</h1>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {books.map((book, idx) => (
            <div key={idx} className="border p-4 rounded-lg shadow">
              <p className="font-semibold" style={{ fontWeight: "bold" }}>
                {book.name}
              </p>
              <p>Author: {book.author}</p>
              <p>Price: ${book.price}</p>
            </div>
          ))}
        </div> */}
      </div>
    </div>
  );
}
