# ampliconsuite CWL Generation Report

## ampliconsuite_AmpliconSuite-pipeline.py

### Tool Description
A pipeline wrapper for AmpliconArchitect, invoking alignment CNV calling and CNV filtering prior. Can launch AA, as well as downstream amplicon classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/ampliconsuite:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/AmpliconSuite
- **Package**: https://anaconda.org/channels/bioconda/packages/ampliconsuite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ampliconsuite/overview
- **Total Downloads**: 16.3K
- **Last updated**: 2025-12-04
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: AmpliconSuite-pipeline.py [-h] [-v] [-t INT]
                                 [--bam FILE | --fastqs TWO FILES TWO FILES | --completed_AA_runs PATH]
                                 [--cnv_bed FILE | --cnvkit_dir PATH] [-s STR]
                                 [-o PATH] [--run_AA] [--run_AC] [--no_QC]
                                 [--align_only] [--ref STR]
                                 [--download_repo {hg19,GRCh37,GRCh38,mm10,GRCh38_viral,hg19_indexed,GRCh37_indexed,GRCh38_indexed,mm10_indexed,GRCh38_viral_indexed} [{hg19,GRCh37,GRCh38,mm10,GRCh38_viral,hg19_indexed,GRCh37_indexed,GRCh38_indexed,mm10_indexed,GRCh38_viral_indexed} ...]]
                                 [--cngain FLOAT] [--cnsize_min INT]
                                 [--no_filter] [--rscript_path PATH]
                                 [--python3_path PATH]
                                 [--aa_python_interpreter PATH]
                                 [--samtools_path SAMTOOLS_PATH]
                                 [--AA_src PATH] [--downsample FLOAT]
                                 [--sv_vcf FILE] [--sv_vcf_no_filter]
                                 [--AA_runmode STR] [--AA_extendmode STR]
                                 [--AA_insert_sdevs FLOAT]
                                 [--pair_support_min INT]
                                 [--foldback_pair_support_min INT]
                                 [--normal_bam FILE] [--ploidy FLOAT]
                                 [--purity FLOAT] [--cnvkit_segmentation STR]
                                 [--sample_metadata FILE]
                                 [--completed_run_metadata FILE] [--upload]
                                 [--project_uuid STR] [--project_key STR]
                                 [--username STR] [--upload_server STR]

