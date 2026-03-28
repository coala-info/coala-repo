# methylpy CWL Generation Report

## methylpy_build-reference

### Tool Description
Build reference files for methylpy using specified aligners.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Total Downloads**: 16.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yupenghe/methylpy
- **Stars**: N/A
### Original Help Text
```text
usage: methylpy build-reference [-h] --input-files INPUT_FILES
                                [INPUT_FILES ...] --output-prefix
                                OUTPUT_PREFIX [--num-procs NUM_PROCS]
                                [--aligner ALIGNER]
                                [--path-to-aligner PATH_TO_ALIGNER]
                                [--buffsize BUFFSIZE]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --input-files INPUT_FILES [INPUT_FILES ...]
                        List of genome fasta files to build a reference from.
                        (default: None)
  --output-prefix OUTPUT_PREFIX
                        the prefix of the two output reference files that will
                        be created. (default: None)

optional inputs:
  --num-procs NUM_PROCS
                        Number of processors you wish to use to parallelize
                        this function (default: 1)
  --aligner ALIGNER     Aligner to use. Currently, methylpy supports bowtie,
                        bowtie2 and minimap2. (default: bowtie2)
  --path-to-aligner PATH_TO_ALIGNER
                        Path to bowtie/bowtie2 installation (default: )
  --buffsize BUFFSIZE   The number of bytes that will be read in from the
                        reference at once. (default: 100)
```


## methylpy_single-end-pipeline

### Tool Description
Methylpy pipeline for single-end bisulfite sequencing data, including read alignment and methylation calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy single-end-pipeline [-h] --read-files READ_FILES
                                    [READ_FILES ...] --sample SAMPLE
                                    --forward-ref FORWARD_REF --reverse-ref
                                    REVERSE_REF --ref-fasta REF_FASTA
                                    [--libraries LIBRARIES [LIBRARIES ...]]
                                    [--path-to-output PATH_TO_OUTPUT]
                                    [--pbat PBAT]
                                    [--check-dependency CHECK_DEPENDENCY]
                                    [--num-procs NUM_PROCS]
                                    [--sort-mem SORT_MEM]
                                    [--num-upstream-bases NUM_UPSTREAM_BASES]
                                    [--num-downstream-bases NUM_DOWNSTREAM_BASES]
                                    [--generate-allc-file GENERATE_ALLC_FILE]
                                    [--generate-mpileup-file GENERATE_MPILEUP_FILE]
                                    [--compress-output COMPRESS_OUTPUT]
                                    [--bgzip BGZIP]
                                    [--path-to-bgzip PATH_TO_BGZIP]
                                    [--path-to-tabix PATH_TO_TABIX]
                                    [--trim-reads TRIM_READS]
                                    [--path-to-cutadapt PATH_TO_CUTADAPT]
                                    [--path-to-aligner PATH_TO_ALIGNER]
                                    [--aligner ALIGNER]
                                    [--aligner-options ALIGNER_OPTIONS [ALIGNER_OPTIONS ...]]
                                    [--merge-by-max-mapq MERGE_BY_MAX_MAPQ]
                                    [--remove-clonal REMOVE_CLONAL]
                                    [--path-to-picard PATH_TO_PICARD]
                                    [--keep-clonal-stats KEEP_CLONAL_STATS]
                                    [--java-options JAVA_OPTIONS]
                                    [--path-to-samtools PATH_TO_SAMTOOLS]
                                    [--adapter-seq ADAPTER_SEQ]
                                    [--remove-chr-prefix REMOVE_CHR_PREFIX]
                                    [--add-snp-info ADD_SNP_INFO]
                                    [--unmethylated-control UNMETHYLATED_CONTROL]
                                    [--binom-test BINOM_TEST]
                                    [--sig-cutoff SIG_CUTOFF]
                                    [--min-mapq MIN_MAPQ] [--min-cov MIN_COV]
                                    [--max-adapter-removal MAX_ADAPTER_REMOVAL]
                                    [--overlap-length OVERLAP_LENGTH]
                                    [--zero-cap ZERO_CAP]
                                    [--error-rate ERROR_RATE]
                                    [--min-qual-score MIN_QUAL_SCORE]
                                    [--min-read-len MIN_READ_LEN]
                                    [--min-base-quality MIN_BASE_QUALITY]
                                    [--keep-temp-files KEEP_TEMP_FILES]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --read-files READ_FILES [READ_FILES ...]
                        list of all the fastq files you would like to run
                        through the pipeline. Note that globbing is supported
                        here (i.e., you can use * in your paths) (default:
                        None)
  --sample SAMPLE       String indicating the name of the sample you are
                        processing. It will be included in the output files.
                        (default: None)
  --forward-ref FORWARD_REF
                        string indicating the path to the forward strand
                        reference created by build_ref (default: None)
  --reverse-ref REVERSE_REF
                        string indicating the path to the reverse strand
                        reference created by build_ref (default: None)
  --ref-fasta REF_FASTA
                        string indicating the path to a fasta file containing
                        the sequences you used for mapping (default: None)

