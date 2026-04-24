cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_scat
label: seqkit_scat
doc: "real time recursive concatenation and streaming of fastx files\n\nTool homepage:
  https://github.com/shenwei356/seqkit"
inputs:
  - id: allow_gaps
    type:
      - 'null'
      - boolean
    doc: allow gap character (-) in sequences
    inputBinding:
      position: 101
      prefix: --allow-gaps
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq)
    inputBinding:
      position: 101
      prefix: --alphabet-guess-seq-length
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: delta
    type:
      - 'null'
      - int
    doc: minimum size increase in kilobytes to trigger parsing
    inputBinding:
      position: 101
      prefix: --delta
  - id: drop_time
    type:
      - 'null'
      - string
    doc: Notification drop interval
    inputBinding:
      position: 101
      prefix: --drop-time
  - id: find_only
    type:
      - 'null'
      - boolean
    doc: concatenate existing files and quit
    inputBinding:
      position: 101
      prefix: --find-only
  - id: format
    type:
      - 'null'
      - string
    doc: 'input and output format: fastq or fasta'
    inputBinding:
      position: 101
      prefix: --format
  - id: gz_only
    type:
      - 'null'
      - boolean
    doc: only look for gzipped files (.gz suffix)
    inputBinding:
      position: 101
      prefix: --gz-only
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
  - id: in_format
    type:
      - 'null'
      - string
    doc: 'input format: fastq or fasta'
    inputBinding:
      position: 101
      prefix: --in-format
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
  - id: out_format
    type:
      - 'null'
      - string
    doc: 'output format: fastq or fasta'
    inputBinding:
      position: 101
      prefix: --out-format
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
  - id: regexp
    type:
      - 'null'
      - string
    doc: regexp for watched files, by default guessed from the input format
    inputBinding:
      position: 101
      prefix: --regexp
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
  - id: time_limit
    type:
      - 'null'
      - string
    doc: quit after inactive for this time period
    inputBinding:
      position: 101
      prefix: --time-limit
  - id: wait_pid
    type:
      - 'null'
      - int
    doc: after process with this PID exited
    inputBinding:
      position: 101
      prefix: --wait-pid
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
