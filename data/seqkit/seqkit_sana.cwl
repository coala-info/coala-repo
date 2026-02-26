cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqkit
  - sana
label: seqkit_sana
doc: "sanitize broken single line FASTQ files\nSana is a resilient FASTQ/FASTA parser.
  Unlike many parsers,\nit won't stop at the first error. Instead, it skips malformed
  records\nand continues processing the file.\n\nSana currently supports this FASTQ
  dialect:\n\n  - One line for each sequence and quality value\n\nTool homepage: https://github.com/shenwei356/seqkit"
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
    doc: "length of sequence prefix of the first FASTA record based on\nwhich seqkit
      guesses the sequence type (0 for whole seq)"
    default: 10000
    inputBinding:
      position: 101
  - id: compress_level
    type:
      - 'null'
      - int
    doc: "compression level for gzip, zstd, xz and bzip2. type \"seqkit -h\"\nfor
      the range and default value for each format"
    default: -1
    inputBinding:
      position: 101
  - id: format
    type:
      - 'null'
      - string
    doc: 'input and output format: fastq or fasta'
    default: fastq
    inputBinding:
      position: 101
      prefix: --format
  - id: id_ncbi
    type:
      - 'null'
      - boolean
    doc: "FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|\nPseud..."
    inputBinding:
      position: 101
  - id: id_regexp
    type:
      - 'null'
      - string
    doc: regular expression for parsing ID
    default: ^(\S+)\s?
    inputBinding:
      position: 101
  - id: infile_list
    type:
      - 'null'
      - File
    doc: "file of input files list (one file per line), if given, they are\nappended
      to files from cli arguments"
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'input format: fastq or fasta'
    inputBinding:
      position: 101
      prefix: --in-format
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap)
    default: 60
    inputBinding:
      position: 101
      prefix: --line-width
  - id: output_format
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
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "sequence type (dna|rna|protein|unlimit|auto) (for auto, it\nautomatically
      detect by the first sequence)"
    default: auto
    inputBinding:
      position: 101
      prefix: --seq-type
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: "skip input file checking when given a file list if you believe\nthese files
      do exist"
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of CPUs. can also set with environment variable\nSEQKIT_THREADS)"
    default: 4
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
