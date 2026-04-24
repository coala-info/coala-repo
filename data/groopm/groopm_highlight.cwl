cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm highlight
label: groopm_highlight
doc: "Highlight contigs in a groopm database.\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
inputs:
  - id: dbname
    type: string
    doc: name of the database to open
    inputBinding:
      position: 1
  - id: azimuth
    type:
      - 'null'
      - float
    doc: azimuth in printed image
    inputBinding:
      position: 102
      prefix: --azimuth
  - id: bids
    type:
      - 'null'
      - type: array
        items: string
    doc: bin ids to plot (None for all)
    inputBinding:
      position: 102
      prefix: --bids
  - id: binlabels
    type:
      - 'null'
      - string
    doc: replace bin IDs with user specified labels (use 'none' to force no 
      labels)
    inputBinding:
      position: 102
      prefix: --binlabels
  - id: contigcolors
    type:
      - 'null'
      - string
    doc: specify contig colors
    inputBinding:
      position: 102
      prefix: --contigcolors
  - id: cutoff
    type:
      - 'null'
      - int
    doc: cutoff contig size
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: dpi
    type:
      - 'null'
      - int
    doc: Image resolution
    inputBinding:
      position: 102
      prefix: --dpi
  - id: elevation
    type:
      - 'null'
      - float
    doc: elevation in printed image
    inputBinding:
      position: 102
      prefix: --elevation
  - id: file
    type:
      - 'null'
      - File
    doc: name of image file to produce
    inputBinding:
      position: 102
      prefix: --file
  - id: filetype
    type:
      - 'null'
      - string
    doc: Type of file to produce
    inputBinding:
      position: 102
      prefix: --filetype
  - id: place
    type:
      - 'null'
      - boolean
    doc: use this to help work out azimuth/elevation parameters
    inputBinding:
      position: 102
      prefix: --place
  - id: points
    type:
      - 'null'
      - boolean
    doc: ignore contig lengths when plotting
    inputBinding:
      position: 102
      prefix: --points
  - id: radius
    type:
      - 'null'
      - boolean
    doc: draw placement radius to help with label moving
    inputBinding:
      position: 102
      prefix: --radius
  - id: show
    type:
      - 'null'
      - boolean
    doc: load image in viewer only
    inputBinding:
      position: 102
      prefix: --show
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_highlight.out
