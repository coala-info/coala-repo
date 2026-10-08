# detonate CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| detonate_ref-eval | PASS |  |
| detonate_ref-eval-estimate-true-assembly | PASS |  |
| detonate_rsem-eval-calculate-score | PASS |  |

## detonate_rsem-eval-calculate-score

### Tool Description
Calculates RSEM-EVAL score and expression values using alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/detonate:1.11--boost1.64_1
- **Homepage**: https://github.com/deweylab/detonate
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/detonate/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/deweylab/detonate
- **Stars**: N/A
### Original Help Text
```text
Invalid number of arguments!
NAME
    rsem-eval-calculate-score

SYNOPSIS
     rsem-eval-calculate-score [options] upstream_read_file(s) assembly_fasta_file sample_name L
     rsem-eval-calculate-score [options] --paired-end upstream_read_file(s) downstream_read_file(s) assembly_fasta_file sample_name L
     rsem-eval-calculate-score [options] --sam/--bam [--paired-end] input assembly_fasta_file sample_name L

ARGUMENTS
    upstream_read_files(s)
        Comma-separated list of files containing single-end reads or
        upstream reads for paired-end data. By default, these files are
        assumed to be in FASTQ format. If the --no-qualities option is
        specified, then FASTA format is expected.

    downstream_read_file(s)
        Comma-separated list of files containing downstream reads which are
        paired with the upstream reads. By default, these files are assumed
        to be in FASTQ format. If the --no-qualities option is specified,
        then FASTA format is expected.

    input
        SAM/BAM formatted input file. If "-" is specified for the filename,
        SAM/BAM input is instead assumed to come from standard input.
        RSEM-EVAL requires all alignments of the same read group together.
        For paired-end reads, RSEM-EVAL also requires the two mates of any
        alignment be adjacent. See Description section for how to make input
        file obey RSEM-EVAL's requirements.

    assembly_fasta_file
        A multi-FASTA file contains the assembly used for calculating
        RSEM-EVAL score.

    sample_name
        The name of the sample analyzed. All output files are prefixed by
        this name (e.g., sample_name.isoforms.results).

    L   For single-end data, L represents the average read length. For
        paired-end data, L represents the average fragment length. It should
        be a positive integer (real value will be rounded to the nearest
        integer).

BASIC OPTIONS
    --overlap-size <int>
        The minimum overlap size required to join two reads together.
        (Default: 0)

    --transcript-length-parameters <file>
        Read the true transcript length distribution's mean and standard
        deviation from <file>. This option is mutually exclusive with
        '--transcript-length-mean' and '--transcript-length-sd'. (Default:
        off)

    --transcript-length-mean <double>
        The mean of true transcript length distribution. This option is used
        together with '--transcript-length-sd' and mutually exclusive with
        '--estimate-transcript-length-distribution'. (Default: learned from
        human Ensembl annotation and hg20 genome)

    --transcript-length-sd <double>
        The standard deviation of true transcript length distribution. This
        option is used together with '--transcript-length-mean' and mutually
        exclusive with '--estimate-transcript-length-distribution'.
        (Default: learned from human Ensembl annotation and hg20 genome)

    --paired-end
        Input reads are paired-end reads. (Default: off)

    --no-qualities
        Input reads do not contain quality scores. (Default: off)

    --strand-specific
        The RNA-Seq protocol used to generate the reads is strand specific,
        i.e., all (upstream) reads are derived from the forward strand. This
        option is equivalent to --forward-prob=1.0. With this option set, if
        RSEM-EVAL runs the Bowtie/Bowtie 2 aligner, the '--norc'
        Bowtie/Bowtie 2 option will be used, which disables alignment to the
        reverse strand of transcripts. (Default: off)

    --bowtie2
        Use Bowtie 2 instead of Bowtie to align reads. Since currently
        RSEM-EVAL does not handle indel, local and discordant alignments,
        the Bowtie2 parameters are set in a way to avoid those alignments.
        In particular, we use options '--sensitive --dpad 0 --gbar 99999999
        --mp 1,1 --np 1 --score-min L,0,-0.1' by default. "-0.1", the last
        parameter of '--score-min' is the negative value of the maximum
        mismatch rate allowed. This rate can be set by option
        '--bowtie2-mismatch-rate'. If reads are paired-end, we additionally
        use options '--no-mixed' and '--no-discordant'. (Default: off)

    --sam
        Input file is in SAM format. (Default: off)

    --bam
        Input file is in BAM format. (Default: off)

    -p/--num-threads <int>
        Number of threads to use. Both Bowtie/Bowtie2, expression estimation
        and 'samtools sort' will use this many threads. (Default: 1)

    --output-bam
        Generate BAM outputs. (Default: off)

    --sampling-for-bam
        When RSEM-EVAL generates a BAM file, instead of outputing all
        alignments a read has with their posterior probabilities, one
        alignment is sampled according to the posterior probabilities. The
        sampling procedure includes the alignment to the "noise" transcript,
        which does not appear in the BAM file. Only the sampled alignment
        has a weight of 1. All other alignments have weight 0. If the
        "noise" transcript is sampled, all alignments appeared in the BAM
        file should have weight 0. (Default: off)

    --seed <uint32>
        Set the seed for the random number generators used in calculating
        posterior mean estimates and credibility intervals. The seed must be
        a non-negative 32 bit interger. (Default: off)

    -q/--quiet
        Suppress the output of logging information. (Default: off)

    -h/--help
        Show help information.

    --version
        Show version information.

ADVANCED OPTIONS
    --sam-header-info <file>
        RSEM-EVAL reads header information from input by default. If this
        option is on, header information is read from the specified file.
        For the format of the file, please see SAM official website.
        (Default: "")

    --seed-length <int>
        Seed length used by the read aligner. Providing the correct value is
        important for RSEM-EVAL. If RSEM-EVAL runs Bowtie, it uses this
        value for Bowtie's seed length parameter. Any read with its or at
        least one of its mates' (for paired-end reads) length less than this
        value will be ignored. If the references are not added poly(A)
        tails, the minimum allowed value is 5, otherwise, the minimum
        allowed value is 25. Note that this script will only check if the
        value >= 5 and give a warning message if the value < 25 but >= 5.
        (Default: 25)

    --tag <string>
        The name of the optional field used in the SAM input for identifying
        a read with too many valid alignments. The field should have the
        format <tagName>:i:<value>, where a <value> bigger than 0 indicates
        a read with too many alignments. (Default: "")

    --bowtie-path <path>
        The path to the Bowtie executables. (Default: the path to the Bowtie
        executables is assumed to be in the user's PATH environment
        variable)

    --bowtie-n <int>
        (Bowtie parameter) max # of mismatches in the seed. (Range: 0-3,
        Default: 2)

    --bowtie-e <int>
        (Bowtie parameter) max sum of mismatch quality scores across the
        alignment. (Default: 99999999)

    --bowtie-m <int>
        (Bowtie parameter) suppress all alignments for a read if > <int>
        valid alignments exist. (Default: 200)

    --bowtie-chunkmbs <int>
        (Bowtie parameter) memory allocated for best first alignment
        calculation (Default: 0 - use Bowtie's default)

    --phred33-quals
        Input quality scores are encoded as Phred+33. (Default: on)

    --phred64-quals
        Input quality scores are encoded as Phred+64 (default for GA
        Pipeline ver. >= 1.3). (Default: off)

    --solexa-quals
        Input quality scores are solexa encoded (from GA Pipeline ver. <
        1.3). (Default: off)

    --bowtie2-path <path>
        (Bowtie 2 parameter) The path to the Bowtie 2 executables. (Default:
        the path to the Bowtie 2 executables is assumed to be in the user's
        PATH environment variable)

    --bowtie2-mismatch-rate <double>
        (Bowtie 2 parameter) The maximum mismatch rate allowed. (Default:
        0.1)

    --bowtie2-k <int>
        (Bowtie 2 parameter) Find up to <int> alignments per read. (Default:
        200)

    --bowtie2-sensitivity-level <string>
        (Bowtie 2 parameter) Set Bowtie 2's preset options in --end-to-end
        mode. This option controls how hard Bowtie 2 tries to find
        alignments. <string> must be one of "very_fast", "fast", "sensitive"
        and "very_sensitive". The four candidates correspond to Bowtie 2's
        "--very-fast", "--fast", "--sensitive" and "--very-sensitive"
        options. (Default: "sensitive" - use Bowtie 2's default)

    --forward-prob <double>
        Probability of generating a read from the forward strand of a
        transcript. Set to 1 for a strand-specific protocol where all
        (upstream) reads are derived from the forward strand, 0 for a
        strand-specific protocol where all (upstream) read are derived from
        the reverse strand, or 0.5 for a non-strand-specific protocol.
        (Default: 0.5)

    --fragment-length-min <int>
        Minimum read(SE)/fragment(PE) length allowed. This is also the value
        for the Bowtie/Bowtie2 -I option. (Default: 1)

    --fragment-length-max <int>
        Maximum read(SE)/fragment(PE) length allowed. This is also the value
        for the Bowtie/Bowtie 2 -X option. (Default: 1000)

    --estimate-rspd
        Set this option if you want to estimate the read start position
        distribution (RSPD) from data. Otherwise, RSEM-EVAL will use a
        uniform RSPD. (Default: off)

    --num-rspd-bins <int>
        Number of bins in the RSPD. Only relevant when '--estimate-rspd' is
        specified. Use of the default setting is recommended. (Default: 20)

    --samtools-sort-mem <string>
        Set the maximum memory per thread that can be used by 'samtools
        sort'. <string> represents the memory and accepts suffices 'K/M/G'.
        RSEM-EVAL will pass <string> to the '-m' option of 'samtools sort'.
        Please note that the default used here is different from the default
        used by samtools. (Default: 1G)

    --keep-intermediate-files
        Keep temporary files generated by RSEM-EVAL. RSEM-EVAL creates a
        temporary directory, 'sample_name.temp', into which it puts all
        intermediate output files. If this directory already exists,
        RSEM-EVAL overwrites all files generated by previous RSEM-EVAL runs
        inside of it. By default, after RSEM-EVAL finishes, the temporary
        directory is deleted. Set this option to prevent the deletion of
        this directory and the intermediate files inside of it. (Default:
        off)

    --temporary-folder <string>
        Set where to put the temporary files generated by RSEM-EVAL. If the
        folder specified does not exist, RSEM-EVAL will try to create it.
        (Default: sample_name.temp)

    --time
        Output time consumed by each step of RSEM-EVAL to
        'sample_name.time'. (Default: off)

DESCRIPTION
    In its default mode, this program builds indices, aligns input reads
    against a reference assembly with Bowtie and calculates RSEM-EVAL score
    and expression values using the alignments. RSEM-EVAL assumes the data
    are single-end reads with quality scores, unless the '--paired-end' or
    '--no-qualities' options are specified. Users may use an alternative
    aligner by specifying one of the --sam and --bam options, and providing
    an alignment file in the specified format. However, users should make
    sure that they align against 'assembly_fasta_file' and the alignment
    file satisfies the requirements mentioned in ARGUMENTS section.

    The SAM/BAM format RSEM-EVAL uses is v1.4. However, it is compatible
    with old SAM/BAM format. However, RSEM-EVAL cannot recognize 0x100 in
    the FLAG field. In addition, RSEM-EVAL requires SEQ and QUAL are not
    '*'.

    Please note that some of the default values for the Bowtie parameters
    are not the same as those defined for Bowtie itself.

    The temporary directory and all intermediate files will be removed when
    RSEM-EVAL finishes unless '--keep-intermediate-files' is specified.

OUTPUT
    sample_name.score, sample_name.score.isoforms.results and
    sample_name.score.genes.results
        'sample_name.score' stores the evaluation score for the evaluated
        assembly. It contains 13 lines and each line contains a name and a
        value separated by a tab.

        The first 6 lines provide: 'Score', the RSEM-EVAL score;
        'BIC_penalty', the BIC penalty term;
        'Prior_score_on_contig_lengths_(f_function_canceled)', the log score
        of priors of contig lengths, with f function values excluded (f
        function is defined in equation (4) at page 5 of Additional file 1,
        which is the supplementary methods, tables and figures of our
        DETONATE paper); 'Prior_score_on_contig_sequences', the log score of
        priors of contig sequence bases;
        'Data_likelihood_in_log_space_without_correction', the RSEM log data
        likelihood calculated with contig-level read generating
        probabilities mentioned in section 4 of Additional file 1;
        'Correction_term_(f_function_canceled)', the correction term, with f
        function values excluded. Score = BIC_penalty +
        Prior_score_on_contig_lengths + Prior_score_on_contig_sequences +
        Data_likelihood_in_log_space_without_correction - Correction_term.
        Because both 'Prior_score_on_contig_lengths' and 'Correction_term'
        share the same f function values for each contig, the f function
        values can be canceled out. Then
        'Prior_score_on_contig_lengths_(f_function_canceled)' is the sum of
        log $c_{\lambda}(\ell)$ terms in equation (9) at page 5 of
        Additional file 1. 'Correction_term_(f_function_canceled)' is the
        sum of log $(1 - p_{\lambda_i})$ terms in equation (23) at page 9 of
        Additional file 1. For the correction term, we use $\lambda_i$
        instead of $\lambda'_i$ to make f function canceled out.

        The next 7 lines provide statistics that may help users to
        understand the RSEM-EVAL score better. They are:
        'Number_of_contigs', the number of contigs contained in the
        assembly; 'Expected_number_of_aligned_reads_given_the_data', the
        expected number of reads assigned to each contig estimated using the
        contig-level read generating probabilities mentioned in section 4 of
        Additional file 1;
        'Number_of_contigs_smaller_than_expected_read/fragment_length', the
        number of contigs whose length is smaller than the expected
        read/fragment length; 'Number_of_contigs_with_no_read_aligned_to',
        the number of contigs whose expected number of aligned reads is
        smaller than 0.005; 'Maximum_data_likelihood_in_log_space', the
        maximum data likelihood in log space calculated from RSEM by
        treating the assembly as "true" transcripts;
        'Number_of_alignable_reads', the number of reads that have at least
        one alignment found by the aligner (Because
        'rsem-calculate-expression' tries to use a very loose criteria to
        find alignments, reads with only low quality alignments may also be
        counted as alignable reads here); 'Number_of_alignments_in_total',
        the number of total alignments found by the aligner.

        'sample_name.score.isoforms.results' and
        'sample_name.score.genes.results' output "corrected" expression
        levels based on contig-level read generating probabilities mentioned
        in section 4 of Additional file 1. Unlike
        'sample_name.isoforms.results' and 'sample_name.genes.results',
        which are calculated by treating the contigs as true transcripts,
        calculating 'sample_name.score.isoforms.results' and
        'sample_name.score.genes.results' involves first estimating expected
        read coverage for each contig and then convert the expected read
        coverage into contig-level read generating probabilities. This
        procedure is aware of that provided sequences are contigs and gives
        better expression estimates for very short contigs. In addtion, the
        'TPM' field is changed to 'CPM' field, which stands for contig per
        million.

        For 'sample_name.score.isoforms.results', one additional column is
        added. The additional column is named as 'contig_impact_score' and
        gives the contig impact score for each contig as described in
        section 5 of Additional file 1.

    sample_name.isoforms.results
        File containing isoform level expression estimates. The first line
        contains column names separated by the tab character. The format of
        each line in the rest of this file is:

        transcript_id gene_id length effective_length expected_count TPM
        FPKM IsoPct

        Fields are separated by the tab character.

        'transcript_id' is the transcript name of this transcript. 'gene_id'
        is the gene name of the gene which this transcript belongs to
        (denote this gene as its parent gene). If no gene information is
        provided, 'gene_id' and 'transcript_id' are the same.

        'length' is this transcript's sequence length (poly(A) tail is not
        counted). 'effective_length' counts only the positions that can
        generate a valid fragment. If no poly(A) tail is added,
        'effective_length' is equal to transcript length - mean fragment
        length + 1. If one transcript's effective length is less than 1,
        this transcript's both effective length and abundance estimates are
        set to 0.

        'expected_count' is the sum of the posterior probability of each
        read comes from this transcript over all reads. Because 1) each read
        aligning to this transcript has a probability of being generated
        from background noise; 2) RSEM-EVAL may filter some alignable low
        quality reads, the sum of expected counts for all transcript are
        generally less than the total number of reads aligned.

        'TPM' stands for Transcripts Per Million. It is a relative measure
        of transcript abundance. The sum of all transcripts' TPM is 1
        million. 'FPKM' stands for Fragments Per Kilobase of transcript per
        Million mapped reads. It is another relative measure of transcript
        abundance. If we define l_bar be the mean transcript length in a
        sample, which can be calculated as

        l_bar = \sum_i TPM_i / 10^6 * effective_length_i (i goes through
        every transcript),

        the following equation is hold:

        FPKM_i = 10^3 / l_bar * TPM_i.

        We can see that the sum of FPKM is not a constant across samples.

        'IsoPct' stands for isoform percentage. It is the percentage of this
        transcript's abandunce over its parent gene's abandunce. If its
        parent gene has only one isoform or the gene information is not
        provided, this field will be set to 100.

    sample_name.genes.results
        File containing gene level expression estimates. The first line
        contains column names separated by the tab character. The format of
        each line in the rest of this file is:

        gene_id transcript_id(s) length effective_length expected_count TPM
        FPKM

        Fields are separated by the tab character.

        'transcript_id(s)' is a comma-separated list of transcript_ids
        belonging to this gene. If no gene information is provided,
        'gene_id' and 'transcript_id(s)' are identical (the
        'transcript_id').

        A gene's 'length' and 'effective_length' are defined as the weighted
        average of its transcripts' lengths and effective lengths (weighted
        by 'IsoPct'). A gene's abundance estimates are just the sum of its
        transcripts' abundance estimates.

    sample_name.transcript.bam, sample_name.transcript.sorted.bam and
    sample_name.transcript.sorted.bam.bai
        Only generated when --output-bam is specified.

        'sample_name.transcript.bam' is a BAM-formatted file of read
        alignments in transcript coordinates. The MAPQ field of each
        alignment is set to min(100, floor(-10 * log10(1.0 - w) + 0.5)),
        where w is the posterior probability of that alignment being the
        true mapping of a read. In addition, RSEM-EVAL pads a new tag
        ZW:f:value, where value is a single precision floating number
        representing the posterior probability. Because this file contains
        all alignment lines produced by bowtie or user-specified aligners,
        it can also be used as a replacement of the aligner generated
        BAM/SAM file. For paired-end reads, if one mate has alignments but
        the other does not, this file marks the alignable mate as
        "unmappable" (flag bit 0x4) and appends an optional field "Z0:A:!".

        'sample_name.transcript.sorted.bam' and
        'sample_name.transcript.sorted.bam.bai' are the sorted BAM file and
        indices generated by samtools (included in RSEM-EVAL package).

    sample_name.time
        Only generated when --time is specified.

        It contains time (in seconds) consumed by building references,
        aligning reads, estimating expression levels and calculating
        credibility intervals.

    sample_name.stat
        This is a folder instead of a file. All model related statistics are
        stored in this folder. Use 'rsem-plot-model' can generate plots
        using this folder.

EXAMPLES
    We want to compute the RSEM-EVAL score for a contig assembly,
    'assembly1.fa'. Our data are 76bp single-end reads contained in
    '/data/reads.fq'. The related species is human and
    'human_transcripts.fa' contains all human transcripts. We use 8 threads
    and do not generate any BAM files. In addition, we set the overlap size
    w as 0 and 'sample_name' as 'assembly1_rsem_eval'.

    First, we need to estimate the true transcript length distribution using
    'human_transcripts.fa':

     rsem-eval-estimate-transcript-length-distribution human_transcripts.fa human.txt

    Now, we can calculate RSEM-EVAL score:

     rsem-eval-calculate-score -p 8 \
                               --transcript-length-parameters human.txt \
                               /data/reads.fq \
                               assembly1.fa \
                               assembly1_rsem_eval \
                               76

    The RSEM-EVAL score can be found in 'assembly1_rsem_eval.score' and the
    contig impact scores can be found in
    'assembly1_rsem_eval.score.isoforms.results'.
```


