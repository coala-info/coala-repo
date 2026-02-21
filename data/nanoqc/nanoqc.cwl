cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoqc
label: nanoqc
doc: "The provided text does not contain help information or usage instructions for
  nanoqc. It contains container runtime error messages indicating a failure to build
  the image due to lack of disk space.\n\nTool homepage: https://github.com/wdecoster/nanoQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoqc:0.10.0--pyhdfd78af_0
stdout: nanoqc.out
