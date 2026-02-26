cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtk
  - cov
label: bedtk_cov
doc: "Calculate coverage of intervals in a BED file.\n\nTool homepage: https://github.com/lh3/bedtk"
inputs:
  - id: loaded_bed
    type: File
    doc: The first BED file (loaded intervals).
    inputBinding:
      position: 1
  - id: streamed_bed
    type: File
    doc: The second BED file (streamed intervals).
    inputBinding:
      position: 2
  - id: containment_only
    type:
      - 'null'
      - boolean
    doc: containment only
    inputBinding:
      position: 103
      prefix: -C
  - id: only_count
    type:
      - 'null'
      - boolean
    doc: only count; no breadth of depth
    inputBinding:
      position: 103
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtk:1.2--h9990f68_0
stdout: bedtk_cov.out
