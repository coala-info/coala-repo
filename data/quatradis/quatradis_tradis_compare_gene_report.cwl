cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tradis
  - compare
  - gene_report
label: quatradis_tradis_compare_gene_report
doc: "Generate a gene report from comparison analysis data.\n\nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs:
  - id: embl
    type: File
    doc: "Original EMBL file used for analysis."
    inputBinding:
      position: 1
  - id: combined
    type:
      - 'null'
      - File
    doc: "Combined plotfile."
    inputBinding:
      position: 103
      prefix: --combined
  - id: forward
    type:
      - 'null'
      - File
    doc: "Forward plotfile."
    inputBinding:
      position: 104
      prefix: --forward
  - id: reverse
    type:
      - 'null'
      - File
    doc: "Reverse plotfile."
    inputBinding:
      position: 105
      prefix: --reverse
  - id: scores
    type:
      - 'null'
      - File
    doc: "Combined scores."
    inputBinding:
      position: 106
      prefix: --scores
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Window size."
    inputBinding:
      position: 107
      prefix: --window_size
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Output filename prefix."
    inputBinding:
      position: 108
      prefix: --output_dir
  - id: use_annotations
    type:
      - 'null'
      - boolean
    doc: "EMBL file is a real EMBL file with annotations (not a set of windows)."
    inputBinding:
      position: 109
      prefix: --use_annotations
  - id: profile
    type:
      - 'null'
      - boolean
    doc: "Turn on profiling."
    inputBinding:
      position: 100
      prefix: --profile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print out extra information about the process while it runs."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_out
    type:
      - 'null'
      - Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis_compare_gene_report.out
