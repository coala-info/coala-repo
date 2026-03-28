# xyalign CWL Generation Report

## xyalign_prepare_reference

### Tool Description
XYalign

### Metadata
- **Docker Image**: quay.io/biocontainers/xyalign:1.1.5--py_1
- **Homepage**: https://github.com/WilsonSayresLab/XYalign
- **Package**: https://anaconda.org/channels/bioconda/packages/xyalign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/xyalign/overview
- **Total Downloads**: 18.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/WilsonSayresLab/XYalign
- **Stars**: N/A
### Original Help Text
```text
usage: xyalign [-h] [--bam [BAM [BAM ...]]] [--cram [CRAM [CRAM ...]]]
               [--sam [SAM [SAM ...]]] --ref REF --output_dir OUTPUT_DIR
               [--chromosomes [CHROMOSOMES [CHROMOSOMES ...]]]
               [--x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]]]
               [--y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]]]
               [--sample_id SAMPLE_ID] [--cpus CPUS] [--xmx XMX]
               [--fastq_compression {0,1,2,3,4,5,6,7,8,9}] [--single_end]
               [--version] [--no_cleanup]
               [--PREPARE_REFERENCE | --CHROM_STATS | --ANALYZE_BAM | --CHARACTERIZE_SEX_CHROMS | --REMAPPING | --STRIP_READS]
               [--logfile LOGFILE]
               [--reporting_level {DEBUG,INFO,ERROR,CRITICAL}]
               [--platypus_path PLATYPUS_PATH] [--bwa_path BWA_PATH]
               [--samtools_path SAMTOOLS_PATH] [--repairsh_path REPAIRSH_PATH]
               [--shufflesh_path SHUFFLESH_PATH]
               [--sambamba_path SAMBAMBA_PATH] [--bedtools_path BEDTOOLS_PATH]
               [--platypus_calling {both,none,before,after}]
               [--no_variant_plots] [--no_bam_analysis]
               [--skip_compatibility_check] [--no_perm_test] [--no_ks_test]
               [--no_bootstrap] [--variant_site_quality VARIANT_SITE_QUALITY]
               [--variant_genotype_quality VARIANT_GENOTYPE_QUALITY]
               [--variant_depth VARIANT_DEPTH]
               [--platypus_logfile PLATYPUS_LOGFILE]
               [--homogenize_read_balance HOMOGENIZE_READ_BALANCE]
               [--min_variant_count MIN_VARIANT_COUNT]
               [--reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]]
               [--xx_ref_out_name XX_REF_OUT_NAME]
               [--xy_ref_out_name XY_REF_OUT_NAME] [--xx_ref_out XX_REF_OUT]
               [--xy_ref_out XY_REF_OUT] [--xx_ref_in XX_REF_IN]
               [--xy_ref_in XY_REF_IN] [--bwa_index BWA_INDEX]
               [--read_group_id READ_GROUP_ID] [--bwa_flags BWA_FLAGS]
               [--sex_chrom_bam_only]
               [--sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD]
               [--y_present | --y_absent] [--window_size WINDOW_SIZE]
               [--target_bed TARGET_BED] [--exact_depth]
               [--whole_genome_threshold] [--mapq_cutoff MAPQ_CUTOFF]
               [--min_depth_filter MIN_DEPTH_FILTER]
               [--max_depth_filter MAX_DEPTH_FILTER]
               [--num_permutations NUM_PERMUTATIONS]
               [--num_bootstraps NUM_BOOTSTRAPS] [--ignore_duplicates]
               [--marker_size MARKER_SIZE]
               [--marker_transparency MARKER_TRANSPARENCY]
               [--coordinate_scale COORDINATE_SCALE]
               [--include_fixed INCLUDE_FIXED] [--use_counts]

XYalign

optional arguments:
  -h, --help            show this help message and exit
  --bam [BAM [BAM ...]]
                        Full path to input bam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS
  --cram [CRAM [CRAM ...]]
                        Full path to input cram files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --sam [SAM [SAM ...]]
                        Full path to input sam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --ref REF             REQUIRED. Path to reference sequence (including file
                        name).
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        REQUIRED. Output directory. XYalign will create a
                        directory structure within this directory
  --chromosomes [CHROMOSOMES [CHROMOSOMES ...]], -c [CHROMOSOMES [CHROMOSOMES ...]]
                        Chromosomes to analyze (names must match reference
                        exactly). For humans, we recommend at least chr19,
                        chrX, chrY. Generally, we suggest including the sex
                        chromosomes and at least one autosome. To analyze all
                        chromosomes use '--chromosomes ALL' or '--chromosomes
                        all'.
  --x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]], -x [X_CHROMOSOME [X_CHROMOSOME ...]]
                        Names of x-linked scaffolds in reference fasta (must
                        match reference exactly).
  --y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]], -y [Y_CHROMOSOME [Y_CHROMOSOME ...]]
                        Names of y-linked scaffolds in reference fasta (must
                        match reference exactly). Defaults to chrY. Give None
                        if using an assembly without a Y chromosome
  --sample_id SAMPLE_ID, -id SAMPLE_ID
                        Name/ID of sample - for use in plot titles and file
                        naming. Default is sample
  --cpus CPUS           Number of cores/threads to use. Default is 1
  --xmx XMX             Memory to be provided to java programs via -Xmx. E.g.,
                        use the flag '--xmx 4g' to pass '-Xmx4g' as a flag
                        when running java programs (currently just repair.sh).
                        Default is 'None' (i.e., nothing provided on the
                        command line), which will allow repair.sh to
                        automatically allocate memory. Note that if you're
                        using --STRIP_READS on deep coverage whole genome
                        data, you might need quite a bit of memory, e.g. '--
                        xmx 16g', '--xmx 32g', or more depending on how many
                        reads are present per read group.
  --fastq_compression {0,1,2,3,4,5,6,7,8,9}
                        Compression level for fastqs output from repair.sh.
                        Between (inclusive) 0 and 9. Default is 3. 1 through 9
                        indicate compression levels. If 0, fastqs will be
                        uncompressed.
  --single_end          Include flag if reads are single-end and NOT paired-
                        end.
  --version, -V         Print version and exit.
  --no_cleanup          Include flag to preserve temporary files.
  --PREPARE_REFERENCE   This flag will limit XYalign to only preparing
                        reference fastas for individuals with and without Y
                        chromosomes. These fastas can then be passed with each
                        sample to save subsequent processing time.
  --CHROM_STATS         This flag will limit XYalign to only analyzing
                        provided bam files for depth and mapq across entire
                        chromosomes.
  --ANALYZE_BAM         This flag will limit XYalign to only analyzing the bam
                        file for depth, mapq, and (optionally) read balance
                        and outputting plots.
  --CHARACTERIZE_SEX_CHROMS
                        This flag will limit XYalign to the steps required to
                        characterize sex chromosome content (i.e., analyzing
                        the bam for depth, mapq, and read balance and running
                        statistical tests to help infer ploidy)
  --REMAPPING           This flag will limit XYalign to only the steps
                        required to strip reads and remap to masked
                        references. If masked references are not provided,
                        they will be created.
  --STRIP_READS         This flag will limit XYalign to only the steps
                        required to strip reads from a provided bam file.
  --logfile LOGFILE     Name of logfile. Will overwrite if exists. Default is
                        sample_xyalign.log
  --reporting_level {DEBUG,INFO,ERROR,CRITICAL}
                        Set level of messages printed to console. Default is
                        'INFO'. Choose from (in decreasing amount of
                        reporting) DEBUG, INFO, ERROR or CRITICAL
  --platypus_path PLATYPUS_PATH
                        Path to platypus. Default is 'platypus'. If platypus
                        is not directly callable (e.g., '/path/to/platypus' or
                        '/path/to/Playpus.py'), then provide path to python as
                        well (e.g., '/path/to/python /path/to/platypus'). In
                        addition, be sure provided python is version 2. See
                        the documentation for more information about setting
                        up an anaconda environment.
  --bwa_path BWA_PATH   Path to bwa. Default is 'bwa'
  --samtools_path SAMTOOLS_PATH
                        Path to samtools. Default is 'samtools'
  --repairsh_path REPAIRSH_PATH
                        Path to bbmap's repair.sh script. Default is
                        'repair.sh'
  --shufflesh_path SHUFFLESH_PATH
                        Path to bbmap's shuffle.sh script. Default is
                        'shuffle.sh'
  --sambamba_path SAMBAMBA_PATH
                        Path to sambamba. Default is 'sambamba'
  --bedtools_path BEDTOOLS_PATH
                        Path to bedtools. Default is 'bedtools'
  --platypus_calling {both,none,before,after}
                        Platypus calling withing the pipeline (before
                        processing, after processing, both, or neither).
                        Options: both, none, before, after.
  --no_variant_plots    Include flag to prevent plotting read balance from VCF
                        files.
  --no_bam_analysis     Include flag to prevent depth/mapq analysis of bam
                        file. Used to isolate platypus_calling.
  --skip_compatibility_check
                        Include flag to prevent check of compatibility between
                        input bam and reference fasta
  --no_perm_test        Include flag to turn off permutation tests.
  --no_ks_test          Include flag to turn off KS Two Sample tests.
  --no_bootstrap        Include flag to turn off bootstrap analyses. Requires
                        either --y_present, --y_absent, or
                        --sex_chrom_calling_threshold if running full
                        pipeline.
  --variant_site_quality VARIANT_SITE_QUALITY, -vsq VARIANT_SITE_QUALITY
                        Consider all SNPs with a site quality (QUAL) greater
                        than or equal to this value. Default is 30.
  --variant_genotype_quality VARIANT_GENOTYPE_QUALITY, -vgq VARIANT_GENOTYPE_QUALITY
                        Consider all SNPs with a sample genotype quality
                        greater than or equal to this value. Default is 30.
  --variant_depth VARIANT_DEPTH, -vd VARIANT_DEPTH
                        Consider all SNPs with a sample depth greater than or
                        equal to this value. Default is 4.
  --platypus_logfile PLATYPUS_LOGFILE
                        Prefix to use for Platypus log files. Will default to
                        the sample_id argument provided
  --homogenize_read_balance HOMOGENIZE_READ_BALANCE
                        If True, read balance values will be transformed by
                        subtracting each value from 1. For example, 0.25 and
                        0.75 would be treated equivalently. Default is False.
  --min_variant_count MIN_VARIANT_COUNT
                        Minimum number of variants in a window for the read
                        balance of that window to be plotted. Note that this
                        does not affect plotting of variant counts. Default is
                        1, though we note that many window averages will be
                        meaningless at this setting.
  --reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]
                        Bed file containing regions to replace with Ns in the
                        sex chromosome reference. Examples might include the
                        pseudoautosomal regions on the Y to force all
                        mapping/calling on those regions of the X chromosome.
                        Default is None.
  --xx_ref_out_name XX_REF_OUT_NAME
                        Desired name for masked output fasta for samples
                        WITHOUT a Y chromosome (e.g., XX, XXX, XO, etc.).
                        Defaults to 'xyalign_noY.masked.fa'. Will be output in
                        the XYalign reference directory.
  --xy_ref_out_name XY_REF_OUT_NAME
                        Desired name for masked output fasta for samples WITH
                        a Y chromosome (e.g., XY, XXY, etc.). Defaults to
                        'xyalign_withY.masked.fa'. Will be output in the
                        XYalign reference directory.
  --xx_ref_out XX_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITHOUT a Y chromosome (e.g., XX, XXX, XO,
                        etc.). Overwrites if exists. Use if you would like
                        output somewhere other than XYalign reference
                        directory. Otherwise, use --xx_ref_name.
  --xy_ref_out XY_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITH a Y chromosome (e.g., XY, XXY, etc.).
                        Overwrites if exists. Use if you would like output
                        somewhere other than XYalign reference directory.
                        Otherwise, use --xy_ref_name.
  --xx_ref_in XX_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in X0 or XX samples. Default is None. If
                        none, will produce a sample-specific reference for
                        remapping.
  --xy_ref_in XY_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in samples containing Y chromosome. Default
                        is None. If none, will produce a sample-specific
                        reference for remapping.
  --bwa_index BWA_INDEX
                        If True, index with BWA during PREPARE_REFERENCE. Only
                        relevantwhen running the PREPARE_REFERENCE module by
                        itself. Default is False.
  --read_group_id READ_GROUP_ID
                        If read groups are present in a bam file, they are
                        used by default in remapping steps. However, if read
                        groups are not present in a file, there are two
                        options for proceeding. If '--read_group_id None' is
                        provided (case sensitive), then no read groups will be
                        used in subsequent mapping steps. Otherwise, any other
                        string provided to this flag will be used as a read
                        group ID. Default is '--read_group_id xyalign'
  --bwa_flags BWA_FLAGS
                        Provide a string (in quotes, with spaces between
                        arguments) for additional flags desired for BWA
                        mapping (other than -R and -t). Example: '-M -T 20 -v
                        4'. Note that those are spaces between arguments.
  --sex_chrom_bam_only  This flag skips merging the new sex chromosome bam
                        file back into the original bam file (i.e., sex chrom
                        swapping). This will output a bam file containing only
                        the newly remapped sex chromosomes.
  --sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD
                        This is the *maximum* filtered X/Y depth ratio for an
                        individual to be considered as having heterogametic
                        sex chromsomes (e.g., XY) for the REMAPPING module of
                        XYalign. Note here that X and Y chromosomes are simply
                        the chromosomes that have been designated as X and Y
                        via --x_chromosome and --y_chromosome. Keep in mind
                        that the ideal threshold will vary according to sex
                        determination mechanism, sequence homology between the
                        sex chromosomes, reference genome, sequencing methods,
                        etc. See documentation for more detail. Default is
                        2.0, which we found to be reasonable for exome, low-
                        coverage whole-genome, and high-coverage whole-genome
                        human data.
  --y_present           Overrides sex chr estimation by XYalign and remaps
                        with Y present.
  --y_absent            Overrides sex chr estimation by XY align and remaps
                        with Y absent.
  --window_size WINDOW_SIZE, -w WINDOW_SIZE
                        Window size (integer) for sliding window calculations.
                        Default is 50000. Default is None. If set to None,
                        will use targets provided using --target_bed.
  --target_bed TARGET_BED
                        Bed file containing targets to use in sliding window
                        analyses instead of a fixed window width. Either this
                        or --window_size needs to be set. Default is None,
                        which will use window size provided with
                        --window_size. If not None, and --window_size is None,
                        analyses will use targets in provided file. Must be
                        typical bed format, 0-based indexing, with the first
                        three columns containing the chromosome name, start
                        coordinate, stop coordinate.
  --exact_depth         Calculate exact depth within windows, else use much
                        faster approximation. *Currently exact is not
                        implemented*. Default is False.
  --whole_genome_threshold
                        This flag will calculate the depth filter threshold
                        based on all values from across the genome. By
                        default, thresholds are calculated per chromosome.
  --mapq_cutoff MAPQ_CUTOFF, -mq MAPQ_CUTOFF
                        Minimum mean mapq threshold for a window to be
                        considered high quality. Default is 20.
  --min_depth_filter MIN_DEPTH_FILTER
                        Minimum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        min_depth_filter. So, a min_depth_filter of 0.2 would
                        require at least a minimum depth of 2 if the mean
                        depth was 10. Default is 0.0 to consider all windows.
  --max_depth_filter MAX_DEPTH_FILTER
                        Maximum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        max_depth_filter. So, a max_depth_filter of 4 would
                        require depths to be less than or equal to 40 if the
                        mean depth was 10. Default is 10000.0 to consider all
                        windows.
  --num_permutations NUM_PERMUTATIONS
                        Number of permutations to use for permutation
                        analyses. Default is 10000
  --num_bootstraps NUM_BOOTSTRAPS
                        Number of bootstrap replicates to use when
                        bootstrapping mean depth ratios among chromosomes.
                        Default is 10000
  --ignore_duplicates   Ignore duplicate reads in bam analyses. Default is to
                        include duplicates.
  --marker_size MARKER_SIZE
                        Marker size for genome-wide plots in matplotlib.
                        Default is 10.
  --marker_transparency MARKER_TRANSPARENCY, -mt MARKER_TRANSPARENCY
                        Transparency of markers in genome-wide plots. Alpha in
                        matplotlib. Default is 0.5
  --coordinate_scale COORDINATE_SCALE
                        For genome-wide scatter plots, divide all coordinates
                        by this value.Default is 1000000, which will plot
                        everything in megabases.
  --include_fixed INCLUDE_FIXED
                        Default is False, which removes read balances less
                        than or equal to 0.05 and equal to 1.0 for histogram
                        plotting. True will include all values. Extreme values
                        removed by default because they often swamp out the
                        signal of the rest of the distribution.
  --use_counts          If True, get counts of reads per chromosome for
                        CHROM_STATS, rather than calculating mean depth and
                        mapq. Much faster, but provides less information.
                        Default is False
```


