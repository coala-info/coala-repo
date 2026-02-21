cwlVersion: v1.2
class: CommandLineTool
baseCommand: vpt-plugin-cellpose2
label: vpt-plugin-cellpose2
doc: "A plugin for the Vizgen Post-processing Tool (VPT) that utilizes Cellpose 2.0
  for cell segmentation.\n\nTool homepage: https://github.com/Vizgen/vpt-plugin-cellpose2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt-plugin-cellpose2:1.0.1--pyhdfd78af_0
stdout: vpt-plugin-cellpose2.out
