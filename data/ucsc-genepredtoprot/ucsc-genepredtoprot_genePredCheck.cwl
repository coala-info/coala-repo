cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genePredCheck
label: ucsc-genepredtoprot_genePredCheck
doc: "The provided text does not contain help information for the tool, but rather
  a container execution error log. genePredCheck is a UCSC utility used to validate
  genePred files.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtoprot:482--h0b57e2e_0
stdout: ucsc-genepredtoprot_genePredCheck.out