## detonate_ref-eval-estimate-true-assembly

### Tool Description
A program to estimate the "true" assembly of a set of reads, relative to a set of reference sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/detonate:1.11--boost1.64_1
- **Homepage**: https://github.com/deweylab/detonate
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
REF-EVAL-ESTIMATE-TRUE-ASSEMBLY: A program to estimate the "true" assembly
        of a set of reads, relative to a set of reference sequences

Overview

   This program constructs an estimate of the "true" assembly of a set
   of reads, relative to a set of reference sequences, based on
   alignment information produced by RSEM.

   As defined by DETONATE [1], the "true" assembly of a set of reads,
   relative to the true transcript sequences that the reads were
   generated from, is the set of contiguous subsequences of the
   transcript sequences that are covered by reads, with the reads
   overlapping by at least --min-overlap bases, when each read is
   aligned to its true location of origin.

   In practice, we do not know the reads' true locations of origin; in
   fact, we do not even know (precisely) the true transcript sequences
   that the reads were generated from. Instead, we start with a set of
   reference sequences (e.g., an Ensembl reference), and we align each
   read to these reference sequences using RSEM/Bowtie. The current
   program chooses a subset of these alignments, according to a policy
   specified by --alignment-policy and --min-alignment-prob, and then
   builds our best guess as to the "true" assembly based on these
   alignments.

   [1] Bo Li*, Nathanael Fillmore*, Yongsheng Bai, Mike Collins, James
   A. Thompson, Ron Stewart, Colin N. Dewey. Evaluation of de novo
   transcriptome assemblies from RNA-Seq data.

