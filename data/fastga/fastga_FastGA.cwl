cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastGA
label: fastga_FastGA
doc: "FastGA is a tool for aligning sequences.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: format
    type: string
    doc: Output format. Can be -paf[mxsS]*, -psl, or -1:<align:path>[.1aln].
    inputBinding:
      position: 1
  - id: source1
    type: File
    doc: First source sequence file.
    inputBinding:
      position: 2
  - id: source1_precursor
    type:
      - 'null'
      - string
    doc: Precursor for the first source file (e.g., .gix, .1gdb, .fa, .fna, 
      .fasta, .gz, or any 1-code sequence file type).
    inputBinding:
      position: 3
  - id: source2
    type:
      - 'null'
      - File
    doc: Second source sequence file.
    inputBinding:
      position: 4
  - id: source2_precursor
    type:
      - 'null'
      - string
    doc: Precursor for the second source file (e.g., .gix, .1gdb, .fa, .fna, 
      .fasta, .gz, or any 1-code sequence file type).
    inputBinding:
      position: 5
  - id: adaptive_seed_count_cutoff
    type:
      - 'null'
      - int
    doc: Adaptive seed count cutoff.
    inputBinding:
      position: 106
      prefix: -f
  - id: generate_1code_output
    type:
      - 'null'
      - File
    doc: Generate 1-code output to specified file.
    inputBinding:
      position: 106
      prefix: '-1'
  - id: keep_generated_files
    type:
      - 'null'
      - boolean
    doc: Keep any generated .1gdb's and .gix's.
    inputBinding:
      position: 106
      prefix: -k
  - id: log_file
    type:
      - 'null'
      - File
    doc: Output log to specified file.
    inputBinding:
      position: 106
      prefix: -L
  - id: min_alignment_identity
    type:
      - 'null'
      - float
    doc: Minimum alignment identity.
    inputBinding:
      position: 106
      prefix: -i
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Minimum alignment length.
    inputBinding:
      position: 106
      prefix: -l
  - id: min_seed_chain_coverage
    type:
      - 'null'
      - int
    doc: Minimum seed chain coverage in both genomes.
    inputBinding:
      position: 106
      prefix: -c
  - id: seed_adaptamers
    type:
      - 'null'
      - boolean
    doc: Seed adaptamers from both genomes.
    inputBinding:
      position: 106
      prefix: -S
  - id: seed_chain_start_threshold
    type:
      - 'null'
      - int
    doc: Threshold for starting a new seed chain.
    inputBinding:
      position: 106
      prefix: -s
  - id: stream_paf
    type:
      - 'null'
      - boolean
    doc: Stream PAF output
    inputBinding:
      position: 106
      prefix: -paf
  - id: stream_paf_long_cs
    type:
      - 'null'
      - boolean
    doc: Stream PAF output with CS string in long form
    inputBinding:
      position: 106
      prefix: -pafS
  - id: stream_paf_short_cs
    type:
      - 'null'
      - boolean
    doc: Stream PAF output with CS string in short form
    inputBinding:
      position: 106
      prefix: -pafs
  - id: stream_paf_with_cigar_equals
    type:
      - 'null'
      - boolean
    doc: Stream PAF output with CIGAR string with ='s
    inputBinding:
      position: 106
      prefix: -pafm
  - id: stream_paf_with_cigar_x
    type:
      - 'null'
      - boolean
    doc: Stream PAF output with CIGAR string with X's
    inputBinding:
      position: 106
      prefix: -pafx
  - id: stream_psl
    type:
      - 'null'
      - boolean
    doc: Stream PSL output
    inputBinding:
      position: 106
      prefix: -psl
  - id: symmetric_seeding
    type:
      - 'null'
      - boolean
    doc: Use symmetric seeding (not recommended).
    inputBinding:
      position: 106
      prefix: -S
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    inputBinding:
      position: 106
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 106
      prefix: -T
  - id: use_soft_mask
    type:
      - 'null'
      - boolean
    doc: Use soft mask information if available.
    inputBinding:
      position: 106
      prefix: -M
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 106
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_FastGA.out
