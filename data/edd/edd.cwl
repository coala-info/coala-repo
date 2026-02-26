cwlVersion: v1.2
class: CommandLineTool
baseCommand: edd
label: edd
doc: "Enriched Domain Detector -- for analysis of ChIP-seq data. See documentation
  at https://github.com/CollasLab/edd for more info and tips.\n\nTool homepage: http://github.com/CollasLab/edd"
inputs:
  - id: chrom_size
    type: File
    doc: This must be a tab separated file with two columns. The first column 
      contains chromosome names and the second contains the chromosome sizes.
    inputBinding:
      position: 1
  - id: unalignable_regions
    type: File
    doc: bed file marking regions to be excluded from the analysis (such as 
      centromeres).
    inputBinding:
      position: 2
  - id: ip_bam
    type: File
    doc: ChIP bam file
    inputBinding:
      position: 3
  - id: input_bam
    type: File
    doc: Input/control bam file
    inputBinding:
      position: 4
  - id: bin_size
    type:
      - 'null'
      - int
    doc: An integer specifying the bin size in KB. Will auto select bin size 
      based on input data if not specified.
    inputBinding:
      position: 105
      prefix: --bin-size
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to user specified EDD configuration file. See EDD manual section 
      about configuration for more information.
    inputBinding:
      position: 105
      prefix: --config-file
  - id: fdr
    type:
      - 'null'
      - float
    doc: False Discovery Rate
    inputBinding:
      position: 105
      prefix: --fdr
  - id: gap_penalty
    type:
      - 'null'
      - float
    doc: Leave unspecificed for auto-estimation. Adjusts how sensitive EDD is to
      heterogeneity within domains. Depends on Signal/Noise ratio of source 
      files and on the interests of the researcher. A "low" value favors large 
      enriched domains with more heterogeneity. A "high" value favors smaller 
      enriched domains devoid of heterogeneity.
    inputBinding:
      position: 105
      prefix: --gap-penalty
  - id: nprocs
    type:
      - 'null'
      - int
    doc: Number of processes to use for the monte carlo simulation. One 
      processes per physical CPU core is recommended.
    inputBinding:
      position: 105
      prefix: --nprocs
  - id: num_trials
    type:
      - 'null'
      - int
    doc: Number of trials in monte carlo simulation
    inputBinding:
      position: 105
      prefix: --num-trials
  - id: write_bin_scores
    type:
      - 'null'
      - boolean
    doc: Write bin scores to file.
    inputBinding:
      position: 105
      prefix: --write-bin-scores
  - id: write_log_ratios
    type:
      - 'null'
      - boolean
    doc: Write log ratios to file.
    inputBinding:
      position: 105
      prefix: --write-log-ratios
outputs:
  - id: output_dir
    type: Directory
    doc: output directory, will be created if not existing.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/edd:1.1.19--py27hc1659b7_0