## xyalign_chrom_stats

### Tool Description
XYalign

### Metadata
- **Docker Image**: quay.io/biocontainers/xyalign:1.1.5--py_1
- **Homepage**: https://github.com/WilsonSayresLab/XYalign
- **Package**: https://anaconda.org/channels/bioconda/packages/xyalign/overview
- **Validation**: PASS

### Original Help Text
```text
usage: xyalign [-h] [--bam [BAM [BAM ...]]] [--cram [CRAM [CRAM ...]]]
               [--sam [SAM [SAM ...]]] --ref REF --output_dir OUTPUT_DIR
               [--chromosomes [CHROMOSOMES [CHROMOSOMES ...]]]
               [--x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]]]
               [--y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]]]
               [--sample_id SAMPLE_ID] [--cpus CPUS] [--xmx XMX]
               [--fastq_compression {0,1,2,3,4,5,6,7,8,9}] [--single_end]
               [--version] [--no_cleanup]
               [--PREPARE_REFERENCE | --CHROM_STATS | --ANALYZE_BAM | --CHARACTERIZE_SEX_CHROMS | --REMAPPING | --STRIP_READS]
               [--logfile LOGFILE]
               [--reporting_level {DEBUG,INFO,ERROR,CRITICAL}]
               [--platypus_path PLATYPUS_PATH] [--bwa_path BWA_PATH]
               [--samtools_path SAMTOOLS_PATH] [--repairsh_path REPAIRSH_PATH]
               [--shufflesh_path SHUFFLESH_PATH]
               [--sambamba_path SAMBAMBA_PATH] [--bedtools_path BEDTOOLS_PATH]
               [--platypus_calling {both,none,before,after}]
               [--no_variant_plots] [--no_bam_analysis]
               [--skip_compatibility_check] [--no_perm_test] [--no_ks_test]
               [--no_bootstrap] [--variant_site_quality VARIANT_SITE_QUALITY]
               [--variant_genotype_quality VARIANT_GENOTYPE_QUALITY]
               [--variant_depth VARIANT_DEPTH]
               [--platypus_logfile PLATYPUS_LOGFILE]
               [--homogenize_read_balance HOMOGENIZE_READ_BALANCE]
               [--min_variant_count MIN_VARIANT_COUNT]
               [--reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]]
               [--xx_ref_out_name XX_REF_OUT_NAME]
               [--xy_ref_out_name XY_REF_OUT_NAME] [--xx_ref_out XX_REF_OUT]
               [--xy_ref_out XY_REF_OUT] [--xx_ref_in XX_REF_IN]
               [--xy_ref_in XY_REF_IN] [--bwa_index BWA_INDEX]
               [--read_group_id READ_GROUP_ID] [--bwa_flags BWA_FLAGS]
               [--sex_chrom_bam_only]
               [--sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD]
               [--y_present | --y_absent] [--window_size WINDOW_SIZE]
               [--target_bed TARGET_BED] [--exact_depth]
               [--whole_genome_threshold] [--mapq_cutoff MAPQ_CUTOFF]
               [--min_depth_filter MIN_DEPTH_FILTER]
               [--max_depth_filter MAX_DEPTH_FILTER]
               [--num_permutations NUM_PERMUTATIONS]
               [--num_bootstraps NUM_BOOTSTRAPS] [--ignore_duplicates]
               [--marker_size MARKER_SIZE]
               [--marker_transparency MARKER_TRANSPARENCY]
               [--coordinate_scale COORDINATE_SCALE]
               [--include_fixed INCLUDE_FIXED] [--use_counts]

XYalign

optional arguments:
  -h, --help            show this help message and exit
  --bam [BAM [BAM ...]]
                        Full path to input bam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS
  --cram [CRAM [CRAM ...]]
                        Full path to input cram files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --sam [SAM [SAM ...]]
                        Full path to input sam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --ref REF             REQUIRED. Path to reference sequence (including file
                        name).
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        REQUIRED. Output directory. XYalign will create a
                        directory structure within this directory
  --chromosomes [CHROMOSOMES [CHROMOSOMES ...]], -c [CHROMOSOMES [CHROMOSOMES ...]]
                        Chromosomes to analyze (names must match reference
                        exactly). For humans, we recommend at least chr19,
                        chrX, chrY. Generally, we suggest including the sex
                        chromosomes and at least one autosome. To analyze all
                        chromosomes use '--chromosomes ALL' or '--chromosomes
                        all'.
  --x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]], -x [X_CHROMOSOME [X_CHROMOSOME ...]]
                        Names of x-linked scaffolds in reference fasta (must
                        match reference exactly).
  --y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]], -y [Y_CHROMOSOME [Y_CHROMOSOME ...]]
                        Names of y-linked scaffolds in reference fasta (must
                        match reference exactly). Defaults to chrY. Give None
                        if using an assembly without a Y chromosome
  --sample_id SAMPLE_ID, -id SAMPLE_ID
                        Name/ID of sample - for use in plot titles and file
                        naming. Default is sample
  --cpus CPUS           Number of cores/threads to use. Default is 1
  --xmx XMX             Memory to be provided to java programs via -Xmx. E.g.,
                        use the flag '--xmx 4g' to pass '-Xmx4g' as a flag
                        when running java programs (currently just repair.sh).
                        Default is 'None' (i.e., nothing provided on the
                        command line), which will allow repair.sh to
                        automatically allocate memory. Note that if you're
                        using --STRIP_READS on deep coverage whole genome
                        data, you might need quite a bit of memory, e.g. '--
                        xmx 16g', '--xmx 32g', or more depending on how many
                        reads are present per read group.
  --fastq_compression {0,1,2,3,4,5,6,7,8,9}
                        Compression level for fastqs output from repair.sh.
                        Between (inclusive) 0 and 9. Default is 3. 1 through 9
                        indicate compression levels. If 0, fastqs will be
                        uncompressed.
  --single_end          Include flag if reads are single-end and NOT paired-
                        end.
  --version, -V         Print version and exit.
  --no_cleanup          Include flag to preserve temporary files.
  --PREPARE_REFERENCE   This flag will limit XYalign to only preparing
                        reference fastas for individuals with and without Y
                        chromosomes. These fastas can then be passed with each
                        sample to save subsequent processing time.
  --CHROM_STATS         This flag will limit XYalign to only analyzing
                        provided bam files for depth and mapq across entire
                        chromosomes.
  --ANALYZE_BAM         This flag will limit XYalign to only analyzing the bam
                        file for depth, mapq, and (optionally) read balance
                        and outputting plots.
  --CHARACTERIZE_SEX_CHROMS
                        This flag will limit XYalign to the steps required to
                        characterize sex chromosome content (i.e., analyzing
                        the bam for depth, mapq, and read balance and running
                        statistical tests to help infer ploidy)
  --REMAPPING           This flag will limit XYalign to only the steps
                        required to strip reads and remap to masked
                        references. If masked references are not provided,
                        they will be created.
  --STRIP_READS         This flag will limit XYalign to only the steps
                        required to strip reads from a provided bam file.
  --logfile LOGFILE     Name of logfile. Will overwrite if exists. Default is
                        sample_xyalign.log
  --reporting_level {DEBUG,INFO,ERROR,CRITICAL}
                        Set level of messages printed to console. Default is
                        'INFO'. Choose from (in decreasing amount of
                        reporting) DEBUG, INFO, ERROR or CRITICAL
  --platypus_path PLATYPUS_PATH
                        Path to platypus. Default is 'platypus'. If platypus
                        is not directly callable (e.g., '/path/to/platypus' or
                        '/path/to/Playpus.py'), then provide path to python as
                        well (e.g., '/path/to/python /path/to/platypus'). In
                        addition, be sure provided python is version 2. See
                        the documentation for more information about setting
                        up an anaconda environment.
  --bwa_path BWA_PATH   Path to bwa. Default is 'bwa'
  --samtools_path SAMTOOLS_PATH
                        Path to samtools. Default is 'samtools'
  --repairsh_path REPAIRSH_PATH
                        Path to bbmap's repair.sh script. Default is
                        'repair.sh'
  --shufflesh_path SHUFFLESH_PATH
                        Path to bbmap's shuffle.sh script. Default is
                        'shuffle.sh'
  --sambamba_path SAMBAMBA_PATH
                        Path to sambamba. Default is 'sambamba'
  --bedtools_path BEDTOOLS_PATH
                        Path to bedtools. Default is 'bedtools'
  --platypus_calling {both,none,before,after}
                        Platypus calling withing the pipeline (before
                        processing, after processing, both, or neither).
                        Options: both, none, before, after.
  --no_variant_plots    Include flag to prevent plotting read balance from VCF
                        files.
  --no_bam_analysis     Include flag to prevent depth/mapq analysis of bam
                        file. Used to isolate platypus_calling.
  --skip_compatibility_check
                        Include flag to prevent check of compatibility between
                        input bam and reference fasta
  --no_perm_test        Include flag to turn off permutation tests.
  --no_ks_test          Include flag to turn off KS Two Sample tests.
  --no_bootstrap        Include flag to turn off bootstrap analyses. Requires
                        either --y_present, --y_absent, or
                        --sex_chrom_calling_threshold if running full
                        pipeline.
  --variant_site_quality VARIANT_SITE_QUALITY, -vsq VARIANT_SITE_QUALITY
                        Consider all SNPs with a site quality (QUAL) greater
                        than or equal to this value. Default is 30.
  --variant_genotype_quality VARIANT_GENOTYPE_QUALITY, -vgq VARIANT_GENOTYPE_QUALITY
                        Consider all SNPs with a sample genotype quality
                        greater than or equal to this value. Default is 30.
  --variant_depth VARIANT_DEPTH, -vd VARIANT_DEPTH
                        Consider all SNPs with a sample depth greater than or
                        equal to this value. Default is 4.
  --platypus_logfile PLATYPUS_LOGFILE
                        Prefix to use for Platypus log files. Will default to
                        the sample_id argument provided
  --homogenize_read_balance HOMOGENIZE_READ_BALANCE
                        If True, read balance values will be transformed by
                        subtracting each value from 1. For example, 0.25 and
                        0.75 would be treated equivalently. Default is False.
  --min_variant_count MIN_VARIANT_COUNT
                        Minimum number of variants in a window for the read
                        balance of that window to be plotted. Note that this
                        does not affect plotting of variant counts. Default is
                        1, though we note that many window averages will be
                        meaningless at this setting.
  --reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]
                        Bed file containing regions to replace with Ns in the
                        sex chromosome reference. Examples might include the
                        pseudoautosomal regions on the Y to force all
                        mapping/calling on those regions of the X chromosome.
                        Default is None.
  --xx_ref_out_name XX_REF_OUT_NAME
                        Desired name for masked output fasta for samples
                        WITHOUT a Y chromosome (e.g., XX, XXX, XO, etc.).
                        Defaults to 'xyalign_noY.masked.fa'. Will be output in
                        the XYalign reference directory.
  --xy_ref_out_name XY_REF_OUT_NAME
                        Desired name for masked output fasta for samples WITH
                        a Y chromosome (e.g., XY, XXY, etc.). Defaults to
                        'xyalign_withY.masked.fa'. Will be output in the
                        XYalign reference directory.
  --xx_ref_out XX_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITHOUT a Y chromosome (e.g., XX, XXX, XO,
                        etc.). Overwrites if exists. Use if you would like
                        output somewhere other than XYalign reference
                        directory. Otherwise, use --xx_ref_name.
  --xy_ref_out XY_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITH a Y chromosome (e.g., XY, XXY, etc.).
                        Overwrites if exists. Use if you would like output
                        somewhere other than XYalign reference directory.
                        Otherwise, use --xy_ref_name.
  --xx_ref_in XX_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in X0 or XX samples. Default is None. If
                        none, will produce a sample-specific reference for
                        remapping.
  --xy_ref_in XY_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in samples containing Y chromosome. Default
                        is None. If none, will produce a sample-specific
                        reference for remapping.
  --bwa_index BWA_INDEX
                        If True, index with BWA during PREPARE_REFERENCE. Only
                        relevantwhen running the PREPARE_REFERENCE module by
                        itself. Default is False.
  --read_group_id READ_GROUP_ID
                        If read groups are present in a bam file, they are
                        used by default in remapping steps. However, if read
                        groups are not present in a file, there are two
                        options for proceeding. If '--read_group_id None' is
                        provided (case sensitive), then no read groups will be
                        used in subsequent mapping steps. Otherwise, any other
                        string provided to this flag will be used as a read
                        group ID. Default is '--read_group_id xyalign'
  --bwa_flags BWA_FLAGS
                        Provide a string (in quotes, with spaces between
                        arguments) for additional flags desired for BWA
                        mapping (other than -R and -t). Example: '-M -T 20 -v
                        4'. Note that those are spaces between arguments.
  --sex_chrom_bam_only  This flag skips merging the new sex chromosome bam
                        file back into the original bam file (i.e., sex chrom
                        swapping). This will output a bam file containing only
                        the newly remapped sex chromosomes.
  --sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD
                        This is the *maximum* filtered X/Y depth ratio for an
                        individual to be considered as having heterogametic
                        sex chromsomes (e.g., XY) for the REMAPPING module of
                        XYalign. Note here that X and Y chromosomes are simply
                        the chromosomes that have been designated as X and Y
                        via --x_chromosome and --y_chromosome. Keep in mind
                        that the ideal threshold will vary according to sex
                        determination mechanism, sequence homology between the
                        sex chromosomes, reference genome, sequencing methods,
                        etc. See documentation for more detail. Default is
                        2.0, which we found to be reasonable for exome, low-
                        coverage whole-genome, and high-coverage whole-genome
                        human data.
  --y_present           Overrides sex chr estimation by XYalign and remaps
                        with Y present.
  --y_absent            Overrides sex chr estimation by XY align and remaps
                        with Y absent.
  --window_size WINDOW_SIZE, -w WINDOW_SIZE
                        Window size (integer) for sliding window calculations.
                        Default is 50000. Default is None. If set to None,
                        will use targets provided using --target_bed.
  --target_bed TARGET_BED
                        Bed file containing targets to use in sliding window
                        analyses instead of a fixed window width. Either this
                        or --window_size needs to be set. Default is None,
                        which will use window size provided with
                        --window_size. If not None, and --window_size is None,
                        analyses will use targets in provided file. Must be
                        typical bed format, 0-based indexing, with the first
                        three columns containing the chromosome name, start
                        coordinate, stop coordinate.
  --exact_depth         Calculate exact depth within windows, else use much
                        faster approximation. *Currently exact is not
                        implemented*. Default is False.
  --whole_genome_threshold
                        This flag will calculate the depth filter threshold
                        based on all values from across the genome. By
                        default, thresholds are calculated per chromosome.
  --mapq_cutoff MAPQ_CUTOFF, -mq MAPQ_CUTOFF
                        Minimum mean mapq threshold for a window to be
                        considered high quality. Default is 20.
  --min_depth_filter MIN_DEPTH_FILTER
                        Minimum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        min_depth_filter. So, a min_depth_filter of 0.2 would
                        require at least a minimum depth of 2 if the mean
                        depth was 10. Default is 0.0 to consider all windows.
  --max_depth_filter MAX_DEPTH_FILTER
                        Maximum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        max_depth_filter. So, a max_depth_filter of 4 would
                        require depths to be less than or equal to 40 if the
                        mean depth was 10. Default is 10000.0 to consider all
                        windows.
  --num_permutations NUM_PERMUTATIONS
                        Number of permutations to use for permutation
                        analyses. Default is 10000
  --num_bootstraps NUM_BOOTSTRAPS
                        Number of bootstrap replicates to use when
                        bootstrapping mean depth ratios among chromosomes.
                        Default is 10000
  --ignore_duplicates   Ignore duplicate reads in bam analyses. Default is to
                        include duplicates.
  --marker_size MARKER_SIZE
                        Marker size for genome-wide plots in matplotlib.
                        Default is 10.
  --marker_transparency MARKER_TRANSPARENCY, -mt MARKER_TRANSPARENCY
                        Transparency of markers in genome-wide plots. Alpha in
                        matplotlib. Default is 0.5
  --coordinate_scale COORDINATE_SCALE
                        For genome-wide scatter plots, divide all coordinates
                        by this value.Default is 1000000, which will plot
                        everything in megabases.
  --include_fixed INCLUDE_FIXED
                        Default is False, which removes read balances less
                        than or equal to 0.05 and equal to 1.0 for histogram
                        plotting. True will include all values. Extreme values
                        removed by default because they often swamp out the
                        signal of the rest of the distribution.
  --use_counts          If True, get counts of reads per chromosome for
                        CHROM_STATS, rather than calculating mean depth and
                        mapq. Much faster, but provides less information.
                        Default is False
```


