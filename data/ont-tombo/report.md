# ont-tombo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ont-tombo_build_model_estimate_alt_reference | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, WT against KO control); 5mC alternative model written with the 3-mer model estimated from the same reads |
| ont-tombo_build_model_estimate_motif_alt_reference | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq); alternative model for motif AAA position 2 written (attributes checked) |
| ont-tombo_build_model_estimate_reference | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, WT and KO re-squiggled); 3-mer model file written and read back as a standard model (central_pos 1) |
| ont-tombo_build_model_estimate_scale | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq); global scale estimate 103.9 printed (tool writes it to standard error, captured; warns that few reads are present) |
| ont-tombo_build_model_event_resquiggle | Not completed | needs reads with a basecaller event table (Albacore); the real direct RNA reads here have only raw signal and FASTQ, and the tool reports success but writes no re-squiggle group |
| ont-tombo_detect_modifications_aggregate_per_read_stats | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; aggregated the per-read stats from alternative_model into a genomic stats file |
| ont-tombo_detect_modifications_alternative_model | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; 5mC model on the re-squiggled reads; stats and per-read stats written |
| ont-tombo_detect_modifications_de_novo | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; chained from resquiggle output; stats and per-read stats files written |
| ont-tombo_detect_modifications_level_sample_compare | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; WT against KO control; stats file written |
| ont-tombo_detect_modifications_model_sample_compare | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, WT against METTL3-KO); stats and per-read stats files written |
| ont-tombo_filter_clear_filters | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled reads); index written with 0 reads filtered |
| ont-tombo_filter_genome_locations | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled reads); keeping one transcript filtered 21 of 39 reads in the index |
| ont-tombo_filter_level_coverage | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled reads); 25 percent setting filtered 9 of 39 reads in the index |
| ont-tombo_filter_q_score | Failed | tool bug: reads the Fastq with ds[:], which raises on this scalar dataset (h5py 2.9), and a bare except then marks every read as failed; all 39 reads filtered at q-score 1 although their mean q-score is 8.6 to 10.9 |
| ont-tombo_filter_raw_signal_matching | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled reads); score 1.5 filtered 3 of 39 reads in the index |
| ont-tombo_filter_stuck | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled reads); 99th percentile 300 observations per base filtered 20 of 39 reads in the index |
| ont-tombo_plot_cluster_most_significant | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled WT reads and its transcriptome FASTA); PDF 1 page and R data file |
| ont-tombo_plot_genome_locations | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled WT reads and its transcriptome FASTA); PDF 1 page |
| ont-tombo_plot_kmer | Failed | image problem: rpy2 in the image rejects the read-id tuple in r.StrVector (TypeError in plot_kmer_dist), so no PDF is written |
| ont-tombo_plot_max_coverage | PASS | ran on real HEK293T direct RNA fast5 reads (nf-core nanoseq, 40 WT and 40 METTL3-KO) with its transcriptome FASTA; PDF written; --control-fast5-basedirs crashes in this image (NameError _R_DF, R plotting missing), the main mode works |
| ont-tombo_plot_max_difference | Failed | image problem: rpy2 in the image cannot build _R_DF (r.DataFrame fails at import), so every two-sample plot stops with NameError _R_DF |
| ont-tombo_plot_most_significant | Failed | tool bug: --sequences-filename writes no file in single-sample mode (also with the standard model); the PDF itself is correct, 2 pages |
| ont-tombo_plot_motif_centered | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled WT reads and its transcriptome FASTA); PDF 2 pages |
| ont-tombo_plot_motif_with_stats | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled WT reads and its transcriptome FASTA); PDF 1 page |
| ont-tombo_plot_per_read | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled WT reads and its transcriptome FASTA); PDF 1 page |
| ont-tombo_plot_per_read_roc | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled WT reads and its transcriptome FASTA); PDF 3 pages |
| ont-tombo_plot_roc | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled WT reads and its transcriptome FASTA); PDF 2 pages |
| ont-tombo_plot_sample_compare_per_read_roc | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled WT reads and its transcriptome FASTA); PDF 3 pages |
| ont-tombo_plot_sample_compare_roc | PASS | real HEK293T direct RNA fast5 reads (nf-core nanoseq, 39 re-squiggled WT reads and its transcriptome FASTA); PDF 2 pages |
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

## ont-tombo_filter_clear_filters

