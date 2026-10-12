# ont-tombo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ont-tombo_detect_modifications_aggregate_per_read_stats | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; aggregated the per-read stats from alternative_model into a genomic stats file |
| ont-tombo_detect_modifications_alternative_model | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; 5mC model on the re-squiggled reads; stats and per-read stats written |
| ont-tombo_detect_modifications_de_novo | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; chained from resquiggle output; stats and per-read stats files written |
| ont-tombo_detect_modifications_level_sample_compare | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; WT against KO control; stats file written |
| ont-tombo_plot_max_coverage | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; PDF written; --control-fast5-basedirs crashes in this image (NameError _R_DF, R plotting missing), the main mode works |
| ont-tombo_preprocess_annotate_raw_with_fastqs | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; basecalls added to all 40 reads; fast5 directory staged writable |
| ont-tombo_resquiggle | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; 37 of 40 reads re-squiggled, resquiggle groups present in the output fast5 |
| ont-tombo_text_output_browser_files | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; coverage, fraction and statistic wig/bedGraph files written from the de_novo stats |
| ont-tombo_text_output_signif_sequence_context | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; 50 sequences written and all found in the reference at the reported positions; genome FASTA staged writable |

## ont-tombo_preprocess_annotate_raw_with_fastqs

### Tool Description
Add basecalled sequence from FASTQs to raw FAST5s.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
[help] tombo preprocess annotate_raw_with_fastqs: ok via tombo preprocess annotate_raw_with_fastqs --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: tombo preprocess annotate_raw_with_fastqs --fast5-basedir FAST5_BASEDIR
                                                 --fastq-filenames
                                                 FASTQ_FILENAMES
                                                 [FASTQ_FILENAMES ...]
                                                 [--basecall-group BASECALL_GROUP]
                                                 [--basecall-subgroup BASECALL_SUBGROUP]
                                                 [--overwrite]
                                                 [--sequencing-summary-filenames SEQUENCING_SUMMARY_FILENAMES [SEQUENCING_SUMMARY_FILENAMES ...]]
                                                 [--processes PROCESSES]
                                                 [--quiet] [--help]

Required Arguments:
  --fast5-basedir FAST5_BASEDIR
                        Directory containing fast5 files.
  --fastq-filenames FASTQ_FILENAMES [FASTQ_FILENAMES ...]
                        FASTQ filenames containing basecalls to be added to
                        raw FAST5 files.

FAST5 Data Arguments:
  --basecall-group BASECALL_GROUP
                        FAST5 group obtain original basecalls (under Analyses
                        group). Default: Basecall_1D_000
  --basecall-subgroup BASECALL_SUBGROUP
                        FAST5 subgroup (under /Analyses/[--basecall-group]/)
                        under which to store basecalls from FASTQs. Default:
                        BaseCalled_template
  --overwrite           Overwrite previous corrected group in FAST5 files.
                        Note: only effects --corrected-group or --new-
                        corrected-group.

Sequencing Summary Argument:
  --sequencing-summary-filenames SEQUENCING_SUMMARY_FILENAMES [SEQUENCING_SUMMARY_FILENAMES ...]
                        Sequencing summary filenames produced by albacore.
                        These can make annotation of raw FAST5 files with
                        FASTQ sequence much faster.

Multiprocessing Argument:
  --processes PROCESSES
                        Number of processes. Default: 1

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_resquiggle

