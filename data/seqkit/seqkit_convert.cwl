cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit convert
label: seqkit_convert
doc: "convert FASTQ quality encoding between Sanger, Solexa and Illumina\n\nTool homepage:
  https://github.com/shenwei356/seqkit"
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
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: dry run
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: force
    type:
      - 'null'
      - boolean
    doc: for Illumina-1.8+ -> Sanger, truncate scores > 40 to 40
    inputBinding:
      position: 101
      prefix: --force
  - id: from_encoding
    type:
      - 'null'
      - string
    doc: source quality encoding. if not given, we'll guess it
    inputBinding:
      position: 101
      prefix: --from
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
  - id: num_records_guess
    type:
      - 'null'
      - int
    doc: number of records for guessing quality encoding
    default: 1000
    inputBinding:
      position: 101
      prefix: --nrecords
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
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. can also set with environment variable SEQKIT_THREADS)
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: thresh_b_in_n_most_common
    type:
      - 'null'
      - int
    doc: threshold of 'B' in top N most common quality for guessing Illumina 
      1.5.
    default: 2
    inputBinding:
      position: 101
      prefix: --thresh-B-in-n-most-common
  - id: thresh_illumina1.5_frac
    type:
      - 'null'
      - float
    doc: threshold of faction of Illumina 1.5 in the leading N records
    default: 0.1
    inputBinding:
      position: 101
      prefix: --thresh-illumina1.5-frac
  - id: to_encoding
    type:
      - 'null'
      - string
    doc: target quality encoding
    default: Sanger
    inputBinding:
      position: 101
      prefix: --to
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
