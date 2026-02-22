cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-cli
label: scran-cli
doc: "The provided text contains system error messages (no space left on device) and
  does not include help documentation or argument definitions for the tool.\n\nTool
  homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
stdout: scran-cli.out
