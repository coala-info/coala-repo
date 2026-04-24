cwlVersion: v1.2
class: CommandLineTool
baseCommand: LongGF
label: longgf_LongGF
doc: "LongGF tool for processing BAM and GTF files.\n\nTool homepage: https://github.com/WGLab/LongGF"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: input_gtf
    type: File
    doc: Input GTF file
    inputBinding:
      position: 2
  - id: min_overlap_len
    type: int
    doc: Minimum overlap length
    inputBinding:
      position: 3
  - id: bin_size
    type: int
    doc: Bin size
    inputBinding:
      position: 4
  - id: min_map_len
    type: int
    doc: Minimum map length
    inputBinding:
      position: 5
  - id: pseudogene
    type:
      - 'null'
      - string
    doc: 'Pseudogene filter: 0 (default)/1/other (no filter)'
    inputBinding:
      position: 6
  - id: secondary_alignment
    type:
      - 'null'
      - string
    doc: 'Secondary alignment filter: 0 (default)'
    inputBinding:
      position: 7
  - id: min_sup_read
    type:
      - 'null'
      - int
    doc: Minimum supporting read count
    inputBinding:
      position: 8
  - id: output_flag
    type:
      - 'null'
      - int
    doc: Output flag
    inputBinding:
      position: 9
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longgf:0.1.2--h84372a0_6
stdout: longgf_LongGF.out
