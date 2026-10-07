cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - plot_tensor
label: clair_plot_tensor
doc: "Visualize tensors and hidden layers in PNG\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: array_fn
    type: File
    doc: "Array input (comma-separated values of one 33x8x4 tensor)"
    inputBinding:
      position: 101
      prefix: --array_fn
  - id: name
    type: string
    doc: "output name (folder that gets tensor.png)"
    inputBinding:
      position: 101
      prefix: --name
outputs:
  - id: plot_dir
    type: Directory
    doc: "Folder with tensor.png"
    outputBinding:
      glob: "$(inputs.name)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
