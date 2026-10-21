# rsem CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rsem_convert-sam-for-rsem | PASS |  |
| rsem_rsem-bam2readdepth | PASS |  |
| rsem_rsem-bam2wig | PASS | wiggle file has per-base coverage matching the read depth output; --no-fractional-weight also works |
| rsem_rsem-build-read-index | PASS |  |
| rsem_rsem-calculate-credibility-intervals | Failed | image problem: crashes with a segmentation fault (exit 139); rsem-calculate-expression --calc-ci fails the same way |
| rsem_rsem-calculate-expression | PASS | tested in --alignments mode (counts close to RSEM gold); read mode needs bowtie/bowtie2/STAR/HISAT2, which are not in the image |
| rsem_rsem-control-fdr | Not completed | needs a valid rsem-run-ebseq result, which the image cannot produce (PPDE is 0 for every gene); the Perl script ran and gave a header-only file |
| rsem_rsem-extract-reference-transcripts | PASS | transcripts, chrlist, grp and ti files are identical to the rsem-prepare-reference output |
| rsem_rsem-for-ebseq-calculate-clustering-info | PASS |  |
| rsem_rsem-for-ebseq-find-DE | Failed | image problem: the usual two-condition mode crashes because the image's EBSeq 2.4.0 output has no C1Mean field, which the rsem script reads; only the three-condition mode works (tested on EBSeq's example count matrix, synthetic data). |
| rsem_rsem-for-ebseq-generate-ngvector-from-clustering-info | PASS |  |
| rsem_rsem-gen-transcript-plots | PASS |  |
| rsem_rsem-generate-data-matrix | PASS |  |
| rsem_rsem-get-unique | PASS | 2208 uniquely aligned pairs kept, matching the bowtie2 unique count |
| rsem_rsem-gff3-to-gtf | Failed | image problem: the script starts with 'env python' and the image has no python |
| rsem_rsem-parse-alignments | PASS |  |
| rsem_rsem-plot-model | PASS |  |
| rsem_rsem-plot-transcript-wiggles | PASS |  |
| rsem_rsem-prepare-reference | PASS | reference files match the RSEM gold files; the aligner-index options need bowtie/bowtie2/STAR/HISAT2, which are not in the image |
| rsem_rsem-preref | PASS |  |
| rsem_rsem-refseq-extract-primary-assembly | Failed | image problem: the script starts with 'env python' and the image has no python |
| rsem_rsem-run-ebseq | Failed | image problem: EBSeq 2.4.0 in the image does not fit rsem-for-ebseq-find-DE; two conditions crash, more than two give PPDE 0 for every gene |
| rsem_rsem-run-em | PASS |  |
| rsem_rsem-run-gibbs | PASS |  |
| rsem_rsem-sam-validator | PASS |  |
| rsem_rsem-scan-for-paired-end-reads | PASS |  |
| rsem_rsem-simulate-reads | Failed | image problem: rsem-simulate-reads crashes with a segmentation fault (exit 139) on a model learned from real data |
| rsem_rsem-synthesis-reference-transcripts | PASS |  |
| rsem_rsem-tbam2gbam | Failed | tool bug: exits 255 on a valid paired transcript BAM (two mates aligned to two different transcripts); rsem-calculate-expression --output-genome-bam fails the same way |

## rsem_rsem-prepare-reference

### Tool Description
Prepare transcript references for RSEM and optionally build BOWTIE/BOWTIE2/STAR/HISAT2(transcriptome) indices.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Total Downloads**: 231.3K
- **Last updated**: 2025-10-15
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Invalid number of arguments!
NAME
    rsem-prepare-reference - Prepare transcript references for RSEM and
    optionally build BOWTIE/BOWTIE2/STAR/HISAT2(transcriptome) indices.

SYNOPSIS
     rsem-prepare-reference [options] reference_fasta_file(s) reference_name

ARGUMENTS
    reference_fasta_file(s)
        Either a comma-separated list of Multi-FASTA formatted files OR a
        directory name. If a directory name is specified, RSEM will read all
        files with suffix ".fa" or ".fasta" in this directory. The files
        should contain either the sequences of transcripts or an entire
        genome, depending on whether the '--gtf' option is used.

    reference name
        The name of the reference used. RSEM will generate several
        reference-related files that are prefixed by this name. This name
        can contain path information (e.g. '/ref/mm9').

OPTIONS
    --gtf <file>
        If this option is on, RSEM assumes that 'reference_fasta_file(s)'
        contains the sequence of a genome, and will extract transcript
        reference sequences using the gene annotations specified in <file>,
        which should be in GTF format.

        If this and '--gff3' options are off, RSEM will assume
        'reference_fasta_file(s)' contains the reference transcripts. In
        this case, RSEM assumes that name of each sequence in the
        Multi-FASTA files is its transcript_id.

        (Default: off)

    --gff3 <file>
        The annotation file is in GFF3 format instead of GTF format. RSEM
        will first convert it to GTF format with the file name
        'reference_name.gtf'. Please make sure that 'reference_name.gtf'
        does not exist. (Default: off)

    --gff3-RNA-patterns <pattern>
        <pattern> is a comma-separated list of transcript categories, e.g.
        "mRNA,rRNA". Only transcripts that match the <pattern> will be
        extracted. (Default: "mRNA")

    --gff3-genes-as-transcripts
        This option is designed for untypical organisms, such as viruses,
        whose GFF3 files only contain genes. RSEM will assume each gene as a
        unique transcript when it converts the GFF3 file into GTF format.

    --trusted-sources <sources>
        <sources> is a comma-separated list of trusted sources, e.g.
        "ENSEMBL,HAVANA". Only transcripts coming from these sources will be
        extracted. If this option is off, all sources are accepted.
        (Default: off)

    --transcript-to-gene-map <file>
        Use information from <file> to map from transcript (isoform) ids to
        gene ids. Each line of <file> should be of the form:

        gene_id transcript_id

        with the two fields separated by a tab character.

        If you are using a GTF file for the "UCSC Genes" gene set from the
        UCSC Genome Browser, then the "knownIsoforms.txt" file (obtained
        from the "Downloads" section of the UCSC Genome Browser site) is of
        this format.

        If this option is off, then the mapping of isoforms to genes depends
        on whether the '--gtf' option is specified. If '--gtf' is specified,
        then RSEM uses the "gene_id" and "transcript_id" attributes in the
        GTF file. Otherwise, RSEM assumes that each sequence in the
        reference sequence files is a separate gene.

        (Default: off)

    --allele-to-gene-map <file>
        Use information from <file> to provide gene_id and transcript_id
        information for each allele-specific transcript. Each line of <file>
        should be of the form:

        gene_id transcript_id allele_id

        with the fields separated by a tab character.

        This option is designed for quantifying allele-specific expression.
        It is only valid if '--gtf' option is not specified. allele_id
        should be the sequence names presented in the Multi-FASTA-formatted
        files.

        (Default: off)

    --polyA
        Add poly(A) tails to the end of all reference isoforms. The length
        of poly(A) tail added is specified by '--polyA-length' option. STAR
        aligner users may not want to use this option. (Default: do not add
        poly(A) tail to any of the isoforms)

    --polyA-length <int>
        The length of the poly(A) tails to be added. (Default: 125)

    --no-polyA-subset <file>
        Only meaningful if '--polyA' is specified. Do not add poly(A) tails
        to those transcripts listed in <file>. <file> is a file containing a
        list of transcript_ids. (Default: off)

    --bowtie
        Build Bowtie indices. (Default: off)

    --bowtie-path <path>
        The path to the Bowtie executables. (Default: the path to Bowtie
        executables is assumed to be in the user's PATH environment
        variable)

    --bowtie2
        Build Bowtie 2 indices. (Default: off)

    --bowtie2-path <path>
        The path to the Bowtie 2 executables. (Default: the path to Bowtie 2
        executables is assumed to be in the user's PATH environment
        variable)

    --star
        Build STAR indices. (Default: off)

    --star-path <path>
        The path to STAR's executable. (Default: the path to STAR executable
        is assumed to be in user's PATH environment variable)

    --star-sjdboverhang <int>
        Length of the genomic sequence around annotated junction. It is only
        used for STAR to build splice junctions database and not needed for
        Bowtie or Bowtie2. It will be passed as the --sjdbOverhang option to
        STAR. According to STAR's manual, its ideal value is
        max(ReadLength)-1, e.g. for 2x101 paired-end reads, the ideal value
        is 101-1=100. In most cases, the default value of 100 will work as
        well as the ideal value. (Default: 100)

    --hisat2-hca
        Build HISAT2 indices on the transcriptome according to Human Cell
        Atlas (HCA) SMART-Seq2 pipeline. (Default: off)

    --hisat2-path <path>
        The path to the HISAT2 executables. (Default: the path to HISAT2
        executables is assumed to be in the user's PATH environment
        variable)

    -p/--num-threads <int>
        Number of threads to use for building STAR's genome indices.
        (Default: 1)

    -q/--quiet
        Suppress the output of logging information. (Default: off)

    -h/--help
        Show help information.

PRIOR-ENHANCED RSEM OPTIONS
    --prep-pRSEM
        A Boolean indicating whether to prepare reference files for pRSEM,
        including building Bowtie indices for a genome and selecting
        training set isoforms. The index files will be used for aligning
        ChIP-seq reads in prior-enhanced RSEM and the training set isoforms
        will be used for learning prior. A path to Bowtie executables and a
        mappability file in bigWig format are required when this option is
        on. Currently, Bowtie2 is not supported for prior-enhanced RSEM.
        (Default: off)

    --mappability-bigwig-file <string>
        Full path to a whole-genome mappability file in bigWig format. This
        file is required for running prior-enhanced RSEM. It is used for
        selecting a training set of isoforms for prior-learning. This file
        can be either downloaded from UCSC Genome Browser or generated by
        GEM (Derrien et al., 2012, PLoS One). (Default: "")

