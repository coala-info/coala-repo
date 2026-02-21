cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_flexdyn
label: biobb_flexdyn
doc: "Biobb_flexdyn is a BioBB category for flexible docking and molecular dynamics
  related tools. (Note: The provided help text contains only system error logs and
  no usage information.)\n\nTool homepage: https://github.com/bioexcel/biobb_flexdyn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_flexdyn:5.2.0--pyhdfd78af_0
stdout: biobb_flexdyn.out