### Tool Description
Clear filters to process all successfully re-squiggled reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo filter clear_filters --fast5-basedirs FAST5_BASEDIRS
                                  [FAST5_BASEDIRS ...]
                                  [--corrected-group CORRECTED_GROUP]
                                  [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

FAST5 Data Argument:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_filter_genome_locations

### Tool Description
Filter reads based on mapping location.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo filter genome_locations --fast5-basedirs FAST5_BASEDIRS
                                     [FAST5_BASEDIRS ...]
                                     [--include-regions INCLUDE_REGIONS [INCLUDE_REGIONS ...]]
                                     [--include-partial-overlap]
                                     [--corrected-group CORRECTED_GROUP]
                                     [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --include-regions INCLUDE_REGIONS [INCLUDE_REGIONS ...]
                        Filter out reads not falling completely within include
                        regions. Omit start and end coordinates to include an
                        entire chromosome/sequence record. Format regions as
                        "chrm[:start-end] [chrm2[:start2-end2] ...]".

Filter Argument:
  --include-partial-overlap
                        Include reads that partially overlap the specified
                        region. Default: Only include reads completely
                        contained in a specified region

FAST5 Data Argument:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_filter_raw_signal_matching

### Tool Description
Filter reads with poor raw to expected signal matching.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo filter raw_signal_matching --fast5-basedirs FAST5_BASEDIRS
                                        [FAST5_BASEDIRS ...]
                                        --signal-matching-score
                                        SIGNAL_MATCHING_SCORE
                                        [--corrected-group CORRECTED_GROUP]
                                        [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --signal-matching-score SIGNAL_MATCHING_SCORE
                        Observed to expected signal matching score (higher
                        score indicates poor matching). Sample type defaults:
                        RNA : 2 || DNA : 1.1

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_filter_level_coverage

### Tool Description
Filter reads for more even coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo filter level_coverage --fast5-basedirs FAST5_BASEDIRS
                                   [FAST5_BASEDIRS ...]
                                   [--percent-to-filter PERCENT_TO_FILTER]
                                   [--corrected-group CORRECTED_GROUP]
                                   [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Read Filtering Argument:
  --percent-to-filter PERCENT_TO_FILTER
                        Percentage of all reads to filter. Reads are randomly
                        selected weighted according to the approximate
                        coverage at the mapped genomic location. This can be
                        useful in modeling and testing. Default: 10.000000

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_filter_stuck

### Tool Description
Filter reads with more "stuck" bases.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo filter stuck --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                          [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                          [--corrected-group CORRECTED_GROUP] [--quiet]
                          [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Read Filtering Argument:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads based on observations per base percentile
                        thresholds. Format thresholds as "percentile:thresh
                        [pctl2:thresh2 ...]". For example to filter reads with
                        99th pctl > 200 obs/base or max > 5k obs/base use
                        "99:200 100:5000".

FAST5 Data Argument:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_filter_q_score

### Tool Description
Filter reads with poor mean basecalling quality.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo filter q_score --fast5-basedirs FAST5_BASEDIRS
                            [FAST5_BASEDIRS ...] [--q-score Q_SCORE]
                            [--corrected-group CORRECTED_GROUP]
                            [--basecall-group BASECALL_GROUP] [--quiet]
                            [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Read Filtering Argument:
  --q-score Q_SCORE     Q-score threshold for filtering low quality reads.
                        Default: 7.000000

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-group BASECALL_GROUP
                        FAST5 group obtain original basecalls (under Analyses
                        group). Default: Basecall_1D_000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_detect_modifications_model_sample_compare

### Tool Description
Test for shifts in raw signal against levels estimated from a canonical/control sample (PCR/IVT) at each reference position.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo detect_modifications model_sample_compare --fast5-basedirs
                                                       FAST5_BASEDIRS
                                                       [FAST5_BASEDIRS ...]
                                                       --statistics-file-basename
                                                       STATISTICS_FILE_BASENAME
                                                       --control-fast5-basedirs
                                                       CONTROL_FAST5_BASEDIRS
                                                       [CONTROL_FAST5_BASEDIRS ...]
                                                       [--sample-only-estimates]
                                                       [--model-prior-weights MODEL_PRIOR_WEIGHTS MODEL_PRIOR_WEIGHTS]
                                                       [--dna] [--rna]
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
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for control
                        reads, containing only canonical nucleotides.

Model Prior Arguments:
  --sample-only-estimates
                        Only use canonical sample to estimate expected signal
                        level and spread. Default: Use canonical model to
                        improve estimtates (esp. for low coverage regions)
                        using baysian posterior estimates.
  --model-prior-weights MODEL_PRIOR_WEIGHTS MODEL_PRIOR_WEIGHTS
                        Prior weights (one each for mean and spread) applied
                        to canonical base model for estimating posterior model
                        parameters for sample comparison. Default: [5, 40]
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

## ont-tombo_build_model_estimate_reference

### Tool Description
Estimate reference tombo model derived from the provided reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo build_model estimate_reference --fast5-basedirs FAST5_BASEDIRS
                                            [FAST5_BASEDIRS ...]
                                            --tombo-model-filename
                                            TOMBO_MODEL_FILENAME
                                            [--estimate-mean]
                                            [--kmer-specific-sd]
                                            [--upstream-bases {0,1,2,3,4}]
                                            [--downstream-bases {0,1,2,3,4}]
                                            [--minimum-test-reads MINIMUM_TEST_READS]
                                            [--coverage-threshold COVERAGE_THRESHOLD]
                                            [--minimum-kmer-observations MINIMUM_KMER_OBSERVATIONS]
                                            [--multiprocess-region-size MULTIPROCESS_REGION_SIZE]
                                            [--processes PROCESSES]
                                            [--corrected-group CORRECTED_GROUP]
                                            [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                            [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Filename to save Tombo model.

Modeling Arguments:
  --estimate-mean       Use the mean instead of median for model level
                        estimation. Note: This can cause poor fits due to
                        outliers
  --kmer-specific-sd    Estimate standard deviation for each k-mers
                        individually.
  --upstream-bases {0,1,2,3,4}
                        Upstream bases in k-mer. Default: 1
  --downstream-bases {0,1,2,3,4}
                        Downstream bases in k-mer. Default: 2

Filtering Arguments:
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required at a position to perform
                        significance testing or contribute to model
                        estimation. Default: 10
  --coverage-threshold COVERAGE_THRESHOLD
                        Maximum mean coverage per region when estimating k-mer
                        model (limits compute time for deep samples). Default:
                        100
  --minimum-kmer-observations MINIMUM_KMER_OBSERVATIONS
                        Number of each k-mer observations required in order to
                        produce a reference (genomic locations for standard
                        reference and per-read for alternative reference).
                        Default: 5

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

## ont-tombo_build_model_estimate_alt_reference

### Tool Description
Estimate alternative tombo model from a sample containing canonical bases spiked with a single non-standard base.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo build_model estimate_alt_reference --alternate-model-filename
                                                ALTERNATE_MODEL_FILENAME
                                                --alternate-model-name
                                                ALTERNATE_MODEL_NAME
                                                --alternate-model-base
                                                {A,C,G,T}
                                                [--fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]]
                                                [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                                                [--alternate-density-filename ALTERNATE_DENSITY_FILENAME]
                                                [--control-density-filename CONTROL_DENSITY_FILENAME]
                                                [--dna] [--rna]
                                                [--tombo-model-filename TOMBO_MODEL_FILENAME]
                                                [--alt-fraction-percentile ALT_FRACTION_PERCENTILE]
                                                [--kernel-density-bandwidth KERNEL_DENSITY_BANDWIDTH]
                                                [--minimum-kmer-observations MINIMUM_KMER_OBSERVATIONS]
                                                [--save-density-basename SAVE_DENSITY_BASENAME]
                                                [--processes PROCESSES]
                                                [--corrected-group CORRECTED_GROUP]
                                                [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                                [--quiet] [--help]

Required Arguments:
  --alternate-model-filename ALTERNATE_MODEL_FILENAME
                        Tombo model for alternative likelihood ratio
                        significance testing.
  --alternate-model-name ALTERNATE_MODEL_NAME
                        A short name to associate with this alternate model
                        (e.g. 5mC, 6mA, etc.). This text will be included in
                        output filenames when this model is used for testing.
  --alternate-model-base {A,C,G,T}
                        Non-standard base is an alternative to this base.

Signal Data Arguments (Must provide either FAST5 dirs or previous density estimates):
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for control
                        reads, containing only canonical nucleotides.
  --alternate-density-filename ALTERNATE_DENSITY_FILENAME
                        File containing k-mer level kernel density estimates
                        for the alternative sample saved using --save-density-
                        basename.
  --control-density-filename CONTROL_DENSITY_FILENAME
                        File containing k-mer level kernel density estimates
                        for the control sample saved using --save-density-
                        basename.

Standard Model Arguments:
  --dna                 Explicitly select canonical DNA model. Default:
                        Automatically determine from FAST5s
  --rna                 Explicitly select canonical RNA model. Default:
                        Automatically determine from FAST5s
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model filename. If no file is provided, the
                        default DNA or RNA Tombo model will be used.

Model Fitting Arguments:
  --alt-fraction-percentile ALT_FRACTION_PERCENTILE
                        When esitmating the alternative base incorporation
                        rate, this percent of k-mers are assumed to have
                        significantly shifted signal so the alternative
                        distribution minimally overlaps the standard base
                        distribution. Default: 5.000000
  --kernel-density-bandwidth KERNEL_DENSITY_BANDWIDTH
                        Bandwidth applied when performing Gaussian kernal
                        density esitmation on standard and alternative base
                        signal distributions. Default: 0.050000

Filtering Argument:
  --minimum-kmer-observations MINIMUM_KMER_OBSERVATIONS
                        Number of each k-mer observations required in order to
                        produce a reference (genomic locations for standard
                        reference and per-read for alternative reference).
                        Default: 1000

Output Argument:
  --save-density-basename SAVE_DENSITY_BASENAME
                        Basename to save alternative model estimation density
                        estimation information. See scripts/debug_est_alt.R
                        for info use example. Default: Don't save.

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

## ont-tombo_build_model_estimate_motif_alt_reference

### Tool Description
Estimate alternative tombo model from a sample containing modified bases within a known sequence motif.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo build_model estimate_motif_alt_reference
                                                      --alternate-model-filename
                                                      ALTERNATE_MODEL_FILENAME
                                                      --alternate-model-name
                                                      ALTERNATE_MODEL_NAME
                                                      --motif-description
                                                      MOTIF_DESCRIPTION
                                                      --fast5-basedirs
                                                      FAST5_BASEDIRS
                                                      [FAST5_BASEDIRS ...]
                                                      [--upstream-bases {0,1,2,3,4}]
                                                      [--downstream-bases {0,1,2,3,4}]
                                                      [--minimum-kmer-observations MINIMUM_KMER_OBSERVATIONS]
                                                      [--valid-locations-filename VALID_LOCATIONS_FILENAME]
                                                      [--minimum-test-reads MINIMUM_TEST_READS]
                                                      [--coverage-threshold COVERAGE_THRESHOLD]
                                                      [--multiprocess-region-size MULTIPROCESS_REGION_SIZE]
                                                      [--processes PROCESSES]
                                                      [--corrected-group CORRECTED_GROUP]
                                                      [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                                      [--quiet] [--help]

Required Arguments:
  --alternate-model-filename ALTERNATE_MODEL_FILENAME
                        Tombo model for alternative likelihood ratio
                        significance testing.
  --alternate-model-name ALTERNATE_MODEL_NAME
                        A short name to associate with this alternate model
                        (e.g. 5mC, 6mA, etc.). This text will be included in
                        output filenames when this model is used for testing.
  --motif-description MOTIF_DESCRIPTION
                        Motif containing alternate-base. All positions with
                        this motif should be modified (or filtered with
                        [--valid-locations-filename]). Format descriptions as:
                        "motif:mod_pos". mod_pos indicates the alternate-base
                        within the motif (1-based index). Example: "CG:1" to
                        train a CpG methylation model.
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Modeling Arguments (Should match canoncial model):
  --upstream-bases {0,1,2,3,4}
                        Upstream bases in k-mer. Default: 1
  --downstream-bases {0,1,2,3,4}
                        Downstream bases in k-mer. Default: 2

Filtering Argument:
  --minimum-kmer-observations MINIMUM_KMER_OBSERVATIONS
                        Number of each k-mer observations required in order to
                        produce a reference (genomic locations for standard
                        reference and per-read for alternative reference).
                        Default: 1
  --valid-locations-filename VALID_LOCATIONS_FILENAME
                        Bed format file containing single base locations of
                        valid sites. Should contain 6 fields including strand.
                        E.g. modified base locations.
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required at a position to perform
                        significance testing or contribute to model
                        estimation. Default: 10
  --coverage-threshold COVERAGE_THRESHOLD
                        Maximum mean coverage per region when estimating k-mer
                        model (limits compute time for deep samples). Default:
                        100

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

## ont-tombo_build_model_estimate_scale

### Tool Description
Estimate a global scaling parameter from a sub-set of reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo build_model estimate_scale [--quiet] [--help] fast5s_basedir

Required Arguments:
  fast5s_basedir  Directory containing fast5 files. All files ending in
                  "fast5" found recursively within this base directory will be
                  processed.

Miscellaneous Arguments:
  --quiet, -q     Don't print status information.
  --help, -h      Print this help message and exit
```

## ont-tombo_build_model_event_resquiggle

### Tool Description
Re-annotate raw signal with genomic alignment from existing basecalls using event table.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo build_model event_resquiggle
                                          [--minimap2-executable MINIMAP2_EXECUTABLE]
                                          [--minimap2-index MINIMAP2_INDEX]
                                          [--bwa-mem-executable BWA_MEM_EXECUTABLE]
                                          [--graphmap-executable GRAPHMAP_EXECUTABLE]
                                          [--alignment-batch-size ALIGNMENT_BATCH_SIZE]
                                          [--normalization-type {median,pA,pA_raw,none}]
                                          [--pore-model-filename PORE_MODEL_FILENAME]
                                          [--outlier-threshold OUTLIER_THRESHOLD]
                                          [--segmentation-parameters SEGMENTATION_PARAMETERS SEGMENTATION_PARAMETERS]
                                          [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                                          [--timeout TIMEOUT]
                                          [--cpts-limit CPTS_LIMIT]
                                          [--skip-index] [--overwrite]
                                          [--failed-reads-filename FAILED_READS_FILENAME]
                                          [--include-event-stdev]
                                          [--corrected-group CORRECTED_GROUP]
                                          [--basecall-group BASECALL_GROUP]
                                          [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                          [--processes PROCESSES]
                                          [--align-processes ALIGN_PROCESSES]
                                          [--align-threads-per-process ALIGN_THREADS_PER_PROCESS]
                                          [--resquiggle-processes RESQUIGGLE_PROCESSES]
                                          [--quiet] [--help]
                                          fast5s_basedir reference_fasta

Required Arguments:
  fast5s_basedir        Directory containing fast5 files. All files ending in
                        "fast5" found recursively within this base directory
                        will be processed.
  reference_fasta       Reference genome/transcriptome FASTA file for mapping.

Mapper Arguments (One mapper is required):
  --minimap2-executable MINIMAP2_EXECUTABLE
                        Path to minimap2 executable.
  --minimap2-index MINIMAP2_INDEX
                        Path to minimap2 index (with map-ont preset) file
                        corresponding to the [genome_fasta] provided.
  --bwa-mem-executable BWA_MEM_EXECUTABLE
                        Path to bwa-mem executable.
  --graphmap-executable GRAPHMAP_EXECUTABLE
                        Path to graphmap executable.
  --alignment-batch-size ALIGNMENT_BATCH_SIZE
                        Number of reads included in each alignment call. Note:
                        A new system mapping call is made for each batch
                        (including loading of the genome), so it is advised to
                        use larger values for larger genomes. Default: 1000

Signal Processing Arguments:
  --normalization-type {median,pA,pA_raw,none}
                        Choices: "none": raw 16-bit DAQ values, "pA_raw": pA
                        as in the ONT events (using offset, range and
                        digitization), "pA": k-mer-based correction for pA
                        drift as in nanopolish (requires [--pore-model-
                        filename]), "median": median and MAD from raw signal.
                        Default: median
  --pore-model-filename PORE_MODEL_FILENAME
                        File containing kmer model parameters (level_mean and
                        level_stdv) used in order to compute kmer-based
                        corrected pA values. E.g. https://github.com/jts/nanop
                        olish/blob/master/etc/r9-models/template_median68pA.5m
                        ers.model
  --outlier-threshold OUTLIER_THRESHOLD
                        Windosrize the signal at this number of scale values.
                        Negative value disables outlier clipping. Default:
                        5.000000
  --segmentation-parameters SEGMENTATION_PARAMETERS SEGMENTATION_PARAMETERS
                        Specify the 2 parameters for segmentation 1) running
                        neighboring windows width 2) minimum raw observations
                        per genomic base. Sample type defaults: RNA : 12 6 ||
                        DNA : 5 3

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads based on observations per base percentile
                        thresholds. Format thresholds as "percentile:thresh
                        [pctl2:thresh2 ...]". For example to filter reads with
                        99th pctl > 200 obs/base or max > 5k obs/base use
                        "99:200 100:5000".
  --timeout TIMEOUT     Timeout in seconds for processing a single read.
                        Default: No timeout.
  --cpts-limit CPTS_LIMIT
                        Maximum number of changepoints to find within a single
                        indel group. Default: No limit.

Input/Output Arguments:
  --skip-index          Skip creation of tombo index. This drastically slows
                        downstream tombo commands. Default stores tombo index
                        named ".[--fast5-basedir].[--corrected-
                        group].tombo.index" to be loaded automatically for
                        downstream commands.
  --overwrite           Overwrite previous corrected group in FAST5 files.
                        Note: only effects --corrected-group or --new-
                        corrected-group.
  --failed-reads-filename FAILED_READS_FILENAME
                        Output failed read filenames with assoicated error.
                        Default: Do not store failed reads.
  --include-event-stdev
                        Include corrected event standard deviation in output
                        FAST5 data.

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

Multiprocessing Arguments:
  --processes PROCESSES
                        Number of processes. Default: 2
  --align-processes ALIGN_PROCESSES
                        Number of processes to use for parsing and aligning
                        original basecalls. Each process will independently
                        load the genome into memory, so use caution with
                        larger genomes (e.g. human). Default: 1
  --align-threads-per-process ALIGN_THREADS_PER_PROCESS
                        Number of threads to use for aligner system call.
                        Default: [--processes] / (2 * [--align-processes)]
  --resquiggle-processes RESQUIGGLE_PROCESSES
                        Number of processes to use for resquiggle algorithm.
                        Default: [--processes] / 2

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_plot_genome_locations

### Tool Description
Plot raw signal at defined genomic locations.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot genome_locations --fast5-basedirs FAST5_BASEDIRS
                                   [FAST5_BASEDIRS ...] --genome-locations
                                   GENOME_LOCATIONS [GENOME_LOCATIONS ...]
                                   [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                                   [--plot-standard-model]
                                   [--plot-alternate-model {dam,6mA,CpG,dcm,5mC}]
                                   [--overplot-threshold OVERPLOT_THRESHOLD]
                                   [--overplot-type {Downsample,Boxplot,Quantile,Density}]
                                   [--num-bases NUM_BASES]
                                   [--pdf-filename PDF_FILENAME]
                                   [--corrected-group CORRECTED_GROUP]
                                   [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                   [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --genome-locations GENOME_LOCATIONS [GENOME_LOCATIONS ...]
                        Genomic locations at which to plot signal. Format
                        locations as "chrm:position[:strand]
                        [chrm2:position2[:strand2] ...]" (strand not
                        applicable for all applications)

Comparison Arguments:
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for control
                        reads, containing only canonical nucleotides.
  --plot-standard-model
                        Add default standard model distribution to the plot.
  --plot-alternate-model {dam,6mA,CpG,dcm,5mC}
                        Add alternative model distribution to the plot.

Overplotting Arguments:
  --overplot-threshold OVERPLOT_THRESHOLD
                        Coverage level to trigger alternative plot type
                        instead of raw signal. Default: 50
  --overplot-type {Downsample,Boxplot,Quantile,Density}
                        Plot type for regions with higher coverage. Default:
                        Downsample

Plotting Region Argument:
  --num-bases NUM_BASES
                        Number of bases to plot/output. Default: 21

Output Argument:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.genome_locations.pdf

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

## ont-tombo_plot_motif_centered

### Tool Description
Plot raw signal at a specific motif.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot motif_centered --fast5-basedirs FAST5_BASEDIRS
                                 [FAST5_BASEDIRS ...] --motif MOTIF
                                 --genome-fasta GENOME_FASTA
                                 [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                                 [--plot-standard-model]
                                 [--plot-alternate-model {5mC,6mA,dcm,CpG,dam}]
                                 [--overplot-threshold OVERPLOT_THRESHOLD]
                                 [--overplot-type {Downsample,Boxplot,Quantile,Density}]
                                 [--num-regions NUM_REGIONS]
                                 [--num-bases NUM_BASES] [--deepest-coverage]
                                 [--pdf-filename PDF_FILENAME]
                                 [--corrected-group CORRECTED_GROUP]
                                 [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                 [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --motif MOTIF         Motif of interest at which to plot signal and
                        statsitics. Supports IUPAC single letter codes (use T
                        for RNA).
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.

Comparison Arguments:
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for control
                        reads, containing only canonical nucleotides.
  --plot-standard-model
                        Add default standard model distribution to the plot.
  --plot-alternate-model {5mC,6mA,dcm,CpG,dam}
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
  --deepest-coverage    Plot the deepest coverage regions.

Output Argument:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.motif_centered.pdf

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

## ont-tombo_plot_motif_with_stats

### Tool Description
Plot example signal and statistic distributions around a motif of interst.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot motif_with_stats --fast5-basedirs FAST5_BASEDIRS
                                   [FAST5_BASEDIRS ...] --motif MOTIF
                                   --statistics-filename STATISTICS_FILENAME
                                   --genome-fasta GENOME_FASTA
                                   [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                                   [--plot-standard-model]
                                   [--plot-alternate-model {5mC,6mA,CpG,dam,dcm}]
                                   [--overplot-threshold OVERPLOT_THRESHOLD]
                                   [--num-regions NUM_REGIONS]
                                   [--num-context NUM_CONTEXT]
                                   [--num-statistics NUM_STATISTICS]
                                   [--coverage-dampen-counts COVERAGE_DAMPEN_COUNTS COVERAGE_DAMPEN_COUNTS]
                                   [--pdf-filename PDF_FILENAME]
                                   [--corrected-group CORRECTED_GROUP]
                                   [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                   [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --motif MOTIF         Motif of interest at which to plot signal and
                        statsitics. Supports IUPAC single letter codes (use T
                        for RNA).
  --statistics-filename STATISTICS_FILENAME
                        File to save/load genomic base anchored statistics.
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.

Comparison Arguments:
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for control
                        reads, containing only canonical nucleotides.
  --plot-standard-model
                        Add default standard model distribution to the plot.
  --plot-alternate-model {5mC,6mA,CpG,dam,dcm}
                        Add alternative model distribution to the plot.

Overplotting Argument:
  --overplot-threshold OVERPLOT_THRESHOLD
                        Coverage level to trigger alternative plot type
                        instead of raw signal. Default: 50

Plotting Region Arguments:
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 3
  --num-context NUM_CONTEXT
                        Number of context bases around motif. Default: 5
  --num-statistics NUM_STATISTICS
                        Number of motif centered regions to include in
                        statistic distributions. Default: 200

Statistical Argument:
  --coverage-dampen-counts COVERAGE_DAMPEN_COUNTS COVERAGE_DAMPEN_COUNTS
                        Dampen fraction modified estimates for low coverage
                        sites. Two parameters are unmodified and modified
                        pseudo read counts. This is equivalent to a beta prior
                        on the fraction estimate. Set to "0 0" to disable
                        dampened fraction estimation. Default: [2, 0]

Output Argument:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.motif_statistics.pdf

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

## ont-tombo_plot_per_read

### Tool Description
Plot per-read modified base probabilities.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot per_read --genome-locations GENOME_LOCATIONS
                           [GENOME_LOCATIONS ...]
                           --per-read-statistics-filename
                           PER_READ_STATISTICS_FILENAME
                           [--genome-fasta GENOME_FASTA]
                           [--fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]]
                           [--num-reads NUM_READS] [--num-bases NUM_BASES]
                           [--box-center] [--pdf-filename PDF_FILENAME]
                           [--corrected-group CORRECTED_GROUP]
                           [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                           [--quiet] [--help]

Required Arguments:
  --genome-locations GENOME_LOCATIONS [GENOME_LOCATIONS ...]
                        Genomic locations at which to plot signal. Format
                        locations as "chrm:position[:strand]
                        [chrm2:position2[:strand2] ...]" (strand not
                        applicable for all applications)
  --per-read-statistics-filename PER_READ_STATISTICS_FILENAME
                        Binary file containing per-read statistics from
                        statistical testing.

Sequence Arguments (Provide either FAST5s dir or genome FASTA):
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Plotting Region Arguments:
  --num-reads NUM_READS
                        Number of reads to plot. Default: 100
  --num-bases NUM_BASES
                        Number of bases to plot/output. Default: 51
  --box-center          Plot a box around the central base.

Output Argument:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.per_read_stats.pdf

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

## ont-tombo_plot_roc

### Tool Description
Plot ROC curve from known motif(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot roc --statistics-filenames STATISTICS_FILENAMES
                      [STATISTICS_FILENAMES ...]
                      [--modified-locations MODIFIED_LOCATIONS [MODIFIED_LOCATIONS ...]]
                      [--unmodified-locations UNMODIFIED_LOCATIONS [UNMODIFIED_LOCATIONS ...]]
                      [--motif-descriptions MOTIF_DESCRIPTIONS [MOTIF_DESCRIPTIONS ...]]
                      [--genome-fasta GENOME_FASTA]
                      [--pdf-filename PDF_FILENAME]
                      [--statistics-per-block STATISTICS_PER_BLOCK]
                      [--total-statistics-limit TOTAL_STATISTICS_LIMIT]
                      [--quiet] [--help]

Required Argument:
  --statistics-filenames STATISTICS_FILENAMES [STATISTICS_FILENAMES ...]
                        Files to load genomic base anchored statistics.

Ground Truth Arguments (provide bed files or motifs):
  --modified-locations MODIFIED_LOCATIONS [MODIFIED_LOCATIONS ...]
                        Modification description and bed format files
                        containing single base locations of ground truth
                        modified sites. Bed files should contain 6 fields
                        including strand. Format descriptions as
                        "mod_name:locs.bed". Example: "CpG
                        bisulfite":bisulfite_locs.bed
  --unmodified-locations UNMODIFIED_LOCATIONS [UNMODIFIED_LOCATIONS ...]
                        Bed format files containing single base locations of
                        ground truth unmodified sites. Bed files should
                        contain 6 fields including strand.
  --motif-descriptions MOTIF_DESCRIPTIONS [MOTIF_DESCRIPTIONS ...]
                        Ground truth, motif centered, modified base
                        descriptions for computing ROC and PR curves. Each
                        statistics file is associated with a set of motif
                        descriptions. Format descriptions as:
                        "motif:mod_pos:name[::motif2:mod_pos2:name2...]".
                        mod_pos indicates the alternate-base within the motif
                        (1-based index). Example: CCWGG:2:"dcm
                        5mC"::GATC:2:"dam 6mA" would assess the performance of
                        a single Tombo statistics file for identification of
                        E. coli dam and dcm methylation.
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.

Output Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.roc.pdf

Down-sampling Arguments:
  --statistics-per-block STATISTICS_PER_BLOCK
                        Number of randomly selected per-read, per-base
                        statistics to extract from each genomic block for
                        plotting. Default: Include all stats
  --total-statistics-limit TOTAL_STATISTICS_LIMIT
                        Total per-read statistics to be extracted for
                        plotting. Avoids memory overflow for large runs.
                        Default: 5000000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_plot_sample_compare_roc

### Tool Description
Plot ROC curve comparing two samples at known motif(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot sample_compare_roc --statistics-filenames
                                     STATISTICS_FILENAMES
                                     [STATISTICS_FILENAMES ...]
                                     --control-statistics-filenames
                                     CONTROL_STATISTICS_FILENAMES
                                     [CONTROL_STATISTICS_FILENAMES ...]
                                     --motif-descriptions MOTIF_DESCRIPTIONS
                                     [MOTIF_DESCRIPTIONS ...] --genome-fasta
                                     GENOME_FASTA
                                     [--pdf-filename PDF_FILENAME]
                                     [--statistics-per-block STATISTICS_PER_BLOCK]
                                     [--total-statistics-limit TOTAL_STATISTICS_LIMIT]
                                     [--quiet] [--help]

Required Arguments:
  --statistics-filenames STATISTICS_FILENAMES [STATISTICS_FILENAMES ...]
                        Files to load genomic base anchored statistics.
  --control-statistics-filenames CONTROL_STATISTICS_FILENAMES [CONTROL_STATISTICS_FILENAMES ...]
                        Files to load genomic base anchored statistics from a
                        control sample.
  --motif-descriptions MOTIF_DESCRIPTIONS [MOTIF_DESCRIPTIONS ...]
                        Ground truth, motif centered, modified base
                        descriptions for computing ROC and PR curves. Each
                        statistics file is associated with a set of motif
                        descriptions. Format descriptions as:
                        "motif:mod_pos:name[::motif2:mod_pos2:name2...]".
                        mod_pos indicates the alternate-base within the motif
                        (1-based index). Example: CCWGG:2:"dcm
                        5mC"::GATC:2:"dam 6mA" would assess the performance of
                        a single Tombo statistics file for identification of
                        E. coli dam and dcm methylation.
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.

Output Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.sample_compare.roc.pdf

Down-sampling Arguments:
  --statistics-per-block STATISTICS_PER_BLOCK
                        Number of randomly selected per-read, per-base
                        statistics to extract from each genomic block for
                        plotting. Default: Include all stats
  --total-statistics-limit TOTAL_STATISTICS_LIMIT
                        Total per-read statistics to be extracted for
                        plotting. Avoids memory overflow for large runs.
                        Default: 5000000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_plot_per_read_roc

### Tool Description
Plot per-read ROC curve from known motif(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot per_read_roc --per-read-statistics-filenames
                               PER_READ_STATISTICS_FILENAMES
                               [PER_READ_STATISTICS_FILENAMES ...]
                               [--modified-locations MODIFIED_LOCATIONS [MODIFIED_LOCATIONS ...]]
                               [--unmodified-locations UNMODIFIED_LOCATIONS [UNMODIFIED_LOCATIONS ...]]
                               [--motif-descriptions MOTIF_DESCRIPTIONS [MOTIF_DESCRIPTIONS ...]]
                               [--genome-fasta GENOME_FASTA]
                               [--statistics-per-block STATISTICS_PER_BLOCK]
                               [--total-statistics-limit TOTAL_STATISTICS_LIMIT]
                               [--pdf-filename PDF_FILENAME] [--quiet]
                               [--help]

Required Argument:
  --per-read-statistics-filenames PER_READ_STATISTICS_FILENAMES [PER_READ_STATISTICS_FILENAMES ...]
                        Binary files containing per-read statistics from
                        statistical testing.

Ground Truth Arguments (provide bed files or motifs):
  --modified-locations MODIFIED_LOCATIONS [MODIFIED_LOCATIONS ...]
                        Modification description and bed format files
                        containing single base locations of ground truth
                        modified sites. Bed files should contain 6 fields
                        including strand. Format descriptions as
                        "mod_name:locs.bed". Example: "CpG
                        bisulfite":bisulfite_locs.bed
  --unmodified-locations UNMODIFIED_LOCATIONS [UNMODIFIED_LOCATIONS ...]
                        Bed format files containing single base locations of
                        ground truth unmodified sites. Bed files should
                        contain 6 fields including strand.
  --motif-descriptions MOTIF_DESCRIPTIONS [MOTIF_DESCRIPTIONS ...]
                        Ground truth, motif centered, modified base
                        descriptions for computing ROC and PR curves. Each
                        statistics file is associated with a set of motif
                        descriptions. Format descriptions as:
                        "motif:mod_pos:name[::motif2:mod_pos2:name2...]".
                        mod_pos indicates the alternate-base within the motif
                        (1-based index). Example: CCWGG:2:"dcm
                        5mC"::GATC:2:"dam 6mA" would assess the performance of
                        a single Tombo statistics file for identification of
                        E. coli dam and dcm methylation.
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.

Down-sampling Arguments:
  --statistics-per-block STATISTICS_PER_BLOCK
                        Number of randomly selected per-read, per-base
                        statistics to extract from each genomic block for
                        plotting. Default: 100000
  --total-statistics-limit TOTAL_STATISTICS_LIMIT
                        Total per-read statistics to be extracted for
                        plotting. Avoids memory overflow for large runs.
                        Default: 5000000

Output Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.per_reads_roc.pdf

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_plot_sample_compare_per_read_roc

### Tool Description
Plot per-read ROC curve comparing two samples at known motif(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot sample_compare_per_read_roc --per-read-statistics-filenames
                                              PER_READ_STATISTICS_FILENAMES
                                              [PER_READ_STATISTICS_FILENAMES ...]
                                              --per-read-control-statistics-filenames
                                              PER_READ_CONTROL_STATISTICS_FILENAMES
                                              [PER_READ_CONTROL_STATISTICS_FILENAMES ...]
                                              --motif-descriptions
                                              MOTIF_DESCRIPTIONS
                                              [MOTIF_DESCRIPTIONS ...]
                                              --genome-fasta GENOME_FASTA
                                              [--pdf-filename PDF_FILENAME]
                                              [--statistics-per-block STATISTICS_PER_BLOCK]
                                              [--total-statistics-limit TOTAL_STATISTICS_LIMIT]
                                              [--quiet] [--help]

Required Arguments:
  --per-read-statistics-filenames PER_READ_STATISTICS_FILENAMES [PER_READ_STATISTICS_FILENAMES ...]
                        Binary files containing per-read statistics from
                        statistical testing.
  --per-read-control-statistics-filenames PER_READ_CONTROL_STATISTICS_FILENAMES [PER_READ_CONTROL_STATISTICS_FILENAMES ...]
                        Binary files containing per-read control statistics
                        from statistical testing.
  --motif-descriptions MOTIF_DESCRIPTIONS [MOTIF_DESCRIPTIONS ...]
                        Ground truth, motif centered, modified base
                        descriptions for computing ROC and PR curves. Each
                        statistics file is associated with a set of motif
                        descriptions. Format descriptions as:
                        "motif:mod_pos:name[::motif2:mod_pos2:name2...]".
                        mod_pos indicates the alternate-base within the motif
                        (1-based index). Example: CCWGG:2:"dcm
                        5mC"::GATC:2:"dam 6mA" would assess the performance of
                        a single Tombo statistics file for identification of
                        E. coli dam and dcm methylation.
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.

Output Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.sample_compare.roc.pdf

Down-sampling Arguments:
  --statistics-per-block STATISTICS_PER_BLOCK
                        Number of randomly selected per-read, per-base
                        statistics to extract from each genomic block for
                        plotting. Default: Include all stats
  --total-statistics-limit TOTAL_STATISTICS_LIMIT
                        Total per-read statistics to be extracted for
                        plotting. Avoids memory overflow for large runs.
                        Default: 5000000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```

## ont-tombo_plot_cluster_most_significant

### Tool Description
Clustering traces at bases with most significant stats.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot cluster_most_significant --fast5-basedirs FAST5_BASEDIRS
                                           [FAST5_BASEDIRS ...]
                                           --control-fast5-basedirs
                                           CONTROL_FAST5_BASEDIRS
                                           [CONTROL_FAST5_BASEDIRS ...]
                                           --statistics-filename
                                           STATISTICS_FILENAME
                                           [--genome-fasta GENOME_FASTA]
                                           [--processes PROCESSES]
                                           [--num-regions NUM_REGIONS]
                                           [--num-bases NUM_BASES]
                                           [--slide-span SLIDE_SPAN]
                                           [--pdf-filename PDF_FILENAME]
                                           [--r-data-filename R_DATA_FILENAME]
                                           [--corrected-group CORRECTED_GROUP]
                                           [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                           [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for control
                        reads, containing only canonical nucleotides.
  --statistics-filename STATISTICS_FILENAME
                        File to save/load genomic base anchored statistics.

FASTA Sequence Argument:
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.

Multiprocessing Argument:
  --processes PROCESSES
                        Number of processes. Default: 1

Plotting Region Arguments:
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 10
  --num-bases NUM_BASES
                        Number of bases to plot/output. Default: 21
  --slide-span SLIDE_SPAN
                        Number of bases offset over which to search when
                        computing distances for signal cluster plotting.
                        Default: 0 (exact position)

Output Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.signal_clusters.pdf
  --r-data-filename R_DATA_FILENAME
                        Filename to save R data structure. Default: Don't save

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

## ont-tombo_plot_max_difference

### Tool Description
Plot raw signal where signal differs most between two read groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot max_difference --fast5-basedirs FAST5_BASEDIRS
                                 [FAST5_BASEDIRS ...] --control-fast5-basedirs
                                 CONTROL_FAST5_BASEDIRS
                                 [CONTROL_FAST5_BASEDIRS ...]
                                 [--overplot-threshold OVERPLOT_THRESHOLD]
                                 [--overplot-type {Downsample,Boxplot,Quantile,Density}]
                                 [--num-regions NUM_REGIONS]
                                 [--num-bases NUM_BASES]
                                 [--pdf-filename PDF_FILENAME]
                                 [--sequences-filename SEQUENCES_FILENAME]
                                 [--corrected-group CORRECTED_GROUP]
                                 [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                 [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for control
                        reads, containing only canonical nucleotides.

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

Output Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.max_difference.pdf
  --sequences-filename SEQUENCES_FILENAME
                        File for sequences from selected regions. Sequences
                        will be stored in FASTA format. Default: None.

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

## ont-tombo_plot_kmer

### Tool Description
Plot signal distributions acorss kmers.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot kmer --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                       [--upstream-bases {0,1,2,3,4}]
                       [--downstream-bases {0,1,2,3,4}] [--read-mean]
                       [--num-kmer-threshold NUM_KMER_THRESHOLD]
                       [--num-reads NUM_READS] [--pdf-filename PDF_FILENAME]
                       [--r-data-filename R_DATA_FILENAME] [--dont-plot]
                       [--corrected-group CORRECTED_GROUP]
                       [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                       [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Data Processing Arguments:
  --upstream-bases {0,1,2,3,4}
                        Upstream bases in k-mer. Default: 1
  --downstream-bases {0,1,2,3,4}
                        Downstream bases in k-mer. Default: 2
  --read-mean           Plot k-mer means across whole reads as opposed to
                        individual k-mer event levels.
  --num-kmer-threshold NUM_KMER_THRESHOLD
                        Observations of each k-mer required to include a read
                        in read level averages. Default: 1

Plotting Region Arguments:
  --num-reads NUM_READS
                        Number of reads to plot. Default: 100

Output Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.kmer_distribution.pdf
  --r-data-filename R_DATA_FILENAME
                        Filename to save R data structure. Default: Don't save
  --dont-plot           Don't plot result. Useful to produce only R data file.

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

## ont-tombo_plot_most_significant

### Tool Description
Plot raw signal at most modified locations.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot most_significant --fast5-basedirs FAST5_BASEDIRS
                                   [FAST5_BASEDIRS ...] --statistics-filename
                                   STATISTICS_FILENAME
                                   [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                                   [--plot-standard-model]
                                   [--plot-alternate-model {5mC,dcm,6mA,CpG,dam}]
                                   [--overplot-threshold OVERPLOT_THRESHOLD]
                                   [--overplot-type {Downsample,Boxplot,Quantile,Density}]
                                   [--num-regions NUM_REGIONS]
                                   [--num-bases NUM_BASES]
                                   [--coverage-dampen-counts COVERAGE_DAMPEN_COUNTS COVERAGE_DAMPEN_COUNTS]
                                   [--pdf-filename PDF_FILENAME]
                                   [--sequences-filename SEQUENCES_FILENAME]
                                   [--corrected-group CORRECTED_GROUP]
                                   [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                   [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --statistics-filename STATISTICS_FILENAME
                        File to save/load genomic base anchored statistics.

Comparison Arguments:
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Set of directories containing fast5 files for control
                        reads, containing only canonical nucleotides.
  --plot-standard-model
                        Add default standard model distribution to the plot.
  --plot-alternate-model {5mC,dcm,6mA,CpG,dam}
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

Statistical Argument:
  --coverage-dampen-counts COVERAGE_DAMPEN_COUNTS COVERAGE_DAMPEN_COUNTS
                        Dampen fraction modified estimates for low coverage
                        sites. Two parameters are unmodified and modified
                        pseudo read counts. This is equivalent to a beta prior
                        on the fraction estimate. Set to "0 0" to disable
                        dampened fraction estimation. Default: [2, 0]

Output Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.significant_difference.pdf
  --sequences-filename SEQUENCES_FILENAME
                        File for sequences from selected regions. Sequences
                        will be stored in FASTA format. Default: None.

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

