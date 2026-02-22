FROM python:3.9-slim
WORKDIR /app

# 1. 安裝 git (這次一定要裝，因為我們要手動 clone)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# 2. 直接複製原始碼到本地 (使用正確的開源地址)
RUN git clone https://github.com/idootop/openclaw.git .

# 3. 升級 pip 並安裝當前目錄下的專案與 requests
RUN pip install --upgrade pip && pip install . requests

EXPOSE 8080

# 4. 啟動指令，記得加上關鍵的 --allow-unconfigured
CMD ["openclaw", "gateway", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