## xyalign_analyze_bam

### Tool Description
XYalign

### Metadata
- **Docker Image**: quay.io/biocontainers/xyalign:1.1.5--py_1
- **Homepage**: https://github.com/WilsonSayresLab/XYalign
- **Package**: https://anaconda.org/channels/bioconda/packages/xyalign/overview
- **Validation**: PASS

### Original Help Text
```text
usage: xyalign [-h] [--bam [BAM [BAM ...]]] [--cram [CRAM [CRAM ...]]]
               [--sam [SAM [SAM ...]]] --ref REF --output_dir OUTPUT_DIR
               [--chromosomes [CHROMOSOMES [CHROMOSOMES ...]]]
               [--x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]]]
               [--y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]]]
               [--sample_id SAMPLE_ID] [--cpus CPUS] [--xmx XMX]
               [--fastq_compression {0,1,2,3,4,5,6,7,8,9}] [--single_end]
               [--version] [--no_cleanup]
               [--PREPARE_REFERENCE | --CHROM_STATS | --ANALYZE_BAM | --CHARACTERIZE_SEX_CHROMS | --REMAPPING | --STRIP_READS]
               [--logfile LOGFILE]
               [--reporting_level {DEBUG,INFO,ERROR,CRITICAL}]
               [--platypus_path PLATYPUS_PATH] [--bwa_path BWA_PATH]
               [--samtools_path SAMTOOLS_PATH] [--repairsh_path REPAIRSH_PATH]
               [--shufflesh_path SHUFFLESH_PATH]
               [--sambamba_path SAMBAMBA_PATH] [--bedtools_path BEDTOOLS_PATH]
               [--platypus_calling {both,none,before,after}]
               [--no_variant_plots] [--no_bam_analysis]
               [--skip_compatibility_check] [--no_perm_test] [--no_ks_test]
               [--no_bootstrap] [--variant_site_quality VARIANT_SITE_QUALITY]
               [--variant_genotype_quality VARIANT_GENOTYPE_QUALITY]
               [--variant_depth VARIANT_DEPTH]
               [--platypus_logfile PLATYPUS_LOGFILE]
               [--homogenize_read_balance HOMOGENIZE_READ_BALANCE]
               [--min_variant_count MIN_VARIANT_COUNT]
               [--reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]]
               [--xx_ref_out_name XX_REF_OUT_NAME]
               [--xy_ref_out_name XY_REF_OUT_NAME] [--xx_ref_out XX_REF_OUT]
               [--xy_ref_out XY_REF_OUT] [--xx_ref_in XX_REF_IN]
               [--xy_ref_in XY_REF_IN] [--bwa_index BWA_INDEX]
               [--read_group_id READ_GROUP_ID] [--bwa_flags BWA_FLAGS]
               [--sex_chrom_bam_only]
               [--sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD]
               [--y_present | --y_absent] [--window_size WINDOW_SIZE]
               [--target_bed TARGET_BED] [--exact_depth]
               [--whole_genome_threshold] [--mapq_cutoff MAPQ_CUTOFF]
               [--min_depth_filter MIN_DEPTH_FILTER]
               [--max_depth_filter MAX_DEPTH_FILTER]
               [--num_permutations NUM_PERMUTATIONS]
               [--num_bootstraps NUM_BOOTSTRAPS] [--ignore_duplicates]
               [--marker_size MARKER_SIZE]
               [--marker_transparency MARKER_TRANSPARENCY]
               [--coordinate_scale COORDINATE_SCALE]
               [--include_fixed INCLUDE_FIXED] [--use_counts]

XYalign

optional arguments:
  -h, --help            show this help message and exit
  --bam [BAM [BAM ...]]
                        Full path to input bam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS
  --cram [CRAM [CRAM ...]]
                        Full path to input cram files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --sam [SAM [SAM ...]]
                        Full path to input sam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --ref REF             REQUIRED. Path to reference sequence (including file
                        name).
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        REQUIRED. Output directory. XYalign will create a
                        directory structure within this directory
  --chromosomes [CHROMOSOMES [CHROMOSOMES ...]], -c [CHROMOSOMES [CHROMOSOMES ...]]
                        Chromosomes to analyze (names must match reference
                        exactly). For humans, we recommend at least chr19,
                        chrX, chrY. Generally, we suggest including the sex
                        chromosomes and at least one autosome. To analyze all
                        chromosomes use '--chromosomes ALL' or '--chromosomes
                        all'.
  --x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]], -x [X_CHROMOSOME [X_CHROMOSOME ...]]
                        Names of x-linked scaffolds in reference fasta (must
                        match reference exactly).
  --y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]], -y [Y_CHROMOSOME [Y_CHROMOSOME ...]]
                        Names of y-linked scaffolds in reference fasta (must
                        match reference exactly). Defaults to chrY. Give None
                        if using an assembly without a Y chromosome
  --sample_id SAMPLE_ID, -id SAMPLE_ID
                        Name/ID of sample - for use in plot titles and file
                        naming. Default is sample
  --cpus CPUS           Number of cores/threads to use. Default is 1
  --xmx XMX             Memory to be provided to java programs via -Xmx. E.g.,
                        use the flag '--xmx 4g' to pass '-Xmx4g' as a flag
                        when running java programs (currently just repair.sh).
                        Default is 'None' (i.e., nothing provided on the
                        command line), which will allow repair.sh to
                        automatically allocate memory. Note that if you're
                        using --STRIP_READS on deep coverage whole genome
                        data, you might need quite a bit of memory, e.g. '--
                        xmx 16g', '--xmx 32g', or more depending on how many
                        reads are present per read group.
  --fastq_compression {0,1,2,3,4,5,6,7,8,9}
                        Compression level for fastqs output from repair.sh.
                        Between (inclusive) 0 and 9. Default is 3. 1 through 9
                        indicate compression levels. If 0, fastqs will be
                        uncompressed.
  --single_end          Include flag if reads are single-end and NOT paired-
                        end.
  --version, -V         Print version and exit.
  --no_cleanup          Include flag to preserve temporary files.
  --PREPARE_REFERENCE   This flag will limit XYalign to only preparing
                        reference fastas for individuals with and without Y
                        chromosomes. These fastas can then be passed with each
                        sample to save subsequent processing time.
  --CHROM_STATS         This flag will limit XYalign to only analyzing
                        provided bam files for depth and mapq across entire
                        chromosomes.
  --ANALYZE_BAM         This flag will limit XYalign to only analyzing the bam
                        file for depth, mapq, and (optionally) read balance
                        and outputting plots.
  --CHARACTERIZE_SEX_CHROMS
                        This flag will limit XYalign to the steps required to
                        characterize sex chromosome content (i.e., analyzing
                        the bam for depth, mapq, and read balance and running
                        statistical tests to help infer ploidy)
  --REMAPPING           This flag will limit XYalign to only the steps
                        required to strip reads and remap to masked
                        references. If masked references are not provided,
                        they will be created.
  --STRIP_READS         This flag will limit XYalign to only the steps
                        required to strip reads from a provided bam file.
  --logfile LOGFILE     Name of logfile. Will overwrite if exists. Default is
                        sample_xyalign.log
  --reporting_level {DEBUG,INFO,ERROR,CRITICAL}
                        Set level of messages printed to console. Default is
                        'INFO'. Choose from (in decreasing amount of
                        reporting) DEBUG, INFO, ERROR or CRITICAL
  --platypus_path PLATYPUS_PATH
                        Path to platypus. Default is 'platypus'. If platypus
                        is not directly callable (e.g., '/path/to/platypus' or
                        '/path/to/Playpus.py'), then provide path to python as
                        well (e.g., '/path/to/python /path/to/platypus'). In
                        addition, be sure provided python is version 2. See
                        the documentation for more information about setting
                        up an anaconda environment.
  --bwa_path BWA_PATH   Path to bwa. Default is 'bwa'
  --samtools_path SAMTOOLS_PATH
                        Path to samtools. Default is 'samtools'
  --repairsh_path REPAIRSH_PATH
                        Path to bbmap's repair.sh script. Default is
                        'repair.sh'
  --shufflesh_path SHUFFLESH_PATH
                        Path to bbmap's shuffle.sh script. Default is
                        'shuffle.sh'
  --sambamba_path SAMBAMBA_PATH
                        Path to sambamba. Default is 'sambamba'
  --bedtools_path BEDTOOLS_PATH
                        Path to bedtools. Default is 'bedtools'
  --platypus_calling {both,none,before,after}
                        Platypus calling withing the pipeline (before
                        processing, after processing, both, or neither).
                        Options: both, none, before, after.
  --no_variant_plots    Include flag to prevent plotting read balance from VCF
                        files.
  --no_bam_analysis     Include flag to prevent depth/mapq analysis of bam
                        file. Used to isolate platypus_calling.
  --skip_compatibility_check
                        Include flag to prevent check of compatibility between
                        input bam and reference fasta
  --no_perm_test        Include flag to turn off permutation tests.
  --no_ks_test          Include flag to turn off KS Two Sample tests.
  --no_bootstrap        Include flag to turn off bootstrap analyses. Requires
                        either --y_present, --y_absent, or
                        --sex_chrom_calling_threshold if running full
                        pipeline.
  --variant_site_quality VARIANT_SITE_QUALITY, -vsq VARIANT_SITE_QUALITY
                        Consider all SNPs with a site quality (QUAL) greater
                        than or equal to this value. Default is 30.
  --variant_genotype_quality VARIANT_GENOTYPE_QUALITY, -vgq VARIANT_GENOTYPE_QUALITY
                        Consider all SNPs with a sample genotype quality
                        greater than or equal to this value. Default is 30.
  --variant_depth VARIANT_DEPTH, -vd VARIANT_DEPTH
                        Consider all SNPs with a sample depth greater than or
                        equal to this value. Default is 4.
  --platypus_logfile PLATYPUS_LOGFILE
                        Prefix to use for Platypus log files. Will default to
                        the sample_id argument provided
  --homogenize_read_balance HOMOGENIZE_READ_BALANCE
                        If True, read balance values will be transformed by
                        subtracting each value from 1. For example, 0.25 and
                        0.75 would be treated equivalently. Default is False.
  --min_variant_count MIN_VARIANT_COUNT
                        Minimum number of variants in a window for the read
                        balance of that window to be plotted. Note that this
                        does not affect plotting of variant counts. Default is
                        1, though we note that many window averages will be
                        meaningless at this setting.
  --reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]
                        Bed file containing regions to replace with Ns in the
                        sex chromosome reference. Examples might include the
                        pseudoautosomal regions on the Y to force all
                        mapping/calling on those regions of the X chromosome.
                        Default is None.
  --xx_ref_out_name XX_REF_OUT_NAME
                        Desired name for masked output fasta for samples
                        WITHOUT a Y chromosome (e.g., XX, XXX, XO, etc.).
                        Defaults to 'xyalign_noY.masked.fa'. Will be output in
                        the XYalign reference directory.
  --xy_ref_out_name XY_REF_OUT_NAME
                        Desired name for masked output fasta for samples WITH
                        a Y chromosome (e.g., XY, XXY, etc.). Defaults to
                        'xyalign_withY.masked.fa'. Will be output in the
                        XYalign reference directory.
  --xx_ref_out XX_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITHOUT a Y chromosome (e.g., XX, XXX, XO,
                        etc.). Overwrites if exists. Use if you would like
                        output somewhere other than XYalign reference
                        directory. Otherwise, use --xx_ref_name.
  --xy_ref_out XY_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITH a Y chromosome (e.g., XY, XXY, etc.).
                        Overwrites if exists. Use if you would like output
                        somewhere other than XYalign reference directory.
                        Otherwise, use --xy_ref_name.
  --xx_ref_in XX_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in X0 or XX samples. Default is None. If
                        none, will produce a sample-specific reference for
                        remapping.
  --xy_ref_in XY_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in samples containing Y chromosome. Default
                        is None. If none, will produce a sample-specific
                        reference for remapping.
  --bwa_index BWA_INDEX
                        If True, index with BWA during PREPARE_REFERENCE. Only
                        relevantwhen running the PREPARE_REFERENCE module by
                        itself. Default is False.
  --read_group_id READ_GROUP_ID
                        If read groups are present in a bam file, they are
                        used by default in remapping steps. However, if read
                        groups are not present in a file, there are two
                        options for proceeding. If '--read_group_id None' is
                        provided (case sensitive), then no read groups will be
                        used in subsequent mapping steps. Otherwise, any other
                        string provided to this flag will be used as a read
                        group ID. Default is '--read_group_id xyalign'
  --bwa_flags BWA_FLAGS
                        Provide a string (in quotes, with spaces between
                        arguments) for additional flags desired for BWA
                        mapping (other than -R and -t). Example: '-M -T 20 -v
                        4'. Note that those are spaces between arguments.
  --sex_chrom_bam_only  This flag skips merging the new sex chromosome bam
                        file back into the original bam file (i.e., sex chrom
                        swapping). This will output a bam file containing only
                        the newly remapped sex chromosomes.
  --sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD
                        This is the *maximum* filtered X/Y depth ratio for an
                        individual to be considered as having heterogametic
                        sex chromsomes (e.g., XY) for the REMAPPING module of
                        XYalign. Note here that X and Y chromosomes are simply
                        the chromosomes that have been designated as X and Y
                        via --x_chromosome and --y_chromosome. Keep in mind
                        that the ideal threshold will vary according to sex
                        determination mechanism, sequence homology between the
                        sex chromosomes, reference genome, sequencing methods,
                        etc. See documentation for more detail. Default is
                        2.0, which we found to be reasonable for exome, low-
                        coverage whole-genome, and high-coverage whole-genome
                        human data.
  --y_present           Overrides sex chr estimation by XYalign and remaps
                        with Y present.
  --y_absent            Overrides sex chr estimation by XY align and remaps
                        with Y absent.
  --window_size WINDOW_SIZE, -w WINDOW_SIZE
                        Window size (integer) for sliding window calculations.
                        Default is 50000. Default is None. If set to None,
                        will use targets provided using --target_bed.
  --target_bed TARGET_BED
                        Bed file containing targets to use in sliding window
                        analyses instead of a fixed window width. Either this
                        or --window_size needs to be set. Default is None,
                        which will use window size provided with
                        --window_size. If not None, and --window_size is None,
                        analyses will use targets in provided file. Must be
                        typical bed format, 0-based indexing, with the first
                        three columns containing the chromosome name, start
                        coordinate, stop coordinate.
  --exact_depth         Calculate exact depth within windows, else use much
                        faster approximation. *Currently exact is not
                        implemented*. Default is False.
  --whole_genome_threshold
                        This flag will calculate the depth filter threshold
                        based on all values from across the genome. By
                        default, thresholds are calculated per chromosome.
  --mapq_cutoff MAPQ_CUTOFF, -mq MAPQ_CUTOFF
                        Minimum mean mapq threshold for a window to be
                        considered high quality. Default is 20.
  --min_depth_filter MIN_DEPTH_FILTER
                        Minimum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        min_depth_filter. So, a min_depth_filter of 0.2 would
                        require at least a minimum depth of 2 if the mean
                        depth was 10. Default is 0.0 to consider all windows.
  --max_depth_filter MAX_DEPTH_FILTER
                        Maximum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        max_depth_filter. So, a max_depth_filter of 4 would
                        require depths to be less than or equal to 40 if the
                        mean depth was 10. Default is 10000.0 to consider all
                        windows.
  --num_permutations NUM_PERMUTATIONS
                        Number of permutations to use for permutation
                        analyses. Default is 10000
  --num_bootstraps NUM_BOOTSTRAPS
                        Number of bootstrap replicates to use when
                        bootstrapping mean depth ratios among chromosomes.
                        Default is 10000
  --ignore_duplicates   Ignore duplicate reads in bam analyses. Default is to
                        include duplicates.
  --marker_size MARKER_SIZE
                        Marker size for genome-wide plots in matplotlib.
                        Default is 10.
  --marker_transparency MARKER_TRANSPARENCY, -mt MARKER_TRANSPARENCY
                        Transparency of markers in genome-wide plots. Alpha in
                        matplotlib. Default is 0.5
  --coordinate_scale COORDINATE_SCALE
                        For genome-wide scatter plots, divide all coordinates
                        by this value.Default is 1000000, which will plot
                        everything in megabases.
  --include_fixed INCLUDE_FIXED
                        Default is False, which removes read balances less
                        than or equal to 0.05 and equal to 1.0 for histogram
                        plotting. True will include all values. Extreme values
                        removed by default because they often swamp out the
                        signal of the rest of the distribution.
  --use_counts          If True, get counts of reads per chromosome for
                        CHROM_STATS, rather than calculating mean depth and
                        mapq. Much faster, but provides less information.
                        Default is False
```


