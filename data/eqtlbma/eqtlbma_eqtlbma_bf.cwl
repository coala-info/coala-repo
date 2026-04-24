cwlVersion: v1.2
class: CommandLineTool
baseCommand: eqtlbma_bf
label: eqtlbma_eqtlbma_bf
doc: "performs eQTL mapping in multiple subgroups via a Bayesian model.\n\nTool homepage:
  https://github.com/timflutre/eqtlbma"
inputs:
  - id: analys
    type:
      - 'null'
      - string
    doc: "analysis to perform\n'sep': separate analysis of each subgroup\n'join':
      joint analysis of all subgroups"
    inputBinding:
      position: 101
      prefix: --analys
  - id: anchor
    type:
      - 'null'
      - string
    doc: "gene boundary(ies) for the cis region\ndefault=TSS (assumed to be start
      in BED file)"
    inputBinding:
      position: 101
      prefix: --anchor
  - id: bfs
    type:
      - 'null'
      - string
    doc: "which Bayes Factors to compute for the joint analysis\nonly the Laplace-approximated
      BF from Wen and Stephens (AoAS 2013) is implemented\nif --outw, each BF for
      a given configuration is the average of the BFs over one of the grids, with
      equal weights\n'gen' (default): general way to capture any level of heterogeneity\n\
      \ correspond to the consistent configuration with the large grid\n fixed-effect
      and maximum-heterogeneity BFs are also calculated\n'sin': compute also the BF
      for each singleton (subgroup-specific configuration)\n they use the small grid
      (BF_BMAlite is also reported)\n'all': compute also the BFs for all configurations
      (costly if many subgroups)\n all BFs use the small grid (BF_BMA is also reported)"
    inputBinding:
      position: 101
      prefix: --bfs
  - id: cis
    type:
      - 'null'
      - int
    doc: "length of half of the cis region (radius, in bp)\napart from the anchor(s),
      default=100000"
    inputBinding:
      position: 101
      prefix: --cis
  - id: covar
    type:
      - 'null'
      - File
    doc: "file with absolute paths to covariate files\ntwo columns: subgroup identifier<space/tab>path
      to file\ncan be a single line (single subgroup)\nadd '#' at the beginning of
      a line to comment it\nsubgroup file: row 1 is a header sample<space/tab>covariate1
      ...\nall sample names should be in the respective genotype and exp level files\n\
      the covariates should be numbers, no missing value is allowed\nsubgroups can
      have different covariates\nthe order of rows is not important"
    inputBinding:
      position: 101
      prefix: --covar
  - id: error
    type:
      - 'null'
      - string
    doc: "model for the errors (if --analys join)\n'uvlr': default, errors are not
      correlated between subgroups (different individuals)\n'mvlr': errors can be
      correlated between subgroups (same individuals)\n'hybrid': errors can be correlated
      between pairs of subgroups (common individuals)"
    inputBinding:
      position: 101
      prefix: --error
  - id: exp
    type:
      - 'null'
      - File
    doc: "file with absolute paths to expression level files\ntwo columns: subgroup
      identifier<space/tab>path to file\nadd '#' at the beginning of a line to comment
      it\nsubgroup file: custom format, same as for MatrixEQTL\n row 1 for sample
      names, column 1 for gene names\nsubgroups can have different genes\nall genes
      should be in the --gcoord file"
    inputBinding:
      position: 101
      prefix: --exp
  - id: fiterr
    type:
      - 'null'
      - float
    doc: "param used when estimating the variance of the errors (if --analys join,
      only with 'mvlr' or 'hybrid')\ndefault=0.5 but can be between 0 (null model)
      and 1 (full model)"
    inputBinding:
      position: 101
      prefix: --fiterr
  - id: gcoord
    type:
      - 'null'
      - File
    doc: "file with the gene coordinates\nshould be in the BED format (delimiter:
      tab)\ngenes in the exp level files without coordinates are skipped"
    inputBinding:
      position: 101
      prefix: --gcoord
  - id: geno
    type:
      - 'null'
      - File
    doc: "file with absolute paths to genotype files\ntwo columns: subgroup identifier<space/tab>path
      to file\nadd '#' at the beginning of a line to comment it\nsubgroup file: can
      be in three formats (VCF/IMPUTE/custom)\nVCF: see specifications on 1kG website\n\
      IMPUTE: row 1 is a header chr<del>name<del>coord<del>a1<del>a2\n followed by
      >sample1_a1a1<del>sample1_a1a2<del>sample1_a2a2<del>...\ncustom: genotypes as
      allele dose, same as for MatrixEQTL\n and missing data can be NA or -1 (as used
      by vcftools --012)"
    inputBinding:
      position: 101
      prefix: --geno
  - id: gridl
    type:
      - 'null'
      - File
    doc: "file with a 'large' grid for prior variances in standardized effect sizes\n\
      first column is phi^2 and second column is omega^2, no header\nthis grid is
      used with model 1 ('general alternative') trying to capture\n all sorts of heterogeneity\n\
      required with --analys join"
    inputBinding:
      position: 101
      prefix: --gridL
  - id: grids
    type:
      - 'null'
      - File
    doc: "file with a 'small' grid of values for phi^2 and omega^2\nsame format as
      --gridL\nrequired with --analyis join if --bfs is 'sin' or 'all'"
    inputBinding:
      position: 101
      prefix: --gridS
  - id: inss
    type:
      - 'null'
      - File
    doc: "file with absolute paths to files with summary statistics\ntwo columns:
      subgroup identifier<space/tab>path to file\nadd '#' at the beginning of a line
      to comment it\nsstats file: custom format, similar to the one from --outss (see
      below)\n header should have gene, snp, n, sigmahat, betahat.geno and sebetahat.geno\n\
      \ order doesn't matter"
    inputBinding:
      position: 101
      prefix: --inss
  - id: lik
    type:
      - 'null'
      - string
    doc: "likelihood to use\n'normal' (default)\n'poisson' or 'quasipoisson'"
    inputBinding:
      position: 101
      prefix: --lik
  - id: maf
    type:
      - 'null'
      - float
    doc: minimum minor allele frequency (default=0.0)
    inputBinding:
      position: 101
      prefix: --maf
  - id: maxbf
    type:
      - 'null'
      - boolean
    doc: "use the maximum ABF over SNPs as test statistic for permutations\notherwise
      the average ABF over SNPs is used (more Bayesian)"
    inputBinding:
      position: 101
      prefix: --maxbf
  - id: nperm
    type:
      - 'null'
      - int
    doc: "number of permutations\ndefault=0, otherwise 10000 is recommended"
    inputBinding:
      position: 101
      prefix: --nperm
  - id: outss
    type:
      - 'null'
      - boolean
    doc: write the output file with all summary statistics
    inputBinding:
      position: 101
      prefix: --outss
  - id: outw
    type:
      - 'null'
      - boolean
    doc: "write the output file with the ABFs averaged over the grid\ngrid weights
      are uniformly equal"
    inputBinding:
      position: 101
      prefix: --outw
  - id: pbf
    type:
      - 'null'
      - string
    doc: "which BF to use as the test statistic for the joint-analysis permutations\n\
      'none' (default): no permutations are done for the joint analysis\n'gen': general
      BF (see --bfs above)\n'gen-sin': 0.5 BFgen + 0.5 BFsin (also called BF_BMAlite)\n\
      'all': average over all configurations (also called BF_BMA)"
    inputBinding:
      position: 101
      prefix: --pbf
  - id: permsep
    type:
      - 'null'
      - int
    doc: "which permutation procedure for the separate analysis\n0 (default): no permutations
      are done for the separate analysis\n1: use the minimum P-value over SNPs and
      subgroups as a test statistic (keeps correlations)\n2: use the minimum P-value
      over SNPs but in each subgroup separately (breaks correlations)"
    inputBinding:
      position: 101
      prefix: --permsep
  - id: qnorm
    type:
      - 'null'
      - boolean
    doc: quantile-normalize the exp levels to a N(0,1)
    inputBinding:
      position: 101
      prefix: --qnorm
  - id: sbgrp
    type:
      - 'null'
      - string
    doc: "identifier of the subgroup to analyze\nuseful for quick analysis and debugging\n\
      can be 'sbgrp1+sbgrp3' for instance"
    inputBinding:
      position: 101
      prefix: --sbgrp
  - id: scoord
    type:
      - 'null'
      - File
    doc: "file with the SNP coordinates\ncompulsory if custom genotype format; forbidden
      otherwise\nshould be in the BED format (delimiter: tab)\nSNPs in the genotype
      files without coordinate are skipped (see also --snp)\nif a tabix-indexed file
      is also present, it will be used"
    inputBinding:
      position: 101
      prefix: --scoord
  - id: seed
    type:
      - 'null'
      - int
    doc: "seed for the two random number generators\none for the permutations, another
      for the trick\nby default, both are initialized via microseconds from epoch\n\
      the RNGs are re-seeded before each subgroup and before the joint analysis\n\
      this, along with --trick 2, allows for proper comparison of separate and joint
      analyzes"
    inputBinding:
      position: 101
      prefix: --seed
  - id: snp
    type:
      - 'null'
      - File
    doc: "file with a list of SNPs to analyze\none SNP name per line, useful when
      launched in parallel\nprogram exits if an empty file is given"
    inputBinding:
      position: 101
      prefix: --snp
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads (default=1, parallelize over SNPs)
    inputBinding:
      position: 101
      prefix: --thread
  - id: trick
    type:
      - 'null'
      - string
    doc: "apply trick to speed-up permutations\nstop after the tenth permutation for
      which the test statistic\n is better than or equal to the true value, and sample
      from\n a uniform between 11/(nbPermsSoFar+2) and 11/(nbPermsSoFar+1)\nif '1',
      the permutations really stops\nif '2', all permutations are done but the test
      statistics are not computed\nallows to compare different test statistics on
      the same permutations"
    inputBinding:
      position: 101
      prefix: --trick
  - id: tricut
    type:
      - 'null'
      - int
    doc: "cutoff for the trick (default=10)\nstop permutations once the nb of permutations
      for which permTestStat is more extreme\n than trueTestStat equals this cutoff"
    inputBinding:
      position: 101
      prefix: --tricut
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level (0/default=1/2/3)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: wrtsize
    type:
      - 'null'
      - int
    doc: "number of genes which results are written at once (default=10)\nto prevent
      excessive memory usage\ntune it depending on the average number of cis SNPs
      per gene"
    inputBinding:
      position: 101
      prefix: --wrtsize
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: "prefix for the output files\nall output files are gzipped and have a header
      line"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0
