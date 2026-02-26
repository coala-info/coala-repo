cwlVersion: v1.2
class: CommandLineTool
baseCommand: head
label: seq_crumbs_seq_head
doc: "Print first 10 lines of FILEs (or stdin). With more than one FILE, precede each
  with a filename header.\n\nTool homepage: https://github.com/JoseBlanca/seq_crumbs"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to print the first lines of
    inputBinding:
      position: 1
  - id: bytes
    type:
      - 'null'
      - string
    doc: Print first N bytes. Suffixes b, k, m supported.
    inputBinding:
      position: 102
      prefix: -c
  - id: lines
    type:
      - 'null'
      - string
    doc: Print first N lines (or all except N last lines if negative). Suffixes 
      b, k, m supported.
    inputBinding:
      position: 102
      prefix: -n
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Never print headers
    inputBinding:
      position: 102
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Always print headers
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequana_pipetools:1.3.1--pyhdfd78af_0
stdout: seq_crumbs_seq_head.out
