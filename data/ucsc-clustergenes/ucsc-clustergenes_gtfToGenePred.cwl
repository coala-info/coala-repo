cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtfToGenePred
label: ucsc-clustergenes_gtfToGenePred
doc: "The provided text is a container runtime error log and does not contain help
  information for the tool. gtfToGenePred is typically used to convert GTF files to
  GenePred format.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-clustergenes:377--h199ee4e_0
stdout: ucsc-clustergenes_gtfToGenePred.out
