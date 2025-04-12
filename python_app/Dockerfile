# builder stage
FROM python:3.12 AS builder

WORKDIR /app

COPY pyproject.toml Makefile ./
RUN make install && \
    make install-dev && \
    rm -rf /root/.cache/pip

# final stage
FROM python:3.12-slim as prod

WORKDIR /app

#RUN apt-get update && apt-get install -y --no-install-recommends make && \
#    rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/.local/lib/python3.12/site-packages /root/.local/lib/python3.12/site-packages
COPY --from=builder /root/.local/bin /root/.local/bin

ENV PYTHONPATH="/root/.local/lib/python3.12/site-packages /root/.local/lib/python3.12/site-packages" \
    PATH="/root/.local/bin:${PATH}"

COPY /src /src

# RUN make test

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--reload"]