## xyalign_characterize_sex_chroms

### Tool Description
XYalign

### Metadata
- **Docker Image**: quay.io/biocontainers/xyalign:1.1.5--py_1
- **Homepage**: https://github.com/WilsonSayresLab/XYalign
- **Package**: https://anaconda.org/channels/bioconda/packages/xyalign/overview
- **Validation**: PASS

### Original Help Text
```text
usage: xyalign [-h] [--bam [BAM [BAM ...]]] [--cram [CRAM [CRAM ...]]]
               [--sam [SAM [SAM ...]]] --ref REF --output_dir OUTPUT_DIR
               [--chromosomes [CHROMOSOMES [CHROMOSOMES ...]]]
               [--x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]]]
               [--y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]]]
               [--sample_id SAMPLE_ID] [--cpus CPUS] [--xmx XMX]
               [--fastq_compression {0,1,2,3,4,5,6,7,8,9}] [--single_end]
               [--version] [--no_cleanup]
               [--PREPARE_REFERENCE | --CHROM_STATS | --ANALYZE_BAM | --CHARACTERIZE_SEX_CHROMS | --REMAPPING | --STRIP_READS]
               [--logfile LOGFILE]
               [--reporting_level {DEBUG,INFO,ERROR,CRITICAL}]
               [--platypus_path PLATYPUS_PATH] [--bwa_path BWA_PATH]
               [--samtools_path SAMTOOLS_PATH] [--repairsh_path REPAIRSH_PATH]
               [--shufflesh_path SHUFFLESH_PATH]
               [--sambamba_path SAMBAMBA_PATH] [--bedtools_path BEDTOOLS_PATH]
               [--platypus_calling {both,none,before,after}]
               [--no_variant_plots] [--no_bam_analysis]
               [--skip_compatibility_check] [--no_perm_test] [--no_ks_test]
               [--no_bootstrap] [--variant_site_quality VARIANT_SITE_QUALITY]
               [--variant_genotype_quality VARIANT_GENOTYPE_QUALITY]
               [--variant_depth VARIANT_DEPTH]
               [--platypus_logfile PLATYPUS_LOGFILE]
               [--homogenize_read_balance HOMOGENIZE_READ_BALANCE]
               [--min_variant_count MIN_VARIANT_COUNT]
               [--reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]]
               [--xx_ref_out_name XX_REF_OUT_NAME]
               [--xy_ref_out_name XY_REF_OUT_NAME] [--xx_ref_out XX_REF_OUT]
               [--xy_ref_out XY_REF_OUT] [--xx_ref_in XX_REF_IN]
               [--xy_ref_in XY_REF_IN] [--bwa_index BWA_INDEX]
               [--read_group_id READ_GROUP_ID] [--bwa_flags BWA_FLAGS]
               [--sex_chrom_bam_only]
               [--sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD]
               [--y_present | --y_absent] [--window_size WINDOW_SIZE]
               [--target_bed TARGET_BED] [--exact_depth]
               [--whole_genome_threshold] [--mapq_cutoff MAPQ_CUTOFF]
               [--min_depth_filter MIN_DEPTH_FILTER]
               [--max_depth_filter MAX_DEPTH_FILTER]
               [--num_permutations NUM_PERMUTATIONS]
               [--num_bootstraps NUM_BOOTSTRAPS] [--ignore_duplicates]
               [--marker_size MARKER_SIZE]
               [--marker_transparency MARKER_TRANSPARENCY]
               [--coordinate_scale COORDINATE_SCALE]
               [--include_fixed INCLUDE_FIXED] [--use_counts]

XYalign

optional arguments:
  -h, --help            show this help message and exit
  --bam [BAM [BAM ...]]
                        Full path to input bam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS
  --cram [CRAM [CRAM ...]]
                        Full path to input cram files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --sam [SAM [SAM ...]]
                        Full path to input sam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --ref REF             REQUIRED. Path to reference sequence (including file
                        name).
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        REQUIRED. Output directory. XYalign will create a
                        directory structure within this directory
  --chromosomes [CHROMOSOMES [CHROMOSOMES ...]], -c [CHROMOSOMES [CHROMOSOMES ...]]
                        Chromosomes to analyze (names must match reference
                        exactly). For humans, we recommend at least chr19,
                        chrX, chrY. Generally, we suggest including the sex
                        chromosomes and at least one autosome. To analyze all
                        chromosomes use '--chromosomes ALL' or '--chromosomes
                        all'.
  --x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]], -x [X_CHROMOSOME [X_CHROMOSOME ...]]
                        Names of x-linked scaffolds in reference fasta (must
                        match reference exactly).
  --y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]], -y [Y_CHROMOSOME [Y_CHROMOSOME ...]]
                        Names of y-linked scaffolds in reference fasta (must
                        match reference exactly). Defaults to chrY. Give None
                        if using an assembly without a Y chromosome
  --sample_id SAMPLE_ID, -id SAMPLE_ID
                        Name/ID of sample - for use in plot titles and file
                        naming. Default is sample
  --cpus CPUS           Number of cores/threads to use. Default is 1
  --xmx XMX             Memory to be provided to java programs via -Xmx. E.g.,
                        use the flag '--xmx 4g' to pass '-Xmx4g' as a flag
                        when running java programs (currently just repair.sh).
                        Default is 'None' (i.e., nothing provided on the
                        command line), which will allow repair.sh to
                        automatically allocate memory. Note that if you're
                        using --STRIP_READS on deep coverage whole genome
                        data, you might need quite a bit of memory, e.g. '--
                        xmx 16g', '--xmx 32g', or more depending on how many
                        reads are present per read group.
  --fastq_compression {0,1,2,3,4,5,6,7,8,9}
                        Compression level for fastqs output from repair.sh.
                        Between (inclusive) 0 and 9. Default is 3. 1 through 9
                        indicate compression levels. If 0, fastqs will be
                        uncompressed.
  --single_end          Include flag if reads are single-end and NOT paired-
                        end.
  --version, -V         Print version and exit.
  --no_cleanup          Include flag to preserve temporary files.
  --PREPARE_REFERENCE   This flag will limit XYalign to only preparing
                        reference fastas for individuals with and without Y
                        chromosomes. These fastas can then be passed with each
                        sample to save subsequent processing time.
  --CHROM_STATS         This flag will limit XYalign to only analyzing
                        provided bam files for depth and mapq across entire
                        chromosomes.
  --ANALYZE_BAM         This flag will limit XYalign to only analyzing the bam
                        file for depth, mapq, and (optionally) read balance
                        and outputting plots.
  --CHARACTERIZE_SEX_CHROMS
                        This flag will limit XYalign to the steps required to
                        characterize sex chromosome content (i.e., analyzing
                        the bam for depth, mapq, and read balance and running
                        statistical tests to help infer ploidy)
  --REMAPPING           This flag will limit XYalign to only the steps
                        required to strip reads and remap to masked
                        references. If masked references are not provided,
                        they will be created.
  --STRIP_READS         This flag will limit XYalign to only the steps
                        required to strip reads from a provided bam file.
  --logfile LOGFILE     Name of logfile. Will overwrite if exists. Default is
                        sample_xyalign.log
  --reporting_level {DEBUG,INFO,ERROR,CRITICAL}
                        Set level of messages printed to console. Default is
                        'INFO'. Choose from (in decreasing amount of
                        reporting) DEBUG, INFO, ERROR or CRITICAL
  --platypus_path PLATYPUS_PATH
                        Path to platypus. Default is 'platypus'. If platypus
                        is not directly callable (e.g., '/path/to/platypus' or
                        '/path/to/Playpus.py'), then provide path to python as
                        well (e.g., '/path/to/python /path/to/platypus'). In
                        addition, be sure provided python is version 2. See
                        the documentation for more information about setting
                        up an anaconda environment.
  --bwa_path BWA_PATH   Path to bwa. Default is 'bwa'
  --samtools_path SAMTOOLS_PATH
                        Path to samtools. Default is 'samtools'
  --repairsh_path REPAIRSH_PATH
                        Path to bbmap's repair.sh script. Default is
                        'repair.sh'
  --shufflesh_path SHUFFLESH_PATH
                        Path to bbmap's shuffle.sh script. Default is
                        'shuffle.sh'
  --sambamba_path SAMBAMBA_PATH
                        Path to sambamba. Default is 'sambamba'
  --bedtools_path BEDTOOLS_PATH
                        Path to bedtools. Default is 'bedtools'
  --platypus_calling {both,none,before,after}
                        Platypus calling withing the pipeline (before
                        processing, after processing, both, or neither).
                        Options: both, none, before, after.
  --no_variant_plots    Include flag to prevent plotting read balance from VCF
                        files.
  --no_bam_analysis     Include flag to prevent depth/mapq analysis of bam
                        file. Used to isolate platypus_calling.
  --skip_compatibility_check
                        Include flag to prevent check of compatibility between
                        input bam and reference fasta
  --no_perm_test        Include flag to turn off permutation tests.
  --no_ks_test          Include flag to turn off KS Two Sample tests.
  --no_bootstrap        Include flag to turn off bootstrap analyses. Requires
                        either --y_present, --y_absent, or
                        --sex_chrom_calling_threshold if running full
                        pipeline.
  --variant_site_quality VARIANT_SITE_QUALITY, -vsq VARIANT_SITE_QUALITY
                        Consider all SNPs with a site quality (QUAL) greater
                        than or equal to this value. Default is 30.
  --variant_genotype_quality VARIANT_GENOTYPE_QUALITY, -vgq VARIANT_GENOTYPE_QUALITY
                        Consider all SNPs with a sample genotype quality
                        greater than or equal to this value. Default is 30.
  --variant_depth VARIANT_DEPTH, -vd VARIANT_DEPTH
                        Consider all SNPs with a sample depth greater than or
                        equal to this value. Default is 4.
  --platypus_logfile PLATYPUS_LOGFILE
                        Prefix to use for Platypus log files. Will default to
                        the sample_id argument provided
  --homogenize_read_balance HOMOGENIZE_READ_BALANCE
                        If True, read balance values will be transformed by
                        subtracting each value from 1. For example, 0.25 and
                        0.75 would be treated equivalently. Default is False.
  --min_variant_count MIN_VARIANT_COUNT
                        Minimum number of variants in a window for the read
                        balance of that window to be plotted. Note that this
                        does not affect plotting of variant counts. Default is
                        1, though we note that many window averages will be
                        meaningless at this setting.
  --reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]
                        Bed file containing regions to replace with Ns in the
                        sex chromosome reference. Examples might include the
                        pseudoautosomal regions on the Y to force all
                        mapping/calling on those regions of the X chromosome.
                        Default is None.
  --xx_ref_out_name XX_REF_OUT_NAME
                        Desired name for masked output fasta for samples
                        WITHOUT a Y chromosome (e.g., XX, XXX, XO, etc.).
                        Defaults to 'xyalign_noY.masked.fa'. Will be output in
                        the XYalign reference directory.
  --xy_ref_out_name XY_REF_OUT_NAME
                        Desired name for masked output fasta for samples WITH
                        a Y chromosome (e.g., XY, XXY, etc.). Defaults to
                        'xyalign_withY.masked.fa'. Will be output in the
                        XYalign reference directory.
  --xx_ref_out XX_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITHOUT a Y chromosome (e.g., XX, XXX, XO,
                        etc.). Overwrites if exists. Use if you would like
                        output somewhere other than XYalign reference
                        directory. Otherwise, use --xx_ref_name.
  --xy_ref_out XY_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITH a Y chromosome (e.g., XY, XXY, etc.).
                        Overwrites if exists. Use if you would like output
                        somewhere other than XYalign reference directory.
                        Otherwise, use --xy_ref_name.
  --xx_ref_in XX_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in X0 or XX samples. Default is None. If
                        none, will produce a sample-specific reference for
                        remapping.
  --xy_ref_in XY_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in samples containing Y chromosome. Default
                        is None. If none, will produce a sample-specific
                        reference for remapping.
  --bwa_index BWA_INDEX
                        If True, index with BWA during PREPARE_REFERENCE. Only
                        relevantwhen running the PREPARE_REFERENCE module by
                        itself. Default is False.
  --read_group_id READ_GROUP_ID
                        If read groups are present in a bam file, they are
                        used by default in remapping steps. However, if read
                        groups are not present in a file, there are two
                        options for proceeding. If '--read_group_id None' is
                        provided (case sensitive), then no read groups will be
                        used in subsequent mapping steps. Otherwise, any other
                        string provided to this flag will be used as a read
                        group ID. Default is '--read_group_id xyalign'
  --bwa_flags BWA_FLAGS
                        Provide a string (in quotes, with spaces between
                        arguments) for additional flags desired for BWA
                        mapping (other than -R and -t). Example: '-M -T 20 -v
                        4'. Note that those are spaces between arguments.
  --sex_chrom_bam_only  This flag skips merging the new sex chromosome bam
                        file back into the original bam file (i.e., sex chrom
                        swapping). This will output a bam file containing only
                        the newly remapped sex chromosomes.
  --sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD
                        This is the *maximum* filtered X/Y depth ratio for an
                        individual to be considered as having heterogametic
                        sex chromsomes (e.g., XY) for the REMAPPING module of
                        XYalign. Note here that X and Y chromosomes are simply
                        the chromosomes that have been designated as X and Y
                        via --x_chromosome and --y_chromosome. Keep in mind
                        that the ideal threshold will vary according to sex
                        determination mechanism, sequence homology between the
                        sex chromosomes, reference genome, sequencing methods,
                        etc. See documentation for more detail. Default is
                        2.0, which we found to be reasonable for exome, low-
                        coverage whole-genome, and high-coverage whole-genome
                        human data.
  --y_present           Overrides sex chr estimation by XYalign and remaps
                        with Y present.
  --y_absent            Overrides sex chr estimation by XY align and remaps
                        with Y absent.
  --window_size WINDOW_SIZE, -w WINDOW_SIZE
                        Window size (integer) for sliding window calculations.
                        Default is 50000. Default is None. If set to None,
                        will use targets provided using --target_bed.
  --target_bed TARGET_BED
                        Bed file containing targets to use in sliding window
                        analyses instead of a fixed window width. Either this
                        or --window_size needs to be set. Default is None,
                        which will use window size provided with
                        --window_size. If not None, and --window_size is None,
                        analyses will use targets in provided file. Must be
                        typical bed format, 0-based indexing, with the first
                        three columns containing the chromosome name, start
                        coordinate, stop coordinate.
  --exact_depth         Calculate exact depth within windows, else use much
                        faster approximation. *Currently exact is not
                        implemented*. Default is False.
  --whole_genome_threshold
                        This flag will calculate the depth filter threshold
                        based on all values from across the genome. By
                        default, thresholds are calculated per chromosome.
  --mapq_cutoff MAPQ_CUTOFF, -mq MAPQ_CUTOFF
                        Minimum mean mapq threshold for a window to be
                        considered high quality. Default is 20.
  --min_depth_filter MIN_DEPTH_FILTER
                        Minimum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        min_depth_filter. So, a min_depth_filter of 0.2 would
                        require at least a minimum depth of 2 if the mean
                        depth was 10. Default is 0.0 to consider all windows.
  --max_depth_filter MAX_DEPTH_FILTER
                        Maximum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        max_depth_filter. So, a max_depth_filter of 4 would
                        require depths to be less than or equal to 40 if the
                        mean depth was 10. Default is 10000.0 to consider all
                        windows.
  --num_permutations NUM_PERMUTATIONS
                        Number of permutations to use for permutation
                        analyses. Default is 10000
  --num_bootstraps NUM_BOOTSTRAPS
                        Number of bootstrap replicates to use when
                        bootstrapping mean depth ratios among chromosomes.
                        Default is 10000
  --ignore_duplicates   Ignore duplicate reads in bam analyses. Default is to
                        include duplicates.
  --marker_size MARKER_SIZE
                        Marker size for genome-wide plots in matplotlib.
                        Default is 10.
  --marker_transparency MARKER_TRANSPARENCY, -mt MARKER_TRANSPARENCY
                        Transparency of markers in genome-wide plots. Alpha in
                        matplotlib. Default is 0.5
  --coordinate_scale COORDINATE_SCALE
                        For genome-wide scatter plots, divide all coordinates
                        by this value.Default is 1000000, which will plot
                        everything in megabases.
  --include_fixed INCLUDE_FIXED
                        Default is False, which removes read balances less
                        than or equal to 0.05 and equal to 1.0 for histogram
                        plotting. True will include all values. Extreme values
                        removed by default because they often swamp out the
                        signal of the rest of the distribution.
  --use_counts          If True, get counts of reads per chromosome for
                        CHROM_STATS, rather than calculating mean depth and
                        mapq. Much faster, but provides less information.
                        Default is False
```


