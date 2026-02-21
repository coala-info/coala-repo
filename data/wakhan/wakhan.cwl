cwlVersion: v1.2
class: CommandLineTool
baseCommand: wakhan
label: wakhan
doc: "The provided text is an error log from a container build process and does not
  contain the tool's help documentation or usage instructions.\n\nTool homepage: https://github.com/KolmogorovLab/Wakhan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wakhan:0.2.0--pyhdfd78af_1
stdout: wakhan.out
