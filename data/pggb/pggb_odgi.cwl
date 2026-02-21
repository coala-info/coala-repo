cwlVersion: v1.2
class: CommandLineTool
baseCommand: pggb_odgi
label: pggb_odgi
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to build or extract a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/pangenome/pggb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pggb:0.7.4--h9ee0642_0
stdout: pggb_odgi.out
