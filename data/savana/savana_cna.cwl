cwlVersion: v1.2
class: CommandLineTool
baseCommand: savana cna
label: savana_cna
doc: "Copy Number Aberration analysis tool\n\nTool homepage: https://github.com/cortes-ciriano-lab/savana"
inputs:
  - id: ac_window
    type:
      - 'null'
      - int
    doc: Window size for allele counting to parallelise and use for purity 
      estimation (default = 1200000; this should be >=500000)
    default: 1200000
    inputBinding:
      position: 101
      prefix: --ac_window
  - id: allele_counts_het_snps
    type:
      - 'null'
      - File
    doc: Path to allele counts of heterozygous SNPs
    inputBinding:
      position: 101
      prefix: --allele_counts_het_snps
  - id: allele_mapq
    type:
      - 'null'
      - int
    doc: Mapping quality threshold for reads to be included in the allele 
      counting (default = 5)
    default: 5
    inputBinding:
      position: 101
      prefix: --allele_mapq
  - id: allele_min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads required per het SNP site for allele counting 
      (default = 10)
    default: 10
    inputBinding:
      position: 101
      prefix: --allele_min_reads
  - id: bases_threshold
    type:
      - 'null'
      - int
    doc: Percentage of known bases per bin required for read counting (default =
      75). Please specify percentage threshold as integer, e.g. "-bt 95"
    default: 75
    inputBinding:
      position: 101
      prefix: --bases_threshold
  - id: bl_threshold
    type:
      - 'null'
      - int
    doc: Percentage overlap between bin and blacklist threshold to tolerate for 
      read counting (default = 5). Please specify percentage threshold as 
      integer, e.g. "-t 5". Set "-t 0" if no overlap with blacklist is to be 
      tolerated
    default: 5
    inputBinding:
      position: 101
      prefix: --bl_threshold
  - id: blacklist
    type:
      - 'null'
      - File
    doc: Path to the blacklist file
    inputBinding:
      position: 101
      prefix: --blacklist
  - id: breakpoints
    type:
      - 'null'
      - File
    doc: Path to SAVANA VCF file to incorporate savana breakpoints into copy 
      number analysis
    inputBinding:
      position: 101
      prefix: --breakpoints
  - id: cellularity_buffer
    type:
      - 'null'
      - float
    doc: Cellularity buffer to define purity grid search space during copy 
      number fitting (default = 0.1).
    default: 0.1
    inputBinding:
      position: 101
      prefix: --cellularity_buffer
  - id: cellularity_step
    type:
      - 'null'
      - float
    doc: Cellularity step size for grid search space used during for copy number
      fitting.
    inputBinding:
      position: 101
      prefix: --cellularity_step
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: Chromosomes to analyse. To run on all chromosomes, leave unspecified 
      (default). To run on a subset of chromosomes only, specify the chromosome 
      numbers separated by spaces. For x and y chromosomes, use 23 and 24, 
      respectively. E.g. use "-c 1 4 23 24" to run chromosomes 1, 4, X and Y
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: cn_binsize
    type:
      - 'null'
      - int
    doc: Bin window size in kbp
    inputBinding:
      position: 101
      prefix: --cn_binsize
  - id: cna_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for CNA (default=max)
    inputBinding:
      position: 101
      prefix: --cna_threads
  - id: distance_filter_scale_factor
    type:
      - 'null'
      - float
    doc: Distance filter scale factor to only include solutions with distances <
      scale factor * min(distance).
    inputBinding:
      position: 101
      prefix: --distance_filter_scale_factor
  - id: distance_function
    type:
      - 'null'
      - string
    doc: Distance function to be used for copy number fitting.
    inputBinding:
      position: 101
      prefix: --distance_function
  - id: distance_precision
    type:
      - 'null'
      - int
    doc: Number of digits to round distance functions to
    inputBinding:
      position: 101
      prefix: --distance_precision
  - id: g1000_vcf
    type:
      - 'null'
      - string
    doc: Use 1000g biallelic vcf file for allele counting instead of SNP vcf 
      from matched normal. Specify which genome version to use.
    inputBinding:
      position: 101
      prefix: --g1000_vcf
  - id: main_cn_step_change
    type:
      - 'null'
      - float
    doc: Max main copy number step change across genome to be considered for a 
      given solution.
    inputBinding:
      position: 101
      prefix: --main_cn_step_change
  - id: max_cellularity
    type:
      - 'null'
      - float
    doc: Maximum cellularity to be considered for copy number fitting. If 
      hetSNPs allele counts are provided, this is estimated during copy number 
      fitting. Alternatively, a purity value can be provided if the purity of 
      the sample is already known.
    inputBinding:
      position: 101
      prefix: --max_cellularity
  - id: max_distance_from_whole_number
    type:
      - 'null'
      - float
    doc: Distance from whole number for fitted value to be considered 
      sufficiently close to nearest copy number integer.
    inputBinding:
      position: 101
      prefix: --max_distance_from_whole_number
  - id: max_ploidy
    type:
      - 'null'
      - float
    doc: Maximum ploidy to be considered for copy number fitting.
    inputBinding:
      position: 101
      prefix: --max_ploidy
  - id: max_proportion_zero
    type:
      - 'null'
      - float
    doc: Maximum proportion of fitted copy numbers to be tolerated in the zero 
      or negative copy number state.
    inputBinding:
      position: 101
      prefix: --max_proportion_zero
  - id: min_block_length
    type:
      - 'null'
      - int
    doc: Minimum length (bps) for a genomic block to be considered for purity 
      estimation.
    inputBinding:
      position: 101
      prefix: --min_block_length
  - id: min_block_size
    type:
      - 'null'
      - int
    doc: Minimum size (number of SNPs) for a genomic block to be considered for 
      purity estimation.
    inputBinding:
      position: 101
      prefix: --min_block_size
  - id: min_cellularity
    type:
      - 'null'
      - float
    doc: Minimum cellularity to be considered for copy number fitting. If 
      hetSNPs allele counts are provided, this is estimated during copy number 
      fitting. Alternatively, a purity value can be provided if the purity of 
      the sample is already known.
    inputBinding:
      position: 101
      prefix: --min_cellularity
  - id: min_ploidy
    type:
      - 'null'
      - float
    doc: Minimum ploidy to be considered for copy number fitting.
    inputBinding:
      position: 101
      prefix: --min_ploidy
  - id: min_proportion_close_to_whole_number
    type:
      - 'null'
      - float
    doc: Minimum proportion of fitted copy numbers sufficiently close to whole 
      number to be tolerated for a given fit.
    inputBinding:
      position: 101
      prefix: --min_proportion_close_to_whole_number
  - id: min_segment_size
    type:
      - 'null'
      - int
    doc: Minimum size for a segement to be considered a segment (default = 5).
    default: 5
    inputBinding:
      position: 101
      prefix: --min_segment_size
  - id: no_basesfilter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --no_basesfilter
  - id: no_blacklist
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --no_blacklist
  - id: normal
    type:
      - 'null'
      - File
    doc: Normal BAM file (must have index)
    inputBinding:
      position: 101
      prefix: --normal
  - id: outdir
    type: Directory
    doc: Output directory (can exist but must be empty)
    inputBinding:
      position: 101
      prefix: --outdir
  - id: overrule_cellularity
    type:
      - 'null'
      - float
    doc: Set to sample`s purity if known. This value will overrule the 
      cellularity estimated using hetSNP allele counts (not used by default).
    inputBinding:
      position: 101
      prefix: --overrule_cellularity
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Use this flag to write to output directory even if files are present
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: p_seg
    type:
      - 'null'
      - float
    doc: p-value used to test segmentation statistic for a given interval during
      CBS using (shuffles) number of permutations (default = 0.05).
    default: 0.05
    inputBinding:
      position: 101
      prefix: --p_seg
  - id: p_val
    type:
      - 'null'
      - float
    doc: p-value used to test validity of candidate segments from CBS using 
      (shuffles) number of permutations (default = 0.01).
    default: 0.01
    inputBinding:
      position: 101
      prefix: --p_val
  - id: ploidy_step
    type:
      - 'null'
      - float
    doc: Ploidy step size for grid search space used during for copy number 
      fitting.
    inputBinding:
      position: 101
      prefix: --ploidy_step
  - id: quantile
    type:
      - 'null'
      - float
    doc: Quantile of changepoint (absolute median differences across all 
      segments) used to estimate threshold for segment merging (default = 0.2; 
      set to 0 to avoid segment merging).
    default: 0.2
    inputBinding:
      position: 101
      prefix: --quantile
  - id: readcount_mapq
    type:
      - 'null'
      - int
    doc: Mapping quality threshold for reads to be included in the read counting
      (default = 5)
    default: 5
    inputBinding:
      position: 101
      prefix: --readcount_mapq
  - id: ref
    type: string
    doc: Full path to reference genome
    inputBinding:
      position: 101
      prefix: --ref
  - id: sample
    type:
      - 'null'
      - string
    doc: Name to prepend to output files (default=tumour BAM filename without 
      extension)
    inputBinding:
      position: 101
      prefix: --sample
  - id: shuffles
    type:
      - 'null'
      - int
    doc: Number of permutations (shuffles) to be performed during CBS (default =
      1000).
    default: 1000
    inputBinding:
      position: 101
      prefix: --shuffles
  - id: smoothing_level
    type:
      - 'null'
      - int
    doc: Size of neighbourhood for smoothing.
    inputBinding:
      position: 101
      prefix: --smoothing_level
  - id: snp_vcf
    type:
      - 'null'
      - File
    doc: Path to matched normal SNP vcf file to extract heterozygous SNPs for 
      allele counting.
    inputBinding:
      position: 101
      prefix: --snp_vcf
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Temp directory for allele counting temp files (defaults to outdir)
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: trim
    type:
      - 'null'
      - float
    doc: Trimming percentage to be used.
    inputBinding:
      position: 101
      prefix: --trim
  - id: tumour
    type: File
    doc: Tumour BAM file (must have index)
    inputBinding:
      position: 101
      prefix: --tumour
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
stdout: savana_cna.out
