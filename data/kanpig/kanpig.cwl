cwlVersion: v1.2
class: CommandLineTool
baseCommand: kanpig
label: kanpig
doc: "A tool for k-mer based assembly of pangenomes (Note: The provided text contains
  error logs rather than help documentation, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/ACEnglish/kanpig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kanpig:2.0.2--ha6fb395_0
stdout: kanpig.out
