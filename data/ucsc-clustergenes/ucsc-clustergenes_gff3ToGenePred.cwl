cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3ToGenePred
label: ucsc-clustergenes_gff3ToGenePred
doc: "A tool to convert GFF3 files to genePred format. Note: The provided help text
  contains only system error messages and no usage information.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-clustergenes:377--h199ee4e_0
stdout: ucsc-clustergenes_gff3ToGenePred.out