## xyalign_remapping

### Tool Description
XYalign

### Metadata
- **Docker Image**: quay.io/biocontainers/xyalign:1.1.5--py_1
- **Homepage**: https://github.com/WilsonSayresLab/XYalign
- **Package**: https://anaconda.org/channels/bioconda/packages/xyalign/overview
- **Validation**: PASS

### Original Help Text
```text
usage: xyalign [-h] [--bam [BAM [BAM ...]]] [--cram [CRAM [CRAM ...]]]
               [--sam [SAM [SAM ...]]] --ref REF --output_dir OUTPUT_DIR
               [--chromosomes [CHROMOSOMES [CHROMOSOMES ...]]]
               [--x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]]]
               [--y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]]]
               [--sample_id SAMPLE_ID] [--cpus CPUS] [--xmx XMX]
               [--fastq_compression {0,1,2,3,4,5,6,7,8,9}] [--single_end]
               [--version] [--no_cleanup]
               [--PREPARE_REFERENCE | --CHROM_STATS | --ANALYZE_BAM | --CHARACTERIZE_SEX_CHROMS | --REMAPPING | --STRIP_READS]
               [--logfile LOGFILE]
               [--reporting_level {DEBUG,INFO,ERROR,CRITICAL}]
               [--platypus_path PLATYPUS_PATH] [--bwa_path BWA_PATH]
               [--samtools_path SAMTOOLS_PATH] [--repairsh_path REPAIRSH_PATH]
               [--shufflesh_path SHUFFLESH_PATH]
               [--sambamba_path SAMBAMBA_PATH] [--bedtools_path BEDTOOLS_PATH]
               [--platypus_calling {both,none,before,after}]
               [--no_variant_plots] [--no_bam_analysis]
               [--skip_compatibility_check] [--no_perm_test] [--no_ks_test]
               [--no_bootstrap] [--variant_site_quality VARIANT_SITE_QUALITY]
               [--variant_genotype_quality VARIANT_GENOTYPE_QUALITY]
               [--variant_depth VARIANT_DEPTH]
               [--platypus_logfile PLATYPUS_LOGFILE]
               [--homogenize_read_balance HOMOGENIZE_READ_BALANCE]
               [--min_variant_count MIN_VARIANT_COUNT]
               [--reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]]
               [--xx_ref_out_name XX_REF_OUT_NAME]
               [--xy_ref_out_name XY_REF_OUT_NAME] [--xx_ref_out XX_REF_OUT]
               [--xy_ref_out XY_REF_OUT] [--xx_ref_in XX_REF_IN]
               [--xy_ref_in XY_REF_IN] [--bwa_index BWA_INDEX]
               [--read_group_id READ_GROUP_ID] [--bwa_flags BWA_FLAGS]
               [--sex_chrom_bam_only]
               [--sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD]
               [--y_present | --y_absent] [--window_size WINDOW_SIZE]
               [--target_bed TARGET_BED] [--exact_depth]
               [--whole_genome_threshold] [--mapq_cutoff MAPQ_CUTOFF]
               [--min_depth_filter MIN_DEPTH_FILTER]
               [--max_depth_filter MAX_DEPTH_FILTER]
               [--num_permutations NUM_PERMUTATIONS]
               [--num_bootstraps NUM_BOOTSTRAPS] [--ignore_duplicates]
               [--marker_size MARKER_SIZE]
               [--marker_transparency MARKER_TRANSPARENCY]
               [--coordinate_scale COORDINATE_SCALE]
               [--include_fixed INCLUDE_FIXED] [--use_counts]

XYalign

optional arguments:
  -h, --help            show this help message and exit
  --bam [BAM [BAM ...]]
                        Full path to input bam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS
  --cram [CRAM [CRAM ...]]
                        Full path to input cram files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --sam [SAM [SAM ...]]
                        Full path to input sam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --ref REF             REQUIRED. Path to reference sequence (including file
                        name).
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        REQUIRED. Output directory. XYalign will create a
                        directory structure within this directory
  --chromosomes [CHROMOSOMES [CHROMOSOMES ...]], -c [CHROMOSOMES [CHROMOSOMES ...]]
                        Chromosomes to analyze (names must match reference
                        exactly). For humans, we recommend at least chr19,
                        chrX, chrY. Generally, we suggest including the sex
                        chromosomes and at least one autosome. To analyze all
                        chromosomes use '--chromosomes ALL' or '--chromosomes
                        all'.
  --x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]], -x [X_CHROMOSOME [X_CHROMOSOME ...]]
                        Names of x-linked scaffolds in reference fasta (must
                        match reference exactly).
  --y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]], -y [Y_CHROMOSOME [Y_CHROMOSOME ...]]
                        Names of y-linked scaffolds in reference fasta (must
                        match reference exactly). Defaults to chrY. Give None
                        if using an assembly without a Y chromosome
  --sample_id SAMPLE_ID, -id SAMPLE_ID
                        Name/ID of sample - for use in plot titles and file
                        naming. Default is sample
  --cpus CPUS           Number of cores/threads to use. Default is 1
  --xmx XMX             Memory to be provided to java programs via -Xmx. E.g.,
                        use the flag '--xmx 4g' to pass '-Xmx4g' as a flag
                        when running java programs (currently just repair.sh).
                        Default is 'None' (i.e., nothing provided on the
                        command line), which will allow repair.sh to
                        automatically allocate memory. Note that if you're
                        using --STRIP_READS on deep coverage whole genome
                        data, you might need quite a bit of memory, e.g. '--
                        xmx 16g', '--xmx 32g', or more depending on how many
                        reads are present per read group.
  --fastq_compression {0,1,2,3,4,5,6,7,8,9}
                        Compression level for fastqs output from repair.sh.
                        Between (inclusive) 0 and 9. Default is 3. 1 through 9
                        indicate compression levels. If 0, fastqs will be
                        uncompressed.
  --single_end          Include flag if reads are single-end and NOT paired-
                        end.
  --version, -V         Print version and exit.
  --no_cleanup          Include flag to preserve temporary files.
  --PREPARE_REFERENCE   This flag will limit XYalign to only preparing
                        reference fastas for individuals with and without Y
                        chromosomes. These fastas can then be passed with each
                        sample to save subsequent processing time.
  --CHROM_STATS         This flag will limit XYalign to only analyzing
                        provided bam files for depth and mapq across entire
                        chromosomes.
  --ANALYZE_BAM         This flag will limit XYalign to only analyzing the bam
                        file for depth, mapq, and (optionally) read balance
                        and outputting plots.
  --CHARACTERIZE_SEX_CHROMS
                        This flag will limit XYalign to the steps required to
                        characterize sex chromosome content (i.e., analyzing
                        the bam for depth, mapq, and read balance and running
                        statistical tests to help infer ploidy)
  --REMAPPING           This flag will limit XYalign to only the steps
                        required to strip reads and remap to masked
                        references. If masked references are not provided,
                        they will be created.
  --STRIP_READS         This flag will limit XYalign to only the steps
                        required to strip reads from a provided bam file.
  --logfile LOGFILE     Name of logfile. Will overwrite if exists. Default is
                        sample_xyalign.log
  --reporting_level {DEBUG,INFO,ERROR,CRITICAL}
                        Set level of messages printed to console. Default is
                        'INFO'. Choose from (in decreasing amount of
                        reporting) DEBUG, INFO, ERROR or CRITICAL
  --platypus_path PLATYPUS_PATH
                        Path to platypus. Default is 'platypus'. If platypus
                        is not directly callable (e.g., '/path/to/platypus' or
                        '/path/to/Playpus.py'), then provide path to python as
                        well (e.g., '/path/to/python /path/to/platypus'). In
                        addition, be sure provided python is version 2. See
                        the documentation for more information about setting
                        up an anaconda environment.
  --bwa_path BWA_PATH   Path to bwa. Default is 'bwa'
  --samtools_path SAMTOOLS_PATH
                        Path to samtools. Default is 'samtools'
  --repairsh_path REPAIRSH_PATH
                        Path to bbmap's repair.sh script. Default is
                        'repair.sh'
  --shufflesh_path SHUFFLESH_PATH
                        Path to bbmap's shuffle.sh script. Default is
                        'shuffle.sh'
  --sambamba_path SAMBAMBA_PATH
                        Path to sambamba. Default is 'sambamba'
  --bedtools_path BEDTOOLS_PATH
                        Path to bedtools. Default is 'bedtools'
  --platypus_calling {both,none,before,after}
                        Platypus calling withing the pipeline (before
                        processing, after processing, both, or neither).
                        Options: both, none, before, after.
  --no_variant_plots    Include flag to prevent plotting read balance from VCF
                        files.
  --no_bam_analysis     Include flag to prevent depth/mapq analysis of bam
                        file. Used to isolate platypus_calling.
  --skip_compatibility_check
                        Include flag to prevent check of compatibility between
                        input bam and reference fasta
  --no_perm_test        Include flag to turn off permutation tests.
  --no_ks_test          Include flag to turn off KS Two Sample tests.
  --no_bootstrap        Include flag to turn off bootstrap analyses. Requires
                        either --y_present, --y_absent, or
                        --sex_chrom_calling_threshold if running full
                        pipeline.
  --variant_site_quality VARIANT_SITE_QUALITY, -vsq VARIANT_SITE_QUALITY
                        Consider all SNPs with a site quality (QUAL) greater
                        than or equal to this value. Default is 30.
  --variant_genotype_quality VARIANT_GENOTYPE_QUALITY, -vgq VARIANT_GENOTYPE_QUALITY
                        Consider all SNPs with a sample genotype quality
                        greater than or equal to this value. Default is 30.
  --variant_depth VARIANT_DEPTH, -vd VARIANT_DEPTH
                        Consider all SNPs with a sample depth greater than or
                        equal to this value. Default is 4.
  --platypus_logfile PLATYPUS_LOGFILE
                        Prefix to use for Platypus log files. Will default to
                        the sample_id argument provided
  --homogenize_read_balance HOMOGENIZE_READ_BALANCE
                        If True, read balance values will be transformed by
                        subtracting each value from 1. For example, 0.25 and
                        0.75 would be treated equivalently. Default is False.
  --min_variant_count MIN_VARIANT_COUNT
                        Minimum number of variants in a window for the read
                        balance of that window to be plotted. Note that this
                        does not affect plotting of variant counts. Default is
                        1, though we note that many window averages will be
                        meaningless at this setting.
  --reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]
                        Bed file containing regions to replace with Ns in the
                        sex chromosome reference. Examples might include the
                        pseudoautosomal regions on the Y to force all
                        mapping/calling on those regions of the X chromosome.
                        Default is None.
  --xx_ref_out_name XX_REF_OUT_NAME
                        Desired name for masked output fasta for samples
                        WITHOUT a Y chromosome (e.g., XX, XXX, XO, etc.).
                        Defaults to 'xyalign_noY.masked.fa'. Will be output in
                        the XYalign reference directory.
  --xy_ref_out_name XY_REF_OUT_NAME
                        Desired name for masked output fasta for samples WITH
                        a Y chromosome (e.g., XY, XXY, etc.). Defaults to
                        'xyalign_withY.masked.fa'. Will be output in the
                        XYalign reference directory.
  --xx_ref_out XX_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITHOUT a Y chromosome (e.g., XX, XXX, XO,
                        etc.). Overwrites if exists. Use if you would like
                        output somewhere other than XYalign reference
                        directory. Otherwise, use --xx_ref_name.
  --xy_ref_out XY_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITH a Y chromosome (e.g., XY, XXY, etc.).
                        Overwrites if exists. Use if you would like output
                        somewhere other than XYalign reference directory.
                        Otherwise, use --xy_ref_name.
  --xx_ref_in XX_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in X0 or XX samples. Default is None. If
                        none, will produce a sample-specific reference for
                        remapping.
  --xy_ref_in XY_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in samples containing Y chromosome. Default
                        is None. If none, will produce a sample-specific
                        reference for remapping.
  --bwa_index BWA_INDEX
                        If True, index with BWA during PREPARE_REFERENCE. Only
                        relevantwhen running the PREPARE_REFERENCE module by
                        itself. Default is False.
  --read_group_id READ_GROUP_ID
                        If read groups are present in a bam file, they are
                        used by default in remapping steps. However, if read
                        groups are not present in a file, there are two
                        options for proceeding. If '--read_group_id None' is
                        provided (case sensitive), then no read groups will be
                        used in subsequent mapping steps. Otherwise, any other
                        string provided to this flag will be used as a read
                        group ID. Default is '--read_group_id xyalign'
  --bwa_flags BWA_FLAGS
                        Provide a string (in quotes, with spaces between
                        arguments) for additional flags desired for BWA
                        mapping (other than -R and -t). Example: '-M -T 20 -v
                        4'. Note that those are spaces between arguments.
  --sex_chrom_bam_only  This flag skips merging the new sex chromosome bam
                        file back into the original bam file (i.e., sex chrom
                        swapping). This will output a bam file containing only
                        the newly remapped sex chromosomes.
  --sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD
                        This is the *maximum* filtered X/Y depth ratio for an
                        individual to be considered as having heterogametic
                        sex chromsomes (e.g., XY) for the REMAPPING module of
                        XYalign. Note here that X and Y chromosomes are simply
                        the chromosomes that have been designated as X and Y
                        via --x_chromosome and --y_chromosome. Keep in mind
                        that the ideal threshold will vary according to sex
                        determination mechanism, sequence homology between the
                        sex chromosomes, reference genome, sequencing methods,
                        etc. See documentation for more detail. Default is
                        2.0, which we found to be reasonable for exome, low-
                        coverage whole-genome, and high-coverage whole-genome
                        human data.
  --y_present           Overrides sex chr estimation by XYalign and remaps
                        with Y present.
  --y_absent            Overrides sex chr estimation by XY align and remaps
                        with Y absent.
  --window_size WINDOW_SIZE, -w WINDOW_SIZE
                        Window size (integer) for sliding window calculations.
                        Default is 50000. Default is None. If set to None,
                        will use targets provided using --target_bed.
  --target_bed TARGET_BED
                        Bed file containing targets to use in sliding window
                        analyses instead of a fixed window width. Either this
                        or --window_size needs to be set. Default is None,
                        which will use window size provided with
                        --window_size. If not None, and --window_size is None,
                        analyses will use targets in provided file. Must be
                        typical bed format, 0-based indexing, with the first
                        three columns containing the chromosome name, start
                        coordinate, stop coordinate.
  --exact_depth         Calculate exact depth within windows, else use much
                        faster approximation. *Currently exact is not
                        implemented*. Default is False.
  --whole_genome_threshold
                        This flag will calculate the depth filter threshold
                        based on all values from across the genome. By
                        default, thresholds are calculated per chromosome.
  --mapq_cutoff MAPQ_CUTOFF, -mq MAPQ_CUTOFF
                        Minimum mean mapq threshold for a window to be
                        considered high quality. Default is 20.
  --min_depth_filter MIN_DEPTH_FILTER
                        Minimum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        min_depth_filter. So, a min_depth_filter of 0.2 would
                        require at least a minimum depth of 2 if the mean
                        depth was 10. Default is 0.0 to consider all windows.
  --max_depth_filter MAX_DEPTH_FILTER
                        Maximum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        max_depth_filter. So, a max_depth_filter of 4 would
                        require depths to be less than or equal to 40 if the
                        mean depth was 10. Default is 10000.0 to consider all
                        windows.
  --num_permutations NUM_PERMUTATIONS
                        Number of permutations to use for permutation
                        analyses. Default is 10000
  --num_bootstraps NUM_BOOTSTRAPS
                        Number of bootstrap replicates to use when
                        bootstrapping mean depth ratios among chromosomes.
                        Default is 10000
  --ignore_duplicates   Ignore duplicate reads in bam analyses. Default is to
                        include duplicates.
  --marker_size MARKER_SIZE
                        Marker size for genome-wide plots in matplotlib.
                        Default is 10.
  --marker_transparency MARKER_TRANSPARENCY, -mt MARKER_TRANSPARENCY
                        Transparency of markers in genome-wide plots. Alpha in
                        matplotlib. Default is 0.5
  --coordinate_scale COORDINATE_SCALE
                        For genome-wide scatter plots, divide all coordinates
                        by this value.Default is 1000000, which will plot
                        everything in megabases.
  --include_fixed INCLUDE_FIXED
                        Default is False, which removes read balances less
                        than or equal to 0.05 and equal to 1.0 for histogram
                        plotting. True will include all values. Extreme values
                        removed by default because they often swamp out the
                        signal of the rest of the distribution.
  --use_counts          If True, get counts of reads per chromosome for
                        CHROM_STATS, rather than calculating mean depth and
                        mapq. Much faster, but provides less information.
                        Default is False
```


