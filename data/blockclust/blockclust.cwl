cwlVersion: v1.2
class: CommandLineTool
baseCommand: blockclust
label: blockclust
doc: "A tool for clustering small RNA read blocks (Note: The provided text contains
  system error messages regarding container execution and disk space, rather than
  the tool's help documentation).\n\nTool homepage: https://github.com/pavanvidem/blockclust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blockclust:1.1.1--py311r44he264feb_2
stdout: blockclust.out
