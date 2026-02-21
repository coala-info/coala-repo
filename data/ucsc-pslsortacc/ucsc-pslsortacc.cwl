cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSortAcc
label: ucsc-pslsortacc
doc: "Sort a PSL file by accession. (Note: The provided help text contains a container
  execution error and does not list command-line arguments.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslsortacc:482--h0b57e2e_0
stdout: ucsc-pslsortacc.out
