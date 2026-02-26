cwlVersion: v1.2
class: CommandLineTool
baseCommand: refseq-plasmid-dl
label: refseq-plasmid-dl
doc: "Download, curate, and filter plasmid sequences from the NCBI RefSeq database.\n\
  \nTool homepage: https://github.com/erinyoung/refseq-plasmid-dl"
inputs:
  - id: dev_mode
    type:
      - 'null'
      - boolean
    doc: 'Enables development mode: fetches only a single test file group.'
    inputBinding:
      position: 101
      prefix: --dev-mode
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force re-download of files even if they already exist locally.
    inputBinding:
      position: 101
      prefix: --force
  - id: geo_loc_name
    type:
      - 'null'
      - string
    doc: Filter by Geographic Location Name (substring match).
    inputBinding:
      position: 101
      prefix: --geo_loc_name
  - id: host
    type:
      - 'null'
      - string
    doc: Filter by Host (substring match, e.g. "Homo sapiens").
    inputBinding:
      position: 101
      prefix: --host
  - id: indir
    type:
      - 'null'
      - Directory
    doc: Directory where FASTA and GBFF files have already been downloaded. If 
      provided, skips the download step.
    inputBinding:
      position: 101
      prefix: --indir
  - id: isolate
    type:
      - 'null'
      - string
    doc: Filter by Isolate (substring match).
    inputBinding:
      position: 101
      prefix: --isolate
  - id: isolation_source
    type:
      - 'null'
      - string
    doc: Filter by Isolation Source (substring match).
    inputBinding:
      position: 101
      prefix: --isolation_source
  - id: max_collection_date
    type:
      - 'null'
      - string
    doc: Include only records collected before YYYY-MM-DD.
    inputBinding:
      position: 101
      prefix: --max-collection-date
  - id: max_date
    type:
      - 'null'
      - string
    doc: Include only records updated before YYYY-MM-DD.
    inputBinding:
      position: 101
      prefix: --max-date
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum sequence length (bp).
    inputBinding:
      position: 101
      prefix: --max-length
  - id: min_collection_date
    type:
      - 'null'
      - string
    doc: Include only records collected after YYYY-MM-DD.
    inputBinding:
      position: 101
      prefix: --min-collection-date
  - id: min_date
    type:
      - 'null'
      - string
    doc: Include only records updated after YYYY-MM-DD.
    inputBinding:
      position: 101
      prefix: --min-date
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length (bp).
    inputBinding:
      position: 101
      prefix: --min-length
  - id: organism
    type:
      - 'null'
      - string
    doc: 'Filter by species/organism (e.g. "Salmonella"). Case-insensitive substring
      match. Default: all'
    inputBinding:
      position: 101
      prefix: --organism
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to save FASTA files, reports, and final multi-FASTA
    default: refseq_plasmids
    inputBinding:
      position: 101
      prefix: --outdir
  - id: plasmid_name
    type:
      - 'null'
      - string
    doc: Filter by Plasmid Name (substring match).
    inputBinding:
      position: 101
      prefix: --plasmid-name
  - id: strain
    type:
      - 'null'
      - string
    doc: Filter by Strain (substring match).
    inputBinding:
      position: 101
      prefix: --strain
  - id: taxid
    type:
      - 'null'
      - string
    doc: 'Filter by NCBI Taxonomy ID (e.g. "28901"). Default: all'
    inputBinding:
      position: 101
      prefix: --taxid
  - id: topology
    type:
      - 'null'
      - string
    doc: Filter by topology (circular or linear).
    default: circular
    inputBinding:
      position: 101
      prefix: --topology
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refseq-plasmid-dl:0.1.0--pyhdfd78af_0
stdout: refseq-plasmid-dl.out
