FROM python:3.9-slim

# 安裝 Git，因為有些 OpenClaw 插件可能需要從 Git 抓取
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 1. 複製檔案
COPY . .

# 2. 安裝套件
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# 3. 環境變數設定：確保 Python 能找到 openclaw 資料夾
# 假設您的結構是 happyfarm-openclaw/openclaw
ENV PYTHONPATH="/app:/app/openclaw"

EXPOSE 8080

# 4. 啟動指令：直接呼叫 python 執行 gateway.py
# 這是最不容易出錯的方式
# 替換掉原本的 CMD 這一行
CMD ["python", "-c", "import os, sys, subprocess; \
    target = 'gateway.py'; \
    found_path = ''; \
    for root, dirs, files in os.walk('.'): \
        if target in files: \
            found_path = os.path.join(root, target); \
            break; \
    if found_path: \
        print(f'找到啟動檔: {found_path}'); \
        cmd = ['python', found_path, '--host', '0.0.0.0', '--port', '8080', '--allow-unconfigured']; \
        subprocess.run(cmd); \
    else: \
        print('錯誤：找不到 gateway.py，請確認 GitHub 檔案結構'); \
        sys.exit(1);"]