### Tool Description
Re-annotate raw signal with genomic alignment from existing basecalls.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
[help] tombo resquiggle: ok via tombo resquiggle --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: tombo resquiggle [--dna] [--rna]
                        [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                        [--q-score Q_SCORE]
                        [--signal-matching-score SIGNAL_MATCHING_SCORE]
                        [--processes PROCESSES]
                        [--corrected-group CORRECTED_GROUP]
                        [--basecall-group BASECALL_GROUP]
                        [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                        [--overwrite]
                        [--failed-reads-filename FAILED_READS_FILENAME]
                        [--num-most-common-errors NUM_MOST_COMMON_ERRORS]
                        [--print-advanced-arguments] [--quiet] [--help]
                        fast5s_basedir reference

Required Arguments:
  fast5s_basedir        Directory containing fast5 files. All files ending in
                        "fast5" found recursively within this base directory
                        will be processed.
  reference             Reference genome/transcriptome FASTA file or minimap2
                        index (with "map-ont" preset) for mapping.

Model Parameters:
  --dna                 Explicitly select canonical DNA model. Default:
                        Automatically determine from FAST5s
  --rna                 Explicitly select canonical RNA model. Default:
                        Automatically determine from FAST5s

Read Filtering Argument:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads based on observations per base percentile
                        thresholds. Format thresholds as "percentile:thresh
                        [pctl2:thresh2 ...]". For example to filter reads with
                        99th pctl > 200 obs/base or max > 5k obs/base use
                        "99:200 100:5000".
  --q-score Q_SCORE     Q-score threshold for filtering low quality reads.
                        Default: 0.000000
  --signal-matching-score SIGNAL_MATCHING_SCORE
                        Observed to expected signal matching score (higher
                        score indicates poor matching). Sample type defaults:
                        RNA : 2 || DNA : 1.1

Multiprocessing Arguments:
  --processes PROCESSES
                        Number of processes. Default: 1

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-group BASECALL_GROUP
                        FAST5 group obtain original basecalls (under Analyses
                        group). Default: Basecall_1D_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under /Analyses/[--basecall-
                        group]/) containing basecalls and created within
                        [--corrected-group] containing re-squiggle results.
                        Default: ['BaseCalled_template']
  --overwrite           Overwrite previous corrected group in FAST5 files.
                        Note: only effects --corrected-group or --new-
                        corrected-group.

Input/Output Arguments:
  --failed-reads-filename FAILED_READS_FILENAME
                        Output failed read filenames with assoicated error.
                        Default: Do not store failed reads.
  --num-most-common-errors NUM_MOST_COMMON_ERRORS
                        Dynamically show this many most common errors so far
                        through run. Default: 0; Just show progress

Advanced Arguments:
  --print-advanced-arguments
                        Print advanced re-squiggle arguments and exit.

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_detect_modifications_de_novo

### Tool Description
Test for shifts in raw signal against a canonical base model.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
[help] tombo detect_modifications de_novo: ok via tombo detect_modifications de_novo --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: tombo detect_modifications de_novo --fast5-basedirs FAST5_BASEDIRS
                                          [FAST5_BASEDIRS ...]
                                          --statistics-file-basename
                                          STATISTICS_FILE_BASENAME [--dna]
                                          [--rna]
                                          [--fishers-method-context FISHERS_METHOD_CONTEXT]
                                          [--minimum-test-reads MINIMUM_TEST_READS]
                                          [--single-read-threshold SINGLE_READ_THRESHOLD [SINGLE_READ_THRESHOLD ...]]
                                          [--coverage-dampen-counts COVERAGE_DAMPEN_COUNTS COVERAGE_DAMPEN_COUNTS]
                                          [--per-read-statistics-basename PER_READ_STATISTICS_BASENAME]
                                          [--num-most-significant-stored NUM_MOST_SIGNIFICANT_STORED]
                                          [--multiprocess-region-size MULTIPROCESS_REGION_SIZE]
                                          [--processes PROCESSES]
                                          [--corrected-group CORRECTED_GROUP]
                                          [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                          [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --statistics-file-basename STATISTICS_FILE_BASENAME
                        File base name to save base by base statistics from
                        testing. Filenames will be [--statistics-file-
                        basename].[--alternate-bases]?.tombo.stats

Comparison Model Arguments:
  --dna                 Explicitly select canonical DNA model. Default:
                        Automatically determine from FAST5s
  --rna                 Explicitly select canonical RNA model. Default:
                        Automatically determine from FAST5s

Significance Test Arguments:
  --fishers-method-context FISHERS_METHOD_CONTEXT
                        Number of context bases up and downstream over which
                        to compute Fisher's method combined p-values. Note:
                        Not applicable for alternative model likelihood ratio
                        tests. Default: 1.
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required at a position to perform
                        significance testing or contribute to model
                        estimation. Default: 1
  --single-read-threshold SINGLE_READ_THRESHOLD [SINGLE_READ_THRESHOLD ...]
                        P-value threshold when computing fraction of
                        significant reads at each genomic position. If two
                        values are provided, statistics between these values
                        are not considered. Default thresholds: DNA:0.15-0.5 ,
                        RNA:0.05-0.4
  --coverage-dampen-counts COVERAGE_DAMPEN_COUNTS COVERAGE_DAMPEN_COUNTS
                        Dampen fraction modified estimates for low coverage
                        sites. Two parameters are unmodified and modified
                        pseudo read counts. This is equivalent to a beta prior
                        on the fraction estimate. Set to "0 0" to disable
                        dampened fraction estimation. Default: [2, 0]

Output Argument:
  --per-read-statistics-basename PER_READ_STATISTICS_BASENAME
                        Base for binary files containing per-read statistics
                        from statistical testing. Filenames will be [--per-
                        read-statistics-basename].[--alternate-
                        bases]?.tombo.per_read_stats
  --num-most-significant-stored NUM_MOST_SIGNIFICANT_STORED
                        Number of the most significant sites to store for
                        faster access. If a longer list of most significant
                        sites is required the list must be re-computed from
                        all batches. Very large values can increase RAM usage.
                        Default: 100000

Multiprocessing Arguments:
  --multiprocess-region-size MULTIPROCESS_REGION_SIZE
                        Size of regions over which to multiprocesses statistic
                        computation. For very deep samples a smaller value is
                        recommmended in order to control memory consumption.
                        Default: 10000
  --processes PROCESSES
                        Number of processes. Default: 1

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under /Analyses/[--basecall-
                        group]/) containing basecalls and created within
                        [--corrected-group] containing re-squiggle results.
                        Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_detect_modifications_alternative_model

### Tool Description
Test for shifts in raw signal which match those of a specific known non-canonical base.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
[help] tombo detect_modifications alternative_model: ok via tombo detect_modifications alternative_model --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: tombo detect_modifications alternative_model
                                                    [--fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]]
                                                    [--statistics-file-basename STATISTICS_FILE_BASENAME]
                                                    [--alternate-bases {CpG,6mA,dam,5mC,dcm} [{CpG,6mA,dam,5mC,dcm} ...]]
                                                    [--print-available-models]
                                                    [--dna] [--rna]
                                                    [--minimum-test-reads MINIMUM_TEST_READS]
                                                    [--single-read-threshold SINGLE_READ_THRESHOLD [SINGLE_READ_THRESHOLD ...]]
                                                    [--standard-log-likelihood-ratio]
                                                    [--coverage-dampen-counts COVERAGE_DAMPEN_COUNTS COVERAGE_DAMPEN_COUNTS]
                                                    [--per-read-statistics-basename PER_READ_STATISTICS_BASENAME]
                                                    [--num-most-significant-stored NUM_MOST_SIGNIFICANT_STORED]
                                                    [--multiprocess-region-size MULTIPROCESS_REGION_SIZE]
                                                    [--processes PROCESSES]
                                                    [--corrected-group CORRECTED_GROUP]
                                                    [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                                    [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --statistics-file-basename STATISTICS_FILE_BASENAME
                        File base name to save base by base statistics from
                        testing. Filenames will be [--statistics-file-
                        basename].[--alternate-bases]?.tombo.stats
  --alternate-bases {CpG,6mA,dam,5mC,dcm} [{CpG,6mA,dam,5mC,dcm} ...]
                        Default non-standard base model for testing (not
                        required if user created --alternate-model-filenames
                        is provided).

Comparison Arguments:
  --print-available-models
                        Print available alternative models and exit.
  --dna                 Explicitly select canonical DNA model. Default:
                        Automatically determine from FAST5s
  --rna                 Explicitly select canonical RNA model. Default:
                        Automatically determine from FAST5s

Significance Test Arguments:
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required at a position to perform
                        significance testing or contribute to model
                        estimation. Default: 1
  --single-read-threshold SINGLE_READ_THRESHOLD [SINGLE_READ_THRESHOLD ...]
                        Log likelihood ratio threshold when computing fraction
                        of significant reads at each genomic position. If two
                        values are provided, statistics between these values
                        are not considered. Default thresholds: DNA:-1.5-2.5 ,
                        RNA:-2.5-2.5
  --standard-log-likelihood-ratio
                        Use a standard log likelihood ratio (LLR) statistic.
                        Default is to use an outlier-robust LLR-like
                        statistic. Detail in full online documentation.
  --coverage-dampen-counts COVERAGE_DAMPEN_COUNTS COVERAGE_DAMPEN_COUNTS
                        Dampen fraction modified estimates for low coverage
                        sites. Two parameters are unmodified and modified
                        pseudo read counts. This is equivalent to a beta prior
                        on the fraction estimate. Set to "0 0" to disable
                        dampened fraction estimation. Default: [2, 0]

Output Argument:
  --per-read-statistics-basename PER_READ_STATISTICS_BASENAME
                        Base for binary files containing per-read statistics
                        from statistical testing. Filenames will be [--per-
                        read-statistics-basename].[--alternate-
                        bases]?.tombo.per_read_stats
  --num-most-significant-stored NUM_MOST_SIGNIFICANT_STORED
                        Number of the most significant sites to store for
                        faster access. If a longer list of most significant
                        sites is required the list must be re-computed from
                        all batches. Very large values can increase RAM usage.
                        Default: 100000

Multiprocessing Arguments:
  --multiprocess-region-size MULTIPROCESS_REGION_SIZE
                        Size of regions over which to multiprocesses statistic
                        computation. For very deep samples a smaller value is
                        recommmended in order to control memory consumption.
                        Default: 10000
  --processes PROCESSES
                        Number of processes. Default: 1

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under /Analyses/[--basecall-
                        group]/) containing basecalls and created within
                        [--corrected-group] containing re-squiggle results.
                        Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_detect_modifications_level_sample_compare

### Tool Description
Test for shifts in raw signal against signal level distributions from a control sample at each reference position.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
[help] tombo detect_modifications level_sample_compare: ok via tombo detect_modifications level_sample_compare --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: tombo detect_modifications level_sample_compare --fast5-basedirs
                                                       FAST5_BASEDIRS
                                                       [FAST5_BASEDIRS ...]
                                                       --statistics-file-basename
                                                       STATISTICS_FILE_BASENAME
                                                       --alternate-fast5-basedirs
                                                       ALTERNATE_FAST5_BASEDIRS
                                                       [ALTERNATE_FAST5_BASEDIRS ...]
                                                       [--fishers-method-context FISHERS_METHOD_CONTEXT]
                                                       [--minimum-test-reads MINIMUM_TEST_READS]
                                                       [--statistic-type {ks,u,t}]
                                                       [--store-p-value]
                                                       [--num-most-significant-stored NUM_MOST_SIGNIFICANT_STORED]
                                                       [--multiprocess-region-size MULTIPROCESS_REGION_SIZE]
                                                       [--processes PROCESSES]
                                                       [--corrected-group CORRECTED_GROUP]
                                                       [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                                       [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --statistics-file-basename STATISTICS_FILE_BASENAME
                        File base name to save base by base statistics from
                        testing. Filenames will be [--statistics-file-
                        basename].[--alternate-bases]?.tombo.stats
  --alternate-fast5-basedirs ALTERNATE_FAST5_BASEDIRS [ALTERNATE_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for
                        alternate set of reads.

Significance Test Arguments:
  --fishers-method-context FISHERS_METHOD_CONTEXT
                        Number of context bases up and downstream over which
                        to compute Fisher's method combined p-values. Note:
                        Not applicable for alternative model likelihood ratio
                        tests. Default: 1.
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required at a position to perform
                        significance testing or contribute to model
                        estimation. Default: 50
  --statistic-type {ks,u,t}
                        Type of statistical test to apply. Default: "ks"
  --store-p-value       Store p-value instead of effect-size statistic.
                        Statistics are D-statistic (KS-test), deviation from
                        even common language effect size (u-test), and Cohen's
                        D (t-test).

Output Argument:
  --num-most-significant-stored NUM_MOST_SIGNIFICANT_STORED
                        Number of the most significant sites to store for
                        faster access. If a longer list of most significant
                        sites is required the list must be re-computed from
                        all batches. Very large values can increase RAM usage.
                        Default: 100000

Multiprocessing Arguments:
  --multiprocess-region-size MULTIPROCESS_REGION_SIZE
                        Size of regions over which to multiprocesses statistic
                        computation. For very deep samples a smaller value is
                        recommmended in order to control memory consumption.
                        Default: 10000
  --processes PROCESSES
                        Number of processes. Default: 1

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under /Analyses/[--basecall-
                        group]/) containing basecalls and created within
                        [--corrected-group] containing re-squiggle results.
                        Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_detect_modifications_aggregate_per_read_stats

### Tool Description
Aggregate Tombo per-read statistics to produce a genomic base statistics file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
[help] tombo detect_modifications aggregate_per_read_stats: ok via tombo detect_modifications aggregate_per_read_stats --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: tombo detect_modifications aggregate_per_read_stats
                                                           --per-read-statistics-filename
                                                           PER_READ_STATISTICS_FILENAME
                                                           --statistics-filename
                                                           STATISTICS_FILENAME
                                                           --single-read-threshold
                                                           SINGLE_READ_THRESHOLD
                                                           [SINGLE_READ_THRESHOLD ...]
                                                           [--minimum-test-reads MINIMUM_TEST_READS]
                                                           [--coverage-dampen-counts COVERAGE_DAMPEN_COUNTS COVERAGE_DAMPEN_COUNTS]
                                                           [--num-most-significant-stored NUM_MOST_SIGNIFICANT_STORED]
                                                           [--processes PROCESSES]
                                                           [--corrected-group CORRECTED_GROUP]
                                                           [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                                           [--quiet] [--help]

Required Argument:
  --per-read-statistics-filename PER_READ_STATISTICS_FILENAME
                        Binary file containing per-read statistics from
                        statistical testing.
  --statistics-filename STATISTICS_FILENAME
                        File to save/load genomic base anchored statistics.
  --single-read-threshold SINGLE_READ_THRESHOLD [SINGLE_READ_THRESHOLD ...]
                        P-value or log likelihood ratio threshold when
                        computing fraction of significant reads at each
                        genomic position. If two values are provided,
                        statistics between these values are not considered.

Significance Test Arguments:
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required at a position to perform
                        significance testing or contribute to model
                        estimation. Default: 1
  --coverage-dampen-counts COVERAGE_DAMPEN_COUNTS COVERAGE_DAMPEN_COUNTS
                        Dampen fraction modified estimates for low coverage
                        sites. Two parameters are unmodified and modified
                        pseudo read counts. This is equivalent to a beta prior
                        on the fraction estimate. Set to "0 0" to disable
                        dampened fraction estimation. Default: [2, 0]

Output Argument:
  --num-most-significant-stored NUM_MOST_SIGNIFICANT_STORED
                        Number of the most significant sites to store for
                        faster access. If a longer list of most significant
                        sites is required the list must be re-computed from
                        all batches. Very large values can increase RAM usage.
                        Default: 100000

Multiprocessing Arguments:
  --processes PROCESSES
                        Number of processes. Default: 1

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under /Analyses/[--basecall-
                        group]/) containing basecalls and created within
                        [--corrected-group] containing re-squiggle results.
                        Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_text_output_browser_files

### Tool Description
Write text outputs for genome browser visualization (wiggle or bedGraph file format).

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
[help] tombo text_output browser_files: ok via tombo text_output browser_files --help (--help=ok, -h=ok, -help=ok, (no args)=no_options)
usage: tombo text_output browser_files
                                       [--fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]]
                                       [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                                       [--statistics-filename STATISTICS_FILENAME]
                                       [--genome-fasta GENOME_FASTA]
                                       [--motif-descriptions MOTIF_DESCRIPTIONS [MOTIF_DESCRIPTIONS ...]]
                                       [--browser-file-basename BROWSER_FILE_BASENAME]
                                       [--file-types {coverage,valid_coverage,fraction,dampened_fraction,signal,signal_sd,dwell,difference,statistic} [{coverage,valid_coverage,fraction,dampened_fraction,signal,signal_sd,dwell,difference,statistic} ...]]
                                       [--corrected-group CORRECTED_GROUP]
                                       [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                       [--quiet] [--help]

Data Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for control
                        reads, containing only canonical nucleotides.
  --statistics-filename STATISTICS_FILENAME
                        File to save/load genomic base anchored statistics.

Statistic Motif Filter Arguments:
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.
  --motif-descriptions MOTIF_DESCRIPTIONS [MOTIF_DESCRIPTIONS ...]
                        Ground truth, motif centered, modified base
                        descriptions for output filtering. Format descriptions
                        as: "motif:mod_pos:name". The mod_pos indicates the
                        modified base within the motif (1-based index).
                        Example: CCWGG:2:dcm_5mC GATC:2:dam_6mA would filter
                        output for identification of E. coli dam and dcm
                        methylation.

Output Arguments:
  --browser-file-basename BROWSER_FILE_BASENAME
                        Basename for output browser files. Two files (plus and
                        minus strand) will be produced for each --file-types
                        supplied. Filenames formatted as "[browser-file-
                        basename].[file-
                        type].[sample|control]?.[plus|minus].[wig|bedgraph]".
                        Default: tombo_results
  --file-types {coverage,valid_coverage,fraction,dampened_fraction,signal,signal_sd,dwell,difference,statistic} [{coverage,valid_coverage,fraction,dampened_fraction,signal,signal_sd,dwell,difference,statistic} ...]
                        Data types of genome browser files to produce.
                        Produced coverage files are in bedGraph format, while
                        all other file types will be in wiggle format
                        (https://genome.ucsc.edu/goldenpath/help/wiggle.html).
                        Default: "coverage"

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under /Analyses/[--basecall-
                        group]/) containing basecalls and created within
                        [--corrected-group] containing re-squiggle results.
                        Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_text_output_signif_sequence_context

### Tool Description
Write genomic/transcriptomic sequence centered on most modified genomic locations.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
[help] tombo text_output signif_sequence_context: ok via tombo text_output signif_sequence_context --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: tombo text_output signif_sequence_context --statistics-filename
                                                 STATISTICS_FILENAME
                                                 [--genome-fasta GENOME_FASTA]
                                                 [--fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]]
                                                 [--num-regions NUM_REGIONS]
                                                 [--num-bases NUM_BASES]
                                                 [--sequences-filename SEQUENCES_FILENAME]
                                                 [--corrected-group CORRECTED_GROUP]
                                                 [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                                 [--quiet] [--help]

Required Argument:
  --statistics-filename STATISTICS_FILENAME
                        File to save/load genomic base anchored statistics.

Sequence Arguments (Provide either FAST5s dir or genome FASTA):
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Region Selection Arguments:
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 100
  --num-bases NUM_BASES
                        Number of bases to plot/output. Default: 15

Output Arguments:
  --sequences-filename SEQUENCES_FILENAME
                        File for sequences from selected regions. Sequences
                        will be stored in FASTA format. Default:
                        tombo_results.significant_regions.fasta.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under /Analyses/[--basecall-
                        group]/) containing basecalls and created within
                        [--corrected-group] containing re-squiggle results.
                        Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_plot_max_coverage

### Tool Description
Plot raw signal in regions with maximal coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
[help] tombo plot max_coverage: ok via tombo plot max_coverage --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: tombo plot max_coverage --fast5-basedirs FAST5_BASEDIRS
                               [FAST5_BASEDIRS ...]
                               [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                               [--plot-standard-model]
                               [--plot-alternate-model {dam,6mA,dcm,CpG,5mC}]
                               [--overplot-threshold OVERPLOT_THRESHOLD]
                               [--overplot-type {Downsample,Boxplot,Quantile,Density}]
                               [--num-regions NUM_REGIONS]
                               [--num-bases NUM_BASES]
                               [--pdf-filename PDF_FILENAME]
                               [--corrected-group CORRECTED_GROUP]
                               [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                               [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Comparison Arguments:
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for control
                        reads, containing only canonical nucleotides.
  --plot-standard-model
                        Add default standard model distribution to the plot.
  --plot-alternate-model {dam,6mA,dcm,CpG,5mC}
                        Add alternative model distribution to the plot.

Overplotting Arguments:
  --overplot-threshold OVERPLOT_THRESHOLD
                        Coverage level to trigger alternative plot type
                        instead of raw signal. Default: 50
  --overplot-type {Downsample,Boxplot,Quantile,Density}
                        Plot type for regions with higher coverage. Default:
                        Downsample

Plotting Region Arguments:
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 10
  --num-bases NUM_BASES
                        Number of bases to plot/output. Default: 21

Output Argument:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.max_coverage.pdf

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under /Analyses/[--basecall-
                        group]/) containing basecalls and created within
                        [--corrected-group] containing re-squiggle results.
                        Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```
