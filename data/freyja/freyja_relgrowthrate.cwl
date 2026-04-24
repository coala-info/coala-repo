cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja_relgrowthrate
label: freyja_relgrowthrate
doc: "Calculates relative growth rates for each lineage using AGG_RESULTS and METADATA\n\
  \nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: agg_results
    type: string
    doc: AGG_RESULTS
    inputBinding:
      position: 1
  - id: metadata
    type: string
    doc: METADATA
    inputBinding:
      position: 2
  - id: config
    type:
      - 'null'
      - string
    doc: control the colors and grouping of lineages in the plot
    inputBinding:
      position: 103
      prefix: --config
  - id: days
    type:
      - 'null'
      - int
    doc: number of days for growth calculation
    inputBinding:
      position: 103
      prefix: --days
  - id: grthresh
    type:
      - 'null'
      - float
    doc: minimum prevalence to calculate relative growth rate for
    inputBinding:
      position: 103
      prefix: --grthresh
  - id: lineageyml
    type:
      - 'null'
      - string
    doc: lineage hierarchy file
    inputBinding:
      position: 103
      prefix: --lineageyml
  - id: mincov
    type:
      - 'null'
      - float
    doc: min genome coverage included
    inputBinding:
      position: 103
      prefix: --mincov
  - id: nboots
    type:
      - 'null'
      - int
    doc: Number of Bootstrap iterations
    inputBinding:
      position: 103
      prefix: --nboots
  - id: pathogen
    type:
      - 'null'
      - string
    doc: Pathogen of interest.Not used if using --lineageyml option.
    inputBinding:
      position: 103
      prefix: --pathogen
  - id: scale_by_viral_load
    type:
      - 'null'
      - boolean
    doc: scale by viral load
    inputBinding:
      position: 103
      prefix: --scale_by_viral_load
  - id: serial_interval
    type:
      - 'null'
      - float
    doc: Serial Interval
    inputBinding:
      position: 103
      prefix: --serial_interval
  - id: thresh
    type:
      - 'null'
      - float
    doc: min lineage abundance in plot
    inputBinding:
      position: 103
      prefix: --thresh
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output html file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
