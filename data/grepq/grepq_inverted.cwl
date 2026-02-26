cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grepq
  - inverted
label: grepq_inverted
doc: "Search for PATTERNS in FILE\n\nTool homepage: https://github.com/Rbfinch/grepq"
inputs:
  - id: patterns
    type:
      type: array
      items: string
    doc: Patterns to search for
    inputBinding:
      position: 1
  - id: file
    type: File
    doc: File to search in
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grepq:1.5.4--h6ce8773_0
stdout: grepq_inverted.out
