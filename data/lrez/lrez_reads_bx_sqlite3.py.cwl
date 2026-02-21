cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrez_reads_bx_sqlite3.py
label: lrez_reads_bx_sqlite3.py
doc: "A tool from the LReZ (Long Read Zealot) suite for processing barcode (BX) tags
  using SQLite3. (Note: The provided help text contains only container runtime error
  messages and no usage information.)\n\nTool homepage: https://github.com/flegeai/LRez"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrez:2.2.4--h077b44d_4
stdout: lrez_reads_bx_sqlite3.py.out
