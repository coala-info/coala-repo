cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafFilter
label: ucsc-maffilter
doc: "A tool for filtering MAF (Multiple Alignment Format) files. Note: The provided
  help text contains only container runtime error messages and does not list specific
  command-line arguments.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maffilter:482--h0b57e2e_0
stdout: ucsc-maffilter.out
