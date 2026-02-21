cwlVersion: v1.2
class: CommandLineTool
baseCommand: aletsch
label: aletsch
doc: "Aletsch is a tool for transcript assembly (Note: The provided text is an error
  log and does not contain help information; description and arguments could not be
  extracted from the input).\n\nTool homepage: https://github.com/Shao-Group/aletsch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aletsch:1.1.3--h503566f_1
stdout: aletsch.out