## xyalign_strip_reads

### Tool Description
XYalign

### Metadata
- **Docker Image**: quay.io/biocontainers/xyalign:1.1.5--py_1
- **Homepage**: https://github.com/WilsonSayresLab/XYalign
- **Package**: https://anaconda.org/channels/bioconda/packages/xyalign/overview
- **Validation**: PASS

### Original Help Text
```text
usage: xyalign [-h] [--bam [BAM [BAM ...]]] [--cram [CRAM [CRAM ...]]]
               [--sam [SAM [SAM ...]]] --ref REF --output_dir OUTPUT_DIR
               [--chromosomes [CHROMOSOMES [CHROMOSOMES ...]]]
               [--x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]]]
               [--y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]]]
               [--sample_id SAMPLE_ID] [--cpus CPUS] [--xmx XMX]
               [--fastq_compression {0,1,2,3,4,5,6,7,8,9}] [--single_end]
               [--version] [--no_cleanup]
               [--PREPARE_REFERENCE | --CHROM_STATS | --ANALYZE_BAM | --CHARACTERIZE_SEX_CHROMS | --REMAPPING | --STRIP_READS]
               [--logfile LOGFILE]
               [--reporting_level {DEBUG,INFO,ERROR,CRITICAL}]
               [--platypus_path PLATYPUS_PATH] [--bwa_path BWA_PATH]
               [--samtools_path SAMTOOLS_PATH] [--repairsh_path REPAIRSH_PATH]
               [--shufflesh_path SHUFFLESH_PATH]
               [--sambamba_path SAMBAMBA_PATH] [--bedtools_path BEDTOOLS_PATH]
               [--platypus_calling {both,none,before,after}]
               [--no_variant_plots] [--no_bam_analysis]
               [--skip_compatibility_check] [--no_perm_test] [--no_ks_test]
               [--no_bootstrap] [--variant_site_quality VARIANT_SITE_QUALITY]
               [--variant_genotype_quality VARIANT_GENOTYPE_QUALITY]
               [--variant_depth VARIANT_DEPTH]
               [--platypus_logfile PLATYPUS_LOGFILE]
               [--homogenize_read_balance HOMOGENIZE_READ_BALANCE]
               [--min_variant_count MIN_VARIANT_COUNT]
               [--reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]]
               [--xx_ref_out_name XX_REF_OUT_NAME]
               [--xy_ref_out_name XY_REF_OUT_NAME] [--xx_ref_out XX_REF_OUT]
               [--xy_ref_out XY_REF_OUT] [--xx_ref_in XX_REF_IN]
               [--xy_ref_in XY_REF_IN] [--bwa_index BWA_INDEX]
               [--read_group_id READ_GROUP_ID] [--bwa_flags BWA_FLAGS]
               [--sex_chrom_bam_only]
               [--sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD]
               [--y_present | --y_absent] [--window_size WINDOW_SIZE]
               [--target_bed TARGET_BED] [--exact_depth]
               [--whole_genome_threshold] [--mapq_cutoff MAPQ_CUTOFF]
               [--min_depth_filter MIN_DEPTH_FILTER]
               [--max_depth_filter MAX_DEPTH_FILTER]
               [--num_permutations NUM_PERMUTATIONS]
               [--num_bootstraps NUM_BOOTSTRAPS] [--ignore_duplicates]
               [--marker_size MARKER_SIZE]
               [--marker_transparency MARKER_TRANSPARENCY]
               [--coordinate_scale COORDINATE_SCALE]
               [--include_fixed INCLUDE_FIXED] [--use_counts]

XYalign

optional arguments:
  -h, --help            show this help message and exit
  --bam [BAM [BAM ...]]
                        Full path to input bam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS
  --cram [CRAM [CRAM ...]]
                        Full path to input cram files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --sam [SAM [SAM ...]]
                        Full path to input sam files. If more than one
                        provided, only the first will be used for modules
                        other than --CHROM_STATS. Not currently supported.
  --ref REF             REQUIRED. Path to reference sequence (including file
                        name).
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        REQUIRED. Output directory. XYalign will create a
                        directory structure within this directory
  --chromosomes [CHROMOSOMES [CHROMOSOMES ...]], -c [CHROMOSOMES [CHROMOSOMES ...]]
                        Chromosomes to analyze (names must match reference
                        exactly). For humans, we recommend at least chr19,
                        chrX, chrY. Generally, we suggest including the sex
                        chromosomes and at least one autosome. To analyze all
                        chromosomes use '--chromosomes ALL' or '--chromosomes
                        all'.
  --x_chromosome [X_CHROMOSOME [X_CHROMOSOME ...]], -x [X_CHROMOSOME [X_CHROMOSOME ...]]
                        Names of x-linked scaffolds in reference fasta (must
                        match reference exactly).
  --y_chromosome [Y_CHROMOSOME [Y_CHROMOSOME ...]], -y [Y_CHROMOSOME [Y_CHROMOSOME ...]]
                        Names of y-linked scaffolds in reference fasta (must
                        match reference exactly). Defaults to chrY. Give None
                        if using an assembly without a Y chromosome
  --sample_id SAMPLE_ID, -id SAMPLE_ID
                        Name/ID of sample - for use in plot titles and file
                        naming. Default is sample
  --cpus CPUS           Number of cores/threads to use. Default is 1
  --xmx XMX             Memory to be provided to java programs via -Xmx. E.g.,
                        use the flag '--xmx 4g' to pass '-Xmx4g' as a flag
                        when running java programs (currently just repair.sh).
                        Default is 'None' (i.e., nothing provided on the
                        command line), which will allow repair.sh to
                        automatically allocate memory. Note that if you're
                        using --STRIP_READS on deep coverage whole genome
                        data, you might need quite a bit of memory, e.g. '--
                        xmx 16g', '--xmx 32g', or more depending on how many
                        reads are present per read group.
  --fastq_compression {0,1,2,3,4,5,6,7,8,9}
                        Compression level for fastqs output from repair.sh.
                        Between (inclusive) 0 and 9. Default is 3. 1 through 9
                        indicate compression levels. If 0, fastqs will be
                        uncompressed.
  --single_end          Include flag if reads are single-end and NOT paired-
                        end.
  --version, -V         Print version and exit.
  --no_cleanup          Include flag to preserve temporary files.
  --PREPARE_REFERENCE   This flag will limit XYalign to only preparing
                        reference fastas for individuals with and without Y
                        chromosomes. These fastas can then be passed with each
                        sample to save subsequent processing time.
  --CHROM_STATS         This flag will limit XYalign to only analyzing
                        provided bam files for depth and mapq across entire
                        chromosomes.
  --ANALYZE_BAM         This flag will limit XYalign to only analyzing the bam
                        file for depth, mapq, and (optionally) read balance
                        and outputting plots.
  --CHARACTERIZE_SEX_CHROMS
                        This flag will limit XYalign to the steps required to
                        characterize sex chromosome content (i.e., analyzing
                        the bam for depth, mapq, and read balance and running
                        statistical tests to help infer ploidy)
  --REMAPPING           This flag will limit XYalign to only the steps
                        required to strip reads and remap to masked
                        references. If masked references are not provided,
                        they will be created.
  --STRIP_READS         This flag will limit XYalign to only the steps
                        required to strip reads from a provided bam file.
  --logfile LOGFILE     Name of logfile. Will overwrite if exists. Default is
                        sample_xyalign.log
  --reporting_level {DEBUG,INFO,ERROR,CRITICAL}
                        Set level of messages printed to console. Default is
                        'INFO'. Choose from (in decreasing amount of
                        reporting) DEBUG, INFO, ERROR or CRITICAL
  --platypus_path PLATYPUS_PATH
                        Path to platypus. Default is 'platypus'. If platypus
                        is not directly callable (e.g., '/path/to/platypus' or
                        '/path/to/Playpus.py'), then provide path to python as
                        well (e.g., '/path/to/python /path/to/platypus'). In
                        addition, be sure provided python is version 2. See
                        the documentation for more information about setting
                        up an anaconda environment.
  --bwa_path BWA_PATH   Path to bwa. Default is 'bwa'
  --samtools_path SAMTOOLS_PATH
                        Path to samtools. Default is 'samtools'
  --repairsh_path REPAIRSH_PATH
                        Path to bbmap's repair.sh script. Default is
                        'repair.sh'
  --shufflesh_path SHUFFLESH_PATH
                        Path to bbmap's shuffle.sh script. Default is
                        'shuffle.sh'
  --sambamba_path SAMBAMBA_PATH
                        Path to sambamba. Default is 'sambamba'
  --bedtools_path BEDTOOLS_PATH
                        Path to bedtools. Default is 'bedtools'
  --platypus_calling {both,none,before,after}
                        Platypus calling withing the pipeline (before
                        processing, after processing, both, or neither).
                        Options: both, none, before, after.
  --no_variant_plots    Include flag to prevent plotting read balance from VCF
                        files.
  --no_bam_analysis     Include flag to prevent depth/mapq analysis of bam
                        file. Used to isolate platypus_calling.
  --skip_compatibility_check
                        Include flag to prevent check of compatibility between
                        input bam and reference fasta
  --no_perm_test        Include flag to turn off permutation tests.
  --no_ks_test          Include flag to turn off KS Two Sample tests.
  --no_bootstrap        Include flag to turn off bootstrap analyses. Requires
                        either --y_present, --y_absent, or
                        --sex_chrom_calling_threshold if running full
                        pipeline.
  --variant_site_quality VARIANT_SITE_QUALITY, -vsq VARIANT_SITE_QUALITY
                        Consider all SNPs with a site quality (QUAL) greater
                        than or equal to this value. Default is 30.
  --variant_genotype_quality VARIANT_GENOTYPE_QUALITY, -vgq VARIANT_GENOTYPE_QUALITY
                        Consider all SNPs with a sample genotype quality
                        greater than or equal to this value. Default is 30.
  --variant_depth VARIANT_DEPTH, -vd VARIANT_DEPTH
                        Consider all SNPs with a sample depth greater than or
                        equal to this value. Default is 4.
  --platypus_logfile PLATYPUS_LOGFILE
                        Prefix to use for Platypus log files. Will default to
                        the sample_id argument provided
  --homogenize_read_balance HOMOGENIZE_READ_BALANCE
                        If True, read balance values will be transformed by
                        subtracting each value from 1. For example, 0.25 and
                        0.75 would be treated equivalently. Default is False.
  --min_variant_count MIN_VARIANT_COUNT
                        Minimum number of variants in a window for the read
                        balance of that window to be plotted. Note that this
                        does not affect plotting of variant counts. Default is
                        1, though we note that many window averages will be
                        meaningless at this setting.
  --reference_mask [REFERENCE_MASK [REFERENCE_MASK ...]]
                        Bed file containing regions to replace with Ns in the
                        sex chromosome reference. Examples might include the
                        pseudoautosomal regions on the Y to force all
                        mapping/calling on those regions of the X chromosome.
                        Default is None.
  --xx_ref_out_name XX_REF_OUT_NAME
                        Desired name for masked output fasta for samples
                        WITHOUT a Y chromosome (e.g., XX, XXX, XO, etc.).
                        Defaults to 'xyalign_noY.masked.fa'. Will be output in
                        the XYalign reference directory.
  --xy_ref_out_name XY_REF_OUT_NAME
                        Desired name for masked output fasta for samples WITH
                        a Y chromosome (e.g., XY, XXY, etc.). Defaults to
                        'xyalign_withY.masked.fa'. Will be output in the
                        XYalign reference directory.
  --xx_ref_out XX_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITHOUT a Y chromosome (e.g., XX, XXX, XO,
                        etc.). Overwrites if exists. Use if you would like
                        output somewhere other than XYalign reference
                        directory. Otherwise, use --xx_ref_name.
  --xy_ref_out XY_REF_OUT
                        Desired path to and name of masked output fasta for
                        samples WITH a Y chromosome (e.g., XY, XXY, etc.).
                        Overwrites if exists. Use if you would like output
                        somewhere other than XYalign reference directory.
                        Otherwise, use --xy_ref_name.
  --xx_ref_in XX_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in X0 or XX samples. Default is None. If
                        none, will produce a sample-specific reference for
                        remapping.
  --xy_ref_in XY_REF_IN
                        Path to preprocessed reference fasta to be used for
                        remapping in samples containing Y chromosome. Default
                        is None. If none, will produce a sample-specific
                        reference for remapping.
  --bwa_index BWA_INDEX
                        If True, index with BWA during PREPARE_REFERENCE. Only
                        relevantwhen running the PREPARE_REFERENCE module by
                        itself. Default is False.
  --read_group_id READ_GROUP_ID
                        If read groups are present in a bam file, they are
                        used by default in remapping steps. However, if read
                        groups are not present in a file, there are two
                        options for proceeding. If '--read_group_id None' is
                        provided (case sensitive), then no read groups will be
                        used in subsequent mapping steps. Otherwise, any other
                        string provided to this flag will be used as a read
                        group ID. Default is '--read_group_id xyalign'
  --bwa_flags BWA_FLAGS
                        Provide a string (in quotes, with spaces between
                        arguments) for additional flags desired for BWA
                        mapping (other than -R and -t). Example: '-M -T 20 -v
                        4'. Note that those are spaces between arguments.
  --sex_chrom_bam_only  This flag skips merging the new sex chromosome bam
                        file back into the original bam file (i.e., sex chrom
                        swapping). This will output a bam file containing only
                        the newly remapped sex chromosomes.
  --sex_chrom_calling_threshold SEX_CHROM_CALLING_THRESHOLD
                        This is the *maximum* filtered X/Y depth ratio for an
                        individual to be considered as having heterogametic
                        sex chromsomes (e.g., XY) for the REMAPPING module of
                        XYalign. Note here that X and Y chromosomes are simply
                        the chromosomes that have been designated as X and Y
                        via --x_chromosome and --y_chromosome. Keep in mind
                        that the ideal threshold will vary according to sex
                        determination mechanism, sequence homology between the
                        sex chromosomes, reference genome, sequencing methods,
                        etc. See documentation for more detail. Default is
                        2.0, which we found to be reasonable for exome, low-
                        coverage whole-genome, and high-coverage whole-genome
                        human data.
  --y_present           Overrides sex chr estimation by XYalign and remaps
                        with Y present.
  --y_absent            Overrides sex chr estimation by XY align and remaps
                        with Y absent.
  --window_size WINDOW_SIZE, -w WINDOW_SIZE
                        Window size (integer) for sliding window calculations.
                        Default is 50000. Default is None. If set to None,
                        will use targets provided using --target_bed.
  --target_bed TARGET_BED
                        Bed file containing targets to use in sliding window
                        analyses instead of a fixed window width. Either this
                        or --window_size needs to be set. Default is None,
                        which will use window size provided with
                        --window_size. If not None, and --window_size is None,
                        analyses will use targets in provided file. Must be
                        typical bed format, 0-based indexing, with the first
                        three columns containing the chromosome name, start
                        coordinate, stop coordinate.
  --exact_depth         Calculate exact depth within windows, else use much
                        faster approximation. *Currently exact is not
                        implemented*. Default is False.
  --whole_genome_threshold
                        This flag will calculate the depth filter threshold
                        based on all values from across the genome. By
                        default, thresholds are calculated per chromosome.
  --mapq_cutoff MAPQ_CUTOFF, -mq MAPQ_CUTOFF
                        Minimum mean mapq threshold for a window to be
                        considered high quality. Default is 20.
  --min_depth_filter MIN_DEPTH_FILTER
                        Minimum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        min_depth_filter. So, a min_depth_filter of 0.2 would
                        require at least a minimum depth of 2 if the mean
                        depth was 10. Default is 0.0 to consider all windows.
  --max_depth_filter MAX_DEPTH_FILTER
                        Maximum depth threshold for a window to be considered
                        high quality. Calculated as mean depth *
                        max_depth_filter. So, a max_depth_filter of 4 would
                        require depths to be less than or equal to 40 if the
                        mean depth was 10. Default is 10000.0 to consider all
                        windows.
  --num_permutations NUM_PERMUTATIONS
                        Number of permutations to use for permutation
                        analyses. Default is 10000
  --num_bootstraps NUM_BOOTSTRAPS
                        Number of bootstrap replicates to use when
                        bootstrapping mean depth ratios among chromosomes.
                        Default is 10000
  --ignore_duplicates   Ignore duplicate reads in bam analyses. Default is to
                        include duplicates.
  --marker_size MARKER_SIZE
                        Marker size for genome-wide plots in matplotlib.
                        Default is 10.
  --marker_transparency MARKER_TRANSPARENCY, -mt MARKER_TRANSPARENCY
                        Transparency of markers in genome-wide plots. Alpha in
                        matplotlib. Default is 0.5
  --coordinate_scale COORDINATE_SCALE
                        For genome-wide scatter plots, divide all coordinates
                        by this value.Default is 1000000, which will plot
                        everything in megabases.
  --include_fixed INCLUDE_FIXED
                        Default is False, which removes read balances less
                        than or equal to 0.05 and equal to 1.0 for histogram
                        plotting. True will include all values. Extreme values
                        removed by default because they often swamp out the
                        signal of the rest of the distribution.
  --use_counts          If True, get counts of reads per chromosome for
                        CHROM_STATS, rather than calculating mean depth and
                        mapq. Much faster, but provides less information.
                        Default is False
```


## Metadata
- **Skill**: not generated
