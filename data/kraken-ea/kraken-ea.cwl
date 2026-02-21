cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken-ea
label: kraken-ea
doc: "Kraken-ea is a taxonomic sequence classification system. Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/ExpressionAnalysis/kraken/tree/v0.10.5-beta-ea.2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kraken-ea:0.10.5ea.3--pl5321h077b44d_5
stdout: kraken-ea.out
