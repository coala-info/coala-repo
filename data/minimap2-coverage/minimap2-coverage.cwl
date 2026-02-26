cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap2-coverage
label: minimap2-coverage
doc: "minimap2-coverage is a forked minimap2 program focusing on coverage, and tuned
  for LongQC.\n\nTool homepage: https://github.com/yfukasawa/LongQC"
inputs:
  - id: reference
    type: string
    doc: reference
    inputBinding:
      position: 1
  - id: reads
    type: string
    doc: reads
    inputBinding:
      position: 2
  - id: dump_index
    type:
      - 'null'
      - File
    doc: dump index to FILE
    inputBinding:
      position: 103
      prefix: --dump-index
  - id: filter
    type:
      - 'null'
      - boolean
    doc: read filtering mode. Can be used to filter out known contaminants (e.g.
      spiked-in control reads).
    inputBinding:
      position: 103
      prefix: --filter
  - id: homopolymer
    type:
      - 'null'
      - boolean
    doc: use homopolymer-compressed k-mer
    inputBinding:
      position: 103
      prefix: --homopolymer
  - id: index_size
    type:
      - 'null'
      - string
    doc: split index for every ~NUM input bases
    inputBinding:
      position: 103
      prefix: --index-size
  - id: k_mer
    type:
      - 'null'
      - int
    doc: k-mer size (no larger than 28)
    inputBinding:
      position: 103
      prefix: --k-mer
  - id: max_gap_length
    type:
      - 'null'
      - int
    doc: stop chain enlongation if there are no minimizers in INT-bp
    inputBinding:
      position: 103
      prefix: --max-gap-length
  - id: max_overhang
    type:
      - 'null'
      - int
    doc: stop chain enlongation if there are no minimizers in INT-bp
    inputBinding:
      position: 103
      prefix: --max-overhang
  - id: min_cnt
    type:
      - 'null'
      - int
    doc: minimal number of minimizers on a chain
    inputBinding:
      position: 103
      prefix: --min-cnt
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: minimal chaining score (matching bases minus log gap penalty)
    inputBinding:
      position: 103
      prefix: --min-coverage
  - id: min_overlap_len
    type:
      - 'null'
      - int
    doc: minimal number of minimizers on a chain
    inputBinding:
      position: 103
      prefix: --min-overlap-len
  - id: min_overlap_ratio
    type:
      - 'null'
      - float
    doc: minimum coverage ratio. overlap length is compared with overhang 
      length.
    inputBinding:
      position: 103
      prefix: --min-overlap-ratio
  - id: min_score
    type:
      - 'null'
      - int
    doc: minimal chaining score (matching bases minus log gap penalty)
    inputBinding:
      position: 103
      prefix: --min-score
  - id: min_score_t2
    type:
      - 'null'
      - int
    doc: chaining score to filter bad reads and must be >= min-score
    inputBinding:
      position: 103
      prefix: --min-score-t2
  - id: min_score_t3
    type:
      - 'null'
      - int
    doc: chaining score to filter bad and some spurious reads/overlap and must 
      be >= min-score-t2
    inputBinding:
      position: 103
      prefix: --min-score-t3
  - id: minimizer_cnt
    type:
      - 'null'
      - boolean
    doc: count minimizer apperance for all queries
    inputBinding:
      position: 103
      prefix: --minimizer-cnt
  - id: num_subset
    type:
      - 'null'
      - int
    doc: number of sequences for query subset
    inputBinding:
      position: 103
      prefix: --num-subset
  - id: skip_self
    type:
      - 'null'
      - boolean
    doc: skip self mappings (for the all-vs-subfraction mode)
    inputBinding:
      position: 103
      prefix: --skip-self
  - id: skip_self_ava
    type:
      - 'null'
      - boolean
    doc: skip self and dual mappings (for the all-vs-all mode)
    inputBinding:
      position: 103
      prefix: --skip-self-ava
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: window
    type:
      - 'null'
      - int
    doc: minizer window size
    inputBinding:
      position: 103
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimap2-coverage:1.2.0c--h577a1d6_4
stdout: minimap2-coverage.out
