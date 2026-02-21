cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredCheck
label: ucsc-genepredtobed_genePredCheck
doc: "Check genePred files for validity. (Note: The provided help text contains container
  runtime error messages and does not include usage information for the tool.)\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtobed:482--h0b57e2e_0
stdout: ucsc-genepredtobed_genePredCheck.out
