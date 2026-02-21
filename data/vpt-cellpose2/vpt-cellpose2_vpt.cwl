cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - cellpose2
label: vpt-cellpose2_vpt
doc: "Vizgen Post-processing Tool (VPT) for Cellpose2 segmentation. Note: The provided
  text contains system error logs rather than help documentation, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/Vizgen/vpt-plugin-cellpose2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt-cellpose2:1.0.0--hdfd78af_0
stdout: vpt-cellpose2_vpt.out
