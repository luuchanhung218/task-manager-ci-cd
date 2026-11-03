
FROM python:3.9-slim

WORKDIR /app

COPY . /app

RUN chmod +x /app/.github/scripts/entrypoint.sh \
    /app/.github/scripts/update_index.sh

ENTRYPOINT ["bash", "/app/.github/scripts/entrypoint.sh"]