Example usage

   First, use a recent version of RSEM to quantify the expression of the
   full-length transcripts relative to the reads. For example:

 $ rsem-prepare-reference --gtf mm9.ensembl63.filtered.gtf mm9.fa ref
 $ rsem-calculate-expression --num-threads 24 reads.fq ref expr

   Second, use this program to estimate the "true" assembly:

 $ ./ref-eval-estimate-true-assembly --reference ref --expression expr --assembly cc

   This will output a file, cc_0.fa, that contains the "true" assembly.

General options

   -? [ --help ]

           Display this information.

Options that specify input and output

   --reference arg

           The prefix of the reference built by rsem-prepare-reference.
           Required.

   --expression arg

           The prefix of the expression built by
           rsem-calculate-expression. Required.

   --paired-end

           If you have paired-end data, and you want to estimate the
           "true" scaffolded assembly, then include the --paired-end
           flag. In this case, rsem-calculate-expression needs to have
           been run with the --paired-end flag. (However, even if
           rsem-calculate-expression was run with the --paired-end flag,
           you can omit it here in order to generate an unscaffolded
           assembly. In this case, each mate will be treated as an
           independent read.)

   --assembly arg

           A prefix to write the "true" assembly or sequence of
           assemblies to. The suffix _x.fa will be appended to this
           prefix, where x is the minimum overlap size. Required.

