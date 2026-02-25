# 第一行絕對不能少，這是基礎環境
FROM python:3.9-slim

WORKDIR /app

# 1. 複製檔案
COPY . .

# 2. 列出所有檔案並保持運行，讓我們看清楚路徑
# 這會解決 "no build stage" 錯誤，並幫我們抓出檔案到底在哪
CMD ["/bin/sh", "-c", "echo '--- 檔案清單開始 ---'; ls -R; echo '--- 檔案清單結束 ---'; sleep 3600"]
