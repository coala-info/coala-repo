cwlVersion: v1.2
class: CommandLineTool
baseCommand: scmap-cli
label: scmap-cli
doc: "The provided text contains system error messages related to a Singularity container
  execution failure and does not contain help documentation or usage information for
  scmap-cli.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scmap-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
stdout: scmap-cli.out
