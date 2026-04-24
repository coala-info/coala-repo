cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit merge-slides
label: seqkit_merge-slides
doc: "merge sliding windows generated from seqkit sliding\n\nTool homepage: https://github.com/shenwei356/seqkit"
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
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: "size of buffer, supported unit: K, M, G. You need increase the\n       \
      \                               value when \"bufio.Scanner: token too long\"\
      \ error reported"
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: comment_line_prefix
    type:
      - 'null'
      - type: array
        items: string
    doc: comment line prefix
      - '#'
      - //
    inputBinding:
      position: 101
      prefix: --comment-line-prefix
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
  - id: infile_list
    type:
      - 'null'
      - string
    doc: "file of input files list (one file per line), if given, they are\n     \
      \                             appended to files from cli arguments"
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
  - id: max_gap
    type:
      - 'null'
      - int
    doc: "maximum distance of starting positions of two adjacent regions, 0\n    \
      \                                  for no limitation, 1 for no merging."
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: "minimum overlap of two adjacent regions, recommend\n                   \
      \                   $sliding_step_size - 1."
    inputBinding:
      position: 101
      prefix: --min-overlap
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: regexp
    type:
      - 'null'
      - string
    doc: "regular expression for extract the reference name and window\n         \
      \                             position."
    inputBinding:
      position: 101
      prefix: --regexp
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
