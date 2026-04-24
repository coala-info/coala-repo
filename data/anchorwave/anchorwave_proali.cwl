cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchorwave
  - proali
label: anchorwave_proali
doc: "Identify collinear blocks and perform genome alignment using anchors.\n\nTool
  homepage: https://github.com/baoxingsong/AnchorWave"
inputs:
  - id: anchor_sequence_file
    type: File
    doc: anchor sequence file (output from the gff2seq command)
    inputBinding:
      position: 101
      prefix: -as
  - id: chain_extend_gap_penalty
    type:
      - 'null'
      - float
    doc: chain extend gap penalty
    inputBinding:
      position: 101
      prefix: -E
  - id: chain_open_gap_penalty
    type:
      - 'null'
      - float
    doc: chain open gap penalty
    inputBinding:
      position: 101
      prefix: -O
  - id: extend_gap_penalty_1
    type:
      - 'null'
      - int
    doc: extend gap penalty
    inputBinding:
      position: 101
      prefix: -E1
  - id: extend_gap_penalty_2
    type:
      - 'null'
      - int
    doc: extend gap penalty 2
    inputBinding:
      position: 101
      prefix: -E2
  - id: indel_distance
    type:
      - 'null'
      - float
    doc: calculate IndelDistance
    inputBinding:
      position: 101
      prefix: -d
  - id: inter_anchor_length_threshold
    type:
      - 'null'
      - int
    doc: if the inter-anchor length is shorter than this value, stop trying to find
      new anchors
    inputBinding:
      position: 101
      prefix: -fa3
  - id: max_copy_number
    type:
      - 'null'
      - int
    doc: maximum expected copy number of each gene on each chromosome
    inputBinding:
      position: 101
      prefix: -e
  - id: max_gap_size
    type:
      - 'null'
      - int
    doc: maximum gap size for chain
    inputBinding:
      position: 101
      prefix: -D
  - id: min_cds_similarity
    type:
      - 'null'
      - float
    doc: minimum full-length CDS anchor hit similarity to use
    inputBinding:
      position: 101
      prefix: -mi
  - id: min_chain_score
    type:
      - 'null'
      - float
    doc: minimum chain score
    inputBinding:
      position: 101
      prefix: -I
  - id: min_exon_length
    type:
      - 'null'
      - int
    doc: minimum exon length to use (should be identical with the setting of gff2seq
      function)
    inputBinding:
      position: 101
      prefix: -m
  - id: min_novel_similarity
    type:
      - 'null'
      - float
    doc: minimum novel anchor hit similarity to use
    inputBinding:
      position: 101
      prefix: -mi2
  - id: minimal_ratio
    type:
      - 'null'
      - float
    doc: minimal ratio of e+1 similarity to 1 similarity to drop an anchor
    inputBinding:
      position: 101
      prefix: -y
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: mismatching penalty
    inputBinding:
      position: 101
      prefix: -B
  - id: no_new_anchors
    type:
      - 'null'
      - boolean
    doc: do not search for new anchors
    inputBinding:
      position: 101
      prefix: -ns
  - id: open_gap_penalty_1
    type:
      - 'null'
      - int
    doc: open gap penalty
    inputBinding:
      position: 101
      prefix: -O1
  - id: open_gap_penalty_2
    type:
      - 'null'
      - int
    doc: open gap penalty 2
    inputBinding:
      position: 101
      prefix: -O2
  - id: query_max_coverage
    type: int
    doc: query genome maximum alignment coverage
    inputBinding:
      position: 101
      prefix: -Q
  - id: query_sam_file
    type: File
    doc: sam file by mapping conserved sequence to query genome
    inputBinding:
      position: 101
      prefix: -a
  - id: ref_genome
    type: File
    doc: reference genome sequence
    inputBinding:
      position: 101
      prefix: -r
  - id: ref_gff_file
    type: File
    doc: reference GFF/GTF file
    inputBinding:
      position: 101
      prefix: -i
  - id: ref_max_coverage
    type: int
    doc: reference genome maximum alignment coverage
    inputBinding:
      position: 101
      prefix: -R
  - id: ref_sam_file
    type: File
    doc: sam file by mapping conserved sequence to reference genome
    inputBinding:
      position: 101
      prefix: -ar
  - id: target_genome_sequence
    type: File
    doc: target genome sequence
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: use_exon_records
    type:
      - 'null'
      - boolean
    doc: use exon records instead of CDS from the GFF file
    inputBinding:
      position: 101
      prefix: -x
  - id: window_width
    type:
      - 'null'
      - int
    doc: sequence alignment window width
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: output_anchors_file
    type: File
    doc: output anchors file
    outputBinding:
      glob: $(inputs.output_anchors_file)
  - id: output_maf
    type: File
    doc: output file in maf format
    outputBinding:
      glob: $(inputs.output_maf)
  - id: output_fragmentation_maf
    type: File
    doc: output sequence alignment for each anchor/inter-anchor region in maf format
    outputBinding:
      glob: $(inputs.output_fragmentation_maf)
  - id: output_bed
    type:
      - 'null'
      - File
    doc: output the sequence alignment method used for each anchor/inter-anchor region,
      in bed format
    outputBinding:
      glob: $(inputs.output_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anchorwave:1.2.6--h077b44d_0
