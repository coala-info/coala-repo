cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyseer
label: pyseer
doc: "SEER (doi: 10.1038/ncomms12797), reimplemented in python\n\nTool homepage: https://github.com/mgalardini/pyseer"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: Set the mixing between l1 and l2 penalties
    inputBinding:
      position: 101
      prefix: --alpha
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of variants per core
    inputBinding:
      position: 101
      prefix: --block_size
  - id: burden
    type:
      - 'null'
      - File
    doc: VCF regions to group variants by for burden testing (requires --vcf). 
      Requires vcf to be indexed
    inputBinding:
      position: 101
      prefix: --burden
  - id: continuous
    type:
      - 'null'
      - boolean
    doc: 'Force continuous phenotype [Default: binary auto-detect]'
    inputBinding:
      position: 101
      prefix: --continuous
  - id: cor_filter
    type:
      - 'null'
      - float
    doc: Correlation filter for elastic net (phenotype/variant correlation 
      quantile at which to start keeping variants)
    inputBinding:
      position: 101
      prefix: --cor-filter
  - id: covariates
    type:
      - 'null'
      - File
    doc: User-defined covariates file (tab-delimited, with header, first column 
      contains sample names)
    inputBinding:
      position: 101
      prefix: --covariates
  - id: cpu
    type:
      - 'null'
      - int
    doc: Processes
    inputBinding:
      position: 101
      prefix: --cpu
  - id: distances
    type:
      - 'null'
      - File
    doc: Strains distance square matrix (fixed or lineage effects)
    inputBinding:
      position: 101
      prefix: --distances
  - id: filter_pvalue
    type:
      - 'null'
      - float
    doc: Prefiltering t-test pvalue threshold
    inputBinding:
      position: 101
      prefix: --filter-pvalue
  - id: kmers
    type:
      - 'null'
      - File
    doc: Kmers file
    inputBinding:
      position: 101
      prefix: --kmers
  - id: lineage
    type:
      - 'null'
      - boolean
    doc: Report lineage effects
    inputBinding:
      position: 101
      prefix: --lineage
  - id: lineage_clusters
    type:
      - 'null'
      - File
    doc: 'Custom clusters to use as lineages [Default: MDS components]'
    inputBinding:
      position: 101
      prefix: --lineage-clusters
  - id: lineage_file
    type:
      - 'null'
      - File
    doc: File to write lineage association to
    inputBinding:
      position: 101
      prefix: --lineage-file
  - id: lmm
    type:
      - 'null'
      - boolean
    doc: Use random instead of fixed effects to correct for population 
      structure. Requires a similarity matrix
    inputBinding:
      position: 101
      prefix: --lmm
  - id: load_lmm
    type:
      - 'null'
      - File
    doc: Load an existing lmm cache
    inputBinding:
      position: 101
      prefix: --load-lmm
  - id: load_m
    type:
      - 'null'
      - File
    doc: Load an existing matrix decomposition
    inputBinding:
      position: 101
      prefix: --load-m
  - id: load_vars
    type:
      - 'null'
      - string
    doc: Prefix for loading variants
    inputBinding:
      position: 101
      prefix: --load-vars
  - id: lrt_pvalue
    type:
      - 'null'
      - float
    doc: Likelihood ratio test pvalue threshold
    inputBinding:
      position: 101
      prefix: --lrt-pvalue
  - id: max_af
    type:
      - 'null'
      - float
    doc: Maximum AF
    inputBinding:
      position: 101
      prefix: --max-af
  - id: max_dimensions
    type:
      - 'null'
      - int
    doc: Maximum number of dimensions to consider after MDS
    inputBinding:
      position: 101
      prefix: --max-dimensions
  - id: max_missing
    type:
      - 'null'
      - float
    doc: Maximum missing (vcf/Rtab)
    inputBinding:
      position: 101
      prefix: --max-missing
  - id: mds
    type:
      - 'null'
      - string
    doc: Type of multidimensional scaling
    inputBinding:
      position: 101
      prefix: --mds
  - id: min_af
    type:
      - 'null'
      - float
    doc: Minimum AF
    inputBinding:
      position: 101
      prefix: --min-af
  - id: n_folds
    type:
      - 'null'
      - int
    doc: Number of folds cross-validation to perform
    inputBinding:
      position: 101
      prefix: --n-folds
  - id: no_distances
    type:
      - 'null'
      - boolean
    doc: Allow run without a distance matrix
    inputBinding:
      position: 101
      prefix: --no-distances
  - id: output_patterns
    type:
      - 'null'
      - File
    doc: File to print patterns to, useful for finding pvalue threshold (not 
      used with --wg)
    inputBinding:
      position: 101
      prefix: --output-patterns
  - id: phenotype_column
    type:
      - 'null'
      - string
    doc: Phenotype file column to use
    inputBinding:
      position: 101
      prefix: --phenotype-column
  - id: phenotypes
    type: File
    doc: Phenotypes file (whitespace separated)
    inputBinding:
      position: 101
      prefix: --phenotypes
  - id: pres
    type:
      - 'null'
      - File
    doc: Presence/absence .Rtab matrix as produced by roary and piggy
    inputBinding:
      position: 101
      prefix: --pres
  - id: print_filtered
    type:
      - 'null'
      - boolean
    doc: 'Print filtered variants (i.e. fitting errors) (does not apply if --wg is
      used) [Default: hide them]'
    inputBinding:
      position: 101
      prefix: --print-filtered
  - id: print_samples
    type:
      - 'null'
      - boolean
    doc: 'Print sample lists [Default: hide samples]'
    inputBinding:
      position: 101
      prefix: --print-samples
  - id: save_lmm
    type:
      - 'null'
      - string
    doc: Prefix for saving LMM cache
    inputBinding:
      position: 101
      prefix: --save-lmm
  - id: save_m
    type:
      - 'null'
      - string
    doc: Prefix for saving matrix decomposition
    inputBinding:
      position: 101
      prefix: --save-m
  - id: save_model
    type:
      - 'null'
      - string
    doc: Prefix for saving model
    inputBinding:
      position: 101
      prefix: --save-model
  - id: save_predictions
    type:
      - 'null'
      - File
    doc: File to save predictions to in TSV format
    inputBinding:
      position: 101
      prefix: --save-predictions
  - id: save_vars
    type:
      - 'null'
      - string
    doc: Prefix for saving variants
    inputBinding:
      position: 101
      prefix: --save-vars
  - id: sequence_reweighting
    type:
      - 'null'
      - boolean
    doc: Use --lineage-clusters to downweight sequences.
    inputBinding:
      position: 101
      prefix: --sequence-reweighting
  - id: similarity
    type:
      - 'null'
      - File
    doc: Strains similarity square matrix (for --lmm)
    inputBinding:
      position: 101
      prefix: --similarity
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: 'Uncompressed kmers file [Default: gzipped]'
    inputBinding:
      position: 101
      prefix: --uncompressed
  - id: use_covariates
    type:
      - 'null'
      - type: array
        items: string
    doc: Covariates to use. Format is "2 3q 4" (q for quantitative)
    inputBinding:
      position: 101
      prefix: --use-covariates
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF file. Will filter any non 'PASS' sites
    inputBinding:
      position: 101
      prefix: --vcf
  - id: wg
    type:
      - 'null'
      - string
    doc: Use a whole genome model for association and prediction. Population 
      structure correction is implicit.
    inputBinding:
      position: 101
      prefix: --wg
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
stdout: pyseer.out
