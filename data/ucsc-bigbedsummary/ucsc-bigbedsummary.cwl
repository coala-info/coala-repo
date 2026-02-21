cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigBedSummary
label: ucsc-bigbedsummary
doc: "The provided help text contains a fatal system error (no space left on device)
  and does not include the actual usage information for the tool. Based on the tool
  name hint, this is a UCSC Genome Browser utility used to extract summary statistics
  from bigBed files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigbedsummary:482--h0b57e2e_0
stdout: ucsc-bigbedsummary.out
