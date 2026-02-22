FROM python:3.9-slim
WORKDIR /app

# 修正：直接安裝 OpenClaw 套件
RUN pip install --no-cache-dir OpenClaw requests

EXPOSE 8080

# 確保加上跳過設定的參數
CMD ["openclaw", "gateway", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
