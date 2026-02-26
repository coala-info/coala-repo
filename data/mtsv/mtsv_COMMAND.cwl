cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv
label: mtsv_COMMAND
doc: "mtsv: error: argument COMMAND: invalid choice: 'COMMAND' (choose from 'init',
  'analyze', 'binning', 'readprep', 'summary', 'extract', 'pipeline')\n\nTool homepage:
  https://github.com/FofanovLab/MTSv"
inputs:
  - id: command
    type: string
    doc: 'Command to execute. Available commands: init, analyze, binning, readprep,
      summary, extract, pipeline'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
stdout: mtsv_COMMAND.out
