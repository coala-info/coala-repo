cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucleosome_prediction
label: nucleosome_prediction
doc: "A tool for nucleosome prediction. Note: The provided help text contains only
  container runtime error messages and does not list specific command-line arguments.\n
  \nTool homepage: https://genie.weizmann.ac.il/software/nucleo_prediction.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucleosome_prediction:3.0--pl5321h503566f_7
stdout: nucleosome_prediction.out
