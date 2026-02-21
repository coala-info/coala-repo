cwlVersion: v1.2
class: CommandLineTool
baseCommand: sincei_scFilterBarcodes
label: sincei_scFilterBarcodes
doc: "Filter barcodes from single-cell data. (Note: The provided text contains container
  build logs and error messages rather than the tool's help documentation.)\n\nTool
  homepage: https://github.com/bhardwaj-lab/sincei"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sincei:0.5.2--pyhdfd78af_0
stdout: sincei_scFilterBarcodes.out
