cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToBigGenePred
label: ucsc-genepredtobiggenepred
doc: "Converts genePred or genePredExt to bigGenePred input (bed format with extra fields). The result can be sorted and converted to a bigBed with bedToBigBed.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: gene_pred
    type: File
    doc: Input genePred or genePredExt file.
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the output bigGenePred input file (the tool also accepts stdout)
    inputBinding:
      position: 2
  - id: known
    type:
      - 'null'
      - boolean
    doc: Input file is a genePred in knownGene format
    inputBinding:
      position: 101
      prefix: -known
  - id: score
    type:
      - 'null'
      - File
    doc: Two column file with id's mapping to scores
    inputBinding:
      position: 101
      prefix: -score=
      separate: false
  - id: gene_names
    type:
      - 'null'
      - File
    doc: Three column file with id's mapping to two gene names
    inputBinding:
      position: 101
      prefix: -geneNames=
      separate: false
  - id: colors
    type:
      - 'null'
      - File
    doc: Four column file with id's mapping to r,g,b
    inputBinding:
      position: 101
      prefix: -colors=
      separate: false
  - id: cds
    type:
      - 'null'
      - File
    doc: Five column file with id's mapping to cds status codes and exonFrames (see knownCds.as)
    inputBinding:
      position: 101
      prefix: -cds=
      separate: false
  - id: gene_type
    type:
      - 'null'
      - File
    doc: Two column file with id's mapping to geneType
    inputBinding:
      position: 101
      prefix: -geneType=
      separate: false
outputs:
  - id: big_gene_pred
    type: File
    doc: Output bigGenePred input file (text, to be passed to bedToBigBed).
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtobiggenepred:482--h0b57e2e_0
