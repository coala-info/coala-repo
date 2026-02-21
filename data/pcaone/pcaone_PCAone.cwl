cwlVersion: v1.2
class: CommandLineTool
baseCommand: PCAone
label: pcaone_PCAone
doc: "PCA All In One: A tool for Principal Component Analysis on large-scale datasets,
  supporting various SVD methods and genomic data formats.\n\nTool homepage: https://github.com/Zilong-Li/PCAone"
inputs:
  - id: batches
    type:
      - 'null'
      - int
    doc: the number of mini-batches used by --svd 2
    default: 64
    inputBinding:
      position: 101
      prefix: --batches
  - id: beagle_file
    type:
      - 'null'
      - File
    doc: path of BEAGLE file compressed by gzip
    inputBinding:
      position: 101
      prefix: --beagle
  - id: bgen_file
    type:
      - 'null'
      - File
    doc: path of BGEN file compressed by gzip/zstd
    inputBinding:
      position: 101
      prefix: --bgen
  - id: binary_file
    type:
      - 'null'
      - File
    doc: path of binary file
    inputBinding:
      position: 101
      prefix: --binary
  - id: buffer
    type:
      - 'null'
      - float
    doc: memory buffer in GB unit for permuting the data
    default: 2.0
    inputBinding:
      position: 101
      prefix: --buffer
  - id: clump_bp
    type:
      - 'null'
      - int
    doc: physical distance threshold in bases for clumping
    default: 250000
    inputBinding:
      position: 101
      prefix: --clump-bp
  - id: clump_file
    type:
      - 'null'
      - File
    doc: assoc-like file with target variants and pvalues for clumping
    inputBinding:
      position: 101
      prefix: --clump
  - id: clump_names
    type:
      - 'null'
      - string
    doc: column names in assoc-like file for locating chr, pos and pvalue
    default: CHR,BP,P
    inputBinding:
      position: 101
      prefix: --clump-names
  - id: clump_p1
    type:
      - 'null'
      - float
    doc: significance threshold for index SNPs
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --clump-p1
  - id: clump_p2
    type:
      - 'null'
      - float
    doc: secondary significance threshold for clumped SNPs
    default: 0.01
    inputBinding:
      position: 101
      prefix: --clump-p2
  - id: clump_r2
    type:
      - 'null'
      - float
    doc: r2 cutoff for LD-based clumping
    default: 0.5
    inputBinding:
      position: 101
      prefix: --clump-r2
  - id: csv_file
    type:
      - 'null'
      - File
    doc: path of comma seperated CSV file compressed by zstd
    inputBinding:
      position: 101
      prefix: --csv
  - id: em_max_iter
    type:
      - 'null'
      - int
    doc: maximum number of EM iterations
    default: 100
    inputBinding:
      position: 101
      prefix: --maxiter
  - id: emu
    type:
      - 'null'
      - boolean
    doc: use EMU algorithm for genotype input with missingness
    inputBinding:
      position: 101
      prefix: --emu
  - id: haploid
    type:
      - 'null'
      - boolean
    doc: the plink format represents haploid data
    inputBinding:
      position: 101
      prefix: --haploid
  - id: inbreed
    type:
      - 'null'
      - int
    doc: compute the inbreeding coefficient accounting for population structure
    default: 0
    inputBinding:
      position: 101
      prefix: --inbreed
  - id: iram_max_iter
    type:
      - 'null'
      - int
    doc: maximum number of IRAM iterations
    default: 1000
    inputBinding:
      position: 101
      prefix: --imaxiter
  - id: iram_ncv
    type:
      - 'null'
      - int
    doc: the number of Lanzcos basis vectors for IRAM
    default: 20
    inputBinding:
      position: 101
      prefix: --ncv
  - id: iram_tol
    type:
      - 'null'
      - float
    doc: stopping tolerance for IRAM algorithm
    default: 1e-06
    inputBinding:
      position: 101
      prefix: --itol
  - id: ld_binary
    type:
      - 'null'
      - boolean
    doc: output a binary matrix for downstream LD related analysis
    inputBinding:
      position: 101
      prefix: --ld
  - id: ld_bp_window
    type:
      - 'null'
      - int
    doc: physical distance threshold in bases for LD window
    default: 0
    inputBinding:
      position: 101
      prefix: --ld-bp
  - id: ld_r2_cutoff
    type:
      - 'null'
      - float
    doc: R2 cutoff for LD-based pruning
    default: 0.0
    inputBinding:
      position: 101
      prefix: --ld-r2
  - id: ld_stats
    type:
      - 'null'
      - int
    doc: 'statistics to compute LD R2 (0: ancestry adjusted, 1: standard)'
    default: 0
    inputBinding:
      position: 101
      prefix: --ld-stats
  - id: maf_filter
    type:
      - 'null'
      - float
    doc: exclude variants with MAF lower than this value
    default: 0.0
    inputBinding:
      position: 101
      prefix: --maf
  - id: match_bim
    type:
      - 'null'
      - File
    doc: the .mbim file to be matched, where the 7th column is allele frequency
    inputBinding:
      position: 101
      prefix: --match-bim
  - id: max_power_iterations
    type:
      - 'null'
      - int
    doc: maximum number of power iterations for RSVD algorithm
    default: 20
    inputBinding:
      position: 101
      prefix: --maxp
  - id: memory
    type:
      - 'null'
      - int
    doc: RAM usage in GB unit for out-of-core mode. default is in-core mode
    default: 0
    inputBinding:
      position: 101
      prefix: --memory
  - id: no_shuffle
    type:
      - 'null'
      - boolean
    doc: do not shuffle columns of data for --svd 2
    inputBinding:
      position: 101
      prefix: --no-shuffle
  - id: num_features
    type:
      - 'null'
      - int
    doc: the number of features (eg. SNPs) if already known
    default: 0
    inputBinding:
      position: 101
      prefix: --M
  - id: num_samples
    type:
      - 'null'
      - int
    doc: the number of samples if already known
    default: 0
    inputBinding:
      position: 101
      prefix: --N
  - id: oversamples
    type:
      - 'null'
      - int
    doc: the number of oversampling columns for RSVD
    default: 10
    inputBinding:
      position: 101
      prefix: --oversamples
  - id: pc_count
    type:
      - 'null'
      - int
    doc: top k principal components (PCs) to be calculated
    default: 10
    inputBinding:
      position: 101
      prefix: --pc
  - id: pcangsd
    type:
      - 'null'
      - boolean
    doc: use PCAngsd algorithm for genotype likelihood input
    inputBinding:
      position: 101
      prefix: --pcangsd
  - id: plink_prefix
    type:
      - 'null'
      - string
    doc: prefix of PLINK .bed/.bim/.fam files
    inputBinding:
      position: 101
      prefix: --bfile
  - id: print_loadings
    type:
      - 'null'
      - boolean
    doc: output the right eigenvectors with suffix .loadings
    inputBinding:
      position: 101
      prefix: --printv
  - id: print_r2
    type:
      - 'null'
      - boolean
    doc: print LD R2 to *.ld.gz file for pairwise SNPs within a window
    inputBinding:
      position: 101
      prefix: --print-r2
  - id: project
    type:
      - 'null'
      - int
    doc: 'project the new samples onto the existing PCs (0: disabled, 1: mean imputation,
      2: least squares, 3: Augmentation)'
    default: 0
    inputBinding:
      position: 101
      prefix: --project
  - id: rand_type
    type:
      - 'null'
      - int
    doc: 'the random matrix type. 0: uniform; 1: guassian'
    default: 1
    inputBinding:
      position: 101
      prefix: --rand
  - id: scale
    type:
      - 'null'
      - int
    doc: 'scaling for input file (0: none, 1: standardization, 2: CPMED, 3: log1p,
      4: relative counts)'
    default: 0
    inputBinding:
      position: 101
      prefix: --scale
  - id: scale_factor
    type:
      - 'null'
      - float
    doc: feature counts for each sample are normalized and multiplied by this value
    default: 1.0
    inputBinding:
      position: 101
      prefix: --scale-factor
  - id: seed
    type:
      - 'null'
      - int
    doc: seeds for reproducing results
    default: 101
    inputBinding:
      position: 101
      prefix: --seed
  - id: svd_method
    type:
      - 'null'
      - int
    doc: 'SVD method to be applied (0: IRAM, 1: Randomized SVD, 2: window-based RSVD,
      3: full SVD)'
    default: 2
    inputBinding:
      position: 101
      prefix: --svd
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads to be used
    default: 12
    inputBinding:
      position: 101
      prefix: --threads
  - id: tol_em
    type:
      - 'null'
      - float
    doc: tolerance for EMU/PCAngsd algorithm
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --tol-em
  - id: tol_maf
    type:
      - 'null'
      - float
    doc: tolerance for MAF estimation by EM
    default: 1e-06
    inputBinding:
      position: 101
      prefix: --tol-maf
  - id: tol_rsvd
    type:
      - 'null'
      - float
    doc: tolerance for RSVD algorithm
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --tol-rsvd
  - id: usv_prefix
    type:
      - 'null'
      - string
    doc: prefix of PCAone .eigvecs/.eigvals/.loadings/.mbim
    inputBinding:
      position: 101
      prefix: --USV
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'verbosity level for logs (0: silent, 1: concise, 2: verbose, 3: debug)'
    default: 1
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: prefix of output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pcaone:0.6.0--ha628be3_0
