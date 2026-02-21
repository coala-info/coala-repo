cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebfilter
label: ebfilter
doc: "Empirical Bayesian mutation filtering tool. (Note: The provided text is a container
  runtime error log and does not contain the tool's help documentation or argument
  definitions.)\n\nTool homepage: https://github.com/Genomon-Project/EBFilter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebfilter:0.2.2--pyh5ca1d4c_0
stdout: ebfilter.out
