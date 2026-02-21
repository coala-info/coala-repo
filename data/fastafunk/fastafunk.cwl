cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk
label: fastafunk
doc: "A tool for FASTA file manipulation (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
stdout: fastafunk.out
