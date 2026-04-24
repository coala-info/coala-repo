cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_rename
label: seqkit_rename
doc: "Rename duplicated IDs\n\nTool homepage: https://github.com/shenwei356/seqkit"
inputs:
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq)
    inputBinding:
      position: 101
  - id: by_name
    type:
      - 'null'
      - boolean
    doc: check duplication by full name instead of just id
    inputBinding:
      position: 101
      prefix: --by-name
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format
    inputBinding:
      position: 101
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
  - id: id_regexp
    type:
      - 'null'
      - string
    doc: regular expression for parsing ID
    inputBinding:
      position: 101
  - id: infile_list
    type:
      - 'null'
      - type: array
        items: File
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
  - id: multiple_outfiles
    type:
      - 'null'
      - boolean
    doc: write results into separated files for multiple input files
    inputBinding:
      position: 101
      prefix: --multiple-outfiles
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
  - id: rename_1st_rec
    type:
      - 'null'
      - boolean
    doc: rename the first record as well
    inputBinding:
      position: 101
      prefix: --rename-1st-rec
  - id: separator
    type:
      - 'null'
      - string
    doc: separator between original ID/name and the counter
    inputBinding:
      position: 101
      prefix: --separator
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
  - id: start_num
    type:
      - 'null'
      - int
    doc: starting count number for *duplicated* IDs/names, should be greater 
      than zero
    inputBinding:
      position: 101
      prefix: --start-num
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
