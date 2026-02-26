# mageck CWL Generation Report

## mageck_count

### Tool Description
Count reads for MAGeCK analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
- **Homepage**: http://mageck.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/mageck/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mageck/overview
- **Total Downloads**: 145.3K
- **Last updated**: 2025-09-05
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: mageck count [-h] [-l LIST_SEQ]
                    (--fastq FASTQ [FASTQ ...] | -k COUNT_TABLE)
                    [--norm-method {none,median,total,control}]
                    [--control-sgrna CONTROL_SGRNA | --control-gene CONTROL_GENE]
                    [--sample-label SAMPLE_LABEL] [-n OUTPUT_PREFIX]
                    [--unmapped-to-file] [--keep-tmp] [--test-run]
                    [--fastq-2 FASTQ_2 [FASTQ_2 ...]]
                    [--count-pair COUNT_PAIR] [--trim-5 TRIM_5]
                    [--sgrna-len SGRNA_LEN] [--count-n] [--reverse-complement]
                    [--pdf-report] [--day0-label DAY0_LABEL]
                    [--gmt-file GMT_FILE]

options:
  -h, --help            show this help message and exit

Required arguments:

  -l LIST_SEQ, --list-seq LIST_SEQ
                        A file containing the list of sgRNA names, their
                        sequences and associated genes. Support file format:
                        csv and txt. Provide an empty file for collecting all
                        possible sgRNA counts.
  --fastq FASTQ [FASTQ ...]
                        Sample fastq files (or fastq.gz files, or SAM/BAM
                        files after v0.5.5), separated by space; use comma (,)
                        to indicate technical replicates of the same sample.
                        For example, "--fastq
                        sample1_replicate1.fastq,sample1_replicate2.fastq
                        sample2_replicate1.fastq,sample2_replicate2.fastq"
                        indicates two samples with 2 technical replicates for
                        each sample.
  -k COUNT_TABLE, --count-table COUNT_TABLE
                        The read count table file. Only 1 file is accepted.

Optional arguments for normalization:

  --norm-method {none,median,total,control}
                        Method for normalization, including "none" (no
                        normalization), "median" (median normalization,
                        default), "total" (normalization by total read
                        counts), "control" (normalization by control sgRNAs
                        specified by the --control-sgrna option).
  --control-sgrna CONTROL_SGRNA
                        A list of control sgRNAs for normalization and for
                        generating the null distribution of RRA.
  --control-gene CONTROL_GENE
                        A list of genes whose sgRNAs are used as control
                        sgRNAs for normalization and for generating the null
                        distribution of RRA.

Optional arguments for input and output:

  --sample-label SAMPLE_LABEL
                        Sample labels, separated by comma (,). Must be equal
                        to the number of samples provided (in --fastq option).
                        Default "sample1,sample2,...".
  -n OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        The prefix of the output file(s). Default sample1.
  --unmapped-to-file    Save unmapped reads to file, with sgRNA lengths
                        specified by --sgrna-len option.
  --keep-tmp            Keep intermediate files.
  --test-run            Test running. If this option is on, MAGeCK will only
                        process the first 1M records for each file.

Optional arguments for processing fastq files:

  --fastq-2 FASTQ_2 [FASTQ_2 ...]
                        Paired sample fastq files (or fastq.gz files), the
                        order of which should be consistent with that in fastq
                        option.
  --count-pair COUNT_PAIR
                        Report all valid alignments per read or pair (default:
                        False).
  --trim-5 TRIM_5       Length of trimming the 5' of the reads. Users can
                        specify multiple trimming lengths, separated by comma
                        (,); for example, "7,8". Use "AUTO" to allow MAGeCK to
                        automatically determine the trimming length. Default
                        AUTO.
  --sgrna-len SGRNA_LEN
                        Length of the sgRNA. Default 20. ATTENTION: after
                        v0.5.3, the program will automatically determine the
                        sgRNA length from library file; so only use this if
                        you turn on the --unmapped-to-file option.
  --count-n             Count sgRNAs with Ns. By default, sgRNAs containing N
                        will be discarded.
  --reverse-complement  Reverse complement the sequences in library for read
                        mapping.

Optional arguments for quality controls:

  --pdf-report          Generate pdf report of the fastq files.
  --day0-label DAY0_LABEL
                        Turn on the negative selection QC and specify the
                        label for control sample (usually day 0 or plasmid).
                        For every other sample label, the negative selection
                        QC will compare it with day0 sample, and estimate the
                        degree of negative selections in essential genes.
  --gmt-file GMT_FILE   The pathway file used for QC, in GMT format. By
                        default it will use the GMT file provided by MAGeCK.
