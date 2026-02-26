cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffq
label: ffq
doc: "A command line tool to find sequencing data from SRA / GEO / ENCODE\n/ ENA /
  EBI-EMBL / DDBJ / Biosample.\n\nTool homepage: https://github.com/pachterlab/ffq"
inputs:
  - id: ids
    type:
      type: array
      items: string
    doc: "One or multiple SRA / GEO / ENCODE / ENA / EBI-EMBL / DDBJ /\n         \
      \     Biosample accessions, DOIs, or paper titles"
    inputBinding:
      position: 1
  - id: aws
    type:
      - 'null'
      - boolean
    doc: Return AWS links
    inputBinding:
      position: 102
      prefix: --aws
  - id: ftp
    type:
      - 'null'
      - boolean
    doc: Return FTP links
    inputBinding:
      position: 102
      prefix: --ftp
  - id: gcp
    type:
      - 'null'
      - boolean
    doc: Return GCP links
    inputBinding:
      position: 102
      prefix: --gcp
  - id: level
    type:
      - 'null'
      - string
    doc: Max depth to fetch data within accession tree
    inputBinding:
      position: 102
      prefix: -l
  - id: ncbi
    type:
      - 'null'
      - boolean
    doc: Return NCBI links
    inputBinding:
      position: 102
      prefix: --ncbi
  - id: split
    type:
      - 'null'
      - boolean
    doc: "Split output into separate files by accession (`-o` is a\n             \
      \ directory)"
    inputBinding:
      position: 102
      prefix: --split
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debugging information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to write metadata
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffq:0.3.1--pyhdfd78af_0
