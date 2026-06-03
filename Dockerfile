ARG HOMEBOX_TAG=latest
FROM ghcr.io/sysadminsmedia/homebox:${HOMEBOX_TAG}

COPY requirements.txt /tmp/requirements.txt

# Build deps for Pillow + runtime libs
RUN apk add --no-cache \
    python3 \
    py3-pip \
    python3-dev \
    build-base \
    zlib-dev \
    jpeg-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    freetype-dev \
    font-liberation \
    && pip3 install --break-system-packages --no-cache-dir -r /tmp/requirements.txt \
    && apk del python3-dev build-base zlib-dev jpeg-dev libpng-dev freetype-dev

COPY print-label.py /usr/local/bin/print-label.py
COPY print-label.sh /usr/local/bin/print-label.sh
RUN chmod +x /usr/local/bin/print-label.sh

ENV HBOX_LABEL_MAKER_PRINT_COMMAND="/usr/local/bin/print-label.sh"
