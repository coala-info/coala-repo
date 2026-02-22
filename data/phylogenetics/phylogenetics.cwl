cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylogenetics
label: phylogenetics
doc: "A tool for phylogenetic analysis (Note: The provided text contains system error
  messages regarding disk space and container image conversion rather than command-line
  help documentation. No arguments could be extracted from the input.)\n\nTool homepage:
  https://github.com/Zsailer/phylogenetics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylogenetics:0.5.0--py_0
stdout: phylogenetics.out
