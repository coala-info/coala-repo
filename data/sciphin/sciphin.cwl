cwlVersion: v1.2
class: CommandLineTool
baseCommand: sciphin
label: sciphin
doc: "SCIPhIN: Single-cell Inference of Phylogeny and INdividual mutations\n\nTool
  homepage: https://github.com/cbg-ethz/SCIPhI"
inputs:
  - id: bam_names
    type:
      - 'null'
      - string
    doc: Name of the BAM files used to create the mpileup.
    inputBinding:
      position: 101
      prefix: --in
  - id: bulk_normal_coverage
    type:
      - 'null'
      - int
    doc: Minimum required coverage of reads in the bulk control sample.
    inputBinding:
      position: 101
      prefix: --bnc
  - id: bulk_normal_skip
    type:
      - 'null'
      - int
    doc: Loci with up to this number of alternative supporting reads in the bulk control
      sample will be skiped.
    inputBinding:
      position: 101
      prefix: --bns
  - id: cells_with_mutation
    type:
      - 'null'
      - int
    doc: Number of cells requiered to have a mutation in order to be called.
    inputBinding:
      position: 101
      prefix: --cwm
  - id: estimate_error_rate
    type:
      - 'null'
      - int
    doc: Estimate the sequencing error rate.
    inputBinding:
      position: 101
      prefix: --ese
  - id: estimation_rate
    type:
      - 'null'
      - float
    doc: Paramter estimation rate, i.e. the fraction of loops used to estimate the
      different parameters.
    inputBinding:
      position: 101
      prefix: -e
  - id: exclusion_list
    type:
      - 'null'
      - File
    doc: Filename of exclusion list (VCF format).
    inputBinding:
      position: 101
      prefix: --ex
  - id: inclusion_list
    type:
      - 'null'
      - File
    doc: File name of inclusion list (VCF format) containing Variants (CHROM, POS,
      REF, ALT) that should be included.
    inputBinding:
      position: 101
      prefix: --inc
  - id: input_intermediate_dir
    type:
      - 'null'
      - Directory
    doc: Directory from which to read intermediate results.
    inputBinding:
      position: 101
      prefix: --il
  - id: input_mpileup
    type:
      - 'null'
      - File
    doc: input mpileup
    inputBinding:
      position: 101
      prefix: --im
  - id: learn_priors
    type:
      - 'null'
      - string
    doc: Learn the loss and parallel priors.
    inputBinding:
      position: 101
      prefix: --chi
  - id: learn_zygosity
    type:
      - 'null'
      - int
    doc: Set to 1 if zygosity should be learned.
    inputBinding:
      position: 101
      prefix: --lz
  - id: loss_penalty
    type:
      - 'null'
      - float
    doc: Penalty when computing the loss score.
    inputBinding:
      position: 101
      prefix: --llp
  - id: loss_score
    type:
      - 'null'
      - boolean
    doc: Compute the loss score = allow a mutation to be lost in a subtree.
    inputBinding:
      position: 101
      prefix: --ll
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximal number of iterations per repetition.
    inputBinding:
      position: 101
      prefix: -l
  - id: max_mutations_per_window
    type:
      - 'null'
      - int
    doc: Maximum number of mutations allowed per window.
    inputBinding:
      position: 101
      prefix: --mmw
  - id: max_normal_cells_mutated
    type:
      - 'null'
      - int
    doc: Maximum number of control cells allowed to be mutated.
    inputBinding:
      position: 101
      prefix: --mnc
  - id: maximum_likelihood_mode
    type:
      - 'null'
      - string
    doc: Use the maximum likelihood mode instead of the MCMC approach.
    inputBinding:
      position: 101
      prefix: --mlm
  - id: mean_vaf
    type:
      - 'null'
      - float
    doc: Mean of acceptable variant allele frequency across all cells for a specific
      locus.
    inputBinding:
      position: 101
      prefix: --mff
  - id: min_alt_frequency
    type:
      - 'null'
      - float
    doc: Minimum required frequency of reads supporting the alternative per cell.
    inputBinding:
      position: 101
      prefix: --mf
  - id: min_alt_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads required to support the alternative.
    inputBinding:
      position: 101
      prefix: --ms
  - id: min_cells_pass_filter
    type:
      - 'null'
      - int
    doc: Number of cells which need to pass the filters.
    inputBinding:
      position: 101
      prefix: --mnp
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage required per cell.
    inputBinding:
      position: 101
      prefix: --mc
  - id: mutation_overdispersion
    type:
      - 'null'
      - int
    doc: Overdispersion for mutant type.
    inputBinding:
      position: 101
      prefix: --mutationOverDis
  - id: mutation_window_size
    type:
      - 'null'
      - int
    doc: Window size for maximum number of allowed mutations.
    inputBinding:
      position: 101
      prefix: --md
  - id: mutations_to_exclude
    type:
      - 'null'
      - File
    doc: Filename of mutations to exclude during the sequencing error rate estimation
      (VCF format).
    inputBinding:
      position: 101
      prefix: --me
  - id: normal_cell_filter
    type:
      - 'null'
      - int
    doc: Normal cell filter scheme (0, 1, or 2).
    inputBinding:
      position: 101
      prefix: --ncf
  - id: parallel_penalty
    type:
      - 'null'
      - float
    doc: Penalty when computing the parallel score.
    inputBinding:
      position: 101
      prefix: --lpp
  - id: parallel_score
    type:
      - 'null'
      - boolean
    doc: Compute the parallel score = allow a mutation to be acquired twice independently
      in the tree.
    inputBinding:
      position: 101
      prefix: --lp
  - id: pcr_substitution_rate
    type:
      - 'null'
      - float
    doc: PCR substitution rate.
    inputBinding:
      position: 101
      prefix: --sub
  - id: prior_mutation_rate
    type:
      - 'null'
      - float
    doc: Prior mutation rate.
    inputBinding:
      position: 101
      prefix: --pr
  - id: sample_iterations
    type:
      - 'null'
      - int
    doc: Number of sample iterations.
    inputBinding:
      position: 101
      prefix: --ls
  - id: sampling_step
    type:
      - 'null'
      - int
    doc: Sampling step. If a value x different from 0 is specified, every x iteration,
      after the burn in phase, an index will be writen to disk to provide a posterior
      sampling.
    inputBinding:
      position: 101
      prefix: --sa
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator.
    inputBinding:
      position: 101
      prefix: --seed
  - id: tree_score_type
    type:
      - 'null'
      - string
    doc: Tree score type [m (max), s (sum)].
    inputBinding:
      position: 101
      prefix: -t
  - id: uniq_filter
    type:
      - 'null'
      - int
    doc: Filter mutations showing up to this number of cells from the VCF.
    inputBinding:
      position: 101
      prefix: --uniq
  - id: usage_rate_increment
    type:
      - 'null'
      - float
    doc: Data usage rate increment steps.
    inputBinding:
      position: 101
      prefix: --ur
  - id: use_normal_cells
    type:
      - 'null'
      - string
    doc: Use normal cells for tree reconstruction.
    inputBinding:
      position: 101
      prefix: --unc
  - id: wild_mean
    type:
      - 'null'
      - float
    doc: Mean error rate.
    inputBinding:
      position: 101
      prefix: --wildMean
  - id: wild_overdispersion
    type:
      - 'null'
      - int
    doc: Overdispersion for wild type.
    inputBinding:
      position: 101
      prefix: --wildOverDis
  - id: zygosity_rate
    type:
      - 'null'
      - float
    doc: Zygosity rate.
    inputBinding:
      position: 101
      prefix: --zyg
outputs:
  - id: output_intermediate_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store intermediate results.
    outputBinding:
      glob: $(inputs.output_intermediate_dir)
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix of output files.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sciphin:1.0.1--h077b44d_4