DESCRIPTION
    This program extracts/preprocesses the reference sequences for RSEM and
    prior-enhanced RSEM. It can optionally build Bowtie indices (with
    '--bowtie' option) and/or Bowtie 2 indices (with '--bowtie2' option)
    using their default parameters. It can also optionally build STAR
    indices (with '--star' option) using parameters from ENCODE3's STAR-RSEM
    pipeline. For prior-enhanced RSEM, it can build Bowtie genomic indices
    and select training set isoforms (with options '--prep-pRSEM' and
    '--mappability-bigwig-file <string>'). If an alternative aligner is to
    be used, indices for that particular aligner can be built from either
    'reference_name.idx.fa' or 'reference_name.n2g.idx.fa' (see OUTPUT for
    details). This program is used in conjunction with the
    'rsem-calculate-expression' program.

OUTPUT
    This program will generate 'reference_name.grp', 'reference_name.ti',
    'reference_name.transcripts.fa', 'reference_name.seq',
    'reference_name.chrlist' (if '--gtf' is on), 'reference_name.idx.fa',
    'reference_name.n2g.idx.fa', optional Bowtie/Bowtie 2 index files, and
    optional STAR index files.

    'reference_name.grp', 'reference_name.ti', 'reference_name.seq', and
    'reference_name.chrlist' are used by RSEM internally.

    'reference_name.transcripts.fa' contains the extracted reference
    transcripts in Multi-FASTA format. Poly(A) tails are not added and it
    may contain lower case bases in its sequences if the corresponding
    genomic regions are soft-masked.

    'reference_name.idx.fa' and 'reference_name.n2g.idx.fa' are used by
    aligners to build their own indices. In these two files, all sequence
    bases are converted into upper case. In addition, poly(A) tails are
    added if '--polyA' option is set. The only difference between
    'reference_name.idx.fa' and 'reference_name.n2g.idx.fa' is that
    'reference_name.n2g.idx.fa' in addition converts all 'N' characters to
    'G' characters. This conversion is in particular desired for aligners
    (e.g. Bowtie) that do not allow reads to overlap with 'N' characters in
    the reference sequences. Otherwise, 'reference_name.idx.fa' should be
    used to build the aligner's index files. RSEM uses
    'reference_name.idx.fa' to build Bowtie 2 indices and
    'reference_name.n2g.idx.fa' to build Bowtie indices. For visualizing the
    transcript-coordinate-based BAM files generated by RSEM in IGV,
    'reference_name.idx.fa' should be imported as a "genome" (see
    Visualization section in README.md for details).

    If the whole genome is indexed for prior-enhanced RSEM, all the index
    files will be generated with prefix as 'reference_name_prsem'. Selected
    isoforms for training set are listed in the file
    'reference_name_prsem.training_tr_crd'

EXAMPLES
    1) Suppose we have mouse RNA-Seq data and want to use the UCSC mm9
    version of the mouse genome. We have downloaded the UCSC Genes
    transcript annotations in GTF format (as mm9.gtf) using the Table
    Browser and the knownIsoforms.txt file for mm9 from the UCSC Downloads.
    We also have all chromosome files for mm9 in the directory '/data/mm9'.
    We want to put the generated reference files under '/ref' with name
    'mouse_0'. We do not add any poly(A) tails. Please note that GTF files
    generated from UCSC's Table Browser do not contain isoform-gene
    relationship information. For the UCSC Genes annotation, this
    information can be obtained from the knownIsoforms.txt file. Suppose we
    want to build Bowtie indices and Bowtie executables are found in
    '/sw/bowtie'.

    There are two ways to write the command:

     rsem-prepare-reference --gtf mm9.gtf \
                            --transcript-to-gene-map knownIsoforms.txt \
                            --bowtie \
                            --bowtie-path /sw/bowtie \                  
                            /data/mm9/chr1.fa,/data/mm9/chr2.fa,...,/data/mm9/chrM.fa \
                            /ref/mouse_0

    OR

     rsem-prepare-reference --gtf mm9.gtf \
                            --transcript-to-gene-map knownIsoforms.txt \
                            --bowtie \
                            --bowtie-path /sw/bowtie \
                            /data/mm9 \
                            /ref/mouse_0

    2) Suppose we also want to build Bowtie 2 indices in the above example
    and Bowtie 2 executables are found in '/sw/bowtie2', the command will
    be:

     rsem-prepare-reference --gtf mm9.gtf \
                            --transcript-to-gene-map knownIsoforms.txt \
                            --bowtie \
                            --bowtie-path /sw/bowtie \
                            --bowtie2 \
                            --bowtie2-path /sw/bowtie2 \
                            /data/mm9 \
                            /ref/mouse_0

    3) Suppose we want to build STAR indices in the above example and save
    index files under '/ref' with name 'mouse_0'. Assuming STAR executable
    is '/sw/STAR', the command will be:

     rsem-prepare-reference --gtf mm9.gtf \
                            --transcript-to-gene-map knownIsoforms.txt \
                            --star \
                            --star-path /sw/STAR \
                            -p 8 \
                            /data/mm9/chr1.fa,/data/mm9/chr2.fa,...,/data/mm9/chrM.fa \
                            /ref/mouse_0

    OR

     rsem-prepare-reference --gtf mm9.gtf \
                            --transcript-to-gene-map knownIsoforms.txt \
                            --star \
                            --star-path /sw/STAR \
                            -p 8 \
                            /data/mm9
                            /ref/mouse_0

    STAR genome index files will be saved under '/ref/'.

    4) Suppose we want to prepare references for prior-enhanced RSEM in the
    above example. In this scenario, both STAR and Bowtie are required to
    build genomic indices - STAR for RNA-seq reads and Bowtie for ChIP-seq
    reads. Assuming their executables are under '/sw/STAR' and '/sw/Bowtie',
    respectively. Also, assuming the mappability file for mouse genome is
    '/data/mm9.bigWig'. The command will be:

     rsem-prepare-reference --gtf mm9.gtf \
                            --transcript-to-gene-map knownIsoforms.txt \
                            --star \
                            --star-path /sw/STAR \
                            -p 8 \
                            --prep-pRSEM \
                            --bowtie-path /sw/Bowtie \
                            --mappability-bigwig-file /data/mm9.bigWig \
                            /data/mm9/chr1.fa,/data/mm9/chr2.fa,...,/data/mm9/chrM.fa \
                            /ref/mouse_0

    OR

     rsem-prepare-reference --gtf mm9.gtf \
                            --transcript-to-gene-map knownIsoforms.txt \
                            --star \
                            --star-path /sw/STAR \
                            -p 8 \
                            --prep-pRSEM \
                            --bowtie-path /sw/Bowtie \
                            --mappability-bigwig-file /data/mm9.bigWig \
                            /data/mm9
                            /ref/mouse_0

    Both STAR and Bowtie's index files will be saved under '/ref/'. Bowtie
    files will have name prefix 'mouse_0_prsem'

    5) Suppose we only have transcripts from EST tags stored in 'mm9.fasta'
    and isoform-gene information stored in 'mapping.txt'. We want to add
    125bp long poly(A) tails to all transcripts. The reference_name is set
    as 'mouse_125'. In addition, we do not want to build Bowtie/Bowtie 2
    indices, and will use an alternative aligner to align reads against
    either 'mouse_125.idx.fa' or 'mouse_125.idx.n2g.fa':

     rsem-prepare-reference --transcript-to-gene-map mapping.txt \
                            --polyA
                            mm9.fasta \
                            mouse_125
