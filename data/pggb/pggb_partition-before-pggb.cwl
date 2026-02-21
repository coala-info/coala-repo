cwlVersion: v1.2
class: CommandLineTool
baseCommand: pggb_partition-before-pggb
label: pggb_partition-before-pggb
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failed container build due to insufficient disk
  space ('no space left on device').\n\nTool homepage: https://github.com/pangenome/pggb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pggb:0.7.4--h9ee0642_0
stdout: pggb_partition-before-pggb.out
