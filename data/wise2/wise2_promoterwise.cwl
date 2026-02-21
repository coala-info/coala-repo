cwlVersion: v1.2
class: CommandLineTool
baseCommand: promoterwise
label: wise2_promoterwise
doc: "A tool from the Wise2 package for comparing two DNA sequences. (Note: The provided
  help text contains container execution errors and does not list command-line arguments.)\n
  \nTool homepage: https://www.ebi.ac.uk/~birney/wise2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wise2:2.4.1--h17e8430_6
stdout: wise2_promoterwise.out
