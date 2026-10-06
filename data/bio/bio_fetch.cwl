cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bio
  - fetch
label: bio_fetch
doc: "Fetch biological data from various databases.\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: accession_numbers
    type:
      type: array
      items: string
    doc: accession numbers
    inputBinding:
      position: 1
  - id: database
    type:
      - 'null'
      - string
    doc: database
    inputBinding:
      position: 102
      prefix: --db
  - id: format
    type:
      - 'null'
      - string
    doc: return format
    inputBinding:
      position: 102
      prefix: --format
  - id: limit
    type:
      - 'null'
      - int
    doc: limit results
    inputBinding:
      position: 102
      prefix: --limit
  - id: type
    type:
      - 'null'
      - string
    doc: get CDS/CDNA (Ensembl only)
    inputBinding:
      position: 102
      prefix: --type
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: output file (used as prefix in for FASTQ)
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (GenBank, FASTA, GFF or JSON records)
  - id: output_file
    type:
      type: array
      items: File
    doc: output files (used as prefix in for FASTQ)
    outputBinding:
      glob: '$(inputs.output_file_path ? inputs.output_file_path + "*" : "_no_out_")'
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_fetch.out
