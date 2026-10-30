cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_counts_correlation.py
label: wub_plot_counts_correlation.py
doc: "Scatter plot of two set of counts.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: "Report PDF (plot_counts_correlation.pdf)."
    inputBinding:
      position: 1
      prefix: -r
  - id: tags
    type:
      - 'null'
      - string
    doc: "Data tags: tag1,tag2."
    inputBinding:
      position: 2
      prefix: -T
  - id: merged_data
    type:
      - 'null'
      - string
    doc: "Merged data TSV."
    inputBinding:
      position: 3
      prefix: -t
  - id: correlation_tsv
    type:
      - 'null'
      - string
    doc: "Correlation TSV."
    inputBinding:
      position: 4
      prefix: -o
  - id: counts_one
    type: File
    doc: "Input tab separated file."
    inputBinding:
      position: 100
  - id: counts_two
    type: File
    doc: "Input tab separated file."
    inputBinding:
      position: 101
outputs:
  - id: report
    type: File
    doc: "Scatter plot report"
    outputBinding:
      glob: '${ return inputs.report_pdf ? inputs.report_pdf : "plot_counts_correlation.pdf"; }'
  - id: merged_tsv
    type:
      - 'null'
      - File
    doc: "Merged counts table"
    outputBinding:
      glob: $(inputs.merged_data)
  - id: correlation
    type:
      - 'null'
      - File
    doc: "Spearman correlation table"
    outputBinding:
      glob: $(inputs.correlation_tsv)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
