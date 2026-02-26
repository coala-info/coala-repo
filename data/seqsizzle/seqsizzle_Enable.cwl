cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqsizzle
label: seqsizzle_Enable
doc: "A pager for viewing FASTQ and FASTA files with fuzzy matching, allowing different
  adaptors to be colored differently.\n\nTool homepage: https://github.com/ChangqingW/SeqSizzle"
inputs:
  - id: file
    type: File
    doc: The FASTQ or FASTA file to view (supports .fastq, .fasta, .fa, .fq and 
      their .gz variants)
    inputBinding:
      position: 1
  - id: command
    type:
      - 'null'
      - string
    doc: Command to execute (summarize, enrich, help)
    inputBinding:
      position: 2
  - id: adapter_3p
    type:
      - 'null'
      - boolean
    doc: "Start with 10x 3' kit adaptors:\n           - Patrial Read1: CTACACGACGCTCTTCCGATCT
      (and reverse complement)\n           - Partial TSO: CCCATGTACTCTGCGTTGATACCA
      (and reverse complement)\n           - Poly(>10)A/T"
    inputBinding:
      position: 103
      prefix: --adapter-3p
  - id: adapter_5p
    type:
      - 'null'
      - boolean
    doc: "Start with 10x 5' kit adaptors\n           - Patrial Read1: CTACACGACGCTCTTCCGATCT
      (and reverse complement)\n           - Patrial Read2: AGATCGGAAGAGCACACGTCTGAA
      (and reverse complement)\n           - TSO: TTTCTTATATGGG (and reverse complement)\n\
      \           - Poly(>10)A/T"
    inputBinding:
      position: 103
      prefix: --adapter-5p
  - id: no_quality_italic
    type:
      - 'null'
      - boolean
    doc: Disable italic styling for low quality bases
    inputBinding:
      position: 103
      prefix: --no-quality-italic
  - id: patterns
    type:
      - 'null'
      - File
    doc: "Start with patterns from a CSV file\n          Must have the following header:\n\
      \          pattern,color,editdistance,comment"
    inputBinding:
      position: 103
      prefix: --patterns
  - id: quality_colors
    type:
      - 'null'
      - boolean
    doc: Enable background color styling based on quality scores. You will 
      probably have a hard time distinguishing forground colors from background 
      colors, so this is disabled by default
    inputBinding:
      position: 103
      prefix: --quality-colors
  - id: quality_italic
    type:
      - 'null'
      - boolean
    doc: Enable italic styling for low quality bases (enabled by default)
    inputBinding:
      position: 103
      prefix: --quality-italic
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Quality threshold for styling
    default: 10
    inputBinding:
      position: 103
      prefix: --quality-threshold
outputs:
  - id: save_patterns
    type:
      - 'null'
      - File
    doc: Save the search panel to a CSV file before quitting. To be removed in 
      the future since you can now hit Ctrl-S in the search panel to save the 
      patterns
    outputBinding:
      glob: $(inputs.save_patterns)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
