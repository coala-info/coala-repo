cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_gffcmp_stats.py
label: wub_plot_gffcmp_stats.py
doc: "Plot a gffcompare stats file.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: "Report PDF (plot_gffcmp_stats.pdf)."
    inputBinding:
      position: 1
      prefix: -r
  - id: pickle_out
    type:
      - 'null'
      - string
    doc: "Output pickle file."
    inputBinding:
      position: 2
      prefix: -p
  - id: input_txt
    type: File
    doc: "Input gffcompare stats file."
    inputBinding:
      position: 100
outputs:
  - id: report
    type: File
    doc: "Plot report"
    outputBinding:
      glob: '${ return inputs.report_pdf ? inputs.report_pdf : "plot_gffcmp_stats.pdf"; }'
  - id: pickle
    type:
      - 'null'
      - File
    doc: "Pickle file with the parsed statistics"
    outputBinding:
      glob: '${ return inputs.pickle_out ? inputs.pickle_out : "plot_gffcmp_stats.pk"; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
