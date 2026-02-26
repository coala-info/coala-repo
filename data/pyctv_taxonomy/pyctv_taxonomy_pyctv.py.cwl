cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyctv.py
label: pyctv_taxonomy_pyctv.py
doc: "Parse the current workbook and get a list\n\nTool homepage: https://github.com/linsalrob/pyctv"
inputs:
  - id: command
    type: string
    doc: Command to run
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force an update, even if you have the newest file
    inputBinding:
      position: 102
      prefix: --force
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: Print GenBank IDs and taxonomy
    inputBinding:
      position: 102
      prefix: --genbank
  - id: refseq
    type:
      - 'null'
      - boolean
    doc: Print RefSeq IDs and taxonomy
    inputBinding:
      position: 102
      prefix: --refseq
  - id: semi
    type:
      - 'null'
      - boolean
    doc: Print semi-colon separated taxonomy
    inputBinding:
      position: 102
      prefix: --semi
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyctv_taxonomy:0.25--pyhdfd78af_0
stdout: pyctv_taxonomy_pyctv.py.out
