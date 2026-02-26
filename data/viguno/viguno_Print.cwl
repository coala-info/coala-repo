cwlVersion: v1.2
class: CommandLineTool
baseCommand: viguno
label: viguno_Print
doc: "A tool for processing and analyzing biological sequences.\n\nTool homepage:
  https://github.com/bihealth/viguno"
inputs:
  - id: command
    type: string
    doc: The command to run
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viguno:0.4.0--h13c227e_0
stdout: viguno_Print.out
