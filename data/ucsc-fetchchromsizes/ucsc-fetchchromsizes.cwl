cwlVersion: v1.2
class: CommandLineTool
baseCommand: fetchChromSizes
label: ucsc-fetchchromsizes
doc: "Fetch chromosome sizes for a specified genome database from UCSC.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: db
    type: string
    doc: UCSC genome database name (e.g., hg38, mm10)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fetchchromsizes:482--h0b57e2e_0
stdout: ucsc-fetchchromsizes.out
