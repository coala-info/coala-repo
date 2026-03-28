# savana CWL Generation Report

## savana_run

### Tool Description
Savana is a tool for structural variant detection in cancer genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/cortes-ciriano-lab/savana
- **Package**: https://anaconda.org/channels/bioconda/packages/savana/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/savana/overview
- **Total Downloads**: 111.5K
- **Last updated**: 2025-09-22
- **GitHub**: https://github.com/cortes-ciriano-lab/savana
- **Stars**: N/A
### Original Help Text
```text
███████  █████  ██    ██  █████  ███    ██  █████
██      ██   ██ ██    ██ ██   ██ ████   ██ ██   ██
███████ ███████ ██    ██ ███████ ██ ██  ██ ███████
     ██ ██   ██  ██  ██  ██   ██ ██  ██ ██ ██   ██
███████ ██   ██   ████   ██   ██ ██   ████ ██   ██

Version 1.3.6
Source: /usr/local/lib/python3.11/site-packages/savana/savana.py

usage: savana run [-h] -t [TUMOUR] -n [NORMAL] -r [REF]
                  [--ref_index [REF_INDEX]] [--contigs [CONTIGS]]
                  [--length [LENGTH]] [-s [SAMPLE]] [--mapq [MAPQ]]
                  [--buffer [BUFFER]] [--insertion_buffer [INSERTION_BUFFER]]
                  [--end_buffer [END_BUFFER]] [--min_support [MIN_SUPPORT]]
                  [--min_reads_per_cluster [MIN_READS_PER_CLUSTER]]
                  [--threads [THREADS]] --outdir [OUTDIR] [--overwrite]
                  [--keep_inv_artefact]
                  [--inv_artefact_distance [INV_ARTEFACT_DISTANCE]]
                  [--single_bnd]
                  [--single_bnd_min_length [SINGLE_BND_MIN_LENGTH]]
                  [--single_bnd_max_mapq [SINGLE_BND_MAX_MAPQ]] [--debug]
                  [--chunksize [CHUNKSIZE]]
                  [--coverage_binsize [COVERAGE_BINSIZE]]

options:
  -h, --help            show this help message and exit
  -t [TUMOUR], --tumour [TUMOUR]
                        Tumour BAM file (must have index)
  -n [NORMAL], --normal [NORMAL]
                        Normal BAM file (must have index)
  -r [REF], --ref [REF]
                        Full path to reference genome
  --ref_index [REF_INDEX]
                        Full path to reference genome fasta index (ref path +
                        ".fai" by default)
  --contigs [CONTIGS]   Contigs/chromosomes to consider. See example at
                        example/contigs.chr.hg38.txt (optional, default=All)
  --length [LENGTH]     Minimum length SV to consider (default=30)
  -s [SAMPLE], --sample [SAMPLE]
                        Name to prepend to output files (default=tumour BAM
                        filename without extension)
  --mapq [MAPQ]         Minimum MAPQ to consider a read mapped (default=5)
  --buffer [BUFFER]     Buffer when clustering adjacent potential breakpoints,
                        excepting insertions (default=10)
  --insertion_buffer [INSERTION_BUFFER]
                        Buffer when clustering adjacent potential insertion
                        breakpoints (default=250)
  --end_buffer [END_BUFFER]
                        Buffer when clustering alternate edge of potential
                        breakpoints, excepting insertions (default=50)
  --min_support [MIN_SUPPORT]
                        Minimum supporting reads for a PASS variant
                        (default=3)
  --min_reads_per_cluster [MIN_READS_PER_CLUSTER]
                        In clustering step, discard clusters with fewer than n
                        (default=3) supporting reads
  --threads [THREADS]   Number of threads to use (default=max)
  --outdir [OUTDIR]     Output directory (can exist but must be empty)
  --overwrite           Use this flag to write to output directory even if
                        files are present
  --keep_inv_artefact   Do not remove breakpoints with foldback-inversion
                        artefact pattern
  --inv_artefact_distance [INV_ARTEFACT_DISTANCE]
                        Maximum distance between alignment start/end to be
                        considered an artefact when --keep_inv_artefact is not
                        set (default=200)
  --single_bnd          Report single breakend variants in addition to
                        standard types (default=False)
  --single_bnd_min_length [SINGLE_BND_MIN_LENGTH]
                        Minimum length of single breakend to consider
                        (default=100)
  --single_bnd_max_mapq [SINGLE_BND_MAX_MAPQ]
                        Convert supplementary alignments below this threshold
                        to single breakend (default=5, must not exceed --mapq
                        argument)
  --debug               output extra debugging info and files
  --chunksize [CHUNKSIZE]
                        Chunksize to use when splitting genome for parallel
                        analysis - used to optimise memory (default=1000000)
  --coverage_binsize [COVERAGE_BINSIZE]
                        Length used for coverage bins (default=5)
```