```


## mageck_test

### Tool Description
Perform differential analysis of CRISPR screens.

### Metadata
- **Docker Image**: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
- **Homepage**: http://mageck.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/mageck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mageck test [-h] -k COUNT_TABLE
                   (-t TREATMENT_ID | --day0-label DAY0_LABEL) [-c CONTROL_ID]
                   [--paired] [--norm-method {none,median,total,control}]
                   [--gene-test-fdr-threshold GENE_TEST_FDR_THRESHOLD]
                   [--adjust-method {fdr,holm,pounds}]
                   [--variance-estimation-samples VARIANCE_ESTIMATION_SAMPLES]
                   [--sort-criteria {neg,pos}]
                   [--remove-zero {none,control,treatment,both,any}]
                   [--remove-zero-threshold REMOVE_ZERO_THRESHOLD]
                   [--pdf-report]
                   [--gene-lfc-method {median,alphamedian,mean,alphamean,secondbest}]
                   [-n OUTPUT_PREFIX]
                   [--control-sgrna CONTROL_SGRNA | --control-gene CONTROL_GENE]
                   [--normcounts-to-file] [--skip-gene SKIP_GENE] [--keep-tmp]
                   [--additional-rra-parameters ADDITIONAL_RRA_PARAMETERS]
                   [--cnv-norm CNV_NORM] [--cell-line CELL_LINE]
                   [--cnv-est CNV_EST]

options:
  -h, --help            show this help message and exit

Required arguments:

  -k COUNT_TABLE, --count-table COUNT_TABLE
                        Provide a tab-separated count table instead of sam
                        files. Each line in the table should include sgRNA
                        name (1st column), gene name (2nd column) and read
                        counts in each sample.
  -t TREATMENT_ID, --treatment-id TREATMENT_ID
                        Sample label or sample index (0 as the first sample)
                        in the count table as treatment experiments, separated
                        by comma (,). If sample label is provided, the labels
                        must match the labels in the first line of the count
                        table; for example, "HL60.final,KBM7.final". For
                        sample index, "0,2" means the 1st and 3rd samples are
                        treatment experiments.
  --day0-label DAY0_LABEL
                        Specify the label for control sample (usually day 0 or
                        plasmid). For every other sample label, the module
                        will treat it as a treatment condition and compare
                        with control sample.

Optional general arguments:

  -c CONTROL_ID, --control-id CONTROL_ID
                        Sample label or sample index in the count table as
                        control experiments, separated by comma (,). Default
                        is all the samples not specified in treatment
                        experiments.
  --paired              Paired sample comparisons. In this mode, the number of
                        samples in -t and -c must match and have an exactly
                        the same order in terms of samples. For example, "-t
                        treatment_r1,treatment_r2 -c control_r1,control_r2".
  --norm-method {none,median,total,control}
                        Method for normalization, including "none" (no
                        normalization), "median" (median normalization,
                        default), "total" (normalization by total read
                        counts), "control" (normalization by control sgRNAs
                        specified by the --control-sgrna option).
  --gene-test-fdr-threshold GENE_TEST_FDR_THRESHOLD
                        p value threshold to determine the alpha value of RRA
                        in gene test (-p option in RRA), default 0.25.
  --adjust-method {fdr,holm,pounds}
                        Method for sgrna-level p-value adjustment, including
                        false discovery rate (fdr), holm's method (holm), or
                        pounds's method (pounds).
  --variance-estimation-samples VARIANCE_ESTIMATION_SAMPLES
                        Sample label or sample index for estimating variances,
                        separated by comma (,). See -t/--treatment-id option
                        for specifying samples.
  --sort-criteria {neg,pos}
                        Sorting criteria, either by negative selection (neg)
                        or positive selection (pos). Default negative
                        selection.
  --remove-zero {none,control,treatment,both,any}
                        Remove sgRNAs whose mean value is zero in control,
                        treatment, both control/treatment, or any
                        control/treatment sample. Default: both (remove those
                        sgRNAs that are zero in both control and treatment
                        samples).
  --remove-zero-threshold REMOVE_ZERO_THRESHOLD
                        sgRNA normalized count threshold to be considered
                        removed in the --remove-zero option. Default 0.
  --pdf-report          Generate pdf report of the analysis.
  --gene-lfc-method {median,alphamedian,mean,alphamean,secondbest}
                        Method to calculate gene log2 fold changes (LFC) from
                        sgRNA LFCs. Available methods include the median/mean
                        of all sgRNAs (median/mean), or the median/mean sgRNAs
                        that are ranked in front of the alpha cutoff in RRA
                        (alphamedian/alphamean), or the sgRNA that has the
                        second strongest LFC (secondbest). In the
                        alphamedian/alphamean case, the number of sgRNAs
                        correspond to the "goodsgrna" column in the output,
                        and the gene LFC will be set to 0 if no sgRNA is in
                        front of the alpha cutoff. Default median.

Optional arguments for input and output:

  -n OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        The prefix of the output file(s). Default sample1.
  --control-sgrna CONTROL_SGRNA
                        A list of control sgRNAs for normalization and for
                        generating the null distribution of RRA.
  --control-gene CONTROL_GENE
                        A list of genes whose sgRNAs are used as control
                        sgRNAs for normalization and for generating the null
                        distribution of RRA.
  --normcounts-to-file  Write normalized read counts to file ([output-
                        prefix].normalized.txt).
  --skip-gene SKIP_GENE
                        Skip genes in the report. By default, "NA" or "na"
                        will be skipped.
  --keep-tmp            Keep intermediate files.
  --additional-rra-parameters ADDITIONAL_RRA_PARAMETERS
                        Additional arguments to run RRA. They will be appended
                        to the command line for calling RRA.

Optional arguments for CNV correction:

  --cnv-norm CNV_NORM   A matrix of copy number variation data across cell
                        lines to normalize CNV-biased sgRNA scores prior to
                        gene ranking.
  --cell-line CELL_LINE
                        The name of the cell line to be used for copy number
                        variation normalization. Must match one of the column
                        names in the file provided by --cnv-norm.
  --cnv-est CNV_EST     Estimate CNV profiles from screening data. A BED file
                        with gene positions are required as input. The CNVs of
                        these genes are to be estimated and used for copy
                        number bias correction.
```


