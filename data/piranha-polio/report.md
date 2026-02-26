# piranha-polio CWL Generation Report

## piranha-polio_piranha

### Tool Description
Poliovirus Investigation Resource
Automating Nanopore Haplotype Analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/piranha-polio:1.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/polio-nanopore/piranha
- **Package**: https://anaconda.org/channels/bioconda/packages/piranha-polio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/piranha-polio/overview
- **Total Downloads**: 19.0K
- **Last updated**: 2025-05-30
- **GitHub**: https://github.com/polio-nanopore/piranha
- **Stars**: N/A
### Original Help Text
```text
[32m

                            __                      __            
                    ______ |__|_____ _____  |\____ |  |__ _____   
                    \____ \|  |\  _ \\__  \ |     \|  |  \\__  \  
                    |  |_| |  ||  |\/ / __ \|   |  \   |  \/ __ \ 
                    |   __/|__||__|  (____ / ___|__/___|___(____/ 
                    |__|                                          

                     **** Poliovirus Investigation Resource ****
                   **** Automating Nanopore Haplotype Analysis ****
                [0m[32m
                                        1.5.3[0m[32m
                        ****************************************[0m
                             Developed by researchers at[32m
                               University of Edinburgh[0m
                                in collaboration with[32m
                           Imperial College London & NIBSC[0m
                                      Supported by:[32m
                    ARTIC Network Wellcome Trust Collaborators Award
                                    (206298/Z/17/Z)
                           Bill and Melinda Gates Foundation 
                                    (OPP1207299)


[0m
usage: 
	piranha -c <config.yaml> [options]
	piranha -b <barcodes.csv> -i <demultiplexed fastq_dir> [options]

Input options:
  -c CONFIG, --config CONFIG
                        Input config file in yaml format, all command line
                        arguments can be passed via the config file.
  -i READDIR, --readdir READDIR
                        Path to the directory containing fastq read files
  -b BARCODES_CSV, --barcodes-csv BARCODES_CSV
                        CSV file describing which barcodes were used on which
                        sample
  -e EPI_CSV, --epi-csv EPI_CSV
                        CSV file providing EPI-info for the samples. Sample
                        names must correspond to the names in barcodes_csv
  -r REFERENCE_SEQUENCES, --reference-sequences REFERENCE_SEQUENCES
                        Custom reference sequences file.
  -rg REFERENCE_GROUP_FIELD, --reference-group-field REFERENCE_GROUP_FIELD
                        Specify reference description field to group
                        references by. Default: `ddns_group`
  -nc NEGATIVE_CONTROL, --negative-control NEGATIVE_CONTROL
                        Sample name of negative control. If multiple samples,
                        supply as comma-separated string of sample names. E.g.
                        `sample01,sample02` Default: `negative`
  -pc POSITIVE_CONTROL, --positive-control POSITIVE_CONTROL
                        Sample name of positive control. If multiple samples,
                        supply as comma-separated string of sample names. E.g.
                        `sample01,sample02`. Default: `positive`
  -pr POSITIVE_REFERENCES, --positive-references POSITIVE_REFERENCES
                        Comma separated string of sequences in the reference
                        file to class as positive control sequences.

Analysis options:
  -s SAMPLE_TYPE, --sample-type SAMPLE_TYPE
                        Specify sample type. Options: `stool`,
                        `environmental`, `isolate`. Default: `stool`
  -m ANALYSIS_MODE, --analysis-mode ANALYSIS_MODE
                        Specify analysis mode to run, for preconfigured
                        defaults. Options: `vp1`, `wg`. Default: `vp1`
  --medaka-model MEDAKA_MODEL
                        Medaka model to run analysis using. Default:
                        r941_min_hac_variant_g507
  --medaka-list-models  List available medaka models and exit.
  -q MIN_MAP_QUALITY, --min-map-quality MIN_MAP_QUALITY
                        Minimum mapping quality. Range 0 to 60, however 0 can
                        imply a multimapper. Default: 0
  -n MIN_READ_LENGTH, --min-read-length MIN_READ_LENGTH
                        Minimum read length. Default: 1000
  -x MAX_READ_LENGTH, --max-read-length MAX_READ_LENGTH
                        Maximum read length. Default: 1300
  -d MIN_READ_DEPTH, --min-read-depth MIN_READ_DEPTH
                        Minimum read depth required for consensus generation.
                        Default: 50
  -p MIN_READ_PCENT, --min-read-pcent MIN_READ_PCENT
                        Minimum percentage of sample required for consensus
                        generation. Default: 0
  -a MIN_ALN_BLOCK, --min-aln-block MIN_ALN_BLOCK
                        Minimum alignment block length. Default:
                        0.6*MIN_READ_LENGTH
  --primer-length PRIMER_LENGTH
                        Length of primer sequences to trim off start and end
                        of reads. Default: 30
  -mo [MINIMAP2_OPTIONS ...], --minimap2-options [MINIMAP2_OPTIONS ...]
                        Specify any number of minimap2 options to overwrite
                        the default mapping settings. The options take the
                        form `flag=value` and can be any number of space-
                        delimited options. Default: -x asm20. Example: For
                        short reads of a sample diverged from the reference,
                        we suggest using `-mo k=5 w=4`, which overwrites the
                        minimap2 option `-x asm20`.

Haplotyping options:
  -rh, --run-haplotyping
                        Trigger the optional haplotyping module. Additional
                        dependencies may need to be installed.
  -hs HAPLOTYPE_SAMPLE_SIZE, --haplotype-sample-size HAPLOTYPE_SAMPLE_SIZE
                        Number of reads to downsample to for haplotype
                        calling. Default: 3000
  -hf MIN_ALLELE_FREQUENCY, --min-allele-frequency MIN_ALLELE_FREQUENCY
                        Minimum allele frequency to call. Note: setting this
                        below 0.07 may significantly increase run time.
                        Default: 0.07
  -hx MAX_HAPLOTYPES, --max-haplotypes MAX_HAPLOTYPES
                        Maximum number of haplotypes callable within reference
                        group. Default: 4
  -hdist MIN_HAPLOTYPE_DISTANCE, --min-haplotype-distance MIN_HAPLOTYPE_DISTANCE
                        Minimum number of SNPs between haplotypes. Default: 2
  -hd MIN_HAPLOTYPE_DEPTH, --min-haplotype-depth MIN_HAPLOTYPE_DEPTH
                        Minimum number of reads in a given haplotype. Default:
                        20

Phylogenetics options:
  -rp, --run-phylo      Trigger the optional phylogenetics module. Additional
                        dependencies may need to be installed.
  -sd SUPPLEMENTARY_DATADIR, --supplementary-datadir SUPPLEMENTARY_DATADIR
                        Path to directory containing supplementary sequence
                        FASTA file and optional metadata to be incorporated
                        into phylogenetic analysis.
  -pcol PHYLO_METADATA_COLUMNS, --phylo-metadata-columns PHYLO_METADATA_COLUMNS
                        Columns in the barcodes.csv file to annotate the
                        phylogeny with. Default: ['call', 'sample_date',
                        'EPID']
  -smcol SUPPLEMENTARY_METADATA_COLUMNS, --supplementary-metadata-columns SUPPLEMENTARY_METADATA_COLUMNS
                        Columns in the supplementary metadata to annotate the
                        phylogeny with. Default: ['location', 'lineage']
  -smid SUPPLEMENTARY_METADATA_ID_COLUMN, --supplementary-metadata-id-column SUPPLEMENTARY_METADATA_ID_COLUMN
                        Column in the supplementary metadata files to match
                        with the supplementary sequences. Default:
                        sequence_name
  -ud, --update-local-database
                        Add newly generated consensus sequences (with a
                        distance greater than a threshold (--local-database-
                        threshold) away from Sabin, if Sabin-related) and
                        associated metadata to the supplementary data
                        directory.
  -dt, --local-database-threshold
                        The threshold beyond which Sabin-related sequences are
                        added to the supplementary data directory if update
                        local database flag used. Default: 6

Output options:
  -o OUTDIR, --outdir OUTDIR
                        Output directory. Default: `analysis-2022-XX-YY`
  -pub PUBLISHDIR, --publishdir PUBLISHDIR
                        Output publish directory. Default: `analysis-2022-XX-
                        YY`
  -pre OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        Prefix of output directory & report name: Default:
                        `analysis`
  --datestamp DATESTAMP
                        Append datestamp to directory name when using
                        <-o/--outdir>. Default: <-o/--outdir> without a
                        datestamp
  --overwrite           Overwrite output directory. Default: append an
                        incrementing number if <-o/--outdir> already exists
  -temp TEMPDIR, --tempdir TEMPDIR
                        Specify where you want the temp stuff to go. Default:
                        `$TMPDIR`
  --no-temp             Output all intermediate files. For development/
                        debugging purposes
  --all-metadata-to-header
                        Parse all fields from input barcode.csv file and
                        include in the output fasta headers. Be aware spaces
                        in metadata will disrupt the record id, so avoid
                        these.
  --language LANGUAGE   Output report language. Options: English, French.
                        Default: English
  --save-config         Output the config file with all parameters used
  --archive-fastq       Write the supplied fastq_pass directory to the output
                        directory.
  --archivedir ARCHIVEDIR
                        Configure where to put the fastq_pass files, default
                        in the output directory.

Misc options:
  --runname RUNNAME     Run name to appear in report. Default: polioDDNS
  --username USERNAME   Username to appear in report. Default: no user name
  --institute INSTITUTE
                        Institute name to appear in report. Default: no
                        institute name
  --notes NOTES         Miscellaneous notes to appear at top of report.
                        Default: no notes
  --orientation ORIENTATION
                        Orientation of barcodes in wells on a 96-well plate.
                        If `well` is supplied as a column in the barcode.csv,
                        this default orientation will be overwritten. Default:
                        `vertical`. Options: `vertical` or `horizontal`.
  -t THREADS, --threads THREADS
                        Number of threads. Default: 1
  --verbose             Print lots of stuff to screen
  -v, --version         show program's version number and exit
  -h, --help
```

