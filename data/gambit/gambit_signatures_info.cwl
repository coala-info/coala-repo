cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gambit
label: gambit_signatures_info
doc: "Inspect GAMBIT signature (.gs) files.\n\nTool homepage: https://github.com/jlumpe/gambit"
inputs:
  - id: db
    type:
      - 'null'
      - Directory
    doc: Directory containing GAMBIT database files (global option, given before the subcommand).
    inputBinding:
      position: 1
      prefix: --db
  - id: file
    type:
      - 'null'
      - File
    doc: Signature (.gs) file to inspect.
    inputBinding:
      position: 103
  - id: json
    type:
      - 'null'
      - boolean
    doc: Write output in JSON format.
    inputBinding:
      position: 102
      prefix: --json
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: Prettify JSON output.
    inputBinding:
      position: 102
      prefix: --pretty
  - id: ids
    type:
      - 'null'
      - boolean
    doc: Write IDs of signatures in file, one per line.
    inputBinding:
      position: 102
      prefix: --ids
  - id: use_db_signatures
    type:
      - 'null'
      - boolean
    doc: Use signatures from reference database.
    inputBinding:
      position: 102
      prefix: -d
arguments:
  - position: 2
    valueFrom: signatures
  - position: 3
    valueFrom: info
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
stdout: gambit_signatures_info.out
