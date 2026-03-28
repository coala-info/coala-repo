# secapr CWL Generation Report

## secapr_quality_check

### Tool Description
This script runs a fastqc test on all fastq samples in a user-provided folder and creates an overview plot

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Total Downloads**: 84.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AntonelliLab/seqcap_processor
- **Stars**: N/A
### Original Help Text
```text
usage: secapr quality_check [-h] --input INPUT [--cores CORES] --output OUTPUT

This script runs a fastqc test on all fastq samples in a user-provided folder
and creates an overview plot

optional arguments:
  -h, --help       show this help message and exit
  --input INPUT    The directory containing fastq files
  --cores CORES    Number of computational cores for parallelization of
                   computation.
  --output OUTPUT  The output directory where quality-test results will be
                   saved
```


## secapr_clean_reads

### Tool Description
Clean and trim raw Illumina read files

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr clean_reads [-h] --input INPUT --sample_annotation_file
                          SAMPLE_ANNOTATION_FILE --output OUTPUT
                          [--read_min READ_MIN]
                          [--qualified_quality_phred QUALIFIED_QUALITY_PHRED]
                          [--unqualified_percent_limit UNQUALIFIED_PERCENT_LIMIT]
                          [--cut_window_size CUT_WINDOW_SIZE]
                          [--cut_mean_quality CUT_MEAN_QUALITY]
                          [--trim_front TRIM_FRONT] [--trim_tail TRIM_TAIL]
                          [--required_read_length REQUIRED_READ_LENGTH]
                          [--disable_complexity_filter]
                          [--complexity_threshold COMPLEXITY_THRESHOLD]
                          [--disable_poly_g_trimming]
                          [--poly_g_min_len POLY_G_MIN_LEN]
                          [--disable_poly_x_trimming]
                          [--poly_x_min_len POLY_X_MIN_LEN]

Clean and trim raw Illumina read files

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The directory containing the .fastq or .fq files (raw
                        read files). Files can be zipped or unzipped.
  --sample_annotation_file SAMPLE_ANNOTATION_FILE
                        A simple comma-delimited text file containing the
                        sample names in the first column and the name-stem of
                        the corresponding fastq files in the second column
                        (file should not have any column headers).
  --output OUTPUT       The output directory where the cleaned reads will be
                        stored.
  --read_min READ_MIN   Set the minimum read count threshold. Any sample with
                        fewer reads than this minimum threshold will not be
                        processed further. Default: 400000
  --qualified_quality_phred QUALIFIED_QUALITY_PHRED
                        Specifies how accurate the match between any adapter
                        etc. sequence must be against a read. For more
                        information see trimmoatic tutorial. Default: 20
  --unqualified_percent_limit UNQUALIFIED_PERCENT_LIMIT
                        Set the maximum percent of low-quality nucleotides
                        allowed. Any read with a higher percentage of
                        unqualified (low quality) nucleotides will be
                        discarded. Default: 40
  --cut_window_size CUT_WINDOW_SIZE
                        Set the size of the moving window (in nucleotides) for
                        quality trimming. The window will start moving from
                        the end toward the beginning of the read, applying the
                        quality threshold set with the --cut_mean_quality
                        flag. Default: 5
  --cut_mean_quality CUT_MEAN_QUALITY
                        Set quality threshold for moving window. If the mean
                        quality across the window drops below this threshold,
                        the nucleotides within the window are removed (cut),
                        as well as all trailing nucleotides. Default: 20
  --trim_front TRIM_FRONT
                        Remove this number of nucleotides from the beginning
                        of each read. Default: 0
  --trim_tail TRIM_TAIL
                        Remove this number of nucleotides from the end of each
                        read. Default: 0
  --required_read_length REQUIRED_READ_LENGTH
                        Set this value to only allow reads to pass which are
                        equal to or longer than this threshold. Default: 0
  --disable_complexity_filter
                        Use this flag if you want to disable the removal of
                        low-complexity reads, e.g.
                        AAAAAAACCCCCCCCAAAAAAAAAAAAAAAAAAGGGGG (activated by
                        default).
  --complexity_threshold COMPLEXITY_THRESHOLD
                        Reads below this complexity threshold will be removed
                        (consult fastp manual for more explanation). Default:
                        10
  --disable_poly_g_trimming
                        Use this flag if you want to disable trimming of G
                        repeats at the end of the read. Poly-G read ends are
                        common when working with very short fragments.
                        (activated by default).
  --poly_g_min_len POLY_G_MIN_LEN
                        Specifies the length of the nucleotide repeat region
                        at end of read to be trimmed. Default: 7
  --disable_poly_x_trimming
                        Use this flag if you want to disable trimming of
                        nucleotide repeats of any kind at the end of the read,
                        e.g. poly-A tails (activated by default).
  --poly_x_min_len POLY_X_MIN_LEN
                        Specifies the length of the nucleotide repeat region
                        at end of read to be trimmed. Default: 7
