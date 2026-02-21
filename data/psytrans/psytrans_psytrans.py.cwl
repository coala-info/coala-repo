cwlVersion: v1.2
class: CommandLineTool
baseCommand: psytrans_psytrans.py
label: psytrans_psytrans.py
doc: "The provided text does not contain a description of the tool; it contains system
  logs and error messages related to a container build failure.\n\nTool homepage:
  https://github.com/rivera10/psytrans"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psytrans:2.0.0--hdfd78af_1
stdout: psytrans_psytrans.py.out
