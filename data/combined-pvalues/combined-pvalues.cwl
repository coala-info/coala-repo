cwlVersion: v1.2
class: CommandLineTool
baseCommand: combined-pvalues
label: combined-pvalues
doc: "A tool for combining p-values (Note: The provided help text contains only system
  error messages regarding disk space and container image retrieval, so specific argument
  details could not be extracted).\n\nTool homepage: https://github.com/brentp/combined-pvalues"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
stdout: combined-pvalues.out
