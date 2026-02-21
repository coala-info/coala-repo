cwlVersion: v1.2
class: CommandLineTool
baseCommand: vqsr_cnn
label: vqsr_cnn
doc: "Variant Quality Score Recalibration using Convolutional Neural Networks (Note:
  The provided text contains container runtime error logs rather than tool help documentation).\n
  \nTool homepage: https://broadinstitute.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vqsr_cnn:0.0.194--py_0
stdout: vqsr_cnn.out
