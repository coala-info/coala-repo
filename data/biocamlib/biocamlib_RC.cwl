cwlVersion: v1.2
class: CommandLineTool
baseCommand: RC
label: biocamlib_RC
doc: "A tool to reverse-complement or complement biological sequences.\n\nTool homepage:
  https://github.com/PaoloRibeca/BiOCamLib"
inputs:
  - id: no_complement
    type:
      - 'null'
      - boolean
    doc: do not base-complement the sequence (default is to base-complement)
    inputBinding:
      position: 101
      prefix: --no-complement
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocamlib:1.0.0--h9ee0642_0
stdout: biocamlib_RC.out
