cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToFakePsl
label: ucsc-genepredtofakepsl
doc: "Create a fake PSL from a genePred file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: db
    type: string
    doc: Database name (e.g., hg19)
    inputBinding:
      position: 1
  - id: gene_pred
    type: File
    doc: Input genePred file
    inputBinding:
      position: 2
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
  - id: out_cds
    type: File
    doc: Output CDS file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtofakepsl:482--h0b57e2e_1
