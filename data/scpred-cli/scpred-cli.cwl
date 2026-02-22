cwlVersion: v1.2
class: CommandLineTool
baseCommand: scpred-cli
label: scpred-cli
doc: "The provided text contains error messages related to a failed container execution
  (no space left on device) and does not contain the actual help documentation or
  usage instructions for the tool.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scPred-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scpred-cli:0.1.0--hdfd78af_2
stdout: scpred-cli.out