```


## rsem_rsem-calculate-expression

### Tool Description
Estimate gene and isoform expression from RNA-Seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Invalid number of arguments!
NAME
    rsem-calculate-expression - Estimate gene and isoform expression from
    RNA-Seq data.

SYNOPSIS
     rsem-calculate-expression [options] upstream_read_file(s) reference_name sample_name 
     rsem-calculate-expression [options] --paired-end upstream_read_file(s) downstream_read_file(s) reference_name sample_name 
     rsem-calculate-expression [options] --alignments [--paired-end] input reference_name sample_name

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
        SAM/BAM/CRAM formatted input file. If "-" is specified for the
        filename, the input is instead assumed to come from standard input.
        RSEM requires all alignments of the same read group together. For
        paired-end reads, RSEM also requires the two mates of any alignment
        be adjacent. In addition, RSEM does not allow the SEQ and QUAL
        fields to be empty. See Description section for how to make input
        file obey RSEM's requirements.

    reference_name
        The name of the reference used. The user must have run
        'rsem-prepare-reference' with this reference_name before running
        this program.

    sample_name
        The name of the sample analyzed. All output files are prefixed by
        this name (e.g., sample_name.genes.results)

BASIC OPTIONS
    --paired-end
        Input reads are paired-end reads. (Default: off)

    --no-qualities
        Input reads do not contain quality scores. (Default: off)

    --strandedness <none|forward|reverse>
        This option defines the strandedness of the RNA-Seq reads. It
        recognizes three values: 'none', 'forward', and 'reverse'. 'none'
        refers to non-strand-specific protocols. 'forward' means all
        (upstream) reads are derived from the forward strand. 'reverse'
        means all (upstream) reads are derived from the reverse strand. If
        'forward'/'reverse' is set, the '--norc'/'--nofw' Bowtie/Bowtie 2
        option will also be enabled to avoid aligning reads to the opposite
        strand. For Illumina TruSeq Stranded protocols, please use
        'reverse'. (Default: 'none')

    -p/--num-threads <int>
        Number of threads to use. Both Bowtie/Bowtie2, expression estimation
        and 'samtools sort' will use this many threads. (Default: 1)

    --alignments
        Input file contains alignments in SAM/BAM/CRAM format. The exact
        file format will be determined automatically. (Default: off)

    --fai <file>
        If the header section of input alignment file does not contain
        reference sequence information, this option should be turned on.
        <file> is a FAI format file containing each reference sequence's
        name and length. Please refer to the SAM official website for the
        details of FAI format. (Default: off)

    --bowtie2
        Use Bowtie 2 instead of Bowtie to align reads. Since currently RSEM
        does not handle indel, local and discordant alignments, the Bowtie2
        parameters are set in a way to avoid those alignments. In
        particular, we use options '--sensitive --dpad 0 --gbar 99999999
        --mp 1,1 --np 1 --score-min L,0,-0.1' by default. The last parameter
        of '--score-min', '-0.1', is the negative of maximum mismatch rate.
        This rate can be set by option '--bowtie2-mismatch-rate'. If reads
        are paired-end, we additionally use options '--no-mixed' and
        '--no-discordant'. (Default: off)

    --star
        Use STAR to align reads. Alignment parameters are from ENCODE3's
        STAR-RSEM pipeline. To save computational time and memory resources,
        STAR's Output BAM file is unsorted. It is stored in RSEM's temporary
        directory with name as 'sample_name.bam'. Each STAR job will have
        its own private copy of the genome in memory. (Default: off)

    --hisat2-hca
        Use HISAT2 to align reads to the transcriptome according to Human
        Cell Atlast SMART-Seq2 pipeline. In particular, we use HISAT
        parameters "-k 10 --secondary --rg-id=$sampleToken --rg
        SM:$sampleToken --rg LB:$sampleToken --rg PL:ILLUMINA --rg
        PU:$sampleToken --new-summary --summary-file $sampleName.log
        --met-file $sampleName.hisat2.met.txt --met 5 --mp 1,1 --np 1
        --score-min L,0,-0.1 --rdg 99999999,99999999 --rfg 99999999,99999999
        --no-spliced-alignment --no-softclip --seed 12345". If inputs are
        paired-end reads, we additionally use parameters "--no-mixed
        --no-discordant". (Default: off)

    --append-names
        If gene_name/transcript_name is available, append it to the end of
        gene_id/transcript_id (separated by '_') in files
        'sample_name.isoforms.results' and 'sample_name.genes.results'.
        (Default: off)

    --seed <uint32>
        Set the seed for the random number generators used in calculating
        posterior mean estimates and credibility intervals. The seed must be
        a non-negative 32 bit integer. (Default: off)

    --single-cell-prior
        By default, RSEM uses Dirichlet(1) as the prior to calculate
        posterior mean estimates and credibility intervals. However, much
        less genes are expressed in single cell RNA-Seq data. Thus, if you
        want to compute posterior mean estimates and/or credibility
        intervals and you have single-cell RNA-Seq data, you are recommended
        to turn on this option. Then RSEM will use Dirichlet(0.1) as the
        prior which encourage the sparsity of the expression levels.
        (Default: off)

    --calc-pme
        Run RSEM's collapsed Gibbs sampler to calculate posterior mean
        estimates. (Default: off)

    --calc-ci
        Calculate 95% credibility intervals and posterior mean estimates.
        The credibility level can be changed by setting
        '--ci-credibility-level'. (Default: off)

    -q/--quiet
        Suppress the output of logging information. (Default: off)

    -h/--help
        Show help information.

    --version
        Show version information.

OUTPUT OPTIONS
    --sort-bam-by-read-name
        Sort BAM file aligned under transcript coordidate by read name.
        Setting this option on will produce deterministic maximum likelihood
        estimations from independent runs. Note that sorting will take long
        time and lots of memory. (Default: off)

    --no-bam-output
        Do not output any BAM file. (Default: off)

    --sampling-for-bam
        When RSEM generates a BAM file, instead of outputting all alignments
        a read has with their posterior probabilities, one alignment is
        sampled according to the posterior probabilities. The sampling
        procedure includes the alignment to the "noise" transcript, which
        does not appear in the BAM file. Only the sampled alignment has a
        weight of 1. All other alignments have weight 0. If the "noise"
        transcript is sampled, all alignments appeared in the BAM file
        should have weight 0. (Default: off)

    --output-genome-bam
        Generate a BAM file, 'sample_name.genome.bam', with alignments
        mapped to genomic coordinates and annotated with their posterior
        probabilities. In addition, RSEM will call samtools (included in
        RSEM package) to sort and index the bam file.
        'sample_name.genome.sorted.bam' and
        'sample_name.genome.sorted.bam.bai' will be generated. (Default:
        off)

    --sort-bam-by-coordinate
        Sort RSEM generated transcript and genome BAM files by coordinates
        and build associated indices. (Default: off)

    --sort-bam-memory-per-thread <string>
        Set the maximum memory per thread that can be used by 'samtools
        sort'. <string> represents the memory and accepts suffices 'K/M/G'.
        RSEM will pass <string> to the '-m' option of 'samtools sort'. Note
        that the default used here is different from the default used by
        samtools. (Default: 1G)

ALIGNER OPTIONS
    --seed-length <int>
        Seed length used by the read aligner. Providing the correct value is
        important for RSEM. If RSEM runs Bowtie, it uses this value for
        Bowtie's seed length parameter. Any read with its or at least one of
        its mates' (for paired-end reads) length less than this value will
        be ignored. If the references are not added poly(A) tails, the
        minimum allowed value is 5, otherwise, the minimum allowed value is
        25. Note that this script will only check if the value >= 5 and give
        a warning message if the value < 25 but >= 5. (Default: 25)

    --phred33-quals
        Input quality scores are encoded as Phred+33. This option is used by
        Bowtie, Bowtie 2 and HISAT2. (Default: on)

    --phred64-quals
        Input quality scores are encoded as Phred+64 (default for GA
        Pipeline ver. >= 1.3). This option is used by Bowtie, Bowtie 2 and
        HISAT2. (Default: off)

    --solexa-quals
        Input quality scores are solexa encoded (from GA Pipeline ver. <
        1.3). This option is used by Bowtie, Bowtie 2 and HISAT2. (Default:
        off)

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

    --star-path <path>
        The path to STAR's executable. (Default: the path to STAR executable
        is assumed to be in user's PATH environment variable)

    --star-gzipped-read-file
        (STAR parameter) Input read file(s) is compressed by gzip. (Default:
        off)

    --star-bzipped-read-file
        (STAR parameter) Input read file(s) is compressed by bzip2.
        (Default: off)

    --star-output-genome-bam
        (STAR parameter) Save the BAM file from STAR alignment under genomic
        coordinate to 'sample_name.STAR.genome.bam'. This file is NOT sorted
        by genomic coordinate. In this file, according to STAR's manual,
        'paired ends of an alignment are always adjacent, and multiple
        alignments of a read are adjacent as well'. (Default: off)

    --hisat2-path <path>
        The path to HISAT2's executable. (Default: the path to HISAT2
        executable is assumed to be in user's PATH environment variable)

ADVANCED OPTIONS
    --tag <string>
        The name of the optional field used in the SAM input for identifying
        a read with too many valid alignments. The field should have the
        format <tagName>:i:<value>, where a <value> bigger than 0 indicates
        a read with too many alignments. (Default: "")

    --fragment-length-min <int>
        Minimum read/insert length allowed. This is also the value for the
        Bowtie/Bowtie2 -I option. (Default: 1)

    --fragment-length-max <int>
        Maximum read/insert length allowed. This is also the value for the
        Bowtie/Bowtie 2 -X option. (Default: 1000)

    --fragment-length-mean <double>
        (single-end data only) The mean of the fragment length distribution,
        which is assumed to be a Gaussian. (Default: -1, which disables use
        of the fragment length distribution)

    --fragment-length-sd <double>
        (single-end data only) The standard deviation of the fragment length
        distribution, which is assumed to be a Gaussian. (Default: 0, which
        assumes that all fragments are of the same length, given by the
        rounded value of --fragment-length-mean)

    --estimate-rspd
        Set this option if you want to estimate the read start position
        distribution (RSPD) from data. Otherwise, RSEM will use a uniform
        RSPD. (Default: off)

    --num-rspd-bins <int>
        Number of bins in the RSPD. Only relevant when '--estimate-rspd' is
        specified. Use of the default setting is recommended. (Default: 20)

    --gibbs-burnin <int>
        The number of burn-in rounds for RSEM's Gibbs sampler. Each round
        passes over the entire data set once. If RSEM can use multiple
        threads, multiple Gibbs samplers will start at the same time and all
        samplers share the same burn-in number. (Default: 200)

    --gibbs-number-of-samples <int>
        The total number of count vectors RSEM will collect from its Gibbs
        samplers. (Default: 1000)

    --gibbs-sampling-gap <int>
        The number of rounds between two succinct count vectors RSEM
        collects. If the count vector after round N is collected, the count
        vector after round N + <int> will also be collected. (Default: 1)

    --ci-credibility-level <double>
        The credibility level for credibility intervals. (Default: 0.95)

    --ci-memory <int>
        Maximum size (in memory, MB) of the auxiliary buffer used for
        computing credibility intervals (CI). (Default: 1024)

    --ci-number-of-samples-per-count-vector <int>
        The number of read generating probability vectors sampled per
        sampled count vector. The crebility intervals are calculated by
        first sampling P(C | D) and then sampling P(Theta | C) for each
        sampled count vector. This option controls how many Theta vectors
        are sampled per sampled count vector. (Default: 50)

    --keep-intermediate-files
        Keep temporary files generated by RSEM. RSEM creates a temporary
        directory, 'sample_name.temp', into which it puts all intermediate
        output files. If this directory already exists, RSEM overwrites all
        files generated by previous RSEM runs inside of it. By default,
        after RSEM finishes, the temporary directory is deleted. Set this
        option to prevent the deletion of this directory and the
        intermediate files inside of it. (Default: off)

    --temporary-folder <string>
        Set where to put the temporary files generated by RSEM. If the
        folder specified does not exist, RSEM will try to create it.
        (Default: sample_name.temp)

    --time
        Output time consumed by each step of RSEM to 'sample_name.time'.
        (Default: off)

PRIOR-ENHANCED RSEM OPTIONS
    --run-pRSEM
        Running prior-enhanced RSEM (pRSEM). Prior parameters, i.e.
        isoform's initial pseudo-count for RSEM's Gibbs sampling, will be
        learned from input RNA-seq data and an external data set. When pRSEM
        needs and only needs ChIP-seq peak information to partition isoforms
        (e.g. in pRSEM's default partition model), either ChIP-seq peak file
        (with the '--chipseq-peak-file' option) or ChIP-seq FASTQ files for
        target and input and the path for Bowtie executables are required
        (with the '--chipseq-target-read-files <string>',
        '--chipseq-control-read-files <string>', and '--bowtie-path <path>
        options), otherwise, ChIP-seq FASTQ files for target and control and
        the path to Bowtie executables are required. (Default: off)

    --chipseq-peak-file <string>
        Full path to a ChIP-seq peak file in ENCODE's narrowPeak, i.e.
        BED6+4, format. This file is used when running prior-enhanced RSEM
        in the default two-partition model. It partitions isoforms by
        whether they have ChIP-seq overlapping with their transcription
        start site region or not. Each partition will have its own prior
        parameter learned from a training set. This file can be either
        gzipped or ungzipped. (Default: "")

    --chipseq-target-read-files <string>
        Comma-separated full path of FASTQ read file(s) for ChIP-seq target.
        This option is used when running prior-enhanced RSEM. It provides
        information to calculate ChIP-seq peaks and signals. The file(s) can
        be either ungzipped or gzipped with a suffix '.gz' or '.gzip'. The
        options '--bowtie-path <path>' and '--chipseq-control-read-files
        <string>' must be defined when this option is specified. (Default:
        "")

    --chipseq-control-read-files <string>
        Comma-separated full path of FASTQ read file(s) for ChIP-seq conrol.
        This option is used when running prior-enhanced RSEM. It provides
        information to call ChIP-seq peaks. The file(s) can be either
        ungzipped or gzipped with a suffix '.gz' or '.gzip'. The options
        '--bowtie-path <path>' and '--chipseq-target-read-files <string>'
        must be defined when this option is specified. (Default: "")

    --chipseq-read-files-multi-targets <string>
        Comma-separated full path of FASTQ read files for multiple ChIP-seq
        targets. This option is used when running prior-enhanced RSEM, where
        prior is learned from multiple complementary data sets. It provides
        information to calculate ChIP-seq signals. All files can be either
        ungzipped or gzipped with a suffix '.gz' or '.gzip'. When this
        option is specified, the option '--bowtie-path <path>' must be
        defined and the option '--partition-model <string>' will be set to
        'cmb_lgt' automatically. (Default: "")

    --chipseq-bed-files-multi-targets <string>
        Comma-separated full path of BED files for multiple ChIP-seq
        targets. This option is used when running prior-enhanced RSEM, where
        prior is learned from multiple complementary data sets. It provides
        information of ChIP-seq signals and must have at least the first six
        BED columns. All files can be either ungzipped or gzipped with a
        suffix '.gz' or '.gzip'. When this option is specified, the option
        '--partition-model <string>' will be set to 'cmb_lgt' automatically.
        (Default: "")

    --cap-stacked-chipseq-reads
        Keep a maximum number of ChIP-seq reads that aligned to the same
        genomic interval. This option is used when running prior-enhanced
        RSEM, where prior is learned from multiple complementary data sets.
        This option is only in use when either
        '--chipseq-read-files-multi-targets <string>' or
        '--chipseq-bed-files-multi-targets <string>' is specified. (Default:
        off)

    --n-max-stacked-chipseq-reads <int>
        The maximum number of stacked ChIP-seq reads to keep. This option is
        used when running prior-enhanced RSEM, where prior is learned from
        multiple complementary data sets. This option is only in use when
        the option '--cap-stacked-chipseq-reads' is set. (Default: 5)

    --partition-model <string>
        A keyword to specify the partition model used by prior-enhanced
        RSEM. It must be one of the following keywords:

        - pk
          Partitioned by whether an isoform has a ChIP-seq peak overlapping
          with its transcription start site (TSS) region. The TSS region is
          defined as [TSS-500bp, TSS+500bp]. For simplicity, we refer this
          type of peak as 'TSS peak' when explaining other keywords.

        - pk_lgtnopk
          First partitioned by TSS peak. Then, for isoforms in the 'no TSS
          peak' set, a logistic model is employed to further classify them
          into two partitions.

        - lm3, lm4, lm5, or lm6
          Based on their ChIP-seq signals, isoforms are classified into 3,
          4, 5, or 6 partitions by a linear regression model.

        - nopk_lm2pk, nopk_lm3pk, nopk_lm4pk, or nopk_lm5pk
          First partitioned by TSS peak. Then, for isoforms in the 'with TSS
          peak' set, a linear regression model is employed to further
          classify them into 2, 3, 4, or 5 partitions.

        - pk_lm2nopk, pk_lm3nopk, pk_lm4nopk, or pk_lm5nopk
          First partitioned by TSS peak. Then, for isoforms in the 'no TSS
          peak' set, a linear regression model is employed to further
          classify them into 2, 3, 4, or 5 partitions.

        - cmb_lgt
          Using a logistic regression to combine TSS signals from multiple
          complementary data sets and partition training set isoform into
          'expressed' and 'not expressed'. This partition model is only in
          use when either '--chipseq-read-files-multi-targets <string>' or
          '--chipseq-bed-files-multi-targets <string> is specified.

        Parameters for all the above models are learned from a training set.
        For detailed explanations, please see prior-enhanced RSEM's paper.
        (Default: 'pk')

DEPRECATED OPTIONS
        The options in this section are deprecated. They are here only for
        compatibility reasons and may be removed in future releases.

    --sam
        Inputs are alignments in SAM format. (Default: off)

    --bam
        Inputs are alignments in BAM format. (Default: off)

    --strand-specific
        Equivalent to '--strandedness forward'. (Default: off)

    --forward-prob <double>
        Probability of generating a read from the forward strand of a
        transcript. Set to 1 for a strand-specific protocol where all
        (upstream) reads are derived from the forward strand, 0 for a
        strand-specific protocol where all (upstream) read are derived from
        the reverse strand, or 0.5 for a non-strand-specific protocol.
        (Default: off)

DESCRIPTION
    In its default mode, this program aligns input reads against a reference
    transcriptome with Bowtie and calculates expression values using the
    alignments. RSEM assumes the data are single-end reads with quality
    scores, unless the '--paired-end' or '--no-qualities' options are
    specified. Alternatively, users can use STAR to align reads using the
    '--star' option. RSEM has provided options in 'rsem-prepare-reference'
    to prepare STAR's genome indices. Users may use an alternative aligner
    by specifying '--alignments', and providing an alignment file in
    SAM/BAM/CRAM format. However, users should make sure that they align
    against the indices generated by 'rsem-prepare-reference' and the
    alignment file satisfies the requirements mentioned in ARGUMENTS
    section.

    One simple way to make the alignment file satisfying RSEM's requirements
    is to use the 'convert-sam-for-rsem' script. This script accepts
    SAM/BAM/CRAM files as input and outputs a BAM file. For example, type
    the following command to convert a SAM file, 'input.sam', to a
    ready-for-use BAM file, 'input_for_rsem.bam':

      convert-sam-for-rsem input.sam input_for_rsem

    For details, please refer to 'convert-sam-for-rsem's documentation page.

NOTES
    1. Users must run 'rsem-prepare-reference' with the appropriate
    reference before using this program.

    2. For single-end data, it is strongly recommended that the user provide
    the fragment length distribution parameters (--fragment-length-mean and
    --fragment-length-sd). For paired-end data, RSEM will automatically
    learn a fragment length distribution from the data.

    3. Some aligner parameters have default values different from their
    original settings.

    4. With the '--calc-pme' option, posterior mean estimates will be
    calculated in addition to maximum likelihood estimates.

    5. With the '--calc-ci' option, 95% credibility intervals and posterior
    mean estimates will be calculated in addition to maximum likelihood
    estimates.

    6. The temporary directory and all intermediate files will be removed
    when RSEM finishes unless '--keep-intermediate-files' is specified.

    With the '--run-pRSEM' option and associated options (see section
    'PRIOR-ENHANCED RSEM OPTIONS' above for details), prior-enhanced RSEM
    will be running. Prior parameters will be learned from supplied external
    data set(s) and assigned as initial pseudo-counts for isoforms in the
    corresponding partition for Gibbs sampling.

OUTPUT
    sample_name.isoforms.results
        File containing isoform level expression estimates. The first line
        contains column names separated by the tab character. The format of
        each line in the rest of this file is:

        transcript_id gene_id length effective_length expected_count TPM
        FPKM IsoPct [posterior_mean_count
        posterior_standard_deviation_of_count pme_TPM pme_FPKM
        IsoPct_from_pme_TPM TPM_ci_lower_bound TPM_ci_upper_bound
        TPM_coefficient_of_quartile_variation FPKM_ci_lower_bound
        FPKM_ci_upper_bound FPKM_coefficient_of_quartile_variation]

        Fields are separated by the tab character. Fields within "[]" are
        optional. They will not be presented if neither '--calc-pme' nor
        '--calc-ci' is set.

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
        from background noise; 2) RSEM may filter some alignable low quality
        reads, the sum of expected counts for all transcript are generally
        less than the total number of reads aligned.

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

        'posterior_mean_count', 'pme_TPM', 'pme_FPKM' are posterior mean
        estimates calculated by RSEM's Gibbs sampler.
        'posterior_standard_deviation_of_count' is the posterior standard
        deviation of counts. 'IsoPct_from_pme_TPM' is the isoform percentage
        calculated from 'pme_TPM' values.

        'TPM_ci_lower_bound', 'TPM_ci_upper_bound', 'FPKM_ci_lower_bound'
        and 'FPKM_ci_upper_bound' are lower(l) and upper(u) bounds of 95%
        credibility intervals for TPM and FPKM values. The bounds are
        inclusive (i.e. [l, u]).

        'TPM_coefficient_of_quartile_variation' and
        'FPKM_coefficient_of_quartile_variation' are coefficients of
        quartile variation (CQV) for TPM and FPKM values. CQV is a robust
        way of measuring the ratio between the standard deviation and the
        mean. It is defined as

        CQV := (Q3 - Q1) / (Q3 + Q1),

        where Q1 and Q3 are the first and third quartiles.

    sample_name.genes.results
        File containing gene level expression estimates. The first line
        contains column names separated by the tab character. The format of
        each line in the rest of this file is:

        gene_id transcript_id(s) length effective_length expected_count TPM
        FPKM [posterior_mean_count posterior_standard_deviation_of_count
        pme_TPM pme_FPKM TPM_ci_lower_bound TPM_ci_upper_bound
        TPM_coefficient_of_quartile_variation FPKM_ci_lower_bound
        FPKM_ci_upper_bound FPKM_coefficient_of_quartile_variation]

        Fields are separated by the tab character. Fields within "[]" are
        optional. They will not be presented if neither '--calc-pme' nor
        '--calc-ci' is set.

        'transcript_id(s)' is a comma-separated list of transcript_ids
        belonging to this gene. If no gene information is provided,
        'gene_id' and 'transcript_id(s)' are identical (the
        'transcript_id').

        A gene's 'length' and 'effective_length' are defined as the weighted
        average of its transcripts' lengths and effective lengths (weighted
        by 'IsoPct'). A gene's abundance estimates are just the sum of its
        transcripts' abundance estimates.

    sample_name.alleles.results
        Only generated when the RSEM references are built with
        allele-specific transcripts.

        This file contains allele level expression estimates for
        allele-specific expression calculation. The first line contains
        column names separated by the tab character. The format of each line
        in the rest of this file is:

        allele_id transcript_id gene_id length effective_length
        expected_count TPM FPKM AlleleIsoPct AlleleGenePct
        [posterior_mean_count posterior_standard_deviation_of_count pme_TPM
        pme_FPKM AlleleIsoPct_from_pme_TPM AlleleGenePct_from_pme_TPM
        TPM_ci_lower_bound TPM_ci_upper_bound
        TPM_coefficient_of_quartile_variation FPKM_ci_lower_bound
        FPKM_ci_upper_bound FPKM_coefficient_of_quartile_variation]

        Fields are separated by the tab character. Fields within "[]" are
        optional. They will not be presented if neither '--calc-pme' nor
        '--calc-ci' is set.

        'allele_id' is the allele-specific name of this allele-specific
        transcript.

        'AlleleIsoPct' stands for allele-specific percentage on isoform
        level. It is the percentage of this allele-specific transcript's
        abundance over its parent transcript's abundance. If its parent
        transcript has only one allele variant form, this field will be set
        to 100.

        'AlleleGenePct' stands for allele-specific percentage on gene level.
        It is the percentage of this allele-specific transcript's abundance
        over its parent gene's abundance.

        'AlleleIsoPct_from_pme_TPM' and 'AlleleGenePct_from_pme_TPM' have
        similar meanings. They are calculated based on posterior mean
        estimates.

        Please note that if this file is present, the fields 'length' and
        'effective_length' in 'sample_name.isoforms.results' should be
        interpreted similarly as the corresponding definitions in
        'sample_name.genes.results'.

    sample_name.transcript.bam
        Only generated when --no-bam-output is not specified.

        'sample_name.transcript.bam' is a BAM-formatted file of read
        alignments in transcript coordinates. The MAPQ field of each
        alignment is set to min(100, floor(-10 * log10(1.0 - w) + 0.5)),
        where w is the posterior probability of that alignment being the
        true mapping of a read. In addition, RSEM pads a new tag ZW:f:value,
        where value is a single precision floating number representing the
        posterior probability. Because this file contains all alignment
        lines produced by bowtie or user-specified aligners, it can also be
        used as a replacement of the aligner generated BAM/SAM file.

    sample_name.transcript.sorted.bam and
    sample_name.transcript.sorted.bam.bai
        Only generated when --no-bam-output is not specified and
        --sort-bam-by-coordinate is specified.

        'sample_name.transcript.sorted.bam' and
        'sample_name.transcript.sorted.bam.bai' are the sorted BAM file and
        indices generated by samtools (included in RSEM package).

    sample_name.genome.bam
        Only generated when --no-bam-output is not specified and
        --output-genome-bam is specified.

        'sample_name.genome.bam' is a BAM-formatted file of read alignments
        in genomic coordinates. Alignments of reads that have identical
        genomic coordinates (i.e., alignments to different isoforms that
        share the same genomic region) are collapsed into one alignment. The
        MAPQ field of each alignment is set to min(100, floor(-10 *
        log10(1.0 - w) + 0.5)), where w is the posterior probability of that
        alignment being the true mapping of a read. In addition, RSEM pads a
        new tag ZW:f:value, where value is a single precision floating
        number representing the posterior probability. If an alignment is
        spliced, a XS:A:value tag is also added, where value is either '+'
        or '-' indicating the strand of the transcript it aligns to.

    sample_name.genome.sorted.bam and sample_name.genome.sorted.bam.bai
        Only generated when --no-bam-output is not specified, and
        --sort-bam-by-coordinate and --output-genome-bam are specified.

        'sample_name.genome.sorted.bam' and
        'sample_name.genome.sorted.bam.bai' are the sorted BAM file and
        indices generated by samtools (included in RSEM package).

    sample_name.time
        Only generated when --time is specified.

        It contains time (in seconds) consumed by aligning reads, estimating
        expression levels and calculating credibility intervals.

    sample_name.log
        Only generated when --alignments is not specified.

        It captures alignment statistics outputted from the user-specified
        aligner.

    sample_name.stat
        This is a folder instead of a file. All model related statistics are
        stored in this folder. Use 'rsem-plot-model' can generate plots
        using this folder.

        'sample_name.stat/sample_name.cnt' contains alignment statistics.
        The format and meanings of each field are described in
        'cnt_file_description.txt' under RSEM directory.

        'sample_name.stat/sample_name.model' stores RNA-Seq model parameters
        learned from the data. The format and meanings of each filed of this
        file are described in 'model_file_description.txt' under RSEM
        directory.

        The following four output files will be generated only by
        prior-enhanced RSEM

        - 'sample_name.stat/sample_name_prsem.all_tr_features'
          It stores isofrom features for deriving and assigning pRSEM prior.
          The first line is a header and the rest is one isoform per line.
          The description for each column is:

          * trid: transcript ID from input annotation

          * geneid: gene ID from input anntation

          * chrom: isoform's chromosome name

          * strand: isoform's strand name

          * start: isoform's end with the lowest genomic loci

          * end: isoform's end with the highest genomic loci

          * tss_mpp: average mappability of [TSS-500bp, TSS+500bp], where
            TSS is isoform's transcription start site, i.e. 5'-end

          * body_mpp: average mappability of (TSS+500bp, TES-500bp), where
            TES is isoform's transcription end site, i.e. 3'-end

          * tes_mpp: average mappability of [TES-500bp, TES+500bp]

          * pme_count: isoform's fragment or read count from RSEM's
            posterior mean estimates

          * tss: isoform's TSS loci

          * tss_pk: equal to 1 if isoform's [TSS-500bp, TSS+500bp] region
            overlaps with a RNA Pol II peak; 0 otherwise

          * is_training: equal to 1 if isoform is in the training set where
            Pol II prior is learned; 0 otherwise

        - 'sample_name.stat/sample_name_prsem.all_tr_prior'
          It stores prior parameters for every isoform. This file does not
          have a header. Each line contains a prior parameter and an
          isoform's transcript ID delimited by ` # `.

        - 'sample_name.stat/sample_name_uniform_prior_1.isoforms.results'
          RSEM's posterior mean estimates on the isoform level with an
          initial pseudo-count of one for every isoform. It is in the same
          format as the 'sample_name.isoforms.results'.

        - 'sample_name.stat/sample_name_uniform_prior_1.genes.results'
          RSEM's posterior mean estimates on the gene level with an initial
          pseudo-count of one for every isoform. It is in the same format as
          the 'sample_name.genes.results'.

        When learning prior from multiple external data sets in
        prior-enhanced RSEM, two additional output files will be generated.

        - 'sample_name.stat/sample_name.pval_LL'
          It stores a p-value and a log-likelihood. The p-value indicates
          whether the combination of multiple complementary data sets is
          informative for RNA-seq quantification. The log-likelihood shows
          how well pRSEM's Dirichlet-multinomial model fits the read counts
          of partitioned training set isoforms.

        - 'sample_name.stat/sample_name.lgt_mdl.RData'
          It stores an R object named 'glmmdl', which is a logistic
          regression model on the training set isoforms and multiple
          external data sets.

        In addition, extra columns will be added to
        'sample_name.stat/all_tr_features'

        * is_expr: equal to 1 if isoform has an abundance >= 1 TPM and a
          non-zero read count from RSEM's posterior mean estimates; 0
          otherwise

        * "$external_data_set_basename": log10 of external data's signal at
          [TSS-500, TSS+500]. Signal is the number of reads aligned within
          that interval and normalized to RPKM by read depth and interval
          length. It will be set to -4 if no read aligned to that interval.

          There are multiple columns like this one, where each represents an
          external data set.

        * prd_expr_prob: predicted probability from logistic regression
          model on whether this isoform is expressed or not. A probability
          higher than 0.5 is considered as expressed

        * partition: group index, to which this isoforms is partitioned

        * prior: prior parameter for this isoform

