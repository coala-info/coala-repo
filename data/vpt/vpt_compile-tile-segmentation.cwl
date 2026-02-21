cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - compile-tile-segmentation
label: vpt_compile-tile-segmentation
doc: "Vizgen Post-processing Tool (vpt) - compile-tile-segmentation subcommand\n\n
  Tool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
stdout: vpt_compile-tile-segmentation.out