## savana_without

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/cortes-ciriano-lab/savana
- **Package**: https://anaconda.org/channels/bioconda/packages/savana/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
███████  █████  ██    ██  █████  ███    ██  █████
██      ██   ██ ██    ██ ██   ██ ████   ██ ██   ██
███████ ███████ ██    ██ ███████ ██ ██  ██ ███████
     ██ ██   ██  ██  ██  ██   ██ ██  ██ ██ ██   ██
███████ ██   ██   ████   ██   ██ ██   ████ ██   ██

Version 1.3.6
Source: /usr/local/lib/python3.11/site-packages/savana/savana.py
```


## savana_classify

### Tool Description
Classify variants in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/cortes-ciriano-lab/savana
- **Package**: https://anaconda.org/channels/bioconda/packages/savana/overview
- **Validation**: PASS

### Original Help Text
```text
███████  █████  ██    ██  █████  ███    ██  █████
██      ██   ██ ██    ██ ██   ██ ████   ██ ██   ██
███████ ███████ ██    ██ ███████ ██ ██  ██ ███████
     ██ ██   ██  ██  ██  ██   ██ ██  ██ ██ ██   ██
███████ ██   ██   ████   ██   ██ ██   ████ ██   ██

Version 1.3.6
Source: /usr/local/lib/python3.11/site-packages/savana/savana.py

usage: savana classify [-h] --vcf [VCF] [--min_support [MIN_SUPPORT]]
                       [--min_af [MIN_AF]] [--cna_rescue [CNA_RESCUE]]
                       [--cna_rescue_distance [CNA_RESCUE_DISTANCE]] [--ont]
                       [--pb] [--predict_germline]
                       [--custom_model [CUSTOM_MODEL]]
                       [--custom_params [CUSTOM_PARAMS]] [--legacy] [-to]
                       --output [OUTPUT] [--somatic_output [SOMATIC_OUTPUT]]
                       [--germline_output [GERMLINE_OUTPUT]]
                       [--confidence [CONFIDENCE]] [--threads [THREADS]]

options:
  -h, --help            show this help message and exit
  --vcf [VCF]           VCF file to classify
  --min_support [MIN_SUPPORT]
                        Minimum supporting reads for a PASS variant
  --min_af [MIN_AF]     Minimum allele-fraction for a PASS variant
  --cna_rescue [CNA_RESCUE]
                        Copy number abberation output file for this sample
                        (used to rescue variants)
  --cna_rescue_distance [CNA_RESCUE_DISTANCE]
                        Maximum distance from a copy number abberation for a
                        variant to be rescued
  --ont                 Use the Oxford Nanopore (ONT) trained model to
                        classify variants (default)
  --pb                  Use PacBio thresholds to classify variants
  --predict_germline    Also predict germline events (reduces accuracy of
                        somatic calls for model)
  --custom_model [CUSTOM_MODEL]
                        Pickle file of custom machine-learning model
  --custom_params [CUSTOM_PARAMS]
                        JSON file of custom filtering parameters
  --legacy              Legacy lenient/strict filtering
  -to, --tumour_only    Classifying tumour-only data
  --output [OUTPUT]     Output VCF with PASS columns and CLASS added to INFO
  --somatic_output [SOMATIC_OUTPUT]
                        Output VCF containing only PASS somatic variants
  --germline_output [GERMLINE_OUTPUT]
                        Output VCF containing only PASS germline variants
  --confidence [CONFIDENCE]
                        Confidence level for mondrian conformal prediction -
                        suggested range (0.70-0.99) (not used by default)
  --threads [THREADS]   Number of threads to use
```


## savana_evaluate

### Tool Description
Evaluate VCF files by comparing them against reference VCFs and adding labels to the INFO field.

### Metadata
- **Docker Image**: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/cortes-ciriano-lab/savana
- **Package**: https://anaconda.org/channels/bioconda/packages/savana/overview
- **Validation**: PASS

### Original Help Text
```text
███████  █████  ██    ██  █████  ███    ██  █████
██      ██   ██ ██    ██ ██   ██ ████   ██ ██   ██
███████ ███████ ██    ██ ███████ ██ ██  ██ ███████
     ██ ██   ██  ██  ██  ██   ██ ██  ██ ██ ██   ██
███████ ██   ██   ████   ██   ██ ██   ████ ██   ██

Version 1.3.6
Source: /usr/local/lib/python3.11/site-packages/savana/savana.py

usage: savana evaluate [-h] --input [INPUT] --somatic [SOMATIC]
                       [--germline [GERMLINE]]
                       [--overlap_buffer [OVERLAP_BUFFER]] --output [OUTPUT]
                       [--stats [STATS]] [--curate]
                       [--qual_filter [QUAL_FILTER]]
                       [--by_support | --by_distance]

