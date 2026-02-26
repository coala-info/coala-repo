cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit_bamfilterrg.py
label: bamkit_bamfilterrg.py
doc: "Filter BAM files by read group.\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs:
  - id: input
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: readgroup
    type: string
    doc: Read group ID to filter by
    inputBinding:
      position: 2
  - id: S
    type:
      - 'null'
      - boolean
    doc: Output SAM format
    inputBinding:
      position: 103
  - id: b
    type:
      - 'null'
      - boolean
    doc: Output BAM format (default)
    inputBinding:
      position: 103
  - id: n
    type:
      - 'null'
      - string
    doc: 'Output BAM file (default: stdout)'
    inputBinding:
      position: 103
  - id: u
    type:
      - 'null'
      - boolean
    doc: Uncompressed BAM output
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamfilterrg.py.out
