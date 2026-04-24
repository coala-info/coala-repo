cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deblur
  - remove-artifacts
label: deblur_remove-artifacts
doc: "Filter artifacts from input sequences based on database(s) provided with the\n\
  \  --ref-fp (raw FASTA file) or --ref-db-fp (indexed database) options.\n\nTool
  homepage: https://github.com/biocore/deblur"
inputs:
  - id: seqs_fp
    type: File
    doc: Input sequences file
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 2
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file name
    inputBinding:
      position: 103
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - int
    doc: "Level of messages for log file (range 1-debug\n                        \
      \          to 5-critical"
    inputBinding:
      position: 103
      prefix: --log-level
  - id: negate
    type:
      - 'null'
      - boolean
    doc: "Use --negate (i.e. True) to discard all\n                              \
      \    sequences aligning to the database passed\n                           \
      \       via --neg-ref-fp option."
    inputBinding:
      position: 103
      prefix: --negate
  - id: only_pos
    type:
      - 'null'
      - boolean
    doc: "filter by only\n                                  keeping sequences similar
      to ones in --pos-\n                                  ref-fp."
    inputBinding:
      position: 103
      prefix: --only-pos
  - id: ref_db_fp
    type:
      - 'null'
      - type: array
        items: File
    doc: "Keep all sequences aligning to this indexed\n                          \
      \        database. For multiple databases, the order\n                     \
      \             must follow that of --ref-fp, for example,\n                 \
      \                 --ref-db-fp db1.idx --ref-db-fp db2.idx .."
    inputBinding:
      position: 103
      prefix: --ref-db-fp
  - id: ref_fp
    type:
      - 'null'
      - type: array
        items: File
    doc: "Keep all sequences aligning to this FASTA database (for multiple databases,
      use --ref-\n                                  fp db1.fa --ref-fp db2.fa ..)
      default for\n                                  positive filtering is: /usr/local/lib/python3.10/site-\n\
      \                                  packages/deblur/support_files/88_otus.fasta\n\
      \                                  default for negative filtering is: /usr/local/lib/python3.10/site-\n\
      \                                  packages/deblur/support_files/artifacts.fa"
    inputBinding:
      position: 103
      prefix: --ref-fp
  - id: threads_per_sample
    type:
      - 'null'
      - int
    doc: "Number of threads to use per sample (0 to\n                            \
      \      use all)"
    inputBinding:
      position: 103
      prefix: --threads-per-sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
stdout: deblur_remove-artifacts.out
