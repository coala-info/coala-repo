cwlVersion: v1.2
class: CommandLineTool
baseCommand: longqc
label: longqc
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log regarding a container runtime failure (no space left on
  device).\n\nTool homepage: https://github.com/yfukasawa/LongQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longqc:1.2.0c--hdfd78af_0
stdout: longqc.out
