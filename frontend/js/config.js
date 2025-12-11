export const QR_API_URL =
  window.location.hostname === "localhost"
    ? "http://localhost:8000/api/qr/create"
    : "https://cratejuice-press-backend.onrender.com/api/qr/create"
