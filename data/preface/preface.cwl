cwlVersion: v1.2
class: CommandLineTool
baseCommand: preface
label: preface
doc: "The provided text is a container build log and does not contain help information
  or usage instructions for the 'preface' tool. As a result, no arguments could be
  extracted.\n\nTool homepage: https://github.com/CenterForMedicalGeneticsGhent/PREFACE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preface:0.1.2--hdfd78af_0
stdout: preface.out