A pipeline wrapper for AmpliconArchitect, invoking alignment CNV calling and
CNV filtering prior. Can launch AA, as well as downstream amplicon
classification.

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -t INT, --nthreads INT
                        (Required) Number of threads to use in BWA and CNV
                        calling
  --bam FILE, --sorted_bam FILE
                        Coordinate sorted BAM file (aligned to an AA-supported
                        reference.)
  --fastqs TWO FILES TWO FILES
                        Fastq files (r1.fq r2.fq)
  --completed_AA_runs PATH
                        Path to a directory containing one or more completed
                        AA runs which utilized the same reference genome.
  --cnv_bed FILE, --bed FILE
                        BED file (or CNVKit .cns file) of CNV changes. Fields
                        in the bed file should be: chr start end name cngain
  --cnvkit_dir PATH     Optional path to cnvkit.py. Assumes CNVKit is on the
                        system path if not set and no --cnv_bed given
  -s STR, --sample_name STR
                        (Required) Sample name
  -o PATH, --output_directory PATH
                        Output directory name. Will create directory if
                        needed.
  --run_AA              Run AA after all files prepared. Default off.
  --run_AC              Run AmpliconClassifier after all files prepared.
                        Default off.
  --no_QC               Skip QC on the BAM file. Do not adjust AA insert_sdevs
                        for poor-quality insert size distribution
  --align_only          Only perform the alignment stage (do not run CNV
                        calling and seeding
  --ref STR             Reference genome version. Autodetected unless fastqs
                        given as input.
  --download_repo {hg19,GRCh37,GRCh38,mm10,GRCh38_viral,hg19_indexed,GRCh37_indexed,GRCh38_indexed,mm10_indexed,GRCh38_viral_indexed} [{hg19,GRCh37,GRCh38,mm10,GRCh38_viral,hg19_indexed,GRCh37_indexed,GRCh38_indexed,mm10_indexed,GRCh38_viral_indexed} ...]
                        Download the selected data repo to the $AA_DATA_REPO
                        directory and exit. '_indexed' suffix indicates BWA
                        index is included, which is useful if performing
                        alignment with AmpliconSuite-pipeline, but has a
                        larger filesize.
  --cngain FLOAT        CN gain threshold to consider for AA seeding
  --cnsize_min INT      CN interval size (in bp) to consider for AA seeding
  --no_filter           Do not run amplified_intervals.py to remove low
                        confidence candidate seed regions overlapping
                        repetitive parts of the genome
  --rscript_path PATH   Specify custom path to Rscript for CNVKit, which
                        requires R version >=3.5
  --python3_path PATH   If needed, specify a custom path to python3.
  --aa_python_interpreter PATH
                        By default AmpliconSuite-pipeline will use the
                        system's default python path. If you would like to use
                        a different python version with AA, set this to either
                        the path to the interpreter or 'python', 'python3',
                        'python2' (default 'python3')
  --samtools_path SAMTOOLS_PATH
                        Path to samtools binary (e.g., /path/to/my/samtools).
                        If unset, will use samtools on system path.
  --AA_src PATH         Specify a custom $AA_SRC path. Overrides the bash
                        variable
  --downsample FLOAT    AA downsample argument (see AA documentation)
  --sv_vcf FILE         Provide a VCF file of externally-called SVs to augment
                        SVs identified by AA internally.
  --sv_vcf_no_filter    Use all external SV calls from the --sv_vcf arg, even
                        those without 'PASS' in the FILTER column.
  --AA_runmode STR      If --run_AA selected, set the --runmode argument to
                        AA. Default mode is 'FULL'
  --AA_extendmode STR   If --run_AA selected, set the --extendmode argument to
                        AA. Default mode is 'EXPLORE'
  --AA_insert_sdevs FLOAT
                        Number of standard deviations around the insert size.
                        May need to increase for sequencing runs with high
                        variance after insert size selection step. (default
                        3.0)
  --pair_support_min INT
                        Number of read pairs for minimum breakpoint support
                        (default 2 but typically becomes higher due to
                        coverage-scaled cutoffs)
  --foldback_pair_support_min INT
                        Number of read pairs for minimum foldback SV support
                        (default 2 but typically becomes higher due to
                        coverage-scaled cutoffs). Used value will be the
                        maximum of pair_support and this argument. Raising to
                        3 will help dramatically in heavily artifacted
                        samples.
  --normal_bam FILE     Path to matched normal bam for CNVKit (optional)
  --ploidy FLOAT        Ploidy estimate for CNVKit (optional). This is not
                        used outside of CNVKit.
  --purity FLOAT        Tumor purity estimate for CNVKit (optional). This is
                        not used outside of CNVKit.
  --cnvkit_segmentation STR
                        Segmentation method for CNVKit (if used), defaults to
                        CNVKit default segmentation method (cbs).
  --sample_metadata FILE
                        JSON file of sample metadata to build on
  --completed_run_metadata FILE
                        Run metadata JSON to retroactively assign to
                        collection of samples
  --upload              (Optional) Upload results to specified project on
                        AmpliconRepository
  --project_uuid STR    Project UUID for upload (required if --upload is set)
  --project_key STR     Project key for upload (required if --upload is set)
  --username STR        Username for upload (required if --upload is set)
  --upload_server STR   Upload server: 'local', 'dev', 'prod' (prod is
                        default)
```


## ampliconsuite_amplicon_classifier.py

### Tool Description
Classify AA amplicon type

### Metadata
- **Docker Image**: quay.io/biocontainers/ampliconsuite:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/AmpliconSuite
- **Package**: https://anaconda.org/channels/bioconda/packages/ampliconsuite/overview
- **Validation**: PASS

### Original Help Text
```text
usage: amplicon_classifier.py [-h]
                              (--AA_results AA_RESULTS | -i INPUT | -c CYCLES)
                              [-g GRAPH] --ref
                              {hg19,GRCh37,hg38,GRCh38,GRCh38_viral,mm10,GRCm38}
                              -o O [--min_flow MIN_FLOW] [--min_size MIN_SIZE]
                              [--decomposition_strictness DECOMPOSITION_STRICTNESS]
                              [--plotstyle {grouped,individual,noplot}]
                              [--force] [--add_chr_tag] [--report_complexity]
                              [--verbose_classification] [--no_LC_filter]
                              [--exclude_bed EXCLUDE_BED] [--filter_similar]
                              [--filter_pval FILTER_PVAL] [--config CONFIG]
                              [--make_results_table] [-v]

Classify AA amplicon type

options:
  -h, --help            show this help message and exit
  --AA_results AA_RESULTS
                        Path to location of AA output files. Can be multiple
                        runs in a single parent directory.
  -i INPUT, --input INPUT
                        Alternative to --AA_results if make_input.sh was
                        already run to produce the .input file
  -c CYCLES, --cycles CYCLES
                        Alternative to --AA_results for classifying a single
                        amplicon. Path to an AA-formatted cycles file.
  -g GRAPH, --graph GRAPH
                        Path to AA-formatted graph file (required if --cycles
                        given)
  --ref {hg19,GRCh37,hg38,GRCh38,GRCh38_viral,mm10,GRCm38}
                        Reference genome name used for alignment, one of hg19,
                        GRCh37, or GRCh38.
  -o O                  Output filename prefix
  --min_flow MIN_FLOW   Minimum flow to consider among decomposed paths (1.0).
  --min_size MIN_SIZE   Minimum cycle size (in bp) to consider as valid
                        amplicon (5000).
  --decomposition_strictness DECOMPOSITION_STRICTNESS
                        Value between 0 and 1 reflecting how strictly to
                        filter low CN decompositions (default = 0.1). Higher
                        values filter more of the low-weight decompositions.
  --plotstyle {grouped,individual,noplot}
                        Type of visualizations to produce.
  --force               Disable No amp/Invalid class if possible
  --add_chr_tag         Add 'chr' to the beginning of chromosome names in
                        input files.
  --report_complexity   [Deprecated - on by default] Compute a measure of
                        amplicon entropy for each amplicon.
  --verbose_classification
                        Generate verbose output with raw classification
                        scores.
  --no_LC_filter        Do not filter low-complexity cycles. Not recommended
                        to set this flag.
  --exclude_bed EXCLUDE_BED
                        List of regions in which to ignore classification.
  --filter_similar      Only use if all samples are of independent origins
                        (not replicates and not multi-region biopsies).
                        Permits filtering of false-positive amps arising in
                        multiple independent samples based on similarity
                        calculation
  --filter_pval FILTER_PVAL
                        P value cutoff to use when --filter_similar is set.
                        Default is 0.05/(n_amps-1)
  --config CONFIG       Path to custom parameter configuration file. If not
                        specified, uses default config in ampclasslib
                        directory.
  --make_results_table  Create summary results table after classification
                        completes. Only works when using --AA_results or
                        --input (not with -c/-g single amplicon mode).
  -v, --version         show program's version number and exit
```

