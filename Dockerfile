FROM python:3.9-slim
WORKDIR /app

# 1. 複製所有檔案
COPY . .

# 2. 安裝必要的輕量庫 (避開那個報錯的 torch)
RUN pip install --upgrade pip && \
    pip install requests flask pydantic openai

# 3. 關鍵：設定 Python 路徑，確保它能找到 openclaw 資料夾
# 我們同時嘗試從根目錄或子目錄啟動
ENV PYTHONPATH=/app:/app/openclaw-main

EXPOSE 8080

# 4. 啟動指令：直接執行檔案，這是最穩的
# 如果 openclaw 裡面有 gateway.py，就直接執行它
CMD ["python", "-m", "openclaw.gateway", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
