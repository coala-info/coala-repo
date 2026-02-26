cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja_dash
label: freyja_dash
doc: "Generate an interactive dashboard from Freyja results.\n\nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: agg_results
    type: File
    doc: Aggregated results file from Freyja
    inputBinding:
      position: 1
  - id: metadata
    type: File
    doc: Metadata file
    inputBinding:
      position: 2
  - id: title
    type: string
    doc: Title for the dashboard
    inputBinding:
      position: 3
  - id: intro
    type: string
    doc: Introductory text for the dashboard
    inputBinding:
      position: 4
  - id: body_color
    type:
      - 'null'
      - string
    doc: color of body
    default: '#ffffff'
    inputBinding:
      position: 105
      prefix: --bodyColor
  - id: config
    type:
      - 'null'
      - string
    doc: control the colors and grouping of lineages in the plot
    inputBinding:
      position: 105
      prefix: --config
  - id: days
    type:
      - 'null'
      - int
    doc: specify number of days for growth calculation
    default: 56
    inputBinding:
      position: 105
      prefix: --days
  - id: grthresh
    type:
      - 'null'
      - float
    doc: minimum prevalence to calculate relative growth rate for
    default: 0.001
    inputBinding:
      position: 105
      prefix: --grthresh
  - id: header_color
    type:
      - 'null'
      - string
    doc: color of header
    default: '#2fdcf5'
    inputBinding:
      position: 105
      prefix: --headerColor
  - id: keep_plot_files
    type:
      - 'null'
      - boolean
    doc: keep the intermediate html for the core plot
    inputBinding:
      position: 105
      prefix: --keep_plot_files
  - id: lineageyml
    type:
      - 'null'
      - File
    doc: custom lineage hierarchy file
    default: ''
    inputBinding:
      position: 105
      prefix: --lineageyml
  - id: mincov
    type:
      - 'null'
      - float
    doc: min genome coverage included
    default: 60.0
    inputBinding:
      position: 105
      prefix: --mincov
  - id: nboots
    type:
      - 'null'
      - int
    doc: Number of Bootstrap iterations
    default: 1000
    inputBinding:
      position: 105
      prefix: --nboots
  - id: pathogen
    type:
      - 'null'
      - string
    doc: Pathogen of interest.Not used if using --lineageyml option.
    default: SARS-CoV-2
    inputBinding:
      position: 105
      prefix: --pathogen
  - id: scale_by_viral_load
    type:
      - 'null'
      - boolean
    doc: scale by viral load
    inputBinding:
      position: 105
      prefix: --scale_by_viral_load
  - id: serial_interval
    type:
      - 'null'
      - float
    doc: Serial Interval
    default: 5.5
    inputBinding:
      position: 105
      prefix: --serial_interval
  - id: thresh
    type:
      - 'null'
      - float
    doc: minimum lineage abundance
    default: 0.01
    inputBinding:
      position: 105
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
