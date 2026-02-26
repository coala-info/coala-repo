cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymsaviz
label: pymsaviz
doc: "MSA(Multiple Sequence Alignment) visualization CLI tool\n\nTool homepage: https://moshi4.github.io/pyMSAviz/"
inputs:
  - id: color_scheme
    type:
      - 'null'
      - string
    doc: Color scheme
    default: Zappo
    inputBinding:
      position: 101
      prefix: --color_scheme
  - id: consensus_color
    type:
      - 'null'
      - string
    doc: Consensus identity bar color
    default: '#1f77b4'
    inputBinding:
      position: 101
      prefix: --consensus_color
  - id: consensus_size
    type:
      - 'null'
      - float
    doc: Consensus identity bar height size
    default: 2.0
    inputBinding:
      position: 101
      prefix: --consensus_size
  - id: dpi
    type:
      - 'null'
      - int
    doc: Figure DPI
    default: 300
    inputBinding:
      position: 101
      prefix: --dpi
  - id: end
    type:
      - 'null'
      - string
    doc: End position of MSA visualization
    default: MSA Length
    inputBinding:
      position: 101
      prefix: --end
  - id: format
    type:
      - 'null'
      - string
    doc: MSA file format
    default: fasta
    inputBinding:
      position: 101
      prefix: --format
  - id: infile
    type: File
    doc: Input MSA file
    inputBinding:
      position: 101
      prefix: --infile
  - id: label_type
    type:
      - 'null'
      - string
    doc: Label type ('id'[default]|'description')
    default: id
    inputBinding:
      position: 101
      prefix: --label_type
  - id: show_consensus
    type:
      - 'null'
      - boolean
    doc: Show consensus sequence
    default: false
    inputBinding:
      position: 101
      prefix: --show_consensus
  - id: show_count
    type:
      - 'null'
      - boolean
    doc: Show seq char count without gap on right side
    default: false
    inputBinding:
      position: 101
      prefix: --show_count
  - id: show_grid
    type:
      - 'null'
      - boolean
    doc: Show grid
    default: false
    inputBinding:
      position: 101
      prefix: --show_grid
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort MSA order by NJ tree constructed from MSA distance matrix
    default: false
    inputBinding:
      position: 101
      prefix: --sort
  - id: start
    type:
      - 'null'
      - int
    doc: Start position of MSA visualization
    default: 1
    inputBinding:
      position: 101
      prefix: --start
  - id: wrap_length
    type:
      - 'null'
      - string
    doc: Wrap length
    default: None
    inputBinding:
      position: 101
      prefix: --wrap_length
  - id: wrap_space_size
    type:
      - 'null'
      - float
    doc: Space size between wrap MSA plot area
    default: 3.0
    inputBinding:
      position: 101
      prefix: --wrap_space_size
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output MSA visualization file (*.png|*.jpg|*.svg|*.pdf)
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymsaviz:0.5.0--pyhdfd78af_0
