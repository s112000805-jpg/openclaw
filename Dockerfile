FROM python:3.10-slim
LABEL "language"="python"

WORKDIR /app

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/idootop/openclaw.git . && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 8080

CMD ["python", "-m", "openclaw.gateway"]
