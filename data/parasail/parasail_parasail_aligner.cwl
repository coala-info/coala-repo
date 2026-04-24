cwlVersion: v1.2
class: CommandLineTool
baseCommand: parasail_aligner
label: parasail_parasail_aligner
doc: "Sequence alignment tool using the parasail library\n\nTool homepage: https://github.com/jeffdaily/parasail"
inputs:
  - id: alphabet_aliases
    type:
      - 'null'
      - string
    doc: Traceback will treat these pairs of characters as matches (e.g., 'TU')
    inputBinding:
      position: 101
      prefix: -A
  - id: aol
    type:
      - 'null'
      - int
    doc: Percent alignment length, must be 0 <= AOL <= 100
    inputBinding:
      position: 101
      prefix: -l
  - id: band_size
    type:
      - 'null'
      - int
    doc: Band size (for nw_banded)
    inputBinding:
      position: 101
      prefix: -k
  - id: batch_size
    type:
      - 'null'
      - int
    doc: How many alignments before writing output (0 to calculate based on memory
      budget)
    inputBinding:
      position: 101
      prefix: -b
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: If present, use case sensitive alignments, matrices, etc.
    inputBinding:
      position: 101
      prefix: -C
  - id: cutoff
    type:
      - 'null'
      - int
    doc: Exact match length cutoff, must be >= 1
    inputBinding:
      position: 101
      prefix: -c
  - id: dna_alphabet
    type:
      - 'null'
      - boolean
    doc: If present, assume DNA alphabet ACGT
    inputBinding:
      position: 101
      prefix: -d
  - id: funcname
    type:
      - 'null'
      - string
    doc: The parasail function name to use for alignment
    inputBinding:
      position: 101
      prefix: -a
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: Gap extension penalty, must be >= 0
    inputBinding:
      position: 101
      prefix: -e
  - id: gap_open
    type:
      - 'null'
      - int
    doc: Gap open penalty, must be >= 0
    inputBinding:
      position: 101
      prefix: -o
  - id: input_file
    type: File
    doc: Input file in FASTA format
    inputBinding:
      position: 101
      prefix: -f
  - id: match
    type:
      - 'null'
      - int
    doc: Match score, must be >= 0
    inputBinding:
      position: 101
      prefix: -M
  - id: matrix
    type:
      - 'null'
      - string
    doc: Substitution matrix
    inputBinding:
      position: 101
      prefix: -m
  - id: memory_budget
    type:
      - 'null'
      - string
    doc: Memory budget (e.g., 2GB)
    inputBinding:
      position: 101
      prefix: -r
  - id: mismatch
    type:
      - 'null'
      - int
    doc: Mismatch penalty, must be >= 0
    inputBinding:
      position: 101
      prefix: -X
  - id: no_suffix_array
    type:
      - 'null'
      - boolean
    doc: If present, don't use suffix array filter
    inputBinding:
      position: 101
      prefix: -x
  - id: os
    type:
      - 'null'
      - int
    doc: Percent optimal score over self score, must be 0 <= OS <= 100
    inputBinding:
      position: 101
      prefix: -i
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format, must be one of {EMBOSS,SAM,SAMH,SSW}
    inputBinding:
      position: 101
      prefix: -O
  - id: query_file
    type:
      - 'null'
      - File
    doc: Query file in FASTA format
    inputBinding:
      position: 101
      prefix: -q
  - id: sim
    type:
      - 'null'
      - int
    doc: Percent exact matches, must be 0 <= SIM <= 100
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, must be >= 1
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output, report input parameters and timing
    inputBinding:
      position: 101
      prefix: -v
  - id: verbose_memory
    type:
      - 'null'
      - boolean
    doc: Verbose memory output, report memory use
    inputBinding:
      position: 101
      prefix: -V
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parasail:2.6.2--h5ca1c30_1
