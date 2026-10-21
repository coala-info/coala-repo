cwlVersion: v1.2
class: CommandLineTool
baseCommand: [sc_seqQual.py]
label: rseqc_sc_seqQual.py
doc: "Generate a heatmap from a FASTQ file to visualize the sequencing quality.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: infile
    type: File
    doc: "Input file in FASTQ format."
    inputBinding:
      position: 1
      prefix: --infile
  - id: outfile
    type: string
    doc: "The prefix of output files."
    inputBinding:
      position: 1
      prefix: --outfile
  - id: nseq_limit
    type:
      - 'null'
      - int
    doc: "Only process this many sequences and stop. default=none (generate logo from ALL sequences)."
    inputBinding:
      position: 1
      prefix: --nseq-limit
  - id: cell_width
    type:
      - 'null'
      - int
    doc: "Cell width (in points) of the heatmap. default=12"
    inputBinding:
      position: 1
      prefix: --cell-width
  - id: cell_height
    type:
      - 'null'
      - int
    doc: "Cell height (in points) of the heatmap. default=10"
    inputBinding:
      position: 1
      prefix: --cell-height
  - id: font_size
    type:
      - 'null'
      - int
    doc: "Font size in points. If --display-num was set, fontsize_number = 0.8 * font_size. default=6"
    inputBinding:
      position: 1
      prefix: --font-size
  - id: angle
    type:
      - 'null'
      - int
    doc: "The angle (must be 0, 45, 90, 270, 315) of column text lables under the heatmap. default=45"
    inputBinding:
      position: 1
      prefix: --angle
  - id: text_color
    type:
      - 'null'
      - string
    doc: "The color of numbers in each cell. default=black"
    inputBinding:
      position: 1
      prefix: --text-color
  - id: file_type
    type:
      - 'null'
      - string
    doc: "The file type of heatmap. Choose one of 'pdf', 'png', 'tiff', 'bmp', 'jpeg'. default=pdf"
    inputBinding:
      position: 1
      prefix: --file-type
  - id: no_num
    type:
      - 'null'
      - boolean
    doc: "if set, will not print numerical values to cells. default=False"
    inputBinding:
      position: 1
      prefix: --no-num
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "If set, will produce detailed information for debugging."
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: qual_count
    type: File
    doc: "Quality score counts per position."
    outputBinding:
      glob: "$(inputs.outfile).qual_count.csv"
  - id: qual_percent
    type: File
    doc: "Quality score percentages per position."
    outputBinding:
      glob: "$(inputs.outfile).qual_percent.csv"
  - id: qual_heatmap
    type: File
    doc: "Quality heatmap."
    outputBinding:
      glob: "$(inputs.outfile).qual_heatmap.$(inputs.file_type || 'pdf')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
