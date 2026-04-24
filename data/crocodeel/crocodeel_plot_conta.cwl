cwlVersion: v1.2
class: CommandLineTool
baseCommand: crocodeel plot_conta
label: crocodeel_plot_conta
doc: "Generate scatterplots for contamination events.\n\nTool homepage: https://github.com/metagenopolis/crocodeel"
inputs:
  - id: color_conta_species
    type:
      - 'null'
      - boolean
    doc: Use a different color for species introduced by contamination
    inputBinding:
      position: 101
      prefix: --color-conta-species
  - id: contamination_events_file
    type: File
    doc: Input TSV file listing all contaminations events.
    inputBinding:
      position: 101
      prefix: -c
  - id: filter_low_ab
    type:
      - 'null'
      - float
    doc: 'Filter out low-abundance species that may be inaccurately quantified. In
      each sample, set the abundance of species to zero if they are up to AB_THRESHOLD_FACTOR
      times more abundant than the least abundant species. Recommended value for MetaPhlAn4:
      20 (default: None)'
    inputBinding:
      position: 101
      prefix: --filter-low-ab
  - id: ncol
    type:
      - 'null'
      - int
    doc: Number of scatterplots to draw horizontally on each page
    inputBinding:
      position: 101
      prefix: --ncol
  - id: no_conta_line
    type:
      - 'null'
      - boolean
    doc: Do not show contamination line in scatterplots
    inputBinding:
      position: 101
      prefix: --no-conta-line
  - id: nrow
    type:
      - 'null'
      - int
    doc: Number of scatterplots to draw vertically on each page
    inputBinding:
      position: 101
      prefix: --nrow
  - id: species_abundance_table
    type: File
    doc: Input TSV file corresponding to the species abundance table
    inputBinding:
      position: 101
      prefix: -s
  - id: species_abundance_table_2
    type:
      - 'null'
      - File
    doc: Optional input TSV file corresponding to another species abundance 
      table. If provided, samples from this table will be considered as 
      contamination targets while those from the first table as contamination 
      sources.
    inputBinding:
      position: 101
      prefix: -s2
outputs:
  - id: pdf_report_file
    type: File
    doc: Output PDF file with scatterplots for all contamination events
    outputBinding:
      glob: $(inputs.pdf_report_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crocodeel:1.1.0--pyhdfd78af_0
