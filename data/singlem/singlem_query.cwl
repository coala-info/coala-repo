cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem query
label: singlem_query
doc: "Find closely related sequences in a SingleM database.\n\nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: continue_on_missing_genes
    type:
      - 'null'
      - boolean
    doc: Continue if a gene is missing from the DB. Only works with 
      smafa/nuclotide search method.
    inputBinding:
      position: 101
      prefix: --continue-on-missing-genes
  - id: db
    type: string
    doc: Output from 'makedb' mode
    inputBinding:
      position: 101
      prefix: --db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Print all OTUs in the DB
    inputBinding:
      position: 101
      prefix: --dump
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
  - id: limit_per_sequence
    type:
      - 'null'
      - string
    doc: How many entries (samples/genomes from DB with identical sequences) to 
      report for each distinct, matched sequence (arbitrarily chosen)
    inputBinding:
      position: 101
      prefix: --limit-per-sequence
  - id: max_divergence
    type:
      - 'null'
      - int
    doc: Report sequences less than or equal to this divergence i.e. number of 
      different bases/amino acids
    inputBinding:
      position: 101
      prefix: --max-divergence
  - id: max_nearest_neighbours
    type:
      - 'null'
      - int
    doc: How many nearest neighbours to report. Each neighbour is a distinct 
      sequence from the DB.
    inputBinding:
      position: 101
      prefix: --max-nearest-neighbours
  - id: max_search_nearest_neighbours
    type:
      - 'null'
      - int
    doc: How many nearest neighbours to search for with approximate nearest 
      neighbours. Of these hits, only --max-nearest-neighbours will actually be 
      reported. Ignored for --search-method naive and scann-naive.
    inputBinding:
      position: 101
      prefix: --max-search-nearest-neighbours
  - id: preload_db
    type:
      - 'null'
      - boolean
    doc: Cache all DB data in python-land instead of querying for it by SQL each
      time. This is faster particularly for querying many sequences, but uses 
      more memory and has a larger start-up time for each marker gene.
    inputBinding:
      position: 101
      prefix: --preload-db
  - id: query_archive_otu_table_list
    type:
      - 'null'
      - File
    doc: Query the database with all sequences in archive tables newline 
      separated in this file
    inputBinding:
      position: 101
      prefix: --query-archive-otu-table-list
  - id: query_archive_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: Query the database with all sequences in these archive tables
    inputBinding:
      position: 101
      prefix: --query-archive-otu-tables
  - id: query_gzip_archive_otu_table_list
    type:
      - 'null'
      - File
    doc: Query the database with all sequences in gzip'd archive tables newline 
      separated in this file
    inputBinding:
      position: 101
      prefix: --query-gzip-archive-otu-table-list
  - id: query_otu_table
    type:
      - 'null'
      - type: array
        items: File
    doc: Query the database with all sequences in this OTU table
    inputBinding:
      position: 101
      prefix: --query-otu-table
  - id: query_otu_tables
    type:
      - 'null'
      - type: array
        items: File
    doc: Query the database with all sequences in this OTU table
    inputBinding:
      position: 101
      prefix: --query-otu-tables
  - id: query_otu_tables_list
    type:
      - 'null'
      - File
    doc: Query the database with all sequences in OTU table files newline 
      separated in this file
    inputBinding:
      position: 101
      prefix: --query-otu-tables-list
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sample_list
    type:
      - 'null'
      - File
    doc: Print all OTUs from the samples listed in the file (newline-separated)
    inputBinding:
      position: 101
      prefix: --sample-list
  - id: sample_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Print all OTUs from these samples
    inputBinding:
      position: 101
      prefix: --sample-names
  - id: search_method
    type:
      - 'null'
      - string
    doc: Algorithm to perform search
    inputBinding:
      position: 101
      prefix: --search-method
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: Which sequence types to compare (i.e. protein for blastp, nucleotide 
      for blastn)
    inputBinding:
      position: 101
      prefix: --sequence-type
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: Print all OTUs assigned a taxonomy including this string e.g. 'Archaea'
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: threads
    type:
      - 'null'
      - int
    doc: Use this many threads where possible
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
stdout: singlem_query.out
