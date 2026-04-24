cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_seq
label: seqkit_seq
doc: "transform sequences (extract ID, filter by length, remove gaps, reverse complement...)\n\
  \nTool homepage: https://github.com/shenwei356/seqkit"
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
  - id: color
    type:
      - 'null'
      - boolean
    doc: colorize sequences - to be piped into "less -R"
    inputBinding:
      position: 101
      prefix: --color
  - id: complement
    type:
      - 'null'
      - boolean
    doc: complement sequence, flag '-v' is recommended to switch on
    inputBinding:
      position: 101
      prefix: --complement
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: dna2rna
    type:
      - 'null'
      - boolean
    doc: DNA to RNA
    inputBinding:
      position: 101
      prefix: --dna2rna
  - id: gap_letters
    type:
      - 'null'
      - string
    doc: gap letters to be removed with -g/--remove-gaps
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
  - id: infile_list
    type:
      - 'null'
      - File
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
  - id: lower_case
    type:
      - 'null'
      - boolean
    doc: print sequences in lower case
    inputBinding:
      position: 101
      prefix: --lower-case
  - id: max_len
    type:
      - 'null'
      - int
    doc: only print sequences shorter than or equal to the maximum length (-1 
      for no limit)
    inputBinding:
      position: 101
      prefix: --max-len
  - id: max_qual
    type:
      - 'null'
      - float
    doc: only print sequences with average quality less than this limit (-1 for 
      no limit)
    inputBinding:
      position: 101
      prefix: --max-qual
  - id: min_len
    type:
      - 'null'
      - int
    doc: only print sequences longer than or equal to the minimum length (-1 for
      no limit)
    inputBinding:
      position: 101
      prefix: --min-len
  - id: min_qual
    type:
      - 'null'
      - float
    doc: only print sequences with average quality greater or equal than this 
      limit (-1 for no limit)
    inputBinding:
      position: 101
      prefix: --min-qual
  - id: name
    type:
      - 'null'
      - boolean
    doc: only print names/sequence headers
    inputBinding:
      position: 101
      prefix: --name
  - id: only_id
    type:
      - 'null'
      - boolean
    doc: print IDs instead of full headers
    inputBinding:
      position: 101
      prefix: --only-id
  - id: qual
    type:
      - 'null'
      - boolean
    doc: only print qualities
    inputBinding:
      position: 101
      prefix: --qual
  - id: qual_ascii_base
    type:
      - 'null'
      - int
    doc: ASCII BASE, 33 for Phred+33
    inputBinding:
      position: 101
      prefix: --qual-ascii-base
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: remove_gaps
    type:
      - 'null'
      - boolean
    doc: remove gaps letters set by -G/--gap-letters, e.g., spaces, tabs, and 
      dashes (gaps "-" in aligned sequences)
    inputBinding:
      position: 101
      prefix: --remove-gaps
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: reverse sequence
    inputBinding:
      position: 101
      prefix: --reverse
  - id: rna2dna
    type:
      - 'null'
      - boolean
    doc: RNA to DNA
    inputBinding:
      position: 101
      prefix: --rna2dna
  - id: seq
    type:
      - 'null'
      - boolean
    doc: only print sequences
    inputBinding:
      position: 101
      prefix: --seq
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
  - id: upper_case
    type:
      - 'null'
      - boolean
    doc: print sequences in upper case
    inputBinding:
      position: 101
      prefix: --upper-case
  - id: validate_seq
    type:
      - 'null'
      - boolean
    doc: validate bases according to the alphabet
    inputBinding:
      position: 101
      prefix: --validate-seq
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
