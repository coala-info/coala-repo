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
      - int
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
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Path to write metadata (default standard output); a directory when
      split is set
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Metadata file written with -o
    outputBinding:
      glob: '$(inputs.split ? null : inputs.output_file_path)'
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory with one file per accession (split mode)
    outputBinding:
      glob: '$(inputs.split ? inputs.output_file_path : null)'
  - id: stdout
    type: stdout
    doc: Metadata printed to standard output (when no output path is given)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffq:0.3.1--pyhdfd78af_0
stdout: ffq.out
