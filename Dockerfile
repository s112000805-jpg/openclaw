FROM python:3.9-slim
WORKDIR /app

# 安裝 git 以支援從 GitHub 安裝套件
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 暴露埠號並啟動
EXPOSE 8080
CMD ["openclaw", "gateway", "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]
