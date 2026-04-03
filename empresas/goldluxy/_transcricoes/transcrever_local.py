#!/usr/bin/env python3
"""Gera transcrições PT-BR dos WAV em _transcricoes/ com faster-whisper."""
import os
from pathlib import Path

DIR = Path(__file__).resolve().parent
WAVS = sorted(DIR.glob("WhatsApp_Ptt_*_at_*.wav"))


def resolve_model():
    """Pasta local existente, ou id no Hub (ex.: small). Ignora placeholders e caminhos inválidos."""
    env = os.environ.get("FASTER_WHISPER_MODEL", "").strip()
    if not env:
        return "small"

    p = Path(env).expanduser()
    if p.is_dir():
        return str(p)

    # Caminho absoluto que não existe (ex.: exemplo copiado da documentação)
    if env.startswith(("/", "~")) and not p.exists():
        print(
            "Aviso: FASTER_WHISPER_MODEL não é uma pasta válida — a usar modelo 'small' (Hub)."
        )
        return "small"

    low = env.lower()
    if "caminho" in low and "para" in low:
        print("Aviso: FASTER_WHISPER_MODEL parece um placeholder — a usar 'small'.")
        return "small"

    # Id no Hugging Face: small, tiny, Systran/faster-whisper-small, etc.
    return env


def main():
    try:
        from faster_whisper import WhisperModel
    except ImportError as e:
        raise SystemExit(
            "Instala faster-whisper: pip install faster-whisper\n" + str(e)
        ) from e

    model_id = resolve_model()
    print(f"A carregar modelo: {model_id!r} (primeira vez pode demorar se for download)...")
    model = WhisperModel(model_id, device="cpu", compute_type="int8")

    for wav in WAVS:
        print("A transcrever:", wav.name)
        segments, info = model.transcribe(
            str(wav),
            language="pt",
            beam_size=5,
            vad_filter=True,
        )
        lines = []
        for seg in segments:
            lines.append(
                f"[{seg.start:06.1f}s - {seg.end:06.1f}s] {seg.text.strip()}"
            )
        body = "\n".join(lines)
        txt = DIR / (wav.stem + ".txt")
        header = (
            f"Arquivo de áudio: {wav.name}\n"
            f"Idioma: {info.language} (prob. ~{info.language_probability:.2f})\n"
            f"Modelo: faster-whisper ({model_id})\n\n"
            "--- Transcrição ---\n\n"
        )
        txt.write_text(header + body, encoding="utf-8")
        print("  ->", txt)


if __name__ == "__main__":
    if not WAVS:
        raise SystemExit(f"Nenhum WAV encontrado em {DIR}")
    main()