```


## secapr_assemble_reads

### Tool Description
Assemble trimmed Illumina read files (fastq)

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr assemble_reads [-h] --input INPUT --output OUTPUT [--kmer KMER]
                             [--contig_length CONTIG_LENGTH]
                             [--max_memory MAX_MEMORY] [--cores CORES]

Assemble trimmed Illumina read files (fastq)

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         Call the folder that contains the cleaned fastq read
                        files. The fastq files should be organized in a
                        separate subfolder for each sample (default output of
                        secapr clean_reads function).
  --output OUTPUT       The output directory where results will be saved
  --kmer KMER           Set the kmer value. Provide a list of kmers for
                        Spades, e.g. "--kmer 21,33,55". Default is
                        21,33,55,77,99,127. Note that Spades only accepts
                        uneven kmer values.
  --contig_length CONTIG_LENGTH
                        Set the minimum contig length for the assembly.
                        Contigs that are shorter than this threshold will be
                        discarded.
  --max_memory MAX_MEMORY
                        Set the maximum memory to be used during assembly in
                        GB. This can be necessary when working with computing
                        nodes with limited memory or to avoid over-allocation
                        of computing resources on clusters which can in some
                        cases cause your assembly to be stopped or
                        interrupted.
  --cores CORES         For parallel processing you can set the number of
                        cores you want to run the assembly on.
```


## secapr_find_target_contigs

### Tool Description
Extract the contigs that match the reference database

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr find_target_contigs [-h] --contigs CONTIGS --reference REFERENCE
                                  --output OUTPUT
                                  [--target_length TARGET_LENGTH]
                                  [--min_identity MIN_IDENTITY]
                                  [--seed_length SEED_LENGTH]
                                  [--remove_multilocus_contigs]
                                  [--keep_paralogs]

Extract the contigs that match the reference database

optional arguments:
  -h, --help            show this help message and exit
  --contigs CONTIGS     The directory containing the assembled contigs in
                        fasta format. Alternatively you can provide a
                        directory with subfolders containing results of
                        various assembly runs (e.g. based on different kmer
                        values). In the latter case it is recommended to use
                        the --keep_paralogs flag, to avoid the majority of
                        loci being discarded as paralogous.
  --reference REFERENCE
                        The fasta-file containing the reference sequences (one
                        sequence per targeted locus).
  --output OUTPUT       The directory in which to store the extracted target
                        contigs and lastz results.
  --target_length TARGET_LENGTH
                        The required length of the matching sequence stretch
                        between contigs and target sequences. This does not
                        have to be a perfect match but can be adjusted with
                        the --min_identity flag [default=50].
  --min_identity MIN_IDENTITY
                        The minimum percent identity required for a match
                        [default=90].
  --seed_length SEED_LENGTH
                        Length of initial seed sequence for finding BLAST
                        matches. The seed has to be a perfect match between a
                        given contig and a reference locus (default=11).
  --remove_multilocus_contigs
                        Drop those contigs that match multiple exons.
  --keep_paralogs       Keep contigs for loci that are flagged as potentially
                        paralogous (multiple contigs matching same locus). The
                        longest contig will be selected for these loci.
