cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToGtf
label: ucsc-genepredtogtf
doc: "Convert genePred files to GTF format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The database name or 'file' if parsing a file.
    inputBinding:
      position: 1
  - id: input_genepred
    type: File
    doc: Input genePred file.
    inputBinding:
      position: 2
  - id: honor_stop
    type:
      - 'null'
      - boolean
    doc: Include stop codon in CDS.
    inputBinding:
      position: 103
      prefix: -honorStop
  - id: source
    type:
      - 'null'
      - string
    doc: Use specified text for the source column.
    inputBinding:
      position: 103
      prefix: -source
  - id: utr
    type:
      - 'null'
      - boolean
    doc: Create UTR/CDS/exon/start_codon/stop_codon lines.
    inputBinding:
      position: 103
      prefix: -utr
outputs:
  - id: output_gtf
    type: File
    doc: Output GTF file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtogtf:482--h0b57e2e_0