options:
  -h, --help            show this help message and exit
  --input [INPUT]       VCF file to evaluate
  --somatic [SOMATIC]   Somatic VCF file to evaluate against
  --germline [GERMLINE]
                        Germline VCF file to evaluate against (optional)
  --overlap_buffer [OVERLAP_BUFFER]
                        Buffer for considering an overlap (default=100)
  --output [OUTPUT]     Output VCF with LABEL added to INFO
  --stats [STATS]       Output file for statistics on comparison if desired
  --curate              Attempt to reduce false labels for training (allow
                        label to be used twice)
  --qual_filter [QUAL_FILTER]
                        Impose a quality filter on comparator variants
                        (default=None)
  --by_support          Comparison method: tie-break by read support
  --by_distance         Comparison method: tie-break by min. distance
                        (default)
```


## savana_train

### Tool Description
Train the model to predict germline and somatic variants (GERMLINE label must be present)

### Metadata
- **Docker Image**: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/cortes-ciriano-lab/savana
- **Package**: https://anaconda.org/channels/bioconda/packages/savana/overview
- **Validation**: PASS

### Original Help Text
```text
███████  █████  ██    ██  █████  ███    ██  █████
██      ██   ██ ██    ██ ██   ██ ████   ██ ██   ██
███████ ███████ ██    ██ ███████ ██ ██  ██ ███████
     ██ ██   ██  ██  ██  ██   ██ ██  ██ ██ ██   ██
███████ ██   ██   ████   ██   ██ ██   ████ ██   ██

Version 1.3.6
Source: /usr/local/lib/python3.11/site-packages/savana/savana.py

usage: savana train [-h] [--vcfs [VCFS]] [--recursive]
                    [--load_matrix [LOAD_MATRIX]]
                    [--save_matrix [SAVE_MATRIX]] [--test_split [TEST_SPLIT]]
                    [--germline_class] [-to] --outdir [OUTDIR] [--overwrite]
                    [--threads [THREADS]]

options:
  -h, --help            show this help message and exit
  --vcfs [VCFS]         Folder of labelled VCF files to read in
  --recursive           Search recursively through input folder for input VCFs
                        (default only one-level deep)
  --load_matrix [LOAD_MATRIX]
                        Pre-loaded pickle file of VCFs
  --save_matrix [SAVE_MATRIX]
                        Output pickle file for data matrix of VCFs
  --test_split [TEST_SPLIT]
                        Fraction of data to use for test (default=0.2)
  --germline_class      Train the model to predict germline and somatic
                        variants (GERMLINE label must be present)
  -to, --tumour_only    Training a model on tumour-only data
  --outdir [OUTDIR]     Output directory (can exist but must be empty)
  --overwrite           Use this flag to write to output directory even if
                        files are present
  --threads [THREADS]   Number of threads to use
```


## savana_cna

### Tool Description
Copy Number Aberration analysis tool

### Metadata
- **Docker Image**: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/cortes-ciriano-lab/savana
- **Package**: https://anaconda.org/channels/bioconda/packages/savana/overview
- **Validation**: PASS

### Original Help Text
```text
███████  █████  ██    ██  █████  ███    ██  █████
██      ██   ██ ██    ██ ██   ██ ████   ██ ██   ██
███████ ███████ ██    ██ ███████ ██ ██  ██ ███████
     ██ ██   ██  ██  ██  ██   ██ ██  ██ ██ ██   ██
███████ ██   ██   ████   ██   ██ ██   ████ ██   ██

Version 1.3.6
Source: /usr/local/lib/python3.11/site-packages/savana/savana.py

usage: savana cna [-h] -t [TUMOUR] [-n [NORMAL]] --ref [REF]
                  [--sample [SAMPLE]] [--cna_threads [CNA_THREADS]] --outdir
                  [OUTDIR] [--overwrite] [--tmpdir [TMPDIR]]
                  [-v SNP_VCF | -vg {1000g_hg38,1000g_t2t,1000g_hg19} | -ac ALLELE_COUNTS_HET_SNPS]
                  [-q ALLELE_MAPQ] [-mr ALLELE_MIN_READS] [-acw AC_WINDOW]
                  [-w CN_BINSIZE] [-b BLACKLIST] [-bp BREAKPOINTS]
                  [-c CHROMOSOMES [CHROMOSOMES ...]] [-rq READCOUNT_MAPQ]
                  [--no_blacklist] [-blt BL_THRESHOLD] [--no_basesfilter]
                  [-bt BASES_THRESHOLD] [-sl SMOOTHING_LEVEL] [-tr TRIM]
                  [-ms MIN_SEGMENT_SIZE] [-sf SHUFFLES] [-ps P_SEG]
                  [-pv P_VAL] [-qt QUANTILE] [--min_ploidy MIN_PLOIDY]
                  [--max_ploidy MAX_PLOIDY] [--ploidy_step PLOIDY_STEP]
                  [--min_cellularity MIN_CELLULARITY]
                  [--max_cellularity MAX_CELLULARITY]
                  [--cellularity_step CELLULARITY_STEP]
                  [--cellularity_buffer CELLULARITY_BUFFER]
                  [--overrule_cellularity OVERRULE_CELLULARITY]
                  [--distance_function {RMSD,MAD}]
                  [--distance_filter_scale_factor DISTANCE_FILTER_SCALE_FACTOR]
                  [--distance_precision DISTANCE_PRECISION]
                  [--max_proportion_zero MAX_PROPORTION_ZERO]
                  [--min_proportion_close_to_whole_number MIN_PROPORTION_CLOSE_TO_WHOLE_NUMBER]
                  [--max_distance_from_whole_number MAX_DISTANCE_FROM_WHOLE_NUMBER]
                  [--main_cn_step_change MAIN_CN_STEP_CHANGE]
                  [--min_block_size MIN_BLOCK_SIZE]
                  [--min_block_length MIN_BLOCK_LENGTH]

