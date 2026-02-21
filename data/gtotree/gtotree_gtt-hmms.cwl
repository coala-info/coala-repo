cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-hmms
label: gtotree_gtt-hmms
doc: "A tool within the GToTree suite for managing or utilizing HMM (Hidden Markov
  Model) profiles. Note: The provided help text contains only system error messages
  regarding container execution and does not list specific arguments.\n\nTool homepage:
  https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
stdout: gtotree_gtt-hmms.out
