cwlVersion: v1.2
class: CommandLineTool
baseCommand: grz-check
label: grz-check
doc: "A tool for checking GRZ files (Note: The provided text is an error log and does
  not contain usage information or argument descriptions).\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools/packages/grz-check"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-check:0.2.1--h3ec5717_0
stdout: grz-check.out