## mageck_pathway

### Tool Description
Pathway enrichment analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
- **Homepage**: http://mageck.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/mageck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mageck pathway [-h] --gene-ranking GENE_RANKING --gmt-file GMT_FILE
                      [-n OUTPUT_PREFIX] [--method {gsea,rra}]
                      [--single-ranking] [--sort-criteria {neg,pos}]
                      [--keep-tmp] [--ranking-column RANKING_COLUMN]
                      [--ranking-column-2 RANKING_COLUMN_2]
                      [--pathway-alpha PATHWAY_ALPHA]
                      [--permutation PERMUTATION]

options:
  -h, --help            show this help message and exit
  --gene-ranking GENE_RANKING
                        The gene summary file (containing both positive and
                        negative selection tests) generated by the gene test
                        step. Pathway enrichment will be performed in both
                        directions.
  --gmt-file GMT_FILE   The pathway file in GMT format.
  -n OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        The prefix of the output file(s). Default sample1.
  --method {gsea,rra}   Method for testing pathway enrichment, including gsea
                        (Gene Set Enrichment Analysis) or rra. Default gsea.
  --single-ranking      The provided file is a (single) gene ranking file,
                        either positive or negative selection. Only one
                        enrichment comparison will be performed.
  --sort-criteria {neg,pos}
                        Sorting criteria, either by negative selection (neg)
                        or positive selection (pos). Default negative
                        selection.
  --keep-tmp            Keep intermediate files.
  --ranking-column RANKING_COLUMN
                        Column number or label in gene summary file for gene
                        ranking; can be either an integer of column number, or
                        a string of column label. Default "2" (the 3rd
                        column), the column of the negative selection RRA
                        score in gene_summary file.
  --ranking-column-2 RANKING_COLUMN_2
                        Column number or label in gene summary file for gene
                        ranking; can be either an integer of column number, or
                        a string of column label. This option is used to
                        determine the column for positive selections and is
                        disabled if --single-ranking is specified. Default "8"
                        (the 9th column), the column of positive selection RRA
                        score in gene_summary file.
  --pathway-alpha PATHWAY_ALPHA
                        The default alpha value for RRA pathway enrichment.
                        Default 0.25.
  --permutation PERMUTATION
                        The perumtation for gsea. Default 1000.
