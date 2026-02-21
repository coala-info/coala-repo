cwlVersion: v1.2
class: CommandLineTool
baseCommand: prinseq++
label: prinseq_prinseq++
doc: "The provided text contains container runtime error logs and does not include
  help documentation or usage information for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/Adrian-Cantu/PRINSEQ-plus-plus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prinseq:0.20.4--4
stdout: prinseq_prinseq++.out
