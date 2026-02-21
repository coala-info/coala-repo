cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepmod
label: deepmod
doc: "A deep learning based tool for detecting DNA modifications from Nanopore sequencing
  data.\n\nTool homepage: https://github.com/WGLab/DeepMod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmod:0.1.3--pyh864c0ab_1
stdout: deepmod.out
