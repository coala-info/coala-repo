cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_sort
label: seqkit_sort
doc: "sort sequences by id/name/sequence/length.\n\nTool homepage: https://github.com/shenwei356/seqkit"
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
  - id: by_bases
    type:
      - 'null'
      - boolean
    doc: by non-gap bases
    inputBinding:
      position: 101
      prefix: --by-bases
  - id: by_length
    type:
      - 'null'
      - boolean
    doc: by sequence length
    inputBinding:
      position: 101
      prefix: --by-length
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
    doc: by sequence
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
  - id: gap_letters
    type:
      - 'null'
      - string
    doc: gap letters
    inputBinding:
      position: 101
      prefix: --gap-letters
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
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: keep temporary FASTA and .fai file when using 2-pass mode
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap)
    inputBinding:
      position: 101
      prefix: --line-width
  - id: natural_order
    type:
      - 'null'
      - boolean
    doc: sort in natural order, when sorting by IDs/full name
    inputBinding:
      position: 101
      prefix: --natural-order
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: reverse the result
    inputBinding:
      position: 101
      prefix: --reverse
  - id: seq_prefix_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix on which seqkit sorts by sequences (0 for 
      whole sequence)
    inputBinding:
      position: 101
      prefix: --seq-prefix-length
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
  - id: two_pass
    type:
      - 'null'
      - boolean
    doc: two-pass mode read files twice to lower memory usage. (only for FASTA 
      format)
    inputBinding:
      position: 101
      prefix: --two-pass
  - id: update_faidx
    type:
      - 'null'
      - boolean
    doc: update the fasta index file if it exists. Use this if you are not sure 
      whether the fasta file changed
    inputBinding:
      position: 101
      prefix: --update-faidx
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
