cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - debarcer.py
  - report
label: debarcer_report
doc: "Generate a report from debarcer results.\n\nTool homepage: https://github.com/oicr-gsi/debarcer"
inputs:
  - id: directory
    type: Directory
    doc: Directory with subdirectories including Figures
    inputBinding:
      position: 101
      prefix: --Directory
  - id: extension
    type:
      - 'null'
      - string
    doc: "Figure format. Does not generate a report if pdf, even\n               \
      \         with -r True. Default is png"
    inputBinding:
      position: 101
      prefix: --Extension
  - id: min_children
    type:
      - 'null'
      - int
    doc: "Minimum children umi count. Values below are plotted\n                 \
      \       in red"
    inputBinding:
      position: 101
      prefix: --MinChildren
  - id: min_cov
    type:
      - 'null'
      - int
    doc: "Minimum coverage value. Values below are plotted in\n                  \
      \      red"
    inputBinding:
      position: 101
      prefix: --MinCov
  - id: min_ratio
    type:
      - 'null'
      - float
    doc: "Minimum children to parent umi ratio. Values below are\n               \
      \         plotted in red"
    inputBinding:
      position: 101
      prefix: --MinRatio
  - id: min_umis
    type:
      - 'null'
      - int
    doc: Minimum umi count. Values below are plotted in red
    inputBinding:
      position: 101
      prefix: --MinUmis
  - id: sample
    type:
      - 'null'
      - string
    doc: "Sample name. Optional. Directory basename is sample\n                  \
      \      name if not provided"
    inputBinding:
      position: 101
      prefix: --Sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
stdout: debarcer_report.out
