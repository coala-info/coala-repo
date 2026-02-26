cwlVersion: v1.2
class: CommandLineTool
baseCommand: poretools metadata
label: poretools_metadata
doc: "Report metadata from FAST5 files.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files.
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 102
      prefix: --quiet
  - id: report_read_metadata
    type:
      - 'null'
      - boolean
    doc: Report read level metadata
    inputBinding:
      position: 102
      prefix: --read
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
stdout: poretools_metadata.out
