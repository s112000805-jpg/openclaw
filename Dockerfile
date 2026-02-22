FROM python:3.9-slim
WORKDIR /app

# 1. 複製倉庫內所有剛上傳的檔案
COPY . .

# 2. 直接安裝當前目錄的專案
RUN pip install --upgrade pip && pip install . requests

EXPOSE 8080

# 3. 啟動指令
CMD ["openclaw", "gateway", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
