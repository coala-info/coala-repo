cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm_plot
label: groopm_plot
doc: "Plotting tool for groopm\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: name of the database to open
    inputBinding:
      position: 1
  - id: bids
    type:
      - 'null'
      - type: array
        items: string
    doc: bin ids to plot (None for all)
    default: None
    inputBinding:
      position: 102
      prefix: --bids
  - id: cm
    type:
      - 'null'
      - string
    doc: set colormap [HSV, Accent, Blues, Spectral, Grayscale, Discrete, 
      DiscretePaired]
    default: HSV
    inputBinding:
      position: 102
      prefix: --cm
  - id: folder
    type:
      - 'null'
      - Directory
    doc: save plots in folder
    default: ''
    inputBinding:
      position: 102
      prefix: --folder
  - id: points
    type:
      - 'null'
      - boolean
    doc: ignore contig lengths when plotting
    default: false
    inputBinding:
      position: 102
      prefix: --points
  - id: tag
    type:
      - 'null'
      - string
    doc: tag to add to output filename
    default: BIN
    inputBinding:
      position: 102
      prefix: --tag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_plot.out
