cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToGtf
label: ucsc-genepredtogtf
doc: "Convert genePred table or file to gtf.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: Database name, or 'file' if the genePred input is a file rather than a table in the database
    default: file
    inputBinding:
      position: 1
  - id: input_genepred
    type: File
    doc: Input genePred file (refFlat or extended genePred keeps the gene_name attribute). Drop a leading bin column with cut first.
    inputBinding:
      position: 2
  - id: output_name
    type: string
    doc: Name of the output GTF file
    inputBinding:
      position: 3
  - id: utr
    type:
      - 'null'
      - boolean
    doc: Add 5UTR and 3UTR features
    inputBinding:
      position: 101
      prefix: -utr
  - id: honor_cds_stat
    type:
      - 'null'
      - boolean
    doc: Use cdsStartStat/cdsEndStat when defining start/end codon records
    inputBinding:
      position: 101
      prefix: -honorCdsStat
  - id: source
    type:
      - 'null'
      - string
    doc: Set source name to use
    inputBinding:
      position: 101
      prefix: -source=
      separate: false
  - id: add_comments
    type:
      - 'null'
      - boolean
    doc: Add comments before each set of transcript records, for easier visual inspection
    inputBinding:
      position: 101
      prefix: -addComments
outputs:
  - id: output_gtf
    type: File
    doc: Output GTF file.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtogtf:482--h0b57e2e_0
