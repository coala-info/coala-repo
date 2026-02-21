cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToProt
label: ucsc-genepredtoprot
doc: "A UCSC Genome Browser utility to convert genePred files to protein sequences.\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtoprot:482--h0b57e2e_0
stdout: ucsc-genepredtoprot.out
