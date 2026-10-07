cwlVersion: v1.2
class: CommandLineTool
baseCommand: cap3
label: cap3
doc: "CAP3 is a DNA sequence assembly program for small-scale assembly projects.\n\
  \ \nTool homepage: https://github.com/crockwell/Cap3D"
inputs:
  - id: file_of_reads
    type: File
    doc: File of DNA reads in FASTA format. If the file of reads is named 
      'xyz', then the file of quality values must be named 'xyz.qual', and the
      file of constraints named 'xyz.con'. Output files are written beside it.
    secondaryFiles:
      - pattern: .qual
        required: false
      - pattern: .con
        required: false
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: band_expansion_size
    type:
      - 'null'
      - int
    doc: specify band expansion size N > 10
    inputBinding:
      position: 102
      prefix: -a
  - id: base_quality_cutoff_clip
    type:
      - 'null'
      - int
    doc: specify base quality cutoff for clipping N > 5
    inputBinding:
      position: 102
      prefix: -c
  - id: base_quality_cutoff_diff
    type:
      - 'null'
      - int
    doc: specify base quality cutoff for differences N > 15
    inputBinding:
      position: 102
      prefix: -b
  - id: chain_score_cutoff
    type:
      - 'null'
      - int
    doc: specify chain score cutoff N > 30
    inputBinding:
      position: 102
      prefix: -j
  - id: clearance_no_diff
    type:
      - 'null'
      - int
    doc: specify clearance between no. of diff N > 10
    inputBinding:
      position: 102
      prefix: -e
  - id: clipping_range
    type:
      - 'null'
      - int
    doc: specify clipping range N > 5
    inputBinding:
      position: 102
      prefix: -y
  - id: end_clipping_flag
    type:
      - 'null'
      - int
    doc: specify end clipping flag N >= 0
    inputBinding:
      position: 102
      prefix: -k
  - id: gap_penalty_factor
    type:
      - 'null'
      - int
    doc: specify gap penalty factor N > 0
    inputBinding:
      position: 102
      prefix: -g
  - id: match_score_factor
    type:
      - 'null'
      - int
    doc: specify match score factor N > 0
    inputBinding:
      position: 102
      prefix: -m
  - id: max_gap_length
    type:
      - 'null'
      - int
    doc: specify max gap length in any overlap N > 1
    inputBinding:
      position: 102
      prefix: -f
  - id: max_overhang_percent
    type:
      - 'null'
      - int
    doc: specify max overhang percent length N > 2
    inputBinding:
      position: 102
      prefix: -h
  - id: max_qscore_sum_diff
    type:
      - 'null'
      - int
    doc: specify max qscore sum at differences N > 20
    inputBinding:
      position: 102
      prefix: -d
  - id: max_word_matches
    type:
      - 'null'
      - int
    doc: specify max number of word matches N > 30
    inputBinding:
      position: 102
      prefix: -t
  - id: min_constraints_correction
    type:
      - 'null'
      - int
    doc: specify min number of constraints for correction N > 0
    inputBinding:
      position: 102
      prefix: -u
  - id: min_constraints_linking
    type:
      - 'null'
      - int
    doc: specify min number of constraints for linking N > 0
    inputBinding:
      position: 102
      prefix: -v
  - id: min_good_reads_clip_pos
    type:
      - 'null'
      - int
    doc: specify min no. of good reads at clip pos N > 0
    inputBinding:
      position: 102
      prefix: -z
  - id: mismatch_score_factor
    type:
      - 'null'
      - int
    doc: specify mismatch score factor N < 0
    inputBinding:
      position: 102
      prefix: -n
  - id: overlap_length_cutoff
    type:
      - 'null'
      - int
    doc: specify overlap length cutoff > 15
    inputBinding:
      position: 102
      prefix: -o
  - id: overlap_percent_identity_cutoff
    type:
      - 'null'
      - int
    doc: specify overlap percent identity cutoff N > 65
    inputBinding:
      position: 102
      prefix: -p
  - id: overlap_similarity_score_cutoff
    type:
      - 'null'
      - int
    doc: specify overlap similarity score cutoff N > 250
    inputBinding:
      position: 102
      prefix: -s
  - id: reverse_orientation_value
    type:
      - 'null'
      - int
    doc: specify reverse orientation value N >= 0
    inputBinding:
      position: 102
      prefix: -r
  - id: segment_pair_score_cutoff
    type:
      - 'null'
      - int
    doc: specify segment pair score cutoff N > 20
    inputBinding:
      position: 102
      prefix: -i
  - id: clipping_info_file
    type:
      - 'null'
      - File
    doc: specify file name for clipping information (an input file giving 
      clipping positions of the reads)
    inputBinding:
      position: 103
      prefix: -w
  - id: output_prefix_path
    type:
      - 'null'
      - string
    doc: specify prefix string for output file names (cap); outputs are named
      <reads file>.<prefix>.contigs, .singlets, .ace, ...
    inputBinding:
      position: 104
      prefix: -x
outputs:
  - id: output_prefix
    type:
      - 'null'
      - type: array
        items: File
    doc: all output files named <reads file>.<prefix>.*
    outputBinding:
      glob: '$(inputs.file_of_reads.basename).$(inputs.output_prefix_path ? 
        inputs.output_prefix_path : "cap").*'
  - id: contigs
    type: File
    doc: assembled contigs (FASTA)
    outputBinding:
      glob: '$(inputs.file_of_reads.basename).$(inputs.output_prefix_path ? 
        inputs.output_prefix_path : "cap").contigs'
  - id: singlets
    type: File
    doc: reads not assembled into contigs (FASTA)
    outputBinding:
      glob: '$(inputs.file_of_reads.basename).$(inputs.output_prefix_path ? 
        inputs.output_prefix_path : "cap").singlets'
  - id: ace
    type: File
    doc: assembly in ACE format
    outputBinding:
      glob: '$(inputs.file_of_reads.basename).$(inputs.output_prefix_path ? 
        inputs.output_prefix_path : "cap").ace'
  - id: alignments
    type: stdout
    doc: overlaps and multiple alignments printed to standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.file_of_reads)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cap3:10.2011--1
stdout: $(inputs.file_of_reads.basename).cap3.out
