cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crocodeel
  - search_conta
label: crocodeel_search_conta
doc: "Search for contamination events\n\nTool homepage: https://github.com/metagenopolis/crocodeel"
inputs:
  - id: filter_low_ab
    type:
      - 'null'
      - float
    doc: 'Filter out low-abundance species that may be inaccurately quantified. In
      each sample, set the abundance of species to zero if they are up to AB_THRESHOLD_FACTOR
      times more abundant than the least abundant species. Recommended value for MetaPhlAn4:
      20'
    inputBinding:
      position: 101
      prefix: --filter-low-ab
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of parallel processes to search contaminations
    inputBinding:
      position: 101
      prefix: --nproc
  - id: probability_cutoff
    type:
      - 'null'
      - float
    doc: Only report contamination events with a probability greater than 
      PROBABILITY_CUTOFF
    inputBinding:
      position: 101
      prefix: --probability-cutoff
  - id: rate_cutoff
    type:
      - 'null'
      - float
    doc: Only report events with a contamination rate greater than RATE_CUTOFF
    inputBinding:
      position: 101
      prefix: --rate-cutoff
  - id: rf_model_file
    type:
      - 'null'
      - File
    doc: Joblib file containing the pre-trained Random Forest model used to 
      detect contamination events
      /usr/local/lib/python3.14/site-packages/crocodeel/models/crocodeel_rf_Feb2026.joblib
    inputBinding:
      position: 101
      prefix: -m
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
  - id: contamination_events_file
    type:
      - 'null'
      - File
    doc: Output TSV file listing all contamination events
    outputBinding:
      glob: $(inputs.contamination_events_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crocodeel:1.1.0--pyhdfd78af_0