optional inputs:
  --libraries LIBRARIES [LIBRARIES ...]
                        list of library IDs (in the same order as the files
                        list) indiciating which libraries each set of fastq
                        files belong to. If you use a glob, you only need to
                        indicate the library ID for those fastqs once (i.e.,
                        the length of files and libraries should be the same)
                        (default: ['libA'])
  --path-to-output PATH_TO_OUTPUT
                        Path to a directory where you would like the output to
                        be stored. The default is the same directory as the
                        input fastqs. (default: )
  --pbat PBAT           Boolean indicating whether to process data in PBAT
                        (Post-Bisulfite Adaptor Tagging) mode, in which reads
                        will be mapped to opposite strand of C-T converted
                        genome and the forward strand of G-A converted genome.
                        (default: False)
  --check-dependency CHECK_DEPENDENCY
                        Boolean indicating whether to check dependency
                        requirements are met. (default: False)
  --num-procs NUM_PROCS
                        Number of processors you wish to use to parallelize
                        this function (default: 1)
  --sort-mem SORT_MEM   Parameter to pass to unix sort with -S/--buffer-size
                        command (default: 500M)
  --num-upstream-bases NUM_UPSTREAM_BASES
                        Number of base(s) upstream of each cytosine that you
                        wish to include in output file. Recommend value 1 for
                        NOMe-seq processing since the upstream base is
                        required to tell apart cytosine at GC context.
                        (default: 0)
  --num-downstream-bases NUM_DOWNSTREAM_BASES
                        Number of base(s) downstream of each cytosine that you
                        wish to include in output file. Recommend value to be
                        at least 1 to separate cytosines at different sequence
                        context. (default: 2)
  --generate-allc-file GENERATE_ALLC_FILE
                        Boolean indicating whether to generate the final
                        output file that contains the methylation state of
                        each cytosine. If set to be false, only alignment file
                        (in BAM format) will be generated. (default: True)
  --generate-mpileup-file GENERATE_MPILEUP_FILE
                        Boolean indicating whether to generate intermediate
                        mpileup file to save space. However, skipping mpileup
                        step may cause problem due to the nature of python.
                        Not skipping this step is recommended. (default: True)
  --compress-output COMPRESS_OUTPUT
                        Boolean indicating whether to compress (by gzip) the
                        final output (allc file(s)). (default: True)
  --bgzip BGZIP         Boolean indicating whether to bgzip compressed allc
                        files and tabix index. (default: False)
  --path-to-bgzip PATH_TO_BGZIP
                        Path to bgzip installation (default: )
  --path-to-tabix PATH_TO_TABIX
                        Path to tabix installation (default: )
  --trim-reads TRIM_READS
                        Boolean indicating whether to trim reads using
                        cutadapt. (default: True)
  --path-to-cutadapt PATH_TO_CUTADAPT
                        Path to cutadapt installation (default: )
  --path-to-aligner PATH_TO_ALIGNER
                        Path to bowtie/bowtie2 installation (default: )
  --aligner ALIGNER     Aligner to use. Currently, methylpy supports bowtie,
                        bowtie2 and minimap2. (default: bowtie2)
  --aligner-options ALIGNER_OPTIONS [ALIGNER_OPTIONS ...]
                        list of strings indicating options you would like
                        passed to bowtie (e.g., "-k 1 -l 2") (default: None)
  --merge-by-max-mapq MERGE_BY_MAX_MAPQ
                        Boolean indicates whether to merge alignment results
                        from two converted genomes by MAPQ score. Be default,
                        we only keep reads that are mapped to only one of the
                        two converted genomes. If this option is set to True,
                        for a read that could be mapped to both converted
                        genomes, the alignment that achieves larger MAPQ score
                        will be kept. (default: False)
  --remove-clonal REMOVE_CLONAL
                        Boolean indicates whether to remove clonal reads or
                        not (default: False)
  --path-to-picard PATH_TO_PICARD
                        The path to the picard.jar in picard tools. The jar
                        file can be downloaded from
                        https://broadinstitute.github.io/picard/index.html
                        (default is current dir) (default: )
  --keep-clonal-stats KEEP_CLONAL_STATS
                        Boolean indicates whether to store the metric file
                        from picard. (default: True)
  --java-options JAVA_OPTIONS
                        String indicating the option pass the java when
                        running picard. (default: -Xmx20g)
  --path-to-samtools PATH_TO_SAMTOOLS
                        Path to samtools installation (default: )
  --adapter-seq ADAPTER_SEQ
                        sequence of an adapter that was ligated to the 3' end.
                        The adapter itself and anything that follows is
                        trimmed. (default: AGATCGGAAGAGCACACGTCTG)
  --remove-chr-prefix REMOVE_CHR_PREFIX
                        Boolean indicates whether to remove in the final
                        output the "chr" prefix in the chromosome name
                        (default: True)
  --add-snp-info ADD_SNP_INFO
                        Boolean indicates whether to add extra two columns in
                        the output (allc) file regarding the genotype
                        information of each site. The first (second) column
                        contain the number of basecalls that support the
                        reference gentype (variant) for nucleotides in the
                        sequence context. (default: False)
  --unmethylated-control UNMETHYLATED_CONTROL
                        name of the chromosome/region that you want to use to
                        estimate the non-conversion rate of your sample, or
                        the non-conversion rate you would like to use.
                        Consequently, control is either a string, or a
                        decimal. If control is a string then it should be in
                        the following format: "chrom:start-end". If you would
                        like to specify an entire chromosome simply use
                        "chrom:" (default: None)
  --binom-test BINOM_TEST
                        Indicates that you would like to perform a binomial
                        test on each cytosine to delineate cytosines that are
                        significantly methylated than noise due to the failure
                        of bisulfite conversion. (default: False)
  --sig-cutoff SIG_CUTOFF
                        float indicating the adjusted p-value cutoff you wish
                        to use for determining whether or not a site is
                        methylated (default: 0.01)
  --min-mapq MIN_MAPQ   Minimum MAPQ for reads to be included. (default: 30)
  --min-cov MIN_COV     Integer indicating the minimum number of reads for a
                        site to be tested. (default: 0)
  --max-adapter-removal MAX_ADAPTER_REMOVAL
                        Indicates the maximum number of times to try to remove
                        adapters. Useful when an adapter gets appended
                        multiple times. (default: None)
  --overlap-length OVERLAP_LENGTH
                        Minimum overlap length. If the overlap between the
                        read and the adapter is shorter than LENGTH, the read
                        is not modified. This reduces the no. of bases trimmed
                        purely due to short random adapter matches. (default:
                        None)
  --zero-cap ZERO_CAP   Flag that causes negative quality values to be set to
                        zero (workaround to avoid segmentation faults in BWA)
                        (default: None)
  --error-rate ERROR_RATE
                        maximum allowed error rate (no. of errors divided by
                        the length of the matching region) (default: None)
  --min-qual-score MIN_QUAL_SCORE
                        allows you to trim low-quality ends from reads before
                        adapter removal. The algorithm is the same as the one
                        used by BWA (Subtract CUTOFF from all qualities;
                        compute partial sums from all indices to the end of
                        the sequence; cut sequence at the index at which the
                        sum is minimal). (default: 10)
  --min-read-len MIN_READ_LEN
                        indicates the minimum length a read must be to be
                        kept. Reads that are too short even before adapter
                        removal are also discarded. In colorspace, an initial
                        primer is not counted. (default: 30)
  --min-base-quality MIN_BASE_QUALITY
                        Integer indicating the minimum PHRED quality score for
                        a base to be included in the mpileup file (and
                        subsequently to be considered for methylation
                        calling). (default: 1)
  --keep-temp-files KEEP_TEMP_FILES
                        Boolean indicating that you would like to keep the
                        intermediate files generated by this function. This
                        can be useful for debugging, but in general should be
                        left False. (default: False)
