export const API_BASE_URL =
  window.location.hostname === "localhost"
    ? "http://localhost:8000"
    : "https://cratejuice-press-backend.onrender.com";

export const QR_API_URL = `${API_BASE_URL}/api/qr/create`;
