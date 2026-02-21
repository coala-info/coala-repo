cwlVersion: v1.2
class: CommandLineTool
baseCommand: fetchChromSizes
label: ucsc-bedtobigbed_fetchChromSizes
doc: "Fetch chromosome sizes for a specific genome assembly from the UCSC Genome Browser.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: db
    type: string
    doc: UCSC database name (e.g., hg38, mm10)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtobigbed:482--hdc0a859_0
stdout: ucsc-bedtobigbed_fetchChromSizes.out
