ARG HOMEBOX_IMAGE=ghcr.io/sysadminsmedia/homebox:latest
FROM ${HOMEBOX_IMAGE}

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

COPY pyproject.toml uv.lock /tmp/

# Build deps for Pillow + runtime libs
RUN apk add --no-cache \
    python3 \
    python3-dev \
    build-base \
    zlib-dev \
    jpeg-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    freetype-dev \
    font-liberation \
    && UV_SYSTEM_PYTHON=1 uv sync --frozen --no-cache --project /tmp \
    && apk del python3-dev build-base zlib-dev jpeg-dev libpng-dev freetype-dev

COPY print-label.py /usr/local/bin/print-label.py
COPY print-label.sh /usr/local/bin/print-label.sh
RUN chmod +x /usr/local/bin/print-label.sh

ENV HBOX_LABEL_MAKER_PRINT_COMMAND="/usr/local/bin/print-label.sh"
