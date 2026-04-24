cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_stats
label: seqkit_stats
doc: "simple statistics of FASTA/Q files\n\nTool homepage: https://github.com/shenwei356/seqkit"
inputs:
  - id: N_stats
    type:
      - 'null'
      - type: array
        items: string
    doc: append other N50-like stats as new columns. value range [0, 100], 
      multiple values supported, e.g., -N 50,90 or -N 50 -N 90
    inputBinding:
      position: 101
      prefix: --N
  - id: all_statistics
    type:
      - 'null'
      - boolean
    doc: all statistics, including quartiles of seq length, sum_gap, N50
    inputBinding:
      position: 101
      prefix: --all
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq)
    inputBinding:
      position: 101
      prefix: --alphabet-guess-seq-length
  - id: basename
    type:
      - 'null'
      - boolean
    doc: only output basename of files
    inputBinding:
      position: 101
      prefix: --basename
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: fq_encoding
    type:
      - 'null'
      - string
    doc: "fastq quality encoding. available values: 'sanger', 'solexa', 'illumina-1.3+',
      'illumina-1.5+', 'illumina-1.8+'."
    inputBinding:
      position: 101
      prefix: --fq-encoding
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
  - id: skip_err
    type:
      - 'null'
      - boolean
    doc: skip error, only show warning message
    inputBinding:
      position: 101
      prefix: --skip-err
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: skip input file checking when given files or a file list.
    inputBinding:
      position: 101
      prefix: --skip-file-check
  - id: stdin_label
    type:
      - 'null'
      - string
    doc: label for replacing default "-" for stdin
    inputBinding:
      position: 101
      prefix: --stdin-label
  - id: tabular
    type:
      - 'null'
      - boolean
    doc: output in machine-friendly tabular format
    inputBinding:
      position: 101
      prefix: --tabular
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
