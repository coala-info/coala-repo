cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToMafFrames
label: ucsc-genepredtomafframes
doc: "Convert genePred alignments to MAF frames.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
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
  - id: maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: Output MAF frames file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtomafframes:482--h0b57e2e_0
