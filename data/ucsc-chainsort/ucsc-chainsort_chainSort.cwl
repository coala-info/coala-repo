cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainSort
label: ucsc-chainsort_chainSort
doc: "Sort a chain file. (Note: The provided help text contains only container execution
  errors and no usage information was available to parse.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainsort:482--h0b57e2e_0
stdout: ucsc-chainsort_chainSort.out
