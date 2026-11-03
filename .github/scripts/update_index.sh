
#!/bin/bash
set -euo pipefail

python3 - "$1" "$2" <<'PY'
import html
from pathlib import Path
import re
import sys

task_output = Path(sys.argv[1]).read_text(
    encoding="utf-8"
)
test_output = Path(sys.argv[2]).read_text(
    encoding="utf-8"
)

todo = task_output.split(
    "ToDo Tasks:\n", 1
)[1].split("\nDone Tasks:\n", 1)[0].strip()

done = task_output.split(
    "\nDone Tasks:\n", 1
)[1].strip()

html_file = Path("index.html")
page = html_file.read_text(encoding="utf-8")

sections = [
    ("pending", todo),
    ("completed", done),
    ("unittest", test_output.strip())
]

for section_id, value in sections:
    pattern = re.compile(
        r'(<pre id="' + section_id + r'">).*?(</pre>)',
        re.DOTALL
    )

    if not pattern.search(page):
        raise SystemExit(
            f'Missing <pre id="{section_id}">'
        )

    page = pattern.sub(
        lambda m: (
            m.group(1)
            + "\n"
            + html.escape(value)
            + "\n"
            + m.group(2)
        ),
        page,
        count=1
    )

html_file.write_text(page, encoding="utf-8")
print("index.html updated successfully")
PY
