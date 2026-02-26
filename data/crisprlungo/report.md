# crisprlungo CWL Generation Report

## crisprlungo_CRISPRlungo

### Tool Description
Analyzing unidirectional sequencing of genome editing

### Metadata
- **Docker Image**: quay.io/biocontainers/crisprlungo:0.1.14--py310h086e186_0
- **Homepage**: https://github.com/pinellolab/CRISPRlungo
- **Package**: https://anaconda.org/channels/bioconda/packages/crisprlungo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crisprlungo/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pinellolab/CRISPRlungo
- **Stars**: N/A
### Original Help Text
```text
usage: CRISPRlungo [-h] [-v] [--debug] [--root ROOT] [--keep_intermediate]
                   [--write_discarded_read_info] [--suppress_plots]
                   [--guide_sequences GUIDE_SEQUENCES [GUIDE_SEQUENCES ...]]
                   [--cut_classification_annotations CUT_CLASSIFICATION_ANNOTATIONS [CUT_CLASSIFICATION_ANNOTATIONS ...]]
                   [--cut_region_annotation_file CUT_REGION_ANNOTATION_FILE]
                   [--additional_cut_site_file ADDITIONAL_CUT_SITE_FILE]
                   [--cleavage_offset CLEAVAGE_OFFSET] [--genome GENOME]
                   [--bowtie2_genome BOWTIE2_GENOME] [--fastq_r1 FASTQ_R1]
                   [--fastq_r2 FASTQ_R2] [--fastq_umi FASTQ_UMI]
                   [--novel_cut_merge_distance NOVEL_CUT_MERGE_DISTANCE]
                   [--known_cut_merge_distance KNOWN_CUT_MERGE_DISTANCE]
                   [--origin_cut_merge_distance ORIGIN_CUT_MERGE_DISTANCE]
                   [--short_indel_length_cutoff SHORT_INDEL_LENGTH_CUTOFF]
                   [--suppress_homology_detection] [--PAM PAM]
                   [--casoffinder_num_mismatches CASOFFINDER_NUM_MISMATCHES]
                   [--primer_seq PRIMER_SEQ] [--primer_in_r2]
                   [--min_primer_aln_score MIN_PRIMER_ALN_SCORE]
                   [--min_primer_length MIN_PRIMER_LENGTH]
                   [--min_read_length MIN_READ_LENGTH]
                   [--transposase_adapter_seq TRANSPOSASE_ADAPTER_SEQ]
                   [--arm_min_matched_start_bases ARM_MIN_MATCHED_START_BASES]
                   [--arm_max_clipped_bases ARM_MAX_CLIPPED_BASES]
                   [--ignore_n] [--suppress_poor_alignment_filter]
                   [--crispresso_min_count CRISPRESSO_MIN_COUNT]
                   [--crispresso_max_indel_size CRISPRESSO_MAX_INDEL_SIZE]
                   [--crispresso_min_aln_score CRISPRESSO_MIN_ALN_SCORE]
                   [--crispresso_quant_window_size CRISPRESSO_QUANT_WINDOW_SIZE]
                   [--run_crispresso_on_novel_sites]
                   [--cutadapt_command CUTADAPT_COMMAND]
                   [--samtools_command SAMTOOLS_COMMAND]
                   [--bowtie2_command BOWTIE2_COMMAND]
                   [--crispresso_command CRISPRESSO_COMMAND]
                   [--casoffinder_command CASOFFINDER_COMMAND]
                   [--n_processes N_PROCESSES] [--dedup_input_on_UMI]
                   [--suppress_dedup_on_aln_pos_and_UMI_filter]
                   [--dedup_by_final_cut_assignment_and_UMI]
                   [--umi_regex UMI_REGEX]
                   [--min_umi_seen_to_keep_read MIN_UMI_SEEN_TO_KEEP_READ]
                   [--write_UMI_counts]
                   [--r1_r2_support_max_distance R1_R2_SUPPORT_MAX_DISTANCE]
                   [--suppress_r2_support_filter]
                   [settings_file ...]

CRISPRlungo: Analyzing unidirectional sequencing of genome editing

positional arguments:
  settings_file         Tab-separated settings file (default: None)

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  --debug               Print debug output (default: False)
  --root ROOT, --name ROOT
                        Output directory file root (default: None)
  --keep_intermediate   If true, intermediate files are not deleted (default:
                        False)
  --write_discarded_read_info
                        If true, a file with information for discarded reads
                        is produced (default: False)
  --suppress_plots      If true, no plotting will be performed (default:
                        False)
  --guide_sequences GUIDE_SEQUENCES [GUIDE_SEQUENCES ...]
                        Spacer sequences of guides (multiple guide sequences
                        are separated by spaces). Spacer sequences must be
                        provided without the PAM sequence, but oriented so the
                        PAM would immediately follow the provided spacer
                        sequence (default: [])
  --cut_classification_annotations CUT_CLASSIFICATION_ANNOTATIONS [CUT_CLASSIFICATION_ANNOTATIONS ...]
                        User-customizable annotations for cut products in the
                        form: chr1:234:left:Custom_label (multiple annotations
                        are separated by spaces) (default: [])
  --cut_region_annotation_file CUT_REGION_ANNOTATION_FILE
                        Bed file containing regions to annotate cut sites that
                        are not otherwise annotated (e.g. fragile sites,
                        etc.). This is a tab-separated file with at least 4
                        columns: chr, start, end, and region_name. Cut sites
                        will be labeled with the following priority: 1)
                        annotation given by --cut_classification_annotations,
                        2) annotations in --additional_cut_site_file 3)
                        presence of homology to any guide 4) this region
                        annotation (default: None)
  --additional_cut_site_file ADDITIONAL_CUT_SITE_FILE
                        File containing additional cut site annotations. This
                        file should have five tab-separated columns. 1)
                        chromosome of the cut site 2) position of the cut site
                        3) guide alignment orientation with respect to the
                        genome (either "FW" or "RC") 4) guide sequence not
                        including the PAM (this will be used to search for
                        homology and may be left blank) 5) cut annotation
                        (e.g. "Programmed" - this will appear in reports)
                        (default: None)
  --cleavage_offset CLEAVAGE_OFFSET
                        Position where cleavage occurs, for in-silico off-
                        target search (relative to end of spacer seq -- for
                        Cas9 this is -3) (default: -3)
  --genome GENOME       Genome sequence file for alignment. This should point
                        to a file ending in ".fa", and the accompanying index
                        file (".fai") should exist. (default: None)
  --bowtie2_genome BOWTIE2_GENOME
                        Bowtie2-indexed genome file. (default: None)
  --fastq_r1 FASTQ_R1   Input fastq r1 file. Reads in this file are primed
                        from the provided primer sequence (default: None)
  --fastq_r2 FASTQ_R2   Input fastq r2 file (default: None)
  --fastq_umi FASTQ_UMI
                        Input fastq umi file (default: None)
  --novel_cut_merge_distance NOVEL_CUT_MERGE_DISTANCE
                        Novel cut sites discovered within this distance (bp)
                        from each other (and not within
                        known_cut_merge_distance to a known/provided cut site
                        or a site with homology to guide_sequences) will be
                        merged into a single cut site. Variation in the cut
                        sites or in the fragments produced may produce
                        clusters of cut sites in a certain region. This
                        parameter will merge novel cut sites within this
                        distance into a single cut site. (default: 50)
  --known_cut_merge_distance KNOWN_CUT_MERGE_DISTANCE
                        Novel cut sites discovered within this distance (bp)
                        with a known/provided/homologous site (that is not the
                        origin) will be merged to that site. Homologous sites
                        are defined as those that have homology to
                        guide_sequences. Novel cut sites farther than
                        known_cut_merge_distance will be merged into novel cut
                        sites based on the parameter novel_cut_merge_distance.
                        (default: 50)
  --origin_cut_merge_distance ORIGIN_CUT_MERGE_DISTANCE
                        Reads aligned within this distance (bp) to the origin
                        site will be merged to that origin. (default: 10000)
  --short_indel_length_cutoff SHORT_INDEL_LENGTH_CUTOFF
                        For reads aligned to a cut site, indels this size or
                        shorter are classified as "short indels" while indels
                        larger than this size are classified as "long indels"
                        (default: 50)
  --suppress_homology_detection
                        If set, detection of guide sequence homology at cut
                        sites is skipped. By default, novel cut sites are
                        checked for homology, which can be computationally
                        demanding if there are many cut sites. (default:
                        False)

In silico off-target search parameters:
  --PAM PAM             PAM for in-silico off-target search (default: None)
  --casoffinder_num_mismatches CASOFFINDER_NUM_MISMATCHES
                        If greater than zero, the number of Cas-OFFinder
                        mismatches for in-silico off-target search. If this
                        value is zero, Cas-OFFinder is not run (default: 0)

Primer and filtering parameters and settings:
  --primer_seq PRIMER_SEQ
                        Sequence of primer (default: None)
  --primer_in_r2        If true, the primer is in R2. By default, the primer
                        is required to be in R1. (default: False)
  --min_primer_aln_score MIN_PRIMER_ALN_SCORE
                        Minimum primer/origin alignment score for trimming.
                        (default: 40)
  --min_primer_length MIN_PRIMER_LENGTH
                        Minimum length of sequence required to match between
                        the primer/origin and read sequence (default: 30)
  --min_read_length MIN_READ_LENGTH
                        Minimum length of read after all filtering (default:
                        30)
  --transposase_adapter_seq TRANSPOSASE_ADAPTER_SEQ
                        Transposase adapter sequence to be trimmed from reads
                        (default: CTGTCTCTTATACACATCTGACGCTGCCGACGA)

Alignment cutoff parameters:
  --arm_min_matched_start_bases ARM_MIN_MATCHED_START_BASES
                        Number of bases that are required to be matching (no
                        indels or mismatches) at the beginning of the read on
                        each "side" of the alignment. E.g. if
                        arm_min_matched_start_bases is set to 5, the first and
                        last 5bp of the read alignment would have to match
                        exactly to the aligned location. (default: 10)
  --arm_max_clipped_bases ARM_MAX_CLIPPED_BASES
                        Maximum number of clipped bases at the beginning of
                        the alignment. Bowtie2 alignment marks reads on the
                        beginning or end of the read as "clipped" if they do
                        not align to the genome. This could arise from CRISPR-
                        induced insertions, or bad alignments. We would expect
                        to see clipped bases only on one side. This parameter
                        sets the threshold for clipped bases on both sides of
                        the read. E.g. if arm_max_clipped_bases is 0, read
                        alignments with more than 0bp on the right AND left
                        side of the alignment would be discarded. An alignment
                        with 5bp clipped on the left and 0bp clipped on the
                        right would be accepted. An alignment with 5bp clipped
                        on the left and 3bp clipped on the right would be
                        discarded. (default: 0)
  --ignore_n            If set, "N" bases will be ignored. By default (False)
                        N bases will count as mismatches in the number of
                        bases required to match at each arm/side of the read
                        (default: False)
  --suppress_poor_alignment_filter
                        If set, reads with poor alignment (fewer than
                        --arm_min_matched_start_bases matches at the alignment
                        ends or more than --arm_max_clipped_bases on both
                        sides of the read) are included in final analysis and
                        counts. By default they are excluded. (default: False)

CRISPResso settings:
  --crispresso_min_count CRISPRESSO_MIN_COUNT
                        Min number of reads required to be seen at a site for
                        it to be analyzed by CRISPResso (default: 50)
  --crispresso_max_indel_size CRISPRESSO_MAX_INDEL_SIZE
                        Maximum length of indel (as determined by genome
                        alignment) for a read to be analyzed by CRISPResso.
                        Reads with indels longer than this length will not be
                        analyzed by CRISPResso, but the indel length will be
                        reported elsewhere. (default: 50)
  --crispresso_min_aln_score CRISPRESSO_MIN_ALN_SCORE
                        Min alignment score to reference sequence for
                        quantification by CRISPResso (default: 20)
  --crispresso_quant_window_size CRISPRESSO_QUANT_WINDOW_SIZE
                        Number of bp on each side of a cut to consider for
                        edits (default: 1)
  --run_crispresso_on_novel_sites
                        If set, CRISPResso analysis will be performed on novel
                        cut sites. If false, CRISPResso analysis will only be
                        performed on user-provided on- and off-targets
                        (default: False)

Pipeline parameters:
  --cutadapt_command CUTADAPT_COMMAND
                        Command to run cutadapt (default: cutadapt)
  --samtools_command SAMTOOLS_COMMAND
                        Command to run samtools (default: samtools)
  --bowtie2_command BOWTIE2_COMMAND
                        Command to run bowtie2 (default: bowtie2)
  --crispresso_command CRISPRESSO_COMMAND
                        Command to run crispresso (default: CRISPResso)
  --casoffinder_command CASOFFINDER_COMMAND
                        Command to run casoffinder (default: cas-offinder)
  --n_processes N_PROCESSES
                        Number of processes to run on (may be set to "max")
                        (default: 1)

UMI parameters:
  --dedup_input_on_UMI  If set, input reads will be deduplicated based on UMI
                        before alignment. Note that if this flag is set
                        deduplication by alignment position will be redundant
                        (only one read will exist with a UMI after this step).
                        This will also affect the values in the column
                        "reads_with_same_umi_pos" in the final_assignments.txt
                        file, which will only show 1 for all reads. (default:
                        False)
  --suppress_dedup_on_aln_pos_and_UMI_filter
                        If set, reads that are called as deduplicates based on
                        alignment position and UMI will be included in final
                        analysis and counts. By default, these reads are
                        excluded. (default: False)
  --dedup_by_final_cut_assignment_and_UMI
                        If set, deduplicates based on final cut assignment -
                        so that reads with the same UMI with different
                        start/stop alignment positions will be deduplicated if
                        they are assigned to the same final cut position
                        (default: False)
  --umi_regex UMI_REGEX
                        String specifying regex that UMI must match (e.g
                        NNWNNWNNN) (default: None)
  --min_umi_seen_to_keep_read MIN_UMI_SEEN_TO_KEEP_READ
                        Minimum times a UMI/read combination must be seen in
                        order to keep that for downstream analysis. If many
                        PCR cycles are performed in library preparation,
                        UMI/read combinations that are highly amplified may be
                        more trusted than UMI/read combinations that appear in
                        low abundance. However, this probably only applies for
                        sequencing libraries with members with uniform PCR
                        amplification properties. (default: 0)
  --write_UMI_counts    If set, a file will be produced containing each UMI
                        and the number of reads that were associated with that
                        UMI (default: False)

R1/R2 support settings:
  --r1_r2_support_max_distance R1_R2_SUPPORT_MAX_DISTANCE
                        Max distance between r1 and r2 for the read pair to be
                        classified as "supported" by r2 (default: 10000)
  --suppress_r2_support_filter
                        If set, reads without r2 support will be included in
                        final analysis and counts. By default these reads are
                        excluded. (default: False)
```

