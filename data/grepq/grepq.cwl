cwlVersion: v1.2
class: CommandLineTool
baseCommand: grepq
label: grepq
doc: "A tool for filtering sequences (based on the provided container name), however,
  the provided text contains only system error logs and no help documentation.\n\n
  Tool homepage: https://github.com/Rbfinch/grepq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grepq:1.5.4--h6ce8773_0
stdout: grepq.out
