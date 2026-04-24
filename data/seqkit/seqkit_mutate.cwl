cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_mutate
label: seqkit_mutate
doc: "edit sequence (point mutation, insertion, deletion)\n\nTool homepage: https://github.com/shenwei356/seqkit"
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
  - id: by_name
    type:
      - 'null'
      - boolean
    doc: '[match seqs to mutate] match by full name instead of just id'
    inputBinding:
      position: 101
      prefix: --by-name
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
  - id: deletion
    type:
      - 'null'
      - string
    doc: "deletion mutation: deleting subsequence in a range. e.g., -d 1:2 for\n \
      \                             deleting leading two bases, -d -3:-1 for removing
      last 3 bases"
    inputBinding:
      position: 101
      prefix: --deletion
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
    doc: '[match seqs to mutate] ignore case of search pattern'
    inputBinding:
      position: 101
      prefix: --ignore-case
  - id: infile_list
    type:
      - 'null'
      - File
    doc: "file of input files list (one file per line), if given, they are\n     \
      \                             appended to files from cli arguments"
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: insertion
    type:
      - 'null'
      - string
    doc: "insertion mutation: inserting bases behind of given position, e.g., -i\n\
      \                              0:ACGT for inserting ACGT at the beginning, -1:*
      for add * to the end"
    inputBinding:
      position: 101
      prefix: --insertion
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: "[match seqs to mutate] invert the sense of matching, to select\n       \
      \                       non-matching records"
    inputBinding:
      position: 101
      prefix: --invert-match
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap)
    inputBinding:
      position: 101
      prefix: --line-width
  - id: pattern
    type:
      - 'null'
      - type: array
        items: string
    doc: "[match seqs to mutate] search pattern .Multiple values supported:\n    \
      \                          comma-separated (e.g., -p \"p1,p2\") OR use -p multiple
      times (e.g., -p p1\n                              -p p2). Make sure to quote
      literal commas, e.g. in regex patterns '\"A{2,}\"'"
    inputBinding:
      position: 101
      prefix: --pattern
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: '[match seqs to mutate] pattern file (one record per line)'
    inputBinding:
      position: 101
      prefix: --pattern-file
  - id: point
    type:
      - 'null'
      - type: array
        items: string
    doc: "point mutation: changing base at given position. e.g., -p 2:C for setting\n\
      \                              2nd base as C, -p -1:A for change last base as
      A"
    inputBinding:
      position: 101
      prefix: --point
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
      \                     automatically detect by the first sequence)"
    inputBinding:
      position: 101
      prefix: --seq-type
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: "skip input file checking when given a file list if you believe\n       \
      \                         these files do exist"
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
  - id: use_regexp
    type:
      - 'null'
      - boolean
    doc: '[match seqs to mutate] search patterns are regular expression'
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
