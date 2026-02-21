cwlVersion: v1.2
class: CommandLineTool
baseCommand: NanoFilt
label: nanopack_NanoFilt
doc: "The provided text does not contain help information for NanoFilt; it contains
  container runtime error messages regarding disk space.\n\nTool homepage: https://github.com/wdecoster/nanopack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0
stdout: nanopack_NanoFilt.out
