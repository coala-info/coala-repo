cwlVersion: v1.2
class: CommandLineTool
baseCommand: length_normalise_counts.py
label: wub_length_normalise_counts.py
doc: "Calculate RPKM values from raw counts and a transcriptome reference.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: in_trs
    type: File
    doc: "Input transcriptome."
    inputBinding:
      position: 1
      prefix: -f
  - id: input_counts
    type: File
    doc: "Input count file."
    inputBinding:
      position: 100
  - id: output_count
    type:
      - 'null'
      - string
    default: "length_normalise_counts.tsv"
    doc: "Output RPKM file."
    inputBinding:
      position: 101
outputs:
  - id: rpkm_tsv
    type: File
    doc: "RPKM table"
    outputBinding:
      glob: $(inputs.output_count)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
