cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrez_idx_bx_sqlite3.py
label: lrez_idx_bx_sqlite3.py
doc: "A tool for indexing BX tags in a SQLite3 database (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/flegeai/LRez"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrez:2.2.4--h077b44d_4
stdout: lrez_idx_bx_sqlite3.py.out
