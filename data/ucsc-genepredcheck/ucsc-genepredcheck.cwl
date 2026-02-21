cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredCheck
label: ucsc-genepredcheck
doc: "Check genePred files for validity. (Note: The provided help text contains only
  container build errors and does not list specific arguments.)\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredcheck:482--h0b57e2e_0
stdout: ucsc-genepredcheck.out
