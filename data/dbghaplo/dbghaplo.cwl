cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbghaplo
label: dbghaplo
doc: "A tool for de novo haplotype assembly using de Bruijn graphs (Note: The provided
  help text contains only system error messages and no usage information).\n\nTool
  homepage: https://github.com/bluenote-1577/dbghaplo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbghaplo:0.0.2--ha6fb395_1
stdout: dbghaplo.out