```


## mageck_plot

### Tool Description
Plotting function for MAGeCK

### Metadata
- **Docker Image**: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
- **Homepage**: http://mageck.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/mageck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mageck plot [-h] -k COUNT_TABLE -g GENE_SUMMARY [--genes GENES]
                   [-s SAMPLES] [-n OUTPUT_PREFIX]
                   [--norm-method {none,median,total,control}]
                   [--control-sgrna CONTROL_SGRNA | --control-gene CONTROL_GENE]
                   [--keep-tmp]

options:
  -h, --help            show this help message and exit
  -k COUNT_TABLE, --count-table COUNT_TABLE
                        Provide a tab-separated count table instead of sam
                        files. Each line in the table should include sgRNA
                        name (1st column), gene name (2nd column) and read
                        counts in each sample.
  -g GENE_SUMMARY, --gene-summary GENE_SUMMARY
                        The gene summary file generated by the test command.
  --genes GENES         A list of genes to be plotted, separated by comma.
                        Default: none.
  -s SAMPLES, --samples SAMPLES
                        A list of samples to be plotted, separated by comma.
                        Default: using all samples in the count table.
  -n OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        The prefix of the output file(s). Default sample1.
  --norm-method {none,median,total,control}
                        Method for normalization, including "none" (no
                        normalization), "median" (median normalization,
                        default), "total" (normalization by total read
                        counts), "control" (normalization by control sgRNAs
                        specified by the --control-sgrna option).
  --control-sgrna CONTROL_SGRNA
                        A list of control sgRNAs for normalization and for
                        generating the null distribution of RRA.
  --control-gene CONTROL_GENE
                        A list of genes whose sgRNAs are used as control
                        sgRNAs for normalization and for generating the null
                        distribution of RRA.
  --keep-tmp            Keep intermediate files.
```


## mageck_mle

### Tool Description
Maximum Likelihood Estimation (MLE) module for MAGeCK.

### Metadata
- **Docker Image**: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
- **Homepage**: http://mageck.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/mageck/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mageck mle [-h] -k COUNT_TABLE
                  (-d DESIGN_MATRIX | --day0-label DAY0_LABEL)
                  [-n OUTPUT_PREFIX] [-i INCLUDE_SAMPLES] [-b BETA_LABELS]
                  [--control-sgrna CONTROL_SGRNA | --control-gene CONTROL_GENE]
                  [--cnv-norm CNV_NORM] [--cell-line CELL_LINE]
                  [--cnv-est CNV_EST] [--debug] [--debug-gene DEBUG_GENE]
                  [--norm-method {none,median,total,control}]
                  [--genes-varmodeling GENES_VARMODELING]
                  [--permutation-round PERMUTATION_ROUND]
                  [--no-permutation-by-group]
                  [--max-sgrnapergene-permutation MAX_SGRNAPERGENE_PERMUTATION]
                  [--remove-outliers] [--threads THREADS]
                  [--adjust-method {fdr,holm,pounds}]
                  [--sgrna-efficiency SGRNA_EFFICIENCY]
                  [--sgrna-eff-name-column SGRNA_EFF_NAME_COLUMN]
                  [--sgrna-eff-score-column SGRNA_EFF_SCORE_COLUMN]
                  [--update-efficiency] [--bayes] [-p] [-w PPI_WEIGHTING]
                  [-e NEGATIVE_CONTROL]

options:
  -h, --help            show this help message and exit

Required arguments:

  -k COUNT_TABLE, --count-table COUNT_TABLE
                        Provide a tab-separated count table. Each line in the
                        table should include sgRNA name (1st column), target
                        gene (2nd column) and read counts in each sample.
  -d DESIGN_MATRIX, --design-matrix DESIGN_MATRIX
                        Provide a design matrix, either a file name or a
                        quoted string of the design matrix. For example,
                        "1,1;1,0". The row of the design matrix must match the
                        order of the samples in the count table (if --include-
                        samples is not specified), or the order of the samples
                        by the --include-samples option.
  --day0-label DAY0_LABEL
                        Specify the label for control sample (usually day 0 or
                        plasmid). For every other sample label, the MLE module
                        will treat it as a single condition and generate an
                        corresponding design matrix.

