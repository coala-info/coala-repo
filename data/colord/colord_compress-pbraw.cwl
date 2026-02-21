cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - colord
  - compress-pbraw
label: colord_compress-pbraw
doc: "compress PacBio Raw data\n\nTool homepage: https://github.com/refresh-bio/colord"
inputs:
  - id: input
    type: File
    doc: input FASTQ/FASTA path (gzipped or not)
    inputBinding:
      position: 1
  - id: anchor_len
    type:
      - 'null'
      - int
    doc: 'anchor len (default: auto adjust)'
    inputBinding:
      position: 102
      prefix: --anchor-len
  - id: edit_script_mult
    type:
      - 'null'
      - float
    doc: multipier for predicted cost of storing read part as edit script
    default: 1.0
    inputBinding:
      position: 102
      prefix: --edit-script-mult
  - id: fill_factor_filtered_kmers
    type:
      - 'null'
      - float
    doc: fill factor of filtered k-mers hash table
    default: 0.75
    inputBinding:
      position: 102
      prefix: --fill-factor-filtered-kmers
  - id: fill_factor_kmers_to_reads
    type:
      - 'null'
      - float
    doc: fill factor of k-mers to reads hash table
    default: 0.8
    inputBinding:
      position: 102
      prefix: --fill-factor-kmers-to-reads
  - id: filter_modulo
    type:
      - 'null'
      - int
    doc: k-mers for which hash(k-mer) mod f != 0 will be filtered out before graph
      building
    default: 9
    inputBinding:
      position: 102
      prefix: --filter-modulo
  - id: highest_count
    type:
      - 'null'
      - int
    doc: maximal k-mer count
    default: 100
    inputBinding:
      position: 102
      prefix: --Highest-count
  - id: identifier
    type:
      - 'null'
      - string
    doc: header compression mode (main, none, org)
    default: org
    inputBinding:
      position: 102
      prefix: --identifier
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: 'k-mer length (default: auto adjust)'
    inputBinding:
      position: 102
      prefix: --kmer-len
  - id: lowest_count
    type:
      - 'null'
      - int
    doc: minimal k-mer count
    default: 3
    inputBinding:
      position: 102
      prefix: --Lowest-count
  - id: max_candidates
    type:
      - 'null'
      - int
    doc: maximal number of reference reads considered as reference
    default: 8
    inputBinding:
      position: 102
      prefix: --max-candidates
  - id: max_matches_mult
    type:
      - 'null'
      - float
    doc: if the number of matches between encode read R and reference read is r, then
      read is refused from encoding if r > max-matches-mult * len(R)
    default: 10.0
    inputBinding:
      position: 102
      prefix: --max-matches-mult
  - id: max_recurence_level
    type:
      - 'null'
      - int
    doc: maximal level of recurence when considering alternative reference reads
    default: 5
    inputBinding:
      position: 102
      prefix: --max-recurence-level
  - id: min_anchors
    type:
      - 'null'
      - int
    doc: if number of anchors common to encode read and reference candidate is lower
      than minAnchors candidate is refused
    default: 1
    inputBinding:
      position: 102
      prefix: --min-anchors
  - id: min_mmer_force_enc
    type:
      - 'null'
      - float
    doc: if A is set of m-mers in encode read R then read is accepted to encoding
      always if |A| > min-mmer-force-enc * len(R)
    default: 0.9
    inputBinding:
      position: 102
      prefix: --min-mmer-force-enc
  - id: min_mmer_frac
    type:
      - 'null'
      - float
    doc: if A is set of m-mers in encode read R then read is refused from encoding
      if |A| < min-mmer-frac * len(R)
    default: 0.5
    inputBinding:
      position: 102
      prefix: --min-mmer-frac
  - id: min_to_alt
    type:
      - 'null'
      - int
    doc: minimum length of encoding part to consider using alternative read
    default: 48
    inputBinding:
      position: 102
      prefix: --min-to-alt
  - id: priority
    type:
      - 'null'
      - string
    doc: compression quality (balanced, memory, ratio)
    inputBinding:
      position: 102
      prefix: --priority
  - id: qual
    type:
      - 'null'
      - string
    doc: quality compression mode (2-avg, 2-fix, 4-avg, 4-fix, 5-avg, 5-fix, avg,
      none, org)
    default: none
    inputBinding:
      position: 102
      prefix: --qual
  - id: qual_thresholds
    type:
      - 'null'
      - type: array
        items: int
    doc: quality thresholds for various modes
    inputBinding:
      position: 102
      prefix: --qual-thresholds
  - id: qual_values
    type:
      - 'null'
      - type: array
        items: int
    doc: quality values for decompression
    inputBinding:
      position: 102
      prefix: --qual-values
  - id: ref_reads_mode
    type:
      - 'null'
      - string
    doc: reference reads mode (all, sparse)
    default: sparse
    inputBinding:
      position: 102
      prefix: --Ref-reads-mode
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: optional reference genome path (multi-FASTA gzipped or not)
    inputBinding:
      position: 102
      prefix: --reference-genome
  - id: sparse_exponent
    type:
      - 'null'
      - float
    doc: sparse mode exponent
    default: 1.0
    inputBinding:
      position: 102
      prefix: --sparse-exponent
  - id: sparse_range
    type:
      - 'null'
      - float
    doc: sparse mode range
    default: 2.0
    inputBinding:
      position: 102
      prefix: --sparse-range
  - id: store_reference
    type:
      - 'null'
      - boolean
    doc: stores the reference genome in the archive, use only with `-G` flag
    inputBinding:
      position: 102
      prefix: --store-reference
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 32
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: archive path
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colord:1.1.0--h9ee0642_0
