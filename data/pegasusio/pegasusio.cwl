cwlVersion: v1.2
class: CommandLineTool
baseCommand: pegasusio
label: pegasusio
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a Singularity/Docker container
  execution failure (no space left on device).\n\nTool homepage: https://github.com/klarman-cell-observatory/pegasusio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pegasusio:0.10.0--py311haab0aaa_0
stdout: pegasusio.out
