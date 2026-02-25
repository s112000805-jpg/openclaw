FROM python:3.9-slim
WORKDIR /app

# 1. 安裝 git 並從官方倉庫補齊核心代碼
RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/idootop/openclaw.git . && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# 2. 啟動指令：監聽 8080 端口
CMD ["python", "openclaw/gateway.py", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