options:
  -h, --help            show this help message and exit
  -t [TUMOUR], --tumour [TUMOUR]
                        Tumour BAM file (must have index)
  -n [NORMAL], --normal [NORMAL]
                        Normal BAM file (must have index)
  --ref [REF]           Full path to reference genome
  --sample [SAMPLE]     Name to prepend to output files (default=tumour BAM
                        filename without extension)
  --cna_threads [CNA_THREADS]
                        Number of threads to use for CNA (default=max)
  --outdir [OUTDIR]     Output directory (can exist but must be empty)
  --overwrite           Use this flag to write to output directory even if
                        files are present
  --tmpdir [TMPDIR]     Temp directory for allele counting temp files
                        (defaults to outdir)
  -v SNP_VCF, --snp_vcf SNP_VCF
                        Path to matched normal SNP vcf file to extract
                        heterozygous SNPs for allele counting.
  -vg {1000g_hg38,1000g_t2t,1000g_hg19}, --g1000_vcf {1000g_hg38,1000g_t2t,1000g_hg19}
                        Use 1000g biallelic vcf file for allele counting
                        instead of SNP vcf from matched normal. Specify which
                        genome version to use.
  -ac ALLELE_COUNTS_HET_SNPS, --allele_counts_het_snps ALLELE_COUNTS_HET_SNPS
                        Path to allele counts of heterozygous SNPs
  -q ALLELE_MAPQ, --allele_mapq ALLELE_MAPQ
                        Mapping quality threshold for reads to be included in
                        the allele counting (default = 5)
  -mr ALLELE_MIN_READS, --allele_min_reads ALLELE_MIN_READS
                        Minimum number of reads required per het SNP site for
                        allele counting (default = 10)
  -acw AC_WINDOW, --ac_window AC_WINDOW
                        Window size for allele counting to parallelise and use
                        for purity estimation (default = 1200000; this should
                        be >=500000)
  -w CN_BINSIZE, --cn_binsize CN_BINSIZE
                        Bin window size in kbp
  -b BLACKLIST, --blacklist BLACKLIST
                        Path to the blacklist file
  -bp BREAKPOINTS, --breakpoints BREAKPOINTS
                        Path to SAVANA VCF file to incorporate savana
                        breakpoints into copy number analysis
  -c CHROMOSOMES [CHROMOSOMES ...], --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        Chromosomes to analyse. To run on all chromosomes,
                        leave unspecified (default). To run on a subset of
                        chromosomes only, specify the chromosome numbers
                        separated by spaces. For x and y chromosomes, use 23
                        and 24, respectively. E.g. use "-c 1 4 23 24" to run
                        chromosomes 1, 4, X and Y
  -rq READCOUNT_MAPQ, --readcount_mapq READCOUNT_MAPQ
                        Mapping quality threshold for reads to be included in
                        the read counting (default = 5)
  --no_blacklist
  -blt BL_THRESHOLD, --bl_threshold BL_THRESHOLD
                        Percentage overlap between bin and blacklist threshold
                        to tolerate for read counting (default = 5). Please
                        specify percentage threshold as integer, e.g. "-t 5".
                        Set "-t 0" if no overlap with blacklist is to be
                        tolerated
  --no_basesfilter
  -bt BASES_THRESHOLD, --bases_threshold BASES_THRESHOLD
                        Percentage of known bases per bin required for read
                        counting (default = 75). Please specify percentage
                        threshold as integer, e.g. "-bt 95"
  -sl SMOOTHING_LEVEL, --smoothing_level SMOOTHING_LEVEL
                        Size of neighbourhood for smoothing.
  -tr TRIM, --trim TRIM
                        Trimming percentage to be used.
  -ms MIN_SEGMENT_SIZE, --min_segment_size MIN_SEGMENT_SIZE
                        Minimum size for a segement to be considered a segment
                        (default = 5).
  -sf SHUFFLES, --shuffles SHUFFLES
                        Number of permutations (shuffles) to be performed
                        during CBS (default = 1000).
  -ps P_SEG, --p_seg P_SEG
                        p-value used to test segmentation statistic for a
                        given interval during CBS using (shuffles) number of
                        permutations (default = 0.05).
  -pv P_VAL, --p_val P_VAL
                        p-value used to test validity of candidate segments
                        from CBS using (shuffles) number of permutations
                        (default = 0.01).
  -qt QUANTILE, --quantile QUANTILE
                        Quantile of changepoint (absolute median differences
                        across all segments) used to estimate threshold for
                        segment merging (default = 0.2; set to 0 to avoid
                        segment merging).
  --min_ploidy MIN_PLOIDY
                        Minimum ploidy to be considered for copy number
                        fitting.
  --max_ploidy MAX_PLOIDY
                        Maximum ploidy to be considered for copy number
                        fitting.
  --ploidy_step PLOIDY_STEP
                        Ploidy step size for grid search space used during for
                        copy number fitting.
  --min_cellularity MIN_CELLULARITY
                        Minimum cellularity to be considered for copy number
                        fitting. If hetSNPs allele counts are provided, this
                        is estimated during copy number fitting.
                        Alternatively, a purity value can be provided if the
                        purity of the sample is already known.
  --max_cellularity MAX_CELLULARITY
                        Maximum cellularity to be considered for copy number
                        fitting. If hetSNPs allele counts are provided, this
                        is estimated during copy number fitting.
                        Alternatively, a purity value can be provided if the
                        purity of the sample is already known.
  --cellularity_step CELLULARITY_STEP
                        Cellularity step size for grid search space used
                        during for copy number fitting.
  --cellularity_buffer CELLULARITY_BUFFER
                        Cellularity buffer to define purity grid search space
                        during copy number fitting (default = 0.1).
  --overrule_cellularity OVERRULE_CELLULARITY
                        Set to sample`s purity if known. This value will
                        overrule the cellularity estimated using hetSNP allele
                        counts (not used by default).
  --distance_function {RMSD,MAD}
                        Distance function to be used for copy number fitting.
  --distance_filter_scale_factor DISTANCE_FILTER_SCALE_FACTOR
                        Distance filter scale factor to only include solutions
                        with distances < scale factor * min(distance).
  --distance_precision DISTANCE_PRECISION
                        Number of digits to round distance functions to
  --max_proportion_zero MAX_PROPORTION_ZERO
                        Maximum proportion of fitted copy numbers to be
                        tolerated in the zero or negative copy number state.
  --min_proportion_close_to_whole_number MIN_PROPORTION_CLOSE_TO_WHOLE_NUMBER
                        Minimum proportion of fitted copy numbers sufficiently
                        close to whole number to be tolerated for a given fit.
  --max_distance_from_whole_number MAX_DISTANCE_FROM_WHOLE_NUMBER
                        Distance from whole number for fitted value to be
                        considered sufficiently close to nearest copy number
                        integer.
  --main_cn_step_change MAIN_CN_STEP_CHANGE
                        Max main copy number step change across genome to be
                        considered for a given solution.
  --min_block_size MIN_BLOCK_SIZE
                        Minimum size (number of SNPs) for a genomic block to
                        be considered for purity estimation.
  --min_block_length MIN_BLOCK_LENGTH
                        Minimum length (bps) for a genomic block to be
                        considered for purity estimation.
```


