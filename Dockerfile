FROM python:3.11-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    WEB_PORT=8000 \
    BID_REVIEW_PAGE_RENDERER=libreoffice \
    BID_REVIEW_LIBREOFFICE_PATH=/usr/bin/libreoffice \
    HOME=/tmp

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        fontconfig \
        fonts-noto-cjk \
        libreoffice-writer \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN python -m pip install --no-cache-dir -r requirements.txt

COPY web_main.py main.py review_rules.md ./
COPY src ./src
COPY web ./web

RUN mkdir -p /app/web_data/jobs

EXPOSE 8000

CMD ["python", "web_main.py"]
