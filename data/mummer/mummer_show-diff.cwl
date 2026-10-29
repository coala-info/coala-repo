cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - show-diff
label: mummer_show-diff
doc: "Output a list of structural differences (GAP, DUP, BRK, JMP, INV, SEQ) for each sequence in the reference and query, sorted by position.\n\nTool homepage: https://github.com/mummer4/mummer"
inputs:
  - id: amos_features
    type:
      - 'null'
      - boolean
    doc: "Output diff information as AMOS features"
    inputBinding:
      position: 1
      prefix: "-f"
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: "Do not show header"
    inputBinding:
      position: 1
      prefix: "-H"
  - id: queries
    type:
      - 'null'
      - boolean
    doc: "Show diff information for queries"
    inputBinding:
      position: 1
      prefix: "-q"
  - id: references
    type:
      - 'null'
      - boolean
    doc: "Show diff information for references (default)"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: delta_file
    type: File
    doc: "Delta alignment file from nucmer or promer"
    inputBinding:
      position: 100
outputs:
  - id: stdout_out
    type: stdout
    doc: "List of structural differences"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stdout: mummer_show-diff.diff
stderr: mummer_show-diff.log
