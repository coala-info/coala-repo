cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqkit_fx2tab
label: seqkit_fx2tab
doc: "convert FASTA/Q to tabular format, and provide various information,\nlike sequence
  length, GC content/GC skew.\n\nTool homepage: https://github.com/shenwei356/seqkit"
inputs:
  - id: alphabet
    type:
      - 'null'
      - boolean
    doc: print alphabet letters
    inputBinding:
      position: 101
      prefix: --alphabet
  - id: alphabet_guess_seq_length
    type:
      - 'null'
      - int
    doc: "length of sequence prefix of the first FASTA record based on\n         \
      \                               which seqkit guesses the sequence type (0 for
      whole seq)"
    inputBinding:
      position: 101
  - id: avg_qual
    type:
      - 'null'
      - boolean
    doc: print average quality of a read
    inputBinding:
      position: 101
      prefix: --avg-qual
  - id: base_content
    type:
      - 'null'
      - type: array
        items: string
    doc: "print base content. (case ignored, multiple values supported) e.g. -B AT\n\
      \                               -B N. Note that the denominator is the sequence
      length"
    inputBinding:
      position: 101
      prefix: --base-content
  - id: base_count
    type:
      - 'null'
      - type: array
        items: string
    doc: print base count. (case ignored, multiple values supported) e.g. -C AT 
      -C N
    inputBinding:
      position: 101
      prefix: --base-count
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: calculate case sensitive base content/sequence hash
    inputBinding:
      position: 101
      prefix: --case-sensitive
  - id: compress_level
    type:
      - 'null'
      - int
    doc: "compression level for gzip, zstd, xz and bzip2. type \"seqkit -h\"\n   \
      \                                     for the range and default value for each
      format"
    inputBinding:
      position: 101
  - id: gc
    type:
      - 'null'
      - boolean
    doc: print GC content, i.e., (G+C)/(G+C+A+T)
    inputBinding:
      position: 101
      prefix: --gc
  - id: gc_skew
    type:
      - 'null'
      - boolean
    doc: print GC-Skew
    inputBinding:
      position: 101
      prefix: --gc-skew
  - id: header_line
    type:
      - 'null'
      - boolean
    doc: print header line
    inputBinding:
      position: 101
      prefix: --header-line
  - id: id_ncbi
    type:
      - 'null'
      - boolean
    doc: "FASTA head is NCBI-style, e.g. >gi|110645304|ref|NC_002516.2|\n        \
      \                                Pseud..."
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
      - string
    doc: "file of input files list (one file per line), if given, they are\n     \
      \                                   appended to files from cli arguments"
    inputBinding:
      position: 101
      prefix: -X
  - id: length
    type:
      - 'null'
      - boolean
    doc: print sequence length
    inputBinding:
      position: 101
      prefix: --length
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width when outputting FASTA format (0 for no wrap)
    inputBinding:
      position: 101
      prefix: -w
  - id: name
    type:
      - 'null'
      - boolean
    doc: only print names (no sequences and qualities)
    inputBinding:
      position: 101
      prefix: --name
  - id: no_qual
    type:
      - 'null'
      - boolean
    doc: only output two column even for FASTQ file
    inputBinding:
      position: 101
      prefix: --no-qual
  - id: only_id
    type:
      - 'null'
      - boolean
    doc: print ID instead of full head
    inputBinding:
      position: 101
      prefix: --only-id
  - id: qual_ascii_base
    type:
      - 'null'
      - int
    doc: ASCII BASE, 33 for Phred+33 (default 33)
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
  - id: seq_hash
    type:
      - 'null'
      - boolean
    doc: print hash (MD5) of sequence
    inputBinding:
      position: 101
      prefix: --seq-hash
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "sequence type (dna|rna|protein|unlimit|auto) (for auto, it\n           \
      \                             automatically detect by the first sequence)"
    inputBinding:
      position: 101
      prefix: -t
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: "skip input file checking when given a file list if you believe\n       \
      \                                 these files do exist"
    inputBinding:
      position: 101
      prefix: --skip-file-check
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of CPUs. can also set with environment variable\n               \
      \                         SEQKIT_THREADS)"
    inputBinding:
      position: 101
      prefix: -j
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