EXAMPLES
    Assume the path to the bowtie executables is in the user's PATH
    environment variable. Reference files are under '/ref' with name
    'mouse_125'.

    1) '/data/mmliver.fq', single-end reads with quality scores. Quality
    scores are encoded as for 'GA pipeline version >= 1.3'. We want to use 8
    threads and generate a genome BAM file. In addition, we want to append
    gene/transcript names to the result files:

     rsem-calculate-expression --phred64-quals \
                               -p 8 \
                               --append-names \
                               --output-genome-bam \
                               /data/mmliver.fq \
                               /ref/mouse_125 \
                               mmliver_single_quals

    2) '/data/mmliver_1.fq' and '/data/mmliver_2.fq', stranded paired-end
    reads with quality scores. Suppose the library is prepared using TruSeq
    Stranded Kit, which means the first mate should map to the reverse
    strand. Quality scores are in SANGER format. We want to use 8 threads
    and do not generate a genome BAM file:

     rsem-calculate-expression -p 8 \
                               --paired-end \
                               --strandedness reverse \
                               /data/mmliver_1.fq \
                               /data/mmliver_2.fq \
                               /ref/mouse_125 \
                               mmliver_paired_end_quals

    3) '/data/mmliver.fa', single-end reads without quality scores. We want
    to use 8 threads:

     rsem-calculate-expression -p 8 \
                               --no-qualities \
                               /data/mmliver.fa \
                               /ref/mouse_125 \
                               mmliver_single_without_quals

    4) Data are the same as 1). This time we assume the bowtie executables
    are under '/sw/bowtie'. We want to take a fragment length distribution
    into consideration. We set the fragment length mean to 150 and the
    standard deviation to 35. In addition to a BAM file, we also want to
    generate credibility intervals. We allow RSEM to use 1GB of memory for
    CI calculation:

     rsem-calculate-expression --bowtie-path /sw/bowtie \
                               --phred64-quals \
                               --fragment-length-mean 150.0 \
                               --fragment-length-sd 35.0 \
                               -p 8 \
                               --output-genome-bam \
                               --calc-ci \
                               --ci-memory 1024 \
                               /data/mmliver.fq \
                               /ref/mouse_125 \
                               mmliver_single_quals

    5) '/data/mmliver_paired_end_quals.bam', BAM-formatted alignments for
    paired-end reads with quality scores. We want to use 8 threads:

     rsem-calculate-expression --paired-end \
                               --alignments \
                               -p 8 \
                               /data/mmliver_paired_end_quals.bam \
                               /ref/mouse_125 \
                               mmliver_paired_end_quals

    6) '/data/mmliver_1.fq.gz' and '/data/mmliver_2.fq.gz', paired-end reads
    with quality scores and read files are compressed by gzip. We want to
    use STAR to aligned reads and assume STAR executable is '/sw/STAR'.
    Suppose we want to use 8 threads and do not generate a genome BAM file:

     rsem-calculate-expression --paired-end \
                               --star \
                               --star-path /sw/STAR \
                               --gzipped-read-file \
                               --paired-end \
                               -p 8 \
                               /data/mmliver_1.fq.gz \
                               /data/mmliver_2.fq.gz \
                               /ref/mouse_125 \
                               mmliver_paired_end_quals

    7) In the above example, suppose we want to run prior-enhanced RSEM
    instead. Assuming we want to learn priors from a ChIP-seq peak file
    '/data/mmlive.narrowPeak.gz':

     rsem-calculate-expression --star \
                               --star-path /sw/STAR \
                               --gzipped-read-file \
                               --paired-end \
                               --calc-pme \
                               --run-pRSEM \
                               --chipseq-peak-file /data/mmliver.narrowPeak.gz \
                               -p 8 \
                               /data/mmliver_1.fq.gz \
                               /data/mmliver_2.fq.gz \
                               /ref/mouse_125 \
                               mmliver_paired_end_quals

    8) Similar to the example in 7), suppose we want to use the partition
    model 'pk_lm2nopk' (partitioning isoforms by Pol II TSS peak first and
    then partitioning 'no TSS peak' isoforms into two bins by a linear
    regression model), and we want to partition isoforms by RNA Pol II's
    ChIP-seq read files '/data/mmliver_PolIIRep1.fq.gz' and
    '/data/mmliver_PolIIRep2.fq.gz', and the control ChIP-seq read files
    '/data/mmliver_ChIPseqCtrl.fq.gz'. Also, assuming Bowtie's executables
    are under '/sw/bowtie/':

     rsem-calculate-expression --star \
                               --star-path /sw/STAR \
                               --gzipped-read-file \
                               --paired-end \
                               --calc-pme \
                               --run-pRSEM \
                               --chipseq-target-read-files /data/mmliver_PolIIRep1.fq.gz,/data/mmliver_PolIIRep2.fq.gz \
                               --chipseq-control-read-files /data/mmliver_ChIPseqCtrl.fq.gz \
                               --partition-model pk_lm2nopk \
                               --bowtie-path /sw/bowtie \
                               -p 8 \
                               /data/mmliver_1.fq.gz \
                               /data/mmliver_2.fq.gz \
                               /ref/mouse_125 \
                               mmliver_paired_end_quals

    9) Similar to the example in 8), suppose we want to derive prior from
    four histone modification ChIP-seq read data sets:
    '/data/H3K27Ac.fastq.gz', '/data/H3K4me1.fastq.gz',
    '/data/H3K4me2.fastq.gz', and '/data/H3K4me3.fastq.gz'. Also, assuming
    Bowtie's executables are under '/sw/bowtie/':

     rsem-calculate-expression --star \
                               --star-path /sw/STAR \
                               --gzipped-read-file \
                               --paired-end \
                               --calc-pme \
                               --run-pRSEM \
                               --partition-model cmb_lgt \
                               --chipseq-read-files-multi-targets /data/H3K27Ac.fastq.gz,/data/H3K4me1.fastq.gz,/data/H3K4me2.fastq.gz,/data/H3K4me3.fastq.gz \
                               --bowtie-path /sw/bowtie \
                               -p 8 \
                               /data/mmliver_1.fq.gz \
                               /data/mmliver_2.fq.gz \
                               /ref/mouse_125 \
                               mmliver_paired_end_quals