Optional arguments for input and output:

  -n OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        The prefix of the output file(s). Default sample1.
  -i INCLUDE_SAMPLES, --include-samples INCLUDE_SAMPLES
                        Specify the sample labels if the design matrix is not
                        given by file in the --design-matrix option. Sample
                        labels are separated by ",", and must match the labels
                        in the count table.
  -b BETA_LABELS, --beta-labels BETA_LABELS
                        Specify the labels of the variables (i.e., beta), if
                        the design matrix is not given by file in the
                        --design-matrix option. Should be separated by ",",
                        and the number of labels must equal to (# columns of
                        design matrix), including baseline labels. Default
                        value: "bata_0,beta_1,beta_2,...".
  --control-sgrna CONTROL_SGRNA
                        A list of control sgRNAs for normalization and for
                        generating the null distribution of RRA.
  --control-gene CONTROL_GENE
                        A list of genes whose sgRNAs are used as control
                        sgRNAs for normalization and for generating the null
                        distribution of RRA.

Optional arguments for CNV correction:

  --cnv-norm CNV_NORM   A matrix of copy number variation data across cell
                        lines to normalize CNV-biased sgRNA scores prior to
                        gene ranking.
  --cell-line CELL_LINE
                        The name of the cell line to be used for copy number
                        variation normalization. Must match one of the column
                        names in the file provided by --cnv-norm. This option
                        will overwrite the default case where cell line names
                        are inferred from the columns of the design matrix.
  --cnv-est CNV_EST     Estimate CNV profiles from screening data. A BED file
                        with gene positions are required as input. The CNVs of
                        these genes are to be estimated and used for copy
                        number bias correction.

Optional arguments for MLE module:

  --debug               Debug mode to output detailed information of the
                        running.
  --debug-gene DEBUG_GENE
                        Debug mode to only run one gene with specified ID.
  --norm-method {none,median,total,control}
                        Method for normalization, including "none" (no
                        normalization), "median" (median normalization,
                        default), "total" (normalization by total read
                        counts), "control" (normalization by control sgRNAs
                        specified by the --control-sgrna option).
  --genes-varmodeling GENES_VARMODELING
                        The number of genes for mean-variance modeling.
                        Default 0.
  --permutation-round PERMUTATION_ROUND
                        The rounds for permutation (interger). The permutation
                        time is (# genes)*x for x rounds of permutation.
                        Suggested value: 10 (may take longer time). Default 2.
  --no-permutation-by-group
                        By default, gene permutation is performed separately,
                        by their number of sgRNAs. Turning this option will
                        perform permutation on all genes together. This makes
                        the program faster, but the p value estimation is
                        accurate only if the number of sgRNAs per gene is
                        approximately the same.
  --max-sgrnapergene-permutation MAX_SGRNAPERGENE_PERMUTATION
                        Do not calculate beta scores or p vales if the number
                        of sgRNAs per gene is greater than this number. This
                        will save a lot of time if some isolated regions are
                        targeted by a large number of sgRNAs (usually
                        hundreds). Must be an integer. Default 40.
  --remove-outliers     Try to remove outliers. Turning this option on will
                        slow the algorithm.
  --threads THREADS     Using multiple threads to run the algorithm. Default
                        using only 1 thread.
  --adjust-method {fdr,holm,pounds}
                        Method for sgrna-level p-value adjustment, including
                        false discovery rate (fdr), holm's method (holm), or
                        pounds's method (pounds).

Optional arguments for the EM iteration:

  --sgrna-efficiency SGRNA_EFFICIENCY
                        An optional file of sgRNA efficiency prediction. The
                        efficiency prediction will be used as an initial guess
                        of the probability an sgRNA is efficient. Must contain
                        at least two columns, one containing sgRNA ID, the
                        other containing sgRNA efficiency prediction.
  --sgrna-eff-name-column SGRNA_EFF_NAME_COLUMN
                        The sgRNA ID column in sgRNA efficiency prediction
                        file (specified by the --sgrna-efficiency option).
                        Default is 0 (the first column).
  --sgrna-eff-score-column SGRNA_EFF_SCORE_COLUMN
                        The sgRNA efficiency prediction column in sgRNA
                        efficiency prediction file (specified by the --sgrna-
                        efficiency option). Default is 1 (the second column).
  --update-efficiency   Iteratively update sgRNA efficiency during EM
                        iteration.

Optional arguments for the Bayes estimation of gene essentiality (experimental):

  --bayes               Use the experimental Bayes module to estimate gene
                        essentiality
  -p, --PPI-prior       Specify whether you want to incorporate PPI as prior
  -w PPI_WEIGHTING, --PPI-weighting PPI_WEIGHTING
                        The weighting used to calculate PPI prior. If not
                        provided, iterations will be used.
  -e NEGATIVE_CONTROL, --negative-control NEGATIVE_CONTROL
                        The gene name of negative controls. The corresponding
                        sgRNA will be viewed independently.
```

