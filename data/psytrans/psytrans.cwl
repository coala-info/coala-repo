cwlVersion: v1.2
class: CommandLineTool
baseCommand: psytrans
label: psytrans
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build or fetch operation.\n\n
  Tool homepage: https://github.com/rivera10/psytrans"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psytrans:2.0.0--hdfd78af_1
stdout: psytrans.out
