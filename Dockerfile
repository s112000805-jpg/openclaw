FROM python:3.9-slim
WORKDIR /app

# 1. 複製檔案
COPY . .

# 2. 安裝套件
RUN pip install --upgrade pip && \
    pip install requests flask pydantic openai

EXPOSE 8080

# 3. 暴力尋找並執行：
# find . -name "gateway.py" 會找到路徑 (例如 ./openclaw/gateway.py)
# head -n 1 確保只抓第一個找到的
# xargs 把它傳給 python 執行
CMD ["/bin/sh", "-c", "START_FILE=$(find . -name 'gateway.py' | head -n 1); if [ -n \"$START_FILE\" ]; then python \"$START_FILE\" --host 0.0.0.0 --port 8080 --allow-unconfigured; else echo '錯誤：找不到 gateway.py'; exit 1; fi"]
