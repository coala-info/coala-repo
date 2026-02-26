cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - hydra
label: quasitools_hydra
doc: "Generate a mixed base consensus sequence.\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: forward_reads
    type: File
    doc: Forward reads file
    inputBinding:
      position: 1
  - id: reverse_reads
    type:
      - 'null'
      - File
    doc: Reverse reads file
    inputBinding:
      position: 2
  - id: consensus_pct
    type:
      - 'null'
      - string
    doc: Minimum percentage a base needs to be incorporated into the consensus 
      sequence.
    inputBinding:
      position: 103
      prefix: --consensus_pct
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Error rate for the sequencing platform.
    inputBinding:
      position: 103
      prefix: --error_rate
  - id: filter_ns
    type:
      - 'null'
      - boolean
    doc: Flag to enable the filtering of n's. This option and --mask_reads 
      cannot be both enabled simultaneously.
    inputBinding:
      position: 103
      prefix: --ns
  - id: generate_consensus
    type:
      - 'null'
      - boolean
    doc: Generate a mixed base consensus sequence.
    inputBinding:
      position: 103
      prefix: --generate_consensus
  - id: id
    type:
      - 'null'
      - string
    doc: Specify FASTA sequence identifier to be used in the consensus report.
    inputBinding:
      position: 103
      prefix: --id
  - id: length_cutoff
    type:
      - 'null'
      - int
    doc: Reads which fall short of the specified length will be filtered out.
    inputBinding:
      position: 103
      prefix: --length_cutoff
  - id: mask_reads
    type:
      - 'null'
      - boolean
    doc: Mask low coverage regions in reads if below minimum read quality. This 
      option and --ns cannot be both enabled simultaneously.
    inputBinding:
      position: 103
      prefix: --mask_reads
  - id: mean_score
    type:
      - 'null'
      - boolean
    doc: Use mean score for the score cutoff value.
    inputBinding:
      position: 103
      prefix: --mean
  - id: median_score
    type:
      - 'null'
      - boolean
    doc: Use median score for the score cutoff value.
    inputBinding:
      position: 103
      prefix: --median
  - id: min_ac
    type:
      - 'null'
      - int
    doc: The minimum required allele count for variant to be considered in the 
      pipeline.
    inputBinding:
      position: 103
      prefix: --min_ac
  - id: min_dp
    type:
      - 'null'
      - int
    doc: Minimum required read depth for variant to be considered later on in 
      the pipeline.
    inputBinding:
      position: 103
      prefix: --min_dp
  - id: min_freq
    type:
      - 'null'
      - float
    doc: The minimum required frequency for mutation to be considered in drug 
      resistance report.
    inputBinding:
      position: 103
      prefix: --min_freq
  - id: min_read_qual
    type:
      - 'null'
      - int
    doc: Minimum quality for a position in a read to be masked.
    inputBinding:
      position: 103
      prefix: --min_read_qual
  - id: min_variant_qual
    type:
      - 'null'
      - int
    doc: Minimum quality for variant to be considered later on in the pipeline.
    inputBinding:
      position: 103
      prefix: --min_variant_qual
  - id: mutation_db
    type:
      - 'null'
      - File
    doc: Mutation database file
    inputBinding:
      position: 103
      prefix: --mutation_db
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all normal output.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: reporting_threshold
    type:
      - 'null'
      - string
    doc: Minimum mutation frequency percent to report.
    inputBinding:
      position: 103
      prefix: --reporting_threshold
  - id: score_cutoff
    type:
      - 'null'
      - int
    doc: Reads that have a median or mean quality score (depending on the score 
      type specified) less than the score cutoff value will be filtered out.
    inputBinding:
      position: 103
      prefix: --score_cutoff
  - id: trim_reads
    type:
      - 'null'
      - boolean
    doc: Iteratively trim reads based on filter values if enabled. Remove reads 
      which do not meet filter values if disabled.
    inputBinding:
      position: 103
      prefix: --trim_reads
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
