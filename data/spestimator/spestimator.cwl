cwlVersion: v1.2
class: CommandLineTool
baseCommand: spestimator
label: spestimator
doc: "Predict bacterial TaxIDs from 16S and download genomes.\n\nTool homepage: https://github.com/erinyoung/Spestimator"
inputs:
  - id: api_key
    type:
      - 'null'
      - string
    doc: NCBI API Key (Speeds up metadata generation)
    inputBinding:
      position: 101
      prefix: --api-key
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Override path to BLAST database directory
    inputBinding:
      position: 101
      prefix: --db-dir
  - id: db_dir_new
    type:
      - 'null'
      - string
    doc: "Folder (created by the wrapper) where the BLAST database is written when update_db is used; bound to --db-dir"
    inputBinding:
      position: 101
      prefix: --db-dir
  - id: db_name
    type:
      - 'null'
      - string
    doc: 'Custom name for the database to appear in results (Default: DB filename)'
    inputBinding:
      position: 101
      prefix: --db-name
  - id: download_genomes
    type:
      - 'null'
      - string
    doc: Download found genomes. Defaults to 'genomes/' if flag is used without 
      a path.
    inputBinding:
      position: 101
      prefix: --download-genomes
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA files
    inputBinding:
      position: 101
      prefix: --input
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: 'BLAST: Hits to keep per read'
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: min_alignment_len
    type:
      - 'null'
      - int
    doc: 'Filter: Minimum Alignment Length in bp (Default: 0/No Filter)'
    inputBinding:
      position: 101
      prefix: --min-alignment-len
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: 'Filter: Minimum Query Coverage (0-100).'
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: min_hits
    type:
      - 'null'
      - int
    doc: 'Filter: Minimum reads required to report an organism. Default: 1/No Filter'
    inputBinding:
      position: 101
      prefix: --min-hits
  - id: min_identity
    type:
      - 'null'
      - float
    doc: 'Filter: Minimum Percent Identity (0-100).'
    inputBinding:
      position: 101
      prefix: --min-identity
  - id: threads
    type:
      - 'null'
      - int
    doc: BLAST threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: top_k_taxa
    type:
      - 'null'
      - int
    doc: 'Report: Only keep the top K unique organisms per file'
    inputBinding:
      position: 101
      prefix: --top-k-taxa
  - id: update_db
    type:
      - 'null'
      - boolean
    doc: Download database and generate metadata
    inputBinding:
      position: 101
      prefix: --update-db
  - id: output_path
    type: string
    doc: Output CSV file
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: db_dir_output
    type:
      - 'null'
      - Directory
    doc: Database folder written with update_db
    outputBinding:
      glob: $(inputs.db_dir_new)
  - id: genomes_output
    type:
      - 'null'
      - Directory
    doc: Folder with the downloaded genomes
    outputBinding:
      glob: $(inputs.download_genomes)
  - id: output
    type:
      - 'null'
      - File
    doc: Output CSV file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.db_dir_new || 'unused_db_dir')
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spestimator:0.3.0.233--pyhdfd78af_0
