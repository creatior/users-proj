FROM python:3.12

WORKDIR /app

COPY . .
COPY pyproject.toml .
COPY Makefile .

RUN make -f Makefile

CMD ["make", "run"]
