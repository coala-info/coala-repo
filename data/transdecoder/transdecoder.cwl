cwlVersion: v1.2
class: CommandLineTool
baseCommand: transdecoder
label: transdecoder
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://transdecoder.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transdecoder:5.7.1--pl5321hdfd78af_2
stdout: transdecoder.out
