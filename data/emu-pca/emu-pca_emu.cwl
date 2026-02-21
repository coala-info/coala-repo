cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - emu-pca
  - emu
label: emu-pca_emu
doc: "Emu-PCA (Note: The provided help text contains only container runtime error
  messages and does not list tool arguments).\n\nTool homepage: https://github.com/Rosemeis/emu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emu-pca:1.5.0--py310h20b60a1_0
stdout: emu-pca_emu.out
