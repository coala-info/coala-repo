cwlVersion: v1.2
class: CommandLineTool
baseCommand: clark_set_targets.sh
label: clark_set_targets.sh
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to build/extract a container image due
  to insufficient disk space.\n\nTool homepage: https://github.com/rouni001/CLARK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clark:1.3.0.0--h9948957_0
stdout: clark_set_targets.sh.out
