cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteinprophet
label: proteinprophet
doc: "ProteinProphet is a tool for protein inference, typically part of the Trans-Proteomic
  Pipeline (TPP). Note: The provided help text contains only container environment
  logs and a fatal error, so no specific arguments could be extracted.\n\nTool homepage:
  https://github.com/lazychach/ProteinProphet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/proteinprophet:v201510131012_cv4
stdout: proteinprophet.out
