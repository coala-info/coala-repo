cwlVersion: v1.2
class: CommandLineTool
baseCommand: rvtests_rvtest
label: rvtests_rvtest
doc: "RVTESTS is a powerful and flexible software package for association testing
  of genetic variants.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: anno_type
    type:
      - 'null'
      - string
    doc: Specify annotation type that is followed by ANNO= in the VCF INFO 
      field, regular expression is allowed
    inputBinding:
      position: 101
      prefix: --annoType
  - id: bolt_plink
    type:
      - 'null'
      - string
    doc: Specify a prefix of binary PLINK inputs for BoltLMM
    inputBinding:
      position: 101
      prefix: --boltPlink
  - id: bolt_plink_no_check
    type:
      - 'null'
      - boolean
    doc: Not checking MAF and missingness for binary PLINK file
    inputBinding:
      position: 101
      prefix: --boltPlinkNoCheck
  - id: burden
    type:
      - 'null'
      - string
    doc: 'Burden tests, choose from: cmc, zeggini, mb, exactCMC, rarecover, cmat,
      cmcWald'
    inputBinding:
      position: 101
      prefix: --burden
  - id: condition
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify markers to be conditions (specify range)
    inputBinding:
      position: 101
      prefix: --condition
  - id: covar
    type:
      - 'null'
      - File
    doc: Specify covariate file
    inputBinding:
      position: 101
      prefix: --covar
  - id: covar_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the column name in covariate file to be included in analysis
    inputBinding:
      position: 101
      prefix: --covar-name
  - id: dosage
    type:
      - 'null'
      - string
    doc: Specify which dosage tag to use. (e.g. EC or DS)
    inputBinding:
      position: 101
      prefix: --dosage
  - id: freq_lower
    type:
      - 'null'
      - float
    doc: Specify lower minor allele frequency bound to be included in analysis
    inputBinding:
      position: 101
      prefix: --freqLower
  - id: freq_upper
    type:
      - 'null'
      - float
    doc: Specify upper minor allele frequency bound to be included in analysis
    inputBinding:
      position: 101
      prefix: --freqUpper
  - id: gene
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify which genes to test
    inputBinding:
      position: 101
      prefix: --gene
  - id: gene_file
    type:
      - 'null'
      - File
    doc: Specify a gene file (for burden tests)
    inputBinding:
      position: 101
      prefix: --geneFile
  - id: hide_covar
    type:
      - 'null'
      - boolean
    doc: Supress output lines of covariates
    inputBinding:
      position: 101
      prefix: --hide-covar
  - id: impute
    type:
      - 'null'
      - string
    doc: 'Impute missing genotype (default:mean): mean, hwe, and drop'
    inputBinding:
      position: 101
      prefix: --impute
  - id: impute_cov
    type:
      - 'null'
      - boolean
    doc: Impute each covariate to its mean, instead of drop samples with missing
      covariates
    inputBinding:
      position: 101
      prefix: --imputeCov
  - id: impute_pheno
    type:
      - 'null'
      - boolean
    doc: Impute phenotype to mean of those have genotypes but no phenotypes
    inputBinding:
      position: 101
      prefix: --imputePheno
  - id: in_bgen
    type:
      - 'null'
      - File
    doc: Input BGEN File
    inputBinding:
      position: 101
      prefix: --inBgen
  - id: in_bgen_sample
    type:
      - 'null'
      - File
    doc: Input Sample IDs for the BGEN File
    inputBinding:
      position: 101
      prefix: --inBgenSample
  - id: in_kgg
    type:
      - 'null'
      - File
    doc: Input KGG File
    inputBinding:
      position: 101
      prefix: --inKgg
  - id: in_vcf
    type:
      - 'null'
      - File
    doc: Input VCF File
    inputBinding:
      position: 101
      prefix: --inVcf
  - id: indv_depth_max
    type:
      - 'null'
      - int
    doc: Specify maximum depth(inclusive); of a sample to be included in 
      analysis
    inputBinding:
      position: 101
      prefix: --indvDepthMax
  - id: indv_depth_min
    type:
      - 'null'
      - int
    doc: Specify minimum depth(inclusive); of a sample to be included in 
      analysis
    inputBinding:
      position: 101
      prefix: --indvDepthMin
  - id: indv_qual_min
    type:
      - 'null'
      - float
    doc: Specify minimum depth(inclusive); of a sample to be included in 
      analysis
    inputBinding:
      position: 101
      prefix: --indvQualMin
  - id: inverse_normal
    type:
      - 'null'
      - boolean
    doc: Transform phenotype like normal distribution
    inputBinding:
      position: 101
      prefix: --inverseNormal
  - id: kernel
    type:
      - 'null'
      - string
    doc: 'Kernal-based tests, choose from: SKAT, KBAC, FamSKAT, SKATO'
    inputBinding:
      position: 101
      prefix: --kernel
  - id: kinship
    type:
      - 'null'
      - File
    doc: Specify a kinship file for autosomal analysis, use vcf2kinship to 
      generate
    inputBinding:
      position: 101
      prefix: --kinship
  - id: kinship_eigen
    type:
      - 'null'
      - File
    doc: Specify eigen decomposition results of a kinship file for autosomal 
      analysis
    inputBinding:
      position: 101
      prefix: --kinshipEigen
  - id: meta
    type:
      - 'null'
      - string
    doc: 'Meta-analysis related functions to generate summary statistics, choose from:
      score, cov, dominant, recessive'
    inputBinding:
      position: 101
      prefix: --meta
  - id: mpheno
    type:
      - 'null'
      - int
    doc: 'Specify which phenotype column to read (default: 1)'
    inputBinding:
      position: 101
      prefix: --mpheno
  - id: multiple_allele
    type:
      - 'null'
      - boolean
    doc: Support multi-allelic genotypes
    inputBinding:
      position: 101
      prefix: --multipleAllele
  - id: multiple_pheno
    type:
      - 'null'
      - File
    doc: Specify aa template file for analyses of more than one phenotype
    inputBinding:
      position: 101
      prefix: --multiplePheno
  - id: noweb
    type:
      - 'null'
      - boolean
    doc: Skip checking new version
    inputBinding:
      position: 101
      prefix: --noweb
  - id: num_thread
    type:
      - 'null'
      - int
    doc: Specify number of threads (default:1)
    inputBinding:
      position: 101
      prefix: --numThread
  - id: out
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --out
  - id: output_id
    type:
      - 'null'
      - boolean
    doc: Output VCF IDs in single-variant assocition results
    inputBinding:
      position: 101
      prefix: --outputID
  - id: output_raw
    type:
      - 'null'
      - boolean
    doc: Output genotypes, phenotype, covariates(if any); and collapsed genotype
      to tabular files
    inputBinding:
      position: 101
      prefix: --outputRaw
  - id: people_exclude_file
    type:
      - 'null'
      - File
    doc: From given file, set IDs of people that will be included in study
    inputBinding:
      position: 101
      prefix: --peopleExcludeFile
  - id: people_exclude_id
    type:
      - 'null'
      - type: array
        items: string
    doc: List IDs of people that will be included in study
    inputBinding:
      position: 101
      prefix: --peopleExcludeID
  - id: people_include_file
    type:
      - 'null'
      - File
    doc: From given file, set IDs of people that will be included in study
    inputBinding:
      position: 101
      prefix: --peopleIncludeFile
  - id: people_include_id
    type:
      - 'null'
      - type: array
        items: string
    doc: List IDs of people that will be included in study
    inputBinding:
      position: 101
      prefix: --peopleIncludeID
  - id: pheno
    type:
      - 'null'
      - File
    doc: Specify phenotype file
    inputBinding:
      position: 101
      prefix: --pheno
  - id: pheno_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify which phenotype column to read by header
    inputBinding:
      position: 101
      prefix: --pheno-name
  - id: qtl
    type:
      - 'null'
      - boolean
    doc: Treat phenotype as quantitative trait
    inputBinding:
      position: 101
      prefix: --qtl
  - id: range_file
    type:
      - 'null'
      - File
    doc: Specify the file containing ranges, please use chr:begin-end format.
    inputBinding:
      position: 101
      prefix: --rangeFile
  - id: range_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify some ranges to use, please use chr:begin-end format.
    inputBinding:
      position: 101
      prefix: --rangeList
  - id: set
    type:
      - 'null'
      - string
    doc: Specify which set to test (1st column)
    inputBinding:
      position: 101
      prefix: --set
  - id: set_file
    type:
      - 'null'
      - File
    doc: 'Specify a list file (for burden tests, first 2 columns: setName chr:beg-end)'
    inputBinding:
      position: 101
      prefix: --setFile
  - id: set_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a list to test (for burden tests)
    inputBinding:
      position: 101
      prefix: --setList
  - id: sex
    type:
      - 'null'
      - boolean
    doc: Include sex (5th column in the PED file) as a covariate
    inputBinding:
      position: 101
      prefix: --sex
  - id: single
    type:
      - 'null'
      - string
    doc: 'Single variant tests, choose from: score, wald, exact, famScore, famLrt,
      famGrammarGamma, firth'
    inputBinding:
      position: 101
      prefix: --single
  - id: site_depth_max
    type:
      - 'null'
      - int
    doc: Specify maximum depth(inclusive); to be included in analysis
    inputBinding:
      position: 101
      prefix: --siteDepthMax
  - id: site_depth_min
    type:
      - 'null'
      - int
    doc: Specify minimum depth(inclusive); to be included in analysis
    inputBinding:
      position: 101
      prefix: --siteDepthMin
  - id: site_file
    type:
      - 'null'
      - File
    doc: Specify the file containing sites to include, please use "chr pos" 
      format.
    inputBinding:
      position: 101
      prefix: --siteFile
  - id: site_mac_min
    type:
      - 'null'
      - int
    doc: Specify minimum Minor Allele Count(inclusive); to be included in 
      analysis
    inputBinding:
      position: 101
      prefix: --siteMACMin
  - id: use_residual_as_phenotype
    type:
      - 'null'
      - boolean
    doc: Fit covariate ~ phenotype, use residual to replace phenotype
    inputBinding:
      position: 101
      prefix: --useResidualAsPhenotype
  - id: vt
    type:
      - 'null'
      - string
    doc: 'Variable threshold tests, choose from: price, analytic'
    inputBinding:
      position: 101
      prefix: --vt
  - id: x_hemi_kinship
    type:
      - 'null'
      - File
    doc: Provide kinship for the chromosome X hemizygote region
    inputBinding:
      position: 101
      prefix: --xHemiKinship
  - id: x_hemi_kinship_eigen
    type:
      - 'null'
      - File
    doc: Specify eigen decomposition results of a kinship file for X analysis
    inputBinding:
      position: 101
      prefix: --xHemiKinshipEigen
  - id: x_label
    type:
      - 'null'
      - string
    doc: 'Specify X chromosome label (default: 23|X)'
    inputBinding:
      position: 101
      prefix: --xLabel
  - id: x_par_region
    type:
      - 'null'
      - string
    doc: "Specify PAR region (default: hg19);, can be build number e.g. hg38, b37;
      or specify region, e.g. '60001-2699520,154931044-155260560'"
    inputBinding:
      position: 101
      prefix: --xParRegion
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: rvtests_rvtest.out
