FROM python:3.9-slim
WORKDIR /app

# 1. 複製所有檔案
COPY . .

# 2. 只安裝 OpenClaw 運作絕對必要的輕量套件，避開沉重的 torch
# 我們直接安裝 gateway 模式需要的依賴
RUN pip install --upgrade pip && \
    pip install requests flask pydantic openai

EXPOSE 8080

# 3. 直接以模組方式啟動，不透過 pip install 安裝
# 假設您的資料夾結構中 openclaw 是一個 package
ENV PYTHONPATH=/app
CMD ["python", "-m", "openclaw.gateway", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
