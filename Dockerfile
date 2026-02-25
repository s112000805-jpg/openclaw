FROM python:3.9-slim
WORKDIR /app

# 安裝 git 並直接抓取官方核心代碼
RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/idootop/openclaw.git . && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# 設定啟動路徑
CMD ["python", "openclaw/gateway.py", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
