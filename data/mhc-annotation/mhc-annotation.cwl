cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhc-annotation
label: mhc-annotation
doc: "A tool for MHC (Major Histocompatibility Complex) annotation.\n\nTool homepage:
  https://github.com/DiltheyLab/MHC-annotation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
stdout: mhc-annotation.out