Options that change the output

   --min-overlap arg

           Either:

              * An integer that specifies how much overlap between two
                reads is required to merge two reads. For example, if
                --min-overlap=3, then only reads whose chosen alignments
                overlap by at least 3 bases will be joined into contigs.
                If --min-overlap=0, then only reads whose chosen
                alignments are contiguous (or overlap by a positive
                amount) will be joined into contigs.

           Or:

              * A pair of integers, separated by commas, specifying a
                range of overlap sizes, as described above. For example,
                if --min-overlap=2,4 is given, then three assemblies
                will be produced, corresponding to --min-overlap=2,
                --min-overlap=3, and --min-overlap=4 You might use this
                option to compute ideal assemblies at all overlap sizes,
                e.g., --min-overlap=0,76 for 76-length reads.

           Default: 0.

   --min-alignment-prob arg

           A number between 0 and 1 (inclusive). Any alignment (of a
           read to a reference transcript) with posterior probability,
           as calculated by RSEM, strictly less than this value will be
           discarded. Noise reads, with posterior probability exactly 0,
           are always discarded. Default: 0.

   --alignment-policy arg

           The policy used to choose which alignment(s) of each read to
           use in constructing the "true" assembly. Options:

              * sample: For each read, sample a single alignment (to
                some reference transcript) according to the posterior
                probability that the read follows each alignment, as
                calculated by RSEM.
              * best: For each read, choose the alignment that maximizes
                the posterior probability mentioned above. Ties are
                broken arbitrarily but deterministically (the first
                alignment in the BAM file is used).
              * all: For each read, use all its alignments. Some reads
                might end up with more than one alignment. In that case,
                contigs will be made assuming that the read aligns to
                each place. (In other words, the read is effectively
                duplicated, with one copy per alignment.)

           This policy is applied after the thresholding implied by
           --min-alignment-prob. For example, if
           "--min-alignment-prob=0.10 --alignment-policy=sample" is
           given, then (first) all alignments with posterior probability
           less than 0.10 will be discarded, and (second), for each
           read, an alignment will be sampled from among the remaining
           alignments, with the posterior distribution renormalized as
           appropriate. As another example, if
           "--min-alignment-prob=0.90 --alignment-policy=all" is given,
           then all alignments with posterior probability at least 0.90
           will be used.

           Default: sample.
