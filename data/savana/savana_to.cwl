cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - savana
  - to
label: savana_to
doc: "Convert BAM files to SAVANA output format\n\nTool homepage: https://github.com/cortes-ciriano-lab/savana"
inputs:
  - id: ac_window
    type:
      - 'null'
      - int
    doc: Window size for allele counting to parallelise (default = 1200000; this
      should be >=500000)
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
    inputBinding:
      position: 101
      prefix: --allele_mapq
  - id: allele_min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads required per het SNP site for allele counting 
      (default = 10)
    inputBinding:
      position: 101
      prefix: --allele_min_reads
  - id: bases_threshold
    type:
      - 'null'
      - int
    doc: Percentage of known bases per bin required for read counting (default =
      75). Please specify percentage threshold as integer, e.g. "-bt 95"
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
  - id: buffer
    type:
      - 'null'
      - int
    doc: Buffer when clustering adjacent potential breakpoints, excepting 
      insertions
    inputBinding:
      position: 101
      prefix: --buffer
  - id: by_distance
    type:
      - 'null'
      - boolean
    doc: 'Comparison method: tie-break by min. distance (default)'
    inputBinding:
      position: 101
      prefix: --by_distance
  - id: by_support
    type:
      - 'null'
      - boolean
    doc: 'Comparison method: tie-break by read support'
    inputBinding:
      position: 101
      prefix: --by_support
  - id: cellularity_buffer
    type:
      - 'null'
      - float
    doc: Cellularity buffer to define purity grid search space during copy 
      number fitting (default = 0.1).
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
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Chunksize to use when splitting genome for parallel analysis - used to 
      optimise memory (default=1000000)
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: cn_binsize
    type:
      - 'null'
      - int
    doc: Bin window size in kbp
    inputBinding:
      position: 101
      prefix: --cn_binsize
  - id: cna_rescue
    type:
      - 'null'
      - File
    doc: Copy number abberation output file for this sample (used to rescue 
      variants)
    inputBinding:
      position: 101
      prefix: --cna_rescue
  - id: cna_rescue_distance
    type:
      - 'null'
      - int
    doc: Maximum distance from a copy number abberation for a variant to be 
      rescued
    inputBinding:
      position: 101
      prefix: --cna_rescue_distance
  - id: cna_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for CNA (default=max)
    inputBinding:
      position: 101
      prefix: --cna_threads
  - id: confidence
    type:
      - 'null'
      - float
    doc: Confidence level for mondrian conformal prediction - suggested range 
      (0.70-0.99) (not used by default)
    inputBinding:
      position: 101
      prefix: --confidence
  - id: contigs
    type:
      - 'null'
      - string
    doc: Contigs/chromosomes to consider. See example at 
      example/contigs.chr.hg38.txt (optional, default=All)
    inputBinding:
      position: 101
      prefix: --contigs
  - id: coverage_binsize
    type:
      - 'null'
      - int
    doc: Length used for coverage bins (default=5)
    inputBinding:
      position: 101
      prefix: --coverage_binsize
  - id: curate
    type:
      - 'null'
      - boolean
    doc: Attempt to reduce false labels for training (allow label to be used 
      twice)
    inputBinding:
      position: 101
      prefix: --curate
  - id: custom_model
    type:
      - 'null'
      - File
    doc: Pickle file of custom machine-learning model
    inputBinding:
      position: 101
      prefix: --custom_model
  - id: custom_params
    type:
      - 'null'
      - File
    doc: JSON file of custom filtering parameters
    inputBinding:
      position: 101
      prefix: --custom_params
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output extra debugging info and files
    inputBinding:
      position: 101
      prefix: --debug
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
  - id: end_buffer
    type:
      - 'null'
      - int
    doc: Buffer when clustering alternate edge of potential breakpoints, 
      excepting insertions
    inputBinding:
      position: 101
      prefix: --end_buffer
  - id: g1000_vcf
    type:
      - 'null'
      - string
    doc: Use 1000g biallelic vcf file for allele counting instead of SNP vcf 
      from matched normal. Specify which genome version to use.
    inputBinding:
      position: 101
      prefix: --g1000_vcf
  - id: insertion_buffer
    type:
      - 'null'
      - int
    doc: Buffer when clustering adjacent potential insertion breakpoints
    inputBinding:
      position: 101
      prefix: --insertion_buffer
  - id: inv_artefact_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between alignment start/end to be considered an 
      artefact when --keep_inv_artefact is not set
    inputBinding:
      position: 101
      prefix: --inv_artefact_distance
  - id: keep_inv_artefact
    type:
      - 'null'
      - boolean
    doc: Do not remove breakpoints with foldback-inversion artefact pattern
    inputBinding:
      position: 101
      prefix: --keep_inv_artefact
  - id: legacy
    type:
      - 'null'
      - boolean
    doc: Use legacy lenient/strict filtering
    inputBinding:
      position: 101
      prefix: --legacy
  - id: length
    type:
      - 'null'
      - int
    doc: Minimum length SV to consider
    inputBinding:
      position: 101
      prefix: --length
  - id: main_cn_step_change
    type:
      - 'null'
      - float
    doc: Max main copy number step change across genome to be considered for a 
      given solution.
    inputBinding:
      position: 101
      prefix: --main_cn_step_change
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ to consider a read mapped
    inputBinding:
      position: 101
      prefix: --mapq
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
  - id: min_af
    type:
      - 'null'
      - float
    doc: Minimum allele-fraction for a PASS variant (default=0.01)
    inputBinding:
      position: 101
      prefix: --min_af
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
  - id: min_reads_per_cluster
    type:
      - 'null'
      - int
    doc: In clustering step, discard clusters with fewer than n supporting reads
    inputBinding:
      position: 101
      prefix: --min_reads_per_cluster
  - id: min_segment_size
    type:
      - 'null'
      - int
    doc: Minimum size for a segement to be considered a segment (default = 5).
    inputBinding:
      position: 101
      prefix: --min_segment_size
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum supporting reads for a PASS variant (default=3)
    inputBinding:
      position: 101
      prefix: --min_support
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
  - id: ont
    type:
      - 'null'
      - boolean
    doc: Use the Oxford Nanopore (ONT) trained model to classify variants 
      (default)
    inputBinding:
      position: 101
      prefix: --ont
  - id: outdir
    type: Directory
    doc: Output directory (can exist but must be empty)
    inputBinding:
      position: 101
      prefix: --outdir
  - id: overlap_buffer
    type:
      - 'null'
      - int
    doc: Buffer for considering an overlap (default=100)
    inputBinding:
      position: 101
      prefix: --overlap_buffer
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
    inputBinding:
      position: 101
      prefix: --p_seg
  - id: p_val
    type:
      - 'null'
      - float
    doc: p-value used to test validity of candidate segments from CBS using 
      (shuffles) number of permutations (default = 0.01).
    inputBinding:
      position: 101
      prefix: --p_val
  - id: pb
    type:
      - 'null'
      - boolean
    doc: Use PacBio thresholds to classify variants
    inputBinding:
      position: 101
      prefix: --pb
  - id: ploidy_step
    type:
      - 'null'
      - float
    doc: Ploidy step size for grid search space used during for copy number 
      fitting.
    inputBinding:
      position: 101
      prefix: --ploidy_step
  - id: qual_filter
    type:
      - 'null'
      - string
    doc: Impose a quality filter on comparator variants (default=None)
    inputBinding:
      position: 101
      prefix: --qual_filter
  - id: quantile
    type:
      - 'null'
      - float
    doc: Quantile of changepoint (absolute median differences across all 
      segments) used to estimate threshold for segment merging (default = 0.2; 
      set to 0 to avoid segment merging).
    inputBinding:
      position: 101
      prefix: --quantile
  - id: readcount_mapq
    type:
      - 'null'
      - int
    doc: Mapping quality threshold for reads to be included in the read counting
      (default = 5)
    inputBinding:
      position: 101
      prefix: --readcount_mapq
  - id: ref
    type: File
    doc: Full path to reference genome
    inputBinding:
      position: 101
      prefix: --ref
  - id: ref_index
    type:
      - 'null'
      - File
    doc: Full path to reference genome fasta index (ref path + ".fai" by 
      default)
    inputBinding:
      position: 101
      prefix: --ref_index
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
    inputBinding:
      position: 101
      prefix: --shuffles
  - id: single_bnd
    type:
      - 'null'
      - boolean
    doc: Report single breakend variants in addition to standard types 
      (default=False)
    inputBinding:
      position: 101
      prefix: --single_bnd
  - id: single_bnd_max_mapq
    type:
      - 'null'
      - int
    doc: Convert supplementary alignments below this threshold to single 
      breakend (default=5, must not exceed --mapq argument)
    inputBinding:
      position: 101
      prefix: --single_bnd_max_mapq
  - id: single_bnd_min_length
    type:
      - 'null'
      - int
    doc: Minimum length of single breakend to consider (default=100)
    inputBinding:
      position: 101
      prefix: --single_bnd_min_length
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
    doc: Path to SNP vcf file to extract heterozygous SNPs for allele counting.
    inputBinding:
      position: 101
      prefix: --snp_vcf
  - id: somatic
    type:
      - 'null'
      - File
    doc: Somatic VCF file to evaluate against
    inputBinding:
      position: 101
      prefix: --somatic
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default=max)
    inputBinding:
      position: 101
      prefix: --threads
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
  - id: somatic_output
    type:
      - 'null'
      - File
    doc: Output VCF with only PASS somatic variants
    outputBinding:
      glob: $(inputs.somatic_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
