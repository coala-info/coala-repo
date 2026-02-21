cwlVersion: v1.2
class: CommandLineTool
baseCommand: glistquery
label: genometester4_glistquery
doc: "A tool from the GenomeTester4 suite for querying k-mer lists. (Note: The provided
  help text contains only system error messages and no usage information; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometester4:4.0--h7b50bb2_7
stdout: genometester4_glistquery.out
