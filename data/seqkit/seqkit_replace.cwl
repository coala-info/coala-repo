cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_replace
label: seqkit_replace
doc: "replace name/sequence by regular expression.\n\nTool homepage: https://github.com/shenwei356/seqkit"
inputs:
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: "length of sequence prefix of the first FASTA record based on\n         \
      \                               which seqkit guesses the sequence type (0 for
      whole seq)\n                                        (default 10000)"
    default: 10000
    inputBinding:
      position: 101
      prefix: --alphabet-guess-seq-length
  - id: by_seq
    type:
      - 'null'
      - boolean
    doc: replace seq (only FASTA)
    inputBinding:
      position: 101
      prefix: --by-seq
  - id: compress_level
    type:
      - 'null'
      - int
    doc: "compression level for gzip, zstd, xz and bzip2. type \"seqkit -h\"\n   \
      \                                     for the range and default value for each
      format (default -1)"
    default: -1
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: f_by_name
    type:
      - 'null'
      - boolean
    doc: '[target filter] match by full name instead of just ID'
    inputBinding:
      position: 101
      prefix: --f-by-name
  - id: f_by_seq
    type:
      - 'null'
      - boolean
    doc: "[target filter] search subseq on seq, both positive and negative strand\n\
      \                                 are searched, and mismatch allowed using flag
      -m/--max-mismatch"
    inputBinding:
      position: 101
      prefix: --f-by-seq
  - id: f_ignore_case
    type:
      - 'null'
      - boolean
    doc: '[target filter] ignore case'
    inputBinding:
      position: 101
      prefix: --f-ignore-case
  - id: f_invert_match
    type:
      - 'null'
      - boolean
    doc: '[target filter] invert the sense of matching, to select non-matching records'
    inputBinding:
      position: 101
      prefix: --f-invert-match
  - id: f_only_positive_strand
    type:
      - 'null'
      - boolean
    doc: '[target filter] only search on positive strand'
    inputBinding:
      position: 101
      prefix: --f-only-positive-strand
  - id: f_pattern
    type:
      - 'null'
      - type: array
        items: string
    doc: "[target filter] search pattern (multiple values supported. Attention:\n\
      \                                 use double quotation marks for patterns containing
      comma, e.g., -p\n                                 '\"A{2,}\"')"
    inputBinding:
      position: 101
      prefix: --f-pattern
  - id: f_pattern_file
    type:
      - 'null'
      - File
    doc: '[target filter] pattern file (one record per line)'
    inputBinding:
      position: 101
      prefix: --f-pattern-file
  - id: f_use_regexp
    type:
      - 'null'
      - boolean
    doc: '[target filter] patterns are regular expression'
    inputBinding:
      position: 101
      prefix: --f-use-regexp
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
    doc: regular expression for parsing ID (default "^(\S+)\s?")
    default: ^(\S+)\s?
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
  - id: infile_list
    type:
      - 'null'
      - File
    doc: "file of input files list (one file per line), if given, they are\n     \
      \                                   appended to files from cli arguments"
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: keep_key
    type:
      - 'null'
      - boolean
    doc: "keep the key as value when no value found for the key (only for\n      \
      \                           sequence name)"
    inputBinding:
      position: 101
      prefix: --keep-key
  - id: keep_untouch
    type:
      - 'null'
      - boolean
    doc: "do not change anything when no value found for the key (only for\n     \
      \                            sequence name)"
    inputBinding:
      position: 101
      prefix: --keep-untouch
  - id: key_capt_idx
    type:
      - 'null'
      - int
    doc: capture variable index of key (1-based) (default 1)
    default: 1
    inputBinding:
      position: 101
      prefix: --key-capt-idx
  - id: key_miss_repl
    type:
      - 'null'
      - string
    doc: replacement for key with no corresponding value
    inputBinding:
      position: 101
      prefix: --key-miss-repl
  - id: kv_file
    type:
      - 'null'
      - File
    doc: "tab-delimited key-value file for replacing key with value when using\n \
      \                                \"{kv}\" in -r (--replacement) (only for sequence
      name)"
    inputBinding:
      position: 101
      prefix: --kv-file
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap) (default 60)
    default: 60
    inputBinding:
      position: 101
      prefix: --line-width
  - id: nr_width
    type:
      - 'null'
      - int
    doc: "minimum width for {nr} in flag -r/--replacement. e.g., formatting \"1\"\n\
      \                                 to \"001\" by --nr-width 3 (default 1)"
    default: 1
    inputBinding:
      position: 101
      prefix: --nr-width
  - id: pattern
    type:
      - 'null'
      - string
    doc: search regular expression
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
  - id: replacement
    type:
      - 'null'
      - string
    doc: "replacement. supporting capture variables.  e.g. $1 represents the text\n\
      \                                 of the first submatch (use ${1} instead of
      $1 when {kv} given!).\n                                 ATTENTION: for *nix
      OS, use SINGLE quote NOT double quotes or use the \\\n                     \
      \            escape character. Record number and file name is also supported
      by\n                                 \"{nr}\" and \"{fn}\". Type \"csvtk replace
      -h\" for more replacement symbols."
    inputBinding:
      position: 101
      prefix: --replacement
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "sequence type (dna|rna|protein|unlimit|auto) (for auto, it\n           \
      \                             automatically detect by the first sequence) (default
      \"auto\")"
    default: auto
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
      \                         SEQKIT_THREADS) (default 4)"
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
