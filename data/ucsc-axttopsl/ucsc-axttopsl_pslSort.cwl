cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSort
label: ucsc-axttopsl_pslSort
doc: "The provided text is an error log indicating a system failure (no space left
  on device) during the extraction of a container image and does not contain help
  information for the tool.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axttopsl:482--h0b57e2e_0
stdout: ucsc-axttopsl_pslSort.out
