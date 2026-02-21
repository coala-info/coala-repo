cwlVersion: v1.2
class: CommandLineTool
baseCommand: pcangsd
label: pcangsd
doc: "PCAngsd is a tool for analyzing low-depth next-generation sequencing data using
  principal component analysis (PCA) and related methods.\n\nTool homepage: https://github.com/Rosemeis/pcangsd"
inputs:
  - id: admix
    type:
      - 'null'
      - boolean
    doc: Estimate admixture proportions and ancestral allele frequencies
    inputBinding:
      position: 101
      prefix: --admix
  - id: admix_alpha
    type:
      - 'null'
      - float
    doc: Alpha value for regularization in admixture estimations - NMF
    default: 0.0
    inputBinding:
      position: 101
      prefix: --admix-alpha
  - id: admix_auto
    type:
      - 'null'
      - float
    doc: Enable automatic search for alpha by giving soft upper search bound
    inputBinding:
      position: 101
      prefix: --admix-auto
  - id: admix_batch
    type:
      - 'null'
      - int
    doc: Number of mini-batches in stochastic admixture estimations - NMF
    default: 10
    inputBinding:
      position: 101
      prefix: --admix-batch
  - id: admix_depth
    type:
      - 'null'
      - int
    doc: Depth in automatic search of alpha
    default: 7
    inputBinding:
      position: 101
      prefix: --admix-depth
  - id: admix_iter
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for admixture estimations - NMF
    default: 500
    inputBinding:
      position: 101
      prefix: --admix-iter
  - id: admix_k
    type:
      - 'null'
      - int
    doc: Number of admixture components
    inputBinding:
      position: 101
      prefix: --admix-K
  - id: admix_seed
    type:
      - 'null'
      - int
    doc: Random seed used in admixture estimations - NMF
    default: 0
    inputBinding:
      position: 101
      prefix: --admix-seed
  - id: admix_tole
    type:
      - 'null'
      - float
    doc: Tolerance for admixture estimations - NMF
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --admix-tole
  - id: beagle
    type:
      - 'null'
      - File
    doc: Filepath to genotype likelihoods in gzipped Beagle format from ANGSD
    inputBinding:
      position: 101
      prefix: --beagle
  - id: dosage_save
    type:
      - 'null'
      - boolean
    doc: Save genotype dosages
    inputBinding:
      position: 101
      prefix: --dosage-save
  - id: eig
    type:
      - 'null'
      - int
    doc: Manual selection of number of eigenvectors in modelling
    inputBinding:
      position: 101
      prefix: --eig
  - id: filter
    type:
      - 'null'
      - File
    doc: Input file of vector for filtering samples
    inputBinding:
      position: 101
      prefix: --filter
  - id: filter_sites
    type:
      - 'null'
      - File
    doc: Input file of vector for filtering sites
    inputBinding:
      position: 101
      prefix: --filter-sites
  - id: geno
    type:
      - 'null'
      - float
    doc: Call genotypes from posterior probabilities with threshold
    inputBinding:
      position: 101
      prefix: --geno
  - id: geno_error
    type:
      - 'null'
      - float
    doc: Incorporate errors into genotypes
    default: 0.0
    inputBinding:
      position: 101
      prefix: --geno-error
  - id: geno_inbreed
    type:
      - 'null'
      - float
    doc: Call genotypes (inbreeding) from posterior probabilities with threshold
    inputBinding:
      position: 101
      prefix: --geno-inbreed
  - id: hwe
    type:
      - 'null'
      - File
    doc: Input file of LRTs from HWE test for site filtering
    inputBinding:
      position: 101
      prefix: --hwe
  - id: hwe_tole
    type:
      - 'null'
      - float
    doc: Tolerance for HWE filtering of sites
    default: 1e-06
    inputBinding:
      position: 101
      prefix: --hwe-tole
  - id: inbreed_iter
    type:
      - 'null'
      - int
    doc: Maximum iterations for inbreeding coefficients estimation - EM
    default: 500
    inputBinding:
      position: 101
      prefix: --inbreed-iter
  - id: inbreed_samples
    type:
      - 'null'
      - boolean
    doc: Compute the per-sample inbreeding coefficients
    inputBinding:
      position: 101
      prefix: --inbreed-samples
  - id: inbreed_sites
    type:
      - 'null'
      - boolean
    doc: Compute the per-site inbreeding coefficients and LRT
    inputBinding:
      position: 101
      prefix: --inbreed-sites
  - id: inbreed_tole
    type:
      - 'null'
      - float
    doc: Tolerance for inbreeding coefficients estimation update - EM
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --inbreed-tole
  - id: iter
    type:
      - 'null'
      - int
    doc: Maximum iterations for estimation of individual allele frequencies
    default: 100
    inputBinding:
      position: 101
      prefix: --iter
  - id: maf
    type:
      - 'null'
      - float
    doc: Minimum minor allele frequency threshold
    default: 0.05
    inputBinding:
      position: 101
      prefix: --maf
  - id: maf_iter
    type:
      - 'null'
      - int
    doc: Maximum iterations for minor allele frequencies estimation - EM
    default: 500
    inputBinding:
      position: 101
      prefix: --maf-iter
  - id: maf_save
    type:
      - 'null'
      - boolean
    doc: Save population allele frequencies
    inputBinding:
      position: 101
      prefix: --maf-save
  - id: maf_tole
    type:
      - 'null'
      - float
    doc: Tolerance for minor allele frequencies estimation update - EM
    default: 1e-06
    inputBinding:
      position: 101
      prefix: --maf-tole
  - id: pcadapt
    type:
      - 'null'
      - boolean
    doc: Perform pcadapt selection scan
    inputBinding:
      position: 101
      prefix: --pcadapt
  - id: pi_save
    type:
      - 'null'
      - boolean
    doc: Save individual allele frequencies
    inputBinding:
      position: 101
      prefix: --pi-save
  - id: plink
    type:
      - 'null'
      - string
    doc: Prefix PLINK files (.bed, .bim, .fam)
    inputBinding:
      position: 101
      prefix: --plink
  - id: post
    type:
      - 'null'
      - boolean
    doc: Save genotype posteriors
    inputBinding:
      position: 101
      prefix: --post
  - id: post_inbreed
    type:
      - 'null'
      - boolean
    doc: Save genotype posteriors (inbreeding)
    inputBinding:
      position: 101
      prefix: --post-inbreed
  - id: selection
    type:
      - 'null'
      - boolean
    doc: Perform PC-based genome-wide selection scan
    inputBinding:
      position: 101
      prefix: --selection
  - id: selection_eig
    type:
      - 'null'
      - int
    doc: Manual selection of number of eigenvectors in selection scans/SNP weights
    inputBinding:
      position: 101
      prefix: --selection-eig
  - id: sites_save
    type:
      - 'null'
      - boolean
    doc: Save boolean vector of used sites
    inputBinding:
      position: 101
      prefix: --sites-save
  - id: snp_weights
    type:
      - 'null'
      - boolean
    doc: Estimate SNP weights
    inputBinding:
      position: 101
      prefix: --snp-weights
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tole
    type:
      - 'null'
      - float
    doc: Tolerance for update in estimation of individual allele frequencies
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --tole
  - id: tree
    type:
      - 'null'
      - boolean
    doc: Construct NJ tree from covariance matrix
    inputBinding:
      position: 101
      prefix: --tree
  - id: tree_samples
    type:
      - 'null'
      - File
    doc: List of sample names to create beautiful tree
    inputBinding:
      position: 101
      prefix: --tree-samples
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pcangsd:1.36.4--py311h8ddd9a4_0
