cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_rmdup
label: seqkit_rmdup
doc: "remove duplicated sequences by ID/name/sequence\n\nTool homepage: https://github.com/shenwei356/seqkit"
inputs:
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq)
    inputBinding:
      position: 101
      prefix: --alphabet-guess-seq-length
  - id: by_name
    type:
      - 'null'
      - boolean
    doc: by full name instead of just id
    inputBinding:
      position: 101
      prefix: --by-name
  - id: by_seq
    type:
      - 'null'
      - boolean
    doc: by seq
    inputBinding:
      position: 101
      prefix: --by-seq
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: dup_num_file
    type:
      - 'null'
      - string
    doc: file to save numbers and ID lists of duplicated seqs
    inputBinding:
      position: 101
      prefix: --dup-num-file
  - id: dup_seqs_file
    type:
      - 'null'
      - string
    doc: file to save duplicated seqs
    inputBinding:
      position: 101
      prefix: --dup-seqs-file
  - id: id_ncbi
    type:
      - 'null'
      - boolean
    doc: FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2| Pseud...
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
  - id: infile_list
    type:
      - 'null'
      - string
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
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
  - id: only_positive_strand
    type:
      - 'null'
      - boolean
    doc: only considering positive strand when comparing by sequence
    inputBinding:
      position: 101
      prefix: --only-positive-strand
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
    doc: sequence type (dna|rna|protein|unlimit|auto) (for auto, it 
      automatically detect by the first sequence)
    inputBinding:
      position: 101
      prefix: --seq-type
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: skip input file checking when given a file list if you believe these 
      files do exist
    inputBinding:
      position: 101
      prefix: --skip-file-check
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. can also set with environment variable SEQKIT_THREADS)
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
