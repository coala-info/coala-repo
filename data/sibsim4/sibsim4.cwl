cwlVersion: v1.2
class: CommandLineTool
baseCommand: SIBsim4
label: sibsim4
doc: "SIBsim4 is a similarity-based tool for aligning a collection of expressed
  sequences (EST, mRNA) with a genomic DNA sequence, allowing for introns.\n\nTool
  homepage: https://github.com/c4chris/SIBsim4"
inputs:
  - id: dna
    type: File
    doc: Genomic DNA sequence file (FASTA)
    inputBinding:
      position: 200
  - id: est_db
    type: File
    doc: Database of expressed sequences (EST, mRNA) in FASTA format
    inputBinding:
      position: 201
  - id: output_format
    type:
      - 'null'
      - int
    doc: "Output format: 0 exon endpoints only, 1 alignment text, 3 both exon
      endpoints and alignment text, 4 both with polyA info, 5 same as 4 plus
      chimeric alignment text [0]"
    inputBinding:
      position: 101
      prefix: -A
  - id: msp_threshold_second_pass
    type:
      - 'null'
      - int
    doc: MSP score threshold for the second pass [15]
    inputBinding:
      position: 101
      prefix: -C
  - id: min_score_cutoff
    type:
      - 'null'
      - int
    doc: Minimum score cutoff [50]
    inputBinding:
      position: 101
      prefix: -c
  - id: cutoff_value
    type:
      - 'null'
      - int
    doc: Cutoff value [3]
    inputBinding:
      position: 101
      prefix: -E
  - id: score_filter_percent
    type:
      - 'null'
      - int
    doc: Score filter in percent (0 to disable filtering) [75]
    inputBinding:
      position: 101
      prefix: -f
  - id: join_exons_gap_percent
    type:
      - 'null'
      - int
    doc: Join exons when gap on genomic and RNA have lengths which differ at most
      by this percentage [10]
    inputBinding:
      position: 101
      prefix: -g
  - id: chimeric_percent
    type:
      - 'null'
      - int
    doc: Report chimeric transcripts when the best score is lower than this
      percentage of the overall RNA coverage and the chimera score is greater
      than this percentage of the RNA length (0 disables this report) [75]
    inputBinding:
      position: 101
      prefix: -H
  - id: intron_window_width
    type:
      - 'null'
      - int
    doc: Window width in which to search for intron splicing [6]
    inputBinding:
      position: 101
      prefix: -I
  - id: msp_threshold_first_pass
    type:
      - 'null'
      - int
    doc: MSP score threshold for the first pass [15]
    inputBinding:
      position: 101
      prefix: -K
  - id: splice_types
    type:
      - 'null'
      - string
    doc: A comma separated list of forward splice-types [GTAG,GCAG,GTAC,ATAC]
    inputBinding:
      position: 101
      prefix: -L
  - id: splice_site_match_window
    type:
      - 'null'
      - int
    doc: Scoring splice sites, evaluate match within M nucleotides [10]
    inputBinding:
      position: 101
      prefix: -M
  - id: dna_offset
    type:
      - 'null'
      - int
    doc: Offset nt positions in dna sequence by this amount [0]
    inputBinding:
      position: 101
      prefix: -o
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Penalty for a nucleotide mismatch [-5]
    inputBinding:
      position: 101
      prefix: -q
  - id: search_direction
    type:
      - 'null'
      - int
    doc: "Direction of search: 0 '+' strand only, 1 '-' strand only, 2 both
      strands and report the best match [2]"
    inputBinding:
      position: 101
      prefix: -R
  - id: match_reward
    type:
      - 'null'
      - int
    doc: Reward for a nucleotide match [1]
    inputBinding:
      position: 101
      prefix: -r
  - id: max_indels
    type:
      - 'null'
      - int
    doc: Max number of insertions and/or deletions evaluated on the DNA strand
      when determining the best splice site positions [2]
    inputBinding:
      position: 101
      prefix: -S
  - id: split_score_percent
    type:
      - 'null'
      - int
    doc: Split score in percent [75]
    inputBinding:
      position: 101
      prefix: -s
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size [12]
    inputBinding:
      position: 101
      prefix: -W
  - id: word_extension_termination
    type:
      - 'null'
      - int
    doc: Value for terminating word extensions [12]
    inputBinding:
      position: 101
      prefix: -X
outputs:
  - id: alignments
    type: stdout
    doc: Alignments of the expressed sequences to the genomic DNA
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sibsim4:v0.20-4-deb_cv1
stdout: sibsim4.out
