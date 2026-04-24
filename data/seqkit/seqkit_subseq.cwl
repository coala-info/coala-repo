cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_subseq
label: seqkit_subseq
doc: "get subsequences by region/gtf/bed, including flanking sequences.\n\nTool homepage:
  https://github.com/shenwei356/seqkit"
inputs:
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: length of sequence prefix of the first FASTA record based on which 
      seqkit guesses the sequence type (0 for whole seq) (default 10000)
    inputBinding:
      position: 101
      prefix: --alphabet-guess-seq-length
  - id: bed_file
    type:
      - 'null'
      - File
    doc: by tab-delimited BED file
    inputBinding:
      position: 101
      prefix: --bed
  - id: chr
    type:
      - 'null'
      - type: array
        items: string
    doc: select limited sequence with sequence IDs when using --gtf or --bed 
      (multiple value supported, case ignored)
    inputBinding:
      position: 101
      prefix: --chr
  - id: compress_level
    type:
      - 'null'
      - int
    doc: compression level for gzip, zstd, xz and bzip2. type "seqkit -h" for 
      the range and default value for each format (default -1)
    inputBinding:
      position: 101
      prefix: --compress-level
  - id: down_stream
    type:
      - 'null'
      - int
    doc: down stream length
    inputBinding:
      position: 101
      prefix: --down-stream
  - id: feature
    type:
      - 'null'
      - type: array
        items: string
    doc: select limited feature types (multiple value supported, case ignored, 
      only works with GTF)
    inputBinding:
      position: 101
      prefix: --feature
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: by GTF (version 2.2) file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: gtf_tag
    type:
      - 'null'
      - string
    doc: output this tag as sequence comment (default "gene_id")
    inputBinding:
      position: 101
      prefix: --gtf-tag
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
    doc: regular expression for parsing ID (default "^(\\S+)\\s?")
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
    doc: line width when outputting FASTA format (0 for no wrap) (default 60)
    inputBinding:
      position: 101
      prefix: --line-width
  - id: only_flank
    type:
      - 'null'
      - boolean
    doc: only return up/down stream sequence
    inputBinding:
      position: 101
      prefix: --only-flank
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: region
    type:
      - 'null'
      - string
    doc: by region. e.g 1:12 for first 12 bases, -12:-1 for last 12 bases, 13:-1
      for cutting first 12 bases. type "seqkit subseq -h" for more examples
    inputBinding:
      position: 101
      prefix: --region
  - id: region_coord
    type:
      - 'null'
      - boolean
    doc: append coordinates to sequence ID for -r/--region
    inputBinding:
      position: 101
      prefix: --region-coord
  - id: seq_type
    type:
      - 'null'
      - string
    doc: sequence type (dna|rna|protein|unlimit|auto) (for auto, it 
      automatically detect by the first sequence) (default "auto")
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
      (default 4)
    inputBinding:
      position: 101
      prefix: --threads
  - id: up_stream
    type:
      - 'null'
      - int
    doc: up stream length
    inputBinding:
      position: 101
      prefix: --up-stream
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
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqkit:2.12.0--he881be0_1
