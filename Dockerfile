FROM python:3.9-slim

# 安裝 Git，因為有些 OpenClaw 插件可能需要從 Git 抓取
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 1. 複製檔案
COPY . .

# 2. 安裝套件
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# 3. 環境變數設定：確保 Python 能找到 openclaw 資料夾
# 假設您的結構是 happyfarm-openclaw/openclaw
ENV PYTHONPATH="/app:/app/openclaw"

EXPOSE 8080

# 4. 啟動指令：直接呼叫 python 執行 gateway.py
# 這是最不容易出錯的方式
CMD ["python", "openclaw/gateway.py", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
