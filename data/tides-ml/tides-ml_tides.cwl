cwlVersion: v1.2
class: CommandLineTool
baseCommand: tides.py
label: tides-ml_tides
doc: "TIdeS (Transcript Isoform Discovery and Expression Simulator)\n\nTool homepage:
  https://github.com/xxmalcala/TIdeS"
inputs:
  - id: clean
    type:
      - 'null'
      - boolean
    doc: remove intermediate filter-step files
    inputBinding:
      position: 101
      prefix: --clean
  - id: contam
    type:
      - 'null'
      - File
    doc: table of annotated sequences
    inputBinding:
      position: 101
      prefix: --contam
  - id: db
    type:
      - 'null'
      - File
    doc: protein database (FASTA or DIAMOND format)
    inputBinding:
      position: 101
      prefix: --db
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum e-value to infer reference ORFs
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fin
    type: File
    doc: input file in FASTA format
    inputBinding:
      position: 101
      prefix: --fin
  - id: gencode
    type:
      - 'null'
      - int
    doc: genetic code to use to translate ORFs
    inputBinding:
      position: 101
      prefix: --gencode
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: tar and gzip TIdeS output
    inputBinding:
      position: 101
      prefix: --gzip
  - id: id
    type:
      - 'null'
      - float
    doc: minimum % identity to remove redundant transcripts
    inputBinding:
      position: 101
      prefix: --id
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer size for generating sequence features
    inputBinding:
      position: 101
      prefix: --kmer
  - id: kraken
    type:
      - 'null'
      - File
    doc: kraken2 database to identify and filter non-eukaryotic sequences
    inputBinding:
      position: 101
      prefix: --kraken
  - id: max_orf
    type:
      - 'null'
      - int
    doc: maximum ORF length (bp) to evaluate
    inputBinding:
      position: 101
      prefix: --max-orf
  - id: memory
    type:
      - 'null'
      - int
    doc: memory limit (MB) for CD-HIT (default = 2000, unlimited = 0)
    inputBinding:
      position: 101
      prefix: --memory
  - id: min_orf
    type:
      - 'null'
      - int
    doc: minimum ORF length (bp) to evaluate
    inputBinding:
      position: 101
      prefix: --min-orf
  - id: model
    type:
      - 'null'
      - File
    doc: previously trained TIdeS model (".pkl" file)
    inputBinding:
      position: 101
      prefix: --model
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: skip the rRNA and transcript clustering steps
    inputBinding:
      position: 101
      prefix: --no-filter
  - id: overlap
    type:
      - 'null'
      - boolean
    doc: permit overlapping kmers (see --kmer)
    inputBinding:
      position: 101
      prefix: --overlap
  - id: partial
    type:
      - 'null'
      - boolean
    doc: evaluate partial ORFs as well
    inputBinding:
      position: 101
      prefix: --partial
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: no console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: step
    type:
      - 'null'
      - int
    doc: step-size for overlapping kmers
    inputBinding:
      position: 101
      prefix: --step
  - id: strand
    type:
      - 'null'
      - string
    doc: query strands to call ORFs (both/minus/plus)
    inputBinding:
      position: 101
      prefix: --strand
  - id: taxon
    type: string
    doc: taxon or output name
    inputBinding:
      position: 101
      prefix: --taxon
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: train_only
    type:
      - 'null'
      - boolean
    doc: run TIdeS through training (no predictions)
    inputBinding:
      position: 101
      prefix: --train-only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tides-ml:1.3.5--pyhdfd78af_0
stdout: tides-ml_tides.out
