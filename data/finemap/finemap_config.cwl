cwlVersion: v1.2
class: CommandLineTool
baseCommand: finemap
label: finemap_config
doc: "Welcome to FINEMAP v1.4.2\n\nTool homepage: http://www.christianbenner.com"
inputs:
  - id: collinear_tol
    type:
      - 'null'
      - float
    doc: Option to set the tolerance for collinearity in stepwise conditional 
      search between already selected SNPs and the tested SNP
    default: 0.95
    inputBinding:
      position: 101
      prefix: --collinear-tol
  - id: cond
    type:
      - 'null'
      - boolean
    doc: Fine-mapping with stepwise conditional search
    inputBinding:
      position: 101
      prefix: --cond
  - id: cond_pvalue
    type:
      - 'null'
      - float
    doc: Option to set the p-value threshold for declaring genome-wide 
      significance
    default: '5e-8'
    inputBinding:
      position: 101
      prefix: --cond-pvalue
  - id: config
    type:
      - 'null'
      - boolean
    doc: Evaluate a single causal configuration without performing shotgun 
      stochastic search
    inputBinding:
      position: 101
      prefix: --config
  - id: corr_config
    type:
      - 'null'
      - float
    doc: Option to set the posterior probability of a causal configuration to 
      zero if it includes a pair of SNPs with absolute correlation above this 
      threshold
    default: 0.95
    inputBinding:
      position: 101
      prefix: --corr-config
  - id: dataset
    type:
      - 'null'
      - string
    doc: Option to specify a delimiter-separated list of datasets for 
      fine-mapping as given in the master file (e.g. 1,2 or 1|2)
    inputBinding:
      position: 101
      prefix: --dataset
  - id: flip_beta
    type:
      - 'null'
      - boolean
    doc: Option to read a column 'flip' in the Z file with binary indicators 
      specifying if the direction of the estimated SNP effect sizes needs to be 
      flipped
    inputBinding:
      position: 101
      prefix: --flip-beta
  - id: force_n_samples
    type:
      - 'null'
      - boolean
    doc: Option to allow correlations in a BCOR file to be computed on a set of 
      samples with different size than GWAS sample size
    inputBinding:
      position: 101
      prefix: --force-n-samples
  - id: in_files
    type:
      - 'null'
      - File
    doc: "Option to specify a semicolon separated master file with the following column
      names: 'z', 'ld', 'snp', 'config', 'n_samples' and optionally 'k' and 'log'.
      Each line is a dataset with file extensions corresponding with column names.
      The column 'n_samples' represents the GWAS sample size"
    inputBinding:
      position: 101
      prefix: --in-files
  - id: log
    type:
      - 'null'
      - boolean
    doc: Option to write output to log files specified in column 'log' in the 
      master file
    inputBinding:
      position: 101
      prefix: --log
  - id: n_causal_snps
    type:
      - 'null'
      - int
    doc: Option to set the maximum number of allowed causal SNPs
    default: 5
    inputBinding:
      position: 101
      prefix: --n-causal-snps
  - id: n_configs_top
    type:
      - 'null'
      - int
    doc: Option to set the number of top causal configurations to be saved
    default: 50000
    inputBinding:
      position: 101
      prefix: --n-configs-top
  - id: n_conv_sss
    type:
      - 'null'
      - int
    doc: Option to set the number of iterations that the added probability mass 
      is required to be below the specified threshold (--prob-conv-sss-tol) 
      before shotgun stochastic search is terminated
    default: 1000
    inputBinding:
      position: 101
      prefix: --n-conv-sss
  - id: n_iter
    type:
      - 'null'
      - int
    doc: Option to set the maximum number of iterations before shotgun 
      stochastic search is terminated
    default: 100000
    inputBinding:
      position: 101
      prefix: --n-iter
  - id: n_threads
    type:
      - 'null'
      - int
    doc: Option to specify the number of parallel threads
    default: 1
    inputBinding:
      position: 101
      prefix: --n-threads
  - id: prior_k
    type:
      - 'null'
      - boolean
    doc: Option to use prior probabilities for the number of causal SNPs from K 
      files as specified in column 'k' in the master file
    inputBinding:
      position: 101
      prefix: --prior-k
  - id: prior_k0
    type:
      - 'null'
      - float
    doc: Option to set the prior probability that there is no causal SNP in the 
      genomic region. Only used when computing posterior probabilities for the 
      number of causal SNPs but not during fine-mapping itself
    default: 0.0
    inputBinding:
      position: 101
      prefix: --prior-k0
  - id: prior_snps
    type:
      - 'null'
      - boolean
    doc: Option to read a column 'prob' in the Z file with prior probabilities 
      that a SNP is causal in order to define the prior probability for each 
      causal configuration
    inputBinding:
      position: 101
      prefix: --prior-snps
  - id: prior_std
    type:
      - 'null'
      - float
    doc: Option to specify a comma-separated list of prior standard deviations 
      of effect sizes.
    default: 0.05
    inputBinding:
      position: 101
      prefix: --prior-std
  - id: prob_conv_sss_tol
    type:
      - 'null'
      - float
    doc: Option to set the tolerance at which the added probability mass (over 
      --n-conv-sss iterations) is considered small enough to terminate shotgun 
      stochastic search
    default: 0.001
    inputBinding:
      position: 101
      prefix: --prob-conv-sss-tol
  - id: prob_cred_set
    type:
      - 'null'
      - float
    doc: Option to set the probability at which the credible interval includes a
      causal SNP
    default: 0.95
    inputBinding:
      position: 101
      prefix: --prob-cred-set
  - id: pvalue_snps
    type:
      - 'null'
      - float
    doc: Option to set a p-value threshold at which SNPs are included
    default: 1.0
    inputBinding:
      position: 101
      prefix: --pvalue-snps
  - id: rsids
    type:
      - 'null'
      - string
    doc: Option to specify a comma-separated list of SNP identifiers 
      corresponding with the 'rsid' column in Z files as specified in column 'z'
      in the master file
    inputBinding:
      position: 101
      prefix: --rsids
  - id: sss
    type:
      - 'null'
      - boolean
    doc: Fine-mapping with shotgun stochastic search
    inputBinding:
      position: 101
      prefix: --sss
  - id: std_effects
    type:
      - 'null'
      - boolean
    doc: Option to print mean and standard deviation of the posterior effect 
      size distribution for standardized dosages
    inputBinding:
      position: 101
      prefix: --std-effects
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finemap:1.4.2--hb192632_1
stdout: finemap_config.out
