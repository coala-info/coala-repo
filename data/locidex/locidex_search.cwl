cwlVersion: v1.2
class: CommandLineTool
baseCommand: locidex_search
label: locidex_search
doc: "Query set of Loci/Genes against a database to produce a sequence store for downstream
  processing\n\nTool homepage: https://pypi.org/project/locidex/"
inputs:
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Perform annotation on unannotated input fasta
    inputBinding:
      position: 101
      prefix: --annotate
  - id: config
    type:
      - 'null'
      - File
    doc: Locidex parameter config file (json)
    inputBinding:
      position: 101
      prefix: --config
  - id: db
    type:
      - 'null'
      - Directory
    doc: Locidex database directory
    inputBinding:
      position: 101
      prefix: --db
  - id: db_group
    type:
      - 'null'
      - Directory
    doc: A directory of databases containing a manifest file. Requires the 
      db_name option to be set to select the correct db
    inputBinding:
      position: 101
      prefix: --db_group
  - id: db_name
    type:
      - 'null'
      - string
    doc: Name of database to perform search, used when a manifest is specified 
      as a db
    inputBinding:
      position: 101
      prefix: --db_name
  - id: db_version
    type:
      - 'null'
      - string
    doc: Version of database to perform search, used when a manifest is 
      specified as a db
    inputBinding:
      position: 101
      prefix: --db_version
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing directory
    inputBinding:
      position: 101
      prefix: --force
  - id: format
    type:
      - 'null'
      - string
    doc: Format of query file [genbank,fasta]
    default: genbank,fasta
    inputBinding:
      position: 101
      prefix: --format
  - id: max_aa_len
    type:
      - 'null'
      - int
    doc: Global maximum query length aa
    inputBinding:
      position: 101
      prefix: --max_aa_len
  - id: max_dna_len
    type:
      - 'null'
      - int
    doc: Global maximum query length dna
    inputBinding:
      position: 101
      prefix: --max_dna_len
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of hit seqs per query
    inputBinding:
      position: 101
      prefix: --max_target_seqs
  - id: min_aa_ident
    type:
      - 'null'
      - float
    doc: Global minumum AA percent identity required for match
    inputBinding:
      position: 101
      prefix: --min_aa_ident
  - id: min_aa_len
    type:
      - 'null'
      - int
    doc: Global minumum query length aa
    inputBinding:
      position: 101
      prefix: --min_aa_len
  - id: min_aa_match_cov
    type:
      - 'null'
      - float
    doc: Global minumum AA percent hit coverage identity required for match
    inputBinding:
      position: 101
      prefix: --min_aa_match_cov
  - id: min_dna_ident
    type:
      - 'null'
      - float
    doc: Global minumum DNA percent identity required for match
    inputBinding:
      position: 101
      prefix: --min_dna_ident
  - id: min_dna_len
    type:
      - 'null'
      - int
    doc: Global minumum query length dna
    inputBinding:
      position: 101
      prefix: --min_dna_len
  - id: min_dna_match_cov
    type:
      - 'null'
      - float
    doc: Global minumum DNA percent hit coverage identity required for match
    inputBinding:
      position: 101
      prefix: --min_dna_match_cov
  - id: min_evalue
    type:
      - 'null'
      - float
    doc: Minumum evalue required for match
    inputBinding:
      position: 101
      prefix: --min_evalue
  - id: n_threads
    type:
      - 'null'
      - int
    doc: CPU Threads to use
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: name
    type:
      - 'null'
      - string
    doc: Sample name to include default=filename
    default: filename
    inputBinding:
      position: 101
      prefix: --name
  - id: override
    type:
      - 'null'
      - boolean
    doc: Overwrite individual loci thresholds for filtering and use the global 
      parameters
    inputBinding:
      position: 101
      prefix: --override
  - id: query
    type: File
    doc: Query sequence file
    inputBinding:
      position: 101
      prefix: --query
  - id: translation_table
    type:
      - 'null'
      - string
    doc: Table to use for translation
    inputBinding:
      position: 101
      prefix: --translation_table
outputs:
  - id: outdir
    type: Directory
    doc: Output directory to put results
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
