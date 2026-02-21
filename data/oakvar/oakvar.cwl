cwlVersion: v1.2
class: CommandLineTool
baseCommand: oakvar
label: oakvar
doc: "OakVar is a genomic variant analysis platform. (Note: The provided text contains
  system error logs rather than help documentation, so no arguments could be extracted.)\n
  \nTool homepage: http://www.oakvar.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.24--pyhdfd78af_0
stdout: oakvar.out
