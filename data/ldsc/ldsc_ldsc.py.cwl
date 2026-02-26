cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldsc.py
label: ldsc_ldsc.py
doc: "LD Score regression\n\nTool homepage: https://github.com/bulik/ldsc/"
inputs:
  - id: M
    type:
      - 'null'
      - int
    doc: "# of SNPs (if you don't want to use the .l2.M files that came with your
      .l2.ldscore.gz files)"
    inputBinding:
      position: 101
      prefix: --M
  - id: annot
    type:
      - 'null'
      - string
    doc: Filename prefix for annotation file for partitioned LD Score 
      estimation. LDSC will automatically append .annot or .annot.gz to the 
      filename prefix. See docs/file_formats_ld for a definition of the .annot 
      format.
    inputBinding:
      position: 101
      prefix: --annot
  - id: bfile
    type:
      - 'null'
      - string
    doc: Prefix for Plink .bed/.bim/.fam file
    inputBinding:
      position: 101
      prefix: --bfile
  - id: chisq_max
    type:
      - 'null'
      - float
    doc: Max chi^2.
    inputBinding:
      position: 101
      prefix: --chisq-max
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Chunk size for LD Score calculation. Use the default.
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: cts_bin
    type:
      - 'null'
      - type: array
        items: string
    doc: This flag tells LDSC to compute partitioned LD Scores, where the 
      partition is defined by cutting one or several continuous variable[s] into
      bins. The argument to this flag should be the name of a single file or a 
      comma-separated list of files. The file format is two columns, with SNP 
      IDs in the first column and the continuous variable in the second column.
    inputBinding:
      position: 101
      prefix: --cts-bin
  - id: cts_breaks
    type:
      - 'null'
      - string
    doc: Use this flag to specify names for the continuous variables cut into 
      bins with --cts-bin. For each continuous variable, specify breaks as a 
      comma-separated list of breakpoints, and separate the breakpoints for each
      variable with an x. For example, if binning on MAF and distance to gene 
      (in kb), you might set --cts-breaks 0.1,0.25,0.4x10,100,1000
    inputBinding:
      position: 101
      prefix: --cts-breaks
  - id: cts_names
    type:
      - 'null'
      - string
    doc: Use this flag to specify names for the continuous variables cut into 
      bins with --cts-bin. The argument to this flag should be a comma-separated
      list of names. For example, if binning on DAF and distance to gene, you 
      might set --cts-bin DAF,DIST_TO_GENE
    inputBinding:
      position: 101
      prefix: --cts-names
  - id: extract
    type:
      - 'null'
      - File
    doc: File with SNPs to include in LD Score estimation. The file should 
      contain one SNP ID per row.
    inputBinding:
      position: 101
      prefix: --extract
  - id: frqfile
    type:
      - 'null'
      - File
    doc: For use with --overlap-annot. Provides allele frequencies to prune to 
      common snps if --not-M-5-50 is not set.
    inputBinding:
      position: 101
      prefix: --frqfile
  - id: frqfile_chr
    type:
      - 'null'
      - string
    doc: Prefix for --frqfile files split over chromosome.
    inputBinding:
      position: 101
      prefix: --frqfile-chr
  - id: h2
    type:
      - 'null'
      - File
    doc: Filename for a .sumstats[.gz] file for one-phenotype LD Score 
      regression. --h2 requires at minimum also setting the --ref-ld and --w-ld 
      flags.
    inputBinding:
      position: 101
      prefix: --h2
  - id: h2_cts
    type:
      - 'null'
      - File
    doc: Filename for a .sumstats[.gz] file for cell-type-specific analysis. 
      --h2-cts requires the --ref-ld-chr, --w-ld, and --ref-ld-chr-cts flags.
    inputBinding:
      position: 101
      prefix: --h2-cts
  - id: intercept_gencov
    type:
      - 'null'
      - type: array
        items: float
    doc: Intercepts for constrained-intercept cross-trait LD Score regression. 
      Must have same length as --rg. The first entry is ignored.
    inputBinding:
      position: 101
      prefix: --intercept-gencov
  - id: intercept_h2
    type:
      - 'null'
      - float
    doc: Intercepts for constrained-intercept single-trait LD Score regression.
    inputBinding:
      position: 101
      prefix: --intercept-h2
  - id: invert_anyway
    type:
      - 'null'
      - boolean
    doc: Force LDSC to attempt to invert ill-conditioned matrices.
    inputBinding:
      position: 101
      prefix: --invert-anyway
  - id: keep
    type:
      - 'null'
      - File
    doc: File with individuals to include in LD Score estimation. The file 
      should contain one individual ID per row.
    inputBinding:
      position: 101
      prefix: --keep
  - id: l2
    type:
      - 'null'
      - boolean
    doc: Estimate l2. Compatible with both jackknife and non-jackknife.
    inputBinding:
      position: 101
      prefix: --l2
  - id: ld_wind_cm
    type:
      - 'null'
      - float
    doc: Specify the window size to be used for estimating LD Scores in units of
      centiMorgans (cM). You can only specify one --ld-wind-* option.
    inputBinding:
      position: 101
      prefix: --ld-wind-cm
  - id: ld_wind_kb
    type:
      - 'null'
      - int
    doc: Specify the window size to be used for estimating LD Scores in units of
      kilobase-pairs (kb). You can only specify one --ld-wind-* option.
    inputBinding:
      position: 101
      prefix: --ld-wind-kb
  - id: ld_wind_snps
    type:
      - 'null'
      - int
    doc: 'Specify the window size to be used for estimating LD Scores in units of
      # of SNPs. You can only specify one --ld-wind-* option.'
    inputBinding:
      position: 101
      prefix: --ld-wind-snps
  - id: maf
    type:
      - 'null'
      - float
    doc: Minor allele frequency lower bound. Default is MAF > 0.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --maf
  - id: n_blocks
    type:
      - 'null'
      - int
    doc: Number of block jackknife blocks.
    inputBinding:
      position: 101
      prefix: --n-blocks
  - id: no_check_alleles
    type:
      - 'null'
      - boolean
    doc: For rg estimation, skip checking whether the alleles match. This check 
      is redundant for pairs of chisq files generated using munge_sumstats.py 
      and the same argument to the --merge-alleles flag.
    inputBinding:
      position: 101
      prefix: --no-check-alleles
  - id: no_intercept
    type:
      - 'null'
      - boolean
    doc: If used with --h2, this constrains the LD Score regression intercept to
      equal 1. If used with --rg, this constrains the LD Score regression 
      intercepts for the h2 estimates to be one and the intercept for the 
      genetic covariance estimate to be zero.
    inputBinding:
      position: 101
      prefix: --no-intercept
  - id: no_print_annot
    type:
      - 'null'
      - boolean
    doc: By defualt, seting --cts-bin or --cts-bin-add causes LDSC to print the 
      resulting annot matrix. Setting --no-print-annot tells LDSC not to print 
      the annot matrix.
    inputBinding:
      position: 101
      prefix: --no-print-annot
  - id: not_M_5_50
    type:
      - 'null'
      - boolean
    doc: This flag tells LDSC to use the .l2.M file instead of the .l2.M_5_50 
      file.
    inputBinding:
      position: 101
      prefix: --not-M-5-50
  - id: out
    type:
      - 'null'
      - string
    doc: Output filename prefix. If --out is not set, LDSC will use ldsc as the 
      defualt output filename prefix.
    inputBinding:
      position: 101
      prefix: --out
  - id: overlap_annot
    type:
      - 'null'
      - boolean
    doc: This flag informs LDSC that the partitioned LD Scores were generates 
      using an annot matrix with overlapping categories (i.e., not all row sums 
      equal 1), and prevents LDSC from displaying output that is meaningless 
      with overlapping categories.
    inputBinding:
      position: 101
      prefix: --overlap-annot
  - id: per_allele
    type:
      - 'null'
      - boolean
    doc: Setting this flag causes LDSC to compute per-allele LD Scores, i.e., 
      \ell_j := \sum_k p_k(1-p_k)r^2_{jk}, where p_k denotes the MAF of SNP j.
    inputBinding:
      position: 101
      prefix: --per-allele
  - id: pickle
    type:
      - 'null'
      - boolean
    doc: Store .l2.ldscore files as pickles instead of gzipped tab-delimited 
      text.
    inputBinding:
      position: 101
      prefix: --pickle
  - id: pop_prev
    type:
      - 'null'
      - float
    doc: Population prevalence of binary phenotype (for conversion to liability 
      scale).
    inputBinding:
      position: 101
      prefix: --pop-prev
  - id: pq_exp
    type:
      - 'null'
      - float
    doc: Setting this flag causes LDSC to compute LD Scores with the given scale
      factor, i.e., \ell_j := \sum_k (p_k(1-p_k))^a r^2_{jk}, where p_k denotes 
      the MAF of SNP j and a is the argument to --pq-exp.
    inputBinding:
      position: 101
      prefix: --pq-exp
  - id: print_all_cts
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --print-all-cts
  - id: print_coefficients
    type:
      - 'null'
      - boolean
    doc: when categories are overlapping, print coefficients as well as 
      heritabilities.
    inputBinding:
      position: 101
      prefix: --print-coefficients
  - id: print_cov
    type:
      - 'null'
      - boolean
    doc: For use with --h2/--rg. This flag tells LDSC to print the covaraince 
      matrix of the estimates.
    inputBinding:
      position: 101
      prefix: --print-cov
  - id: print_delete_vals
    type:
      - 'null'
      - boolean
    doc: If this flag is set, LDSC will print the block jackknife delete-values 
      (i.e., the regression coefficeints estimated from the data with a block 
      removed). The delete-values are formatted as a matrix with (# of jackknife
      blocks) rows and (# of LD Scores) columns.
    inputBinding:
      position: 101
      prefix: --print-delete-vals
  - id: print_snps
    type:
      - 'null'
      - File
    doc: This flag tells LDSC to only print LD Scores for the SNPs listed (one 
      ID per row) in PRINT_SNPS. The sum r^2 will still include SNPs not in 
      PRINT_SNPS. This is useful for reducing the number of LD Scores that have 
      to be read into memory when estimating h2 or rg.
    inputBinding:
      position: 101
      prefix: --print-snps
  - id: ref_ld
    type:
      - 'null'
      - string
    doc: Use --ref-ld to tell LDSC which LD Scores to use as the predictors in 
      the LD Score regression. LDSC will automatically append 
      .l2.ldscore/.l2.ldscore.gz to the filename prefix.
    inputBinding:
      position: 101
      prefix: --ref-ld
  - id: ref_ld_chr
    type:
      - 'null'
      - string
    doc: 'Same as --ref-ld, but will automatically concatenate .l2.ldscore files split
      across 22 chromosomes. LDSC will automatically append .l2.ldscore/.l2.ldscore.gz
      to the filename prefix. If the filename prefix contains the symbol @, LDSC will
      replace the @ symbol with chromosome numbers. Otherwise, LDSC will append chromosome
      numbers to the end of the filename prefix.Example 1: --ref-ld-chr ld/ will read
      ld/1.l2.ldscore.gz ... ld/22.l2.ldscore.gzExample 2: --ref-ld-chr ld/@_kg will
      read ld/1_kg.l2.ldscore.gz ... ld/22_kg.l2.ldscore.gz'
    inputBinding:
      position: 101
      prefix: --ref-ld-chr
  - id: ref_ld_chr_cts
    type:
      - 'null'
      - File
    doc: Name of a file that has a list of file name prefixes for 
      cell-type-specific analysis.
    inputBinding:
      position: 101
      prefix: --ref-ld-chr-cts
  - id: return_silly_things
    type:
      - 'null'
      - boolean
    doc: Force ldsc to return silly genetic correlation estimates.
    inputBinding:
      position: 101
      prefix: --return-silly-things
  - id: rg
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of prefixes of .chisq filed for genetic 
      correlation estimation.
    inputBinding:
      position: 101
      prefix: --rg
  - id: samp_prev
    type:
      - 'null'
      - float
    doc: Sample prevalence of binary phenotype (for conversion to liability 
      scale).
    inputBinding:
      position: 101
      prefix: --samp-prev
  - id: thin_annot
    type:
      - 'null'
      - boolean
    doc: This flag says your annot files have only annotations, with no SNP, CM,
      CHR, BP columns.
    inputBinding:
      position: 101
      prefix: --thin-annot
  - id: two_step
    type:
      - 'null'
      - int
    doc: Test statistic bound for use with the two-step estimator. Not 
      compatible with --no-intercept and --constrain-intercept.
    inputBinding:
      position: 101
      prefix: --two-step
  - id: w_ld
    type:
      - 'null'
      - string
    doc: Filename prefix for file with LD Scores with sum r^2 taken over SNPs 
      included in the regression. LDSC will automatically append 
      .l2.ldscore/.l2.ldscore.gz.
    inputBinding:
      position: 101
      prefix: --w-ld
  - id: w_ld_chr
    type:
      - 'null'
      - string
    doc: Same as --w-ld, but will read files split into 22 chromosomes in the 
      same manner as --ref-ld-chr.
    inputBinding:
      position: 101
      prefix: --w-ld-chr
  - id: yes_really
    type:
      - 'null'
      - boolean
    doc: Yes, I really want to compute whole-chromosome LD Score.
    inputBinding:
      position: 101
      prefix: --yes-really
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldsc:1.0.1--py_0
stdout: ldsc_ldsc.py.out
