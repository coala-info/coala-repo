cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit amplicon
label: seqkit_amplicon
doc: "extract amplicon (or specific region around it) via primer(s).\n\nTool homepage:
  https://github.com/shenwei356/seqkit"
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
  - id: bed_output
    type:
      - 'null'
      - boolean
    doc: output in BED6+1 format with amplicon as the 7th column
    inputBinding:
      position: 101
      prefix: --bed
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
  - id: flanking_region
    type:
      - 'null'
      - boolean
    doc: region is flanking region
    inputBinding:
      position: 101
      prefix: --flanking-region
  - id: forward_primer
    type:
      - 'null'
      - string
    doc: forward primer (5'-primer-3'), degenerate bases allowed
    inputBinding:
      position: 101
      prefix: --forward
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
      - type: array
        items: File
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
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: max mismatch when matching primers, no degenerate bases allowed
    inputBinding:
      position: 101
      prefix: --max-mismatch
  - id: only_positive_strand
    type:
      - 'null'
      - boolean
    doc: only search on positive strand
    inputBinding:
      position: 101
      prefix: --only-positive-strand
  - id: output_mismatches
    type:
      - 'null'
      - boolean
    doc: append the total mismatches and mismatches of 5' end and 3' end
    inputBinding:
      position: 101
      prefix: --output-mismatches
  - id: primer_file
    type:
      - 'null'
      - File
    doc: 3- or 2-column tabular primer file, with first column as primer name
    inputBinding:
      position: 101
      prefix: --primer-file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: region
    type:
      - 'null'
      - string
    doc: specify region to return. type "seqkit amplicon -h" for detail
    inputBinding:
      position: 101
      prefix: --region
  - id: reverse_primer
    type:
      - 'null'
      - string
    doc: reverse primer (5'-primer-3'), degenerate bases allowed
    inputBinding:
      position: 101
      prefix: --reverse
  - id: save_unmatched
    type:
      - 'null'
      - boolean
    doc: also save records that do not match any primer
    inputBinding:
      position: 101
      prefix: --save-unmatched
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
  - id: strict_mode
    type:
      - 'null'
      - boolean
    doc: "strict mode, i.e., discarding seqs not fully matching (shorter) given\n\
      \                               region range"
    inputBinding:
      position: 101
      prefix: --strict-mode
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