```


## methylpy_paired-end-pipeline

### Tool Description
Methylpy pipeline for processing paired-end bisulfite sequencing data, including alignment and methylation calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy paired-end-pipeline [-h] --read1-files READ1_FILES
                                    [READ1_FILES ...] --read2-files
                                    READ2_FILES [READ2_FILES ...] --sample
                                    SAMPLE --forward-ref FORWARD_REF
                                    --reverse-ref REVERSE_REF --ref-fasta
                                    REF_FASTA
                                    [--libraries LIBRARIES [LIBRARIES ...]]
                                    [--path-to-output PATH_TO_OUTPUT]
                                    [--pbat PBAT]
                                    [--check-dependency CHECK_DEPENDENCY]
                                    [--num-procs NUM_PROCS]
                                    [--sort-mem SORT_MEM]
                                    [--num-upstream-bases NUM_UPSTREAM_BASES]
                                    [--num-downstream-bases NUM_DOWNSTREAM_BASES]
                                    [--generate-allc-file GENERATE_ALLC_FILE]
                                    [--generate-mpileup-file GENERATE_MPILEUP_FILE]
                                    [--compress-output COMPRESS_OUTPUT]
                                    [--bgzip BGZIP]
                                    [--path-to-bgzip PATH_TO_BGZIP]
                                    [--path-to-tabix PATH_TO_TABIX]
                                    [--trim-reads TRIM_READS]
                                    [--path-to-cutadapt PATH_TO_CUTADAPT]
                                    [--path-to-aligner PATH_TO_ALIGNER]
                                    [--aligner ALIGNER]
                                    [--aligner-options ALIGNER_OPTIONS [ALIGNER_OPTIONS ...]]
                                    [--merge-by-max-mapq MERGE_BY_MAX_MAPQ]
                                    [--remove-clonal REMOVE_CLONAL]
                                    [--path-to-picard PATH_TO_PICARD]
                                    [--keep-clonal-stats KEEP_CLONAL_STATS]
                                    [--java-options JAVA_OPTIONS]
                                    [--path-to-samtools PATH_TO_SAMTOOLS]
                                    [--adapter-seq-read1 ADAPTER_SEQ_READ1]
                                    [--adapter-seq-read2 ADAPTER_SEQ_READ2]
                                    [--remove-chr-prefix REMOVE_CHR_PREFIX]
                                    [--add-snp-info ADD_SNP_INFO]
                                    [--unmethylated-control UNMETHYLATED_CONTROL]
                                    [--binom-test BINOM_TEST]
                                    [--sig-cutoff SIG_CUTOFF]
                                    [--min-mapq MIN_MAPQ] [--min-cov MIN_COV]
                                    [--max-adapter-removal MAX_ADAPTER_REMOVAL]
                                    [--overlap-length OVERLAP_LENGTH]
                                    [--zero-cap ZERO_CAP]
                                    [--error-rate ERROR_RATE]
                                    [--min-qual-score MIN_QUAL_SCORE]
                                    [--min-read-len MIN_READ_LEN]
                                    [--min-base-quality MIN_BASE_QUALITY]
                                    [--keep-temp-files KEEP_TEMP_FILES]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --read1-files READ1_FILES [READ1_FILES ...]
                        list of all the read 1 fastq files you would like to
                        run through the pipeline. Note that globbing is
                        supported here (i.e., you can use * in your paths)
                        (default: None)
  --read2-files READ2_FILES [READ2_FILES ...]
                        list of all the read 2 fastq files you would like to
                        run through the pipeline. Note that globbing is
                        supported here (i.e., you can use * in your paths)
                        (default: None)
  --sample SAMPLE       String indicating the name of the sample you are
                        processing. It will be included in the output files.
                        (default: None)
  --forward-ref FORWARD_REF
                        string indicating the path to the forward strand
                        reference created by build_ref (default: None)
  --reverse-ref REVERSE_REF
                        string indicating the path to the reverse strand
                        reference created by build_ref (default: None)
  --ref-fasta REF_FASTA
                        string indicating the path to a fasta file containing
                        the sequences you used for mapping (default: None)

optional inputs:
  --libraries LIBRARIES [LIBRARIES ...]
                        list of library IDs (in the same order as the files
                        list) indiciating which libraries each set of fastq
                        files belong to. If you use a glob, you only need to
                        indicate the library ID for those fastqs once (i.e.,
                        the length of files and libraries should be the same)
                        (default: ['libA'])
  --path-to-output PATH_TO_OUTPUT
                        Path to a directory where you would like the output to
                        be stored. The default is the same directory as the
                        input fastqs. (default: )
  --pbat PBAT           Boolean indicating whether to process data in PBAT
                        (Post-Bisulfite Adaptor Tagging) mode, in which reads
                        will be mapped to opposite strand of C-T converted
                        genome and the forward strand of G-A converted genome.
                        (default: False)
  --check-dependency CHECK_DEPENDENCY
                        Boolean indicating whether to check dependency
                        requirements are met. (default: False)
  --num-procs NUM_PROCS
                        Number of processors you wish to use to parallelize
                        this function (default: 1)
  --sort-mem SORT_MEM   Parameter to pass to unix sort with -S/--buffer-size
                        command (default: 500M)
  --num-upstream-bases NUM_UPSTREAM_BASES
                        Number of base(s) upstream of each cytosine that you
                        wish to include in output file. Recommend value 1 for
                        NOMe-seq processing since the upstream base is
                        required to tell apart cytosine at GC context.
                        (default: 0)
  --num-downstream-bases NUM_DOWNSTREAM_BASES
                        Number of base(s) downstream of each cytosine that you
                        wish to include in output file. Recommend value to be
                        at least 1 to separate cytosines at different sequence
                        contexts. (default: 2)
  --generate-allc-file GENERATE_ALLC_FILE
                        Boolean indicating whether to generate the final
                        output file that contains the methylation state of
                        each cytosine. If set to be false, only alignment file
                        (in BAM format) will be generated. (default: True)
  --generate-mpileup-file GENERATE_MPILEUP_FILE
                        Boolean indicating whether to generate intermediate
                        mpileup file to save space. However, skipping mpileup
                        step may cause problem due to the nature of python.
                        Not skipping this step is recommended. (default: True)
  --compress-output COMPRESS_OUTPUT
                        Boolean indicating whether to compress (by gzip) the
                        final output (allc file(s)). (default: True)
  --bgzip BGZIP         Boolean indicating whether to bgzip compressed allc
                        files and tabix index. (default: False)
  --path-to-bgzip PATH_TO_BGZIP
                        Path to bgzip installation (default: )
  --path-to-tabix PATH_TO_TABIX
                        Path to tabix installation (default: )
  --trim-reads TRIM_READS
                        Boolean indicating whether to trim reads using
                        cutadapt. (default: True)
  --path-to-cutadapt PATH_TO_CUTADAPT
                        Path to cutadapt installation (default: )
  --path-to-aligner PATH_TO_ALIGNER
                        Path to bowtie/bowtie2 installation (default: )
  --aligner ALIGNER     Aligner to use. Currently, methylpy supports bowtie,
                        bowtie2 and minimap2. (default: bowtie2)
  --aligner-options ALIGNER_OPTIONS [ALIGNER_OPTIONS ...]
                        list of strings indicating options you would like
                        passed to bowtie (e.g., "-k 1 -l 2") (default: None)
  --merge-by-max-mapq MERGE_BY_MAX_MAPQ
                        Boolean indicates whether to merge alignment results
                        from two converted genomes by MAPQ score. Be default,
                        we only keep read pairs that are mapped to only one of
                        the two converted genomes. If this option is set to
                        True, for a read pair that could be mapped to both
                        converted genomes, the alignment that achieves larger
                        MAPQ score will be kept. (default: False)
  --remove-clonal REMOVE_CLONAL
                        Boolean indicates whether to remove clonal reads or
                        not (default: False)
  --path-to-picard PATH_TO_PICARD
                        The path to the picard.jar in picard tools. The jar
                        file can be downloaded from
                        https://broadinstitute.github.io/picard/index.html
                        (default is current dir) (default: )
  --keep-clonal-stats KEEP_CLONAL_STATS
                        Boolean indicates whether to store the metric file
                        from picard. (default: True)
  --java-options JAVA_OPTIONS
                        String indicating the option pass the java when
                        running picard. (default: -Xmx20g)
  --path-to-samtools PATH_TO_SAMTOOLS
                        Path to samtools installation (default: )
  --adapter-seq-read1 ADAPTER_SEQ_READ1
                        sequence of an adapter that was ligated to the 3' end
                        of read 1. The adapter itself and anything that
                        follows is trimmed. (default:
                        AGATCGGAAGAGCACACGTCTGAAC)
  --adapter-seq-read2 ADAPTER_SEQ_READ2
                        sequence of an adapter that was ligated to the 3' end
                        of read 2. The adapter itself and anything that
                        follows is trimmed. (default:
                        AGATCGGAAGAGCGTCGTGTAGGGA)
  --remove-chr-prefix REMOVE_CHR_PREFIX
                        Boolean indicates whether to remove in the final
                        output the "chr" prefix in the chromosome name
                        (default: True)
  --add-snp-info ADD_SNP_INFO
                        Boolean indicates whether to add extra two columns in
                        the output (allc) file regarding the genotype
                        information of each site. The first (second) column
                        contain the number of basecalls that support the
                        reference gentype (variant) for nucleotides in the
                        sequence context. (default: False)
  --unmethylated-control UNMETHYLATED_CONTROL
                        name of the chromosome/region that you want to use to
                        estimate the non-conversion rate of your sample, or
                        the non-conversion rate you would like to use.
                        Consequently, control is either a string, or a
                        decimal. If control is a string then it should be in
                        the following format: "chrom:start-end". If you would
                        like to specify an entire chromosome simply use
                        "chrom:" (default: None)
  --binom-test BINOM_TEST
                        Indicates that you would like to perform a binomial
                        test on each cytosine to delineate cytosines that are
                        significantly methylated than noise due to the failure
                        of bisulfite conversion. (default: False)
  --sig-cutoff SIG_CUTOFF
                        float indicating the adjusted p-value cutoff you wish
                        to use for determining whether or not a site is
                        methylated (default: 0.01)
  --min-mapq MIN_MAPQ   Minimum MAPQ for reads to be included. (default: 30)
  --min-cov MIN_COV     Integer indicating the minimum number of reads for a
                        site to be tested. (default: 0)
  --max-adapter-removal MAX_ADAPTER_REMOVAL
                        Indicates the maximum number of times to try to remove
                        adapters. Useful when an adapter gets appended
                        multiple times. (default: None)
  --overlap-length OVERLAP_LENGTH
                        Minimum overlap length. If the overlap between the
                        read and the adapter is shorter than LENGTH, the read
                        is not modified. This reduces the no. of bases trimmed
                        purely due to short random adapter matches. (default:
                        None)
  --zero-cap ZERO_CAP   Flag that causes negative quality values to be set to
                        zero (workaround to avoid segmentation faults in BWA)
                        (default: None)
  --error-rate ERROR_RATE
                        maximum allowed error rate (no. of errors divided by
                        the length of the matching region) (default: None)
  --min-qual-score MIN_QUAL_SCORE
                        allows you to trim low-quality ends from reads before
                        adapter removal. The algorithm is the same as the one
                        used by BWA (Subtract CUTOFF from all qualities;
                        compute partial sums from all indices to the end of
                        the sequence; cut sequence at the index at which the
                        sum is minimal). (default: 10)
  --min-read-len MIN_READ_LEN
                        indicates the minimum length a read must be to be
                        kept. Reads that are too short even before adapter
                        removal are also discarded. In colorspace, an initial
                        primer is not counted. (default: 30)
  --min-base-quality MIN_BASE_QUALITY
                        Integer indicating the minimum PHRED quality score for
                        a base to be included in the mpileup file (and
                        subsequently to be considered for methylation
                        calling). (default: 1)
  --keep-temp-files KEEP_TEMP_FILES
                        Boolean indicating that you would like to keep the
                        intermediate files generated by this function. This
                        can be useful for debugging, but in general should be
                        left False. (default: False)
```


