ROM python:3.10-slim
LABEL "language"="python"
LABEL "framework"="flask"

WORKDIR /app

COPY . .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 8080

CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=8080"]
