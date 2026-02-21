cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemma
label: gemma
doc: "Genome-wide Efficient Mixed Model Association (GEMMA). Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific tool arguments.\n\nTool homepage: https://github.com/genetics-statistics/GEMMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemma:0.98.5--ha36d3ea_0
stdout: gemma.out