```


## secapr_align_sequences

### Tool Description
Create multiple sequence alignments from sequence collections

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr align_sequences [-h] --sequences SEQUENCES --outdir OUTDIR
                              [--aligner {muscle,mafft}] [--exclude_ambiguous]
                              [--gap_opening_penalty GAP_OPENING_PENALTY]
                              [--gap_extension_penalty GAP_EXTENSION_PENALTY]
                              [--min_seqs_per_locus MIN_SEQS_PER_LOCUS]
                              [--no_trim]
                              [--trimal_setting {manual,gappyout,strict,strictplus}]
                              [--window_size WINDOW_SIZE]
                              [--seq_proportion SEQ_PROPORTION]
                              [--conserve_alignment_percentage CONSERVE_ALIGNMENT_PERCENTAGE]
                              [--min_length MIN_LENGTH] [--cores CORES]

Create multiple sequence alignments from sequence collections

optional arguments:
  -h, --help            show this help message and exit
  --sequences SEQUENCES
                        The fasta file containing individual sequences for
                        several samples and loci
  --outdir OUTDIR       The directory in which to store the resulting
                        alignments.
  --aligner {muscle,mafft}
                        The alignment engine to use.
  --exclude_ambiguous   Don't allow reads in alignments containing N-bases.
  --gap_opening_penalty GAP_OPENING_PENALTY
                        Set gap opening penalty for aligner.
  --gap_extension_penalty GAP_EXTENSION_PENALTY
                        Set gap extension penalty for aligner.
  --min_seqs_per_locus MIN_SEQS_PER_LOCUS
                        Minimum number of sequences required for building
                        alignment.
  --no_trim             Suppress trimming of alignments. By default secapr
                        uses trimal to trim gappy positions from alignments.
  --trimal_setting {manual,gappyout,strict,strictplus}
                        Use one of trimal automated scenarios. These will
                        overwrite all other trimming flags (see below). See
                        trimal tutorial for more info about settings.
  --window_size WINDOW_SIZE
                        Sliding window size for trimming.
  --seq_proportion SEQ_PROPORTION
                        The proportion of sequences required. All alignment
                        columns with fewer sequences will be deleted (0-1).
  --conserve_alignment_percentage CONSERVE_ALIGNMENT_PERCENTAGE
                        This setting will ensure to conserve the specified
                        percentage of the alignment when trimming (0-100).
  --min_length MIN_LENGTH
                        The minimum length of alignments to keep.
  --cores CORES         Process alignments in parallel using --cores for
                        alignment. This is the number of PHYSICAL CPUs.
```


## secapr_join_exons

### Tool Description
Join exon-alignment files belonging to the same gene

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr join_exons [-h] --input INPUT --output OUTPUT

Join exon-alignment files belonging to the same gene

optional arguments:
  -h, --help       show this help message and exit
  --input INPUT    The directory containing the fasta-alignment-files
  --output OUTPUT  The output directory where results will be saved
```


## secapr_reference_assembly

### Tool Description
Create new reference library and map raw reads against the library (reference-based assembly)

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr reference_assembly [-h] --reads READS
                                 [--reference_type {alignment-consensus,sample-specific,user-ref-lib}]
                                 --reference REFERENCE --output OUTPUT
                                 [--keep_duplicates]
                                 [--min_coverage MIN_COVERAGE] [--cores CORES]
                                 [--k K] [--w W] [--d D] [--r R] [--c C]
                                 [--a A] [--b B] [--o O] [--e E] [--l L]
                                 [--u U]

Create new reference library and map raw reads against the library (reference-
based assembly)

optional arguments:
  -h, --help            show this help message and exit
  --reads READS         Call the folder that contains the trimmed reads,
                        organized in a separate subfolder for each sample. The
                        name of the subfolder has to start with the sample
                        name, delimited with an underscore [_] (default output
                        of clean_reads function).
  --reference_type {alignment-consensus,sample-specific,user-ref-lib}
                        Please choose which type of reference you want to map
                        the samples to. "alignment-consensus" will create a
                        consensus sequence for each alignment file which will
                        be used as a reference for all samples. This is
                        recommendable when all samples are rather closely
                        related to each other. "sample-specific" will extract
                        the sample specific sequences from an alignment and
                        use these as a separate reference for each individual
                        sample. "user-ref-lib" enables to input one single
                        fasta file created by the user which will be used as a
                        reference library for all samples.
  --reference REFERENCE
                        When choosing "alignment-consensus" or "sample-
                        specific" as reference_type, this flag calls the
                        folder containing the alignment files for your target
                        loci (fasta-format). In case of "user-ref-lib" as
                        reference_type, this flag calls one single fasta file
                        that contains a user-prepared reference library which
                        will be applied to all samples.
  --output OUTPUT       The output directory where results will be safed.
  --keep_duplicates     Use this flag if you do not want to discard all
                        duplicate reads with Picard.
  --min_coverage MIN_COVERAGE
                        Set the minimum read coverage. Only positions that are
                        covered by this number of reads will be called in the
                        consensus sequence, otherwise the program will add an
                        ambiguity at this position.
  --cores CORES         Number of computational cores for parallelization of
                        computation.
  --k K                 If the part of the read that sufficiently matches the
                        reference is shorter than this threshold, it will be
                        discarded (minSeedLen).
  --w W                 Avoid introducing gaps in reads that are longer than
                        this threshold.
  --d D                 Stop extension when the difference between the best
                        and the current extension score is above |i-j|*A+INT,
                        where i and j are the current positions of the query
                        and reference, respectively, and A is the matching
                        score.
  --r R                 Trigger re-seeding for a MEM longer than
                        minSeedLen*FLOAT.
  --c C                 Discard a match if it has more than INT occurence in
                        the genome
  --a A                 Matching score. Acts as a factor enhancing any match
                        (higher value makes it less conservative = allows
                        reads that have fewer matches, since every match is
                        scored higher).
  --b B                 Mismatch penalty. The accepted mismatch rate per read
                        on length k is approximately: {.75 * exp[-log(4) *
                        B/A]}
  --o O                 Gap opening penalty
  --e E                 Gap extension penalty
  --l L                 Clipping penalty. During extension, the algorithm
                        keeps track of the best score reaching the end of
                        query. If this score is larger than the best extension
                        score minus the clipping penalty, clipping will not be
                        applied.
  --u U                 Penalty for an unpaired read pair. The lower the
                        value, the more unpaired reads will be allowed in the
                        mapping.
```


