cwlVersion: v1.2
class: CommandLineTool
baseCommand: locidex_report
label: locidex_report
doc: "Filter a sequence store and produce and extract of blast results and gene profile\n\
  \nTool homepage: https://pypi.org/project/locidex/"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Locidex parameter config file (json)
    inputBinding:
      position: 101
      prefix: --config
  - id: fasta
    type:
      - 'null'
      - File
    doc: 'Optional: Query fasta file used to generate search results'
    inputBinding:
      position: 101
      prefix: --fasta
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input
    type: File
    doc: Input seq_store file to report
    inputBinding:
      position: 101
      prefix: --input
  - id: match_cov
    type:
      - 'null'
      - float
    doc: Report match if percent coverage is >= this value
    inputBinding:
      position: 101
      prefix: --match_cov
  - id: match_ident
    type:
      - 'null'
      - float
    doc: Report match if percent identity is >= this value
    inputBinding:
      position: 101
      prefix: --match_ident
  - id: max_ambig
    type:
      - 'null'
      - int
    doc: Maximum number of ambiguous characters allowed in a sequence
    inputBinding:
      position: 101
      prefix: --max_ambig
  - id: max_len
    type:
      - 'null'
      - int
    doc: Report match allele length is <= this value
    inputBinding:
      position: 101
      prefix: --max_len
  - id: max_stop
    type:
      - 'null'
      - int
    doc: Maximum number of internal stop codons allowed in a sequence
    inputBinding:
      position: 101
      prefix: --max_stop
  - id: min_len
    type:
      - 'null'
      - int
    doc: Report match if query length is >= this value
    inputBinding:
      position: 101
      prefix: --min_len
  - id: mode
    type:
      - 'null'
      - string
    doc: Allele profile assignment [normal,conservative,fuzzy]
    inputBinding:
      position: 101
      prefix: --mode
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
  - id: prop
    type:
      - 'null'
      - string
    doc: Metadata label to use for aggregation
    inputBinding:
      position: 101
      prefix: --prop
  - id: translation_table
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --translation_table
outputs:
  - id: outdir
    type: Directory
    doc: Output file to put results
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
