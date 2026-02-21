cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta3
label: fasta3
doc: "The provided text contains system error messages and does not include help documentation
  for the fasta3 tool. As a result, no arguments or tool descriptions could be extracted.\n
  \nTool homepage: http://faculty.virginia.edu/wrpearson/fasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta3:36.3.8--h779adbc_6
stdout: fasta3.out
