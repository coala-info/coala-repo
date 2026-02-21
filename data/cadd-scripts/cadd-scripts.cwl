cwlVersion: v1.2
class: CommandLineTool
baseCommand: cadd-scripts
label: cadd-scripts
doc: "CADD (Combined Annotation Dependent Depletion) scripts for scoring human genetic
  variants.\n\nTool homepage: https://github.com/kircherlab/CADD-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cadd-scripts:1.7.3--hdfd78af_0
stdout: cadd-scripts.out
