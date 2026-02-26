cwlVersion: v1.2
class: CommandLineTool
baseCommand: locidex_extract
label: locidex_extract
doc: "Extract loci from a genome based on a locidex database\n\nTool homepage: https://pypi.org/project/locidex/"
inputs:
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
    default: genbank
    inputBinding:
      position: 101
      prefix: --format
  - id: in_fasta
    type: File
    doc: Query assembly sequence file (fasta)
    inputBinding:
      position: 101
      prefix: --in_fasta
  - id: keep_truncated
    type:
      - 'null'
      - boolean
    doc: Keep sequences where match is broken at the end of a sequence
    inputBinding:
      position: 101
      prefix: --keep_truncated
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
  - id: mode
    type:
      - 'null'
      - string
    doc: Select from the options provided
    inputBinding:
      position: 101
      prefix: --mode
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
    inputBinding:
      position: 101
      prefix: --name
  - id: protein_coding
    type:
      - 'null'
      - string
    doc: output directory
    inputBinding:
      position: 101
      prefix: --protein_coding
  - id: translation_table
    type:
      - 'null'
      - string
    doc: output directory
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
