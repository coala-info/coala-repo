cwlVersion: v1.2
class: CommandLineTool
baseCommand: burrito-fillings
label: burrito-fillings
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to pull or build a container image due
  to insufficient disk space.\n\nTool homepage: https://github.com/biocore/burrito-fillings"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/burrito-fillings:0.1.1--py36_0
stdout: burrito-fillings.out
