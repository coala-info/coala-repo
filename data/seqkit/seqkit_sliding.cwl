cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_sliding
label: seqkit_sliding
doc: "extract subsequences in sliding windows\n\nTool homepage: https://github.com/shenwei356/seqkit"
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
  - id: circular
    type:
      - 'null'
      - boolean
    doc: circular genome (same to -C/--circular-genome)
    inputBinding:
      position: 101
      prefix: --circular
  - id: circular_genome
    type:
      - 'null'
      - boolean
    doc: circular genome (same to -c/--circular)
    inputBinding:
      position: 101
      prefix: --circular-genome
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
  - id: greedy
    type:
      - 'null'
      - boolean
    doc: greedy mode, i.e., exporting last subsequences even shorter than the 
      windows size
    inputBinding:
      position: 101
      prefix: --greedy
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
    default: 60
    inputBinding:
      position: 101
      prefix: --line-width
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
  - id: step
    type:
      - 'null'
      - int
    doc: step size
    inputBinding:
      position: 101
      prefix: --step
  - id: suffix
    type:
      - 'null'
      - string
    doc: suffix added to the sequence ID
    default: _sliding
    inputBinding:
      position: 101
      prefix: --suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. can also set with environment variable SEQKIT_THREADS)
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: window
    type:
      - 'null'
      - int
    doc: window size
    inputBinding:
      position: 101
      prefix: --window
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
