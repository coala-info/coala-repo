cwlVersion: v1.2
class: CommandLineTool
baseCommand: clark_estimate_abundance.sh
label: clark_estimate_abundance.sh
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/rouni001/CLARK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clark:1.3.0.0--h9948957_0
stdout: clark_estimate_abundance.sh.out