```


## rsem_rsem-generate-data-matrix

### Tool Description
All result files should have the same file type. The 'expected_count' columns of every result file are extracted to form the data matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-generate-data-matrix sampleA.[alleles/genes/isoforms].results sampleB.[alleles/genes/isoforms].results ... > output_name.matrix
All result files should have the same file type. The 'expected_count' columns of every result file are extracted to form the data matrix.
```


## rsem_rsem-parse-alignments

### Tool Description
Parse a read-name sorted SAM/BAM/CRAM alignment file into RSEM's intermediate files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage : rsem-parse-alignments refName imdName statName alignF read_type [-t fai_file] [-tag tagName] [-q]
```

## rsem_rsem-build-read-index

### Tool Description
Build a read index (.ridx) for each read file, for RSEM's EM step.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage : rsem-build-read-index gap hasQ quiet readFile1, readFile2, ...
```

## rsem_rsem-run-em

### Tool Description
Run RSEM's expectation-maximization algorithm on the intermediate files and write isoform and gene estimates.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage : rsem-run-em refName read_type sampleName imdName statName [-p #Threads] [-b samInpF has_fai? [fai_file]] [-q] [--gibbs-out] [--sampling] [--seed seed] [--append-names]

  refName: reference name
  read_type: 0 single read without quality score; 1 single read with quality score; 2 paired-end read without quality score; 3 paired-end read with quality score.
  sampleName: sample's name, including the path
  sampleToken: sampleName excludes the path
  -p: number of threads which user wants to use. (default: 1)
  -b: produce bam format output file. (default: off)
  -q: set it quiet
  --gibbs-out: generate output file used by Gibbs sampler. (default: off)
  --sampling: sample each read from its posterior distribution when BAM file is generated. (default: off)
  --seed uint32: the seed used for the BAM sampling. (default: off)
  --append-names: append transcript_name/gene_name when available. (default: off)
