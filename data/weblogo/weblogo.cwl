cwlVersion: v1.2
class: CommandLineTool
baseCommand: weblogo
label: weblogo
doc: "Create sequence logos from biological sequence alignments.\n\nTool homepage:
  https://github.com/WebLogo/weblogo"
inputs:
  - id: sequence_data
    type: File
    doc: Sequence input file
    inputBinding:
      position: 1
  - id: alphabet
    type:
      - 'null'
      - string
    doc: The set of symbols to count, e.g. 'AGTC'. All characters not in the 
      alphabet are ignored. If neither the alphabet nor sequence-type are 
      specified then weblogo will examine the input data and make an educated 
      guess. See also --sequence-type, --ignore-lower-case
    inputBinding:
      position: 102
      prefix: --alphabet
  - id: annotate
    type:
      - 'null'
      - string
    doc: A comma separated list of custom stack annotations, e.g. '1,3,4,5,6,7'.
      Annotation list must be same length as sequences.
    inputBinding:
      position: 102
      prefix: --annotate
  - id: aspect_ratio
    type:
      - 'null'
      - float
    doc: Ratio of stack height to width
    default: 5.0
    inputBinding:
      position: 102
      prefix: --aspect-ratio
  - id: box
    type:
      - 'null'
      - boolean
    doc: Draw boxes around symbols?
    default: false
    inputBinding:
      position: 102
      prefix: --box
  - id: color
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify symbol colors, e.g. --color black AG 'Purine' --color red TC 
      'Pyrimidine'
    inputBinding:
      position: 102
      prefix: --color
  - id: color_scheme
    type:
      - 'null'
      - string
    doc: Specify a standard color scheme (auto, base pairing, charge, chemistry,
      classic, hydrophobicity, monochrome)
    inputBinding:
      position: 102
      prefix: --color-scheme
  - id: complement
    type:
      - 'null'
      - boolean
    doc: complement nucleic sequences
    inputBinding:
      position: 102
      prefix: --complement
  - id: composition
    type:
      - 'null'
      - string
    doc: "The expected composition of the sequences: 'auto' (default), 'equiprobable',
      'none' (do not perform any compositional adjustment), a CG percentage, a species
      name (e.g. 'E. coli', 'H. sapiens'), or an explicit distribution (e.g. \"{'A':10,
      'C':40, 'G':40, 'T':10}\"). The automatic option uses a typical distribution
      for proteins and equiprobable distribution for everything else."
    default: auto
    inputBinding:
      position: 102
      prefix: --composition
  - id: datatype
    type:
      - 'null'
      - string
    doc: Type of multiple sequence alignment or position weight matrix file
    inputBinding:
      position: 102
      prefix: --datatype
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Output additional diagnostic information. (Default: False)'
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: default_color
    type:
      - 'null'
      - string
    doc: Symbol color if not otherwise specified.
    inputBinding:
      position: 102
      prefix: --default-color
  - id: errorbar_fraction
    type:
      - 'null'
      - float
    doc: Sets error bars display proportion
    default: 0.9
    inputBinding:
      position: 102
      prefix: --errorbar-fraction
  - id: errorbar_gray
    type:
      - 'null'
      - float
    doc: Sets error bars' gray scale percentage
    default: 0.75
    inputBinding:
      position: 102
      prefix: --errorbar-gray
  - id: errorbar_width_fraction
    type:
      - 'null'
      - float
    doc: Sets error bars width display proportion
    default: 0.25
    inputBinding:
      position: 102
      prefix: --errorbar-width-fraction
  - id: errorbars
    type:
      - 'null'
      - boolean
    doc: Display error bars?
    default: true
    inputBinding:
      position: 102
      prefix: --errorbars
  - id: fin
    type:
      - 'null'
      - File
    doc: Sequence input file
    default: stdin
    inputBinding:
      position: 102
      prefix: --fin
  - id: fineprint
    type:
      - 'null'
      - string
    doc: 'The fine print (default: weblogo version)'
    inputBinding:
      position: 102
      prefix: --fineprint
  - id: first_index
    type:
      - 'null'
      - int
    doc: Index of first position in sequence data
    default: 1
    inputBinding:
      position: 102
      prefix: --first-index
  - id: fontsize
    type:
      - 'null'
      - int
    doc: Regular text font size in points
    default: 10
    inputBinding:
      position: 102
      prefix: --fontsize
  - id: format
    type:
      - 'null'
      - string
    doc: Format of output
    default: eps
    inputBinding:
      position: 102
      prefix: --format
  - id: ignore_lower_case
    type:
      - 'null'
      - boolean
    doc: Disregard lower case letters and only count upper case letters in 
      sequences.
    inputBinding:
      position: 102
      prefix: --ignore-lower-case
  - id: label
    type:
      - 'null'
      - string
    doc: A figure label, e.g. '2a'
    inputBinding:
      position: 102
      prefix: --label
  - id: logo_font
    type:
      - 'null'
      - string
    doc: Specify font for logo
    default: Arial-BoldMT
    inputBinding:
      position: 102
      prefix: --logo-font
  - id: logo_size
    type:
      - 'null'
      - string
    doc: Specify a standard logo size (small, medium (default), large)
    default: medium
    inputBinding:
      position: 102
      prefix: --size
  - id: lower_bound
    type:
      - 'null'
      - int
    doc: Lower bound of sequence to display
    inputBinding:
      position: 102
      prefix: --lower
  - id: number_fontsize
    type:
      - 'null'
      - int
    doc: Axis numbers font size in points
    default: 8
    inputBinding:
      position: 102
      prefix: --number-fontsize
  - id: number_interval
    type:
      - 'null'
      - int
    doc: Distance between numbers on X-axis
    default: 5
    inputBinding:
      position: 102
      prefix: --number-interval
  - id: port
    type:
      - 'null'
      - int
    doc: Listen to this local port.
    default: 8080
    inputBinding:
      position: 102
      prefix: --port
  - id: resolution
    type:
      - 'null'
      - int
    doc: 'Bitmap resolution in dots per inch (DPI). (Default: 96 DPI, except png_print,
      600 DPI) Low resolution bitmaps (DPI<300) are antialiased.'
    default: 96
    inputBinding:
      position: 102
      prefix: --resolution
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: reverse complement nucleic sequences
    inputBinding:
      position: 102
      prefix: --revcomp
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: reverse sequences
    inputBinding:
      position: 102
      prefix: --reverse
  - id: reverse_stacks
    type:
      - 'null'
      - boolean
    doc: Draw stacks with largest letters on top?
    default: true
    inputBinding:
      position: 102
      prefix: --reverse-stacks
  - id: rotate_numbers
    type:
      - 'null'
      - boolean
    doc: Draw X-axis numbers with vertical orientation
    default: false
    inputBinding:
      position: 102
      prefix: --rotate-numbers
  - id: scale_width
    type:
      - 'null'
      - boolean
    doc: 'Scale the visible stack width by the fraction of symbols in the column?
      (I.e. columns with many gaps of unknowns are narrow.) (Default: yes)'
    default: true
    inputBinding:
      position: 102
      prefix: --scale-width
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: "The type of sequence data: 'protein', 'rna' or 'dna'."
    inputBinding:
      position: 102
      prefix: --sequence-type
  - id: serve
    type:
      - 'null'
      - boolean
    doc: Start a standalone WebLogo server for creating sequence logos.
    inputBinding:
      position: 102
      prefix: --serve
  - id: show_ends
    type:
      - 'null'
      - boolean
    doc: Label the ends of the sequence?
    default: false
    inputBinding:
      position: 102
      prefix: --show-ends
  - id: show_xaxis
    type:
      - 'null'
      - boolean
    doc: Display sequence numbers along x-axis?
    default: true
    inputBinding:
      position: 102
      prefix: --show-xaxis
  - id: show_yaxis
    type:
      - 'null'
      - boolean
    doc: Display entropy scale along y-axis?
    default: true
    inputBinding:
      position: 102
      prefix: --show-yaxis
  - id: small_fontsize
    type:
      - 'null'
      - int
    doc: Small text font size in points
    default: 6
    inputBinding:
      position: 102
      prefix: --small-fontsize
  - id: stack_width
    type:
      - 'null'
      - float
    doc: Width of a logo stack
    default: 10.8
    inputBinding:
      position: 102
      prefix: --stack-width
  - id: stacks_per_line
    type:
      - 'null'
      - int
    doc: Maximum number of logo stacks per logo line.
    default: 40
    inputBinding:
      position: 102
      prefix: --stacks-per-line
  - id: text_font
    type:
      - 'null'
      - string
    doc: Specify font for labels
    default: ArialMT
    inputBinding:
      position: 102
      prefix: --text-font
  - id: ticmarks
    type:
      - 'null'
      - float
    doc: Distance between ticmarks
    default: 1.0
    inputBinding:
      position: 102
      prefix: --ticmarks
  - id: title
    type:
      - 'null'
      - string
    doc: Logo title text.
    inputBinding:
      position: 102
      prefix: --title
  - id: title_font
    type:
      - 'null'
      - string
    doc: Specify font for title
    default: ArialMT
    inputBinding:
      position: 102
      prefix: --title-font
  - id: title_fontsize
    type:
      - 'null'
      - int
    doc: Title text font size in points
    default: 12
    inputBinding:
      position: 102
      prefix: --title-fontsize
  - id: units
    type:
      - 'null'
      - string
    doc: A unit of entropy ('bits' (default), 'nats', 'digits'), or a unit 
      offree energy ('kT', 'kJ/mol', 'kcal/mol'), or 'probability' for 
      probabilities
    default: bits
    inputBinding:
      position: 102
      prefix: --units
  - id: upload_url
    type:
      - 'null'
      - string
    doc: Upload input file from URL
    inputBinding:
      position: 102
      prefix: --upload
  - id: upper_bound
    type:
      - 'null'
      - int
    doc: Upper bound of sequence to display
    inputBinding:
      position: 102
      prefix: --upper
  - id: weight
    type:
      - 'null'
      - float
    doc: The weight of prior data. Default depends on alphabet length
    inputBinding:
      position: 102
      prefix: --weight
  - id: xlabel
    type:
      - 'null'
      - string
    doc: X-axis label
    inputBinding:
      position: 102
      prefix: --xlabel
  - id: yaxis_height
    type:
      - 'null'
      - float
    doc: 'Height of yaxis in units. (Default: Maximum value with uninformative prior.)'
    inputBinding:
      position: 102
      prefix: --yaxis
  - id: ylabel
    type:
      - 'null'
      - string
    doc: Y-axis label (default depends on plot type and units)
    inputBinding:
      position: 102
      prefix: --ylabel
outputs:
  - id: fout
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.fout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/weblogo:3.7.9--pyhdfd78af_0
