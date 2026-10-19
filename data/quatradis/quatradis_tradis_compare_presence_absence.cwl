cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tradis
  - compare
  - presence_absence
label: quatradis_tradis_compare_presence_absence
doc: "Take in gene report files and produce a heatmap.\n\nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs:
  - id: emblfile
    type: File
    doc: "Annotation file in EMBL format."
    inputBinding:
      position: 1
  - id: genereports
    type:
      type: array
      items: File
    doc: "Gene report spreadsheets."
    inputBinding:
      position: 2
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Output directory prefix."
    inputBinding:
      position: 103
      prefix: --prefix
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
      glob: $(inputs.prefix)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis_compare_presence_absence.out
