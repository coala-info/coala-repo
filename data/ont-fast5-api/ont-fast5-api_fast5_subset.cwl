cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast5_subset
label: ont-fast5-api_fast5_subset
doc: "Extract reads from multi-read FAST5 files by read id.\n\nTool homepage: https://github.com/nanoporetech/ont_fast5_api"
inputs:
  - id: input
    type: Directory
    doc: Directory of Fast5 files (the tool asserts a directory)
    inputBinding:
      position: 101
      prefix: --input
  - id: save_path_name
    type: string
    doc: Folder to output MultiRead subset to
    inputBinding:
      position: 101
      prefix: --save_path
  - id: read_id_list
    type: File
    doc: File containing list of read ids to extract (or sequencing_summary.txt file)
    inputBinding:
      position: 101
      prefix: --read_id_list
  - id: filename_base
    type:
      - 'null'
      - string
    doc: "Root of output filename, default='batch' -> 'batch0.fast5'"
    inputBinding:
      position: 101
      prefix: --filename_base
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of reads per multi-read file (default 4000)
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
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
  - id: compression
    type:
      - 'null'
      - string
    doc: Target output compression type (vbz_v1.alpha, vbz, gzip or None)
    inputBinding:
      position: 101
      prefix: --compression
  - id: file_list
    type:
      - 'null'
      - File
    doc: File containing names of files to search in
    inputBinding:
      position: 101
      prefix: --file_list
outputs:
  - id: save_path
    type: Directory
    doc: Folder with the extracted MultiRead fast5 files
    outputBinding:
      glob: $(inputs.save_path_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
