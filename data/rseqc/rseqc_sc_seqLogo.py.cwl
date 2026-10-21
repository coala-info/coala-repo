cwlVersion: v1.2
class: CommandLineTool
baseCommand: [sc_seqLogo.py]
label: rseqc_sc_seqLogo.py
doc: "Generate a DNA sequence logo from a fasta or fastq file. It is useful to visualize the nucleotide compositions of sample barcodes, cell barcodes and molecular barcodes.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: infile
    type: File
    doc: "Input DNA sequence file in FASTQ, FASTA or pure sequence format. All sequences must be the same length. This file can be plain text or compressed format (\".gz\", \".Z\",\".z\",\".bz\", \".bz2\", \".bzip2\")."
    inputBinding:
      position: 1
      prefix: --infile
  - id: outfile
    type: string
    doc: "The prefix of output files."
    inputBinding:
      position: 1
      prefix: --outfile
  - id: iformat
    type:
      - 'null'
      - string
    doc: "The format of input file. Must be 'fq' or 'fa'. default='fq'"
    inputBinding:
      position: 1
      prefix: --iformat
  - id: oformat
    type:
      - 'null'
      - string
    doc: "The format of output logo file. Must be 'pdf', 'png' or 'svg'. default='pdf'"
    inputBinding:
      position: 1
      prefix: --oformat
  - id: nseq_limit
    type:
      - 'null'
      - int
    doc: "Only process this many sequences and stop. default=none (generate logo from ALL sequences)."
    inputBinding:
      position: 1
      prefix: --nseq-limit
  - id: font_name
    type:
      - 'null'
      - string
    doc: "The font of logo characters. For a list of valid font names, run logomaker.list_font_names(). default='sans'"
    inputBinding:
      position: 1
      prefix: --font-name
  - id: stack_order
    type:
      - 'null'
      - string
    doc: "Must be 'big_on_top', 'small_on_top', or 'fixed'. 'big_on_top' : nucleotide with the highest frequency will be on the top; 'small_on_top' : nucleotide with the lowest frequency will be on the top; 'fixed' : nucleotides from top to bottom are in the same order as characters appear in the data frame. default='big_on_top'"
    inputBinding:
      position: 1
      prefix: --stack-order
  - id: flip_below
    type:
      - 'null'
      - boolean
    doc: "If set, characters below the X-axis (which correspond to negative values in the matrix) will be flipped upside down. default=False"
    inputBinding:
      position: 1
      prefix: --flip-below
  - id: shade_below
    type:
      - 'null'
      - float
    doc: "The amount of shading to use for characters drawn below the X-axis. 0 <= shade_below <= 1. Larger values correspond to more shading. default=0.0"
    inputBinding:
      position: 1
      prefix: --shade-below
  - id: fade_below
    type:
      - 'null'
      - float
    doc: "The amount of fading to use for characters drawn below the X-axis. 0 <= shade_below <= 1. Larger values correspond to more fading. default=0.0"
    inputBinding:
      position: 1
      prefix: --fade-below
  - id: excludeN
    type:
      - 'null'
      - boolean
    doc: "If set, exclude all DNA sequences containing \"N\"."
    inputBinding:
      position: 1
      prefix: --excludeN
  - id: highlight_start
    type:
      - 'null'
      - int
    doc: "Highlight logo from this position. Must be within [0, sequence_length-1]. default=none (no highlight)"
    inputBinding:
      position: 1
      prefix: --highlight-start
  - id: highlight_end
    type:
      - 'null'
      - int
    doc: "Highlight logo to this position. Must be within [0, len(logo)-1]. default=none (no highlight)"
    inputBinding:
      position: 1
      prefix: --highlight-end
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "If set, print detailed information for debugging."
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: count_matrix
    type: File
    doc: "Nucleotide count matrix per position."
    outputBinding:
      glob: "$(inputs.outfile).count_matrix.csv"
  - id: logo
    type: File
    doc: "Sequence logo."
    outputBinding:
      glob: "$(inputs.outfile).logo.$(inputs.oformat || 'pdf')"
  - id: logo_mean_centered
    type: File
    doc: "Mean-centered sequence logo."
    outputBinding:
      glob: "$(inputs.outfile).logo.mean_centered.$(inputs.oformat || 'pdf')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
