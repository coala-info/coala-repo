cwlVersion: v1.2
class: CommandLineTool
baseCommand: multi_to_single_fast5
label: ont-fast5-api_multi_to_single_fast5
doc: "Convert multi-read FAST5 files to single-read FAST5 files.\n\nTool homepage: https://github.com/nanoporetech/ont_fast5_api"
inputs:
  - id: input_path
    type: File
    doc: MultiRead fast5 file or path to directory of MultiRead files
    inputBinding:
      position: 101
      prefix: --input_path
  - id: save_path_name
    type: string
    doc: Folder to output SingleRead fast5 files to
    inputBinding:
      position: 101
      prefix: --save_path
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
    doc: Folder with the SingleRead fast5 files
    outputBinding:
      glob: $(inputs.save_path_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
