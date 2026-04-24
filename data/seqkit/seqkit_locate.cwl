cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit locate
label: seqkit_locate
doc: "locate subsequences/motifs, mismatch allowed\n\nTool homepage: https://github.com/shenwei356/seqkit"
inputs:
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: "length of sequence prefix of the first FASTA record based on\n         \
      \                               which seqkit guesses the sequence type (0 for
      whole seq)"
    inputBinding:
      position: 101
      prefix: --alphabet-guess-seq-length
  - id: circular
    type:
      - 'null'
      - boolean
    doc: circular genome. type "seqkit locate -h" for details
    inputBinding:
      position: 101
      prefix: --circular
  - id: compress_level
    type:
      - 'null'
      - int
    doc: "compression level for gzip, zstd, xz and bzip2. type \"seqkit -h\"\n   \
      \                                     for the range and default value for each
      format"
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: degenerate
    type:
      - 'null'
      - boolean
    doc: pattern/motif contains degenerate base
    inputBinding:
      position: 101
      prefix: --degenerate
  - id: hide_matched
    type:
      - 'null'
      - boolean
    doc: do not show matched sequences
    inputBinding:
      position: 101
      prefix: --hide-matched
  - id: id_ncbi
    type:
      - 'null'
      - boolean
    doc: "FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|\n        \
      \                                Pseud..."
    inputBinding:
      position: 101
      prefix: --id-ncbi
  - id: id_regexp
    type:
      - 'null'
      - string
    doc: regular expression for parsing ID
    inputBinding:
      position: 101
      prefix: --id-regexp
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore case
    inputBinding:
      position: 101
      prefix: --ignore-case
  - id: immediate_output
    type:
      - 'null'
      - boolean
    doc: print output immediately, do not use write buffer
    inputBinding:
      position: 101
      prefix: --immediate-output
  - id: infile_list
    type:
      - 'null'
      - File
    doc: "file of input files list (one file per line), if given, they are\n     \
      \                                   appended to files from cli arguments"
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap)
    inputBinding:
      position: 101
      prefix: --line-width
  - id: max_len_to_show
    type:
      - 'null'
      - int
    doc: show at most X characters for the search pattern or matched sequences
    inputBinding:
      position: 101
      prefix: -s
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: "max mismatch when matching by seq. For large genomes like human genome,\n\
      \                               using mapping/alignment tools would be faster"
    inputBinding:
      position: 101
      prefix: --max-mismatch
  - id: non_greedy
    type:
      - 'null'
      - boolean
    doc: non-greedy mode, faster but may miss motifs overlapping with others
    inputBinding:
      position: 101
      prefix: --non-greedy
  - id: only_positive_strand
    type:
      - 'null'
      - boolean
    doc: only search on positive strand
    inputBinding:
      position: 101
      prefix: --only-positive-strand
  - id: output_bed6
    type:
      - 'null'
      - boolean
    doc: output in BED6 format
    inputBinding:
      position: 101
      prefix: --bed
  - id: output_gtf
    type:
      - 'null'
      - boolean
    doc: output in GTF format
    inputBinding:
      position: 101
      prefix: --gtf
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: pattern/motif file (FASTA format)
    inputBinding:
      position: 101
      prefix: --pattern-file
  - id: patterns
    type:
      - 'null'
      - type: array
        items: string
    doc: "pattern/motif. Multiple values supported: comma-separated (e.g., -p\n  \
      \                             \"p1,p2\") OR use -p multiple times (e.g., -p
      p1 -p p2). Make sure to quote\n                               literal commas,
      e.g. in regex patterns '\"A{2,}\"'"
    inputBinding:
      position: 101
      prefix: --pattern
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "sequence type (dna|rna|protein|unlimit|auto) (for auto, it\n           \
      \                             automatically detect by the first sequence)"
    inputBinding:
      position: 101
      prefix: --seq-type
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: "skip input file checking when given a file list if you believe\n       \
      \                                 these files do exist"
    inputBinding:
      position: 101
      prefix: --skip-file-check
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of CPUs. can also set with environment variable\n               \
      \                         SEQKIT_THREADS)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_fmi
    type:
      - 'null'
      - boolean
    doc: use FM-index for much faster search of lots of sequence patterns
    inputBinding:
      position: 101
      prefix: --use-fmi
  - id: use_regexp
    type:
      - 'null'
      - boolean
    doc: patterns/motifs are regular expression
    inputBinding:
      position: 101
      prefix: --use-regexp
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
