cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grabix
  - grab
label: grabix_grab
doc: "Extract a line or a range of lines (the header is printed first) from an indexed bgzipped file.\n\nTool homepage: https://github.com/arq5x/grabix"
inputs:
  - id: bgzf_file
    type: File
    secondaryFiles:
      - .gbi
    doc: bgzipped file with its grabix index (.gbi) beside it
    inputBinding:
      position: 1
  - id: line_start
    type: int
    doc: first line to extract (header lines are not counted)
    inputBinding:
      position: 2
  - id: line_end
    type:
      - 'null'
      - int
    doc: last line to extract (default is line_start only)
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Extracted lines with the file header first
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grabix:0.1.8--h077b44d_12
stdout: grabix_grab.out
