cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgSpeciesRna
label: ucsc-hgspeciesrna_hgSpeciesRna
doc: "Create fasta file with RNA from one species\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 1
  - id: genus
    type: string
    doc: Genus of the species
    inputBinding:
      position: 2
  - id: species
    type: string
    doc: Species name
    inputBinding:
      position: 3
  - id: filter_file
    type:
      - 'null'
      - File
    doc: only read accessions listed in file
    inputBinding:
      position: 104
      prefix: -filter
  - id: get_ests
    type:
      - 'null'
      - boolean
    doc: If set will get ESTs rather than mRNAs
    inputBinding:
      position: 104
      prefix: -est
outputs:
  - id: output_fa
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgspeciesrna:482--h0b57e2e_1
