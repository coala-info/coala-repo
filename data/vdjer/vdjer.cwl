cwlVersion: v1.2
class: CommandLineTool
baseCommand: vdjer
label: vdjer
doc: "vdjer\n\nTool homepage: https://github.com/mozack/vdjer"
inputs:
  - id: anchor_mismatches
    type:
      - 'null'
      - int
    doc: 'anchor mismatches (default: 4)'
    default: 4
    inputBinding:
      position: 101
      prefix: --am
  - id: c_region_locus
    type: string
    doc: C region locus
    inputBinding:
      position: 101
      prefix: --cr
  - id: chain
    type: string
    doc: chain <IGH|IGK|IGL>
    inputBinding:
      position: 101
      prefix: --chain
  - id: conserved_j_amino_acid
    type:
      - 'null'
      - string
    doc: conserved J amino acid (W|F)
    inputBinding:
      position: 101
      prefix: --jc
  - id: contig_filtering_start_position
    type:
      - 'null'
      - int
    doc: 'start position for contig filtering (default: 52)'
    default: 52
    inputBinding:
      position: 101
      prefix: --e0
  - id: contig_filtering_stop_position
    type:
      - 'null'
      - int
    doc: 'stop position for contig filtering (default: 411)'
    default: 411
    inputBinding:
      position: 101
      prefix: --e1
  - id: expected_median_insert_length
    type: int
    doc: expected / median insert length
    inputBinding:
      position: 101
      prefix: --ins
  - id: input_bam
    type: File
    doc: Input BAM must be specified
    inputBinding:
      position: 101
      prefix: --in
  - id: j_extension
    type:
      - 'null'
      - int
    doc: 'J extension (default: 162)'
    default: 162
    inputBinding:
      position: 101
      prefix: --jext
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'kmer size (default: 35)'
    default: 35
    inputBinding:
      position: 101
      prefix: --k
  - id: mate_span_distance
    type:
      - 'null'
      - int
    doc: 'mate span distance (default: 48)'
    default: 48
    inputBinding:
      position: 101
      prefix: --ms
  - id: max_window_length_between_conserved_amino_acids
    type:
      - 'null'
      - int
    doc: max window length between conserved amino acids
    inputBinding:
      position: 101
      prefix: --maw
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: 'min base quality (default: 90)'
    default: 90
    inputBinding:
      position: 101
      prefix: --mq
  - id: min_contig_score
    type:
      - 'null'
      - int
    doc: 'min contig score (default: -5)'
    default: -5
    inputBinding:
      position: 101
      prefix: --mcs
  - id: min_node_frequency
    type:
      - 'null'
      - int
    doc: 'min node frequency (default: 3)'
    default: 3
    inputBinding:
      position: 101
      prefix: --mf
  - id: min_source_node_homology_score
    type:
      - 'null'
      - int
    doc: 'min source node homology score (default: 30)'
    default: 30
    inputBinding:
      position: 101
      prefix: --mrs
  - id: min_window_length_between_conserved_amino_acids
    type:
      - 'null'
      - int
    doc: min window length between conserved amino acids
    inputBinding:
      position: 101
      prefix: --miw
  - id: read_filter_floor
    type:
      - 'null'
      - int
    doc: 'read filter floor (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --rf
  - id: read_span_distance
    type:
      - 'null'
      - int
    doc: 'read span distance (default: 35)'
    default: 35
    inputBinding:
      position: 101
      prefix: --rs
  - id: ref_dir
    type: Directory
    doc: reference directory
    inputBinding:
      position: 101
      prefix: --ref-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: 'threads (default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --t
  - id: v_region_locus
    type: string
    doc: V region locus (chr:start-stop)
    inputBinding:
      position: 101
      prefix: --vr
  - id: vregion_kmer_size
    type:
      - 'null'
      - int
    doc: 'vregion kmer size (default: 15)'
    default: 15
    inputBinding:
      position: 101
      prefix: --vk
  - id: window_overlap_check_size
    type:
      - 'null'
      - int
    doc: window overlap check size
    inputBinding:
      position: 101
      prefix: --wo
  - id: window_span
    type:
      - 'null'
      - int
    doc: 'window span (default: 486)'
    default: 486
    inputBinding:
      position: 101
      prefix: --ws
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vdjer:0.12--h5ca1c30_8
stdout: vdjer.out
