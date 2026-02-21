cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamate
label: metamate
doc: "A tool for phylogenomic analysis (Note: The provided text contains container
  runtime error messages rather than the tool's help documentation).\n\nTool homepage:
  https://github.com/tjcreedy/metamate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamate:0.5.2--pyr44h7e72e81_0
stdout: metamate.out
