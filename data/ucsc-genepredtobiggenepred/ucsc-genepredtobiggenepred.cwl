cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToBigGenePred
label: ucsc-genepredtobiggenepred
doc: "Converts a genePred file to a bigGenePred file, which can then be converted
  to a bigBed file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: gene_pred
    type: File
    doc: Input genePred file.
    inputBinding:
      position: 1
outputs:
  - id: big_gene_pred
    type: File
    doc: Output bigGenePred file (usually a text file to be passed to 
      bedToBigBed).
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtobiggenepred:482--h0b57e2e_0
