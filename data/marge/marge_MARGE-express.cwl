cwlVersion: v1.2
class: CommandLineTool
baseCommand: marge-express
label: marge_MARGE-express
doc: "MARGE (Model-based Analysis of Regulation of Gene Expression) - MARGE-express
  subcommand. Note: The provided help text contains only system error messages and
  no usage information.\n\nTool homepage: http://cistrome.org/MARGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marge:1.0--py35h24bf2e0_1
stdout: marge_MARGE-express.out
