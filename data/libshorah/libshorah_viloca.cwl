cwlVersion: v1.2
class: CommandLineTool
baseCommand: viloca
label: libshorah_viloca
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/LaraFuhrmann/VILOCA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libshorah:1.99.4--py38hebc1f04_1
stdout: libshorah_viloca.out
