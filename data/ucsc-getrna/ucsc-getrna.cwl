cwlVersion: v1.2
class: CommandLineTool
baseCommand: getRNA
label: ucsc-getrna
doc: "Get RNA sequences from a database. Note: The provided input text contained a
  Docker error ('no space left on device') rather than the tool's help output. The
  following structure represents the standard usage for this UCSC utility.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The database name (e.g., hg19)
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbose level
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_file
    type: File
    doc: The output RNA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-getrna:482--h0b57e2e_0
