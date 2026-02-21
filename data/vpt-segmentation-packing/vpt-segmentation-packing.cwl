cwlVersion: v1.2
class: CommandLineTool
baseCommand: vpt-segmentation-packing
label: vpt-segmentation-packing
doc: "The provided text contains container build logs and error messages rather than
  the tool's help documentation. As a result, no arguments or functional descriptions
  could be extracted.\n\nTool homepage: https://github.com/Vizgen/vpt-segmentation-packing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt-segmentation-packing:1.0.1--pyhdfd78af_0
stdout: vpt-segmentation-packing.out
