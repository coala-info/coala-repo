cwlVersion: v1.2
class: CommandLineTool
baseCommand: bolt
label: bolt-lmm_bolt
doc: "BOLT-LMM, v2.5\n\nTool homepage: https://alkesgroup.broadinstitute.org/BOLT-LMM/"
inputs:
  - id: bed
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bed
    doc: PLINK .bed file(s); for >1, use multiple --bim and/or {i:j} expansion
    inputBinding:
      position: 101
  - id: bfile
    type:
      - 'null'
      - File
    doc: prefix of PLINK .fam, .bim, .bed files (give the .bed file; .bim and 
      .fam must sit beside it)
    secondaryFiles:
      - ^.bim
      - ^.fam
    inputBinding:
      position: 101
      prefix: --bfile
      valueFrom: $(self.path.replace(/\.bed$/, ''))
  - id: bfilegz
    type:
      - 'null'
      - File
    doc: prefix of PLINK .fam.gz, .bim.gz, .bed.gz files (give the .bed.gz 
      file; .bim.gz and .fam.gz must sit beside it)
    secondaryFiles:
      - ^^.bim.gz
      - ^^.fam.gz
    inputBinding:
      position: 101
      prefix: --bfilegz
      valueFrom: $(self.path.replace(/\.bed\.gz$/, ''))
  - id: bgen_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bgenFile
    doc: file(s) containing Oxford BGEN-format genotypes to test for association
    inputBinding:
      position: 101
  - id: bgen_min_info
    type:
      - 'null'
      - float
    doc: INFO threshold on Oxford BGEN-format genotypes; lower-INFO SNPs will be
      ignored
    inputBinding:
      position: 101
      prefix: --bgenMinINFO
  - id: bgen_min_mac
    type:
      - 'null'
      - int
    doc: minimum MAC threshold (in samples included in association tests) on 
      BGEN v1.2+ genotypes
    inputBinding:
      position: 101
      prefix: --bgenMinMAC
  - id: bgen_min_maf
    type:
      - 'null'
      - float
    doc: MAF threshold on Oxford BGEN-format genotypes; lower-MAF SNPs will be 
      ignored
    inputBinding:
      position: 101
      prefix: --bgenMinMAF
  - id: bgen_ref_first
    type:
      - 'null'
      - boolean
    doc: set effect allele (ALLELE1) to second allele in BGEN v1.2+ genotype 
      file
    inputBinding:
      position: 101
      prefix: --bgenRefFirst
  - id: bgen_sample_file_list
    type:
      - 'null'
      - File
    doc: list of [bgen sample] file pairs containing BGEN imputed variants to 
      test for association
    inputBinding:
      position: 101
      prefix: --bgenSampleFileList
  - id: bgen_variants_to_test
    type:
      - 'null'
      - File
    doc: list of bgen variants to test (CHR POS REF ALT)
    inputBinding:
      position: 101
      prefix: --bgenVariantsToTest
  - id: bim
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bim
    doc: PLINK .bim file(s); for >1, use multiple --bim and/or {i:j}, e.g., 
      data.chr{1:22}.bim
    inputBinding:
      position: 101
  - id: covar_col
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --covarCol
    doc: categorical covariate column(s); for >1, use multiple --covarCol and/or
      {i:j} expansion
    inputBinding:
      position: 101
  - id: covar_file
    type:
      - 'null'
      - File
    doc: covariate file (header required; FID IID must be first two columns)
    inputBinding:
      position: 101
      prefix: --covarFile
  - id: covar_use_missing_indic
    type:
      - 'null'
      - boolean
    doc: 'include samples with missing covariates in analysis via missing indicator
      method (default: ignore such samples)'
    inputBinding:
      position: 101
      prefix: --covarUseMissingIndic
  - id: dosage2_file_list
    type:
      - 'null'
      - File
    doc: list of [map dosage] file pairs with 2-dosage SNP probabilities 
      (Ricopili/plink2 --dosage format=2) to test for association
    inputBinding:
      position: 101
      prefix: --dosage2FileList
  - id: dosage_fid_iid_file
    type:
      - 'null'
      - File
    doc: file listing FIDs and IIDs of samples in dosageFile(s), one line per 
      sample
    inputBinding:
      position: 101
      prefix: --dosageFidIidFile
  - id: dosage_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --dosageFile
    doc: file(s) containing imputed SNP dosages to test for association (see 
      manual for format)
    inputBinding:
      position: 101
  - id: exclude
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --exclude
    doc: file(s) listing SNPs to ignore (no header; SNP ID must be first column)
    inputBinding:
      position: 101
  - id: fam
    type:
      - 'null'
      - File
    doc: 'PLINK .fam file (note: file names ending in .gz are auto-[de]compressed)'
    inputBinding:
      position: 101
      prefix: --fam
  - id: genetic_map_file
    type:
      - 'null'
      - File
    doc: 'Oxford-format file for interpolating genetic distances: tables/genetic_map_hg##.txt.gz'
    inputBinding:
      position: 101
      prefix: --geneticMapFile
  - id: impute2_fid_iid_file
    type:
      - 'null'
      - File
    doc: file listing FIDs and IIDs of samples in IMPUTE2 files, one line per 
      sample
    inputBinding:
      position: 101
      prefix: --impute2FidIidFile
  - id: impute2_file_list
    type:
      - 'null'
      - File
    doc: list of [chr file] pairs containing IMPUTE2 SNP probabilities to test 
      for association
    inputBinding:
      position: 101
      prefix: --impute2FileList
  - id: impute2_min_maf
    type:
      - 'null'
      - float
    doc: MAF threshold on IMPUTE2 genotypes; lower-MAF SNPs will be ignored
    inputBinding:
      position: 101
      prefix: --impute2MinMAF
  - id: ldscores_file
    type:
      - 'null'
      - File
    doc: 'LD Scores for calibration of Bayesian assoc stats: tables/LDSCORE.1000G_EUR.tab.gz'
    inputBinding:
      position: 101
      prefix: --LDscoresFile
  - id: lmm
    type:
      - 'null'
      - boolean
    doc: compute assoc stats under the inf model and with Bayesian non-inf prior
      (VB approx), if power gain expected
    inputBinding:
      position: 101
      prefix: --lmm
  - id: lmm_force_non_inf
    type:
      - 'null'
      - boolean
    doc: compute non-inf assoc stats even if BOLT-LMM expects no power gain
    inputBinding:
      position: 101
      prefix: --lmmForceNonInf
  - id: lmm_inf_only
    type:
      - 'null'
      - boolean
    doc: compute mixed model assoc stats under the infinitesimal model
    inputBinding:
      position: 101
      prefix: --lmmInfOnly
  - id: max_missing_per_indiv
    type:
      - 'null'
      - float
    doc: 'QC filter: max missing rate per person'
    inputBinding:
      position: 101
      prefix: --maxMissingPerIndiv
  - id: max_missing_per_snp
    type:
      - 'null'
      - float
    doc: 'QC filter: max missing rate per SNP'
    inputBinding:
      position: 101
      prefix: --maxMissingPerSnp
  - id: model_snps
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --modelSnps
    doc: 'file(s) listing SNPs to use in model (i.e., GRM) (default: use all non-excluded
      SNPs)'
    inputBinding:
      position: 101
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of computational threads
    inputBinding:
      position: 101
      prefix: --numThreads
  - id: pheno_col
    type:
      - 'null'
      - string
    doc: phenotype column header
    inputBinding:
      position: 101
      prefix: --phenoCol
  - id: pheno_file
    type:
      - 'null'
      - File
    doc: phenotype file (header required; FID IID must be first two columns)
    inputBinding:
      position: 101
      prefix: --phenoFile
  - id: pheno_use_fam
    type:
      - 'null'
      - boolean
    doc: use last (6th) column of .fam file as phenotype
    inputBinding:
      position: 101
      prefix: --phenoUseFam
  - id: qcovar_col
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --qCovarCol
    doc: quantitative covariate column(s); for >1, use multiple --qCovarCol 
      and/or {i:j} expansion
    inputBinding:
      position: 101
  - id: reml
    type:
      - 'null'
      - boolean
    doc: run variance components analysis to precisely estimate heritability 
      (but not compute assoc stats)
    inputBinding:
      position: 101
      prefix: --reml
  - id: remove
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --remove
    doc: file(s) listing individuals to ignore (no header; FID IID must be first
      two columns)
    inputBinding:
      position: 101
  - id: sample_file
    type:
      - 'null'
      - File
    doc: file containing Oxford sample file corresponding to BGEN file(s)
    inputBinding:
      position: 101
      prefix: --sampleFile
  - id: no_map_check
    type:
      - 'null'
      - boolean
    doc: "disable automatic check of genetic map scale"
    inputBinding:
      position: 101
      prefix: --noMapCheck
  - id: no_dosage_id_check
    type:
      - 'null'
      - boolean
    doc: "disable automatic check of match between PLINK and dosage sample IDs"
    inputBinding:
      position: 101
      prefix: --noDosageIDcheck
  - id: no_dosage2_id_check
    type:
      - 'null'
      - boolean
    doc: "disable automatic check of match between PLINK and 2-dosage sample IDs"
    inputBinding:
      position: 101
      prefix: --noDosage2IDcheck
  - id: no_impute2_id_check
    type:
      - 'null'
      - boolean
    doc: "disable automatic check of match between PLINK and IMPUTE2 sample IDs"
    inputBinding:
      position: 101
      prefix: --noImpute2IDcheck
  - id: no_bgen_id_check
    type:
      - 'null'
      - boolean
    doc: "disable automatic check of match between PLINK and BGEN sample IDs"
    inputBinding:
      position: 101
      prefix: --noBgenIDcheck
  - id: max_model_snps
    type:
      - 'null'
      - int
    doc: "an error-check: if millions of SNPs are imputed, it's inefficient to use them all (default 1000000)"
    inputBinding:
      position: 101
      prefix: --maxModelSnps
  - id: covar_max_levels
    type:
      - 'null'
      - int
    doc: "an error-check: maximum number of levels for a categorical covariate (default 10)"
    inputBinding:
      position: 101
      prefix: --covarMaxLevels
  - id: max_bgen_variants_to_scan
    type:
      - 'null'
      - int
    doc: "an error-check: if --bgenVariantsToTest is supplied, each bgen file is scanned for the presence of a listed variant within the first this many variants (default 100000)"
    inputBinding:
      position: 101
      prefix: --maxBgenVariantsToScan
  - id: num_leave_out_chunks
    type:
      - 'null'
      - int
    doc: "# of SNP groups left out in turn to avoid proximal contamination (default: # chroms; LOCO analysis)"
    inputBinding:
      position: 101
      prefix: --numLeaveOutChunks
  - id: num_calib_snps
    type:
      - 'null'
      - int
    doc: "# of random SNPs at which to compute denominator of prospective statistic for calibration (default 30)"
    inputBinding:
      position: 101
      prefix: --numCalibSnps
  - id: h2g_guess
    type:
      - 'null'
      - float
    doc: "initial guess of h2g for LMM assoc (default 0.25)"
    inputBinding:
      position: 101
      prefix: --h2gGuess
  - id: h2_est_mc_trials
    type:
      - 'null'
      - int
    doc: "number of MC trials to use when roughly estimating h2g for LMM assoc (0 = auto)"
    inputBinding:
      position: 101
      prefix: --h2EstMCtrials
  - id: re_est_mc_trials
    type:
      - 'null'
      - int
    doc: "number of MC trials to use when re-estimating h2g for each LOCO rep (0 = no re-est)"
    inputBinding:
      position: 101
      prefix: --reEstMCtrials
  - id: reml_no_refine
    type:
      - 'null'
      - boolean
    doc: "compute faster (~2-3x) but slightly less accurate (~1.03x higher SE) REML variance parameter estimates"
    inputBinding:
      position: 101
      prefix: --remlNoRefine
  - id: reml_guess_str
    type:
      - 'null'
      - string
    doc: "initial variance parameter guesses (see manual for format) for REML optimization"
    inputBinding:
      position: 101
      prefix: --remlGuessStr
  - id: gen_window
    type:
      - 'null'
      - float
    doc: "genetic dist buffer (Morgans) to avoid proximal contamination if # MLMe leave-out groups > # chroms (default 0.02)"
    inputBinding:
      position: 101
      prefix: --genWindow
  - id: phys_window
    type:
      - 'null'
      - int
    doc: "physical dist buffer (bp) to avoid proximal contamination if # MLMe leave-out groups > # chroms (default 2000000)"
    inputBinding:
      position: 101
      prefix: --physWindow
  - id: p_est
    type:
      - 'null'
      - float
    doc: "prior prob SNP effect is drawn from large-effect mixture component (default: est via CV)"
    inputBinding:
      position: 101
      prefix: --pEst
  - id: var_frac2_est
    type:
      - 'null'
      - float
    doc: "prior fraction of variance in small-effect mixture component (default: estimate via CV)"
    inputBinding:
      position: 101
      prefix: --varFrac2Est
  - id: cv_folds_split
    type:
      - 'null'
      - int
    doc: "cross-validation folds to split samples into for mixture param estimation (default 5)"
    inputBinding:
      position: 101
      prefix: --CVfoldsSplit
  - id: cv_folds_compute
    type:
      - 'null'
      - int
    doc: "max cross-validation folds to actually compute: for large N, few are needed (0 = auto)"
    inputBinding:
      position: 101
      prefix: --CVfoldsCompute
  - id: cv_no_early_exit
    type:
      - 'null'
      - boolean
    doc: "run full CV (by default, CV exits once best param choice is statistically clear"
    inputBinding:
      position: 101
      prefix: --CVnoEarlyExit
  - id: ldscores_col
    type:
      - 'null'
      - string
    doc: "column name of LD Scores to use in regression (default LDSCORE)"
    inputBinding:
      position: 101
      prefix: --LDscoresCol
  - id: ldscores_use_chip
    type:
      - 'null'
      - boolean
    doc: "use LD Scores estimated among chip SNPs instead of reference panel"
    inputBinding:
      position: 101
      prefix: --LDscoresUseChip
  - id: ldscores_match_bp
    type:
      - 'null'
      - boolean
    doc: "match SNPs to reference LD Scores based on (chr,bp) coordinates"
    inputBinding:
      position: 101
      prefix: --LDscoresMatchBp
  - id: n_autosomes
    type:
      - 'null'
      - int
    doc: "number of autosomes for organism being studied (default 22)"
    inputBinding:
      position: 101
      prefix: --Nautosomes
  - id: cg_tol
    type:
      - 'null'
      - float
    doc: "tolerance for declaring convergence of conjugate gradient solver (default 5e-4)"
    inputBinding:
      position: 101
      prefix: --CGtol
  - id: approx_ll_tol
    type:
      - 'null'
      - float
    doc: "tolerance for declaring convergence of variational Bayes (default 0.01)"
    inputBinding:
      position: 101
      prefix: --approxLLtol
  - id: max_iters
    type:
      - 'null'
      - int
    doc: "max number of iterations (default 500)"
    inputBinding:
      position: 101
      prefix: --maxIters
  - id: snps_per_block
    type:
      - 'null'
      - int
    doc: "working set of SNPs to process at once while performing computations (default 64)"
    inputBinding:
      position: 101
      prefix: --snpsPerBlock
  - id: lmm_bayes_mcmc
    type:
      - 'null'
      - boolean
    doc: "compute Bayesian mixed model assoc stats using MCMC"
    inputBinding:
      position: 101
      prefix: --lmmBayesMCMC
  - id: mcmc_iters
    type:
      - 'null'
      - int
    doc: "number of MCMC iterations to use (default: min(maxIters, 5*number of VB iters from CV))"
    inputBinding:
      position: 101
      prefix: --MCMCiters
  - id: verbose_stats
    type:
      - 'null'
      - boolean
    doc: "output additional columns in statsFile"
    inputBinding:
      position: 101
      prefix: --verboseStats
  - id: pred_betas_file_path
    type:
      - 'null'
      - string
    doc: output file of betas for risk prediction
    inputBinding:
      position: 107
      prefix: --predBetasFile
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: data files named inside the list files (--impute2FileList, 
      --dosage2FileList, --bgenSampleFileList); staged in the working directory 
      so the names resolve
  - id: stats_file_path
    type:
      - 'null'
      - string
    doc: output file for assoc stats at PLINK genotypes
    inputBinding:
      position: 102
      prefix: --statsFile
  - id: stats_file_bgen_snps_path
    type:
      - 'null'
      - string
    doc: output file for assoc stats at BGEN-format genotypes
    inputBinding:
      position: 103
      prefix: --statsFileBgenSnps
  - id: stats_file_dosage2_snps_path
    type:
      - 'null'
      - string
    doc: output file for assoc stats at 2-dosage format genotypes
    inputBinding:
      position: 104
      prefix: --statsFileDosage2Snps
  - id: stats_file_dosage_snps_path
    type:
      - 'null'
      - string
    doc: output file for assoc stats at dosage format genotypes
    inputBinding:
      position: 105
      prefix: --statsFileDosageSnps
  - id: stats_file_impute2_snps_path
    type:
      - 'null'
      - string
    doc: output file for assoc stats at IMPUTE2 format genotypes
    inputBinding:
      position: 106
      prefix: --statsFileImpute2Snps
