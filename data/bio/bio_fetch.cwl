cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
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
    default: ''
    inputBinding:
      position: 102
      prefix: --db
  - id: format
    type:
      - 'null'
      - string
    doc: return format
    default: ''
    inputBinding:
      position: 102
      prefix: --format
  - id: limit
    type:
      - 'null'
      - int
    doc: limit results
    default: 100
    inputBinding:
      position: 102
      prefix: --limit
  - id: type
    type:
      - 'null'
      - string
    doc: get CDS/CDNA (Ensembl only)
    default: ''
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file (used as prefix in for FASTQ)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
