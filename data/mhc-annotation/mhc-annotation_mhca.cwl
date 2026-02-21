cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhca
label: mhc-annotation_mhca
doc: "MHC annotation tool (Note: The provided help text contains only container runtime
  error messages and no usage information).\n\nTool homepage: https://github.com/DiltheyLab/MHC-annotation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
stdout: mhc-annotation_mhca.out
