cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnasim
label: cnasim
doc: "Main simulator for generating copy number profiles (CNPs), readcounts, and sequencing
  reads.\n\nTool homepage: https://github.com/samsonweiner/CNAsim"
inputs:
  - id: alt_reference
    type:
      - 'null'
      - File
    doc: Path to an alternate reference genome to be used as a secondary 
      haplotype, also in fasta format.
    inputBinding:
      position: 101
      prefix: --alt-reference
  - id: bin_length
    type:
      - 'null'
      - int
    doc: Resolution of copy number profiles in bp.
    inputBinding:
      position: 101
      prefix: --bin-length
  - id: chrom_arm_rate
    type:
      - 'null'
      - float
    doc: Probability that a chromosomal event is a chromosome-arm event.
    inputBinding:
      position: 101
      prefix: --chrom-arm-rate
  - id: chrom_arm_ratio
    type:
      - 'null'
      - float
    doc: If not using hg38 static, ratio of length within the p-arm.
    inputBinding:
      position: 101
      prefix: --chrom-arm-ratio
  - id: chrom_event_type
    type:
      - 'null'
      - float
    doc: Probability that a chromosomal event is a duplication.
    inputBinding:
      position: 101
      prefix: --chrom-event-type
  - id: chrom_length
    type:
      - 'null'
      - int
    doc: Length of chromosomes in bp if not using hg38 static.
    inputBinding:
      position: 101
      prefix: --chrom-length
  - id: chrom_level_event
    type:
      - 'null'
      - boolean
    doc: Include chromosomal alterations.
    inputBinding:
      position: 101
      prefix: --chrom-level-event
  - id: chrom_rate_clone
    type:
      - 'null'
      - float
    doc: Parameter in poisson for number of chrom-level events for clonal nodes.
    inputBinding:
      position: 101
      prefix: --chrom-rate-clone
  - id: chrom_rate_founder
    type:
      - 'null'
      - float
    doc: Parameter in poisson for number of chromosome-level events along the 
      edge into the founder cell.
    inputBinding:
      position: 101
      prefix: --chrom-rate-founder
  - id: chrom_rate_super_clone
    type:
      - 'null'
      - float
    doc: Parameter in poisson for number of chromosome-level events along the 
      edges out of the founder cell.
    inputBinding:
      position: 101
      prefix: --chrom-rate-super-clone
  - id: clone_criteria
    type:
      - 'null'
      - int
    doc: 'Criteria to choose clonal ancesters. 0: proportional to number of leaves
      in subtree. 1: proportional to edge length'
    inputBinding:
      position: 101
      prefix: --clone-criteria
  - id: clone_mu
    type:
      - 'null'
      - float
    doc: Mean number of leaves in a subclone. Must select 0 for clone-criteria.
    inputBinding:
      position: 101
      prefix: --clone-mu
  - id: clone_sd
    type:
      - 'null'
      - float
    doc: SD in the number of leaves in a subclone. Must select 0 for 
      clone-criteria.
    inputBinding:
      position: 101
      prefix: --clone-sd
  - id: cn_copy_param
    type:
      - 'null'
      - float
    doc: Parameter in the geometric to select number of copies.
    inputBinding:
      position: 101
      prefix: --cn-copy-param
  - id: cn_event_rate
    type:
      - 'null'
      - float
    doc: Probability an event is an amplification. Deletion rate is 1 - amp 
      rate.
    inputBinding:
      position: 101
      prefix: --cn-event-rate
  - id: cn_length_mean
    type:
      - 'null'
      - int
    doc: Mean copy number event length in bp.
    inputBinding:
      position: 101
      prefix: --cn-length-mean
  - id: coverage
    type:
      - 'null'
      - float
    doc: Average sequencing coverage across the genome.
    inputBinding:
      position: 101
      prefix: --coverage
  - id: disable_info
    type:
      - 'null'
      - boolean
    doc: Do not output simulation log, cell types, or ground truth events.
    inputBinding:
      position: 101
      prefix: --disable-info
  - id: error_rate_1
    type:
      - 'null'
      - float
    doc: Error rate for the boundary model.
    inputBinding:
      position: 101
      prefix: --error-rate-1
  - id: error_rate_2
    type:
      - 'null'
      - float
    doc: Error rate for the jitter model.
    inputBinding:
      position: 101
      prefix: --error-rate-2
  - id: founder_event_mult
    type:
      - 'null'
      - float
    doc: Multiplier for the number of events along edge into founder cell.
    inputBinding:
      position: 101
      prefix: --founder-event-mult
  - id: growth_rate
    type:
      - 'null'
      - float
    doc: Exponential growth rate for standard coalescent.
    inputBinding:
      position: 101
      prefix: --growth-rate
  - id: interval
    type:
      - 'null'
      - int
    doc: Initializes a point in the coverage distribution every interval number 
      of windows.
    inputBinding:
      position: 101
      prefix: --interval
  - id: lorenz_x
    type:
      - 'null'
      - float
    doc: x-coordinate of point on lorenz curve if using non-uniform coverage.
    inputBinding:
      position: 101
      prefix: --lorenz-x
  - id: lorenz_y
    type:
      - 'null'
      - float
    doc: y-coordinate of point on lorenz curve if using non-uniform coverage.
    inputBinding:
      position: 101
      prefix: --lorenz-y
  - id: min_cn_length
    type:
      - 'null'
      - int
    doc: Minimum copy number event length in bp. Should be at minimum the region
      length and less than the mean.
    inputBinding:
      position: 101
      prefix: --min-cn-length
  - id: mode
    type:
      - 'null'
      - int
    doc: 'Main simulator mode for generating data. 0: CNPs only, 1: readcounts & CNPs,
      2: sequencing reads & CNPs'
    inputBinding:
      position: 101
      prefix: --mode
  - id: normal_fraction
    type:
      - 'null'
      - float
    doc: Proportion of cells that are normal.
    inputBinding:
      position: 101
      prefix: --normal-fraction
  - id: num_cells
    type:
      - 'null'
      - int
    doc: Number of observed cells in sample.
    inputBinding:
      position: 101
      prefix: --num-cells
  - id: num_chromosomes
    type:
      - 'null'
      - int
    doc: Number of chromosomes if run in mode 0.
    inputBinding:
      position: 101
      prefix: --num-chromosomes
  - id: num_clones
    type:
      - 'null'
      - int
    doc: Number of ancestral nodes to select as clonal founders.
    inputBinding:
      position: 101
      prefix: --num-clones
  - id: num_sweep
    type:
      - 'null'
      - int
    doc: Number of selective sweeps in coalescent.
    inputBinding:
      position: 101
      prefix: --num-sweep
  - id: param_file
    type:
      - 'null'
      - File
    doc: Path to parameter file to specify parameters instead of the command 
      line.
    inputBinding:
      position: 101
      prefix: --param-file
  - id: placement_param
    type:
      - 'null'
      - float
    doc: Parameter for placement choice.
    inputBinding:
      position: 101
      prefix: --placement-param
  - id: placement_type
    type:
      - 'null'
      - int
    doc: 'Number of CNAs per edge. 0: draw from a Poisson with fixed mean, 1: draw
      from a Poisson with mean prop to edge length, 2: fixed per edge'
    inputBinding:
      position: 101
      prefix: --placement-type
  - id: processors
    type:
      - 'null'
      - int
    doc: Number of processes to use for generating reads in parallel.
    inputBinding:
      position: 101
      prefix: --processors
  - id: pseudonormal_fraction
    type:
      - 'null'
      - float
    doc: Proportion of cells that are pseudonormal cells.
    inputBinding:
      position: 101
      prefix: --pseudonormal-fraction
  - id: read_length
    type:
      - 'null'
      - int
    doc: Paired-end short read length.
    inputBinding:
      position: 101
      prefix: --read-length
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to input reference genome as the primary haplotype in fasta 
      format.
    inputBinding:
      position: 101
      prefix: --reference
  - id: region_length
    type:
      - 'null'
      - int
    doc: Region length in bp. Essentially controls the resolution of the 
      simulated genome.
    inputBinding:
      position: 101
      prefix: --region-length
  - id: selection_strength
    type:
      - 'null'
      - float
    doc: Parameter controlling the strength of selection during the sweeps.
    inputBinding:
      position: 101
      prefix: --selection-strength
  - id: seq_error
    type:
      - 'null'
      - float
    doc: Per base error rate for generating sequence data.
    inputBinding:
      position: 101
      prefix: --seq-error
  - id: tree_path
    type:
      - 'null'
      - File
    doc: Path to input tree.
    inputBinding:
      position: 101
      prefix: --tree-path
  - id: tree_type
    type:
      - 'null'
      - int
    doc: '0: coalescence, 1: random, 2: from file (use -T to specify file path).'
    inputBinding:
      position: 101
      prefix: --tree-type
  - id: use_hg38_static
    type:
      - 'null'
      - boolean
    doc: Use hg38 chromosome information. Excludes sex chromosomes chrX and 
      chrY.
    inputBinding:
      position: 101
      prefix: --use-hg38-static
  - id: use_uniform_coverage
    type:
      - 'null'
      - boolean
    doc: Use uniform coverage across the genome.
    inputBinding:
      position: 101
      prefix: --use-uniform-coverage
  - id: wgd
    type:
      - 'null'
      - boolean
    doc: Include WGD.
    inputBinding:
      position: 101
      prefix: --WGD
  - id: window_size
    type:
      - 'null'
      - int
    doc: Number of base pairs to generate reads for in each iteration.
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: out_path
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    outputBinding:
      glob: $(inputs.out_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnasim:1.3.5--pyhdfd78af_0
