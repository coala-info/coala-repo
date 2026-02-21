cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkHgFindSpec
label: ucsc-hgfindspec_checkHgFindSpec
doc: "A tool to check hgFindSpec files for errors. Note: The provided help text contains
  only container execution errors and does not list specific arguments.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgfindspec:482--h0b57e2e_0
stdout: ucsc-hgfindspec_checkHgFindSpec.out
