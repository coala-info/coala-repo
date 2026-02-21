cwlVersion: v1.2
class: CommandLineTool
baseCommand: dca
label: dca
doc: "Deep count autoencoder for denoising scRNA-seq data (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/theislab/dca"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dca:0.3.4--pyhdfd78af_0
stdout: dca.out
