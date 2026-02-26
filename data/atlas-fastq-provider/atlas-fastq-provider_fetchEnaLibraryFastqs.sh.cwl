cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/fetchEnaLibraryFastqs.sh
label: atlas-fastq-provider_fetchEnaLibraryFastqs.sh
doc: "Fetches ENA library FASTQ files.\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-fastq-provider"
inputs:
  - id: access_type
    type:
      - 'null'
      - string
    doc: Access type (public or private)
    default: public
    inputBinding:
      position: 101
      prefix: -p
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file to override defaults
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
      prefix: -t
  - id: library
    type: string
    doc: Library identifier
    inputBinding:
      position: 101
      prefix: -l
  - id: read_pairing
    type:
      - 'null'
      - string
    doc: Read pairing type (SINGLE or PAIRED)
    default: PAIRED
    inputBinding:
      position: 101
      prefix: -n
  - id: retrieval_method
    type:
      - 'null'
      - string
    doc: Retrieval method (e.g., 'wget', 'dir')
    default: wget
    inputBinding:
      position: 101
      prefix: -m
  - id: source_directory
    type:
      - 'null'
      - Directory
    doc: Source directory for 'dir' retrieval method
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: output_directory
    type: Directory
    doc: Directory to save the downloaded files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas-fastq-provider:0.4.8--hdfd78af_0
