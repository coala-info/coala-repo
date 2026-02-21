cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSort
label: ucsc-pslreps_pslSort
doc: "A tool to sort PSL files, typically used in the UCSC Genome Browser pipeline.
  Note: The provided help text contains container runtime errors and does not list
  specific arguments.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslreps:482--h0b57e2e_0
stdout: ucsc-pslreps_pslSort.out