## methylpy_dmrfind

### Tool Description
Find differentially methylated regions (DMRs) from ALLC files.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy [-h]  ...
methylpy: error: argument : invalid choice: 'dmrfind' (choose from 'build-reference', 'single-end-pipeline', 'paired-end-pipeline', 'DMRfind', 'reidentify-DMR', 'add-methylation-level', 'bam-quality-filter', 'call-methylation-state', 'allc-to-bigwig', 'merge-allc', 'index-allc', 'filter-allc', 'test-allc')
```


## methylpy_reidentify-dmr

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: methylpy [-h]  ...
methylpy: error: argument : invalid choice: 'reidentify-dmr' (choose from 'build-reference', 'single-end-pipeline', 'paired-end-pipeline', 'DMRfind', 'reidentify-DMR', 'add-methylation-level', 'bam-quality-filter', 'call-methylation-state', 'allc-to-bigwig', 'merge-allc', 'index-allc', 'filter-allc', 'test-allc')
```


## methylpy_add-methylation-level

### Tool Description
Add methylation level information to genomic intervals in a TSV file using ALLC files.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy add-methylation-level [-h] [--input-tsv-file INPUT_TSV_FILE]
                                      --output-file OUTPUT_FILE --allc-files
                                      ALLC_FILES [ALLC_FILES ...]
                                      [--samples SAMPLES [SAMPLES ...]]
                                      [--mc-type MC_TYPE [MC_TYPE ...]]
                                      [--extra-info EXTRA_INFO]
                                      [--num-procs NUM_PROCS]
                                      [--min-cov MIN_COV] [--max-cov MAX_COV]
                                      [--buffer-line-number BUFFER_LINE_NUMBER]
                                      [--input-no-header INPUT_NO_HEADER]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --input-tsv-file INPUT_TSV_FILE
                        A tab-separate file that specifies genomic intervals.
                        The file contains a header.First three columns are
                        required to be chromosome, start and end, which are
                        1-based cooridates. It may contain additional
                        column(s). (default: None)
  --output-file OUTPUT_FILE
                        Name of output file (default: None)
  --allc-files ALLC_FILES [ALLC_FILES ...]
                        List of allc files. (default: None)

