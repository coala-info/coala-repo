cwlVersion: v1.2
class: CommandLineTool
baseCommand: rseqc
label: rseqc
doc: "The provided text is a container runtime error log and does not contain help
  information or arguments for the rseqc tool.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
stdout: rseqc.out
