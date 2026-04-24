cwlVersion: v1.2
class: CommandLineTool
baseCommand: regenie
label: regenie
doc: "REGENIE v4.1.2.gz\n\nTool homepage: https://rgcgithub.github.io/regenie/"
inputs:
  - id: aaf_bins
    type:
      - 'null'
      - type: array
        items: float
    doc: comma separated list of AAF bins cutoffs for building masks
    inputBinding:
      position: 101
      prefix: --aaf-bins
  - id: aaf_file
    type:
      - 'null'
      - File
    doc: file with AAF to use when building masks
    inputBinding:
      position: 101
      prefix: --aaf-file
  - id: af_cc
    type:
      - 'null'
      - boolean
    doc: print effect allele frequencies among cases/controls for step 2
    inputBinding:
      position: 101
      prefix: --af-cc
  - id: anno_file
    type:
      - 'null'
      - File
    doc: file with variant annotations
    inputBinding:
      position: 101
      prefix: --anno-file
  - id: anno_labels
    type:
      - 'null'
      - File
    doc: file with labels to annotations
    inputBinding:
      position: 101
      prefix: --anno-labels
  - id: apply_rerint
    type:
      - 'null'
      - boolean
    doc: apply Rank-Inverse Normal Transformation to residualized quantitative 
      traits in step 2
    inputBinding:
      position: 101
      prefix: --apply-rerint
  - id: apply_rerint_cov
    type:
      - 'null'
      - boolean
    doc: apply Rank-Inverse Normal Transformation to residualized quantitative 
      traits and project covariates out in step 2
    inputBinding:
      position: 101
      prefix: --apply-rerint-cov
  - id: apply_rint
    type:
      - 'null'
      - boolean
    doc: apply Rank-Inverse Normal Transformation to quantitative traits
    inputBinding:
      position: 101
      prefix: --apply-rint
  - id: approx
    type:
      - 'null'
      - boolean
    doc: use approximation to Firth correction for computational speedup
    inputBinding:
      position: 101
      prefix: --approx
  - id: bed
    type:
      - 'null'
      - string
    doc: prefix to PLINK .bed/.bim/.fam files
    inputBinding:
      position: 101
      prefix: --bed
  - id: bgen
    type:
      - 'null'
      - File
    doc: BGEN file
    inputBinding:
      position: 101
      prefix: --bgen
  - id: bgi
    type:
      - 'null'
      - File
    doc: index bgi file corresponding to BGEN file
    inputBinding:
      position: 101
      prefix: --bgi
  - id: bsize
    type:
      - 'null'
      - int
    doc: size of genotype blocks
    inputBinding:
      position: 101
      prefix: --bsize
  - id: bt
    type:
      - 'null'
      - boolean
    doc: analyze phenotypes as binary
    inputBinding:
      position: 101
      prefix: --bt
  - id: build_mask
    type:
      - 'null'
      - string
    doc: rule to construct masks, can be 'max', 'sum' or 'comphet' (default is 
      max)
    inputBinding:
      position: 101
      prefix: --build-mask
  - id: cat_covar_list
    type:
      - 'null'
      - type: array
        items: string
    doc: comma separated list of categorical covariates
    inputBinding:
      position: 101
      prefix: --catCovarList
  - id: cc12
    type:
      - 'null'
      - boolean
    doc: use control=1,case=2,missing=NA encoding for binary traits
    inputBinding:
      position: 101
      prefix: --cc12
  - id: check_burden_files
    type:
      - 'null'
      - boolean
    doc: check annotation file, set list file and mask file for consistency
    inputBinding:
      position: 101
      prefix: --check-burden-files
  - id: chr
    type:
      - 'null'
      - string
    doc: specify chromosome to test in step 2 (use for each chromosome)
    inputBinding:
      position: 101
      prefix: --chr
  - id: chr_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of chromosomes to test in step 2
    inputBinding:
      position: 101
      prefix: --chrList
  - id: compute_all
    type:
      - 'null'
      - boolean
    doc: store Firth estimates for all chromosomes
    inputBinding:
      position: 101
      prefix: --compute-all
  - id: condition_file
    type:
      - 'null'
      - string
    doc: optional genotype file which contains the variants to include as 
      covariates
    inputBinding:
      position: 101
      prefix: --condition-file
  - id: condition_file_sample
    type:
      - 'null'
      - File
    doc: sample file accompanying BGEN file with the conditional variants
    inputBinding:
      position: 101
      prefix: --condition-file-sample
  - id: condition_list
    type:
      - 'null'
      - File
    doc: file with list of variants to include as covariates
    inputBinding:
      position: 101
      prefix: --condition-list
  - id: covar_col
    type:
      - 'null'
      - string
    doc: covariate name in header (use for each covariate to keep; can use 
      parameter expansion {i:j})
    inputBinding:
      position: 101
      prefix: --covarCol
  - id: covar_col_list
    type:
      - 'null'
      - type: array
        items: string
    doc: comma separated list of covariate names to keep (can use parameter 
      expansion {i:j})
    inputBinding:
      position: 101
      prefix: --covarColList
  - id: covar_file
    type:
      - 'null'
      - File
    doc: covariate file (header required starting with FID IID)
    inputBinding:
      position: 101
      prefix: --covarFile
  - id: cv
    type:
      - 'null'
      - int
    doc: number of cross validation (CV) folds
    inputBinding:
      position: 101
      prefix: --cv
  - id: event_col_list
    type:
      - 'null'
      - type: array
        items: string
    doc: comma separated list of event status names to keep (can use parameter 
      expansion {i:j})
    inputBinding:
      position: 101
      prefix: --eventColList
  - id: exclude
    type:
      - 'null'
      - File
    doc: comma-separated list of files with IDs of variants to remove from the 
      analysis
    inputBinding:
      position: 101
      prefix: --exclude
  - id: exclude_setlist
    type:
      - 'null'
      - type: array
        items: string
    doc: comma separated list of sets to remove from the analysis
    inputBinding:
      position: 101
      prefix: --exclude-setlist
  - id: exclude_sets
    type:
      - 'null'
      - File
    doc: comma-separated list of files with IDs of sets to remove from the 
      analysis
    inputBinding:
      position: 101
      prefix: --exclude-sets
  - id: extract
    type:
      - 'null'
      - File
    doc: comma-separated list of files with IDs of variants to retain in the 
      analysis
    inputBinding:
      position: 101
      prefix: --extract
  - id: extract_setlist
    type:
      - 'null'
      - type: array
        items: string
    doc: comma separated list of sets to retain in the analysis
    inputBinding:
      position: 101
      prefix: --extract-setlist
  - id: extract_sets
    type:
      - 'null'
      - File
    doc: comma-separated list of files with IDs of sets to retain in the 
      analysis
    inputBinding:
      position: 101
      prefix: --extract-sets
  - id: firth
    type:
      - 'null'
      - boolean
    doc: use Firth correction for p-values less than threshold
    inputBinding:
      position: 101
      prefix: --firth
  - id: force_condtl
    type:
      - 'null'
      - boolean
    doc: to also condition on interacting SNP in the marginal GWAS test
    inputBinding:
      position: 101
      prefix: --force-condtl
  - id: force_qt
    type:
      - 'null'
      - boolean
    doc: force QT run for traits with few unique values
    inputBinding:
      position: 101
      prefix: --force-qt
  - id: gz
    type:
      - 'null'
      - boolean
    doc: compress output files (gzip format)
    inputBinding:
      position: 101
      prefix: --gz
  - id: htp
    type:
      - 'null'
      - string
    doc: output association files in step 2 in HTP format specifying the cohort 
      name)
    inputBinding:
      position: 101
      prefix: --htp
  - id: ignore_pred
    type:
      - 'null'
      - boolean
    doc: skip reading predictions from step 1 (equivalent to linear/logistic 
      regression with only covariates)
    inputBinding:
      position: 101
      prefix: --ignore-pred
  - id: interaction
    type:
      - 'null'
      - string
    doc: perform interaction testing with a quantitative/categorical covariate
    inputBinding:
      position: 101
      prefix: --interaction
  - id: interaction_file
    type:
      - 'null'
      - string
    doc: optional genotype file which contains the variant for GxG interaction 
      test
    inputBinding:
      position: 101
      prefix: --interaction-file
  - id: interaction_file_reffirst
    type:
      - 'null'
      - boolean
    doc: use the first allele as the reference for the BGEN or PLINK file with 
      the interacting variant [default assumes reference is last]
    inputBinding:
      position: 101
      prefix: --interaction-file-reffirst
  - id: interaction_file_sample
    type:
      - 'null'
      - File
    doc: sample file accompanying BGEN file with the interacting variant
    inputBinding:
      position: 101
      prefix: --interaction-file-sample
  - id: interaction_prs
    type:
      - 'null'
      - boolean
    doc: perform interaction testing with the full PRS from step 1
    inputBinding:
      position: 101
      prefix: --interaction-prs
  - id: interaction_snp
    type:
      - 'null'
      - string
    doc: perform interaction testing with a variant
    inputBinding:
      position: 101
      prefix: --interaction-snp
  - id: joint
    type:
      - 'null'
      - type: array
        items: string
    doc: comma spearated list of joint tests to perform
    inputBinding:
      position: 101
      prefix: --joint
  - id: keep
    type:
      - 'null'
      - File
    doc: comma-separated list of files listing samples to retain in the analysis
      (no header; starts with FID IID)
    inputBinding:
      position: 101
      prefix: --keep
  - id: keep_l0
    type:
      - 'null'
      - boolean
    doc: avoid deleting the level 0 predictions written on disk after fitting 
      the level 1 models
    inputBinding:
      position: 101
      prefix: --keep-l0
  - id: l0
    type:
      - 'null'
      - int
    doc: number of ridge parameters to use when fitting models within blocks 
      [evenly spaced in (0,1)]
    inputBinding:
      position: 101
      prefix: --l0
  - id: l1
    type:
      - 'null'
      - int
    doc: number of ridge parameters to use when fitting model across blocks 
      [evenly spaced in (0,1)]
    inputBinding:
      position: 101
      prefix: --l1
  - id: l1_pheno_list
    type:
      - 'null'
      - type: array
        items: string
    doc: run level 1 for a subset of the phenotypes (specified as 
      comma-separated list)
    inputBinding:
      position: 101
      prefix: --l1-phenoList
  - id: loocv
    type:
      - 'null'
      - boolean
    doc: use leave-one out cross validation (LOOCV)
    inputBinding:
      position: 101
      prefix: --loocv
  - id: lowmem
    type:
      - 'null'
      - boolean
    doc: reduce memory usage by writing level 0 predictions to temporary files
    inputBinding:
      position: 101
      prefix: --lowmem
  - id: lowmem_prefix
    type:
      - 'null'
      - string
    doc: prefix where to write the temporary files in step 1 (default is to use 
      prefix from --out)
    inputBinding:
      position: 101
      prefix: --lowmem-prefix
  - id: mask_def
    type:
      - 'null'
      - File
    doc: file with mask definitions
    inputBinding:
      position: 101
      prefix: --mask-def
  - id: mask_lodo
    type:
      - 'null'
      - string
    doc: apply Leave-One-Domain-Out (LODO) scheme when building masks 
      (<set_name>,<mask_name>,<aaf_cutoff>)
    inputBinding:
      position: 101
      prefix: --mask-lodo
  - id: mask_lovo
    type:
      - 'null'
      - string
    doc: apply Leave-One-Variant-Out (LOVO) scheme when building masks 
      (<set_name>,<mask_name>,<aaf_cutoff>)
    inputBinding:
      position: 101
      prefix: --mask-lovo
  - id: min_info
    type:
      - 'null'
      - float
    doc: minimum imputation info score (Impute/Mach R^2) for tested variants
    inputBinding:
      position: 101
      prefix: --minINFO
  - id: min_mac
    type:
      - 'null'
      - float
    doc: minimum minor allele count (MAC) for tested variants
    inputBinding:
      position: 101
      prefix: --minMAC
  - id: no_condtl
    type:
      - 'null'
      - boolean
    doc: to print out all main effects in GxE interaction test
    inputBinding:
      position: 101
      prefix: --no-condtl
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: combine asssociation results into a single for all traits
    inputBinding:
      position: 101
      prefix: --no-split
  - id: out
    type:
      - 'null'
      - string
    doc: prefix for output files
    inputBinding:
      position: 101
      prefix: --out
  - id: p_thresh
    type:
      - 'null'
      - float
    doc: P-value threshold below which to apply Firth/SPA correction
    inputBinding:
      position: 101
      prefix: --pThresh
  - id: par_region
    type:
      - 'null'
      - string
    doc: build code to identify PAR region boundaries on chrX
    inputBinding:
      position: 101
      prefix: --par-region
  - id: pgen
    type:
      - 'null'
      - string
    doc: prefix to PLINK2 .pgen/.pvar/.psam files
    inputBinding:
      position: 101
      prefix: --pgen
  - id: pheno_col
    type:
      - 'null'
      - string
    doc: phenotype name in header (use for each phenotype to keep; can use 
      parameter expansion {i:j})
    inputBinding:
      position: 101
      prefix: --phenoCol
  - id: pheno_col_list
    type:
      - 'null'
      - type: array
        items: string
    doc: comma separated list of phenotype names to keep (can use parameter 
      expansion {i:j})
    inputBinding:
      position: 101
      prefix: --phenoColList
  - id: pheno_file
    type:
      - 'null'
      - File
    doc: phenotype file (header required starting with FID IID)
    inputBinding:
      position: 101
      prefix: --phenoFile
  - id: pred
    type:
      - 'null'
      - File
    doc: file containing the list of predictions files from step 1
    inputBinding:
      position: 101
      prefix: --pred
  - id: print_prs
    type:
      - 'null'
      - boolean
    doc: also output polygenic predictions without using LOCO (=whole genome 
      PRS)
    inputBinding:
      position: 101
      prefix: --print-prs
  - id: qt
    type:
      - 'null'
      - boolean
    doc: analyze phenotypes as quantitative
    inputBinding:
      position: 101
      prefix: --qt
  - id: range
    type:
      - 'null'
      - string
    doc: to specify a physical position window for variants to test in step 2
    inputBinding:
      position: 101
      prefix: --range
  - id: rare_mac
    type:
      - 'null'
      - float
    doc: minor allele count (MAC) threshold below which to use HLM for 
      interaction testing with QTs
    inputBinding:
      position: 101
      prefix: --rare-mac
  - id: ref_first
    type:
      - 'null'
      - boolean
    doc: use the first allele as the reference for BGEN or PLINK bed/bim/fam 
      input format [default assumes reference is last]
    inputBinding:
      position: 101
      prefix: --ref-first
  - id: remove
    type:
      - 'null'
      - File
    doc: comma-separated list of files listing samples to remove from the 
      analysis (no header; starts with FID IID)
    inputBinding:
      position: 101
      prefix: --remove
  - id: run_l0
    type:
      - 'null'
      - string
    doc: run level 0 for job K in {1..N} using master file created from 
      '--split-l0'
    inputBinding:
      position: 101
      prefix: --run-l0
  - id: run_l1
    type:
      - 'null'
      - File
    doc: run level 1 using master file from '--split-l0'
    inputBinding:
      position: 101
      prefix: --run-l1
  - id: sample
    type:
      - 'null'
      - File
    doc: sample file corresponding to BGEN file
    inputBinding:
      position: 101
      prefix: --sample
  - id: set_list
    type:
      - 'null'
      - File
    doc: file with sets definition
    inputBinding:
      position: 101
      prefix: --set-list
  - id: set_singletons
    type:
      - 'null'
      - boolean
    doc: use 0/1 indicator in third column of AAF file to specify singleton 
      variants
    inputBinding:
      position: 101
      prefix: --set-singletons
  - id: sex_specific
    type:
      - 'null'
      - string
    doc: for sex-specific analyses (male/female)
    inputBinding:
      position: 101
      prefix: --sex-specific
  - id: singleton_carrier
    type:
      - 'null'
      - boolean
    doc: define singletons as variants with a single carrier in the sample
    inputBinding:
      position: 101
      prefix: --singleton-carrier
  - id: skip_test
    type:
      - 'null'
      - boolean
    doc: skip computing association tests after building masks
    inputBinding:
      position: 101
      prefix: --skip-test
  - id: spa
    type:
      - 'null'
      - boolean
    doc: use Saddlepoint approximation (SPA) for p-values less than threshold
    inputBinding:
      position: 101
      prefix: --spa
  - id: split_l0
    type:
      - 'null'
      - string
    doc: split level 0 across N jobs and set prefix of output files
    inputBinding:
      position: 101
      prefix: --split-l0
  - id: step
    type:
      - 'null'
      - int
    doc: specify if fitting null model (=1) or association testing (=2)
    inputBinding:
      position: 101
      prefix: --step
  - id: strict
    type:
      - 'null'
      - boolean
    doc: remove all samples with missingness at any of the traits
    inputBinding:
      position: 101
      prefix: --strict
  - id: strict_check_burden
    type:
      - 'null'
      - boolean
    doc: to exit early if the annotation, set list and mask definition files 
      don't agree
    inputBinding:
      position: 101
      prefix: --strict-check-burden
  - id: t2e
    type:
      - 'null'
      - boolean
    doc: analyze phenotypes as time to event
    inputBinding:
      position: 101
      prefix: --t2e
  - id: test
    type:
      - 'null'
      - string
    doc: "'additive', 'dominant' or 'recessive' (default is additive test)"
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_null_firth
    type:
      - 'null'
      - File
    doc: use stored coefficients for null model in approximate Firth
    inputBinding:
      position: 101
      prefix: --use-null-firth
  - id: use_prs
    type:
      - 'null'
      - boolean
    doc: when using whole genome PRS step 1 output in '--pred'
    inputBinding:
      position: 101
      prefix: --use-prs
  - id: vc_max_aaf
    type:
      - 'null'
      - float
    doc: maximum AAF for variants included in gene-based tests
    inputBinding:
      position: 101
      prefix: --vc-maxAAF
  - id: vc_tests
    type:
      - 'null'
      - type: array
        items: string
    doc: comma separated list of tests to compute for each set of variants 
      included in a mask [skat/skato/skato-acat/acatv/acato]
    inputBinding:
      position: 101
      prefix: --vc-tests
  - id: weights_col
    type:
      - 'null'
      - string
    doc: column index (1-based) for user-defined weights in annotation file
    inputBinding:
      position: 101
      prefix: --weights-col
  - id: write_mask
    type:
      - 'null'
      - boolean
    doc: write masks in PLINK bed/bim/fam format
    inputBinding:
      position: 101
      prefix: --write-mask
  - id: write_null_firth
    type:
      - 'null'
      - boolean
    doc: store coefficients from null models with approximate Firth for step 2
    inputBinding:
      position: 101
      prefix: --write-null-firth
  - id: write_samples
    type:
      - 'null'
      - boolean
    doc: write IDs of samples included for each trait (only in step 2)
    inputBinding:
      position: 101
      prefix: --write-samples
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regenie:4.1.2--he9e75c4_0
stdout: regenie.out
