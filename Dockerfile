FROM python:3.9-slim
WORKDIR /app

# 1. 安裝 Git (預防某些套件需要)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# 2. 複製檔案
COPY . .

# 3. 安裝套件
RUN pip install --upgrade pip && \
    pip install flask pydantic openai requests python-dotenv

EXPOSE 8080

# 4. 終極啟動指令：
# 用 find 找 gateway.py，找到後直接 python 執行它
CMD ["/bin/sh", "-c", "TARGET_FILE=$(find . -name 'gateway.py' | head -n 1); if [ -z \"$TARGET_FILE\" ]; then echo '錯誤：找不到 gateway.py'; exit 1; else echo \"找到啟動檔：$TARGET_FILE\"; python \"$TARGET_FILE\" --host 0.0.0.0 --port 8080 --allow-unconfigured; fi"]
