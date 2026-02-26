cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicstuff_filter
label: hicstuff_filter
doc: "Filters spurious 3C events such as loops and uncuts from the library based on
  a minimum distance threshold automatically estimated from the library by default.
  Can also plot 3C library statistics.\n\nTool homepage: https://github.com/koszullab/hicstuff"
inputs:
  - id: input
    type: File
    doc: 2D BED file containing coordinates of Hi-C interacting pairs, the index
      of their restriction fragment and their strands.
    inputBinding:
      position: 1
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Interactively shows plots and asks for thresholds.
    inputBinding:
      position: 102
      prefix: --interactive
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Shows plots of library composition and 3C events abundance.
    inputBinding:
      position: 102
      prefix: --plot
  - id: prefix
    type:
      - 'null'
      - string
    doc: If the library has a name, it will be shown on the figures.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: thresholds
    type:
      - 'null'
      - string
    doc: Manually defines integer values for the thresholds in the order [uncut,
      loop]. Reads above those values are kept.
    inputBinding:
      position: 102
      prefix: --thresholds
outputs:
  - id: output
    type: File
    doc: Path to the filtered file, in the same format as the input.
    outputBinding:
      glob: '*.out'
  - id: figdir
    type:
      - 'null'
      - Directory
    doc: Path to the output figure directory. By default, the figure is only 
      shown but not saved.
    outputBinding:
      glob: $(inputs.figdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0
