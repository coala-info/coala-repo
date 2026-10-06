cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtk
  - sum
label: bedtk_sum
doc: "Sum the lengths of intervals in a BED file (total region length).\n\nTool homepage:
  https://github.com/lh3/bedtk"
inputs:
  - id: input_bed_file
    type: File
    doc: Input BED file.
    inputBinding:
      position: 1
  - id: merge
    type:
      - 'null'
      - boolean
    doc: merge overlapping regions
    inputBinding:
      position: 103
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtk:1.2--h9990f68_0
stdout: bedtk_sum.out
