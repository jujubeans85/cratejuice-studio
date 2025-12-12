# backend/main.py
# CrateJuice Studio – The Press (QR + Crate API v1.0)

import io
from typing import List, Optional

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import StreamingResponse, JSONResponse
from pydantic import BaseModel
import qrcode
from qrcode.image.pil import PilImage

app = FastAPI(title="CrateJuice Press QR API")

# CORS – allow Netlify + local dev (can tighten later)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ---------- QR MODELS & ENDPOINT ----------

class QRRequest(BaseModel):
    data: str


@app.post("/api/qr/create")
async def create_qr(payload: QRRequest):
    if not payload.data.strip():
        return JSONResponse({"error": "Empty data"}, status_code=400)

    qr = qrcode.QRCode(version=1, box_size=8, border=2)
    qr.add_data(payload.data)
    qr.make(fit=True)
    img: PilImage = qr.make_image(fill_color="black", back_color="white")

    buf = io.BytesIO()
    img.save(buf, format="PNG")
    buf.seek(0)
    return StreamingResponse(buf, media_type="image/png")


# ---------- CRATE STACKER MODELS & ENDPOINT ----------

class CrateIn(BaseModel):
    name: Optional[str] = None
    playlist_url: Optional[str] = None
    raw_tracks: str  # text blob, one track per line


class Track(BaseModel):
    artist: str
    title: str
    raw: str


class CrateOut(BaseModel):
    crate_name: str
    playlist_url: Optional[str]
    track_count: int
    tracks: List[Track]


def parse_track_line(line: str) -> Track:
    raw = line.strip()
    if " - " in raw:
        artist, title = raw.split(" - ", 1)
    elif "-" in raw:
        artist, title = raw.split("-", 1)
    else:
        artist, title = "", raw
    return Track(artist=artist.strip(), title=title.strip(), raw=raw)


@app.post("/api/crate/ingest", response_model=CrateOut)
async def ingest_crate(payload: CrateIn):
    lines = [ln.strip() for ln in payload.raw_tracks.splitlines() if ln.strip()]
    tracks = [parse_track_line(ln) for ln in lines]

    crate_name = payload.name or "Untitled Crate"
    return CrateOut(
        crate_name=crate_name,
        playlist_url=payload.playlist_url,
        track_count=len(tracks),
        tracks=tracks,
    )


# ---------- HEALTHCHECK ----------

@app.get("/health")
async def health():
    return {"status": "ok", "service": "cratejuice-press"}
