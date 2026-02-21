cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredFilter
label: ucsc-genepredfilter
doc: "Filter genePred files based on various criteria.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredfilter:482--h0b57e2e_0
stdout: ucsc-genepredfilter.out
