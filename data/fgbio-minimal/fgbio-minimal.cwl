cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio-minimal
doc: "A tool for analysis of genomic data (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio-minimal:3.1.1--hdfd78af_0
stdout: fgbio-minimal.out
