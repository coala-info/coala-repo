cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/fetchFastq.sh
label: atlas-fastq-provider_fetchFastq.sh
doc: "Fetches FASTQ files from various sources.\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-fastq-provider"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Config file to override defaults
    inputBinding:
      position: 101
      prefix: -c
  - id: download_type
    type:
      - 'null'
      - string
    doc: Download type (fastq or srr)
    inputBinding:
      position: 101
      prefix: -d
  - id: file_or_uri
    type:
      - 'null'
      - string
    doc: File or URI to fetch
    inputBinding:
      position: 101
      prefix: -f
  - id: library
    type:
      - 'null'
      - string
    doc: Library to infer from file name
    inputBinding:
      position: 101
      prefix: -l
  - id: public_or_private
    type:
      - 'null'
      - string
    doc: Public or private access
    default: public
    inputBinding:
      position: 101
      prefix: -p
  - id: retrieval_method
    type:
      - 'null'
      - string
    doc: Retrieval method
    default: wget
    inputBinding:
      position: 101
      prefix: -m
  - id: source_resource_or_directory
    type:
      - 'null'
      - string
    doc: Source resource or directory
    default: auto
    inputBinding:
      position: 101
      prefix: -s
  - id: target_file
    type:
      - 'null'
      - File
    doc: Target file for download
    inputBinding:
      position: 101
      prefix: -t
  - id: validate_only
    type:
      - 'null'
      - boolean
    doc: Validate only, don't download
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas-fastq-provider:0.4.8--hdfd78af_0
stdout: atlas-fastq-provider_fetchFastq.sh.out
