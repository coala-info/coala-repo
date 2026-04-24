cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_faidx
label: seqkit_faidx
doc: "create the FASTA index file and extract subsequences\n\nTool homepage: https://github.com/shenwei356/seqkit"
inputs:
  - id: fasta_file
    type: File
    doc: FASTA file
    inputBinding:
      position: 1
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Regions to extract
    inputBinding:
      position: 2
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq)
    inputBinding:
      position: 103
      prefix: --alphabet-guess-seq-length
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format
    inputBinding:
      position: 103
      prefix: --compress-level
  - id: full_head
    type:
      - 'null'
      - boolean
    doc: print full header line instead of just ID. New fasta index file ending 
      with .seqkit.fai will be created
    inputBinding:
      position: 103
      prefix: --full-head
  - id: id_ncbi
    type:
      - 'null'
      - boolean
    doc: FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2| Pseud...
    inputBinding:
      position: 103
      prefix: --id-ncbi
  - id: id_regexp
    type:
      - 'null'
      - string
    doc: regular expression for parsing ID
    inputBinding:
      position: 103
      prefix: --id-regexp
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore case
    inputBinding:
      position: 103
      prefix: --ignore-case
  - id: immediate_output
    type:
      - 'null'
      - boolean
    doc: print output immediately, do not use write buffer
    inputBinding:
      position: 103
      prefix: --immediate-output
  - id: infile_list
    type:
      - 'null'
      - File
    doc: file of input files list (one file per line), if given, they are 
      appended to files from cli arguments
    inputBinding:
      position: 103
      prefix: --infile-list
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap)
    inputBinding:
      position: 103
      prefix: --line-width
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 103
      prefix: --quiet
  - id: region_file
    type:
      - 'null'
      - File
    doc: file containing a list of regions
    inputBinding:
      position: 103
      prefix: --region-file
  - id: seq_type
    type:
      - 'null'
      - string
    doc: sequence type (dna|rna|protein|unlimit|auto) (for auto, it 
      automatically detect by the first sequence)
    inputBinding:
      position: 103
      prefix: --seq-type
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: skip input file checking when given a file list if you believe these 
      files do exist
    inputBinding:
      position: 103
      prefix: --skip-file-check
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. can also set with environment variable SEQKIT_THREADS)
    inputBinding:
      position: 103
      prefix: --threads
  - id: update_faidx
    type:
      - 'null'
      - boolean
    doc: update the fasta index file if it exists. Use this if you are not sure 
      whether the fasta file changed
    inputBinding:
      position: 103
      prefix: --update-faidx
  - id: use_regexp
    type:
      - 'null'
      - boolean
    doc: IDs are regular expression. But subseq region is not supported here.
    inputBinding:
      position: 103
      prefix: --use-regexp
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
