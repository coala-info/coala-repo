cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hostile
  - clean
label: hostile_clean
doc: "Remove reads aligning to an index from fastq[.gz] input files or stdin.\n\n\
  Tool homepage: https://github.com/bede/hostile"
inputs:
  - id: airplane
    type:
      - 'null'
      - boolean
    doc: disable automatic index download (offline mode)
    inputBinding:
      position: 101
      prefix: --airplane
  - id: aligner
    type:
      - 'null'
      - string
    doc: alignment algorithm. Defaults to minimap2 (long read) given fastq1 only
      or bowtie2 (short read) given fastq1 and fastq2. Override with bowtie2 for
      single/unpaired short reads
    inputBinding:
      position: 101
      prefix: --aligner
  - id: aligner_args
    type:
      - 'null'
      - string
    doc: additional arguments for alignment
    inputBinding:
      position: 101
      prefix: --aligner-args
  - id: casava
    type:
      - 'null'
      - boolean
    doc: use Casava 1.8+ read header format
    inputBinding:
      position: 101
      prefix: --casava
  - id: debug
    type:
      - 'null'
      - boolean
    doc: show debug messages
    inputBinding:
      position: 101
      prefix: --debug
  - id: fastq1
    type: File
    doc: path to forward fastq[.gz] file or - for stdin
    inputBinding:
      position: 101
      prefix: --fastq1
  - id: fastq2
    type:
      - 'null'
      - File
    doc: optional path to reverse fastq[.gz] file or - for stdin
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite existing output files
    inputBinding:
      position: 101
      prefix: --force
  - id: index
    type:
      - 'null'
      - string
    doc: name of standard index or path to custom genome (Minimap2) or Bowtie2 
      index
    inputBinding:
      position: 101
      prefix: --index
  - id: invert
    type:
      - 'null'
      - boolean
    doc: keep only reads aligning to the index (and their mates if applicable)
    inputBinding:
      position: 101
      prefix: --invert
  - id: rename
    type:
      - 'null'
      - boolean
    doc: replace read names with incrementing integers
    inputBinding:
      position: 101
      prefix: --rename
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: ensure deterministic output order
    inputBinding:
      position: 101
      prefix: --reorder
  - id: threads
    type:
      - 'null'
      - int
    doc: number of alignment threads. A sensible default is chosen automatically
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: path to output directory or - for stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hostile:2.0.2--pyhdfd78af_0
