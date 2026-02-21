cwlVersion: v1.2
class: CommandLineTool
baseCommand: card_trick
label: card_trick
doc: "A tool for processing CARD (Comprehensive Antibiotic Resistance Database) data.
  Note: The provided help text was an error log from a container build process and
  did not contain usage information. Standard parameters for this tool typically involve
  inputting CARD data and outputting filtered or formatted results.\n\nTool homepage:
  https://gitlab.com/cgps/card_trick"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/card_trick:0.2.1--py_0
stdout: card_trick.out
