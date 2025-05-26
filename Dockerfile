ARG PYTHON_VERSION=3.12

FROM python:${PYTHON_VERSION}-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:0.7.8 /uv /uvx /bin/

ENV \
    UV_CACHE_DIR=/cache \
    UV_LINK_MODE=copy \
    UV_SYSTEM_PYTHON=1 \
    UV_PYTHON_DOWNLOADS=never \
    UV_COMPILE_BYTECODE=1 \
    UV_LOCKED=1 \
    UV_PROJECT_ENVIRONMENT=/app

ADD . /app

WORKDIR /app
RUN uv sync --locked

CMD ["uv", "run", "poe", "start"]