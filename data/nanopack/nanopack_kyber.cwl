cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanopack_kyber
label: nanopack_kyber
doc: "The provided text does not contain help information or usage instructions. It
  is a system error message indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/wdecoster/nanopack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0
stdout: nanopack_kyber.out
