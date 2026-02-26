cwlVersion: v1.2
class: CommandLineTool
baseCommand: omamer_search
label: omamer_search
doc: "Search for protein sequences, given in FASTA format, against an existing database.\n\
  \nTool homepage: https://github.com/DessimozLab/omamer"
inputs:
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Number of queries to process at once.
    default: 10000
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: db
    type: File
    doc: Path to existing database (including filename).
    inputBinding:
      position: 101
      prefix: --db
  - id: family_alpha
    type:
      - 'null'
      - float
    doc: Significance threshold used when filtering families.
    default: '1e-06'
    inputBinding:
      position: 101
      prefix: --family_alpha
  - id: family_only
    type:
      - 'null'
      - boolean
    doc: 'Set to only place at family level. Note: subfamily_medianseqlen in results
      is for the family level.'
    default: false
    inputBinding:
      position: 101
      prefix: --family_only
  - id: include_extant_genes
    type:
      - 'null'
      - boolean
    doc: Include extant gene IDs as comma separated entry in results.
    default: false
    inputBinding:
      position: 101
      prefix: --include_extant_genes
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level.
    default: info
    inputBinding:
      position: 101
      prefix: --log_level
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: query
    type: File
    doc: Path to FASTA formatted sequences
    inputBinding:
      position: 101
      prefix: --query
  - id: reference_taxon
    type:
      - 'null'
      - string
    doc: The placement is stopped when reaching the reference taxon (must exist 
      in the OMA database).
    default: None
    inputBinding:
      position: 101
      prefix: --reference_taxon
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Silence output
    default: false
    inputBinding:
      position: 101
      prefix: --silent
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold applied on the OMAmer-score that is used to vary the 
      specificity of predicted HOGs. The lower the theshold the more 
      (over-)specific predicted HOGs will be.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --threshold
  - id: top_n_fams
    type:
      - 'null'
      - int
    doc: Number of top level families to place into. By default, placed into 
      only in the best scoring family.
    default: 1
    inputBinding:
      position: 101
      prefix: --top_n_fams
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Path to output. If not set, defaults to stdout
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/omamer:2.1.2--pyhdfd78af_0
