cwlVersion: v1.2
class: CommandLineTool
baseCommand: xyalign
label: xyalign_analyze_bam
doc: "XYalign\n\nTool homepage: https://github.com/WilsonSayresLab/XYalign"
inputs:
  - id: analyze_bam
    type:
      - 'null'
      - boolean
    doc: This flag will limit XYalign to only analyzing the bam file for depth, 
      mapq, and (optionally) read balance and outputting plots.
    inputBinding:
      position: 101
      prefix: --ANALYZE_BAM
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Full path to input bam files. If more than one provided, only the first
      will be used for modules other than --CHROM_STATS
    inputBinding:
      position: 101
      prefix: --bam
  - id: bedtools_path
    type:
      - 'null'
      - string
    doc: Path to bedtools. Default is 'bedtools'
    inputBinding:
      position: 101
      prefix: --bedtools_path
  - id: bwa_flags
    type:
      - 'null'
      - string
    doc: "Provide a string (in quotes, with spaces between arguments) for additional
      flags desired for BWA mapping (other than -R and -t). Example: '-M -T 20 -v
      4'. Note that those are spaces between arguments."
    inputBinding:
      position: 101
      prefix: --bwa_flags
  - id: bwa_index
    type:
      - 'null'
      - boolean
    doc: If True, index with BWA during PREPARE_REFERENCE. Only relevantwhen 
      running the PREPARE_REFERENCE module by itself. Default is False.
    inputBinding:
      position: 101
      prefix: --bwa_index
  - id: bwa_path
    type:
      - 'null'
      - string
    doc: Path to bwa. Default is 'bwa'
    inputBinding:
      position: 101
      prefix: --bwa_path
  - id: characterize_sex_chroms
    type:
      - 'null'
      - boolean
    doc: This flag will limit XYalign to the steps required to characterize sex 
      chromosome content (i.e., analyzing the bam for depth, mapq, and read 
      balance and running statistical tests to help infer ploidy)
    inputBinding:
      position: 101
      prefix: --CHARACTERIZE_SEX_CHROMS
  - id: chrom_stats
    type:
      - 'null'
      - boolean
    doc: This flag will limit XYalign to only analyzing provided bam files for 
      depth and mapq across entire chromosomes.
    inputBinding:
      position: 101
      prefix: --CHROM_STATS
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: Chromosomes to analyze (names must match reference exactly). For 
      humans, we recommend at least chr19, chrX, chrY. Generally, we suggest 
      including the sex chromosomes and at least one autosome. To analyze all 
      chromosomes use '--chromosomes ALL' or '--chromosomes all'.
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: coordinate_scale
    type:
      - 'null'
      - float
    doc: For genome-wide scatter plots, divide all coordinates by this 
      value.Default is 1000000, which will plot everything in megabases.
    inputBinding:
      position: 101
      prefix: --coordinate_scale
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cores/threads to use. Default is 1
    inputBinding:
      position: 101
      prefix: --cpus
  - id: cram_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Full path to input cram files. If more than one provided, only the 
      first will be used for modules other than --CHROM_STATS. Not currently 
      supported.
    inputBinding:
      position: 101
      prefix: --cram
  - id: exact_depth
    type:
      - 'null'
      - boolean
    doc: Calculate exact depth within windows, else use much faster 
      approximation. *Currently exact is not implemented*. Default is False.
    inputBinding:
      position: 101
      prefix: --exact_depth
  - id: fastq_compression
    type:
      - 'null'
      - int
    doc: Compression level for fastqs output from repair.sh. Between (inclusive)
      0 and 9. Default is 3. 1 through 9 indicate compression levels. If 0, 
      fastqs will be uncompressed.
    inputBinding:
      position: 101
      prefix: --fastq_compression
  - id: homogenize_read_balance
    type:
      - 'null'
      - boolean
    doc: If True, read balance values will be transformed by subtracting each 
      value from 1. For example, 0.25 and 0.75 would be treated equivalently. 
      Default is False.
    inputBinding:
      position: 101
      prefix: --homogenize_read_balance
  - id: ignore_duplicates
    type:
      - 'null'
      - boolean
    doc: Ignore duplicate reads in bam analyses. Default is to include 
      duplicates.
    inputBinding:
      position: 101
      prefix: --ignore_duplicates
  - id: include_fixed
    type:
      - 'null'
      - boolean
    doc: Default is False, which removes read balances less than or equal to 
      0.05 and equal to 1.0 for histogram plotting. True will include all 
      values. Extreme values removed by default because they often swamp out the
      signal of the rest of the distribution.
    inputBinding:
      position: 101
      prefix: --include_fixed
  - id: logfile
    type:
      - 'null'
      - File
    doc: Name of logfile. Will overwrite if exists. Default is 
      sample_xyalign.log
    inputBinding:
      position: 101
      prefix: --logfile
  - id: mapq_cutoff
    type:
      - 'null'
      - int
    doc: Minimum mean mapq threshold for a window to be considered high quality.
      Default is 20.
    inputBinding:
      position: 101
      prefix: --mapq_cutoff
  - id: marker_size
    type:
      - 'null'
      - int
    doc: Marker size for genome-wide plots in matplotlib. Default is 10.
    inputBinding:
      position: 101
      prefix: --marker_size
  - id: marker_transparency
    type:
      - 'null'
      - float
    doc: Transparency of markers in genome-wide plots. Alpha in matplotlib. 
      Default is 0.5
    inputBinding:
      position: 101
      prefix: --marker_transparency
  - id: max_depth_filter
    type:
      - 'null'
      - float
    doc: Maximum depth threshold for a window to be considered high quality. 
      Calculated as mean depth * max_depth_filter. So, a max_depth_filter of 4 
      would require depths to be less than or equal to 40 if the mean depth was 
      10. Default is 10000.0 to consider all windows.
    inputBinding:
      position: 101
      prefix: --max_depth_filter
  - id: min_depth_filter
    type:
      - 'null'
      - float
    doc: Minimum depth threshold for a window to be considered high quality. 
      Calculated as mean depth * min_depth_filter. So, a min_depth_filter of 0.2
      would require at least a minimum depth of 2 if the mean depth was 10. 
      Default is 0.0 to consider all windows.
    inputBinding:
      position: 101
      prefix: --min_depth_filter
  - id: min_variant_count
    type:
      - 'null'
      - int
    doc: Minimum number of variants in a window for the read balance of that 
      window to be plotted. Note that this does not affect plotting of variant 
      counts. Default is 1, though we note that many window averages will be 
      meaningless at this setting.
    inputBinding:
      position: 101
      prefix: --min_variant_count
  - id: no_bam_analysis
    type:
      - 'null'
      - boolean
    doc: Include flag to prevent depth/mapq analysis of bam file. Used to 
      isolate platypus_calling.
    inputBinding:
      position: 101
      prefix: --no_bam_analysis
  - id: no_bootstrap
    type:
      - 'null'
      - boolean
    doc: Include flag to turn off bootstrap analyses. Requires either 
      --y_present, --y_absent, or --sex_chrom_calling_threshold if running full 
      pipeline.
    inputBinding:
      position: 101
      prefix: --no_bootstrap
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Include flag to preserve temporary files.
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: no_ks_test
    type:
      - 'null'
      - boolean
    doc: Include flag to turn off KS Two Sample tests.
    inputBinding:
      position: 101
      prefix: --no_ks_test
  - id: no_perm_test
    type:
      - 'null'
      - boolean
    doc: Include flag to turn off permutation tests.
    inputBinding:
      position: 101
      prefix: --no_perm_test
  - id: no_variant_plots
    type:
      - 'null'
      - boolean
    doc: Include flag to prevent plotting read balance from VCF files.
    inputBinding:
      position: 101
      prefix: --no_variant_plots
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: Number of bootstrap replicates to use when bootstrapping mean depth 
      ratios among chromosomes. Default is 10000
    inputBinding:
      position: 101
      prefix: --num_bootstraps
  - id: num_permutations
    type:
      - 'null'
      - int
    doc: Number of permutations to use for permutation analyses. Default is 
      10000
    inputBinding:
      position: 101
      prefix: --num_permutations
  - id: platypus_calling
    type:
      - 'null'
      - string
    doc: 'Platypus calling withing the pipeline (before processing, after processing,
      both, or neither). Options: both, none, before, after.'
    inputBinding:
      position: 101
      prefix: --platypus_calling
  - id: platypus_logfile
    type:
      - 'null'
      - string
    doc: Prefix to use for Platypus log files. Will default to the sample_id 
      argument provided
    inputBinding:
      position: 101
      prefix: --platypus_logfile
  - id: platypus_path
    type:
      - 'null'
      - string
    doc: Path to platypus. Default is 'platypus'. If platypus is not directly 
      callable (e.g., '/path/to/platypus' or '/path/to/Playpus.py'), then 
      provide path to python as well (e.g., '/path/to/python 
      /path/to/platypus'). In addition, be sure provided python is version 2. 
      See the documentation for more information about setting up an anaconda 
      environment.
    inputBinding:
      position: 101
      prefix: --platypus_path
  - id: prepare_reference
    type:
      - 'null'
      - boolean
    doc: This flag will limit XYalign to only preparing reference fastas for 
      individuals with and without Y chromosomes. These fastas can then be 
      passed with each sample to save subsequent processing time.
    inputBinding:
      position: 101
      prefix: --PREPARE_REFERENCE
  - id: read_group_id
    type:
      - 'null'
      - string
    doc: If read groups are present in a bam file, they are used by default in 
      remapping steps. However, if read groups are not present in a file, there 
      are two options for proceeding. If '--read_group_id None' is provided 
      (case sensitive), then no read groups will be used in subsequent mapping 
      steps. Otherwise, any other string provided to this flag will be used as a
      read group ID. Default is '--read_group_id xyalign'
    inputBinding:
      position: 101
      prefix: --read_group_id
  - id: ref
    type: File
    doc: REQUIRED. Path to reference sequence (including file name).
    inputBinding:
      position: 101
      prefix: --ref
  - id: reference_mask
    type:
      - 'null'
      - type: array
        items: File
    doc: Bed file containing regions to replace with Ns in the sex chromosome 
      reference. Examples might include the pseudoautosomal regions on the Y to 
      force all mapping/calling on those regions of the X chromosome. Default is
      None.
    inputBinding:
      position: 101
      prefix: --reference_mask
  - id: remapping
    type:
      - 'null'
      - boolean
    doc: This flag will limit XYalign to only the steps required to strip reads 
      and remap to masked references. If masked references are not provided, 
      they will be created.
    inputBinding:
      position: 101
      prefix: --REMAPPING
  - id: repairsh_path
    type:
      - 'null'
      - string
    doc: Path to bbmap's repair.sh script. Default is 'repair.sh'
    inputBinding:
      position: 101
      prefix: --repairsh_path
  - id: reporting_level
    type:
      - 'null'
      - string
    doc: Set level of messages printed to console. Default is 'INFO'. Choose 
      from (in decreasing amount of reporting) DEBUG, INFO, ERROR or CRITICAL
    inputBinding:
      position: 101
      prefix: --reporting_level
  - id: sam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Full path to input sam files. If more than one provided, only the first
      will be used for modules other than --CHROM_STATS. Not currently 
      supported.
    inputBinding:
      position: 101
      prefix: --sam
  - id: sambamba_path
    type:
      - 'null'
      - string
    doc: Path to sambamba. Default is 'sambamba'
    inputBinding:
      position: 101
      prefix: --sambamba_path
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Name/ID of sample - for use in plot titles and file naming. Default is 
      sample
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: Path to samtools. Default is 'samtools'
    inputBinding:
      position: 101
      prefix: --samtools_path
  - id: sex_chrom_bam_only
    type:
      - 'null'
      - boolean
    doc: This flag skips merging the new sex chromosome bam file back into the 
      original bam file (i.e., sex chrom swapping). This will output a bam file 
      containing only the newly remapped sex chromosomes.
    inputBinding:
      position: 101
      prefix: --sex_chrom_bam_only
  - id: sex_chrom_calling_threshold
    type:
      - 'null'
      - float
    doc: This is the *maximum* filtered X/Y depth ratio for an individual to be 
      considered as having heterogametic sex chromsomes (e.g., XY) for the 
      REMAPPING module of XYalign. Note here that X and Y chromosomes are simply
      the chromosomes that have been designated as X and Y via --x_chromosome 
      and --y_chromosome. Keep in mind that the ideal threshold will vary 
      according to sex determination mechanism, sequence homology between the 
      sex chromosomes, reference genome, sequencing methods, etc. See 
      documentation for more detail. Default is 2.0, which we found to be 
      reasonable for exome, low-coverage whole-genome, and high-coverage 
      whole-genome human data.
    inputBinding:
      position: 101
      prefix: --sex_chrom_calling_threshold
  - id: shufflesh_path
    type:
      - 'null'
      - string
    doc: Path to bbmap's shuffle.sh script. Default is 'shuffle.sh'
    inputBinding:
      position: 101
      prefix: --shufflesh_path
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Include flag if reads are single-end and NOT paired-end.
    inputBinding:
      position: 101
      prefix: --single_end
  - id: skip_compatibility_check
    type:
      - 'null'
      - boolean
    doc: Include flag to prevent check of compatibility between input bam and 
      reference fasta
    inputBinding:
      position: 101
      prefix: --skip_compatibility_check
  - id: strip_reads
    type:
      - 'null'
      - boolean
    doc: This flag will limit XYalign to only the steps required to strip reads 
      from a provided bam file.
    inputBinding:
      position: 101
      prefix: --STRIP_READS
  - id: target_bed
    type:
      - 'null'
      - File
    doc: Bed file containing targets to use in sliding window analyses instead 
      of a fixed window width. Either this or --window_size needs to be set. 
      Default is None, which will use window size provided with --window_size. 
      If not None, and --window_size is None, analyses will use targets in 
      provided file. Must be typical bed format, 0-based indexing, with the 
      first three columns containing the chromosome name, start coordinate, stop
      coordinate.
    inputBinding:
      position: 101
      prefix: --target_bed
  - id: use_counts
    type:
      - 'null'
      - boolean
    doc: If True, get counts of reads per chromosome for CHROM_STATS, rather 
      than calculating mean depth and mapq. Much faster, but provides less 
      information. Default is False
    inputBinding:
      position: 101
      prefix: --use_counts
  - id: variant_depth
    type:
      - 'null'
      - int
    doc: Consider all SNPs with a sample depth greater than or equal to this 
      value. Default is 4.
    inputBinding:
      position: 101
      prefix: --variant_depth
  - id: variant_genotype_quality
    type:
      - 'null'
      - int
    doc: Consider all SNPs with a sample genotype quality greater than or equal 
      to this value. Default is 30.
    inputBinding:
      position: 101
      prefix: --variant_genotype_quality
  - id: variant_site_quality
    type:
      - 'null'
      - int
    doc: Consider all SNPs with a site quality (QUAL) greater than or equal to 
      this value. Default is 30.
    inputBinding:
      position: 101
      prefix: --variant_site_quality
  - id: whole_genome_threshold
    type:
      - 'null'
      - boolean
    doc: This flag will calculate the depth filter threshold based on all values
      from across the genome. By default, thresholds are calculated per 
      chromosome.
    inputBinding:
      position: 101
      prefix: --whole_genome_threshold
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size (integer) for sliding window calculations. Default is 
      50000. Default is None. If set to None, will use targets provided using 
      --target_bed.
    inputBinding:
      position: 101
      prefix: --window_size
  - id: x_chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of x-linked scaffolds in reference fasta (must match reference 
      exactly).
    inputBinding:
      position: 101
      prefix: --x_chromosome
  - id: xmx
    type:
      - 'null'
      - string
    doc: Memory to be provided to java programs via -Xmx. E.g., use the flag 
      '--xmx 4g' to pass '-Xmx4g' as a flag when running java programs 
      (currently just repair.sh). Default is 'None' (i.e., nothing provided on 
      the command line), which will allow repair.sh to automatically allocate 
      memory. Note that if you're using --STRIP_READS on deep coverage whole 
      genome data, you might need quite a bit of memory, e.g. '--xmx 16g', 
      '--xmx 32g', or more depending on how many reads are present per read 
      group.
    inputBinding:
      position: 101
      prefix: --xmx
  - id: xx_ref_in
    type:
      - 'null'
      - File
    doc: Path to preprocessed reference fasta to be used for remapping in X0 or 
      XX samples. Default is None. If none, will produce a sample-specific 
      reference for remapping.
    inputBinding:
      position: 101
      prefix: --xx_ref_in
  - id: xx_ref_out
    type:
      - 'null'
      - File
    doc: Desired path to and name of masked output fasta for samples WITHOUT a Y
      chromosome (e.g., XX, XXX, XO, etc.). Overwrites if exists. Use if you 
      would like output somewhere other than XYalign reference directory. 
      Otherwise, use --xx_ref_name.
    inputBinding:
      position: 101
      prefix: --xx_ref_out
  - id: xx_ref_out_name
    type:
      - 'null'
      - string
    doc: Desired name for masked output fasta for samples WITHOUT a Y chromosome
      (e.g., XX, XXX, XO, etc.). Defaults to 'xyalign_noY.masked.fa'. Will be 
      output in the XYalign reference directory.
    inputBinding:
      position: 101
      prefix: --xx_ref_out_name
  - id: xy_ref_in
    type:
      - 'null'
      - File
    doc: Path to preprocessed reference fasta to be used for remapping in 
      samples containing Y chromosome. Default is None. If none, will produce a 
      sample-specific reference for remapping.
    inputBinding:
      position: 101
      prefix: --xy_ref_in
  - id: xy_ref_out
    type:
      - 'null'
      - File
    doc: Desired path to and name of masked output fasta for samples WITH a Y 
      chromosome (e.g., XY, XXY, etc.). Overwrites if exists. Use if you would 
      like output somewhere other than XYalign reference directory. Otherwise, 
      use --xy_ref_name.
    inputBinding:
      position: 101
      prefix: --xy_ref_out
  - id: xy_ref_out_name
    type:
      - 'null'
      - string
    doc: Desired name for masked output fasta for samples WITH a Y chromosome 
      (e.g., XY, XXY, etc.). Defaults to 'xyalign_withY.masked.fa'. Will be 
      output in the XYalign reference directory.
    inputBinding:
      position: 101
      prefix: --xy_ref_out_name
  - id: y_absent
    type:
      - 'null'
      - boolean
    doc: Overrides sex chr estimation by XY align and remaps with Y absent.
    inputBinding:
      position: 101
      prefix: --y_absent
  - id: y_chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of y-linked scaffolds in reference fasta (must match reference 
      exactly). Defaults to chrY. Give None if using an assembly without a Y 
      chromosome
    inputBinding:
      position: 101
      prefix: --y_chromosome
  - id: y_present
    type:
      - 'null'
      - boolean
    doc: Overrides sex chr estimation by XYalign and remaps with Y present.
    inputBinding:
      position: 101
      prefix: --y_present
outputs:
  - id: output_dir
    type: Directory
    doc: REQUIRED. Output directory. XYalign will create a directory structure 
      within this directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xyalign:1.1.5--py_1
