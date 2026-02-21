cwlVersion: v1.2
class: CommandLineTool
baseCommand: fetchChromSizes
label: ucsc-fetchchromsizes
doc: "Fetch chromosome sizes for a genome from UCSC. (Note: The provided help text
  contains only container runtime error messages and no usage information.)\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fetchchromsizes:482--h0b57e2e_0
stdout: ucsc-fetchchromsizes.out