```


## detonate_ref-eval

### Tool Description
REF-EVAL: A toolkit of reference-based scores for de novo transcriptome sequence assembly evaluation

### Metadata
- **Docker Image**: quay.io/biocontainers/detonate:1.11--boost1.64_1
- **Homepage**: https://github.com/deweylab/detonate
- **Package**: https://anaconda.org/channels/bioconda/packages/detonate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/detonate/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/deweylab/detonate
- **Stars**: N/A
### Original Help Text
```text
REF-EVAL: A toolkit of reference-based scores for de novo transcriptome
                       sequence assembly evaluation

Overview

   REF-EVAL computes a number of reference-based scores. These scores
   measure the quality of a transcriptome assembly relative to a
   collection of reference sequences. For information about how to run
   REF-EVAL, see "Usage" and the sections following it below. For
   information about the score definitions, see "Score definitions" and
   the sections following it below.

Usage

   As an optional first step, estimate the "true" assembly, using
   [1]REF-EVAL-ESTIMATE-TRUE-ASSEMBLY. Alternatively, you can use the
   full-length reference transcript sequences directly as a reference.

   From now on, we will call the estimated "true" assembly or the
   collection of full-length reference sequences (whichever you choose
   to use) the reference. Let's assume that the assembly of interest is
   in A.fa, and the reference is in B.fa.

   If you want to compute alignment-based scores (see --scores below for
   more info), align the assembly to the reference and vice versa using
   [2]Blat. We recommend fairly unrestrictive settings, in order to
   generate many candidate alignments.

 $ blat -minIdentity=80 B.fa A.fa A_to_B.psl
 $ blat -minIdentity=80 A.fa B.fa B_to_A.psl

   If you want to compute weighted variants of scores, use [3]RSEM to
   compute the expression of the assembly and reference relative to the
   given reads. Let's assume that the reads are in reads.fq.

 $ rsem-prepare-reference --no-polyA A.fa A_ref
 $ rsem-prepare-reference --no-polyA B.fa B_ref
 $ rsem-calculate-expression -p 24 --no-bam-output reads.fq A_ref A_expr
 $ rsem-calculate-expression -p 24 --no-bam-output reads.fq B_ref B_expr

   Finally, run REF-EVAL. To compute everything, run:

 $ ./ref-eval --scores=nucl,pair,contig,kmer,kc \
              --weighted=both \
              --A-seqs A.fa \
              --B-seqs B.fa \
              --A-expr A_expr.isoforms.results \
              --B-expr B_expr.isoforms.results \
              --A-to-B A_to_B.psl \
              --B-to-A B_to_A.psl \
              --num-reads 5000000 \
              --readlen 76 \
              --kmerlen 76 \
              | tee scores.txt

   To only compute the kmer compression score (and its dependencies),
   run:

 $ ./ref-eval --scores=kc \
              --A-seqs A.fa \
              --B-seqs B.fa \
              --B-expr B_expr.isoforms.results \
              --num-reads 5000000 \
              --readlen 76 \
              --kmerlen 76 \
              | tee scores.txt

   To only compute the unweighted reference-based scores, run:

 $ ./ref-eval --scores=nucl,pair,contig \
              --weighted=no \
              --A-seqs A.fa \
              --B-seqs B.fa \
              --A-to-B A_to_B.psl \
              --B-to-A B_to_A.psl \
              | tee scores.txt

   To only compute the scores discussed in the DETONATE paper, run:

 $ ./ref-eval --paper \
              --A-seqs A.fa \
              --B-seqs B.fa \
              --B-expr B_expr.isoforms.results \
              --A-to-B A_to_B.psl \
              --B-to-A B_to_A.psl \
              --num-reads 5000000 \
              --readlen 76 \
              --kmerlen 76 \
              | tee scores.txt

   The scores will be written to standard output (hence, above, to
   scores.txt). Progress information is written to standard error.
   Further details about the arguments to REF-EVAL are described below.
   Further details about the scores themselves are given under "Score
   definitions" below.

Usage: Score specification

   --scores arg

           The groups of scores to compute, separated by commas (e.g.,
           --scores=nucl,contig,kc). It is more efficient to compute all
           the scores you are interested in using one invocation of
           REF-EVAL instead of using multiple invocations that each
           compute one score. The available score groups are as follows:

           Alignment-based score groups:

              * nucl: nucleotide precision, recall, and F1.
              * contig: contig precision, recall, and F1.
              * pair: pair precision, recall, and F1.

           Alignment-free score groups:

              * kmer: kmer Kullback-Leibler divergence, Jensen-Shannon
                divergence, and Hellinger distance.
              * kc: kmer recall, number of nucleotides, and kmer
                compression score.

           Required unless --paper is given.

   --weighted arg

           A string indicating whether to compute weighted or unweighted
           variants of scores, or both (e.g., --weighted=yes):

              * yes: compute weighted variants of scores.
              * no: compute unweighted variants of scores.
              * both: compute both weighted and unweighted variants of
                scores.

           In weighted variants, the expression levels (TPM) of the
           assembly and reference sequences are taken into account, and
           hence need to be specified using --A-expr and --B-expr.
           Unweighted variants are equivalent to weighted variants with
           uniform expression.

           The distinction between weighted and unweighted variants
           doesn't make sense for the KC score, so this option is
           ignored by the KC score.

           Required unless --paper or only --score=kc is given.

   --paper

           As an alternative to the above, if you are only interested in
           computing the scores described in the main text of our paper
           [1], you can pass the --paper flag instead of the --scores
           and --weighted options. In that case, the following scores
           will be computed:

           Alignment-based scores:

              * unweighted nucleotide F1
              * unweighted contig F1

           Alignment-free score groups:

              * weighted kmer compression score

           For obvious reasons, the --scores and --weighted options are
           incompatible with this flag.

           [1] Bo Li*, Nathanael Fillmore*, Yongsheng Bai, Mike Collins,
           James A. Thompson, Ron Stewart, Colin N. Dewey. Evaluation of
           de novo transcriptome assemblies from RNA-Seq data.

Usage: Input and output specification

   --A-seqs arg

           The assembly sequences, in FASTA format. Required.

   --B-seqs arg

           The reference sequences, in FASTA format. Required.

   --A-expr arg

           The assembly expression, for use in weighted scores, as
           produced by RSEM in a file called *.isoforms.results.
           Required for weighted variants of scores.

   --B-expr arg

           The reference expression, for use in weighted scores, as
           produced by RSEM in a file called *.isoforms.results.
           Required for weighted variants of scores.

   --A-to-B arg

           The alignments of the assembly to the reference. The file
           format is specified by --alignment-type. Required for
           alignment-based scores.

   --B-to-A arg

           The alignments of the reference to the assembly. The file
           format is specified by --alignment-type. Required for
           alignment-based scores.

   --alignment-type arg

           The type of alignments used, either blast or psl. Default:
           psl. Currently BLAST support is experimental, not well
           tested, and not recommended.

