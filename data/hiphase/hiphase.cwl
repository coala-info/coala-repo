cwlVersion: v1.2
class: CommandLineTool
baseCommand: hiphase
label: hiphase
doc: "A tool for jointly phasing small, structural, and tandem repeat variants for
  PacBio sequencing data\n\nTool homepage: https://github.com/PacificBiosciences/HiPhase"
inputs:
  - id: bam
    type: File
    doc: Input alignment file in BAM format
    inputBinding:
      position: 101
      prefix: --bam
  - id: csi_index
    type:
      - 'null'
      - boolean
    doc: Output .csi indices instead of .tbi/.bai
    inputBinding:
      position: 101
      prefix: --csi-index
  - id: disable_global_realignment
    type:
      - 'null'
      - boolean
    doc: Disables global realignment
    inputBinding:
      position: 101
      prefix: --disable-global-realignment
  - id: global_failure_count
    type:
      - 'null'
      - int
    doc: Sets a minimum number of global realignment failures before 
      --max-global-failure-ratio is active
    inputBinding:
      position: 101
      prefix: --global-failure-count
  - id: global_pruning_distance
    type:
      - 'null'
      - int
    doc: Sets a pruning threshold on global realignment, set to 0 to disable 
      pruning
    inputBinding:
      position: 101
      prefix: --global-pruning-distance
  - id: global_realignment_max_ed
    type:
      - 'null'
      - int
    doc: The maximum allowed edit distance for global realignment before 
      fallback to local realignment
    inputBinding:
      position: 101
      prefix: --global-realignment-max-ed
  - id: ignore_read_groups
    type:
      - 'null'
      - boolean
    doc: Ignore BAM file read group IDs
    inputBinding:
      position: 101
      prefix: --ignore-read-groups
  - id: io_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads for BAM I/O (default: minimum of `--threads` or `4`)'
    inputBinding:
      position: 101
      prefix: --io-threads
  - id: max_global_failure_ratio
    type:
      - 'null'
      - float
    doc: Sets a maximum global realignment failure ratio before disabling global
      realignment for entire block
    inputBinding:
      position: 101
      prefix: --max-global-failure-ratio
  - id: max_reference_buffer
    type:
      - 'null'
      - int
    doc: Sets a maximum reference buffer for local realignment
    inputBinding:
      position: 101
      prefix: --max-reference-buffer
  - id: min_connecting_reads
    type:
      - 'null'
      - int
    doc: Sets the minimum number of connecting reads required to keep two 
      variants in the same block
    inputBinding:
      position: 101
      prefix: --min-connecting-reads
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Sets a minimum MAPQ to include a read in the phasing
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_matched_alleles
    type:
      - 'null'
      - int
    doc: Sets a minimum number of matched variants required for a read to get 
      included in the scoring
    inputBinding:
      position: 101
      prefix: --min-matched-alleles
  - id: min_spanning_reads
    type:
      - 'null'
      - int
    doc: Sets a minimum number of reads to span two adjacent variants into a 
      putative phase block
    inputBinding:
      position: 101
      prefix: --min-spanning-reads
  - id: min_vcf_qual
    type:
      - 'null'
      - int
    doc: Sets a minimum genotype quality (GQ) value to include a variant in the 
      phasing
    inputBinding:
      position: 101
      prefix: --min-vcf-qual
  - id: no_supplemental_joins
    type:
      - 'null'
      - boolean
    doc: Disables the use of supplemental mappings to join phase blocks
    inputBinding:
      position: 101
      prefix: --no-supplemental-joins
  - id: optimize_variant_order
    type:
      - 'null'
      - boolean
    doc: Optimize the variant order prior to phasing
    inputBinding:
      position: 101
      prefix: --optimize-variant-order
  - id: phase_min_queue_size
    type:
      - 'null'
      - int
    doc: Sets the minimum queue size for the phasing algorithm
    inputBinding:
      position: 101
      prefix: --phase-min-queue-size
  - id: phase_queue_increment
    type:
      - 'null'
      - int
    doc: Sets the queue size increment per variant in a phase block
    inputBinding:
      position: 101
      prefix: --phase-queue-increment
  - id: phase_singletons
    type:
      - 'null'
      - boolean
    doc: Enables the phasing and haplotagging of singleton phase blocks
    inputBinding:
      position: 101
      prefix: --phase-singletons
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Use a preset for the settings. Possible values: - rna: Configure the setting
      for RNA-seq data'
    inputBinding:
      position: 101
      prefix: --preset
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample_name
    type:
      - 'null'
      - string
    doc: 'Sample name to phase within the VCF (default: first sample)'
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for phasing
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf
    type: File
    doc: Input variant file in VCF format
    inputBinding:
      position: 101
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: Output haplotagged alignment file in BAM format
    outputBinding:
      glob: $(inputs.output_bam)
  - id: output_vcf
    type: File
    doc: Output phased variant file in VCF format
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: summary_file
    type:
      - 'null'
      - File
    doc: Output summary phasing statistics file (optional, csv/tsv)
    outputBinding:
      glob: $(inputs.summary_file)
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Output algorithmic statistics file (optional, csv/tsv)
    outputBinding:
      glob: $(inputs.stats_file)
  - id: blocks_file
    type:
      - 'null'
      - File
    doc: Output blocks file (optional, csv/tsv)
    outputBinding:
      glob: $(inputs.blocks_file)
  - id: haplotag_file
    type:
      - 'null'
      - File
    doc: Output haplotag file (optional, csv/tsv)
    outputBinding:
      glob: $(inputs.haplotag_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiphase:1.6.0--h9ee0642_0
