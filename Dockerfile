FROM python:3.9-slim

WORKDIR /app

# 1. 強制安裝 git 並從官方倉庫直接複製程式碼
RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/idootop/openclaw.git . && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# 2. 修正變數路徑環境
ENV PYTHONPATH=/app

# 3. 啟動指令 (這次絕對有檔案了)
CMD ["python", "openclaw/gateway.py", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
