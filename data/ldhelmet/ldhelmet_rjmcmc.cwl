cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ldhelmet
  - rjmcmc
label: ldhelmet_rjmcmc
doc: "Run rjmcmc\n\nTool homepage: http://sourceforge.net/projects/ldhelmet/"
inputs:
  - id: block_penalty
    type:
      - 'null'
      - int
    doc: Block penalty for rjMCMC.
    default: 10
    inputBinding:
      position: 101
      prefix: --block_penalty
  - id: burn_in
    type:
      - 'null'
      - int
    doc: Number of iterations for burn-in (in addition to number of iterations 
      to run rjMCMC).
    default: 1000
    inputBinding:
      position: 101
      prefix: --burn_in
  - id: lk_file
    type:
      - 'null'
      - File
    doc: Two-site likelihood table.
    inputBinding:
      position: 101
      prefix: --lk_file
  - id: max_lk_end
    type:
      - 'null'
      - float
    doc: Rho value to end maximum likelihood estimation of background rate.
    default: 0.3
    inputBinding:
      position: 101
      prefix: --max_lk_end
  - id: max_lk_resolution
    type:
      - 'null'
      - float
    doc: Amount to increment by for maximum likelihood estimation of background 
      rate.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --max_lk_resolution
  - id: max_lk_start
    type:
      - 'null'
      - float
    doc: Rho value to begin maximum likelihood estimation of background rate.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --max_lk_start
  - id: mut_mat_file
    type:
      - 'null'
      - File
    doc: Mutation matrix.
    inputBinding:
      position: 101
      prefix: --mut_mat_file
  - id: num_iter
    type:
      - 'null'
      - int
    doc: Number of iterations to run rjMCMC.
    default: 10000
    inputBinding:
      position: 101
      prefix: --num_iter
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 1
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: overlap_length
    type:
      - 'null'
      - int
    doc: Overlap length.
    default: 200
    inputBinding:
      position: 101
      prefix: --overlap_length
  - id: pade_file
    type:
      - 'null'
      - File
    doc: Pade coefficients.
    inputBinding:
      position: 101
      prefix: --pade_file
  - id: pade_max_rho
    type:
      - 'null'
      - float
    doc: Maximum Pade grid value.
    default: 1000
    inputBinding:
      position: 101
      prefix: --pade_max_rho
  - id: pade_resolution
    type:
      - 'null'
      - int
    doc: Pade grid increment.
    default: 10
    inputBinding:
      position: 101
      prefix: --pade_resolution
  - id: partition_length
    type:
      - 'null'
      - int
    doc: Partition length (number of SNPs).
    default: 4001
    inputBinding:
      position: 101
      prefix: --partition_length
  - id: pos_file
    type:
      - 'null'
      - File
    doc: SNP positions for alternative input format.
    inputBinding:
      position: 101
      prefix: --pos_file
  - id: prior_file
    type:
      - 'null'
      - File
    doc: Prior on ancestral allele for each site.
    inputBinding:
      position: 101
      prefix: --prior_file
  - id: prior_rate
    type:
      - 'null'
      - float
    doc: Prior mean on recombination rate.
    default: 1
    inputBinding:
      position: 101
      prefix: --prior_rate
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for pseudo-random number generator.
    default: 5489
    inputBinding:
      position: 101
      prefix: --seed
  - id: seq_file
    type:
      - 'null'
      - File
    doc: Sequence file.
    inputBinding:
      position: 101
      prefix: --seq_file
  - id: snps_file
    type:
      - 'null'
      - File
    doc: SNPs file for alternative input format.
    inputBinding:
      position: 101
      prefix: --snps_file
  - id: stats_thin
    type:
      - 'null'
      - int
    doc: Thinning parameter for summary statistics.
    default: 1000
    inputBinding:
      position: 101
      prefix: --stats_thin
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size.
    default: 50
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