optional inputs:
  --samples SAMPLES [SAMPLES ...]
                        List of space separated samples matching allc files.
                        By default sample names will be inferred from allc
                        filenames (default: None)
  --mc-type MC_TYPE [MC_TYPE ...]
                        List of space separated mc nucleotide contexts for
                        which you want to look for DMRs. These classifications
                        may use the wildcards H (indicating anything but a G)
                        and N (indicating any nucleotide). (default: ['CGN'])
  --extra-info EXTRA_INFO
                        Boolean to indicate whether to generate two output
                        extra files with the total basecalls and covered sites
                        in each of the regions. (default: False)
  --num-procs NUM_PROCS
                        Number of processors you wish to use to parallelize
                        this function (default: 1)
  --min-cov MIN_COV     Minimum coverage for a site to be included (default:
                        0)
  --max-cov MAX_COV     Maximum coverage for a site to be included. By default
                        this cutoff is not applied. (default: None)
  --buffer-line-number BUFFER_LINE_NUMBER
                        size of buffer for reads to be written on hard drive.
                        (default: 100000)
  --input-no-header INPUT_NO_HEADER
                        Indicating whether input tsv file contains a header.
                        If this is set to True, a header will be automatically
                        generated in the output file. (default: False)
```


## methylpy_bam-quality-filter

### Tool Description
Filter BAM files based on mapping quality and mCH levels.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy bam-quality-filter [-h] --input-file INPUT_FILE --output-file
                                   OUTPUT_FILE --ref-fasta REF_FASTA
                                   [--min-mapq MIN_MAPQ]
                                   [--min-num-ch MIN_NUM_CH]
                                   [--max-mch-level MAX_MCH_LEVEL]
                                   [--buffer-line-number BUFFER_LINE_NUMBER]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --input-file INPUT_FILE
                        BAM file to filter. (default: None)
  --output-file OUTPUT_FILE
                        Name of output file (default: None)
  --ref-fasta REF_FASTA
                        string indicating the path to a fasta file containing
                        the sequences you used for mapping (default: None)

optional inputs:
  --min-mapq MIN_MAPQ   Minimum MAPQ for reads to be included. (default: 30)
  --min-num-ch MIN_NUM_CH
                        Minimum number of CH sites for mCH level filter to be
                        applied. (default: 30)
  --max-mch-level MAX_MCH_LEVEL
                        Maximum mCH level for reads to be included. (default:
                        0.7)
  --buffer-line-number BUFFER_LINE_NUMBER
                        size of buffer for reads to be written on hard drive.
                        (default: 100000)
```