## secapr_phase_alleles

### Tool Description
Phase remapped reads form reference-based assembly into two separate alleles. Then produce consensus sequence for each allele.

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr phase_alleles [-h] --input INPUT --output OUTPUT
                            [--min_coverage MIN_COVERAGE]
                            [--reference REFERENCE]

Phase remapped reads form reference-based assembly into two separate alleles.
Then produce consensus sequence for each allele.

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         Call the folder that contains the results of the
                        reference based assembly (output of reference_assembly
                        function, containing the bam-files).
  --output OUTPUT       The output directory where results will be safed.
  --min_coverage MIN_COVERAGE
                        Set the minimum read coverage. Only positions that are
                        covered by this number of reads will be called in the
                        consensus sequence, otherwise the program will add an
                        ambiguity at this position.
  --reference REFERENCE
                        Provide the reference that was used for read-mapping.
                        If you used the alignment-consensus method, provide
                        the joined_fasta_library.fasta which is found in the
                        reference_seqs folder within the reference-assembly
                        output.
```


## secapr_add_missing_sequences

### Tool Description
This script will add dummy sequences '?' for missing taxa in each alignments,
making sure that all alignments in the input folder contain the same taxa (as
required for e.g. *BEAST)

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr add_missing_sequences [-h] --input INPUT --output OUTPUT

This script will add dummy sequences '?' for missing taxa in each alignments,
making sure that all alignments in the input folder contain the same taxa (as
required for e.g. *BEAST)

optional arguments:
  -h, --help       show this help message and exit
  --input INPUT    The directory containing fasta alignments
  --output OUTPUT  The output directory where results will be safed
```


## secapr_locus_selection

### Tool Description
Extract the n loci with the best read-coverage from you reference-based assembly (bam-files)

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr locus_selection [-h] --input INPUT --output OUTPUT [--n N]
                              [--read_cov READ_COV] [--reference REFERENCE]

Extract the n loci with the best read-coverage from you reference-based
assembly (bam-files)

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The folder with the results of the reference based
                        assembly.
  --output OUTPUT       The output directory where results will be safed.
  --n N                 The n loci that are best represented accross all
                        samples will be extracted.
  --read_cov READ_COV   The threshold for what average read coverage the
                        selected target loci should at least have.
  --reference REFERENCE
                        Path to reference library fasta file (secapr will find
                        it by itself if the reference assembly was executed
                        with secapr).
