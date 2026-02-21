cwlVersion: v1.2
class: CommandLineTool
baseCommand: cap3
label: cap3
doc: "CAP3 is a DNA sequence assembly program for small-scale assembly projects.\n
  \nTool homepage: https://github.com/crockwell/Cap3D"
inputs:
  - id: file_of_reads
    type: File
    doc: File of DNA reads in FASTA format
    inputBinding:
      position: 1
  - id: band_expansion_size
    type:
      - 'null'
      - int
    doc: specify band expansion size N > 10
    default: 20
    inputBinding:
      position: 102
      prefix: -a
  - id: base_quality_cutoff_clip
    type:
      - 'null'
      - int
    doc: specify base quality cutoff for clipping N > 5
    default: 12
    inputBinding:
      position: 102
      prefix: -c
  - id: base_quality_cutoff_diff
    type:
      - 'null'
      - int
    doc: specify base quality cutoff for differences N > 15
    default: 20
    inputBinding:
      position: 102
      prefix: -b
  - id: chain_score_cutoff
    type:
      - 'null'
      - int
    doc: specify chain score cutoff N > 30
    default: 80
    inputBinding:
      position: 102
      prefix: -j
  - id: clearance_no_diff
    type:
      - 'null'
      - int
    doc: specify clearance between no. of diff N > 10
    default: 30
    inputBinding:
      position: 102
      prefix: -e
  - id: clipping_range
    type:
      - 'null'
      - int
    doc: specify clipping range N > 5
    default: 100
    inputBinding:
      position: 102
      prefix: -y
  - id: end_clipping_flag
    type:
      - 'null'
      - int
    doc: specify end clipping flag N >= 0
    default: 1
    inputBinding:
      position: 102
      prefix: -k
  - id: gap_penalty_factor
    type:
      - 'null'
      - int
    doc: specify gap penalty factor N > 0
    default: 6
    inputBinding:
      position: 102
      prefix: -g
  - id: match_score_factor
    type:
      - 'null'
      - int
    doc: specify match score factor N > 0
    default: 2
    inputBinding:
      position: 102
      prefix: -m
  - id: max_gap_length
    type:
      - 'null'
      - int
    doc: specify max gap length in any overlap N > 1
    default: 20
    inputBinding:
      position: 102
      prefix: -f
  - id: max_overhang_percent
    type:
      - 'null'
      - int
    doc: specify max overhang percent length N > 2
    default: 20
    inputBinding:
      position: 102
      prefix: -h
  - id: max_qscore_sum_diff
    type:
      - 'null'
      - int
    doc: specify max qscore sum at differences N > 20
    default: 200
    inputBinding:
      position: 102
      prefix: -d
  - id: max_word_matches
    type:
      - 'null'
      - int
    doc: specify max number of word matches N > 30
    default: 300
    inputBinding:
      position: 102
      prefix: -t
  - id: min_constraints_correction
    type:
      - 'null'
      - int
    doc: specify min number of constraints for correction N > 0
    default: 3
    inputBinding:
      position: 102
      prefix: -u
  - id: min_constraints_linking
    type:
      - 'null'
      - int
    doc: specify min number of constraints for linking N > 0
    default: 2
    inputBinding:
      position: 102
      prefix: -v
  - id: min_good_reads_clip_pos
    type:
      - 'null'
      - int
    doc: specify min no. of good reads at clip pos N > 0
    default: 3
    inputBinding:
      position: 102
      prefix: -z
  - id: mismatch_score_factor
    type:
      - 'null'
      - int
    doc: specify mismatch score factor N < 0
    default: -5
    inputBinding:
      position: 102
      prefix: -n
  - id: overlap_length_cutoff
    type:
      - 'null'
      - int
    doc: specify overlap length cutoff > 15
    default: 40
    inputBinding:
      position: 102
      prefix: -o
  - id: overlap_percent_identity_cutoff
    type:
      - 'null'
      - int
    doc: specify overlap percent identity cutoff N > 65
    default: 90
    inputBinding:
      position: 102
      prefix: -p
  - id: overlap_similarity_score_cutoff
    type:
      - 'null'
      - int
    doc: specify overlap similarity score cutoff N > 250
    default: 900
    inputBinding:
      position: 102
      prefix: -s
  - id: reverse_orientation_value
    type:
      - 'null'
      - int
    doc: specify reverse orientation value N >= 0
    default: 1
    inputBinding:
      position: 102
      prefix: -r
  - id: segment_pair_score_cutoff
    type:
      - 'null'
      - int
    doc: specify segment pair score cutoff N > 20
    default: 40
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: clipping_info_file
    type:
      - 'null'
      - File
    doc: specify file name for clipping information
    outputBinding:
      glob: $(inputs.clipping_info_file)
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: specify prefix string for output file names
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cap3:10.2011--1
