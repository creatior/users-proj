# builder stage
FROM python:3.12 AS builder

WORKDIR /app

COPY pyproject.toml Makefile ./
RUN make install && \
    make install-dev && \
    rm -rf /root/.cache/pip 

ENV PYTHONPATH="/app:${PYTHONPATH}"

COPY . .

# test stage
FROM python:3.12-slim AS test

WORKDIR /app

COPY --from=builder /root/.local/lib/python3.12/site-packages /root/.local/lib/python3.12/site-packages
COPY --from=builder /root/.local/bin /root/.local/bin

ENV PYTHONPATH="/app:/root/.local/lib/python3.12/site-packages" \
    PATH="/root/.local/bin:${PATH}"

COPY . .

CMD ["pytest", "tests"]

# final stage
FROM python:3.12-slim as prod

WORKDIR /app

COPY --from=builder /root/.local/lib/python3.12/site-packages /root/.local/lib/python3.12/site-packages
COPY --from=builder /root/.local/bin /root/.local/bin

ENV PYTHONPATH="/root/.local/lib/python3.12/site-packages" \
    PATH="/root/.local/bin:${PATH}"

COPY . .

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--reload"]