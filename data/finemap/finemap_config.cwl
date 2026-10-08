cwlVersion: v1.2
class: CommandLineTool
baseCommand: finemap
label: finemap_config
doc: 'FINEMAP v1.4.2: Evaluate a single causal configuration without performing shotgun
  stochastic search.


  Tool homepage: http://www.christianbenner.com'
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
arguments:
  - --config
inputs:
  - id: data_files
    type: File[]
    doc: Z, LD, K and other input files named in the master file (staged in the working
      directory by file name; the master file must use plain file names)
  - id: corr_config
    type:
      - 'null'
      - float
    doc: Option to set the posterior probability of a causal configuration to zero
      if it includes a pair of SNPs with absolute correlation above this threshold
    inputBinding:
      prefix: --corr-config
  - id: dataset
    type:
      - 'null'
      - string
    doc: Option to specify a delimiter-separated list of datasets for fine-mapping
      as given in the master file (e.g. 1,2 or 1|2)
    inputBinding:
      prefix: --dataset
  - id: flip_beta
    type:
      - 'null'
      - boolean
    doc: Option to read a column 'flip' in the Z file with binary indicators specifying
      if the direction of the estimated SNP effect sizes needs to be flipped
    inputBinding:
      prefix: --flip-beta
  - id: force_n_samples
    type:
      - 'null'
      - boolean
    doc: Option to allow correlations in a BCOR file to be computed on a set of samples
      with different size than GWAS sample size
    inputBinding:
      prefix: --force-n-samples
  - id: in_files
    type: File
    doc: 'Option to specify a semicolon separated master file with the following column
      names: ''z'', ''ld'', ''snp'', ''config'', ''n_samples'' and optionally ''k''
      and ''log''. Each line is a dataset with file extensions corresponding with
      column names. The column ''n_samples'' represents the GWAS sample size'
    inputBinding:
      prefix: --in-files
  - id: log
    type:
      - 'null'
      - boolean
    doc: Option to write output to log files specified in column 'log' in the master
      file
    inputBinding:
      prefix: --log
  - id: prior_snps
    type:
      - 'null'
      - boolean
    doc: Option to read a column 'prob' in the Z file with prior probabilities that
      a SNP is causal in order to define the prior probability for each causal configuration
    inputBinding:
      prefix: --prior-snps
  - id: prior_std
    type:
      - 'null'
      - string
    doc: Option to specify a comma-separated list of prior standard deviations of
      effect sizes.
    inputBinding:
      prefix: --prior-std
  - id: rsids
    type: string
    doc: Option to specify a comma-separated list of SNP identifiers corresponding
      with the 'rsid' column in Z files as specified in column 'z' in the master file
    inputBinding:
      prefix: --rsids
outputs:
  - id: snp_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Posterior inclusion probability files (*.snp)
    outputBinding:
      glob: '*.snp'
  - id: config_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Causal configuration files (*.config)
    outputBinding:
      glob: '*.config'
  - id: cred_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Credible set files (*.cred*)
    outputBinding:
      glob: '*.cred*'
  - id: log_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Log files written with --log (*.log*)
    outputBinding:
      glob: '*.log*'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finemap:1.4.2--hb192632_1
stdout: finemap_config.out
