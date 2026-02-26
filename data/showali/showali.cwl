cwlVersion: v1.2
class: CommandLineTool
baseCommand: showali
label: showali
doc: "Show alignment file\n\nTool homepage: https://github.com/kirilenkobm/showali"
inputs:
  - id: alignment_file
    type: File
    doc: Alignment file to display
    inputBinding:
      position: 1
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Disable ANSI color codes
    inputBinding:
      position: 102
      prefix: --no-color
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/showali:1.0.1--h7b50bb2_0
stdout: showali.out
