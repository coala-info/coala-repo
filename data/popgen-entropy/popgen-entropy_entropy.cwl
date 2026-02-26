cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./entropy
label: popgen-entropy_entropy
doc: "Calculate population genetic entropy\n\nTool homepage: https://bitbucket.org/buerklelab/mixedploidy-entropy/src/master/"
inputs:
  - id: alpha_proposal
    type:
      - 'null'
      - float
    doc: +/- proposal for alpha
    default: 0.1
    inputBinding:
      position: 101
      prefix: -a
  - id: ancestral_allele_freq_proposal
    type:
      - 'null'
      - float
    doc: +/- proposal for ancestral allele frequency
    default: 0.1
    inputBinding:
      position: 101
      prefix: -p
  - id: burn_in
    type:
      - 'null'
      - int
    doc: Discard the first n MCMC samples as a burn-in
    default: 5000
    inputBinding:
      position: 101
      prefix: -b
  - id: calculate_dic_waic
    type:
      - 'null'
      - boolean
    doc: flag to calculate DIC or WAIC estimates
    default: false
    inputBinding:
      position: 101
      prefix: -D
  - id: dirichlet_init_scalar
    type:
      - 'null'
      - float
    doc: Scalar for Dirichlet init. of q, inversly prop. to variance
    default: 1
    inputBinding:
      position: 101
      prefix: -s
  - id: estimate_ancestry
    type:
      - 'null'
      - boolean
    doc: estimate intra- and interspecific ancestry and marginal q
    default: false
    inputBinding:
      position: 101
      prefix: -Q
  - id: expected_q_file
    type:
      - 'null'
      - File
    doc: File with expected starting values for admixture proportions
    inputBinding:
      position: 101
      prefix: -q
  - id: fst_proposal
    type:
      - 'null'
      - float
    doc: +/- proposal for Fst
    default: 0.01
    inputBinding:
      position: 101
      prefix: -f
  - id: gamma_proposal
    type:
      - 'null'
      - float
    doc: +/- proposal for gamma
    default: 0.2
    inputBinding:
      position: 101
      prefix: -y
  - id: genotype_likelihood_format
    type:
      - 'null'
      - boolean
    doc: infile is in genotype likelihood format
    default: true
    inputBinding:
      position: 101
      prefix: -m
  - id: infile
    type: File
    doc: Infile with genetic data for the population (.mpgl)
    inputBinding:
      position: 101
      prefix: -i
  - id: mcmc_steps
    type:
      - 'null'
      - int
    doc: Number of MCMC steps for the analysis
    default: 10000
    inputBinding:
      position: 101
      prefix: -l
  - id: num_clusters
    type:
      - 'null'
      - int
    doc: Number of population clusters
    default: 2
    inputBinding:
      position: 101
      prefix: -k
  - id: output_allele_frequencies
    type:
      - 'null'
      - boolean
    doc: Output includes population allele frequencies
    default: false
    inputBinding:
      position: 101
      prefix: -w
  - id: ploidy
    type: string
    doc: Ploidy level for individuals (1, 2, 3, 4, 6) (a single number 
      indicating same ploidy for all individuals OR Infile with ploidy for each 
      individual on a new line OR Infile with ploidy for each individual in a 
      new line and each locus in a new column)
    inputBinding:
      position: 101
      prefix: -n
  - id: random_seed
    type:
      - 'null'
      - string
    doc: seed for random number generator
    default: clock
    inputBinding:
      position: 101
      prefix: -r
  - id: sequence_error_prob
    type:
      - 'null'
      - float
    doc: Probability of sequence error, set to '9' for locus-specific error 
      rates (only required if infile is not in genotype likelihood format)
    default: 0
    inputBinding:
      position: 101
      prefix: -e
  - id: thin_mcmc
    type:
      - 'null'
      - int
    doc: Thin MCMC samples by recording every nth value
    default: 5
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: HDF5 format outfile with .hdf5 suffix
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popgen-entropy:2.0--h60038e2_5
