cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - popscle
  - dsc-pileup
label: popscle_dsc-pileup
doc: "The provided text contains container execution logs and a fatal error rather
  than the tool's help documentation. No arguments could be extracted.\n\nTool homepage:
  https://github.com/statgen/popscle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
stdout: popscle_dsc-pileup.out
