cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb-ml
label: tb-ml
doc: "A tool for machine learning analysis of Tuberculosis genomic data (Note: The
  provided text contains container build logs rather than CLI help documentation,
  so no arguments could be extracted).\n\nTool homepage: https://github.com/jodyphelan/tb-ml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-ml:0.1.1--pyh7cba7a3_0
stdout: tb-ml.out
