cwlVersion: v1.2
class: CommandLineTool
baseCommand: unitas
label: unitas
doc: "Universal tool for annotation of small RNAs. (Note: The provided input text
  contained container runtime error logs rather than the tool's help documentation.)\n
  \nTool homepage: http://www.smallrnagroup.uni-mainz.de/software.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitas:1.6.1--hdfd78af_3
stdout: unitas.out
