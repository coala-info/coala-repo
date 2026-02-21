cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimpse-bio
label: glimpse-bio
doc: "GLIMPSE is a suite of tools for phasing and imputation of low-coverage sequencing
  data (Note: The provided input text contains container execution errors rather than
  tool help documentation).\n\nTool homepage: https://odelaneau.github.io/GLIMPSE/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
stdout: glimpse-bio.out
