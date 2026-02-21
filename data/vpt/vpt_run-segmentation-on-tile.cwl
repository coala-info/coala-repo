cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - run-segmentation-on-tile
label: vpt_run-segmentation-on-tile
doc: "Run segmentation on a tile using the vpt tool.\n\nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
stdout: vpt_run-segmentation-on-tile.out
