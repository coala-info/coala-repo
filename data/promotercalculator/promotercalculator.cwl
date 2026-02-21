cwlVersion: v1.2
class: CommandLineTool
baseCommand: promotercalculator
label: promotercalculator
doc: "The provided text does not contain help information for promotercalculator;
  it is a log of a failed container image retrieval. No arguments or descriptions
  could be extracted from the input.\n\nTool homepage: https://github.com/barricklab/promoter-calculator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/promotercalculator:1.2.4--pyh7e72e81_0
stdout: promotercalculator.out
