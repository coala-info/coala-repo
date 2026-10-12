cwlVersion: v1.2
class: CommandLineTool
baseCommand: check_compression
label: ont-fast5-api_check_compression
doc: "Check the compression type of raw data in FAST5 files.\n\nTool homepage: https://github.com/nanoporetech/ont_fast5_api"
inputs:
  - id: input_path
    type: File
    doc: Path to Fast5 file or directory of Fast5 files
    inputBinding:
      position: 101
      prefix: --input_path
  - id: check_all_reads
    type:
      - 'null'
      - boolean
    doc: 'Check all reads in a file individually (default: check only the first read)'
    inputBinding:
      position: 101
      prefix: --check_all_reads
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search recursively through folders for MultiRead fast5 files
    inputBinding:
      position: 101
      prefix: --recursive
  - id: ignore_symlinks
    type:
      - 'null'
      - boolean
    doc: Ignore symlinks when searching recursively for fast5 files
    inputBinding:
      position: 101
      prefix: --ignore_symlinks
  - id: file_list
    type:
      - 'null'
      - File
    doc: File containing names of files to search in
    inputBinding:
      position: 101
      prefix: --file_list
outputs:
  - id: report
    type: stdout
    doc: Compression report printed by the tool
stdout: compression_report.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
