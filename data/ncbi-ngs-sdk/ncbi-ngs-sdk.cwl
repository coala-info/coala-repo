cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-ngs-sdk
label: ncbi-ngs-sdk
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system log messages and a fatal error regarding container
  image creation (no space left on device).\n\nTool homepage: https://github.com/ncbi/ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-ngs-sdk:3.0.1--pl5321h0ff018f_5
stdout: ncbi-ngs-sdk.out
