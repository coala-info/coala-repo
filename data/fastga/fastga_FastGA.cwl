cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastGA
label: fastga_FastGA
doc: "FastGA is a fast whole-genome aligner. It aligns two genomes (FASTA or 1-code files) and streams PAF or PSL, or writes a 1aln file.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
arguments:
  - position: 100
    valueFrom: $(inputs.source1.basename)
  - position: 101
    valueFrom: '$(inputs.source2 ? inputs.source2.basename : null)'
inputs:
  - id: source1
    type: File
    doc: 'First genome (FASTA, .fa/.fna/.fasta with optional .gz, or a 1-code sequence file).'
  - id: source2
    type:
      - 'null'
      - File
    doc: 'Second genome. If absent, the first genome is aligned against itself.'
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format for the stream on standard output: -paf[mxsS]*, for example -paf, -pafx, -pafm, -pafs, -pafS, or -psl. Default is -paf.'
    inputBinding:
      position: 1
  - id: align_output
    type:
      - 'null'
      - string
    doc: Write a 1-code alignment file with this name instead of a stream (the .1aln extension is added).
    inputBinding:
      position: 101
      prefix: '-1:'
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose mode, output statistics as proceed.'
    inputBinding:
      position: 101
      prefix: '-v'
  - id: keep
    type:
      - 'null'
      - boolean
    doc: 'Keep any generated .1gdb''s and .gix''s.'
    inputBinding:
      position: 101
      prefix: '-k'
  - id: soft_mask
    type:
      - 'null'
      - boolean
    doc: Use soft mask information if available.
    inputBinding:
      position: 101
      prefix: '-M'
  - id: symmetric_seeding
    type:
      - 'null'
      - boolean
    doc: Use symmetric seeding (not recommended). Seed adaptamers from both genomes.
    inputBinding:
      position: 101
      prefix: '-S'
  - id: log_file
    type:
      - 'null'
      - string
    doc: Output log to specified file.
    inputBinding:
      position: 101
      prefix: '-L:'
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. [default: 8]'
    inputBinding:
      position: 101
      prefix: '-T'
      separate: false
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: 'Directory to use for temporary files. [default: $TMPDIR]'
    inputBinding:
      position: 101
      prefix: '-P'
      separate: false
  - id: adaptive_seed_count_cutoff
    type:
      - 'null'
      - int
    doc: 'Adaptive seed count cutoff. [default: 10]'
    inputBinding:
      position: 101
      prefix: '-f'
      separate: false
  - id: min_seed_chain_coverage
    type:
      - 'null'
      - int
    doc: 'Minimum seed chain coverage in both genomes. [default: 85]'
    inputBinding:
      position: 101
      prefix: '-c'
      separate: false
  - id: seed_chain_start_threshold
    type:
      - 'null'
      - int
    doc: 'Threshold for starting a new seed chain. [default: 1000]'
    inputBinding:
      position: 101
      prefix: '-s'
      separate: false
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: 'Minimum alignment length. [default: 100]'
    inputBinding:
      position: 101
      prefix: '-l'
      separate: false
  - id: min_alignment_identity
    type:
      - 'null'
      - float
    doc: 'Minimum alignment identity. [default: 0.7]'
    inputBinding:
      position: 101
      prefix: '-i'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: alignment_1aln
    type:
      - 'null'
      - File
    doc: 1-code alignment file written when align_output is set.
    outputBinding:
      glob: $(inputs.align_output).1aln
  - id: log
    type:
      - 'null'
      - File
    doc: Log file written when log_file is set.
    outputBinding:
      glob: $(inputs.log_file)
  - id: generated_files
    type:
      type: array
      items: File
    doc: Genome databases and indexes kept when keep is set.
    outputBinding:
      glob:
        - '*.1gdb'
        - '.*.bps'
        - '*.gix'
        - '.*.ktab.*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.source1)
      - $(inputs.source2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_FastGA.out