// model parameters should be in imdName.mparams.
```

## rsem_rsem-run-gibbs

### Tool Description
Run RSEM's Gibbs sampler on the files made by rsem-run-em and write posterior mean estimates and count samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-run-gibbs reference_name imdName statName BURNIN NSAMPLES GAP [-p #Threads] [--seed seed] [--pseudo-count pseudo_count] [--prior file] [-q]

Format of the prior file:
- One isoform's prior per line
- Priors must be in the same order as in the .ti file
- Priors for those to-be-omitted isoforms must be included as well
- Comments can be added after prior separated by space(s)
```

## rsem_rsem-scan-for-paired-end-reads

### Tool Description
Scan a SAM/BAM/CRAM file and write a BAM file of its paired-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-scan-for-paired-end-reads number_of_threads input.[sam/bam/cram] output.bam
```

## rsem_rsem-synthesis-reference-transcripts

### Tool Description
Build the RSEM transcript reference files (.transcripts.fa, .ti, .grp) from transcript FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: synthesisRef refName quiet hasMappingFile<0,no;1,yes;2,allele-specific> [mappingFile] reference_file_1 [reference_file_2 ...]
```

## rsem_rsem-preref

### Tool Description
Pad poly(A) tails onto the reference transcripts and write the RSEM reference sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE : rsem-preref refFastaF polyAChoice refName [-l polyALen] [-f exceptionF] [-q]

  refFastaF: a FASTA format file contains all reference transcripts
  polyAChoice: choice for polyA tail padding.It is a number from {0,1,2}
    0: pad polyA tail
    1: do not pad polyA tail at all
    2: pad polyA tail for all references but those in exceptionF
  -l: polyALen: specify the length of polyA tail you want to pad. Default is 100
  -f: exceptionF: file contains a list of exception reference ids. IDs starts from 1. Must set if polyAChoice = 2
  -q: quiet
```

## rsem_rsem-refseq-extract-primary-assembly

### Tool Description
Extract the primary assembly sequences from an NCBI RefSeq top-level assembly FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-refseq-extract-primary-assembly input_top_level_assembly.fna output_primary_assembly.fna
```

## rsem_rsem-for-ebseq-calculate-clustering-info

