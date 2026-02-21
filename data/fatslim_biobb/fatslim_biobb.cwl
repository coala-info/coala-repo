cwlVersion: v1.2
class: CommandLineTool
baseCommand: fatslim_biobb
label: fatslim_biobb
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build or pull the container
  image due to lack of disk space.\n\nTool homepage: https://fatslim.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fatslim_biobb:0.2.2--py39hbcbf7aa_1
stdout: fatslim_biobb.out
