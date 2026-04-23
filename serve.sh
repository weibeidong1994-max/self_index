#!/bin/bash

# Self Index - 独立进程静态文件服务
# 用法: ./serve.sh start|stop|status|restart|open

PORT=6789
PID_FILE=".serve.pid"
DIR="dist"

check_running() {
  if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p "$PID" > /dev/null 2>&1; then
      return 0
    fi
  fi
  return 1
}

case "${1:-}" in
  start)
    if check_running; then
      PID=$(cat "$PID_FILE")
      echo "✅ 服务已在运行 (PID: $PID)"
      echo "   访问地址: http://localhost:$PORT/"
      exit 0
    fi

    if [ ! -d "$DIR" ]; then
      echo "❌ 目录 $DIR 不存在，请先运行: npm run build"
      exit 1
    fi

    nohup python3 -m http.server "$PORT" --directory "$DIR" > .serve.log 2>&1 &
    PID=$!
    echo $PID > "$PID_FILE"

    sleep 1
    if ps -p "$PID" > /dev/null 2>&1; then
      echo "🚀 服务已启动 (PID: $PID)"
      echo "   访问地址: http://localhost:$PORT/"
      echo "   日志文件: .serve.log"
      open "http://localhost:$PORT/"
    else
      echo "❌ 服务启动失败，请检查 .serve.log"
      rm -f "$PID_FILE"
      exit 1
    fi
    ;;

  stop)
    if check_running; then
      PID=$(cat "$PID_FILE")
      kill "$PID" 2>/dev/null
      rm -f "$PID_FILE"
      echo "🛑 服务已停止"
    else
      echo "ℹ️ 服务未在运行"
    fi
    ;;

  status)
    if check_running; then
      PID=$(cat "$PID_FILE")
      echo "✅ 服务运行中 (PID: $PID)"
      echo "   访问地址: http://localhost:$PORT/"
    else
      echo "ℹ️ 服务未在运行"
      echo "   启动命令: ./serve.sh start"
    fi
    ;;

  restart)
    $0 stop
    sleep 1
    $0 start
    ;;

  open)
    if check_running; then
      open "http://localhost:$PORT/"
    else
      echo "ℹ️ 服务未在运行，正在启动..."
      $0 start
    fi
    ;;

  *)
    echo "Self Index - 独立进程静态文件服务"
    echo ""
    echo "用法: ./serve.sh <命令>"
    echo ""
    echo "命令:"
    echo "  start    启动后台服务"
    echo "  stop     停止后台服务"
    echo "  status   查看服务状态"
    echo "  restart  重启服务"
    echo "  open     在浏览器中打开页面"
    echo ""
    echo "注意: 启动前请确保已执行 npm run build 生成 dist/ 目录"
    exit 1
    ;;
esac
