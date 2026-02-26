cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-eagle
label: bio-eagle
doc: "Eagle v2.4.1\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: allow_ref_alt_swap
    type:
      - 'null'
      - boolean
    doc: allow swapping of REF/ALT in target vs. ref VCF
    inputBinding:
      position: 101
      prefix: --allowRefAltSwap
  - id: bed
    type:
      - 'null'
      - File
    doc: PLINK .bed file
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
  - id: bim
    type:
      - 'null'
      - File
    doc: PLINK .bim file
    inputBinding:
      position: 101
      prefix: --bim
  - id: bp_end
    type:
      - 'null'
      - int
    doc: maximum base pair position to analyze
    default: 1000000000
    inputBinding:
      position: 101
      prefix: --bpEnd
  - id: bp_flanking
    type:
      - 'null'
      - int
    doc: (ref-mode only) flanking region to use during phasing but discard in 
      output
    default: 0
    inputBinding:
      position: 101
      prefix: --bpFlanking
  - id: bp_start
    type:
      - 'null'
      - int
    doc: minimum base pair position to analyze
    default: 0
    inputBinding:
      position: 101
      prefix: --bpStart
  - id: chrom
    type:
      - 'null'
      - string
    doc: chromosome to analyze (if input has many)
    default: '0'
    inputBinding:
      position: 101
      prefix: --chrom
  - id: exclude
    type:
      - 'null'
      - type: array
        items: File
    doc: file(s) listing SNPs to ignore (no header; SNP ID must be first column)
    inputBinding:
      position: 101
      prefix: --exclude
  - id: expect_ibdc_m
    type:
      - 'null'
      - float
    doc: expected length of haplotype copying (cM)
    default: 2.0
    inputBinding:
      position: 101
      prefix: --expectIBDcM
  - id: fam
    type:
      - 'null'
      - File
    doc: 'PLINK .fam file (note: file names ending in .gz are auto-decompressed)'
    inputBinding:
      position: 101
      prefix: --fam
  - id: genetic_map_file
    type:
      - 'null'
      - File
    doc: 'HapMap genetic map provided with download: tables/genetic_map_hg##.txt.gz'
    inputBinding:
      position: 101
      prefix: --geneticMapFile
  - id: geno_err_prob
    type:
      - 'null'
      - float
    doc: estimated genotype error probability
    default: 0.003
    inputBinding:
      position: 101
      prefix: --genoErrProb
  - id: hist_factor
    type:
      - 'null'
      - int
    doc: history length multiplier (0=auto)
    default: 0
    inputBinding:
      position: 101
      prefix: --histFactor
  - id: keep_missing_ploidy_x
    type:
      - 'null'
      - boolean
    doc: assume missing genotypes have correct ploidy (.=haploid, ./.=diploid)
    inputBinding:
      position: 101
      prefix: --keepMissingPloidyX
  - id: kpbwt
    type:
      - 'null'
      - int
    doc: number of conditioning haplotypes
    default: 10000
    inputBinding:
      position: 101
      prefix: --Kpbwt
  - id: max_missing_per_indiv
    type:
      - 'null'
      - float
    doc: 'QC filter: max missing rate per person'
    default: 0.1
    inputBinding:
      position: 101
      prefix: --maxMissingPerIndiv
  - id: max_missing_per_snp
    type:
      - 'null'
      - float
    doc: 'QC filter: max missing rate per SNP'
    default: 0.1
    inputBinding:
      position: 101
      prefix: --maxMissingPerSnp
  - id: no_imp_missing
    type:
      - 'null'
      - boolean
    doc: disable imputation of missing target genotypes (. or ./.)
    inputBinding:
      position: 101
      prefix: --noImpMissing
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of computational threads
    default: 1
    inputBinding:
      position: 101
      prefix: --numThreads
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: prefix for output files
    inputBinding:
      position: 101
      prefix: --outPrefix
  - id: output_unphased
    type:
      - 'null'
      - boolean
    doc: output unphased sites (target-only, multi-allelic, etc.)
    inputBinding:
      position: 101
      prefix: --outputUnphased
  - id: pbwt_iters
    type:
      - 'null'
      - int
    doc: number of PBWT phasing iterations (0=auto)
    default: 0
    inputBinding:
      position: 101
      prefix: --pbwtIters
  - id: pbwt_only
    type:
      - 'null'
      - boolean
    doc: in non-ref mode, use only PBWT iters (automatic for sequence data)
    inputBinding:
      position: 101
      prefix: --pbwtOnly
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
  - id: v1
    type:
      - 'null'
      - boolean
    doc: use Eagle1 phasing algorithm (instead of default Eagle2 algorithm)
    inputBinding:
      position: 101
      prefix: --v1
  - id: vcf
    type:
      - 'null'
      - File
    doc: '[compressed] VCF/BCF file containing input genotypes'
    inputBinding:
      position: 101
      prefix: --vcf
  - id: vcf_exclude
    type:
      - 'null'
      - File
    doc: tabix-indexed [compressed] VCF/BCF file containing variants to exclude 
      from phasing
    inputBinding:
      position: 101
      prefix: --vcfExclude
  - id: vcf_out_format
    type:
      - 'null'
      - string
    doc: 'b|u|z|v: compressed BCF (b), uncomp BCF (u), compressed VCF (z), uncomp
      VCF (v)'
    default: .
    inputBinding:
      position: 101
      prefix: --vcfOutFormat
  - id: vcf_ref
    type:
      - 'null'
      - File
    doc: tabix-indexed [compressed] VCF/BCF file for reference haplotypes
    inputBinding:
      position: 101
      prefix: --vcfRef
  - id: vcf_target
    type:
      - 'null'
      - File
    doc: tabix-indexed [compressed] VCF/BCF file for target genotypes
    inputBinding:
      position: 101
      prefix: --vcfTarget
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bio-eagle:v2.4.1-1-deb_cv1
stdout: bio-eagle.out
