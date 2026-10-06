cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamfilterrg.py
label: bamkit_bamfilterrg.py
doc: "Filter read group(s) from a BAM file.\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs:
  - id: input
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --input
  - id: readgroup
    type:
      - 'null'
      - type: array
        items: string
    doc: Read group(s) to extract (comma separated)
    inputBinding:
      position: 101
      prefix: --readgroup
      itemSeparator: ','
  - id: first_n
    type:
      - 'null'
      - int
    doc: Output first n alignments and quit
    inputBinding:
      position: 101
      prefix: -n
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
    doc: Output BAM format (default is SAM)
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
outputs:
  - id: stdout
    type: stdout
    doc: Filtered alignments (SAM, or BAM with -b/-u)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamfilterrg.py.out
