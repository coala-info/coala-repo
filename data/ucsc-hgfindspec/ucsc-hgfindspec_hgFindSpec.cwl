cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgFindSpec
label: ucsc-hgfindspec_hgFindSpec
doc: "A UCSC Genome Browser utility. (Note: The provided help text contains container
  execution errors and does not list specific command-line arguments.)\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgfindspec:482--h0b57e2e_0
stdout: ucsc-hgfindspec_hgFindSpec.out
