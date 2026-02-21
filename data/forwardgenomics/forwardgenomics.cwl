cwlVersion: v1.2
class: CommandLineTool
baseCommand: forwardgenomics
label: forwardgenomics
doc: "Forward Genomics is a method to link phenotypic differences between species
  to differences in their genome sequences.\n\nTool homepage: https://github.com/hillerlab/ForwardGenomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/forwardgenomics:1.0--hdfd78af_0
stdout: forwardgenomics.out
