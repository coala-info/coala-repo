cwlVersion: v1.2
class: CommandLineTool
baseCommand: prerapsearch
label: prerapsearch
doc: 'Builds the RAPSearch2 database (hash file and .info file) from a protein FASTA
  file.


  Tool homepage: https://omics.informatics.indiana.edu/mg/RAPSearch2/'
inputs:
  - id: database
    type: File
    doc: database
    inputBinding:
      position: 101
      prefix: -d
  - id: swift_file
    type: string
    doc: swift-file (base name only)
    inputBinding:
      position: 101
      prefix: -n
  - id: splits_num
    type:
      - 'null'
      - int
    doc: splits the database into specified number of files
    inputBinding:
      position: 101
      prefix: -s
  - id: full_headers
    type:
      - 'null'
      - string
    doc: T/t output the full fasta headers of subjects to facilitate annotation
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database_files
    type:
      type: array
      items: File
    doc: RAPSearch2 database files written with the base name
    outputBinding:
      glob: $(inputs.swift_file)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapsearch:2.24--1
stdout: prerapsearch.out
