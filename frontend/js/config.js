export const QR_API_URL =
  window.location.hostname === "localhost"
    ? "http://localhost:8000/api/qr/create"
    : "https://your-render-backend-url.onrender.com/api/qr/create";
