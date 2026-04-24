cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem condense
label: singlem_condense
doc: "Combine OTU tables across different markers into a single taxonomic profile.\n\
  \nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: input_archive_otu_table_list
    type:
      - 'null'
      - File
    doc: Condense from the archive tables newline separated in this file
    inputBinding:
      position: 101
      prefix: --input-archive-otu-table-list
  - id: input_archive_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: Condense from these archive tables
    inputBinding:
      position: 101
      prefix: --input-archive-otu-tables
  - id: input_gzip_archive_otu_table_list
    type:
      - 'null'
      - File
    doc: Condense from the gzip'd archive tables newline separated in this file
    inputBinding:
      position: 101
      prefix: --input-gzip-archive-otu-table-list
  - id: metapackage
    type:
      - 'null'
      - string
    doc: Set of SingleM packages to use
    inputBinding:
      position: 101
      prefix: --metapackage
  - id: min_taxon_coverage
    type:
      - 'null'
      - float
    doc: Set taxons with less coverage to coverage=0.
    inputBinding:
      position: 101
      prefix: --min-taxon-coverage
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: trim_percent
    type:
      - 'null'
      - int
    doc: percentage of markers to be trimmed for each taxonomy
    inputBinding:
      position: 101
      prefix: --trim-percent
outputs:
  - id: taxonomic_profile
    type: File
    doc: output OTU table
    outputBinding:
      glob: $(inputs.taxonomic_profile)
  - id: taxonomic_profile_krona
    type:
      - 'null'
      - File
    doc: name of krona file to generate.
    outputBinding:
      glob: $(inputs.taxonomic_profile_krona)
  - id: output_after_em_otu_table
    type:
      - 'null'
      - File
    doc: output OTU table after expectation maximisation has been applied. Note 
      that this table usually contains multiple rows with the same window 
      sequence.
    outputBinding:
      glob: $(inputs.output_after_em_otu_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
