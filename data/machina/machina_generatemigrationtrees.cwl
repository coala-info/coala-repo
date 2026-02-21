cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - machina
  - generatemigrationtrees
label: machina_generatemigrationtrees
doc: "A tool within the MACHINA suite for generating migration trees. (Note: The provided
  help text contained only system error messages and no usage information; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/raphael-group/machina"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_generatemigrationtrees.out
