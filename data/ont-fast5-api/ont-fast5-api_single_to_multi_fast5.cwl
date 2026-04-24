cwlVersion: v1.2
class: CommandLineTool
baseCommand: single_to_multi_fast5
label: ont-fast5-api_single_to_multi_fast5
doc: "Convert single-read FAST5 files to multi-read FAST5 files.\n\nTool homepage:
  https://github.com/nanoporetech/ont_fast5_api"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of fast5 files to batch into a single multi-read file
    inputBinding:
      position: 101
      prefix: --n_fast5
  - id: compression
    type:
      - 'null'
      - string
    doc: Compression type (gzip or vbz)
    inputBinding:
      position: 101
      prefix: --compression
  - id: filename_base
    type:
      - 'null'
      - string
    doc: Root of output filename
    inputBinding:
      position: 101
      prefix: --filename_base
  - id: input_path
    type: Directory
    doc: Path to directory containing single-read fast5 files
    inputBinding:
      position: 101
      prefix: --input_path
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search recursively for fast5 files in input_path
    inputBinding:
      position: 101
      prefix: --recursive
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: save_path
    type: Directory
    doc: Path to directory to save multi-read fast5 files
    outputBinding:
      glob: $(inputs.save_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
