cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqsizzle
  - enrich
label: seqsizzle_enrich
doc: "Find enriched k-mers in the reads. This can be used to identify potential adapter/primer
  sequences\n\nTool homepage: https://github.com/ChangqingW/SeqSizzle"
inputs:
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: detect_reverse_complement
    type:
      - 'null'
      - boolean
    doc: Detect and merge reverse complement k-mers
    inputBinding:
      position: 102
      prefix: --detect-reverse-complement
  - id: k_max
    type:
      - 'null'
      - int
    doc: Maximum k-mer length to check
    inputBinding:
      position: 102
      prefix: --k-max
  - id: k_min
    type:
      - 'null'
      - int
    doc: Minimum k-mer length to check
    inputBinding:
      position: 102
      prefix: --k-min
  - id: k_step
    type:
      - 'null'
      - int
    doc: Step size between k-values (arithmetic progression)
    inputBinding:
      position: 102
      prefix: --k-step
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Limit the total number of reads used for enrichment. Set to 0 to use 
      all reads
    inputBinding:
      position: 102
      prefix: --max-reads
  - id: min_count
    type:
      - 'null'
      - float
    doc: Minimum counts per read threshold for k-mers (overrides z-score if 
      provided). Accepts fractional values (e.g., 0.01 for 1 count per 100 
      reads)
    inputBinding:
      position: 102
      prefix: --min-count
  - id: sample
    type:
      - 'null'
      - boolean
    doc: If set, randomly sample `--max-reads` reads from the file instead of 
      taking the first N. Requires `--max-reads`
    inputBinding:
      position: 102
      prefix: --sample
  - id: skip_assemble
    type:
      - 'null'
      - boolean
    doc: Perform assembly with k_max k-mers
    inputBinding:
      position: 102
      prefix: --skip-assemble
  - id: substring_count_ratio_threshold
    type:
      - 'null'
      - float
    doc: Substring filtering counts ratio threshold. For k-mers that are 
      contained within longer k-mers, those with (shorter k-mer count) / (longer
      k-mer count) >= this threshold will be removed. For homopolymer k-mers, 
      the threshold is lowered to threshold^4
    inputBinding:
      position: 102
      prefix: --substring-count-ratio-threshold
  - id: top_kmers
    type:
      - 'null'
      - int
    doc: Number of top k-mers to keep per k value
    inputBinding:
      position: 102
      prefix: --top-kmers
  - id: z_score_threshold
    type:
      - 'null'
      - float
    doc: 'Z-score threshold for k-mer enrichment (default: 5.0)'
    inputBinding:
      position: 102
      prefix: --z-score-threshold
outputs:
  - id: output
    type: File
    doc: Path to write the output CSV file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqsizzle:0.4.1--h790517f_0