### Tool Description
Calculate k-mer clustering information for the transcripts of a reference FASTA file (EBSeq input).

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-for-ebseq-calculate-clustering-info k input_reference_fasta_file output_file
```

## rsem_rsem-for-ebseq-find-DE

### Tool Description
Find differentially expressed genes or isoforms with EBSeq from a data matrix of expected counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-for-ebseq-find-DE path ngvector_file data_matrix_file output_file number_of_replicate_for_condition_1 number_of_replicate_for_condition_2 ...
```

## rsem_rsem-for-ebseq-generate-ngvector-from-clustering-info

### Tool Description
Generate the EBSeq NgVector file from the clustering information file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-for-ebseq-generate-ngvector-from-clustering-info input_file output_file
```

## rsem_rsem-plot-transcript-wiggles

### Tool Description
Generate PDF wiggle plots from transcript or gene ids.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Invalid number of arguments!
NAME
    rsem-plot-transcript-wiggles - Generate PDF wiggle plots from transcript
    or gene ids

SYNOPSIS
     rsem-plot-transcript-wiggles [options] sample_name input_list output_plot_file

ARGUMENTS
    sample_name
        The name of the sample analyzed.

    input_list
        A list of transcript ids or gene ids. But it cannot be a mixture of
        transcript & gene ids. Each id occupies one line without extra
        spaces.

    output_plot_file
        The file name of the pdf file which contains all plots.

OPTIONS
    --gene-list
        The input-list is a list of gene ids. (Default: off)

    --transcript-list
        The input-list is a list of transcript ids. This option can only be
        turned on if allele-specific expression is calculated. (Default:
        off)

    --show-unique
        Show the wiggle plots as stacked bar plots. See description section
        for details. (Default: off)

    -p/--num-threads <int>
        Set the number of threads we can use. (Default: 1)

    --memory-per-thread <string>
        Set the maximum allowable memory per thread. <string> represents the
        memory and accepts suffices 'K/M/G'. (Default: 1G)

    -h/--help
        Show help information.

DESCRIPTION
    This program generates transcript wiggle plots and outputs them in a pdf
    file. This program can accept either a list of transcript ids or gene
    ids (if transcript to gene mapping information is provided) and has two
    modes of showing wiggle plots. If '--show-unique' is not specified, the
    wiggle plot for each transcript is a histogram where each position has
    the expected read depth at this position as its height. If
    '--show-unique' is specified, for each transcript a stacked bar plot is
    generated. For each position, the read depth of unique reads, which have
    only one alignment, is showed in black. The read depth of multi-reads,
    which align to more than one places, is showed in red on top of the read
    depth of unique reads.This program will use some files RSEM generated
    previouslly. So please do not delete/move any file
    'rsem-calculate-expression' generated. If allele-specific expression is
    calculated, the basic unit for plotting is an allele-specific transcript
    and plots can be grouped by either transcript ids (--transcript-list) or
    gene ids (--gene-list).

OUTPUT
    output_plot_file
        This is a pdf file containing all plots generated. If a list of
        transcript ids is provided, each page display at most 6 plots in 3
        rows and 2 columns. If gene ids are provided, each page display a
        gene. The gene's id is showed at the top and all its transcripts'
        wiggle plots are showed in this page. The arrangement of plots is
        determined automatically. For each transcript wiggle plot, the
        transcript id is displayed as title. x-axis is position in the
        transcript and y-axis is read depth. If allele-specific expression
        is calculated, the basin unit becomes an allele-specific transcript
        and transcript ids and gene ids can be used to group allele-specific
        transcripts.

    sample_name.transcript.sorted.bam and sample_name.transcript.readdepth
        If these files do not exist, 'rsem-plot-transcript-wiggles' will
        automatically generate them.

    sample_name.uniq.transcript.bam, sample_name.uniq.transcript.sorted.bam
    and sample_name.uniq.transcript.readdepth
        If '--show-unique' option is specified and these files do not exist,
        'rsem-plot-transcript-wiggles' will automatically generate them.

EXAMPLES
    Suppose sample_name and output_plot_file are set to
    'mmliver_single_quals' and 'output.pdf' respectively. input_list is set
    to 'transcript_ids.txt' if transcript ids are provided, and is set to
    'gene_ids.txt' if gene ids are provided.

    1) Transcript ids are provided and we just want normal wiggle plots:

     rsem-plot-transcript-wiggles mmliver_single_quals transcript_ids.txt output.pdf

    2) Gene ids are provided and we want to show stacked bar plots:

     rsem-plot-transcript-wiggles --gene-list --show-unique mmliver_single_quals gene_ids.txt output.pdf
```

## rsem_convert-sam-for-rsem

### Tool Description
Make a RSEM compatible BAM file from a SAM/BAM/CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    convert-sam-for-rsem - Make a RSEM compatible BAM file.

SYNOPSIS
     convert-sam-for-rsem [options] <input.sam/input.bam/input.cram> output_file_name

ARGUMENTS
    input.sam/input.bam/input.cram
        The SAM/BAM/CRAM file generated by user's aligner. We require this
        file contains the header section.

    output_file_name
        The output name for the converted file. 'convert-sam-for-rsem' will
        output a BAM with the name 'output_file_name.bam'.

OPTIONS
    -p/--num-threads <int>
        Set the number of threads to be used for converting. (Default: 1)

    --memory-per-thread <string>
        Set the maximum allowable memory per thread. <string> represents the
        memory and accepts suffices 'K/M/G'. (Default: 1G)

    -h/--help
        Show help information.

DESCRIPTION
    This program converts the SAM/BAM/CRAM file generated by user's aligner
    into a BAM file which RSEM can process. However, users should make sure
    their aligners use 'reference_name.idx.fa' generated by
    'rsem-prepare-reference' as their references and output header sections.
    After the conversion, this program will call 'rsem-sam-validator' to
    validate the resulting BAM file.

    Note: You do not need to run this script if `rsem-sam-validator' reports
    that your SAM/BAM/CRAM file is valid.

EXAMPLES
    Suppose input is set to 'input.sam' and output file name is "output"

     convert-sam-for-rsem input.sam output

    We will get a file called 'output.bam' as output.
```

## rsem_rsem-bam2wig

### Tool Description
Generate a wiggle (read coverage) file from a sorted SAM/BAM/CRAM alignment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Number of arguments is not correct!
Usage: rsem-bam2wig sorted_alignment_file wig_output wiggle_name [--no-fractional-weight]
sorted_alignment_file	: Can be either in SAM/BAM/CRAM format, must be sorted
wig_output		: Output wiggle file's name, e.g. output.wig
wiggle_name		: the name of this wiggle plot
--no-fractional-weight	: If this is set, RSEM will not look for "ZW" tag and each alignment appeared in the BAM file has weight 1. Set this if your BAM file is not generated by RSEM. Please note that this option must be at the end of the command line.
```

## rsem_rsem-bam2readdepth

### Tool Description
Compute the read depth of every transcript from a sorted BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-bam2readdepth sorted_bam_input readdepth_output
```

## rsem_rsem-sam-validator

### Tool Description
Validate that a SAM/BAM/CRAM file can be used as input for RSEM.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-sam-validator <input.sam/input.bam/input.cram>
```

## rsem_rsem-plot-model

### Tool Description
Plot the model files learned by rsem-calculate-expression into a PDF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-plot-model sample_name output_plot_file
```

## rsem_rsem-simulate-reads

### Tool Description
Simulate RNA-Seq reads from a learned RSEM model and isoform expression levels.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-simulate-reads reference_name estimated_model_file estimated_isoform_results theta0 N output_name [--seed seed] [-q]

Parameters:

reference_name: The name of RSEM references, which should be already generated by 'rsem-prepare-reference'
estimated_model_file: This file describes how the RNA-Seq reads will be sequenced given the expression levels. It determines what kind of reads will be simulated (single-end/paired-end, w/o quality score) and includes parameters for fragment length distribution, read start position distribution, sequencing error models, etc. Normally, this file should be learned from real data using 'rsem-calculate-expression'. The file can be found under the 'sample_name.stat' folder with the name of 'sample_name.model'
estimated_isoform_results: This file contains expression levels for all isoforms recorded in the reference. It can be learned using 'rsem-calculate-expression' from real data. The corresponding file users want to use is 'sample_name.isoforms.results'. If simulating from user-designed expression profile is desired, start from a learned 'sample_name.isoforms.results' file and only modify the 'TPM' column. The simulator only reads the TPM column. But keeping the file format the same is required. If the RSEM references built are aware of allele-specific transcripts, 'sample_name.alleles.results' should be used instead.
theta0: This parameter determines the fraction of reads that are coming from background "noise" (instead of from a transcript). It can also be estimated using 'rsem-calculate-expression' from real data. Users can find it as the first value of the third line of the file 'sample_name.stat/sample_name.theta'.
N: The total number of reads to be simulated. If 'rsem-calculate-expression' is executed on a real data set, the total number of reads can be found as the 4th number of the first line of the file 'sample_name.stat/sample_name.cnt'.
output_name: Prefix for all output files.
--seed seed: Set seed for the random number generator used in simulation. The seed should be a 32-bit unsigned integer.
-q: Set it will stop outputting intermediate information.

Outputs:

output_name.sim.isoforms.results, output_name.sim.genes.results: Expression levels estimated by counting where each simulated read comes from.
output_name.sim.alleles.results: Allele-specific expression levels estimated by counting where each simulated read comes from.

output_name.fa if single-end without quality score;
output_name.fq if single-end with quality score;
output_name_1.fa & output_name_2.fa if paired-end without quality score;
output_name_1.fq & output_name_2.fq if paired-end with quality score.

Format of the header line: Each simulated read's header line encodes where it comes from. The header line has the format:

	{>/@}_rid_dir_sid_pos[_insertL]

