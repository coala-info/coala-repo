cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit split
label: seqkit_split
doc: "split sequences into files by name ID, subsequence of given region, part size
  or number of parts.\n\nTool homepage: https://github.com/shenwei356/seqkit"
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
  - id: by_id
    type:
      - 'null'
      - boolean
    doc: split squences according to sequence ID
    inputBinding:
      position: 101
      prefix: --by-id
  - id: by_id_prefix
    type:
      - 'null'
      - string
    doc: file prefix for --by-id
    inputBinding:
      position: 101
      prefix: --by-id-prefix
  - id: by_part
    type:
      - 'null'
      - int
    doc: split sequences into N parts
    inputBinding:
      position: 101
      prefix: --by-part
  - id: by_part_prefix
    type:
      - 'null'
      - string
    doc: file prefix for --by-part
    inputBinding:
      position: 101
      prefix: --by-part-prefix
  - id: by_region
    type:
      - 'null'
      - string
    doc: split squences according to subsequence of given region. e.g 1:12 for 
      first 12 bases, -12:-1 for last 12 bases. type "seqkit split -h" for more 
      examples
    inputBinding:
      position: 101
      prefix: --by-region
  - id: by_region_prefix
    type:
      - 'null'
      - string
    doc: file prefix for --by-region
    inputBinding:
      position: 101
      prefix: --by-region-prefix
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
    doc: file prefix for --by-size
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
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: dry run, just print message and no files will be created.
    inputBinding:
      position: 101
      prefix: --dry-run
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
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore case when using -i/--by-id
    inputBinding:
      position: 101
      prefix: --ignore-case
  - id: infile_list
    type:
      - 'null'
      - type: array
        items: File
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 101
      prefix: -X
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
    default: 60
    inputBinding:
      position: 101
      prefix: -w
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
      prefix: -o
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
stdout: seqkit_split.out
