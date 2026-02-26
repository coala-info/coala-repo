cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - groopm
  - flyover
label: groopm_flyover
doc: "Visualize the contig binning process.\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
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
    doc: bin ids to concentrate on (None for all)
    default: None
    inputBinding:
      position: 102
      prefix: --bids
  - id: colorbar
    type:
      - 'null'
      - boolean
    doc: show the colorbar
    default: false
    inputBinding:
      position: 102
      prefix: --colorbar
  - id: cutoff
    type:
      - 'null'
      - int
    doc: cutoff contig size
    default: 1000
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: first_fade
    type:
      - 'null'
      - float
    doc: what percentage of the movie is devoted to the unbinned contigs
    default: 0.05
    inputBinding:
      position: 102
      prefix: --firstFade
  - id: format
    type:
      - 'null'
      - string
    doc: file format output images
    default: jpeg
    inputBinding:
      position: 102
      prefix: --format
  - id: fps
    type:
      - 'null'
      - int
    doc: frames per second
    default: 10
    inputBinding:
      position: 102
      prefix: --fps
  - id: points
    type:
      - 'null'
      - boolean
    doc: ignore contig lengths when plotting
    default: false
    inputBinding:
      position: 102
      prefix: --points
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix to append to start of output files
    default: file
    inputBinding:
      position: 102
      prefix: --prefix
  - id: title
    type:
      - 'null'
      - string
    doc: title to add to output images
    default: ''
    inputBinding:
      position: 102
      prefix: --title
  - id: total_time
    type:
      - 'null'
      - float
    doc: how long the movie should go for (seconds)
    default: 120.0
    inputBinding:
      position: 102
      prefix: --totalTime
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_flyover.out
