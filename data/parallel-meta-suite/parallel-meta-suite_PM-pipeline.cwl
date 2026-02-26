cwlVersion: v1.2
class: CommandLineTool
baseCommand: PM-pipeline
label: parallel-meta-suite_PM-pipeline
doc: "Parallel-Meta Suite Pipeline\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: asv_denoising
    type:
      - 'null'
      - boolean
    doc: ASV denoising, T(rue) or F(alse)
    default: true
    inputBinding:
      position: 101
      prefix: -v
  - id: bootstrap_normalization
    type:
      - 'null'
      - int
    doc: Bootstrap for sequence number normalization
    default: 200
    inputBinding:
      position: 101
      prefix: -b
  - id: chimera_removal
    type:
      - 'null'
      - boolean
    doc: Chimera removal, T(rue) or F(alse)
    default: true
    inputBinding:
      position: 101
      prefix: -c
  - id: cluster_number
    type:
      - 'null'
      - int
    doc: Cluster number
    default: 2
    inputBinding:
      position: 101
      prefix: -C
  - id: functional_analysis
    type:
      - 'null'
      - boolean
    doc: Functional analysis, T(rue) or F(alse)
    default: true
    inputBinding:
      position: 101
      prefix: -f
  - id: functional_levels
    type:
      - 'null'
      - type: array
        items: int
    doc: Functional levels (Level 1, 2, 3 or 4 (KO number)). Multiple levels are
      accepted
    inputBinding:
      position: 101
      prefix: -F
  - id: list_file_prefix_i
    type:
      - 'null'
      - string
    doc: List file path prefix
    inputBinding:
      position: 101
      prefix: -p
  - id: list_file_prefix_l
    type:
      - 'null'
      - string
    doc: List file path prefix
    inputBinding:
      position: 101
      prefix: -p
  - id: meta_data_file
    type: File
    doc: Meta data file
    inputBinding:
      position: 101
      prefix: -m
  - id: network_edge_threshold
    type:
      - 'null'
      - float
    doc: Network analysis edge threshold
    default: 0.5
    inputBinding:
      position: 101
      prefix: -G
  - id: otu_count_table
    type:
      - 'null'
      - File
    doc: Input OTU count table (*.OTU.Count)
    inputBinding:
      position: 101
      prefix: -T
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Output path
    default: default_out
    inputBinding:
      position: 101
      prefix: -o
  - id: paired_samples
    type:
      - 'null'
      - boolean
    doc: If the samples are paired, T(rue) or F(alse)
    default: false
    inputBinding:
      position: 101
      prefix: -E
  - id: rRNA_copy_number_correction
    type:
      - 'null'
      - boolean
    doc: rRNA copy number correction, T(rue) or F(alse)
    default: true
    inputBinding:
      position: 101
      prefix: -r
  - id: rRNA_length_threshold
    type:
      - 'null'
      - int
    doc: rRNA length threshold of rRNA extraction. 0 is disabled
    default: 0
    inputBinding:
      position: 101
      prefix: -a
  - id: rarefaction_curve
    type:
      - 'null'
      - boolean
    doc: Rarefaction curve, T(rue) or F(alse)
    default: false
    inputBinding:
      position: 101
      prefix: -R
  - id: ref_database
    type:
      - 'null'
      - string
    doc: ref database, Empty database
    inputBinding:
      position: 101
      prefix: -D
  - id: sequence_alignment_threshold
    type:
      - 'null'
      - float
    doc: Sequence alignment threshold (float value 0~1)
    inputBinding:
      position: 101
      prefix: -d
  - id: sequence_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sequence files list, pair-ended sequences are supported
    inputBinding:
      position: 101
      prefix: -i
  - id: sequence_format_check
    type:
      - 'null'
      - boolean
    doc: Sequence format check, T(rue) or F(alse)
    default: false
    inputBinding:
      position: 101
      prefix: -k
  - id: sequence_normalization_depth
    type:
      - 'null'
      - int
    doc: Sequence number normalization depth, 0 is disabled
    default: 0
    inputBinding:
      position: 101
      prefix: -s
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: Sequence type, T (Shotgun) or F (rRNA)
    default: F
    inputBinding:
      position: 101
      prefix: -M
  - id: taxonomic_results_list
    type:
      - 'null'
      - File
    doc: Taxonomic analysis results list
    inputBinding:
      position: 101
      prefix: -l
  - id: taxonomical_distance_type
    type:
      - 'null'
      - int
    doc: 'Taxonomical distance type, 0: weighted, 1: unweigthed, 2: both'
    default: 2
    inputBinding:
      position: 101
      prefix: -w
  - id: taxonomical_levels
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Taxonomical levels (1-6: Phylum - Species). Multiple levels are accepted'
    inputBinding:
      position: 101
      prefix: -L
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of thread
    default: auto
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
stdout: parallel-meta-suite_PM-pipeline.out
