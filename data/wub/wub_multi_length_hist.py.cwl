cwlVersion: v1.2
class: CommandLineTool
baseCommand: multi_length_hist.py
label: wub_multi_length_hist.py
doc: "Plot histograms of length distributions from multiple sequence files.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: "Report PDF (multi_length_hist.pdf)."
    inputBinding:
      position: 1
      prefix: -r
  - id: in_format
    type:
      - 'null'
      - string
    doc: "Input format (fastq)."
    inputBinding:
      position: 2
      prefix: -f
  - id: nr_bins
    type:
      - 'null'
      - int
    doc: "Number of bins (50)."
    inputBinding:
      position: 3
      prefix: -b
  - id: min_len
    type:
      - 'null'
      - int
    doc: "Minimum read length (None)."
    inputBinding:
      position: 4
      prefix: -l
  - id: max_len
    type:
      - 'null'
      - int
    doc: "Maximum read length (None)."
    inputBinding:
      position: 5
      prefix: -u
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: "Log transform lengths."
    inputBinding:
      position: 6
      prefix: -L
  - id: input_counts
    type:
      type: array
      items: File
    doc: "Input sequence files."
    inputBinding:
      position: 100
outputs:
  - id: report
    type: File
    doc: "Histogram report"
    outputBinding:
      glob: '${ return inputs.report_pdf ? inputs.report_pdf : "multi_length_hist.pdf"; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
