cwlVersion: v1.2
class: CommandLineTool
baseCommand: compress_fast5
label: ont-fast5-api_compress_fast5
doc: "Change the compression of FAST5 files.\n\nTool homepage: https://github.com/nanoporetech/ont_fast5_api"
inputs:
  - id: input_path
    type: Directory
    doc: Folder containing fast5 files
    inputBinding:
      position: 101
      prefix: --input_path
  - id: save_path_name
    type: string
    doc: Folder to output fast5 read files to
    inputBinding:
      position: 101
      prefix: --save_path
  - id: compression
    type: string
    doc: Target output compression type (vbz_v1.alpha, vbz or gzip)
    inputBinding:
      position: 101
      prefix: --compression
  - id: sanitize
    type:
      - 'null'
      - boolean
    doc: Clean output files of optional groups and datasets (e.g. 'Analyses')
    inputBinding:
      position: 101
      prefix: --sanitize
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
    doc: Search recursively through folders for single_read fast5 files
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
outputs:
  - id: save_path
    type: Directory
    doc: Folder with the recompressed fast5 files
    outputBinding:
      glob: $(inputs.save_path_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
