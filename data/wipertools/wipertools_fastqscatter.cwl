cwlVersion: v1.2
class: CommandLineTool
baseCommand: wipertools_fastqscatter
label: wipertools_fastqscatter
doc: "Split a FASTQ file into multiple smaller files.\n\nTool homepage: https://github.com/mazzalab/fastqwiper"
inputs:
  - id: extension
    type:
      - 'null'
      - string
    doc: The extension of the split files
    inputBinding:
      position: 101
      prefix: --ext
  - id: fastq_file
    type: File
    doc: The FASTQ file to be split
    inputBinding:
      position: 101
      prefix: --fastq
  - id: num_splits
    type: int
    doc: Number of splits
    inputBinding:
      position: 101
      prefix: --num_splits
  - id: os_type
    type:
      - 'null'
      - string
    doc: Underlying OS
    inputBinding:
      position: 101
      prefix: --os
  - id: prefix
    type: string
    doc: The prefix of the names of the split files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: suffix
    type:
      - 'null'
      - string
    doc: The suffix of the names of the split files
    inputBinding:
      position: 101
      prefix: --suffix
  - id: out_folder_path
    type: Directory
    doc: Output or path parameter `out_folder_path`
    inputBinding:
      position: 102
      prefix: --out-folder
outputs:
  - id: out_folder
    type:
      - 'null'
      - Directory
    doc: The folder name where to put the splits
    outputBinding:
      glob: $(inputs.out_folder_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
