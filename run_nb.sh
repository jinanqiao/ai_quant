#!/usr/bin/env bash
# 一键在终端运行任意 ipynb 文件，输出全部打到 stdout。
# 用法： ./run_nb.sh path/to/xxx.ipynb

set -e

if [ $# -lt 1 ]; then
  echo "用法: $0 <path/to/notebook.ipynb>"
  exit 1
fi

NB_PATH="$1"

if [ ! -f "$NB_PATH" ]; then
  echo "找不到文件: $NB_PATH"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 自动激活项目自带的 .venv
if [ -f "$SCRIPT_DIR/.venv/bin/activate" ]; then
  # shellcheck disable=SC1091
  source "$SCRIPT_DIR/.venv/bin/activate"
fi

jupyter nbconvert --to script --stdout "$NB_PATH" 2>/dev/null | python
