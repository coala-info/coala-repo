cwlVersion: v1.2
class: CommandLineTool
baseCommand: groopm explore
label: groopm_explore
doc: "Exploration mode [binpoints, binids, allcontigs, unbinnedcontigs, binnedcontigs,
  binassignments, compare, sidebyside, together]\n\nTool homepage: https://ecogenomics.github.io/GroopM/"
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
  - id: cutoff
    type:
      - 'null'
      - int
    doc: cutoff contig size
    default: 1000
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: kmers
    type:
      - 'null'
      - boolean
    doc: include kmers in figure [only used when mode == together]
    default: false
    inputBinding:
      position: 102
      prefix: --kmers
  - id: mode
    type:
      - 'null'
      - string
    doc: Exploration mode [binpoints, binids, allcontigs, unbinnedcontigs, 
      binnedcontigs, binassignments, compare, sidebyside, together]
    default: binids
    inputBinding:
      position: 102
      prefix: --mode
  - id: no_transform
    type:
      - 'null'
      - boolean
    doc: skip data transformation (3 stoits only)
    default: false
    inputBinding:
      position: 102
      prefix: --no_transform
  - id: points
    type:
      - 'null'
      - boolean
    doc: ignore contig lengths when plotting
    default: false
    inputBinding:
      position: 102
      prefix: --points
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groopm:0.3.4--pyhdfd78af_2
stdout: groopm_explore.out
