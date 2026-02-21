cwlVersion: v1.2
class: CommandLineTool
baseCommand: grz-cli
label: grz-db_grz-cli
doc: "A command-line interface for grz-db. (Note: The provided text contains system
  error messages regarding container execution and does not include usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-db:1.2.0--pyhdfd78af_0
stdout: grz-db_grz-cli.out
