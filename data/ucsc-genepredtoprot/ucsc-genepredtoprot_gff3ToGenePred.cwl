cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3ToGenePred
label: ucsc-genepredtoprot_gff3ToGenePred
doc: "Convert GFF3 to genePred format. (Note: The provided text contained container
  execution errors rather than help text; no arguments could be extracted from the
  input.)\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtoprot:482--h0b57e2e_0
stdout: ucsc-genepredtoprot_gff3ToGenePred.out
