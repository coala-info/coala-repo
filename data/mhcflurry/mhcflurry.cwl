cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhcflurry
label: mhcflurry
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a failure to build a container image due
  to insufficient disk space.\n\nTool homepage: https://github.com/hammerlab/mhcflurry"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhcflurry:2.1.5--pyh7e72e81_0
stdout: mhcflurry.out
