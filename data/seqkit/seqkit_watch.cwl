cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_watch
label: seqkit_watch
doc: "monitoring and online histograms of sequence features\n\nTool homepage: https://github.com/shenwei356/seqkit"
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
  - id: bins
    type:
      - 'null'
      - int
    doc: number of histogram bins
    default: -1
    inputBinding:
      position: 101
      prefix: --bins
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
  - id: delay
    type:
      - 'null'
      - int
    doc: sleep this many seconds after online plotting
    default: 1
    inputBinding:
      position: 101
      prefix: --delay
  - id: dump
    type:
      - 'null'
      - boolean
    doc: print histogram data to stderr instead of plotting
    inputBinding:
      position: 101
      prefix: --dump
  - id: fields
    type:
      - 'null'
      - string
    doc: 'target fields, available values: ReadLen, MeanQual, GC, GCSkew'
    default: ReadLen
    inputBinding:
      position: 101
      prefix: --fields
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
  - id: list_fields
    type:
      - 'null'
      - boolean
    doc: print out a list of available fields
    inputBinding:
      position: 101
      prefix: --list-fields
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: log10(x+1) transform numeric values
    inputBinding:
      position: 101
      prefix: --log
  - id: pass_through
    type:
      - 'null'
      - boolean
    doc: pass through mode (write input to stdout)
    inputBinding:
      position: 101
      prefix: --pass
  - id: print_freq
    type:
      - 'null'
      - int
    doc: print/report after this many records (-1 for print after EOF)
    default: -1
    inputBinding:
      position: 101
      prefix: --print-freq
  - id: qual_ascii_base
    type:
      - 'null'
      - int
    doc: ASCII BASE, 33 for Phred+33
    default: 33
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
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: supress all plotting to stderr
    inputBinding:
      position: 101
      prefix: --quiet-mode
  - id: reset
    type:
      - 'null'
      - boolean
    doc: reset histogram after every report
    inputBinding:
      position: 101
      prefix: --reset
  - id: save_image
    type:
      - 'null'
      - string
    doc: save histogram to this PDF/image file
    inputBinding:
      position: 101
      prefix: --img
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
