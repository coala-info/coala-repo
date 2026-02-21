cwlVersion: v1.2
class: CommandLineTool
baseCommand: referee_referee.py
label: referee_referee.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or image fetch process.\n\nTool homepage:
  https://github.com/gwct/referee"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/referee:1.2--hdfd78af_0
stdout: referee_referee.py.out
