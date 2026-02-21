cwlVersion: v1.2
class: CommandLineTool
baseCommand: fetchChromSizes
label: ucsc-bedclip_fetchChromSizes
doc: "Fetch chromosome sizes for a specified UCSC genome database (e.g., hg38, mm10).
  The output is sent to stdout.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: db
    type: string
    doc: UCSC database name (e.g., hg38, hg19, mm10)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedclip:482--h0b57e2e_0
stdout: ucsc-bedclip_fetchChromSizes.out
