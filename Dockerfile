FROM python:3.9-slim
WORKDIR /app

# 1. 複製所有檔案
COPY . .

# 2. 安裝必要的套件 (跳過會報錯的 torch)
RUN pip install --upgrade pip && \
    pip install requests flask pydantic openai

# 3. 暴力修復：不論 openclaw 在哪一層，都把它加到搜尋路徑
ENV PYTHONPATH="/app:/app/openclaw:/app/openclaw-main"

EXPOSE 8080

# 4. 啟動指令：直接執行檔案路徑，這比 -m 模組啟動更穩定
# 我們假設 gateway.py 就在 openclaw 資料夾內
CMD ["python", "openclaw/gateway.py", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
