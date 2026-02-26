cwlVersion: v1.2
class: CommandLineTool
baseCommand: crocodeel easy_wf
label: crocodeel_easy_wf
doc: "Detects and quantifies contamination events in metagenomic samples.\n\nTool
  homepage: https://github.com/metagenopolis/crocodeel"
inputs:
  - id: filter_low_ab
    type:
      - 'null'
      - float
    doc: 'Filter out low-abundance species that may be inaccurately quantified. In
      each sample, set the abundance of species to zero if they are up to AB_THRESHOLD_FACTOR
      times more abundant than the least abundant species. Recommended value for MetaPhlAn4:
      20'
    default: None
    inputBinding:
      position: 101
      prefix: --filter-low-ab
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of parallel processes to search contaminations
    default: 20
    inputBinding:
      position: 101
      prefix: --nproc
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
    type: File
    doc: Output TSV file listing all contamination events
    outputBinding:
      glob: $(inputs.contamination_events_file)
  - id: pdf_report_file
    type: File
    doc: Output PDF file with scatterplots for all contamination events
    outputBinding:
      glob: $(inputs.pdf_report_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crocodeel:1.1.0--pyhdfd78af_0
