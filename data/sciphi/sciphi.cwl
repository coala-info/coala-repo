cwlVersion: v1.2
class: CommandLineTool
baseCommand: sciphi
label: sciphi
doc: "SCIPhI: Single-cell Identification of Polymorphism in Heterogeneous Inter-clonal
  populations. A tool for tree reconstruction and variant calling from single-cell
  sequencing data.\n\nTool homepage: https://github.com/cbg-ethz/SCIPhI"
inputs:
  - id: bulk_alt_skip_threshold
    type:
      - 'null'
      - int
    doc: Loci with up to this number of alternative supporting reads in the bulk control
      sample will be skipped as germline.
    inputBinding:
      position: 101
      prefix: --bns
  - id: bulk_min_coverage
    type:
      - 'null'
      - int
    doc: Minimum required coverage of reads in the bulk control sample.
    inputBinding:
      position: 101
      prefix: --bnc
  - id: data_usage_increment
    type:
      - 'null'
      - float
    doc: Data usage rate increment steps. In order to speed up the algorithm one can
      choose to iteratively add more and more of the candidate loci while learning
      the tree model.
    inputBinding:
      position: 101
      prefix: --ur
  - id: deprecated_index_path
    type:
      - 'null'
      - string
    doc: This option is deprecated. The index will be saved in a folder specified
      with -o in 'last_index'.
    inputBinding:
      position: 101
      prefix: --ol
  - id: estimate_sequencing_error
    type:
      - 'null'
      - int
    doc: Estimate the sequencing error rate.
    inputBinding:
      position: 101
      prefix: --ese
  - id: exclusion_list
    type:
      - 'null'
      - File
    doc: File name of exclusion list (VCF format), containing loci which should be
      ignored.
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
  - id: input_bams
    type:
      - 'null'
      - File
    doc: Name of the BAM files used to create the mpileup.
    inputBinding:
      position: 101
      prefix: --in
  - id: intermediate_results_dir
    type:
      - 'null'
      - Directory
    doc: Directory from which to read intermediate results.
    inputBinding:
      position: 101
      prefix: --il
  - id: learn_zygosity
    type:
      - 'null'
      - int
    doc: Set to 1 if zygosity should be learned. The zygosity rate is the fraction
      of mutations which are homozygous in all cells.
    inputBinding:
      position: 101
      prefix: --lz
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximal number of iterations before sampling form the posterior distribution
      of the mutation to cell assignment.
    inputBinding:
      position: 101
      prefix: -l
  - id: max_mutated_control_cells
    type:
      - 'null'
      - int
    doc: Maximum number of control cells allowed to be mutated.
    inputBinding:
      position: 101
      prefix: --mnc
  - id: max_mutations_per_window
    type:
      - 'null'
      - int
    doc: Maximum number of mutations allowed per window.
    inputBinding:
      position: 101
      prefix: --mmw
  - id: mean_error_rate
    type:
      - 'null'
      - float
    doc: Mean error rate. If the sequencing error rate should not be learned '--ese
      0' one can specify it.
    inputBinding:
      position: 101
      prefix: --wildMean
  - id: mean_vaf_threshold
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
    doc: Number of cells which need to pass the filters described below.
    inputBinding:
      position: 101
      prefix: --mnp
  - id: min_coverage_per_cell
    type:
      - 'null'
      - int
    doc: Minimum coverage required per cell.
    inputBinding:
      position: 101
      prefix: --mc
  - id: min_tumor_cells
    type:
      - 'null'
      - int
    doc: Number of tumor cells required to have a mutation in order to be called.
    inputBinding:
      position: 101
      prefix: --cwm
  - id: mutation_overdispersion
    type:
      - 'null'
      - float
    doc: Initial overdispersion for mutant type. The overdispersion is learned during
      the tree traversal.
    inputBinding:
      position: 101
      prefix: --mutationOverDis
  - id: mutations_to_exclude
    type:
      - 'null'
      - File
    doc: File name of mutations to exclude during the sequencing error rate estimation
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
  - id: parameter_estimation_rate
    type:
      - 'null'
      - float
    doc: Parameter estimation rate, i.e. the fraction of loops used to estimate the
      different parameters.
    inputBinding:
      position: 101
      prefix: -e
  - id: pcr_substitution_rate
    type:
      - 'null'
      - float
    doc: PCR substitution rate. An error early during the PCR amplification can result
      in high allele fractions.
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
  - id: sampling_iterations
    type:
      - 'null'
      - int
    doc: Number of iterations in which the mutation to cell assignment is sampled.
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
  - id: uniq_loci_threshold
    type:
      - 'null'
      - int
    doc: Mark loci with this number of cells being mutated as 'PASS'.
    inputBinding:
      position: 101
      prefix: --uniq
  - id: use_normal_cells_for_tree
    type:
      - 'null'
      - boolean
    doc: Use normal cells for tree reconstruction.
    inputBinding:
      position: 101
      prefix: --unc
  - id: wild_overdispersion
    type:
      - 'null'
      - float
    doc: Initial overdispersion for wild type. The overdispersion is learned during
      the tree traversal.
    inputBinding:
      position: 101
      prefix: --wildOverDis
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size in which only x (see option '--mmw') mutations are allowed to
      be present.
    inputBinding:
      position: 101
      prefix: --md
  - id: zygosity_rate
    type:
      - 'null'
      - float
    doc: Zygosity rate.
    inputBinding:
      position: 101
      prefix: --zyg
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix of output files.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sciphi:0.1.7--h077b44d_6
