cwlVersion: v1.2
class: CommandLineTool
baseCommand: prinseq++
label: prinseq-plus-plus_prinseq++
doc: "PRINSEQ++ is a tool for filtering and trimming genomic sequences. (Note: The
  provided input text contains container build logs and a fatal error rather than
  the tool's help documentation.)\n\nTool homepage: https://github.com/Adrian-Cantu/PRINSEQ-plus-plus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prinseq-plus-plus:1.2.4--h077b44d_8
stdout: prinseq-plus-plus_prinseq++.out
