cwlVersion: v1.2
class: CommandLineTool
baseCommand: viralmsa
label: viralmsa
doc: "ViralMSA is a tool for reference-guided multiple sequence alignment of viral
  genomes. (Note: The provided text contains container runtime error logs rather than
  the tool's help documentation; therefore, no arguments could be extracted.)\n\n
  Tool homepage: https://github.com/niemasd/ViralMSA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralmsa:1.1.46--hdfd78af_0
stdout: viralmsa.out
