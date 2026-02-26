cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_fish
label: seqkit_fish
doc: "look for short sequences in larger sequences using local alignment\n\nTool homepage:
  https://github.com/shenwei356/seqkit"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: search all
    inputBinding:
      position: 101
      prefix: --all
  - id: aln_params
    type:
      - 'null'
      - string
    doc: "alignment parameters in format\n                                 \"<match>,<mismatch>,<gap_open>,<gap_extend>\""
    default: '"4,-4,-2,-1"'
    inputBinding:
      position: 101
      prefix: --aln-params
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: "length of sequence prefix of the first FASTA record based on\n         \
      \                               which seqkit guesses the sequence type (0 for
      whole seq)"
    default: 10000
    inputBinding:
      position: 101
      prefix: --alphabet-guess-seq-length
  - id: compress_level
    type:
      - 'null'
      - int
    doc: "compression level for gzip, zstd, xz and bzip2. type \"seqkit -h\"\n   \
      \                                     for the range and default value for each
      format"
    default: -1
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
    default: '"^(\\S+)\\s?"'
    inputBinding:
      position: 101
      prefix: --id-regexp
  - id: infile_list
    type:
      - 'null'
      - File
    doc: "file of input files list (one file per line), if given, they are\n     \
      \                                   appended to files from cli arguments"
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: invert
    type:
      - 'null'
      - boolean
    doc: print out references not matching with any query
    inputBinding:
      position: 101
      prefix: --invert
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap)
    default: 60
    inputBinding:
      position: 101
      prefix: --line-width
  - id: min_qual
    type:
      - 'null'
      - float
    doc: minimum mapping quality
    default: 5
    inputBinding:
      position: 101
      prefix: --min-qual
  - id: out_file
    type:
      - 'null'
      - string
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    default: '"-"'
    inputBinding:
      position: 101
      prefix: --out-file
  - id: pass
    type:
      - 'null'
      - boolean
    doc: pass through mode (write input to stdout)
    inputBinding:
      position: 101
      prefix: --pass
  - id: print_aln
    type:
      - 'null'
      - boolean
    doc: print sequence alignments
    inputBinding:
      position: 101
      prefix: --print-aln
  - id: print_desc
    type:
      - 'null'
      - boolean
    doc: print full sequence header
    inputBinding:
      position: 101
      prefix: --print-desc
  - id: query_fastx
    type:
      - 'null'
      - File
    doc: query fasta
    inputBinding:
      position: 101
      prefix: --query-fastx
  - id: query_sequences
    type:
      - 'null'
      - string
    doc: query sequences
    inputBinding:
      position: 101
      prefix: --query-sequences
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ranges
    type:
      - 'null'
      - string
    doc: 'target ranges, for example: ":10,30:40,-20:"'
    inputBinding:
      position: 101
      prefix: --ranges
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "sequence type (dna|rna|protein|unlimit|auto) (for auto, it\n           \
      \                             automatically detect by the first sequence)"
    default: '"auto"'
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
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: search + strand only
    inputBinding:
      position: 101
      prefix: --stranded
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of CPUs. can also set with environment variable\n               \
      \                         SEQKIT_THREADS)"
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: validate_seq
    type:
      - 'null'
      - boolean
    doc: validate bases according to the alphabet
    inputBinding:
      position: 101
      prefix: --validate-seq
outputs:
  - id: out_bam
    type:
      - 'null'
      - File
    doc: save aligmnets to this BAM file (memory intensive)
    outputBinding:
      glob: $(inputs.out_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