## savana_to

### Tool Description
Convert BAM files to SAVANA output format

### Metadata
- **Docker Image**: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/cortes-ciriano-lab/savana
- **Package**: https://anaconda.org/channels/bioconda/packages/savana/overview
- **Validation**: PASS

### Original Help Text
```text
███████  █████  ██    ██  █████  ███    ██  █████
██      ██   ██ ██    ██ ██   ██ ████   ██ ██   ██
███████ ███████ ██    ██ ███████ ██ ██  ██ ███████
     ██ ██   ██  ██  ██  ██   ██ ██  ██ ██ ██   ██
███████ ██   ██   ████   ██   ██ ██   ████ ██   ██

Version 1.3.6
Source: /usr/local/lib/python3.11/site-packages/savana/savana.py

usage: savana to [-h] -t [TUMOUR] -r [REF] [--ref_index [REF_INDEX]]
                 [--contigs [CONTIGS]] [--length [LENGTH]] [--mapq [MAPQ]]
                 [--buffer [BUFFER]] [--insertion_buffer [INSERTION_BUFFER]]
                 [--end_buffer [END_BUFFER]]
                 [--min_reads_per_cluster [MIN_READS_PER_CLUSTER]]
                 [--threads [THREADS]] --outdir [OUTDIR] [--overwrite]
                 [-s [SAMPLE]] [--keep_inv_artefact]
                 [--inv_artefact_distance [INV_ARTEFACT_DISTANCE]]
                 [--single_bnd]
                 [--single_bnd_min_length [SINGLE_BND_MIN_LENGTH]]
                 [--single_bnd_max_mapq [SINGLE_BND_MAX_MAPQ]] [--debug]
                 [--chunksize [CHUNKSIZE]]
                 [--coverage_binsize [COVERAGE_BINSIZE]]
                 [--min_support [MIN_SUPPORT]] [--min_af [MIN_AF]]
                 [--cna_rescue [CNA_RESCUE]]
                 [--cna_rescue_distance [CNA_RESCUE_DISTANCE]]
                 [--ont | --pb | --custom_model [CUSTOM_MODEL] |
                 --custom_params [CUSTOM_PARAMS] | --legacy]
                 [--somatic_output [SOMATIC_OUTPUT]]
                 [--confidence [CONFIDENCE]] [--somatic [SOMATIC]]
                 [--overlap_buffer [OVERLAP_BUFFER]] [--curate]
                 [--qual_filter [QUAL_FILTER]] [--by_support | --by_distance]
                 [--cna_threads [CNA_THREADS]] [--tmpdir [TMPDIR]]
                 [-v SNP_VCF | -vg {1000g_t2t,1000g_hg19,1000g_hg38} | -ac ALLELE_COUNTS_HET_SNPS]
                 [-q ALLELE_MAPQ] [-mr ALLELE_MIN_READS] [-acw AC_WINDOW]
                 [-w CN_BINSIZE] [-b BLACKLIST] [-bp BREAKPOINTS]
                 [-c CHROMOSOMES [CHROMOSOMES ...]] [-rq READCOUNT_MAPQ]
                 [--no_blacklist] [-blt BL_THRESHOLD] [--no_basesfilter]
                 [-bt BASES_THRESHOLD] [-sl SMOOTHING_LEVEL] [-tr TRIM]
                 [-ms MIN_SEGMENT_SIZE] [-sf SHUFFLES] [-ps P_SEG] [-pv P_VAL]
                 [-qt QUANTILE] [--min_ploidy MIN_PLOIDY]
                 [--max_ploidy MAX_PLOIDY] [--ploidy_step PLOIDY_STEP]
                 [--min_cellularity MIN_CELLULARITY]
                 [--max_cellularity MAX_CELLULARITY]
                 [--cellularity_step CELLULARITY_STEP]
                 [--cellularity_buffer CELLULARITY_BUFFER]
                 [--overrule_cellularity OVERRULE_CELLULARITY]
                 [--distance_function {RMSD,MAD}]
                 [--distance_filter_scale_factor DISTANCE_FILTER_SCALE_FACTOR]
                 [--distance_precision DISTANCE_PRECISION]
                 [--max_proportion_zero MAX_PROPORTION_ZERO]
                 [--min_proportion_close_to_whole_number MIN_PROPORTION_CLOSE_TO_WHOLE_NUMBER]
                 [--max_distance_from_whole_number MAX_DISTANCE_FROM_WHOLE_NUMBER]
                 [--main_cn_step_change MAIN_CN_STEP_CHANGE]
                 [--min_block_size MIN_BLOCK_SIZE]
                 [--min_block_length MIN_BLOCK_LENGTH]

options:
  -h, --help            show this help message and exit
  -t [TUMOUR], --tumour [TUMOUR]
                        Tumour BAM file (must have index)
  -r [REF], --ref [REF]
                        Full path to reference genome
  --ref_index [REF_INDEX]
                        Full path to reference genome fasta index (ref path +
                        ".fai" by default)
  --contigs [CONTIGS]   Contigs/chromosomes to consider. See example at
                        example/contigs.chr.hg38.txt (optional, default=All)
  --length [LENGTH]     Minimum length SV to consider (default=30)
  --mapq [MAPQ]         Minimum MAPQ to consider a read mapped (default=5)
  --buffer [BUFFER]     Buffer when clustering adjacent potential breakpoints,
                        excepting insertions (default=10)
  --insertion_buffer [INSERTION_BUFFER]
                        Buffer when clustering adjacent potential insertion
                        breakpoints (default=250)
  --end_buffer [END_BUFFER]
                        Buffer when clustering alternate edge of potential
                        breakpoints, excepting insertions (default=50)
  --min_reads_per_cluster [MIN_READS_PER_CLUSTER]
                        In clustering step, discard clusters with fewer than n
                        (default=3) supporting reads
  --threads [THREADS]   Number of threads to use (default=max)
  --outdir [OUTDIR]     Output directory (can exist but must be empty)
  --overwrite           Use this flag to write to output directory even if
                        files are present
  -s [SAMPLE], --sample [SAMPLE]
                        Name to prepend to output files (default=tumour BAM
                        filename without extension)
  --keep_inv_artefact   Do not remove breakpoints with foldback-inversion
                        artefact pattern
  --inv_artefact_distance [INV_ARTEFACT_DISTANCE]
                        Maximum distance between alignment start/end to be
                        considered an artefact when --keep_inv_artefact is not
                        set (default=200)
  --single_bnd          Report single breakend variants in addition to
                        standard types (default=False)
  --single_bnd_min_length [SINGLE_BND_MIN_LENGTH]
                        Minimum length of single breakend to consider
                        (default=100)
  --single_bnd_max_mapq [SINGLE_BND_MAX_MAPQ]
                        Convert supplementary alignments below this threshold
                        to single breakend (default=5, must not exceed --mapq
                        argument)
  --debug               Output extra debugging info and files
  --chunksize [CHUNKSIZE]
                        Chunksize to use when splitting genome for parallel
                        analysis - used to optimise memory (default=1000000)
  --coverage_binsize [COVERAGE_BINSIZE]
                        Length used for coverage bins (default=5)
  --min_support [MIN_SUPPORT]
                        Minimum supporting reads for a PASS variant
                        (default=3)
  --min_af [MIN_AF]     Minimum allele-fraction for a PASS variant
                        (default=0.01)
  --cna_rescue [CNA_RESCUE]
                        Copy number abberation output file for this sample
                        (used to rescue variants)
  --cna_rescue_distance [CNA_RESCUE_DISTANCE]
                        Maximum distance from a copy number abberation for a
                        variant to be rescued
  --ont                 Use the Oxford Nanopore (ONT) trained model to
                        classify variants (default)
  --pb                  Use PacBio thresholds to classify variants
  --custom_model [CUSTOM_MODEL]
                        Pickle file of custom machine-learning model
  --custom_params [CUSTOM_PARAMS]
                        JSON file of custom filtering parameters
  --legacy              Use legacy lenient/strict filtering
  --somatic_output [SOMATIC_OUTPUT]
                        Output VCF with only PASS somatic variants
  --confidence [CONFIDENCE]
                        Confidence level for mondrian conformal prediction -
                        suggested range (0.70-0.99) (not used by default)
  --somatic [SOMATIC]   Somatic VCF file to evaluate against
  --overlap_buffer [OVERLAP_BUFFER]
                        Buffer for considering an overlap (default=100)
  --curate              Attempt to reduce false labels for training (allow
                        label to be used twice)
  --qual_filter [QUAL_FILTER]
                        Impose a quality filter on comparator variants
                        (default=None)
  --by_support          Comparison method: tie-break by read support
  --by_distance         Comparison method: tie-break by min. distance
                        (default)
  --cna_threads [CNA_THREADS]
                        Number of threads to use for CNA (default=max)
  --tmpdir [TMPDIR]     Temp directory for allele counting temp files
                        (defaults to outdir)
  -v SNP_VCF, --snp_vcf SNP_VCF
                        Path to SNP vcf file to extract heterozygous SNPs for
                        allele counting.
  -vg {1000g_t2t,1000g_hg19,1000g_hg38}, --g1000_vcf {1000g_t2t,1000g_hg19,1000g_hg38}
                        Use 1000g biallelic vcf file for allele counting
                        instead of SNP vcf from matched normal. Specify which
                        genome version to use.
  -ac ALLELE_COUNTS_HET_SNPS, --allele_counts_het_snps ALLELE_COUNTS_HET_SNPS
                        Path to allele counts of heterozygous SNPs
  -q ALLELE_MAPQ, --allele_mapq ALLELE_MAPQ
                        Mapping quality threshold for reads to be included in
                        the allele counting (default = 5)
  -mr ALLELE_MIN_READS, --allele_min_reads ALLELE_MIN_READS
                        Minimum number of reads required per het SNP site for
                        allele counting (default = 10)
  -acw AC_WINDOW, --ac_window AC_WINDOW
                        Window size for allele counting to parallelise
                        (default = 1200000; this should be >=500000)
  -w CN_BINSIZE, --cn_binsize CN_BINSIZE
                        Bin window size in kbp
  -b BLACKLIST, --blacklist BLACKLIST
                        Path to the blacklist file
  -bp BREAKPOINTS, --breakpoints BREAKPOINTS
                        Path to SAVANA VCF file to incorporate savana
                        breakpoints into copy number analysis
  -c CHROMOSOMES [CHROMOSOMES ...], --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        Chromosomes to analyse. To run on all chromosomes,
                        leave unspecified (default). To run on a subset of
                        chromosomes only, specify the chromosome numbers
                        separated by spaces. For x and y chromosomes, use 23
                        and 24, respectively. E.g. use "-c 1 4 23 24" to run
                        chromosomes 1, 4, X and Y
  -rq READCOUNT_MAPQ, --readcount_mapq READCOUNT_MAPQ
                        Mapping quality threshold for reads to be included in
                        the read counting (default = 5)
  --no_blacklist
  -blt BL_THRESHOLD, --bl_threshold BL_THRESHOLD
                        Percentage overlap between bin and blacklist threshold
                        to tolerate for read counting (default = 5). Please
                        specify percentage threshold as integer, e.g. "-t 5".
                        Set "-t 0" if no overlap with blacklist is to be
                        tolerated
  --no_basesfilter
  -bt BASES_THRESHOLD, --bases_threshold BASES_THRESHOLD
                        Percentage of known bases per bin required for read
                        counting (default = 75). Please specify percentage
                        threshold as integer, e.g. "-bt 95"
  -sl SMOOTHING_LEVEL, --smoothing_level SMOOTHING_LEVEL
                        Size of neighbourhood for smoothing.
  -tr TRIM, --trim TRIM
                        Trimming percentage to be used.
  -ms MIN_SEGMENT_SIZE, --min_segment_size MIN_SEGMENT_SIZE
                        Minimum size for a segement to be considered a segment
                        (default = 5).
  -sf SHUFFLES, --shuffles SHUFFLES
                        Number of permutations (shuffles) to be performed
                        during CBS (default = 1000).
  -ps P_SEG, --p_seg P_SEG
                        p-value used to test segmentation statistic for a
                        given interval during CBS using (shuffles) number of
                        permutations (default = 0.05).
  -pv P_VAL, --p_val P_VAL
                        p-value used to test validity of candidate segments
                        from CBS using (shuffles) number of permutations
                        (default = 0.01).
  -qt QUANTILE, --quantile QUANTILE
                        Quantile of changepoint (absolute median differences
                        across all segments) used to estimate threshold for
                        segment merging (default = 0.2; set to 0 to avoid
                        segment merging).
  --min_ploidy MIN_PLOIDY
                        Minimum ploidy to be considered for copy number
                        fitting.
  --max_ploidy MAX_PLOIDY
                        Maximum ploidy to be considered for copy number
                        fitting.
  --ploidy_step PLOIDY_STEP
                        Ploidy step size for grid search space used during for
                        copy number fitting.
  --min_cellularity MIN_CELLULARITY
                        Minimum cellularity to be considered for copy number
                        fitting. If hetSNPs allele counts are provided, this
                        is estimated during copy number fitting.
                        Alternatively, a purity value can be provided if the
                        purity of the sample is already known.
  --max_cellularity MAX_CELLULARITY
                        Maximum cellularity to be considered for copy number
                        fitting. If hetSNPs allele counts are provided, this
                        is estimated during copy number fitting.
                        Alternatively, a purity value can be provided if the
                        purity of the sample is already known.
  --cellularity_step CELLULARITY_STEP
                        Cellularity step size for grid search space used
                        during for copy number fitting.
  --cellularity_buffer CELLULARITY_BUFFER
                        Cellularity buffer to define purity grid search space
                        during copy number fitting (default = 0.1).
  --overrule_cellularity OVERRULE_CELLULARITY
                        Set to sample`s purity if known. This value will
                        overrule the cellularity estimated using hetSNP allele
                        counts (not used by default).
  --distance_function {RMSD,MAD}
                        Distance function to be used for copy number fitting.
  --distance_filter_scale_factor DISTANCE_FILTER_SCALE_FACTOR
                        Distance filter scale factor to only include solutions
                        with distances < scale factor * min(distance).
  --distance_precision DISTANCE_PRECISION
                        Number of digits to round distance functions to
  --max_proportion_zero MAX_PROPORTION_ZERO
                        Maximum proportion of fitted copy numbers to be
                        tolerated in the zero or negative copy number state.
  --min_proportion_close_to_whole_number MIN_PROPORTION_CLOSE_TO_WHOLE_NUMBER
                        Minimum proportion of fitted copy numbers sufficiently
                        close to whole number to be tolerated for a given fit.
  --max_distance_from_whole_number MAX_DISTANCE_FROM_WHOLE_NUMBER
                        Distance from whole number for fitted value to be
                        considered sufficiently close to nearest copy number
                        integer.
  --main_cn_step_change MAIN_CN_STEP_CHANGE
                        Max main copy number step change across genome to be
                        considered for a given solution.
  --min_block_size MIN_BLOCK_SIZE
                        Minimum size (number of SNPs) for a genomic block to
                        be considered for purity estimation.
  --min_block_length MIN_BLOCK_LENGTH
                        Minimum length (bps) for a genomic block to be
                        considered for purity estimation.
```


## Metadata
- **Skill**: generated