Usage: Options that modify the score definitions (and hence output)

   --strand-specific

           If this flag is present, it is assumed that all the assembly
           and reference sequences have the same orientation. Thus,
           alignments or kmer matches that are to the reverse strand are
           ignored.

   --readlen arg

           This option only applies to the KC scores. The read length of
           the reads used to build the assembly, used in the denominator
           of the ICR. Required for KC scores.

   --num-reads arg

           This option only applies to the KC scores. The number of
           reads used to build the assembly, used in the denominator of
           the ICR. Required for KC scores.

   --kmerlen arg

           This option only applies to the kmer and KC scores. This is
           the length ("k") of the kmers used in the definition of the
           KC and kmer scores. Required for KC and kmer scores.

   --min-frac-identity arg

           This option only applies to contig scores. Alignments with
           fraction identity less than this threshold are ignored. The
           fraction identity of an alignment is min(x/y, x/z), where

              * $x$ is the number of bases in the assembly sequence that
                are aligned to an identical base in the reference
                sequence, according to the alignment,
              * $y$ is the number of bases in the assembly sequence, and
              * $z$ is the number of bases in the reference sequence.

           Default: 0.99.

   --max-frac-indel arg

           This option only applies to contig scores. Alignments with
           fraction indel greater than this threshold are ignored. For
           psl alignments, the fraction indel of an alignment is
           $\max(w/y, x/z)$, where

              * $w$ is the number of bases that are inserted in the
                assembly sequence, according to the alignment ("Q gap
                bases"),
              * $x$ is the number of bases that are inserted in the
                reference sequence, according to the alignment ("T gap
                bases"),
              * $y$ is the number of bases in the assembly sequence, and
              * $z$ is the number of bases in the reference sequence.

           For blast alignments, the fraction indel of an alignment is
           $\max(x/y, x/z)$, where

              * $x$ is the number of gaps bases that are inserted in the
                reference sequence, according to the alignment ("gaps"),
              * $y$ is the number of bases in the assembly sequence, and
              * $z$ is the number of bases in the reference sequence.

           Default: 0.01.

   --min-segment-len arg

           This option only applies to nucleotide and pair scores.
           Alignment segments that contain fewer than this number of
           bases will be discarded. Default: 100. In the DETONATE paper,
           this was set to the read length.

Usage: Options that modify the algorithm, but not the score definitions

   --hash-table-type arg

           The type of hash table to use, either "sparse" or "dense".
           This is only relevant for KC and kmer scores. The sparse
           table is slower but uses less memory. The dense table is
           faster but uses more memory. Default: "sparse".

   --hash-table-numeric-type arg

           The numeric type to use to store values in the hash table,
           either "double" or "float". This is only relevant for KC and
           kmer scores. Using single-precision floating point numbers
           ("float") requires less memory than using double-precision
           ("double"), but may also result in more numerical error. Note
           that we use double-precision numbers throughout our
           calculations even if single-precision numbers are stored in
           the table, so the additional error should be minimal.
           Default: "double".

   --hash-table-fudge-factor arg

           This is only relevant for KC and kmer scores. When the hash
           table is created, its initial capacity is set as the total
           worst-case number of possible kmers in the assembly and
           reference, based on each sequence's length, divided by the
           fudge factor. The default, 2.0, is often reasonable because
           (1) most kmers should be shared by the assembly and the
           reference, and (2) many kmers will be repeated several times.
           However, if you have a lot of memory or a really bad
           assembly, you could try a smaller number. Default: 2.0.

Usage: Options to include additional output

   --trace arg

           If given, the prefix for additional output that provides
           details about the REF-EVAL scores; if not given, no such
           output is produced. Currently, the only such output is as
           follows.

              * (--trace).{weighted,unweighted}_contig_{precision,recall}_matching
                is a TSV file that describes the matching used to
                compute the weighted or unweighted contig precision or
                recall. (Details about the matching are given in the
                section on score definitions below.) For recall, each
                row corresponds to a reference sequence $b$. Column 1
                contains $b$'s name. If $b$ is matched to a contig $a$,
                then the remaining columns are as follows:

                   * Column 2 contains $a$'s name.
                   * Column 3 contains the weight of the edge between
                     $b$ and $a$. (This is set to the uniform weights
                     $1/|B|$ in the unweighted case, although the
                     maximum cardinality matching algorithm does not
                     actually use these weights.)
                   * Column 4 contains the names of all the contigs $a'$
                     that are adjacent to $b$ in the bipartite graph
                     that the matching is based on, separated by commas.
                     Thus, this column lists all the contigs $a'$ that
                     have a "good enough" match with the reference
                     sequence $b$, according to the criteria used to
                     build the bipartite graph. (See the section below
                     on score definitions for details.)

                Otherwise, if $b$ is not matched to any contig, columns
                2 and 3 contain "NA". For precision, the file has the
                same format, but with the reference and the assembly
                interchanged. In other words, each row corresponds to a
                contig $a$ and contains information about its matching
                to a reference sequence $b$, or all "NA" values if $a$
                was not matched.

Usage: General options

   -? [ --help ]

           Display this information.

Score definitions

   In the next few sections, we define the scores computed by REF-EVAL.
   Throughout, $A$ denotes the assembly, and $B$ denotes the reference.
   (As discussed under "Usage" above, the reference can be either an
   estimate of the "true" assembly or a collection of full-length
   reference transcripts.) Both $A$ and $B$ are thought of as sets of
   sequences. $A$ is a set of contigs, and $B$ is a set of reference
   sequences.

Score definitions: contig precision, recall, and F1

   The contig recall is defined as follows:

     * Align the assembly $A$ to the reference $B$. Notation: each
       alignment $l$ is between a contig $a$ in $A$ and an reference
       sequence $b$ in $B$.
     * Throw out alignments that are to the reverse strand, if
       --strand-specific is present.
     * Throw out alignments whose fraction identity is less than
       --min-frac-identity (q.v.\ for the definition of "fraction
       identity").
     * Throw out alignments whose fraction indel is greater than
       --max-frac-indel (q.v.\ for the definition of "fraction indel").
     * Construct a bipartite graph from the remaining alignments, in
       which there is an edge between $a$ and $b$ iff there is a
       remaining alignment $l$ of $a$ to $b$.
     * If --weighted=yes, specify a weight for each edge between $a$ and
       $b$, namely $\tau(b)$, the relative abundance of $b$ within the
       reference, as specified in --B-expr.
     * The unweighted contig recall is the number of edges in the
       maximum cardinality matching of this graph, divided by the number
       of sequences in the reference $B$.
     * The weighted contig recall is the weight of the maximum weight
       matching of this graph.

   The contig precision is defined as follows: Interchange the assembly
   and the reference, and compute the contig recall.

   The contig F1 is the harmonic mean of the precision and recall.

Score definitions: nucleotide precision, recall, and F1

   The nucleotide recall is defined as follows:

     * Align the assembly $A$ to the reference $B$. Notation: each
       alignment $l$ is between a contig $a \in A$ and an reference
       element $b \in B$.
     * Throw out alignments that are to the reverse strand, if
       --strand-specific is present.
     * Throw out alignments that are shorter than --min-fragment-length.
     * Add each remaining alignment to a priority queue, with priority
       equal to the number of identical bases in the alignment.
     * Let numer = 0.
     * While the priority queue is not empty:

          * Pop the alignment $l$ with highest priority.
          * Add the number of identical bases in the alignment to numer.
          * Subtract $l$ from all the other alignments in the queue and
            update their priorities (see below).

     * Let denom be the total number of bases in the reference $B$.
     * The unweighted nucleotide recall is numer/denom.

   The actual implementation uses a more complicated and efficient
   algorithm than the one above.

   If --weighted=yes, then (i) "the number of identical bases" above is
   replaced by "the number of identical bases, times $\tau(b)$", in the
   definition of the priority and the numer, and (ii) "total number of
   bases in the reference $B$" is replaced by "$\sum_{b \in B} \tau(b)
   length(b)$". In other words, each base (of a reference sequence),
   throughout the computation, is weighted by the expression level of
   its parent sequence.

   The nucleotide precision is defined as follows: Interchange the
   assembly and the reference, and compute the nucleotide recall.

   The nucleotide F1 is the harmonic mean of the precision and recall.

   Alignment subtraction is defined as follows.

     * An alignment $l$ from $a$ to $b$ can be thought of as a set of
       pairs of disjoint intervals
       $$ \{ ([s_1(a), e_1(a)], [s_1(b), e_1(b)]), \dots, ([s_n(a),
       e_n(a)], [s_n(b), e_n(b)]) \}, $$
       where each pair $([s_i(a), e_i(a)], [s_i(b), e_i(b)])$
       corresponds to an ungapped segment of the alignment: $s_i(a)$ and
       $e_i(a)$ are the segment's start and end positions within a, and
       $s_i(b)$ and $e_i(b)$ are the segment's start and end positions
       within b. In the case of non-strand-specific alignments, $s_i(b)$
       might be greater than $e_i(b)$.
     * If $l$ is an alignment from $a$ to $b$, $l'$ is an alignment from
       $a'$ to $b'$, $a \neq a'$, and $b \neq b'$, then the difference
       $l - l' = l$.
     * If $l$ is an alignment from $a$ to $b$, $l'$ is an alignment from
       $a'$ to $b'$, $a = a'$, and $b \neq b'$, then the difference $l -
       l' = l''$, defined as follows. Each alignment segment of $l$ is
       compared to the alignment segments of $l'$. If a segment of $l$
       overlaps one of the segments of $l'$ wrt $a$, it is truncated so
       as to avoid the overlap. This truncation may result in zero, one,
       or two replacement alignment segments. (If the overlapping
       alignment segment of $l'$ is contained strictly within the
       segment of $l$, wrt $a$, two segments will result.)
     * If $l$ is an alignment from $a$ to $b$, $l'$ is an alignment from
       $a'$ to $b'$, $a \neq a'$, and $b = b'$, then the difference $l -
       l' = l''$, defined similarly as in the previous item, except
       overlaps are examined and resolved wrt $b$.

   A couple of examples of the above are as follows. The comments in
   [4]test_re_matched.cpp contain even more examples.

   As a first example, consider alignments of an assembly $A = \{a_0,
   a_1, a_2\}$ to a reference $B = \{b_0, b_1\}$. In the pictures below,
   each alignment segment is indicated by a pair diagonal or vertical
   lines, with its name (initially $x$, $y$, $z$, $w$) in between the
   two lines.

       b0                    b1
    B  -----------------     -------------
            /    \   /  \   /  | / |
           /      \ /    \ /   |/  |
          /  x     /  y   \  z / w |
         /        / \    / \  /|   |
    A    ---------   --------- ---------
         a0          a1        a2

   Assume:

     * $x > y > z > w$, where $>$ compares alignment size measured by
       the number of identical bases.
     * $y - x < z$.
     * $y - x$ is contained in $z$, wrt $A$.

   Step 1: Process alignment $x$, resulting in

       b0                    b1
    B  ------------------   --------------
            /        /\ \   /  | / |
           /        /  \ \ /   |/  |
          /  x     /    \*\  z / w |        * = y - x
         /        /      / \  /|   |
    A    ---------   --------- ---------
         a0          a1        a2

   Step 2: Process alignment $z$, resulting in

       b0                    b1
    B  -----------------    --------------
            /        /      /    /||
           /        /      /    / ||
          /  x     /      /  z /  *|        * = w - z
         /        /      /    /   ||
    A    ---------   --------- ---------
         a0          a1        a2

   Now we have a 1-1 mathing. The intervals of $B$ used to compute
   recall are as follows:

       b0                    b1
    B  -----[--------]--    [----][]------
            /        /      /    /||
           ...

   As a second example, we start with the same initial set of
   alignments:

       b0                    b1
    B  -----------------     -------------
            /    \   /  \   /  | / |
           /      \ /    \ /   |/  |
          /  x     /  y   \  z / w |
         /        / \    / \  /|   |
    A    ---------   --------- ---------
         a0          a1        a2

   But we make a slightly different set of assumptions:

     * $x > y > w > z$ ($w$ and $z$ are interchanged, compared to the
       first example).
     * $y - x < w$.
     * $y - x > z - w$.
     * $y - x$ is contained in $z$, wrt $A$.

   Step 1: Process alignment $x$, resulting in

       b0                    b1
    B  ------------------   --------------
            /        /\ \   /  | / |
           /        /  \ \ /   |/  |
          /  x     /    \*\  z / w |        * = y - x
         /        /      / \  /|   |
    A    ---------   --------- ---------
         a0          a1        a2

   Step 2: Process alignment w, resulting in

       b0                    b1
    B  ------------------   --------------
            /        /\ \   /  |   |
           /        /  \ \ /  /|   |
          /  x     /    \*\ +/ | w |        * = y - x
         /        /      / \/  |   |        + = z - w
    A    ---------   --------- ---------
         a0          a1        a2

   Step 3: Process alignment $y - x$, resulting in

       b0                    b1
    B  ------------------   --------------
            /        /\ \  +/  |   |
           /        /  \*\//   |   |
          /  x     /    \ \    | w |        * = y - x
         /        /     // \   |   |        + = (z - w) - (y - x)
    A    ---------   --------- ---------
         a0          a1        a2

   Now we have a 1-1 mathing. The intervals of $B$ used to compute
   recall are:

       b0                    b1
    B  -----[--------][-]   []-[---]------
            /        /\ \  //  |   |        * = y - x
             x         *   +     w          + = (z - w) - (y - x)
           ...

Score definitions: pair precision, recall, and F1

   The definitions for pair precision, recall, and F1 are exactly the
   same as for nucleotide precision, recall, and F1, except that instead
   of bases, we operate on pairs of bases.

   For example, consider the reference $B$ (with one transcript) and
   assembly $A$ (with two contigs), where horizontal position indicates
   alignment.

       B: b   = AGCTCGACGT
       A: a_1 = AGCT
          a_2 =     CGACGT

   Here, the transcript recall is 0 (because neither $a_1$ nor $a_2$
   covers $b$ to $\geq$ 99 percent), but the nucleotide recall is 1
   (because $a_1$ and $a_2$ jointly cover $b$ completely). The pair
   recall is somewhere in between, because the following pairs of $b$
   are correctly predicted (represented by an upper triangular indicator
   matrix):

           First base
       S   AGCTCGACGT
       e A 1111
       c G  111
       o C   11
       n T    1
       d C     111111
         G      11111
       b A       1111
       a C        111
       s G         11
       e T          1

Score definitions: KC and related scores

   The kmer compression score (KC score) is a combination of two
   measures, weighted kmer recall (WKR) and inverse compression rate
   (ICR), and is simply

   $$ KC = WKR - ICR. $$

   The WKR measures the fidelity with which a particular assembly
   represents the kmer content of the reference sequences. Balancing the
   WKR, the ICR measures the degree to which the assembly compresses the
   RNA-Seq data. The details of the WKR and ICR measures are provided
   below.

   To compute the WKR, the relative abundances of the reference elements
   are required, as specified by --B-expr. Given the reference sequences
   and their abundances, a kmer occurrence frequency profile, $p$, is
   computed, with individual kmer occurrences weighted by their parent
   sequences' abundances: for each kmer $r$, we define

   $$ p(r) = \frac{ \sum_{b \in B} n(r,b) \tau(b) } { \sum_{b \in B}
   n(b) \tau(b) } $$

   where $B$ is the set of reference sequences, and for each reference
   sequence $b \in B$:

     * $n(r,b)$ is the number of times the kmer $r$ occurs in $b$,
     * $n(b) $ is the total number of kmers in $b$, and
     * $\tau(b)$ is the relative abundance of $b$.

   Letting $R(A)$ be the set of all kmers in the assembly $A$, the
   weighted kmer recall (WKR) is defined as

   $$ WKR = \sum_{r \in R(A)} p(r). $$

   REF-EVAL currently uses --readlen as the kmer length.

   Since recall measures only tell half of the story regarding accuracy,
   the KC score includes a second term, the ICR, which serves to
   penalize large assemblies. We define the inverse compression rate
   (ICR) of an assembly as

   $$ ICR = n_A/(N L), $$

   where

     * $n_A$ is the total number of bases in the assembly $A$,
     * $N$ is the total number of reads, as specified by --num-reads,
       and
     * $L$ is the read length, as specified by --readlen.

Score definitions: kmer scores

   If --weighted=yes, we construct a kmer occurrence frequency profile
   $p_B$ for $B$ exactly as described in the previous section (about the
   KC score). We construct a kmer occurrence frequency profile $p_A$ for
   $A$ similarly. The relative abundances are specified by --A-expr and
   --B-expr.

   If --weighted=no, we construct the kmer occurrence frequency profiles
   $p_A$ and $p_B$ in the same way, except that uniform relative
   abundances are used, i.e., $\tau(a) = 1/|A|$ for all $a$ in $A$, and
   $\tau(b) = 1/|B|$ for all $b$ in $B$, where $|A|$ is the number of
   contigs in $A$, and $|B|$ is the number of reference sequences in
   $B$.

   Let $m$ be the "mean" profile of $p_A$ and $p_B$:

   $$ m(r) = (1/2) (p_A(r) + p_B(r)) \qquad\hbox{for every kmer $r$}. $$

   The Jensen-Shannon divergence between $p_A$ and $p_B$ is defined in
   terms of the KL divergence between $p_A$ and the mean, and $p_B$ and
   the mean, as follows:

     * Let $KL(p_A || m) = \sum_r p_A(r) (\log_2(p_A(r)) -
       \log_2(m(r)))$.
     * Let $KL(p_B || m) = \sum_r p_B(r) (\log_2(p_B(r)) -
       \log_2(m(r)))$.
     * Let $JS(p_A || p_B) = (1/2) (KL(p_A || m) + KL(p_B || m))$.

   In the output file, these three scores are denoted
   (un)weighted_kmer_KL_A_to_M, (un)weighted_kmer_KL_B_to_M, and
   (un)weighted_kmer_jensen_shannon, respectively.

   The Hellinger distance between $p_A$ and $p_B$ is defined as

   $$ \sqrt{ (1/2) \sum_r (\sqrt{p_A(r)} - \sqrt{p_B(r)})^2 } $$

   The total variation distance between $p_A$ and $p_B$ is defined as

   $$ (1/2) \sum_r |p_A(r) - p_B(r)|, $$

   where $|\cdot|$ denotes absolute value. Above, $\sum_r$ denotes a sum
   over all possible kmers $r$ (most of which will have $p_A(r) = p_B(r)
   = 0$).

References

   Visible links
   1. http://deweylab.biostat.wisc.edu/detonate/ref-eval-estimate-true-assembly.html
   2. http://genome.ucsc.edu/FAQ/FAQblat.html
   3. http://deweylab.biostat.wisc.edu/rsem/
   4. https://github.com/deweylab/detonate/blob/master/ref-eval/test_re_matched.cpp
```

## Metadata
- **Skill**: generated
