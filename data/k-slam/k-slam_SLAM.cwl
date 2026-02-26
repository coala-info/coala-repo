cwlVersion: v1.2
class: CommandLineTool
baseCommand: SLAM
label: k-slam_SLAM
doc: "Align paired reads from R1FILE and R2FILE against DATABASE and perform metagenomic
  analysis\n\nTool homepage: https://github.com/aindj/k-SLAM"
inputs:
  - id: r1file
    type: File
    doc: R1 file
    inputBinding:
      position: 1
  - id: r2file
    type:
      - 'null'
      - File
    doc: R2 file
    inputBinding:
      position: 2
  - id: database
    type: File
    doc: SLAM database file which reads will be aligned against
    inputBinding:
      position: 103
      prefix: --db
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: gap extend penalty (positive)
    default: 2
    inputBinding:
      position: 103
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: gap opening penalty (positive)
    default: 5
    inputBinding:
      position: 103
      prefix: --gap-open
  - id: just_align
    type:
      - 'null'
      - boolean
    doc: only perform alignments, not metagenomics
    inputBinding:
      position: 103
      prefix: --just-align
  - id: match_score
    type:
      - 'null'
      - int
    doc: match score
    default: 2
    inputBinding:
      position: 103
      prefix: --match-score
  - id: min_alignment_score
    type:
      - 'null'
      - int
    doc: alignment score cutoff
    default: 0
    inputBinding:
      position: 103
      prefix: --min-alignment-score
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatch penalty (positive)
    default: 3
    inputBinding:
      position: 103
      prefix: --mismatch-penalty
  - id: no_pseudo_assembly
    type:
      - 'null'
      - boolean
    doc: do not link alignments together
    inputBinding:
      position: 103
      prefix: --no-pseudo-assembly
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: Number of alignments to report in SAM file
    default: 10
    inputBinding:
      position: 103
      prefix: --num-alignments
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads from R1/R2 File to align
    default: 4294967295
    inputBinding:
      position: 103
      prefix: --num-reads
  - id: num_reads_at_once
    type:
      - 'null'
      - int
    doc: Reduce RAM usage by only analysing "arg" reads at once, this will 
      increase execution time
    default: 10000000
    inputBinding:
      position: 103
      prefix: --num-reads-at-once
  - id: sam_xa
    type:
      - 'null'
      - boolean
    doc: only output primary alignment lines, use XA field for secondary 
      alignments
    inputBinding:
      position: 103
      prefix: --sam-xa
  - id: score_fraction_threshold
    type:
      - 'null'
      - float
    doc: screen alignments with scores < this*top score
    default: 0.95
    inputBinding:
      position: 103
      prefix: --score-fraction-threshold
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write to this file instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
  - id: sam_file
    type:
      - 'null'
      - File
    doc: write SAM output to this file
    outputBinding:
      glob: $(inputs.sam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/k-slam:1.0--1
