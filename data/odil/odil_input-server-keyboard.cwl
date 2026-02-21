cwlVersion: v1.2
class: CommandLineTool
baseCommand: odil_input-server-keyboard
label: odil_input-server-keyboard
doc: "odil_input-server-keyboard\n\nTool homepage: https://github.com/odilia-app/odilia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/odil:v0.10.0-3-deb-py3_cv1
stdout: odil_input-server-keyboard.out
