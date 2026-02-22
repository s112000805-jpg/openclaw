FROM python:3.9-slim
WORKDIR /app

# 1. 複製所有內容
COPY . .

# 2. 安裝必要套件 (略過那個會爆炸的 torch)
RUN pip install --upgrade pip && \
    pip install requests flask pydantic openai

# 3. 關鍵：建立一個「萬能啟動腳本」
RUN echo 'import os, sys, subprocess; \
    target = "gateway.py"; \
    found_path = ""; \
    for root, dirs, files in os.walk("."): \
        if target in files: \
            found_path = os.path.join(root, target); \
            break; \
    if found_path: \
        print(f"找到啟動檔: {found_path}"); \
        cmd = ["python", found_path, "--host", "0.0.0.0", "--port", "8080", "--allow-unconfigured"]; \
        subprocess.run(cmd); \
    else: \
        print("錯誤：找不到 gateway.py，請確認 GitHub 檔案結構"); \
        sys.exit(1);' > run.py

EXPOSE 8080

# 4. 執行這個萬能啟動腳本
CMD ["python", "run.py"]
