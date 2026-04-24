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
    doc: PLINK .bed file(s); for >1, use multiple --bim and/or {i:j} expansion
    inputBinding:
      position: 101
      prefix: --bed
  - id: bfile
    type:
      - 'null'
      - string
    doc: prefix of PLINK .fam, .bim, .bed files
    inputBinding:
      position: 101
      prefix: --bfile
  - id: bfilegz
    type:
      - 'null'
      - string
    doc: prefix of PLINK .fam.gz, .bim.gz, .bed.gz files
    inputBinding:
      position: 101
      prefix: --bfilegz
  - id: bgen_file
    type:
      - 'null'
      - type: array
        items: File
    doc: file(s) containing Oxford BGEN-format genotypes to test for association
    inputBinding:
      position: 101
      prefix: --bgenFile
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
      - string
    doc: list of [bgen sample] file pairs containing BGEN imputed variants to 
      test for association
    inputBinding:
      position: 101
      prefix: --bgenSampleFileList
  - id: bgen_variants_to_test
    type:
      - 'null'
      - string
    doc: list of bgen variants to test (CHR POS REF ALT)
    inputBinding:
      position: 101
      prefix: --bgenVariantsToTest
  - id: bim
    type:
      - 'null'
      - type: array
        items: File
    doc: PLINK .bim file(s); for >1, use multiple --bim and/or {i:j}, e.g., 
      data.chr{1:22}.bim
    inputBinding:
      position: 101
      prefix: --bim
  - id: covar_col
    type:
      - 'null'
      - type: array
        items: string
    doc: categorical covariate column(s); for >1, use multiple --covarCol and/or
      {i:j} expansion
    inputBinding:
      position: 101
      prefix: --covarCol
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
      - string
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
    doc: file(s) containing imputed SNP dosages to test for association (see 
      manual for format)
    inputBinding:
      position: 101
      prefix: --dosageFile
  - id: exclude
    type:
      - 'null'
      - type: array
        items: File
    doc: file(s) listing SNPs to ignore (no header; SNP ID must be first column)
    inputBinding:
      position: 101
      prefix: --exclude
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
  - id: helpFull
    type:
      - 'null'
      - boolean
    doc: print help message with full option list
    inputBinding:
      position: 101
      prefix: --helpFull
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
      - string
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
    doc: 'file(s) listing SNPs to use in model (i.e., GRM) (default: use all non-excluded
      SNPs)'
    inputBinding:
      position: 101
      prefix: --modelSnps
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
    doc: quantitative covariate column(s); for >1, use multiple --qCovarCol 
      and/or {i:j} expansion
    inputBinding:
      position: 101
      prefix: --qCovarCol
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
    doc: file(s) listing individuals to ignore (no header; FID IID must be first
      two columns)
    inputBinding:
      position: 101
      prefix: --remove
  - id: sample_file
    type:
      - 'null'
      - File
    doc: file containing Oxford sample file corresponding to BGEN file(s)
    inputBinding:
      position: 101
      prefix: --sampleFile
outputs:
  - id: stats_file
    type:
      - 'null'
      - File
    doc: output file for assoc stats at PLINK genotypes
    outputBinding:
      glob: $(inputs.stats_file)
  - id: stats_file_dosage_snps
    type:
      - 'null'
      - File
    doc: output file for assoc stats at dosage format genotypes
    outputBinding:
      glob: $(inputs.stats_file_dosage_snps)
  - id: stats_file_bgen_snps
    type:
      - 'null'
      - File
    doc: output file for assoc stats at BGEN-format genotypes
    outputBinding:
      glob: $(inputs.stats_file_bgen_snps)
  - id: stats_file_impute2_snps
    type:
      - 'null'
      - File
    doc: output file for assoc stats at IMPUTE2 format genotypes
    outputBinding:
      glob: $(inputs.stats_file_impute2_snps)
  - id: stats_file_dosage2_snps
    type:
      - 'null'
      - File
    doc: output file for assoc stats at 2-dosage format genotypes
    outputBinding:
      glob: $(inputs.stats_file_dosage2_snps)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bolt-lmm:2.5--h15e0e67_0
