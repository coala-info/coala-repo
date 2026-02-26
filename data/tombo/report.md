# tombo CWL Generation Report

## tombo_resquiggle

### Tool Description
Re-annotate raw nanopore signal to a genomic reference (resquiggle).

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Total Downloads**: 108
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nanoporetech/tombo
- **Stars**: N/A
### Original Help Text
```text
usage: tombo resquiggle [--minimap2-executable MINIMAP2_EXECUTABLE]
                        [--minimap2-index MINIMAP2_INDEX]
                        [--bwa-mem-executable BWA_MEM_EXECUTABLE]
                        [--graphmap-executable GRAPHMAP_EXECUTABLE]
                        [--alignment-batch-size ALIGNMENT_BATCH_SIZE]
                        [--tombo-model-filename TOMBO_MODEL_FILENAME]
                        [--match-expected-value MATCH_EXPECTED_VALUE]
                        [--skip-penalty SKIP_PENALTY] [--bandwidth BANDWIDTH]
                        [--skip-index]
                        [--failed-reads-filename FAILED_READS_FILENAME]
                        [--include-event-stdev]
                        [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                        [--outlier-threshold OUTLIER_THRESHOLD]
                        [--processes PROCESSES]
                        [--align-processes ALIGN_PROCESSES]
                        [--align-threads-per-process ALIGN_THREADS_PER_PROCESS]
                        [--resquiggle-processes RESQUIGGLE_PROCESSES]
                        [--corrected-group CORRECTED_GROUP]
                        [--basecall-group BASECALL_GROUP]
                        [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                        [--overwrite] [--quiet] [--help]
                        fast5_basedir genome_fasta

Required Arguments:
  fast5_basedir         Directory containing fast5 files. All files ending in
                        "fast5" found recursively within this base directory
                        will be processed.
  genome_fasta          Path to fasta file for mapping.

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

Event to Sequence Assignment Parameters:
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.
  --match-expected-value MATCH_EXPECTED_VALUE
                        Expected value when a matched event to genomic
                        sequence is encountered. Default: 0.500000
  --skip-penalty SKIP_PENALTY
                        Penalty applied to skipped genomic bases in event to
                        sequence assignment. Default: 1.000000
  --bandwidth BANDWIDTH
                        Bandwidth of events for dynamic sequence to event
                        mapping. Default: 501

Input/Output Arguments:
  --skip-index          Skip creation of tombo index. This drastically slows
                        downstream tombo commands. Default stores tombo index
                        named ".[--fast5-basedir].[--corrected-
                        group].tombo.index" to be loaded automatically for
                        downstream commands.
  --failed-reads-filename FAILED_READS_FILENAME
                        Output failed read filenames with assoicated error.
                        Default: Do not store failed reads.
  --include-event-stdev
                        Include corrected event standard deviation in output
                        FAST5 data.

Read Filtering Argument:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads baseed on observations per base
                        percentile thresholds. Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]". For example
                        to filter reads with 99th pctl > 200 obs/base or max >
                        5k obs/base use "99:200 100:5000".
  --outlier-threshold OUTLIER_THRESHOLD
                        Windosrize the signal at this number of scale values.
                        Negative value disables outlier clipping. Default:
                        5.000000

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

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-group BASECALL_GROUP
                        FAST5 group obtain original basecalls (under Analyses
                        group). Default: Basecall_1D_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']
  --overwrite           Overwrite previous corrected group in FAST5 files.
                        Note: only effects --corrected-group or --new-
                        corrected-group.

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_test_significance

### Tool Description
Test for significant differences in signal between two sets of FAST5 files or against a model to identify modified bases.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo test_significance --fast5-basedirs FAST5_BASEDIRS
                               [FAST5_BASEDIRS ...] --statistics-file-basename
                               STATISTICS_FILE_BASENAME
                               [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                               [--tombo-model-filename TOMBO_MODEL_FILENAME]
                               [--alternate-model-filenames ALTERNATE_MODEL_FILENAMES [ALTERNATE_MODEL_FILENAMES ...]]
                               [--alternate-bases {5mC} [{5mC} ...]]
                               [--fishers-method-context FISHERS_METHOD_CONTEXT]
                               [--minimum-test-reads MINIMUM_TEST_READS]
                               [--single-read-threshold SINGLE_READ_THRESHOLD]
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
                        testing. Filenames will be [--statistics-file-basename
                        ].[--alternate-bases]?.tombo.stats

Comparison Arguments (Default: De novo testing against default standard model):
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Control set of directories containing fast5 files.
                        These reads should contain only standard nucleotides.
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.
  --alternate-model-filenames ALTERNATE_MODEL_FILENAMES [ALTERNATE_MODEL_FILENAMES ...]
                        Tombo models for alternative likelihood ratio
                        significance testing.
  --alternate-bases {5mC} [{5mC} ...]
                        Default non-standard base model for testing.

Significance Test Arguments:
  --fishers-method-context FISHERS_METHOD_CONTEXT
                        Number of context bases up and downstream over which
                        to compute Fisher's method combined p-values. Note:
                        Not applicable for alternative model likelihood ratio
                        tests. Default: 1.
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required at a position to perform
                        significance testing or contribute to model
                        estimation. Default: 5
  --single-read-threshold SINGLE_READ_THRESHOLD
                        P-value or log likelihood ratio threshold when
                        computing fraction of significant reads at each
                        genomic position. Default: pvalue:0.01; likelihood
                        ratio:2

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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_write_wiggles

### Tool Description
Write wiggle files from FAST5 data or statistics for visualization.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo write_wiggles --fast5-basedirs FAST5_BASEDIRS
                           [FAST5_BASEDIRS ...]
                           [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                           [--statistics-filename STATISTICS_FILENAME]
                           [--wiggle-basename WIGGLE_BASENAME]
                           [--wiggle-types {coverage,fraction,signal,signal_sd,length,stat,mt_stat,difference} [{coverage,fraction,signal,signal_sd,length,stat,mt_stat,difference} ...]]
                           [--corrected-group CORRECTED_GROUP]
                           [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                           [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Comparison Arguments:
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Control set of directories containing fast5 files.
                        These reads should contain only standard nucleotides.
  --statistics-filename STATISTICS_FILENAME
                        File to save/load base by base statistics.

Output Arguments:
  --wiggle-basename WIGGLE_BASENAME
                        Basename for output wiggle files. Two files (plus and
                        minus strand) will be produced for each --wiggle-types
                        supplied. Filenames formatted as "[wiggle-basename
                        ].[wiggle-type].[sample|control]?.[plus|minus].wig".
                        Default: tombo_results
  --wiggle-types {coverage,fraction,signal,signal_sd,length,stat,mt_stat,difference} [{coverage,fraction,signal,signal_sd,length,stat,mt_stat,difference} ...]
                        Data types of wiggles to produce. Default: "coverage
                        fraction"

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_write_most_significant_fasta

### Tool Description
Write FASTA file of sequences from the most significant regions based on Tombo statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo write_most_significant_fasta --statistics-filename
                                          STATISTICS_FILENAME
                                          [--fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]]
                                          [--genome-fasta GENOME_FASTA]
                                          [--statistic-order]
                                          [--num-regions NUM_REGIONS]
                                          [--num-bases NUM_BASES]
                                          [--q-value-threshold Q_VALUE_THRESHOLD]
                                          [--sequences-filename SEQUENCES_FILENAME]
                                          [--corrected-group CORRECTED_GROUP]
                                          [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                          [--quiet] [--help]

Required Arguments (either fast5s or fasts required):
  --statistics-filename STATISTICS_FILENAME
                        File to save/load base by base statistics.
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --genome-fasta GENOME_FASTA
                        FASTA file used to re-squiggle. For faster sequence
                        access.

Region Selection Arguments:
  --statistic-order     Order selected locations by p-values or mean
                        likelihood ratio. Default: fraction of significant
                        reads.
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 100
  --num-bases NUM_BASES
                        Number of bases to plot/output. Default: 21
  --q-value-threshold Q_VALUE_THRESHOLD
                        Plot all regions below provied q-value. Overrides
                        --num-regions.

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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_plot_max_coverage

### Tool Description
Plot regions with maximum coverage from FAST5 data using Tombo.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot_max_coverage --fast5-basedirs FAST5_BASEDIRS
                               [FAST5_BASEDIRS ...]
                               [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                               [--tombo-model-filename TOMBO_MODEL_FILENAME]
                               [--alternate-model-filename ALTERNATE_MODEL_FILENAME]
                               [--plot-standard-model]
                               [--plot-alternate-model {5mC}]
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
                        Control set of directories containing fast5 files.
                        These reads should contain only standard nucleotides.
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.
  --alternate-model-filename ALTERNATE_MODEL_FILENAME
                        Tombo model for alternative likelihood ratio
                        significance testing.
  --plot-standard-model
                        Add default standard model distribution to the plot.
  --plot-alternate-model {5mC}
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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_plot_genome_location

### Tool Description
Plot raw signal at specific genomic locations from fast5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot_genome_location --fast5-basedirs FAST5_BASEDIRS
                                  [FAST5_BASEDIRS ...] --genome-locations
                                  GENOME_LOCATIONS [GENOME_LOCATIONS ...]
                                  [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                                  [--tombo-model-filename TOMBO_MODEL_FILENAME]
                                  [--alternate-model-filename ALTERNATE_MODEL_FILENAME]
                                  [--plot-standard-model]
                                  [--plot-alternate-model {5mC}]
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
                        Control set of directories containing fast5 files.
                        These reads should contain only standard nucleotides.
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.
  --alternate-model-filename ALTERNATE_MODEL_FILENAME
                        Tombo model for alternative likelihood ratio
                        significance testing.
  --plot-standard-model
                        Add default standard model distribution to the plot.
  --plot-alternate-model {5mC}
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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_plot_motif_centered

### Tool Description
Plot signal and statistics centered at a specific motif using Tombo-processed FAST5 data.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot_motif_centered --fast5-basedirs FAST5_BASEDIRS
                                 [FAST5_BASEDIRS ...] --motif MOTIF
                                 --genome-fasta GENOME_FASTA
                                 [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                                 [--tombo-model-filename TOMBO_MODEL_FILENAME]
                                 [--alternate-model-filename ALTERNATE_MODEL_FILENAME]
                                 [--plot-standard-model]
                                 [--plot-alternate-model {5mC}]
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
                        Control set of directories containing fast5 files.
                        These reads should contain only standard nucleotides.
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.
  --alternate-model-filename ALTERNATE_MODEL_FILENAME
                        Tombo model for alternative likelihood ratio
                        significance testing.
  --plot-standard-model
                        Add default standard model distribution to the plot.
  --plot-alternate-model {5mC}
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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_plot_max_difference

### Tool Description
Plot regions with the maximum difference in signal between two sets of FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot_max_difference --fast5-basedirs FAST5_BASEDIRS
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
                        Control set of directories containing fast5 files.
                        These reads should contain only standard nucleotides.

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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_plot_most_significant

### Tool Description
Plot the most significant regions of difference between two sets of FAST5 files or based on statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot_most_significant --fast5-basedirs FAST5_BASEDIRS
                                   [FAST5_BASEDIRS ...] --statistics-filename
                                   STATISTICS_FILENAME
                                   [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                                   [--tombo-model-filename TOMBO_MODEL_FILENAME]
                                   [--alternate-model-filename ALTERNATE_MODEL_FILENAME]
                                   [--plot-standard-model]
                                   [--plot-alternate-model {5mC}]
                                   [--overplot-threshold OVERPLOT_THRESHOLD]
                                   [--overplot-type {Downsample,Boxplot,Quantile,Density}]
                                   [--num-regions NUM_REGIONS]
                                   [--num-bases NUM_BASES]
                                   [--q-value-threshold Q_VALUE_THRESHOLD]
                                   [--statistic-order]
                                   [--pdf-filename PDF_FILENAME]
                                   [--sequences-filename SEQUENCES_FILENAME]
                                   [--corrected-group CORRECTED_GROUP]
                                   [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                   [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --statistics-filename STATISTICS_FILENAME
                        File to save/load base by base statistics.

Comparison Arguments:
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Control set of directories containing fast5 files.
                        These reads should contain only standard nucleotides.
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.
  --alternate-model-filename ALTERNATE_MODEL_FILENAME
                        Tombo model for alternative likelihood ratio
                        significance testing.
  --plot-standard-model
                        Add default standard model distribution to the plot.
  --plot-alternate-model {5mC}
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
  --q-value-threshold Q_VALUE_THRESHOLD
                        Plot all regions below provied q-value. Overrides
                        --num-regions.
  --statistic-order     Order selected locations by p-values or mean
                        likelihood ratio. Default: fraction of significant
                        reads.

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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_plot_motif_with_stats

### Tool Description
Plot signal and statistics at a specific motif using Tombo.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot_motif_with_stats --fast5-basedirs FAST5_BASEDIRS
                                   [FAST5_BASEDIRS ...] --motif MOTIF
                                   --statistics-filename STATISTICS_FILENAME
                                   [--control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]]
                                   [--tombo-model-filename TOMBO_MODEL_FILENAME]
                                   [--overplot-threshold OVERPLOT_THRESHOLD]
                                   [--num-regions NUM_REGIONS]
                                   [--num-context NUM_CONTEXT]
                                   [--num-statistics NUM_STATISTICS]
                                   [--statistic-order]
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
                        File to save/load base by base statistics.

Comparison Arguments:
  --control-fast5-basedirs CONTROL_FAST5_BASEDIRS [CONTROL_FAST5_BASEDIRS ...]
                        Control set of directories containing fast5 files.
                        These reads should contain only standard nucleotides.
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.

Overplotting Argument:
  --overplot-threshold OVERPLOT_THRESHOLD
                        Coverage level to trigger alternative plot type
                        instead of raw signal. Default: 50

Plotting Region Arguments:
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 3
  --num-context NUM_CONTEXT
                        Number of context bases around motif. Default: 2
  --num-statistics NUM_STATISTICS
                        Number of motif centered regions to include in
                        statistic distributions. Default: 200
  --statistic-order     Order selected locations by p-values or mean
                        likelihood ratio. Default: fraction of significant
                        reads.

Output Argument:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.motif_statistics.pdf

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_plot_per_read

### Tool Description
Plot per-read signal at specific genomic locations using Tombo.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot_per_read --fast5-basedirs FAST5_BASEDIRS
                           [FAST5_BASEDIRS ...] --genome-locations
                           GENOME_LOCATIONS [GENOME_LOCATIONS ...]
                           [--tombo-model-filename TOMBO_MODEL_FILENAME]
                           [--alternate-model-filename ALTERNATE_MODEL_FILENAME]
                           [--fishers-method-context FISHERS_METHOD_CONTEXT]
                           [--plot-standard-model]
                           [--plot-alternate-model {5mC}]
                           [--num-reads NUM_READS] [--num-bases NUM_BASES]
                           [--box-center] [--pdf-filename PDF_FILENAME]
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
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.
  --alternate-model-filename ALTERNATE_MODEL_FILENAME
                        Tombo model for alternative likelihood ratio
                        significance testing.
  --fishers-method-context FISHERS_METHOD_CONTEXT
                        Number of context bases up and downstream over which
                        to compute Fisher's method combined p-values. Note:
                        Not applicable for alternative model likelihood ratio
                        tests. Default: 1.
  --plot-standard-model
                        Add default standard model distribution to the plot.
  --plot-alternate-model {5mC}
                        Add alternative model distribution to the plot.

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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_plot_correction

### Tool Description
Plot signal-to-sequence alignment correction (resquiggle) results from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot_correction --fast5-basedirs FAST5_BASEDIRS
                             [FAST5_BASEDIRS ...]
                             [--region-type {random,start,end}]
                             [--num-reads NUM_READS] [--num-obs NUM_OBS]
                             [--pdf-filename PDF_FILENAME]
                             [--corrected-group CORRECTED_GROUP]
                             [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                             [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Region Type Argument:
  --region-type {random,start,end}
                        Region to plot within each read. Default: random

Plotting Region Arguments:
  --num-reads NUM_READS
                        Number of reads to plot. Default: 10
  --num-obs NUM_OBS     Number of observations to plot. Default: 500

Output Argument:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.corrected.pdf

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_plot_multi_correction

### Tool Description
Plot multiple corrected signal alignments from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot_multi_correction --fast5-basedirs FAST5_BASEDIRS
                                   [FAST5_BASEDIRS ...]
                                   [--genome-locations GENOME_LOCATIONS [GENOME_LOCATIONS ...]]
                                   [--num-regions NUM_REGIONS]
                                   [--num-reads NUM_READS] [--num-obs NUM_OBS]
                                   [--pdf-filename PDF_FILENAME]
                                   [--include-original-basecalls]
                                   [--corrected-group CORRECTED_GROUP]
                                   [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                   [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Plotting Region Arguments:
  --genome-locations GENOME_LOCATIONS [GENOME_LOCATIONS ...]
                        Genomic locations at which to plot signal. Format
                        locations as "chrm:position[:strand]
                        [chrm2:position2[:strand2] ...]" (strand not
                        applicable for all applications)
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 10
  --num-reads NUM_READS
                        Number of reads to plot. Default: 5
  --num-obs NUM_OBS     Number of observations to plot. Default: 500

Output Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        tombo_results.multi_corrected.pdf
  --include-original-basecalls
                        Include original basecalls in plots.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_cluster_most_significant

### Tool Description
Cluster and plot the most significant signal differences between two sets of FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo cluster_most_significant --fast5-basedirs FAST5_BASEDIRS
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
                                      [--q-value-threshold Q_VALUE_THRESHOLD]
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
                        Control set of directories containing fast5 files.
                        These reads should contain only standard nucleotides.
  --statistics-filename STATISTICS_FILENAME
                        File to save/load base by base statistics.

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
  --q-value-threshold Q_VALUE_THRESHOLD
                        Plot all regions below provied q-value. Overrides
                        --num-regions.
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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_plot_kmer

### Tool Description
Plot k-mer distributions from FAST5 data using Tombo.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo plot_kmer --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_clear_filters

### Tool Description
Clear filters from FAST5 files in the specified directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo clear_filters --fast5-basedirs FAST5_BASEDIRS
                           [FAST5_BASEDIRS ...]
                           [--corrected-group CORRECTED_GROUP] [--quiet]
                           [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_filter_stuck

### Tool Description
Filter reads based on observations per base percentile thresholds to identify 'stuck' reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo filter_stuck --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                          [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                          [--corrected-group CORRECTED_GROUP] [--quiet]
                          [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads baseed on observations per base
                        percentile thresholds. Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]". For example
                        to filter reads with 99th pctl > 200 obs/base or max >
                        5k obs/base use "99:200 100:5000".

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_event_resquiggle

### Tool Description
Resquiggle (align) raw nanopore signal to a reference genome using existing basecalls.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo event_resquiggle [--minimap2-executable MINIMAP2_EXECUTABLE]
                              [--minimap2-index MINIMAP2_INDEX]
                              [--bwa-mem-executable BWA_MEM_EXECUTABLE]
                              [--graphmap-executable GRAPHMAP_EXECUTABLE]
                              [--alignment-batch-size ALIGNMENT_BATCH_SIZE]
                              [--normalization-type {median,pA,pA_raw,none}]
                              [--pore-model-filename PORE_MODEL_FILENAME]
                              [--outlier-threshold OUTLIER_THRESHOLD]
                              [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                              [--timeout TIMEOUT] [--cpts-limit CPTS_LIMIT]
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
                              fast5_basedir genome_fasta

Required Arguments:
  fast5_basedir         Directory containing fast5 files. All files ending in
                        "fast5" found recursively within this base directory
                        will be processed.
  genome_fasta          Path to fasta file for mapping.

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

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads baseed on observations per base
                        percentile thresholds. Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]". For example
                        to filter reads with 99th pctl > 200 obs/base or max >
                        5k obs/base use "99:200 100:5000".
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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

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


## tombo_model_resquiggle

### Tool Description
Perform model-based re-squiggle of FAST5 files to refine signal-to-sequence alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo model_resquiggle --fast5-basedirs FAST5_BASEDIRS
                              [FAST5_BASEDIRS ...]
                              [--stouffer-z-context STOUFFER_Z_CONTEXT]
                              [--region-context REGION_CONTEXT]
                              [--p-value-threshold P_VALUE_THRESHOLD]
                              [--tombo-model-filename TOMBO_MODEL_FILENAME]
                              [--max-bases-shift MAX_BASES_SHIFT]
                              [--min-obs-per-base MIN_OBS_PER_BASE]
                              [--base-score-iterations BASE_SCORE_ITERATIONS]
                              [--base-score-region-context BASE_SCORE_REGION_CONTEXT]
                              [--base-score-max-bases-shift BASE_SCORE_MAX_BASES_SHIFT]
                              [--corrected-group CORRECTED_GROUP]
                              [--new-corrected-group NEW_CORRECTED_GROUP]
                              [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                              [--overwrite]
                              [--failed-reads-filename FAILED_READS_FILENAME]
                              [--include-event-stdev] [--processes PROCESSES]
                              [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Region Selection Arguments:
  --stouffer-z-context STOUFFER_Z_CONTEXT
                        Number of context bases up and downstream over which
                        to compute Stouffer's Z combined z-scores. Default: 1.
  --region-context REGION_CONTEXT
                        Number of context bases up and downstream of poorly
                        fit regions to perform model re-squiggle. Default: 1.
  --p-value-threshold P_VALUE_THRESHOLD
                        P-value threshold to identify regions to apply model
                        re-squiggle algorithm. Default: 0.100000

Model Re-squiggle Arguments:
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.
  --max-bases-shift MAX_BASES_SHIFT
                        Maximum bases to shift raw signal from
                        event_resquiggle assignment. Default: 3
  --min-obs-per-base MIN_OBS_PER_BASE
                        Minimum raw observations to assign to a genomic base.
                        Default: 3

Base Scoring Arguments:
  --base-score-iterations BASE_SCORE_ITERATIONS
                        Number of iterations through each read to perform
                        (computationally expensive) base space model re-
                        squiggle algorithm. Default: 2.
  --base-score-region-context BASE_SCORE_REGION_CONTEXT
                        Number of context bases up and downstream of poorly
                        fit regions to perform iterative base-score model re-
                        squiggle. Default: 4.
  --base-score-max-bases-shift BASE_SCORE_MAX_BASES_SHIFT
                        Maximum bases to shift raw signal from first round of
                        model re-squiggle. Default: 4

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --new-corrected-group NEW_CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawModelCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Output Arguments:
  --overwrite           Overwrite previous corrected group in FAST5 files.
                        Note: only effects --corrected-group or --new-
                        corrected-group.
  --failed-reads-filename FAILED_READS_FILENAME
                        Output failed read filenames with assoicated error.
                        Default: Do not store failed reads.
  --include-event-stdev
                        Include corrected event standard deviation in output
                        FAST5 data.

Multiprocessing Argument:
  --processes PROCESSES
                        Number of processes. Default: 1

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_estimate_kmer_reference

### Tool Description
Estimate k-mer reference model from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo estimate_kmer_reference --fast5-basedirs FAST5_BASEDIRS
                                     [FAST5_BASEDIRS ...]
                                     --tombo-model-filename
                                     TOMBO_MODEL_FILENAME [--estimate-mean]
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
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.

Modeling Arguments:
  --estimate-mean       Use the mean instead of median for model level
                        estimation. Note:This can cause poor fits due to
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
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_estimate_alt_reference

### Tool Description
Estimate alternative reference models from FAST5 data for non-standard base detection.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo estimate_alt_reference --fast5-basedirs FAST5_BASEDIRS
                                    [FAST5_BASEDIRS ...]
                                    --alternate-model-filename
                                    ALTERNATE_MODEL_FILENAME
                                    --alternate-model-name
                                    ALTERNATE_MODEL_NAME
                                    --alternate-model-base {A,C,G,T}
                                    [--tombo-model-filename TOMBO_MODEL_FILENAME]
                                    [--min-alt-base-percentage MIN_ALT_BASE_PERCENTAGE]
                                    [--sd-threshold SD_THRESHOLD]
                                    [--minimum-kmer-observations MINIMUM_KMER_OBSERVATIONS]
                                    [--corrected-group CORRECTED_GROUP]
                                    [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                    [--quiet] [--help]

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --alternate-model-filename ALTERNATE_MODEL_FILENAME
                        Tombo model for alternative likelihood ratio
                        significance testing.
  --alternate-model-name ALTERNATE_MODEL_NAME
                        A short name to associate with this alternate model
                        (e.g. 5mC, 4mC, 6mA). This text will be included in
                        output filenames when this model is used for testing.
  --alternate-model-base {A,C,G,T}
                        Non-standard base is an alternative to this base.

Modeling Arguments:
  --tombo-model-filename TOMBO_MODEL_FILENAME
                        Tombo model for event-less resquiggle and significance
                        testing. If no model is provided the default DNA or
                        RNA tombo model will be used.
  --min-alt-base-percentage MIN_ALT_BASE_PERCENTAGE
                        Minimum estimated percent of non-standard base
                        distribution for inclusion of k-mer in non-standard
                        model. Default: 5.000000
  --sd-threshold SD_THRESHOLD
                        Minimum level standard deviation difference between
                        estimated non-standard distribution mean and standard
                        model mean for inclusion of k-mer in non-standard
                        model. Default: 1.500000

Filtering Argument:
  --minimum-kmer-observations MINIMUM_KMER_OBSERVATIONS
                        Number of each k-mer observations required in order to
                        produce a reference (genomic locations for standard
                        reference and per-read for alternative reference).
                        Default: 1000

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group created by resquiggle command. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup(s) (under Analyses/[corrected-group])
                        containing basecalls. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## tombo_Additional

### Tool Description
Tombo is a suite of tools primarily for the identification of modified nucleotides from nanopore sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/tombo:1.0--py27_0
- **Homepage**: https://github.com/nanoporetech/tombo
- **Package**: https://anaconda.org/channels/bioconda/packages/tombo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tombo [-h] [-v]
             {resquiggle,test_significance,write_wiggles,write_most_significant_fasta,plot_max_coverage,plot_genome_location,plot_motif_centered,plot_max_difference,plot_most_significant,plot_motif_with_stats,plot_per_read,plot_correction,plot_multi_correction,cluster_most_significant,plot_kmer,clear_filters,filter_stuck,event_resquiggle,model_resquiggle,estimate_kmer_reference,estimate_alt_reference}
             ...
tombo: error: invalid choice: 'Additional' (choose from 'resquiggle', 'test_significance', 'write_wiggles', 'write_most_significant_fasta', 'plot_max_coverage', 'plot_genome_location', 'plot_motif_centered', 'plot_max_difference', 'plot_most_significant', 'plot_motif_with_stats', 'plot_per_read', 'plot_correction', 'plot_multi_correction', 'cluster_most_significant', 'plot_kmer', 'clear_filters', 'filter_stuck', 'event_resquiggle', 'model_resquiggle', 'estimate_kmer_reference', 'estimate_alt_reference')
```