## methylpy_call-methylation-state

### Tool Description
Call methylation state from BAM files containing mapped bisulfite sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy call-methylation-state [-h] [--input-file INPUT_FILE] --sample
                                       SAMPLE --ref-fasta REF_FASTA
                                       --paired-end PAIRED_END
                                       [--path-to-output PATH_TO_OUTPUT]
                                       [--num-procs NUM_PROCS]
                                       [--num-upstream-bases NUM_UPSTREAM_BASES]
                                       [--num-downstream-bases NUM_DOWNSTREAM_BASES]
                                       [--generate-allc-file GENERATE_ALLC_FILE]
                                       [--generate-mpileup-file GENERATE_MPILEUP_FILE]
                                       [--compress-output COMPRESS_OUTPUT]
                                       [--bgzip BGZIP]
                                       [--path-to-bgzip PATH_TO_BGZIP]
                                       [--path-to-tabix PATH_TO_TABIX]
                                       [--path-to-samtools PATH_TO_SAMTOOLS]
                                       [--remove-chr-prefix REMOVE_CHR_PREFIX]
                                       [--add-snp-info ADD_SNP_INFO]
                                       [--unmethylated-control UNMETHYLATED_CONTROL]
                                       [--binom-test BINOM_TEST]
                                       [--sig-cutoff SIG_CUTOFF]
                                       [--min-mapq MIN_MAPQ]
                                       [--min-cov MIN_COV]
                                       [--min-base-quality MIN_BASE_QUALITY]
                                       [--keep-temp-files KEEP_TEMP_FILES]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --input-file INPUT_FILE
                        bam file that contains mapped bisulfite sequencing
                        reads. (default: None)
  --sample SAMPLE       String indicating the name of the sample you are
                        processing. It will be included in the output files.
                        (default: None)
  --ref-fasta REF_FASTA
                        string indicating the path to a fasta file containing
                        the sequences you used for mapping (default: None)
  --paired-end PAIRED_END
                        Boolean indicating whether the input BAM file is from
                        paired-end data. (default: False)

optional inputs:
  --path-to-output PATH_TO_OUTPUT
                        Path to a directory where you would like the output to
                        be stored. The default is the same directory as the
                        input fastqs. (default: )
  --num-procs NUM_PROCS
                        Number of processors you wish to use to parallelize
                        this function (default: 1)
  --num-upstream-bases NUM_UPSTREAM_BASES
                        Number of base(s) upstream of each cytosine that you
                        wish to include in output file. Recommend value 1 for
                        NOMe-seq processing since the upstream base is
                        required to tell apart cytosine at GC context.
                        (default: 0)
  --num-downstream-bases NUM_DOWNSTREAM_BASES
                        Number of base(s) downstream of each cytosine that you
                        wish to include in output file. Recommend value to be
                        at least 1 to separate cytosines at different sequence
                        contexts. (default: 2)
  --generate-allc-file GENERATE_ALLC_FILE
                        Boolean indicating whether to generate the final
                        output file that contains the methylation state of
                        each cytosine. If set to be false, only alignment file
                        (in BAM format) will be generated. (default: True)
  --generate-mpileup-file GENERATE_MPILEUP_FILE
                        Boolean indicating whether to generate intermediate
                        mpileup file to save space. However, skipping mpileup
                        step may cause problem due to the nature of python.
                        Not skipping this step is recommended. (default: True)
  --compress-output COMPRESS_OUTPUT
                        Boolean indicating whether to compress (by gzip) the
                        final output (allc file(s)). (default: True)
  --bgzip BGZIP         Boolean indicating whether to bgzip compressed allc
                        files and tabix index. (default: False)
  --path-to-bgzip PATH_TO_BGZIP
                        Path to bgzip installation (default: )
  --path-to-tabix PATH_TO_TABIX
                        Path to tabix installation (default: )
  --path-to-samtools PATH_TO_SAMTOOLS
                        Path to samtools installation (default: )
  --remove-chr-prefix REMOVE_CHR_PREFIX
                        Boolean indicates whether to remove in the final
                        output the "chr" prefix in the chromosome name
                        (default: True)
  --add-snp-info ADD_SNP_INFO
                        Boolean indicates whether to add extra two columns in
                        the output (allc) file regarding the genotype
                        information of each site. The first (second) column
                        contain the number of basecalls that support the
                        reference gentype (variant) for nucleotides in the
                        sequence context. (default: False)
  --unmethylated-control UNMETHYLATED_CONTROL
                        name of the chromosome/region that you want to use to
                        estimate the non-conversion rate of your sample, or
                        the non-conversion rate you would like to use.
                        Consequently, control is either a string, or a
                        decimal. If control is a string then it should be in
                        the following format: "chrom:start-end". If you would
                        like to specify an entire chromosome simply use
                        "chrom:" (default: None)
  --binom-test BINOM_TEST
                        Indicates that you would like to perform a binomial
                        test on each cytosine to delineate cytosines that are
                        significantly methylated than noise due to the failure
                        of bisulfite conversion. (default: False)
  --sig-cutoff SIG_CUTOFF
                        float indicating the adjusted p-value cutoff you wish
                        to use for determining whether or not a site is
                        methylated (default: 0.01)
  --min-mapq MIN_MAPQ   Minimum MAPQ for reads to be included. (default: 30)
  --min-cov MIN_COV     Integer indicating the minimum number of reads for a
                        site to be tested. (default: 0)
  --min-base-quality MIN_BASE_QUALITY
                        Integer indicating the minimum PHRED quality score for
                        a base to be included in the mpileup file (and
                        subsequently to be considered for methylation
                        calling). (default: 1)
  --keep-temp-files KEEP_TEMP_FILES
                        Boolean indicating that you would like to keep the
                        intermediate files generated by this function. This
                        can be useful for debugging, but in general should be
                        left False. (default: False)
