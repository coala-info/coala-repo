cwlVersion: v1.2
class: CommandLineTool
baseCommand: entropy
label: popgen-entropy_entropy
doc: "Bayesian estimation of genotypes and admixture proportions (ancestry) for mixed-ploidy populations from genotype-likelihood or sequence-read data.\n\nTool homepage: https://bitbucket.org/buerklelab/mixedploidy-entropy/src/master/"
inputs:
  - id: infile
    type: File
    doc: "Infile with genetic data for the population (.mpgl)"
    inputBinding:
      position: 1
      prefix: -i
  - id: ploidy
    type: string
    doc: "Ploidy level for individuals (1, 2, 3, 4, 6): a single number for all individuals OR an infile with the ploidy of each individual on a new line OR an infile with the ploidy of each individual in a new line and each locus in a new column"
    inputBinding:
      position: 1
      prefix: -n
  - id: genotype_likelihood_format
    type:
      - 'null'
      - int
    doc: "BOOL (1 or 0): infile is in genotype likelihood format. Default: 1"
    inputBinding:
      position: 1
      prefix: -m
  - id: mcmc_steps
    type:
      - 'null'
      - int
    doc: "Number of MCMC steps for the analysis. Default: 10000"
    inputBinding:
      position: 1
      prefix: -l
  - id: burn_in
    type:
      - 'null'
      - int
    doc: "Discard the first n MCMC samples as a burn-in. Default: 5000"
    inputBinding:
      position: 1
      prefix: -b
  - id: thin_mcmc
    type:
      - 'null'
      - int
    doc: "Thin MCMC samples by recording every nth value. Default: 5"
    inputBinding:
      position: 1
      prefix: -t
  - id: num_clusters
    type:
      - 'null'
      - int
    doc: "Number of population clusters. Default: 2"
    inputBinding:
      position: 1
      prefix: -k
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: "HDF5 format outfile with .hdf5 suffix. Default: mcmcout.hdf5"
    inputBinding:
      position: 1
      prefix: -o
  - id: expected_q_file
    type:
      - 'null'
      - File
    doc: "File with expected starting values for admixture proportions"
    inputBinding:
      position: 1
      prefix: -q
  - id: estimate_ancestry
    type:
      - 'null'
      - int
    doc: "BOOL (1 or 0): estimate intra- and interspecific ancestry and marginal q. Default: 0"
    inputBinding:
      position: 1
      prefix: -Q
  - id: output_allele_frequencies
    type:
      - 'null'
      - int
    doc: "BOOL (1 or 0): output includes population allele frequencies. Default: 0"
    inputBinding:
      position: 1
      prefix: -w
  - id: sequence_error_prob
    type:
      - 'null'
      - float
    doc: "Probability of sequence error, set to 9 for locus-specific error rates. Default: 0 (only required if infile is not in genotype likelihood format)"
    inputBinding:
      position: 1
      prefix: -e
  - id: dirichlet_init_scalar
    type:
      - 'null'
      - float
    doc: "Scalar for Dirichlet init. of q, inversely proportional to variance. Default: 1"
    inputBinding:
      position: 1
      prefix: -s
  - id: ancestral_allele_freq_proposal
    type:
      - 'null'
      - float
    doc: "+/- proposal for ancestral allele frequency. Default: 0.1"
    inputBinding:
      position: 1
      prefix: -p
  - id: fst_proposal
    type:
      - 'null'
      - float
    doc: "+/- proposal for Fst. Default: 0.01"
    inputBinding:
      position: 1
      prefix: -f
  - id: gamma_proposal
    type:
      - 'null'
      - float
    doc: "+/- proposal for gamma. Default: 0.2"
    inputBinding:
      position: 1
      prefix: -y
  - id: alpha_proposal
    type:
      - 'null'
      - float
    doc: "+/- proposal for alpha. Default: 0.1"
    inputBinding:
      position: 1
      prefix: -a
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Seed for random number generator. Default: clock"
    inputBinding:
      position: 1
      prefix: -r
  - id: calculate_dic_waic
    type:
      - 'null'
      - int
    doc: "BOOL (1 or 0): flag to calculate DIC or WAIC estimates. Default: 0 (DIC)"
    inputBinding:
      position: 1
      prefix: -D
outputs:
  - id: outfile
    type: File
    doc: "HDF5 format outfile with MCMC samples"
    outputBinding:
      glob: "*.hdf5"
  - id: stdout
    type: stdout
    doc: "Run log"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popgen-entropy:2.0--h60038e2_5
stdout: entropy.out
