# haystack_bio CWL Generation Report

## haystack_bio_haystack_download_genome

### Tool Description
download_genome parameters

### Metadata
- **Docker Image**: quay.io/biocontainers/haystack_bio:0.5.5--0
- **Homepage**: https://github.com/rfarouni/haystack_bio
- **Package**: https://anaconda.org/channels/bioconda/packages/haystack_bio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/haystack_bio/overview
- **Total Downloads**: 30.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rfarouni/haystack_bio
- **Stars**: N/A
### Original Help Text
```text
[H A Y S T A C K   G E N O M E   D O W L O A D E R]

Version 0.5.5

usage: haystack_download_genome [-h] name

download_genome parameters

positional arguments:
  name        genome name. Example: haystack_download_genome hg19.

optional arguments:
  -h, --help  show this help message and exit
```


## haystack_bio_haystack_hotspots

### Tool Description
HAYSTACK Parameters

### Metadata
- **Docker Image**: quay.io/biocontainers/haystack_bio:0.5.5--0
- **Homepage**: https://github.com/rfarouni/haystack_bio
- **Package**: https://anaconda.org/channels/bioconda/packages/haystack_bio/overview
- **Validation**: PASS

### Original Help Text
```text
[H A Y S T A C K   H O T S P O T]

-SELECTION OF VARIABLE REGIONS-

Version 0.5.5

usage: haystack_hotspots [-h] [--output_directory OUTPUT_DIRECTORY]
                         [--bin_size BIN_SIZE] [--chrom_exclude CHROM_EXCLUDE]
                         [--th_rpm TH_RPM]
                         [--transformation {angle,log2,none}]
                         [--z_score_high Z_SCORE_HIGH]
                         [--z_score_low Z_SCORE_LOW] [--read_ext READ_EXT]
                         [--max_regions_percentage MAX_REGIONS_PERCENTAGE]
                         [--name NAME] [--blacklist BLACKLIST] [--depleted]
                         [--disable_quantile_normalization]
                         [--do_not_recompute] [--do_not_filter_bams]
                         [--input_is_bigwig] [--keep_intermediate_files]
                         [--n_processes N_PROCESSES] [--version]
                         samples_filename_or_bam_folder genome_name

HAYSTACK Parameters

positional arguments:
  samples_filename_or_bam_folder
                        A tab delimited file with in each row (1) a sample
                        name, (2) the path to the corresponding bam or bigwig
                        filename. Alternatively it is possible to specify a
                        folder containing some .bam files to analyze.
  genome_name           Genome assembly to use from UCSC (for example hg19,
                        mm9, etc.)

optional arguments:
  -h, --help            show this help message and exit
  --output_directory OUTPUT_DIRECTORY
                        Output directory (default: current directory)
  --bin_size BIN_SIZE   bin size to use(default: 500bp)
  --chrom_exclude CHROM_EXCLUDE
                        Exclude chromosomes that contain given (regex) string.
                        For example _random|chrX|chrY excludes random, X, and
                        Y chromosome regions
  --th_rpm TH_RPM       Percentile on the signal intensity to consider for the
                        hotspots (default: 99)
  --transformation {angle,log2,none}
                        Variance stabilizing transformation among: none, log2,
                        angle (default: angle)
  --z_score_high Z_SCORE_HIGH
                        z-score value to select the specific regions(default:
                        1.5)
  --z_score_low Z_SCORE_LOW
                        z-score value to select the not specific regions
                        (default: 0.25)
  --read_ext READ_EXT   Read extension in bps (default: 200)
  --max_regions_percentage MAX_REGIONS_PERCENTAGE
                        Upper bound on the % of the regions selected (default:
                        0.1, 0.0=0% 1.0=100%)
  --name NAME           Define a custom output filename for the report
  --blacklist BLACKLIST
                        Exclude blacklisted regions. Blacklisted regions are
                        not excluded by default. Use hg19 to blacklist regions
                        for the human genome build 19, otherwise provide the
                        filepath for a bed file with blacklisted regions.
  --depleted            Look for cell type specific regions with depletion of
                        signal instead of enrichment
  --disable_quantile_normalization
                        Disable quantile normalization (default: False)
  --do_not_recompute    Keep any file previously precalculated
  --do_not_filter_bams  Use BAM files as provided. Do not remove reads that
                        are unmapped, mate unmapped, not primary aligned or
                        low MAPQ reads, reads failing qc and optical
                        duplicates
  --input_is_bigwig     Use the bigwig format instead of the bam format for
                        the input. Note: The files must have extension .bw
  --keep_intermediate_files
                        keep intermediate bedgraph files
  --n_processes N_PROCESSES
                        Specify the number of processes to use. The default is
                        #cores available.
  --version             Print version and exit.
```


## haystack_bio_haystack_motifs

### Tool Description
Haystack Motifs Parameters

### Metadata
- **Docker Image**: quay.io/biocontainers/haystack_bio:0.5.5--0
- **Homepage**: https://github.com/rfarouni/haystack_bio
- **Package**: https://anaconda.org/channels/bioconda/packages/haystack_bio/overview
- **Validation**: PASS

