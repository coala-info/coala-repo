cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit sample
label: seqkit_sample
doc: "sample sequences by number or proportion.\n\nTool homepage: https://github.com/shenwei356/seqkit"
inputs:
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq)
    default: 10000
    inputBinding:
      position: 101
      prefix: --alphabet-guess-seq-length
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format
    default: -1
    inputBinding:
      position: 101
      prefix: --compress-level
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
    default: ^(\S+)\s?
    inputBinding:
      position: 101
      prefix: --id-regexp
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
    default: 60
    inputBinding:
      position: 101
      prefix: --line-width
  - id: number
    type:
      - 'null'
      - int
    doc: sample by number (result may not exactly match), DO NOT use on large 
      FASTQ files.
    inputBinding:
      position: 101
      prefix: --number
  - id: proportion
    type:
      - 'null'
      - float
    doc: sample by proportion
    inputBinding:
      position: 101
      prefix: --proportion
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: random seed. For paired-end data, use the same seed across fastq files 
      to sample the same read pairs
    default: 11
    inputBinding:
      position: 101
      prefix: --rand-seed
  - id: seq_type
    type:
      - 'null'
      - string
    doc: sequence type (dna|rna|protein|unlimit|auto) (for auto, it 
      automatically detect by the first sequence)
    default: auto
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
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: two_pass
    type:
      - 'null'
      - boolean
    doc: 2-pass mode read files twice to lower memory usage. Not allowed when 
      reading from stdin
    inputBinding:
      position: 101
      prefix: --two-pass
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
