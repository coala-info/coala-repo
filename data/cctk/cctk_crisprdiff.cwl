cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctk crisprdiff
label: cctk_crisprdiff
doc: "Control run behaviour\n\nTool homepage: https://github.com/Alan-Collins/CRISPR_comparison_toolkit"
inputs:
  - id: arrays_to_align
    type:
      - 'null'
      - type: array
        items: string
    doc: 'IDs of the arrays you want to analyse. Default: all'
    inputBinding:
      position: 1
  - id: approx_ordered
    type:
      - 'null'
      - boolean
    doc: array order you provided should be optimized slightly
    inputBinding:
      position: 102
      prefix: --approx-ordered
  - id: array_file
    type: File
    doc: Array_IDs.txt or Array_seqs.txt
    inputBinding:
      position: 102
      prefix: --array-file
  - id: colour_file
    type:
      - 'null'
      - File
    doc: file with custom colour list
    inputBinding:
      position: 102
      prefix: --colour-file
  - id: colour_scheme_infile
    type:
      - 'null'
      - File
    doc: input file json format colour scheme
    inputBinding:
      position: 102
      prefix: --colour-scheme-infile
  - id: connection_outline
    type:
      - 'null'
      - boolean
    doc: add outline colour to lines connecting identical spacers
    inputBinding:
      position: 102
      prefix: --connection-outline
  - id: dpi
    type:
      - 'null'
      - int
    doc: resolution of output image
    inputBinding:
      position: 102
      prefix: --dpi
  - id: font_size
    type:
      - 'null'
      - float
    doc: font size. Defualt automatically scaled.
    inputBinding:
      position: 102
      prefix: --font-size
  - id: force_colour_unique
    type:
      - 'null'
      - boolean
    doc: override black colour of unique spacers. Instead use specified colour 
      scheme
    inputBinding:
      position: 102
      prefix: --force-colour-unique
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of iterations of order determination.
    inputBinding:
      position: 102
      prefix: --iterations
  - id: line_width
    type:
      - 'null'
      - float
    doc: scale factor for lines between identical spacers
    inputBinding:
      position: 102
      prefix: --line-width
  - id: plot_height
    type:
      - 'null'
      - float
    doc: height of plot in inches.
    inputBinding:
      position: 102
      prefix: --plot-height
  - id: plot_width
    type:
      - 'null'
      - float
    doc: width of plot in inches.
    inputBinding:
      position: 102
      prefix: --plot-width
  - id: preordered
    type:
      - 'null'
      - boolean
    doc: array order you provided is the one you want plotted
    inputBinding:
      position: 102
      prefix: --preordered
  - id: seed
    type:
      - 'null'
      - int
    doc: set seed for random processes
    inputBinding:
      position: 102
      prefix: --seed
outputs:
  - id: out_file
    type: File
    doc: output plot file name and path
    outputBinding:
      glob: $(inputs.out_file)
  - id: colour_scheme_outfile
    type:
      - 'null'
      - File
    doc: output file to store json format colour schemes
    outputBinding:
      glob: $(inputs.colour_scheme_outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
