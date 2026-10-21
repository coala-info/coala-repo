cwlVersion: v1.2
class: CommandLineTool
baseCommand: [sc_editMatrix.py]
label: rseqc_sc_editMatrix.py
doc: "Generate heatmaps of the positions (X-axis), type of edits (Y-axis, such as \"C\" to \"T\") and frequencies (color) of error-corrected nucleotides in cell barcodes and UMIs.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: infile
    type: File
    doc: "Input file in BAM foramt."
    inputBinding:
      position: 1
      prefix: --infile
  - id: outfile
    type: string
    doc: "The prefix of output files."
    inputBinding:
      position: 1
      prefix: --outfile
  - id: limit
    type:
      - 'null'
      - int
    doc: "Number of alignments to process. default=none"
    inputBinding:
      position: 1
      prefix: --limit
  - id: cr_tag
    type:
      - 'null'
      - string
    doc: "Tag of cellular barcode reported by the sequencer in BAM file. default='CR'"
    inputBinding:
      position: 1
      prefix: --cr-tag
  - id: cb_tag
    type:
      - 'null'
      - string
    doc: "Tag of error-corrected cellular barcode in BAM file. default='CB'"
    inputBinding:
      position: 1
      prefix: --cb-tag
  - id: ur_tag
    type:
      - 'null'
      - string
    doc: "Tag of UMI reported by the sequencer in BAM file. default='UR'"
    inputBinding:
      position: 1
      prefix: --ur-tag
  - id: ub_tag
    type:
      - 'null'
      - string
    doc: "Tag of error-corrected UMI in BAM file. default='UB'"
    inputBinding:
      position: 1
      prefix: --ub-tag
  - id: cell_width
    type:
      - 'null'
      - int
    doc: "Points of cell width in the heatmap. default=15"
    inputBinding:
      position: 1
      prefix: --cell-width
  - id: cell_height
    type:
      - 'null'
      - int
    doc: "Points of cell height in the heatmap. default=10"
    inputBinding:
      position: 1
      prefix: --cell-height
  - id: font_size
    type:
      - 'null'
      - int
    doc: "Font size. If --display-num was set, fontsize_number = 0.8 * font_size. default=8"
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
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "If set, detailed running information is printed to screen."
    inputBinding:
      position: 1
      prefix: --verbose
  - id: no_num
    type:
      - 'null'
      - boolean
    doc: "If set, will not print numerical values to cells. default=False"
    inputBinding:
      position: 1
      prefix: --no-num
outputs:
  - id: cb_edits_count
    type: File
    doc: "Edit counts of cell barcodes."
    outputBinding:
      glob: "$(inputs.outfile).CB_edits_count.csv"
  - id: umi_edits_count
    type: File
    doc: "Edit counts of UMIs."
    outputBinding:
      glob: "$(inputs.outfile).UMI_edits_count.csv"
  - id: cb_freq
    type: File
    doc: "Nucleotide frequencies of cell barcodes."
    outputBinding:
      glob: "$(inputs.outfile).CB_freq.tsv"
  - id: umi_freq
    type: File
    doc: "Nucleotide frequencies of UMIs."
    outputBinding:
      glob: "$(inputs.outfile).UMI_freq.tsv"
  - id: cb_heatmap
    type: File
    doc: "Heatmap of cell barcode edits."
    outputBinding:
      glob: "$(inputs.outfile).CB_edits_heatmap.$(inputs.file_type || 'pdf')"
  - id: umi_heatmap
    type: File
    doc: "Heatmap of UMI edits."
    outputBinding:
      glob: "$(inputs.outfile).UMI_edits_heatmap.$(inputs.file_type || 'pdf')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
