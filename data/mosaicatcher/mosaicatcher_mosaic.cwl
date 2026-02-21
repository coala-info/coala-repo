cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mosaicatcher
  - mosaic
label: mosaicatcher_mosaic
doc: "The provided text does not contain help information or a description of the
  tool, as it is an error log related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/friendsofstrandseq/mosaicatcher/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosaicatcher:0.3.1--h5642b88_3
stdout: mosaicatcher_mosaic.out
