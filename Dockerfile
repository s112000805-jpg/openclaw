
FROM python:3.9-slim
WORKDIR /app

# 1. 下載 git 並從官方源抓取完整的 OpenClaw
RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/idootop/openclaw.git .

# 2. 安裝官方對應的依賴套件
RUN pip install --no-cache-dir -r requirements.txt

# 3. 啟動網關
CMD ["python", "openclaw/gateway.py", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
