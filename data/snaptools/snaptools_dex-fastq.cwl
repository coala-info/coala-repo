cwlVersion: v1.2
class: CommandLineTool
baseCommand: snaptools dex-fastq
label: snaptools_dex-fastq
doc: "Decomplexes a fastq file containing reads from multiple cells into individual
  fastq files for each cell.\n\nTool homepage: https://github.com/r3fang/SnapTools.git"
inputs:
  - id: index_fastq_list
    type:
      type: array
      items: File
    doc: a list of fastq files that contain the cell indices.
    inputBinding:
      position: 101
      prefix: --index-fastq-list
  - id: input_fastq
    type: File
    doc: fastq file contains the sequencing reads
    inputBinding:
      position: 101
      prefix: --input-fastq
outputs:
  - id: output_fastq
    type: File
    doc: output decomplexed fastq file
    outputBinding:
      glob: $(inputs.output_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snaptools:1.4.8--py_0
