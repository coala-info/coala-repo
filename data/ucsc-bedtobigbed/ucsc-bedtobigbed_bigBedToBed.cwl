cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigBedToBed
label: ucsc-bedtobigbed_bigBedToBed
doc: "The provided help text contains a fatal system error (no space left on device)
  and does not contain the actual usage information for the tool. Based on the tool
  name hint, this tool is used to convert bigBed files back to BED format.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtobigbed:482--hdc0a859_0
stdout: ucsc-bedtobigbed_bigBedToBed.out
