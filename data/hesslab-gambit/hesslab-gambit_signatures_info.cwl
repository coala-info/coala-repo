cwlVersion: v1.2
class: CommandLineTool
baseCommand: gambit
label: hesslab-gambit_signatures_info
doc: "Inspect GAMBIT signature files.\n\nTool homepage: https://github.com/hesslab-gambit/gambit"
arguments:
  - position: 2
    valueFrom: signatures
  - position: 3
    valueFrom: info
inputs:
  - id: signature_file
    type:
      - 'null'
      - File
    doc: GAMBIT signature file to inspect.
    inputBinding:
      position: 200
  - id: db
    type:
      - 'null'
      - Directory
    doc: Directory containing GAMBIT database files (the root level --db option; needed with use_db).
    inputBinding:
      position: 1
      prefix: --db
  - id: json
    type:
      - 'null'
      - boolean
    doc: Write output in JSON format.
    inputBinding:
      position: 101
      prefix: --json
  - id: pretty
    type:
      - 'null'
      - boolean
    doc: Prettify JSON output.
    inputBinding:
      position: 101
      prefix: --pretty
  - id: ids
    type:
      - 'null'
      - boolean
    doc: Write IDs of signatures in file, one per line.
    inputBinding:
      position: 101
      prefix: --ids
  - id: use_db
    type:
      - 'null'
      - boolean
    doc: Use signatures from reference database.
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
stdout: hesslab-gambit_signatures_info.out