```


## methylpy_allc-to-bigwig

### Tool Description
Convert allc file to bigwig format

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy allc-to-bigwig [-h] [--allc-file ALLC_FILE] --output-file
                               OUTPUT_FILE --ref-fasta REF_FASTA
                               [--mc-type MC_TYPE [MC_TYPE ...]]
                               [--bin-size BIN_SIZE]
                               [--min-bin-sites MIN_BIN_SITES]
                               [--min-bin-cov MIN_BIN_COV]
                               [--min-site-cov MIN_SITE_COV]
                               [--max-site-cov MAX_SITE_COV]
                               [--path-to-wigToBigWig PATH_TO_WIGTOBIGWIG]
                               [--path-to-samtools PATH_TO_SAMTOOLS]
                               [--remove-chr-prefix REMOVE_CHR_PREFIX]
                               [--add-chr-prefix ADD_CHR_PREFIX]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --allc-file ALLC_FILE
                        input allc file to be converted to bigwig format
                        (default: None)
  --output-file OUTPUT_FILE
                        Name of output file (default: None)
  --ref-fasta REF_FASTA
                        string indicating the path to a fasta file containing
                        the genome sequences (default: None)

optional inputs:
  --mc-type MC_TYPE [MC_TYPE ...]
                        List of space separated mc nucleotide contexts for
                        which you want to look for DMRs. These classifications
                        may use the wildcards H (indicating anything but a G)
                        and N (indicating any nucleotide). (default: ['CGN'])
  --bin-size BIN_SIZE   Genomic bin size for calculating methylation level
                        (default: 100)
  --min-bin-sites MIN_BIN_SITES
                        Minimum sites in a bin for it to be included.
                        (default: 0)
  --min-bin-cov MIN_BIN_COV
                        Minimum total coverage of all sites in a bin for
                        methylation level to be calculated. (default: 0)
  --min-site-cov MIN_SITE_COV
                        Minimum total coverage of a site for it to be
                        included. (default: 0)
  --max-site-cov MAX_SITE_COV
                        Maximum total coverage of a site for it to be
                        included. (default: None)
  --path-to-wigToBigWig PATH_TO_WIGTOBIGWIG
                        Path to wigToBigWig executable (default: )
  --path-to-samtools PATH_TO_SAMTOOLS
                        Path to samtools installation (default: )
  --remove-chr-prefix REMOVE_CHR_PREFIX
                        Boolean indicates whether to remove "chr" in the
                        chromosome names in genome sequence file to match
                        chromosome names in input allc file. (default: True)
  --add-chr-prefix ADD_CHR_PREFIX
                        Boolean indicates whether to add "chr" in the
                        chromosome names in input allc file to match
                        chromosome names in genome sequence file. This option
                        overrides --remove-chr-prefix. (default: False)
```


## methylpy_merge-allc

### Tool Description
Merge multiple allc files into a single allc file.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy merge-allc [-h] --allc-files ALLC_FILES [ALLC_FILES ...]
                           --output-file OUTPUT_FILE [--num-procs NUM_PROCS]
                           [--compress-output COMPRESS_OUTPUT]
                           [--skip-snp-info SKIP_SNP_INFO]
                           [--mini-batch MINI_BATCH]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --allc-files ALLC_FILES [ALLC_FILES ...]
                        List of allc files to merge. (default: None)
  --output-file OUTPUT_FILE
                        String indicating the name of output file (default:
                        None)

optional inputs:
  --num-procs NUM_PROCS
                        Number of processors to use (default: 1)
  --compress-output COMPRESS_OUTPUT
                        Boolean indicating whether to compress (by gzip) the
                        final output (default: True)
  --skip-snp-info SKIP_SNP_INFO
                        Boolean indicating whether to skip the merging of SNP
                        information (default: True)
  --mini-batch MINI_BATCH
                        The maximum number of allc files to be merged at the
                        same time. Since OS or python may limit the number of
                        files that can be open at once, value larger than 200
                        is not recommended (default: 100)
