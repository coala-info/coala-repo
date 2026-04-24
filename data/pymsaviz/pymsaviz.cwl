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
    inputBinding:
      position: 101
      prefix: --color_scheme
  - id: consensus_color
    type:
      - 'null'
      - string
    doc: Consensus identity bar color
    inputBinding:
      position: 101
      prefix: --consensus_color
  - id: consensus_size
    type:
      - 'null'
      - float
    doc: Consensus identity bar height size
    inputBinding:
      position: 101
      prefix: --consensus_size
  - id: dpi
    type:
      - 'null'
      - int
    doc: Figure DPI
    inputBinding:
      position: 101
      prefix: --dpi
  - id: end
    type:
      - 'null'
      - string
    doc: End position of MSA visualization
    inputBinding:
      position: 101
      prefix: --end
  - id: format
    type:
      - 'null'
      - string
    doc: MSA file format
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
    inputBinding:
      position: 101
      prefix: --label_type
  - id: show_consensus
    type:
      - 'null'
      - boolean
    doc: Show consensus sequence
    inputBinding:
      position: 101
      prefix: --show_consensus
  - id: show_count
    type:
      - 'null'
      - boolean
    doc: Show seq char count without gap on right side
    inputBinding:
      position: 101
      prefix: --show_count
  - id: show_grid
    type:
      - 'null'
      - boolean
    doc: Show grid
    inputBinding:
      position: 101
      prefix: --show_grid
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort MSA order by NJ tree constructed from MSA distance matrix
    inputBinding:
      position: 101
      prefix: --sort
  - id: start
    type:
      - 'null'
      - int
    doc: Start position of MSA visualization
    inputBinding:
      position: 101
      prefix: --start
  - id: wrap_length
    type:
      - 'null'
      - string
    doc: Wrap length
    inputBinding:
      position: 101
      prefix: --wrap_length
  - id: wrap_space_size
    type:
      - 'null'
      - float
    doc: Space size between wrap MSA plot area
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
