cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_split2
label: seqkit_split2
doc: "split sequences into files by part size or number of parts\n\nTool homepage:
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
  - id: by_length
    type:
      - 'null'
      - string
    doc: split sequences into chunks of >=N bases, supports K/M/G suffix
    inputBinding:
      position: 101
      prefix: --by-length
  - id: by_length_prefix
    type:
      - 'null'
      - string
    doc: file prefix for --by-length. The placeholder "{read}" is needed for 
      paired-end files.
    inputBinding:
      position: 101
      prefix: --by-length-prefix
  - id: by_part
    type:
      - 'null'
      - int
    doc: split sequences into N parts with the round robin distribution
    inputBinding:
      position: 101
      prefix: --by-part
  - id: by_part_prefix
    type:
      - 'null'
      - string
    doc: file prefix for --by-part. The placeholder "{read}" is needed for 
      paired-end files.
    inputBinding:
      position: 101
      prefix: --by-part-prefix
  - id: by_size
    type:
      - 'null'
      - int
    doc: split sequences into multi parts with N sequences
    inputBinding:
      position: 101
      prefix: --by-size
  - id: by_size_prefix
    type:
      - 'null'
      - string
    doc: file prefix for --by-size. The placeholder "{read}" is needed for 
      paired-end files.
    inputBinding:
      position: 101
      prefix: --by-size-prefix
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
  - id: extension
    type:
      - 'null'
      - string
    doc: set output file extension, e.g., ".gz", ".xz", or ".zst"
    inputBinding:
      position: 101
      prefix: --extension
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite output directory
    inputBinding:
      position: 101
      prefix: --force
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
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory (default value is $infile.split)
    default: $infile.split
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    default: '-'
    inputBinding:
      position: 101
      prefix: --out-file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: read1
    type:
      - 'null'
      - File
    doc: (gzipped) read1 file
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: (gzipped) read2 file
    inputBinding:
      position: 101
      prefix: --read2
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
  - id: seqid_as_filename
    type:
      - 'null'
      - boolean
    doc: use the first sequence ID as the file name. E.g., using '-N -s 1' is 
      equal to 'seqkit split --by-id' but much faster and uses less memory.
    inputBinding:
      position: 101
      prefix: --seqid-as-filename
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
stdout: seqkit_split2.out
