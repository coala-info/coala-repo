cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtotree
label: gtotree
doc: "Phylogenomics workflow for generating trees from HMM sets (Note: The provided
  text is a container runtime error log and does not contain help information).\n\n
  Tool homepage: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
stdout: gtotree.out
