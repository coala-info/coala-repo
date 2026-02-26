cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrnaToGene
label: ucsc-mrnatogene
doc: "Convert mRNA alignments in PSL format to gene predictions.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: psl_input
    type: File
    doc: Input PSL file containing mRNA alignments.
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: Keep all alignments, even those that don't look like genes.
    inputBinding:
      position: 102
      prefix: -all
  - id: cds_file
    type:
      - 'null'
      - File
    doc: Get CDS information from this file (usually a relational table or a 
      file in a specific format).
    inputBinding:
      position: 102
      prefix: -cdsFile
  - id: insert_merge
    type:
      - 'null'
      - int
    doc: Merge inserts of size N or less.
    inputBinding:
      position: 102
      prefix: -insertMerge
  - id: no_head
    type:
      - 'null'
      - boolean
    doc: Don't add a header to the output file.
    inputBinding:
      position: 102
      prefix: -noHead
outputs:
  - id: output_file
    type: File
    doc: Output gene prediction file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mrnatogene:482--h0b57e2e_0
