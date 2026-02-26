cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - itero
  - check
label: itero_check
doc: "Check to ensure binaries are installed and configured.\n\nTool homepage: https://github.com/faircloth-lab/itero"
inputs:
  - id: command
    type: string
    doc: 'Command to execute. Available commands: binaries'
    inputBinding:
      position: 1
  - id: binaries_command
    type:
      - 'null'
      - string
    doc: Check to ensure binaries are installed and configured.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itero:1.1.2--py27_0
stdout: itero_check.out
