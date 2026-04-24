cwlVersion: v1.2
class: CommandLineTool
baseCommand: namfinder
label: namfinder
doc: "namfinder 0.1.2\n\nTool homepage: https://github.com/ksahlin/namfinder"
inputs:
  - id: reference
    type: File
    doc: Reference in FASTA format
    inputBinding:
      position: 1
  - id: reads1
    type:
      - 'null'
      - File
    doc: Reads 1 in FASTA or FASTQ format, optionally gzip compressed
    inputBinding:
      position: 2
  - id: reads2
    type:
      - 'null'
      - File
    doc: Reads 2 in FASTA or FASTQ format, optionally gzip compressed
    inputBinding:
      position: 3
  - id: bitcount_length
    type:
      - 'null'
      - int
    doc: Bitcount length between 2 and 63.
    inputBinding:
      position: 104
      prefix: -c
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: "Do not map reads; only generate the strobemer index and write it to\n  \
      \                  disk. If read files are provided, they are used to estimate
      read\n                    length"
    inputBinding:
      position: 104
      prefix: --create-index
  - id: index_statistics
    type:
      - 'null'
      - File
    doc: Print statistics of indexing to PATH
    inputBinding:
      position: 104
      prefix: --index-statistics
  - id: lower_syncmer_offset
    type:
      - 'null'
      - int
    doc: "Lower syncmer offset from k/(k-s+1). Start sample second syncmer\n     \
      \               k/(k-s+1) + l syncmers downstream"
    inputBinding:
      position: 104
      prefix: -l
  - id: mask_strobemer_hits
    type:
      - 'null'
      - int
    doc: Mask (do not process) strobemer hits with count larger than C
    inputBinding:
      position: 104
      prefix: -C
  - id: max_nams_per_query
    type:
      - 'null'
      - int
    doc: "Print at most L NAMs per query [1000]. Will print the NAMs with\n      \
      \              highest score S = n_strobemer_hits * query_span."
    inputBinding:
      position: 104
      prefix: -L
  - id: max_secondary_alignments
    type:
      - 'null'
      - int
    doc: "Retain at most INT secondary alignments (is upper bounded by -M and\n  \
      \                  depends on -S)"
    inputBinding:
      position: 104
      prefix: -N
  - id: max_seed_length
    type:
      - 'null'
      - int
    doc: "Maximum seed length. the seed length distribution is usually\n         \
      \           determined by parameters l and u. Then, this parameter is only active\n\
      \                    in regions where syncmers are very sparse."
    inputBinding:
      position: 104
      prefix: -m
  - id: sort_output_nams
    type:
      - 'null'
      - boolean
    doc: "Sort output NAMs for each query based on score. Default is to sort\n   \
      \                 first by ref ID, then by query coordinate, then by reference\n\
      \                    coordinate."
    inputBinding:
      position: 104
      prefix: -S
  - id: strobe_length
    type:
      - 'null'
      - int
    doc: Strobe length, has to be below 32.
    inputBinding:
      position: 104
      prefix: -k
  - id: submer_size
    type:
      - 'null'
      - int
    doc: "Submer size used for creating syncmers [k-4]. Only even numbers on k-s\n\
      \                    allowed. A value of s=k-4 roughly represents w=10 as minimizer
      window\n                    [k-4]. It is recommended not to change this parameter
      unless you have\n                    a good understanding of syncmers as it
      will drastically change the\n                    memory usage and results with
      non default values."
    inputBinding:
      position: 104
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 104
      prefix: --threads
  - id: upper_syncmer_offset
    type:
      - 'null'
      - int
    doc: "Upper syncmer offset from k/(k-s+1). End sample second syncmer\n       \
      \             k/(k-s+1) + u syncmers downstream"
    inputBinding:
      position: 104
      prefix: -u
  - id: use_index
    type:
      - 'null'
      - boolean
    doc: Use a pre-generated index previously written with --create-index.
    inputBinding:
      position: 104
      prefix: --use-index
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect output to file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/namfinder:0.1.3--h077b44d_2
