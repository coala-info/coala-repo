cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSort
label: ucsc-pslsort
doc: "A tool for sorting PSL (Pattern Space Layout) files, typically used in the UCSC
  Genome Browser toolset.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslsort:482--h0b57e2e_0
stdout: ucsc-pslsort.out
