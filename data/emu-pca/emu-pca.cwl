cwlVersion: v1.2
class: CommandLineTool
baseCommand: emu-pca
label: emu-pca
doc: "A tool for performing Principal Component Analysis (PCA) on Emu taxonomic profiling
  results.\n\nTool homepage: https://github.com/Rosemeis/emu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emu-pca:1.5.0--py310h20b60a1_0
stdout: emu-pca.out
