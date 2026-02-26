cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - fastxmod
label: sqt_fastxmod
doc: "Modify FASTA and FASTQ files by picking subsets and modifying individual entries.\n\
  \nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: input_file
    type: File
    doc: input FASTA or FASTQ file
    inputBinding:
      position: 1
  - id: allowed_characters
    type:
      - 'null'
      - string
    doc: 'Discard reads that contain characters other than those in CHARS. CHARS is
      case-sensitive. Example: -c ACGTacgt.'
    inputBinding:
      position: 102
      prefix: --allowed-characters
  - id: constant_quality
    type:
      - 'null'
      - int
    doc: Set all quality values to QUALITY. Use this to convert from FASTA to 
      FASTQ.
    inputBinding:
      position: 102
      prefix: --constant-quality
  - id: length
    type:
      - 'null'
      - int
    doc: 'Shorten records to LENGTH (default: do not shorten)'
    inputBinding:
      position: 102
      prefix: --length
  - id: limit
    type:
      - 'null'
      - int
    doc: 'Pick only the first N sequences (default: all)'
    inputBinding:
      position: 102
      prefix: --limit
  - id: lower
    type:
      - 'null'
      - boolean
    doc: Convert sequence characters to lowercase
    inputBinding:
      position: 102
      prefix: --lower
  - id: max_errors
    type:
      - 'null'
      - int
    doc: Discard reads whose expected number of errors (computed from quality 
      values) exceeds ERRORS.
    inputBinding:
      position: 102
      prefix: --max-errors
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: Discard reads shorter than LENGTH
    inputBinding:
      position: 102
      prefix: --minimum-length
  - id: names_file
    type:
      - 'null'
      - File
    doc: Keep only records whose name occurs in FILE (one per line)
    inputBinding:
      position: 102
      prefix: --names
  - id: not_names_file
    type:
      - 'null'
      - File
    doc: Discard records whose name occurs in FILE (one per line)
    inputBinding:
      position: 102
      prefix: --not-names
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: Always output FASTA (drop qualities if input is FASTQ)
    inputBinding:
      position: 102
      prefix: --fasta
  - id: quality_cutoff
    type:
      - 'null'
      - float
    doc: Quality cutoff. Only when input format is FASTQ
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Reverse-complement each sequence
    inputBinding:
      position: 102
      prefix: --reverse-complement
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Set random seed for reproducible runs. Relevant when --substitution-rate
      is used.(default: use different seed each run)'
    inputBinding:
      position: 102
      prefix: --seed
  - id: substitute_prob
    type:
      - 'null'
      - float
    doc: Randomly substitute bases at probability PROB.
    default: 0
    inputBinding:
      position: 102
      prefix: --substitute
  - id: unique_names
    type:
      - 'null'
      - boolean
    doc: Make record names unique by appending _1, _2 etc. when necessary
    inputBinding:
      position: 102
      prefix: --unique-names
  - id: upper
    type:
      - 'null'
      - boolean
    doc: Convert sequence characters to uppercase
    inputBinding:
      position: 102
      prefix: --upper
  - id: width
    type:
      - 'null'
      - int
    doc: 'Characters per line in output FASTA (default: 80). Set to 0 to disallow
      line breaks entirely. This is ignored for FASTQ files.'
    default: 80
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_fastxmod.out
