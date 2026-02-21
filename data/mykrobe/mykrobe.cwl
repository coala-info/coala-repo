cwlVersion: v1.2
class: CommandLineTool
baseCommand: mykrobe
label: mykrobe
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to pull or build a container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/iqbal-lab/Mykrobe-predictor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykrobe:0.13.0--py311h22b1866_5
stdout: mykrobe.out
