# 使用輕量級 Python 環境
FROM python:3.9-slim

# 設定工作目錄
WORKDIR /app

# 1. 安裝 git (因為我們需要從官方下載缺少的程式碼)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# 2. 核心大招：直接從官方倉庫補齊您的檔案
# 這會把缺少的 openclaw 資料夾直接抓進來
RUN git clone https://github.com/idootop/openclaw.git .

# 3. 安裝必要套件
RUN pip install --no-cache-dir -r requirements.txt

# 4. 啟動指令 (路徑現在絕對正確了)
CMD ["python", "openclaw/gateway.py", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
