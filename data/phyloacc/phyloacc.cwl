cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloacc
label: phyloacc
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a container runtime error log.\n\nTool homepage: https://github.com/phyloacc/PhyloAcc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloacc:2.4.5--py311hab6f30d_0
stdout: phyloacc.out
