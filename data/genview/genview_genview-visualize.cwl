cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genview
  - visualize
label: genview_genview-visualize
doc: "Visualize genomic data (Note: The provided text contains container runtime error
  logs rather than tool help text).\n\nTool homepage: https://github.com/EbmeyerSt/GEnView.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genview:0.2--pyhdfd78af_0
stdout: genview_genview-visualize.out
