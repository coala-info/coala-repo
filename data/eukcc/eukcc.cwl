cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukcc
label: eukcc
doc: "Eukaryotic Genome Completeness and Contamination (Note: The provided text contains
  system error logs rather than help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/Finn-Lab/EukCC/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukcc:2.1.3--pyhdfd78af_0
stdout: eukcc.out