```


## methylpy_index-allc

### Tool Description
Index ALLC files for faster access.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy index-allc [-h] --allc-files ALLC_FILES [ALLC_FILES ...]
                           [--num-procs NUM_PROCS] [--reindex REINDEX]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --allc-files ALLC_FILES [ALLC_FILES ...]
                        List of allc files to index. (default: None)

optional inputs:
  --num-procs NUM_PROCS
                        Number of processors to use (default: 1)
  --reindex REINDEX     Boolean indicating whether to index allc files whose
                        index files already exist. (default: True)
```


## methylpy_filter-allc

### Tool Description
Filter allc files based on coverage, mismatch, and sequence context.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy filter-allc [-h] --allc-files ALLC_FILES [ALLC_FILES ...]
                            --output-files OUTPUT_FILES [OUTPUT_FILES ...]
                            [--num-procs NUM_PROCS]
                            [--mc-type MC_TYPE [MC_TYPE ...]]
                            [--min-cov MIN_COV] [--max-cov MAX_COV]
                            [--max-mismatch MAX_MISMATCH [MAX_MISMATCH ...]]
                            [--max-mismatch-frac MAX_MISMATCH_FRAC [MAX_MISMATCH_FRAC ...]]
                            [--compress-output COMPRESS_OUTPUT]
                            [--chroms CHROMS [CHROMS ...]]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --allc-files ALLC_FILES [ALLC_FILES ...]
                        allc files to filter. (default: None)
  --output-files OUTPUT_FILES [OUTPUT_FILES ...]
                        Name of output files. Each output file matches each
                        allc file. (default: None)

optional inputs:
  --num-procs NUM_PROCS
                        Number of processors you wish to use to parallelize
                        this function (default: 1)
  --mc-type MC_TYPE [MC_TYPE ...]
                        List of space separated cytosine nucleotide contexts
                        for sites to be included in output file. These
                        classifications may use the wildcards H (indicating
                        anything but a G) and N (indicating any nucleotide).
                        (default: None)
  --min-cov MIN_COV     Minimum number of reads that must cover a site for it
                        to be included in the output file. (default: 0)
  --max-cov MAX_COV     Maximum number of reads that must cover a site for it
                        to be included in the output file. By default this
                        cutoff is not applied. (default: None)
  --max-mismatch MAX_MISMATCH [MAX_MISMATCH ...]
                        Maximum numbers of mismatch basecalls allowed in each
                        nucleotide in the sequence context of a site for it to
                        be included in output file. If the sequence context
                        has three nucleotides, an example of this option is "0
                        1 2". It requires no mismatch basecall at the first
                        nucleotide, at most one mismatch basecall at the
                        second nucleotide, and at most two at the third
                        nucleotide for a site to be reported. (default: None)
  --max-mismatch-frac MAX_MISMATCH_FRAC [MAX_MISMATCH_FRAC ...]
                        Maximum fraction of mismatch basecalls out of
                        unambiguous basecalls allowed in each nucleotide in
                        the sequence context of a site for it to be included
                        in output file. If the sequence context has three
                        nucleotides, an example of this option is "0 0 0.1".
                        It requires no mismatch basecall at the first and
                        second nucleotide, and at most 10% mismatches out of
                        unambiguous basecalls at the third nucleotide for a
                        site to be reported. (default: None)
  --compress-output COMPRESS_OUTPUT
                        Boolean indicating whether to compress (by gzip) the
                        final output (default: True)
  --chroms CHROMS [CHROMS ...]
                        Space separated listing of chromosomes to be included
                        in the output. By default, data of all chromosomes in
                        input allc file will be included. (default: None)
```


## methylpy_test-allc

### Tool Description
Test allc file for significant methylation sites, estimating non-conversion rates from controls.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
- **Homepage**: https://github.com/yupenghe/methylpy
- **Package**: https://anaconda.org/channels/bioconda/packages/methylpy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: methylpy test-allc [-h] --allc-file ALLC_FILE --sample SAMPLE
                          [--unmethylated-control UNMETHYLATED_CONTROL]
                          [--path-to-output PATH_TO_OUTPUT]
                          [--num-procs NUM_PROCS] [--min-cov MIN_COV]
                          [--compress-output COMPRESS_OUTPUT]
                          [--sig-cutoff SIG_CUTOFF] [--sort-mem SORT_MEM]
                          [--remove-chr-prefix REMOVE_CHR_PREFIX]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --allc-file ALLC_FILE
                        allc file to be tested. (default: None)
  --sample SAMPLE       sample name (default: None)
  --unmethylated-control UNMETHYLATED_CONTROL
                        name of the chromosome/region that you want to use to
                        estimate the non-conversion rate of your sample, or
                        the non-conversion rate you would like to use.
                        Consequently, control is either a string, or a
                        decimal. If control is a string then it should be in
                        the following format: "chrom:start-end". If you would
                        like to specify an entire chromosome simply use
                        "chrom:" (default: None)

optional inputs:
  --path-to-output PATH_TO_OUTPUT
                        Path to a directory where you would like the output to
                        be stored. The default is the same directory as the
                        input fastqs. (default: )
  --num-procs NUM_PROCS
                        Number of processors you wish to use to parallelize
                        this function (default: 1)
  --min-cov MIN_COV     Minimum number of reads that must cover a site for it
                        to be tested. (default: 2)
  --compress-output COMPRESS_OUTPUT
                        Boolean indicating whether to compress (by gzip) the
                        final output (default: True)
  --sig-cutoff SIG_CUTOFF
                        Float indicating at what FDR you want to consider a
                        result significant. (default: 0.01)
  --sort-mem SORT_MEM   Parameter to pass to unix sort with -S/--buffer-size
                        command (default: 500M)
  --remove-chr-prefix REMOVE_CHR_PREFIX
                        Boolean indicates whether to remove in the final
                        output the "chr" prefix in the chromosome name
                        (default: True)
```


## Metadata
- **Skill**: generated
