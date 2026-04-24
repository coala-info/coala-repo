cwlVersion: v1.2
class: CommandLineTool
baseCommand: Logex
label: fastk_Logex
doc: "Logex\n\nTool homepage: https://github.com/thegenemyers/FASTK"
inputs:
  - id: output_name_expr
    type:
      type: array
      items: string
    doc: output:name=expr
    inputBinding:
      position: 1
  - id: source_root
    type:
      type: array
      items: File
    doc: source_root[.ktab]
    inputBinding:
      position: 2
  - id: generate_histograms
    type:
      - 'null'
      - boolean
    doc: Generate histograms.
    inputBinding:
      position: 103
      prefix: -h
  - id: generate_histograms_only
    type:
      - 'null'
      - boolean
    doc: Generate histograms only, no tables.
    inputBinding:
      position: 103
      prefix: -H
  - id: threads
    type:
      - 'null'
      - int
    doc: Use -T threads.
    inputBinding:
      position: 103
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Logex.out
