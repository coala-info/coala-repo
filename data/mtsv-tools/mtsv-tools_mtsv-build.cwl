cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv-build
label: mtsv-tools_mtsv-build
doc: "Index construction for mtsv metagenomic and metatranscriptomic assignment tool.\n\
  \nTool homepage: https://github.com/FofanovLab/mtsv_tools"
inputs:
  - id: fasta
    type: File
    doc: Path to FASTA database file.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: index
    type: Directory
    doc: Absolute path to mtsv index file.
    inputBinding:
      position: 101
      prefix: --index
  - id: mapping
    type:
      - 'null'
      - File
    doc: 'Path to header->taxid/seqid mapping file (columns: header, taxid, seqid).'
    inputBinding:
      position: 101
      prefix: --mapping
  - id: sa_sample_rate
    type:
      - 'null'
      - int
    doc: Suffix array sampling rate. If sampling rate is k, every k-th entry 
      will be kept.
    inputBinding:
      position: 101
      prefix: --sa-sample
  - id: sample_interval
    type:
      - 'null'
      - int
    doc: BWT occurance sampling rate. If sample interval is k, every k-th entry 
      will be kept.
    inputBinding:
      position: 101
      prefix: --sample-interval
  - id: skip_missing
    type:
      - 'null'
      - boolean
    doc: Skip FASTA records missing from the mapping file (warn instead of 
      error).
    inputBinding:
      position: 101
      prefix: --skip-missing
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Include this flag to trigger debug-level logging.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
stdout: mtsv-tools_mtsv-build.out
