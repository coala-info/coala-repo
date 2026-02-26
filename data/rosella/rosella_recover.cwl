cwlVersion: v1.2
class: CommandLineTool
baseCommand: rosella recover
label: rosella_recover
doc: "Recover MAGs from contigs using UMAP and HDBSCAN clustering.\n\nTool homepage:
  https://github.com/rhysnewell/rosella.git"
inputs:
  - id: assembly
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --assembly
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    inputBinding:
      position: 101
      prefix: --bam-files
  - id: bwa_parameters
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --bwa-parameters
  - id: contig_end_exclusion
    type:
      - 'null'
      - int
    default: 75
    inputBinding:
      position: 101
      prefix: --contig-end-exclusion
  - id: coupled
    type:
      - 'null'
      - type: array
        items: File
    inputBinding:
      position: 101
      prefix: --coupled
  - id: coverage_file
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --coverage-file
  - id: ef_construction
    type:
      - 'null'
      - int
    default: 100
    inputBinding:
      position: 101
      prefix: --ef-construction
  - id: exclude_supplementary
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --exclude-supplementary
  - id: filtering_rounds
    type:
      - 'null'
      - int
    default: 1
    inputBinding:
      position: 101
      prefix: --filtering-rounds
  - id: include_secondary
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --include-secondary
  - id: interleaved
    type:
      - 'null'
      - type: array
        items: File
    inputBinding:
      position: 101
      prefix: --interleaved
  - id: kmer_frequency_file
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --kmer-frequency-file
  - id: kmer_size
    type:
      - 'null'
      - int
    default: 31
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: longread_bam_files
    type:
      - 'null'
      - type: array
        items: File
    inputBinding:
      position: 101
      prefix: --longread-bam-files
  - id: longread_mapper
    type:
      - 'null'
      - string
    doc: 'possible values: minimap2-ont, minimap2-pb, minimap2-hifi'
    default: minimap2-ont
    inputBinding:
      position: 101
      prefix: --longread-mapper
  - id: longreads
    type:
      - 'null'
      - type: array
        items: File
    inputBinding:
      position: 101
      prefix: --longreads
  - id: mapper
    type:
      - 'null'
      - string
    doc: 'possible values: bwa-mem, bwa-mem2, minimap2-sr, minimap2-ont, minimap2-pb,
      minimap2-hifi, minimap2-no-preset'
    default: minimap2-sr
    inputBinding:
      position: 101
      prefix: --mapper
  - id: max_layers
    type:
      - 'null'
      - int
    default: 16
    inputBinding:
      position: 101
      prefix: --max-layers
  - id: max_nb_connections
    type:
      - 'null'
      - int
    default: 32
    inputBinding:
      position: 101
      prefix: --max-nb-connections
  - id: max_retries
    type:
      - 'null'
      - int
    default: 5
    inputBinding:
      position: 101
      prefix: --max-retries
  - id: min_bin_size
    type:
      - 'null'
      - int
    default: 200000
    inputBinding:
      position: 101
      prefix: --min-bin-size
  - id: min_contig_count
    type:
      - 'null'
      - int
    default: 10
    inputBinding:
      position: 101
      prefix: --min-contig-count
  - id: min_contig_size
    type:
      - 'null'
      - int
    default: 1500
    inputBinding:
      position: 101
      prefix: --min-contig-size
  - id: min_covered_fraction
    type:
      - 'null'
      - float
    default: 0.0
    inputBinding:
      position: 101
      prefix: --min-covered-fraction
  - id: min_read_aligned_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-read-aligned-length
  - id: min_read_aligned_length_pair
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-read-aligned-length-pair
  - id: min_read_aligned_percent
    type:
      - 'null'
      - float
    default: 0.0
    inputBinding:
      position: 101
      prefix: --min-read-aligned-percent
  - id: min_read_aligned_percent_pair
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-read-aligned-percent-pair
  - id: min_read_percent_identity
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-read-percent-identity
  - id: min_read_percent_identity_pair
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-read-percent-identity-pair
  - id: minimap2_parameters
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --minimap2-parameters
  - id: minimap2_reference_is_index
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --minimap2-reference-is-index
  - id: n_neighbours
    type:
      - 'null'
      - int
    default: 100
    inputBinding:
      position: 101
      prefix: --n-neighbours
  - id: nb_grad_batches
    type:
      - 'null'
      - int
    default: 16
    inputBinding:
      position: 101
      prefix: --nb-grad-batches
  - id: proper_pairs_only
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --proper-pairs-only
  - id: quiet
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --quiet
  - id: read1
    type:
      - 'null'
      - type: array
        items: File
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - type: array
        items: File
    inputBinding:
      position: 101
      prefix: --read2
  - id: seed
    type:
      - 'null'
      - int
    default: 42
    inputBinding:
      position: 101
      prefix: --seed
  - id: single
    type:
      - 'null'
      - type: array
        items: File
    inputBinding:
      position: 101
      prefix: --single
  - id: sketch_scale
    type:
      - 'null'
      - float
    default: 0.1
    inputBinding:
      position: 101
      prefix: --sketch-scale
  - id: threads
    type:
      - 'null'
      - int
    default: 10
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim_max
    type:
      - 'null'
      - float
    default: 95.0
    inputBinding:
      position: 101
      prefix: --trim-max
  - id: trim_min
    type:
      - 'null'
      - float
    default: 5.0
    inputBinding:
      position: 101
      prefix: --trim-min
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rosella:0.5.7--hfa530fd_0
