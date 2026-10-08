cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALNplot
label: fastga_ALNplot
doc: "Plots a dot plot of the alignments in a .1aln or PAF file as EPS (standard output) or PDF.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
arguments:
  - position: 100
    valueFrom: $(inputs.alignments.basename)
inputs:
  - id: alignments
    type: File
    doc: Alignment file (.1aln) made by FastGA.
  - id: sources
    type: File[]
    doc: Source genome files (for example FASTA) named in the alignment file; they are staged beside it.
  - id: selection
    type:
      - 'null'
      - string[]
    doc: Optional selections or files of selections (see the tool help for the grammar).
    inputBinding:
      position: 101
  - id: sequence_ids
    type:
      - 'null'
      - boolean
    doc: Print sequence IDs as labels instead of names.
    inputBinding:
      position: 101
      prefix: '-S'
  - id: no_labels
    type:
      - 'null'
      - boolean
    doc: Do not print labels.
    inputBinding:
      position: 101
      prefix: '-L'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 101
      prefix: '-v'
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. [default: 4]'
    inputBinding:
      position: 101
      prefix: '-T'
      separate: false
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: Make PDF output (requires epstopdf or eps2pdf).
    inputBinding:
      position: 101
      prefix: '-p'
  - id: pdf_output
    type:
      - 'null'
      - string
    doc: Make PDF output with this file name (requires epstopdf or eps2pdf).
    inputBinding:
      position: 101
      prefix: '-p:'
      separate: false
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum alignment length. [default: 100]'
    inputBinding:
      position: 101
      prefix: '-l'
      separate: false
  - id: min_identity
    type:
      - 'null'
      - float
    doc: 'Minimum alignment identity. [default: 0.7]'
    inputBinding:
      position: 101
      prefix: '-i'
      separate: false
  - id: max_lines
    type:
      - 'null'
      - int
    doc: 'Maximum number of lines to display (0 for all). [default: 100000]'
    inputBinding:
      position: 101
      prefix: '-n'
      separate: false
  - id: height
    type:
      - 'null'
      - int
    doc: 'Image height. [default: 600]'
    inputBinding:
      position: 101
      prefix: '-H'
      separate: false
  - id: width
    type:
      - 'null'
      - int
    doc: Image width.
    inputBinding:
      position: 101
      prefix: '-W'
      separate: false
  - id: font_size
    type:
      - 'null'
      - int
    doc: Label font size.
    inputBinding:
      position: 101
      prefix: '-f'
      separate: false
  - id: thickness
    type:
      - 'null'
      - float
    doc: Line thickness.
    inputBinding:
      position: 101
      prefix: '-t'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pdf_file
    type:
      - 'null'
      - File
    doc: PDF written when pdf_output is set.
    outputBinding:
      glob: $(inputs.pdf_output).pdf
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.alignments)
      - $(inputs.sources)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ALNplot.out
