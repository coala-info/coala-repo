cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytrf_findatr
label: pytrf_findatr
doc: "Finds tandem repeats in a FASTA or FASTQ file.\n\nTool homepage: https://github.com/lmdu/pytrf"
inputs:
  - id: fastx
    type: File
    doc: input fasta or fastq file (gzip support)
    inputBinding:
      position: 1
  - id: max_errors
    type:
      - 'null'
      - int
    doc: maximum number of continuous alignment errors
    default: 3
    inputBinding:
      position: 102
      prefix: --max-errors
  - id: max_extend
    type:
      - 'null'
      - int
    doc: maximum length allowed to extend
    default: 2000
    inputBinding:
      position: 102
      prefix: --max-extend
  - id: max_motif
    type:
      - 'null'
      - int
    doc: maximum motif length
    default: 6
    inputBinding:
      position: 102
      prefix: --max-motif
  - id: min_identity
    type:
      - 'null'
      - int
    doc: minimum identity for extending, 0 to 100
    default: 70
    inputBinding:
      position: 102
      prefix: --min-identity
  - id: min_motif
    type:
      - 'null'
      - int
    doc: minimum motif length
    default: 1
    inputBinding:
      position: 102
      prefix: --min-motif
  - id: min_seedlen
    type:
      - 'null'
      - int
    doc: minimum length for seed
    default: 10
    inputBinding:
      position: 102
      prefix: --min-seedlen
  - id: min_seedrep
    type:
      - 'null'
      - int
    doc: minimum repeat number for seed
    default: 3
    inputBinding:
      position: 102
      prefix: --min-seedrep
  - id: out_format
    type:
      - 'null'
      - string
    doc: output format, tsv, csv, bed or gff
    default: tsv
    inputBinding:
      position: 102
      prefix: --out-format
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytrf:1.4.2--py310h1fe012e_1
