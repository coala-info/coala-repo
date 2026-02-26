cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja_plot
label: freyja_plot
doc: "Create plot from AGG_RESULTS\n\nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: agg_results
    type: string
    doc: AGG_RESULTS
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - string
    doc: allows users to control the colors and grouping of lineages in the plot
    inputBinding:
      position: 102
      prefix: --config
  - id: interval
    type:
      - 'null'
      - string
    doc: define whether the intervals are calculated daily D or monthly M use 
      with --windowsize
    default: MS
    inputBinding:
      position: 102
      prefix: --interval
  - id: lineages
    type:
      - 'null'
      - boolean
    doc: modify lineage breakdown
    inputBinding:
      position: 102
      prefix: --lineages
  - id: lineageyml
    type:
      - 'null'
      - string
    doc: Custom lineage hierarchy file
    default: ''
    inputBinding:
      position: 102
      prefix: --lineageyml
  - id: mincov
    type:
      - 'null'
      - float
    doc: min genome coverage included
    default: 60.0
    inputBinding:
      position: 102
      prefix: --mincov
  - id: pathogen
    type:
      - 'null'
      - string
    doc: Pathogen of interest.Not used if using --lineageyml option.
    default: SARS-CoV-2
    inputBinding:
      position: 102
      prefix: --pathogen
  - id: thresh
    type:
      - 'null'
      - float
    doc: pass a minimum lineage abundance
    default: 0.01
    inputBinding:
      position: 102
      prefix: --thresh
  - id: times
    type:
      - 'null'
      - string
    doc: provide sample collection information,check data/times_metadata.csv for
      additional information
    default: ''
    inputBinding:
      position: 102
      prefix: --times
  - id: windowsize
    type:
      - 'null'
      - int
    doc: width of the rolling average windowfor interval calculation
    default: 14
    inputBinding:
      position: 102
      prefix: --windowsize
  - id: writegrouped
    type:
      - 'null'
      - string
    doc: path to write grouped lineage data
    default: ''
    inputBinding:
      position: 102
      prefix: --writegrouped
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: specify output file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
