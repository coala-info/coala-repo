cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqsizzle
arguments:
  - position: 20
    valueFrom: summarize
label: seqsizzle_summarize
doc: "Summarize the reads with patterns specified by the --patterns argument or the
  adapter flags. Make sure you supply the flags BEFORE the subcommand, e.g. `./SeqSizzle
  my.fastq -p my_patterns.csv --adapter-3p summarize`. '..' indicats unmatched regions
  of positive length, '-' indicates the patterns are overlapped, print the number
  of reads that match each pattern combination in TSV format. To be moved to the UI
  in the future\n\nTool homepage: https://github.com/ChangqingW/SeqSizzle"
inputs:
  - id: input_file
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 1
  - id: adapter_3p
    type:
      - 'null'
      - boolean
    doc: "Start with 10x 3' kit adaptors: partial Read1 (CTACACGACGCTCTTCCGATCT),
      partial TSO (CCCATGTACTCTGCGTTGATACCA), both with reverse complement, and
      Poly(>10)A/T"
    inputBinding:
      position: 2
      prefix: --adapter-3p
  - id: adapter_5p
    type:
      - 'null'
      - boolean
    doc: "Start with 10x 5' kit adaptors: partial Read1, partial Read2
      (AGATCGGAAGAGCACACGTCTGAA), TSO (TTTCTTATATGGG), with reverse complements,
      and Poly(>10)A/T"
    inputBinding:
      position: 2
      prefix: --adapter-5p
  - id: patterns
    type:
      - 'null'
      - File
    doc: "Start with patterns from a CSV file. Must have the following header:
      pattern,color,editdistance,comment"
    inputBinding:
      position: 2
      prefix: --patterns
  - id: counts
    type:
      - 'null'
      - boolean
    doc: Print the counts of each summarized catagory instead of the percentage
    inputBinding:
      position: 21
      prefix: --counts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
stdout: seqsizzle_summarize.out
