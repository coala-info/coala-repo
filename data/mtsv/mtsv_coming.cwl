cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv
label: mtsv_coming
doc: "mtsv: error: argument COMMAND: invalid choice: 'coming' (choose from 'init',
  'analyze', 'binning', 'readprep', 'summary', 'extract', 'pipeline')\n\nTool homepage:
  https://github.com/FofanovLab/MTSv"
inputs:
  - id: command
    type: string
    doc: Command to run (choose from 'init', 'analyze', 'binning', 'readprep', 
      'summary', 'extract', 'pipeline')
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv:1.0.6--py36hf1ae8f4_2
stdout: mtsv_coming.out
