FROM python:3.9-slim
WORKDIR /app

# 安裝必要工具
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# 直接從 GitHub 下載 OpenClaw 原始碼並安裝
# 注意：這裡使用 OpenClaw 官方倉庫的 zip 連結
RUN pip install --no-cache-dir https://github.com/idootop/openclaw/archive/refs/heads/main.zip requests

EXPOSE 8080

# 啟動並跳過認證
CMD ["openclaw", "gateway", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
