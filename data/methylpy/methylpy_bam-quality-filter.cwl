cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylpy
  - bam-quality-filter
label: methylpy_bam-quality-filter
doc: "Filter BAM files based on mapping quality and mCH levels.\n\nTool homepage:
  https://github.com/yupenghe/methylpy"
inputs:
  - id: buffer_line_number
    type:
      - 'null'
      - int
    doc: size of buffer for reads to be written on hard drive.
    inputBinding:
      position: 101
      prefix: --buffer-line-number
  - id: input_file
    type: File
    doc: BAM file to filter.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: max_mch_level
    type:
      - 'null'
      - float
    doc: Maximum mCH level for reads to be included.
    inputBinding:
      position: 101
      prefix: --max-mch-level
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ for reads to be included.
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_num_ch
    type:
      - 'null'
      - int
    doc: Minimum number of CH sites for mCH level filter to be applied.
    inputBinding:
      position: 101
      prefix: --min-num-ch
  - id: ref_fasta
    type: File
    doc: string indicating the path to a fasta file containing the sequences you
      used for mapping
    inputBinding:
      position: 101
      prefix: --ref-fasta
outputs:
  - id: output_file
    type: File
    doc: Name of output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
