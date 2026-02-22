FROM python:3.9-slim
WORKDIR /app

# 1. 複製所有檔案
COPY . .

# 2. 安裝必要的輕量庫 (避開沉重的依賴)
RUN pip install --upgrade pip && \
    pip install requests flask pydantic openai

# 3. 核心修正：自動偵測路徑並啟動
# 我們同時檢查 /app 和可能的子目錄 /app/openclaw-main
ENV PYTHONPATH=/app:/app/openclaw-main

EXPOSE 8080

# 4. 啟動指令：使用 python -m 方式啟動 gateway 模組
CMD ["python", "-m", "openclaw.gateway", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
