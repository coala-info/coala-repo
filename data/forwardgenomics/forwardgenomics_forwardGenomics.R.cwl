cwlVersion: v1.2
class: CommandLineTool
baseCommand: forwardGenomics.R
label: forwardgenomics_forwardGenomics.R
doc: "A tool for Forward Genomics analysis (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/hillerlab/ForwardGenomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/forwardgenomics:1.0--hdfd78af_0
stdout: forwardgenomics_forwardGenomics.R.out
