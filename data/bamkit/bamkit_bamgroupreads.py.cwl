cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamgroupreads.py
label: bamkit_bamgroupreads.py
doc: "Group BAM file by read IDs without sorting\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs:
  - id: fix_flags
    type:
      - 'null'
      - boolean
    doc: Fix mate flags for secondary reads
    inputBinding:
      position: 101
      prefix: --fix_flags
  - id: input_bam
    type:
      - 'null'
      - File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --input
  - id: input_sam
    type:
      - 'null'
      - boolean
    doc: Input is SAM format
    inputBinding:
      position: 101
      prefix: -S
  - id: output_bam
    type:
      - 'null'
      - boolean
    doc: Output BAM format
    inputBinding:
      position: 101
      prefix: -b
  - id: output_uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Output uncompressed BAM format (implies -b)
    inputBinding:
      position: 101
      prefix: -u
  - id: readgroup
    type:
      - 'null'
      - type: array
        items: string
    doc: Read group(s) to extract (comma separated)
    inputBinding:
      position: 101
      prefix: --readgroup
  - id: reset_dups
    type:
      - 'null'
      - boolean
    doc: Reset duplicate flags
    inputBinding:
      position: 101
      prefix: --reset_dups
  - id: secondary_flag
    type:
      - 'null'
      - boolean
    doc: split reads are flagged as secondary, not supplementary. For 
      compatibility with legacy BWA-MEM "-M" flag
    inputBinding:
      position: 101
      prefix: -M
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamgroupreads.py.out