outputs:
  - id: stats_file
    type:
      - 'null'
      - File
    doc: output file for assoc stats at PLINK genotypes
    outputBinding:
      glob: $(inputs.stats_file_path)
  - id: stats_file_dosage_snps
    type:
      - 'null'
      - File
    doc: output file for assoc stats at dosage format genotypes
    outputBinding:
      glob: $(inputs.stats_file_dosage_snps_path)
  - id: stats_file_bgen_snps
    type:
      - 'null'
      - File
    doc: output file for assoc stats at BGEN-format genotypes
    outputBinding:
      glob: $(inputs.stats_file_bgen_snps_path)
  - id: stats_file_impute2_snps
    type:
      - 'null'
      - File
    doc: output file for assoc stats at IMPUTE2 format genotypes
    outputBinding:
      glob: $(inputs.stats_file_impute2_snps_path)
  - id: stats_file_dosage2_snps
    type:
      - 'null'
      - File
    doc: output file for assoc stats at 2-dosage format genotypes
    outputBinding:
      glob: $(inputs.stats_file_dosage2_snps_path)
  - id: pred_betas_file
    type:
      - 'null'
      - File
    doc: output file of betas for risk prediction
    outputBinding:
      glob: $(inputs.pred_betas_file_path)
  - id: log
    type: stdout
    doc: BOLT-LMM log (standard output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.listed_files ? inputs.listed_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bolt-lmm:2.5--h15e0e67_0
stdout: bolt.log