{>/@}: Either '>' or '@' must appear. '>' appears if FASTA files are generated and '@' appears if FASTQ files are generated
rid: Simulated read's index, numbered from 0
dir: The direction of the simulated read. 0 refers to forward strand ('+') and 1 refers to reverse strand ('-')
sid: Represent which transcript this read is simulated from. It ranges between 0 and M, where M is the total number of transcripts. If sid=0, the read is simulated from the background noise. Otherwise, the read is simulated from a transcript with index sid. Transcript sid's transcript name can be found in the 'transcript_id' column of the 'sample_name.isoforms.results' file (at line sid + 1, line 1 is for column names)
pos: The start position of the simulated read in strand dir of transcript sid. It is numbered from 0
insertL: Only appear for paired-end reads. It gives the insert length of the simulated read.

Example:

Suppose we want to simulate 50 millon single-end reads with quality scores and use the parameters learned from [Example](#example). In addition, we set theta0 as 0.2 and output_name as 'simulated_reads'. The command is:

	rsem-simulate-reads /ref/mouse_125 mmliver_single_quals.stat/mmliver_single_quals.model mmliver_single_quals.isoforms.results 0.2 50000000 simulated_reads
```

## rsem_rsem-run-ebseq

### Tool Description
Wrapper for EBSeq to perform differential expression analysis on two or more conditions.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    rsem-run-ebseq - Wrapper for EBSeq to perform differential expression
    analysis.

SYNOPSIS
    rsem-run-ebseq [options] data_matrix_file conditions output_file

ARGUMENTS
    data_matrix_file
        This file is a m by n matrix. m is the number of genes/transcripts
        and n is the number of total samples. Each element in the matrix
        represents the expected count for a particular gene/transcript in a
        particular sample. Users can use 'rsem-generate-data-matrix' to
        generate this file from expression result files.

    conditions
        Comma-separated list of values representing the number of replicates
        for each condition. For example, "3,3" means the data set contains 2
        conditions and each condition has 3 replicates. "2,3,3" means the
        data set contains 3 conditions, with 2, 3, and 3 replicates for each
        condition respectively.

    output_file
        Output file name.

OPTIONS
    --ngvector <file>
        This option provides the grouping information required by EBSeq for
        isoform-level differential expression analysis. The file can be
        generated by 'rsem-generate-ngvector'. Turning this option on is
        highly recommended for isoform-level differential expression
        analysis. (Default: off)

    -h/--help
        Show help information.

DESCRIPTION
    This program is a wrapper over EBSeq. It performs differential
    expression analysis and can work on two or more conditions. All
    genes/transcripts and their associated statistcs are reported in one
    output file. This program does not control false discovery rate and call
    differential expressed genes/transcripts. Please use 'rsem-control-fdr'
    to control false discovery rate after this program is finished.

OUTPUT
    output_file
        This file reports the calculated statistics for all
        genes/transcripts. It is written as a matrix with row and column
        names. The row names are the genes'/transcripts' names. The column
        names are for the reported statistics.

        If there are only 2 different conditions among the samples, four
        statistics (columns) will be reported for each gene/transcript. They
        are "PPEE", "PPDE", "PostFC" and "RealFC". "PPEE" is the posterior
        probability (estimated by EBSeq) that a gene/transcript is equally
        expressed. "PPDE" is the posterior probability that a
        gene/transcript is differentially expressed. "PostFC" is the
        posterior fold change (condition 1 over condition2) for a
        gene/transcript. It is defined as the ratio between posterior mean
        expression estimates of the gene/transcript for each condition.
        "RealFC" is the real fold change (condition 1 over condition2) for a
        gene/transcript. It is the ratio of the normalized within condition
        1 mean count over normalized within condition 2 mean count for the
        gene/transcript. Fold changes are calculated using EBSeq's 'PostFC'
        function. The genes/transcripts are reported in descending order of
        their "PPDE" values.

        If there are more than 2 different conditions among the samples, the
        output format is different. For differential expression analysis
        with more than 2 conditions, EBSeq will enumerate all possible
        expression patterns (on which conditions are equally expressed and
        which conditions are not). Suppose there are k different patterns,
        the first k columns of the output file give the posterior
        probability of each expression pattern is true. Patterns are defined
        in a separate file, 'output_file.pattern'. The k+1 column gives the
        maximum a posteriori (MAP) expression pattern for each
        gene/transcript. The k+2 column gives the posterior probability that
        not all conditions are equally expressed (column name "PPDE"). The
        genes/transcripts are reported in descending order of their "PPDE"
        column values. For details on how EBSeq works for more than 2
        conditions, please refer to EBSeq's manual.

    output_file.normalized_data_matrix
        This file contains the median normalized version of the input data
        matrix.

    output_file.pattern
        This file is only generated when there are more than 2 conditions.
        It defines all possible expression patterns over the conditions
        using a matrix with names. Each row of the matrix refers to a
        different expression pattern and each column gives the expression
        status of a different condition. Two conditions are equally
        expressed if and only if their statuses are the same.

    output_file.condmeans
        This file is only generated when there are more than 2 conditions.
        It gives the normalized mean count value for each gene/transcript at
        each condition. It is formatted as a matrix with names. Each row
        represents a gene/transcript and each column represent a condition.
        The order of genes/transcripts is the same as 'output_file'. This
        file can be used to calculate fold changes between conditions which
        users are interested in.

EXAMPLES
    1) We're interested in isoform-level differential expression analysis
    and there are two conditions. Each condition has 5 replicates. We have
    already collected the data matrix as 'IsoMat.txt' and generated ngvector
    as 'ngvector.ngvec':

     rsem-run-ebseq --ngvector ngvector.ngvec IsoMat.txt 5,5 IsoMat.results

    The results will be in 'IsoMat.results' and
    'IsoMat.results.normalized_data_matrix' contains the normalized data
    matrix.

    2) We're interested in gene-level analysis and there are 3 conditions.
    The first condition has 3 replicates and the other two has 4 replicates
    each. The data matrix is named as 'GeneMat.txt':

     rsem-run-ebseq GeneMat.txt 3,4,4 GeneMat.results

    Four files, 'GeneMat.results', 'GeneMat.results.normalized_data_matrix',
    'GeneMat.results.pattern', and 'GeneMat.results.condmeans', will be
    generated.
```

## rsem_rsem-control-fdr

### Tool Description
Filter EBSeq output for statistical significance at a given false discovery rate.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    rsem-control-fdr - Filter EBSeq output for statistical significance.

SYNOPSIS
    rsem-control-fdr [options] input_file fdr_rate output_file

ARGUMENTS
    input_file
        This should be the main result file generated by 'rsem-run-ebseq',
        which contains all genes/transcripts and their associated
        statistics.

    fdr_rate
        The desire false discovery rate (FDR).

    output_file
        This file is a subset of the 'input_file'. It only contains the
        genes/transcripts called as differentially expressed (DE). When more
        than 2 conditions exist, DE is defined as not all conditions are
        equally expressed. Because statistical significance does not
        necessarily mean biological significance, users should also refer to
        the fold changes to decide which genes/transcripts are biologically
        significant. When more than two conditions exist, this file will not
        contain fold change information and users need to calculate it from
        'input_file.condmeans' by themselves.

OPTIONS
    --hard-threshold
        Use hard threshold method to control FDR. If this option is set,
        only those genes/transcripts with their PPDE >= 1 - fdr_rate are
        called as DE. (Default: on)

    --soft-threshold
        Use soft threshold method to control FDR. If this option is set,
        this program will try to report as many genes/transcripts as
        possible, as long as their average PPDE >= 1 - fdr_rate. This option
        is equivalent to use EBSeq's 'crit_fun' for FDR control. (Default:
        off)

    -h/--help
        Show help information.

DESCRIPTION
    This program controls the false discovery rate and reports
    differentially expressed genes/transcripts.

EXAMPLES
    We assume that we have 'GeneMat.results' as input. We want to control
    FDR at 0.05 using hard threshold method and name the output file as
    'GeneMat.de.txt':

     rsem-control-fdr GeneMat.results 0.05 GeneMat.de.txt
```

## rsem_rsem-gen-transcript-plots

### Tool Description
Generate read depth plots (PDF) for a list of transcripts, alleles or genes from RSEM read depth files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-gen-transcript-plots sample_name input_list is_allele_specific id_type<0,allele;1,isoform;2,gene> show_uniq output_plot_file
```

## rsem_rsem-get-unique

### Tool Description
Extract the uniquely aligned reads from an unsorted transcript BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-get-unique number_of_threads unsorted_transcript_bam_input bam_output
```

## rsem_rsem-gff3-to-gtf

### Tool Description
Convert a GFF3 annotation file to a GTF file that rsem-prepare-reference can use.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rsem-gff3-to-gtf [-h] [--make-genes-as-transcripts]
                        [--RNA-patterns <patterns>]
                        [--extract-sequences <output.fa>]
                        input_GFF3_file output_GTF_file

positional arguments:
  input_GFF3_file       Input GFF3 file.
  output_GTF_file       Output GTF file.

options:
  --make-genes-as-transcripts
                        GFF3 file does not contain transcripts, make each gene as a transcript.
  --RNA-patterns <patterns>
                        Types of RNAs to be extracted, e.g. mRNA,rRNA
  --extract-sequences <output.fa>
                        If GFF3 file contains reference sequences, extract them to the specified file
```

## rsem_rsem-extract-reference-transcripts

### Tool Description
Extract transcript sequences and RSEM transcript information from genome FASTA files and a GTF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-extract-reference-transcripts refName quiet gtfF sources hasMappingFile [mappingFile] chromosome_file_1 [chromosome_file_2 ...]
```

## rsem_rsem-tbam2gbam

### Tool Description
Convert a transcript-coordinate BAM file into a genome-coordinate BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-tbam2gbam reference_name unsorted_transcript_bam_input genome_bam_output [-p number_of_threads]
```

## rsem_rsem-calculate-credibility-intervals

### Tool Description
Calculate credibility intervals of the expression estimates from Gibbs sampler count vectors.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
- **Homepage**: https://deweylab.github.io/RSEM/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsem/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rsem-calculate-credibility-intervals reference_name imdName statName confidence nCV nSpC nMB [-p #Threads] [--seed seed] [--pseudo-count pseudo_count] [-q]
```

## Metadata
- **Skill**: generated
