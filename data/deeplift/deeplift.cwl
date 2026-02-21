cwlVersion: v1.2
class: CommandLineTool
baseCommand: deeplift
label: deeplift
doc: "DeepLIFT (Deep Learning Important FeatUreS) is a method for decomposing the
  output prediction of a neural network. (Note: The provided text is a system error
  log regarding container creation and does not contain CLI usage information).\n\n
  Tool homepage: https://github.com/kundajelab/deeplift"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeplift:0.6.13.0--pyh3252c3a_0
stdout: deeplift.out