```


## secapr_automate_all

### Tool Description
This script automates the complete secapr pipeline, producing MSAs (allele, contig and BAM-consensus) from FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr automate_all [-h] --input INPUT --output OUTPUT --reference
                           REFERENCE [--setting {relaxed,medium,conservative}]
                           [--assembler {spades,abyss,trinity}]
                           [--cores CORES]

This script automates the complete secapr pipeline, producing MSAs (allele,
contig and BAM-consensus) from FASTQ files

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         The directory containing cleaned fastq files
  --output OUTPUT       The output directory where all intermediate and final
                        data files will be stored
  --reference REFERENCE
                        Provide a reference library (FASTA) containing
                        sequences for the genes of interest (required to find
                        contigs matching targeted regions).
  --setting {relaxed,medium,conservative}
                        The setting you want to run SECAPR on. "relaxed" uses
                        very non-restrictive default values (use when samples
                        are expected to differ considerably from provided
                        reference or are covering wide evolutionary range,
                        e.g. different families or orders). "conservative" is
                        very restrictive and can be used when samples are
                        closely related and match provided reference very
                        well.
  --assembler {spades,abyss,trinity}
                        The assembler to use for de-novo assembly
                        (default=spades).
  --cores CORES         Number of computational cores for parallelization of
                        computation.
```


## secapr_concatenate_alignments

### Tool Description
Concatenate mutliple alignments (MSAs) into one supermatrix

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr concatenate_alignments [-h] --input INPUT --output OUTPUT

Concatenate mutliple alignments (MSAs) into one supermatrix

optional arguments:
  -h, --help       show this help message and exit
  --input INPUT    The directory containing the fasta-alignment-files
  --output OUTPUT  The output directory where results will be safed
```


## secapr_paralogs_to_ref

### Tool Description
Align paralogous contigs with reference sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr paralogs_to_ref [-h] --extracted_target_contigs
                              EXTRACTED_TARGET_CONTIGS --contigs CONTIGS
                              --reference REFERENCE --output OUTPUT
                              [--gap_open_penalty GAP_OPEN_PENALTY]
                              [--gap_extent_penalty GAP_EXTENT_PENALTY]

Align paralogous contigs with reference sequence

optional arguments:
  -h, --help            show this help message and exit
  --extracted_target_contigs EXTRACTED_TARGET_CONTIGS
                        The directory containing the extraceted target contigs
                        and with them the info about paralogous loci (output
                        dir from find_target_contigs function).
  --contigs CONTIGS     The directory containing the assembled contigs in
                        fasta format. The paralogous contigs logged in the
                        find_target_contigs output folder will be extracted
                        from this file.
  --reference REFERENCE
                        The fasta-file containing the reference sequences that
                        were used for extracting target contigs.
  --output OUTPUT       The output directory where alignments of paralogous
                        cotnigs with reference sequences will be stored.
  --gap_open_penalty GAP_OPEN_PENALTY
                        Set the gap opening penalty for the alignments
                        (default=3).
  --gap_extent_penalty GAP_EXTENT_PENALTY
                        Set the gap extention penalty for the alignment
                        (default=1).
```


## secapr_plot_sequence_yield

### Tool Description
Plot overview of extracted sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AntonelliLab/seqcap_processor
- **Package**: https://anaconda.org/channels/bioconda/packages/secapr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: secapr plot_sequence_yield [-h] --extracted_contigs EXTRACTED_CONTIGS
                                  [--alignments ALIGNMENTS]
                                  [--read_cov READ_COV]
                                  [--coverage_norm COVERAGE_NORM] --output
                                  OUTPUT

Plot overview of extracted sequences

optional arguments:
  -h, --help            show this help message and exit
  --extracted_contigs EXTRACTED_CONTIGS
                        The directory containing the extracted target contigs
                        (output from find_target_contigs function).
  --alignments ALIGNMENTS
                        The directory containing the contig alignments.
                        Provide this path if you want to add a line to the
                        plot showing for which loci alignments could be
                        created.
  --read_cov READ_COV   The directory containing the reference assembly
                        results. Provide this path if you want to display the
                        read coverage for each locus and sample.
  --coverage_norm COVERAGE_NORM
                        Here you can adjust the color scale of the read-
                        coverage plot. This value will define the maximum of
                        the color scale, e.g. if set to '10' read-coverage of
                        10 and above will be colored black, while everything
                        below (0-10) will be stretched across the color
                        spectrum from yellow, red to black.
  --output OUTPUT       The directory in which to store the plots.
```


## Metadata
- **Skill**: generated