### Original Help Text
```text
[H A Y S T A C K   M O T I F S]

-MOTIF ENRICHMENT ANALYSIS- [Luca Pinello - lpinello@jimmy.harvard.edu]

Version 0.5.5

usage: haystack_motifs [-h] [--bed_bg_filename BED_BG_FILENAME]
                       [--meme_motifs_filename MEME_MOTIFS_FILENAME]
                       [--nucleotide_bg_filename NUCLEOTIDE_BG_FILENAME]
                       [--p_value P_VALUE] [--no_c_g_correction]
                       [--c_g_bins C_G_BINS] [--mask_repetitive]
                       [--n_target_coordinates N_TARGET_COORDINATES]
                       [--use_entire_bg] [--bed_score_column BED_SCORE_COLUMN]
                       [--bg_target_ratio BG_TARGET_RATIO] [--bootstrap]
                       [--temp_directory TEMP_DIRECTORY]
                       [--no_random_sampling_target] [--name NAME]
                       [--internal_window_length INTERNAL_WINDOW_LENGTH]
                       [--window_length WINDOW_LENGTH]
                       [--min_central_enrichment MIN_CENTRAL_ENRICHMENT]
                       [--disable_ratio] [--dump]
                       [--output_directory OUTPUT_DIRECTORY]
                       [--smooth_size SMOOTH_SIZE]
                       [--gene_annotations_filename GENE_ANNOTATIONS_FILENAME]
                       [--gene_ids_to_names_filename GENE_IDS_TO_NAMES_FILENAME]
                       [--n_processes N_PROCESSES] [--version]
                       bed_target_filename genome_name

Haystack Motifs Parameters

positional arguments:
  bed_target_filename   A bed file containing the target coordinates on the
                        genome of reference
  genome_name           Genome assembly to use from UCSC (for example hg19,
                        mm9, etc.)

optional arguments:
  -h, --help            show this help message and exit
  --bed_bg_filename BED_BG_FILENAME
                        A bed file containing the backround coordinates on the
                        genome of reference (default random sampled regions
                        from the genome)
  --meme_motifs_filename MEME_MOTIFS_FILENAME
                        Motifs database in MEME format (default JASPAR CORE
                        2016)
  --nucleotide_bg_filename NUCLEOTIDE_BG_FILENAME
                        Nucleotide probability for the background in MEME
                        format (default precomupted on the Genome)
  --p_value P_VALUE     FIMO p-value for calling a motif hit significant
                        (deafult: 1e-4)
  --no_c_g_correction   Disable the matching of the C+G density of the
                        background
  --c_g_bins C_G_BINS   Number of bins for the C+G density correction
                        (default: 8)
  --mask_repetitive     Mask repetitive sequences
  --n_target_coordinates N_TARGET_COORDINATES
                        Number of target coordinates to use (default: all)
  --use_entire_bg       Use the entire background file (use only when the cg
                        correction is disabled)
  --bed_score_column BED_SCORE_COLUMN
                        Column in the bedfile that represents the score
                        (default: 5)
  --bg_target_ratio BG_TARGET_RATIO
                        Background size/Target size ratio (default: 1.0)
  --bootstrap           Enable the bootstrap if the target set or the
                        background set are too small, choices: True, False
                        (default: False)
  --temp_directory TEMP_DIRECTORY
                        Directory to store temporary files (default: /tmp)
  --no_random_sampling_target
                        Select the best --n_target_coordinates using the score
                        column from the target file instead of randomly select
                        them
  --name NAME           Define a custom output filename for the report
  --internal_window_length INTERNAL_WINDOW_LENGTH
                        Window length in bp for the enrichment (default:
                        average lenght of the target sequences)
  --window_length WINDOW_LENGTH
                        Window length in bp for the profiler
                        (default:internal_window_length*5)
  --min_central_enrichment MIN_CENTRAL_ENRICHMENT
                        Minimum central enrichment to report a motif
                        (default:>1.0)
  --disable_ratio       Disable target/bg ratio filter
  --dump                Dump all the intermediate data, choices: True, False
                        (default: False)
  --output_directory OUTPUT_DIRECTORY
                        Output directory (default: current directory)
  --smooth_size SMOOTH_SIZE
                        Size in bp for the smoothing window (default:
                        internal_window_length/4)
  --gene_annotations_filename GENE_ANNOTATIONS_FILENAME
                        Optional gene annotations file from the UCSC Genome
                        Browser in bed format to map each region to its closes
                        gene
  --gene_ids_to_names_filename GENE_IDS_TO_NAMES_FILENAME
                        Optional mapping file between gene ids to gene names
                        (relevant only if --gene_annotation_filename is used)
  --n_processes N_PROCESSES
                        Specify the number of processes to use. The default is
                        #cores available.
  --version             Print version and exit.
```


## Metadata
- **Skill**: generated
