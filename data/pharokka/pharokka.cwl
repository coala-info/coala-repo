cwlVersion: v1.2
class: CommandLineTool
baseCommand: pharokka.py
label: pharokka
doc: "pharokka: fast and functional annotation of phage genomes\n\nTool homepage:
  https://github.com/gbouras13/pharokka"
inputs:
  - id: coding_table
    type:
      - 'null'
      - int
    doc: Genetic code table
    default: 11
    inputBinding:
      position: 101
      prefix: --coding_table
  - id: database
    type: Directory
    doc: Database directory. Use install_databases.py to download
    inputBinding:
      position: 101
      prefix: --database
  - id: fast
    type:
      - 'null'
      - boolean
    doc: 'Fast mode: skips HHsearch and only uses MMseqs2'
    inputBinding:
      position: 101
      prefix: --fast
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrites the output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: gene_predictor
    type:
      - 'null'
      - string
    doc: 'Gene predictor to use: prodigal-gv or phanotate'
    default: prodigal-gv
    inputBinding:
      position: 101
      prefix: --gene_predictor
  - id: infile
    type: File
    doc: Input genome fasta file
    inputBinding:
      position: 101
      prefix: --infile
  - id: locustag
    type:
      - 'null'
      - string
    doc: Locus tag prefix
    default: PHAROKKA
    inputBinding:
      position: 101
      prefix: --locustag
  - id: meta
    type:
      - 'null'
      - boolean
    doc: Metagenomic mode for gene prediction
    inputBinding:
      position: 101
      prefix: --meta
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pharokka:1.9.1--pyhdfd78af_1
