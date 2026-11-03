
#!/bin/bash
set -euo pipefail

cd /app

echo "=== Task Manager ==="

python3 .github/scripts/todo.py \
    | tee /tmp/todo_output.txt

echo "=== Unit Tests ==="

python3 .github/scripts/todo-test.py 2>&1 \
    | tee /tmp/test_output.txt

echo "=== Updating Dashboard ==="

bash .github/scripts/update_index.sh \
    /tmp/todo_output.txt \
    /tmp/test_output.txt

echo "Process Completed!"
