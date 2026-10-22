cwlVersion: v1.2
class: CommandLineTool
baseCommand: [trinculo, ordinal]
label: trinculo_ordinal
doc: "Ordinal (proportional odds) logistic regression of an ordered phenotype on genotypes (trinculo ordinal).\n\nTool homepage: https://sourceforge.net/projects/trinculo/"
inputs:
  - id: bfile
    type:
      - 'null'
      - File
    doc: "Genotype input in binary plink format (.bed with .bim and .fam alongside)"
    secondaryFiles:
      - pattern: ^.bim
        required: true
      - pattern: ^.fam
        required: true
    inputBinding:
      position: 2
      prefix: --bfile
      valueFrom: $(self.path.replace(/\.bed$/, ''))
  - id: dosage
    type:
      - 'null'
      - File
    doc: "Genotype input in dosage format"
    inputBinding:
      position: 2
      prefix: --dosage
  - id: out
    type:
      - 'null'
      - string
    doc: "The prefix used for output files [default is \"trinculo\"]"
    default: trinculo
    inputBinding:
      position: 2
      prefix: --out
  - id: pheno
    type: File
    doc: "Phenotype input (same format as plink)"
    inputBinding:
      position: 2
      prefix: --pheno
  - id: phenoname
    type: string
    doc: "The phenotype in the phenotype file to analyse"
    inputBinding:
      position: 2
      prefix: --phenoname
  - id: basepheno
    type:
      - 'null'
      - string
    doc: "The reference category to use for the analysis [defaults to first category encountered]"
    inputBinding:
      position: 2
      prefix: --basepheno
  - id: missingpheno
    type:
      - 'null'
      - string
    doc: "The symbol used to indicate a missing phenotype in the phenotype file"
    inputBinding:
      position: 2
      prefix: --missingpheno
  - id: condition
    type:
      - 'null'
      - File
    doc: "A file containing a list of SNPs (one per line) to condition on"
    inputBinding:
      position: 2
      prefix: --condition
  - id: covar
    type:
      - 'null'
      - File
    doc: "A file containing covariates to condition on (same format as plink)"
    inputBinding:
      position: 2
      prefix: --covar
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: "Normalizes covariates to have a variance of 1 [off by default]"
    inputBinding:
      position: 2
      prefix: --normalize
  - id: priors
    type:
      - 'null'
      - File
    doc: "A prior covariance matrix on effect sizes"
    inputBinding:
      position: 2
      prefix: --priors
  - id: defaultpriors
    type:
      - 'null'
      - boolean
    doc: "Construct a prior matrix based on default values"
    inputBinding:
      position: 2
      prefix: --defaultprior
  - id: priorsigma
    type:
      - 'null'
      - float
    doc: "Set the prior variance on effect sizes within a disease [default is 0.04]"
    inputBinding:
      position: 2
      prefix: --priorsigma
  - id: priorcor
    type:
      - 'null'
      - float
    doc: "Set the prior correlation on effect sizes across diseases [default is 0]"
    inputBinding:
      position: 2
      prefix: --priorcor
  - id: covarsigma
    type:
      - 'null'
      - float
    doc: "Prior on the covariate effect size [default is 1]"
    inputBinding:
      position: 2
      prefix: --covarsigma
  - id: empiricalprior
    type:
      - 'null'
      - boolean
    doc: "Calculate an empirical prior directly from the data"
    inputBinding:
      position: 2
      prefix: --empiricalprior
  - id: noassoc
    type:
      - 'null'
      - boolean
    doc: "Do not do any association testing, just infer the prior"
    inputBinding:
      position: 2
      prefix: --noassoc
  - id: select
    type:
      - 'null'
      - boolean
    doc: "Do Bayesian model selection (marginal likelihood for each sharing model)"
    inputBinding:
      position: 2
      prefix: --select
  - id: phenops
    type:
      - 'null'
      - boolean
    doc: "Do a likelihood ratio test on each phenotype individually"
    inputBinding:
      position: 2
      prefix: --phenops
  - id: waldstats
    type:
      - 'null'
      - boolean
    doc: "Calculate standard errors, Z scores and Wald p-values"
    inputBinding:
      position: 2
      prefix: --waldstats
  - id: errormat
    type:
      - 'null'
      - boolean
    doc: "Output the variance-covariance matrix for the log odds ratio"
    inputBinding:
      position: 2
      prefix: --errormat
  - id: fullmodel
    type:
      - 'null'
      - boolean
    doc: "Output all parameter estimates and the full error matrix"
    inputBinding:
      position: 2
      prefix: --fullmodel
  - id: threads
    type:
      - 'null'
      - int
    doc: "Use up to n cores"
    inputBinding:
      position: 2
      prefix: --threads
  - id: precision
    type:
      - 'null'
      - int
    doc: "Print output to DIGITS significant figures"
    inputBinding:
      position: 2
      prefix: --precision
  - id: fitIter
    type:
      - 'null'
      - int
    doc: "Try up to NITER iterations when fitting models"
    inputBinding:
      position: 2
      prefix: --fitIter
  - id: fitAbsTol
    type:
      - 'null'
      - float
    doc: "Terminate model fitting if results change by less than ABSTOL"
    inputBinding:
      position: 2
      prefix: --fitAbsTol
  - id: fitRelTol
    type:
      - 'null'
      - float
    doc: "Terminate model fitting if results change by less than (RELTOL x value)"
    inputBinding:
      position: 2
      prefix: --fitRelTol
outputs:
  - id: result_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Result files with the output prefix (association table and log)"
    outputBinding:
      glob: $(inputs.out)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trinculo:0.96--h470a237_2
