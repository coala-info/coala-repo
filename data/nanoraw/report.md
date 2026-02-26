# nanoraw CWL Generation Report

## nanoraw_genome_resquiggle

### Tool Description
Resquiggle raw signal data to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Total Downloads**: 29.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marcus1487/nanoraw
- **Stars**: N/A
### Original Help Text
```text
usage: nanoraw genome_resquiggle [--graphmap-executable GRAPHMAP_EXECUTABLE]
                                 [--bwa-mem-executable BWA_MEM_EXECUTABLE]
                                 [--timeout TIMEOUT] [--cpts-limit CPTS_LIMIT]
                                 [--normalization-type {median,pA,pA_raw,none}]
                                 [--pore-model-filename PORE_MODEL_FILENAME]
                                 [--outlier-threshold OUTLIER_THRESHOLD]
                                 [--fast5-pattern FAST5_PATTERN] [--recursive]
                                 [--overwrite]
                                 [--failed-reads-filename FAILED_READS_FILENAME]
                                 [--corrected-group CORRECTED_GROUP]
                                 [--basecall-group BASECALL_GROUP]
                                 [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                                 | --2d] [--processes PROCESSES]
                                 [--align-processes ALIGN_PROCESSES]
                                 [--align-threads-per-process ALIGN_THREADS_PER_PROCESS]
                                 [--resquiggle-processes RESQUIGGLE_PROCESSES]
                                 [--alignment-batch-size ALIGNMENT_BATCH_SIZE]
                                 [--skip-event-stdev] [--quiet] [--help]
                                 fast5_basedir genome_fasta

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Arguments:
  fast5_basedir         Directory containing fast5 files.
  genome_fasta          Path to fasta file for mapping.

Mapper Arguments (One mapper is required):
  --graphmap-executable GRAPHMAP_EXECUTABLE
                        Relative or absolute path to built graphmap executable
                        or command name if globally installed.
  --bwa-mem-executable BWA_MEM_EXECUTABLE
                        Relative or absolute path to built bwa-mem executable
                        or command name if globally installed.

Read Filtering Arguments:
  --timeout TIMEOUT     Timeout in seconds for the processing of a single
                        read. Default: No timeout.
  --cpts-limit CPTS_LIMIT
                        Maximum number of changepoints to find within a single
                        indel group. (Not setting this option can cause a
                        process to stall and cannot be controlled by the
                        timeout option). Default: No limit.

Read Normalization Arguments:
  --normalization-type {median,pA,pA_raw,none}
                        Type of normalization to apply to raw signal when
                        calculating statistics based on new segmentation.
                        Should be one of {"median", "pA", "pA_raw", "none"}.
                        "none" will provde the raw 16-bit DAQ values as the
                        raw signal is stored. "pA_raw" will calculate the pA
                        estimates as in the ONT events (using offset, range
                        and digitization parameters stored in the FAST5 file).
                        "pA" will first apply the "pA_raw" normalization
                        followed by kmer-based correction for pA drift as
                        described in the nanopolish methylation manuscript
                        (this option requires the [--pore-model-filename]
                        option). "median" will shift by the median of each
                        reads' raw signal and scale by the MAD. Default:
                        median
  --pore-model-filename PORE_MODEL_FILENAME
                        File containing kmer model parameters (level_mean and
                        level_stdv) used in order to compute kmer-based
                        corrected pA values. E.g. https://github.com/jts/nanop
                        olish/blob/master/etc/r9-models/template_median68pA.5m
                        ers.model
  --outlier-threshold OUTLIER_THRESHOLD
                        Number of median absolute deviation (MAD) values at
                        which to clip the raw signal. This can help avoid
                        strong re-segmentation artifacts from spikes in
                        signal. Set to negative value to disable outlier
                        clipping. Default: 5

Input/Output Arguments:
  --fast5-pattern FAST5_PATTERN
                        A pattern to search for a subset of files within
                        fast5-basedir. Note that on the unix command line
                        patterns may be expanded so it is best practice to
                        quote patterns.
  --recursive           Search for FAST5 files within immediate sub-
                        directories.Note that this only searches a single
                        level of subdirectories and only for files ending in
                        .fast5. This is equivalent to specifying
                        --fast5-pattern "*/*.fast5".
  --overwrite           Overwrite previous corrected group in FAST5/HDF5 file.
                        (Note this only effects the group defined by
                        --corrected-group).
  --failed-reads-filename FAILED_READS_FILENAME
                        Output failed read filenames into a this file with
                        assoicated error for each read. Default: Do not store
                        failed reads.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000
  --basecall-group BASECALL_GROUP
                        FAST5 group to use for obtaining original basecalls
                        (under Analyses group). Default: Basecall_1D_000

Multiprocessing Arguments:
  --processes PROCESSES
                        Number of processes. Default: 2
  --align-processes ALIGN_PROCESSES
                        Number of processes to use for aligning and parsing
                        original basecalls. Each process will independently
                        load the genome into memory, so use caution with
                        larger genomes (e.g. human). Default: 1
  --align-threads-per-process ALIGN_THREADS_PER_PROCESS
                        Number of threads to use per alignment process. This
                        value is passed to the underlying mapper system calls.
                        Default: [--processes] / (2 * [--align-processes)]
  --resquiggle-processes RESQUIGGLE_PROCESSES
                        Number of processes to use for re-squiggling raw data.
                        Default: [--processes] / 2

Miscellaneous Arguments:
  --alignment-batch-size ALIGNMENT_BATCH_SIZE
                        Batch size (number of reads) for each alignment call.
                        Note that a new system call to the mapper is made for
                        each batch (including loading of the genome), so it is
                        advised to use larger values for larger genomes.
                        Default: 500
  --skip-event-stdev    Skip computation of corrected event standard
                        deviations to save (potentially significant) time on
                        computations.
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_plot_max_coverage

### Tool Description
Plots the maximum coverage of Nanopore reads across genomic regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw plot_max_coverage --fast5-basedirs FAST5_BASEDIRS
                                 [FAST5_BASEDIRS ...]
                                 [--fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]]
                                 [--corrected-group CORRECTED_GROUP]
                                 [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                                 | --2d]
                                 [--overplot-threshold OVERPLOT_THRESHOLD]
                                 [--overplot-type {Downsample,Boxplot,Quantile,Violin}]
                                 [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                                 [--pdf-filename PDF_FILENAME]
                                 [--num-regions NUM_REGIONS]
                                 [--num-bases NUM_BASES] [--quiet] [--help]

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Comparison Group Argument:
  --fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                        Second set of directories containing fast5 files to
                        compare.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000

Overplotting Arguments:
  --overplot-threshold OVERPLOT_THRESHOLD
                        Number of reads to trigger alternative plot type
                        instead of raw signal due to overplotting. Default: 50
  --overplot-type {Downsample,Boxplot,Quantile,Violin}
                        Plot type for regions with higher coverage. Choices:
                        Downsample (default), Boxplot , Quantile, Violin

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads for plotting baseed on threshold of
                        percentiles of the number of observations assigned to
                        a base (default no filter). Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]" E.g. reads
                        with 99th pctl <200 obs and max <5k obs would be
                        "99:200 100:5000".

Miscellaneous Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        Nanopore_read_coverage.max_coverage.pdf
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 10
  --num-bases NUM_BASES
                        Number of bases to plot from region. Default: 51
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_plot_genome_location

### Tool Description
Plot signal at specified genomic locations.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw plot_genome_location --fast5-basedirs FAST5_BASEDIRS
                                    [FAST5_BASEDIRS ...] --genome-locations
                                    GENOME_LOCATIONS [GENOME_LOCATIONS ...]
                                    [--fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]]
                                    [--corrected-group CORRECTED_GROUP]
                                    [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                                    | --2d]
                                    [--overplot-threshold OVERPLOT_THRESHOLD]
                                    [--overplot-type {Downsample,Boxplot,Quantile,Violin}]
                                    [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                                    [--pdf-filename PDF_FILENAME]
                                    [--num-bases NUM_BASES] [--quiet] [--help]

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Arguments:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --genome-locations GENOME_LOCATIONS [GENOME_LOCATIONS ...]
                        Plot signal at specified genomic locations. Format
                        locations as "chrm:position[:strand]
                        [chrm2:position2[:strand2] ...]" (strand not
                        applicable for all applications)

Comparison Group Argument:
  --fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                        Second set of directories containing fast5 files to
                        compare.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000

Overplotting Arguments:
  --overplot-threshold OVERPLOT_THRESHOLD
                        Number of reads to trigger alternative plot type
                        instead of raw signal due to overplotting. Default: 50
  --overplot-type {Downsample,Boxplot,Quantile,Violin}
                        Plot type for regions with higher coverage. Choices:
                        Downsample (default), Boxplot , Quantile, Violin

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads for plotting baseed on threshold of
                        percentiles of the number of observations assigned to
                        a base (default no filter). Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]" E.g. reads
                        with 99th pctl <200 obs and max <5k obs would be
                        "99:200 100:5000".

Miscellaneous Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        Nanopore_read_coverage.genome_locations.pdf
  --num-bases NUM_BASES
                        Number of bases to plot from region. Default: 51
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_plot_motif_centered

### Tool Description
Plot motif centered regions and statistic distributions at each genomic base in the region.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw plot_motif_centered --fast5-basedirs FAST5_BASEDIRS
                                   [FAST5_BASEDIRS ...] --motif MOTIF
                                   --genome-fasta GENOME_FASTA
                                   [--fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]]
                                   [--corrected-group CORRECTED_GROUP]
                                   [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                                   | --2d]
                                   [--overplot-threshold OVERPLOT_THRESHOLD]
                                   [--overplot-type {Downsample,Boxplot,Quantile,Violin}]
                                   [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                                   [--deepest-coverage]
                                   [--pdf-filename PDF_FILENAME]
                                   [--num-regions NUM_REGIONS]
                                   [--num-bases NUM_BASES] [--quiet] [--help]

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --motif MOTIF         A motif to plot the most significant regions genomic
                        regions as well as statistic distributions at each
                        genomic base in the region. Supports single letter
                        codes.
  --genome-fasta GENOME_FASTA
                        FASTA file used to map reads with "genome_resquiggle"
                        command.

Comparison Group Argument:
  --fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                        Second set of directories containing fast5 files to
                        compare.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000

Overplotting Arguments:
  --overplot-threshold OVERPLOT_THRESHOLD
                        Number of reads to trigger alternative plot type
                        instead of raw signal due to overplotting. Default: 50
  --overplot-type {Downsample,Boxplot,Quantile,Violin}
                        Plot type for regions with higher coverage. Choices:
                        Downsample (default), Boxplot , Quantile, Violin

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads for plotting baseed on threshold of
                        percentiles of the number of observations assigned to
                        a base (default no filter). Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]" E.g. reads
                        with 99th pctl <200 obs and max <5k obs would be
                        "99:200 100:5000".

Miscellaneous Arguments:
  --deepest-coverage    Plot the deepest coverage regions.
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        Nanopore_read_coverage.motif_centered.pdf
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 10
  --num-bases NUM_BASES
                        Number of bases to plot from region. Default: 51
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_plot_max_difference

### Tool Description
Plotting the maximum difference between two sets of fast5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw plot_max_difference --fast5-basedirs FAST5_BASEDIRS
                                   [FAST5_BASEDIRS ...] --fast5-basedirs2
                                   FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                                   [--corrected-group CORRECTED_GROUP]
                                   [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                                   | --2d]
                                   [--overplot-threshold OVERPLOT_THRESHOLD]
                                   [--overplot-type {Downsample,Boxplot,Quantile,Violin}]
                                   [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                                   [--pdf-filename PDF_FILENAME]
                                   [--sequences-filename SEQUENCES_FILENAME]
                                   [--num-regions NUM_REGIONS]
                                   [--num-bases NUM_BASES] [--quiet] [--help]

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                        Second set of directories containing fast5 files to
                        compare.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000

Overplotting Arguments:
  --overplot-threshold OVERPLOT_THRESHOLD
                        Number of reads to trigger alternative plot type
                        instead of raw signal due to overplotting. Default: 50
  --overplot-type {Downsample,Boxplot,Quantile,Violin}
                        Plot type for regions with higher coverage. Choices:
                        Downsample (default), Boxplot , Quantile, Violin

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads for plotting baseed on threshold of
                        percentiles of the number of observations assigned to
                        a base (default no filter). Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]" E.g. reads
                        with 99th pctl <200 obs and max <5k obs would be
                        "99:200 100:5000".

Miscellaneous Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        Nanopore_read_coverage.max_difference.pdf
  --sequences-filename SEQUENCES_FILENAME
                        Filename to store sequences for selected regions (e.g.
                        for PWM search). Sequences will be stored in FASTA
                        format. Default: None.
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 10
  --num-bases NUM_BASES
                        Number of bases to plot from region. Default: 51
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_plot_most_significant

### Tool Description
Plot regions with significant differences in signal level between two sets of FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw plot_most_significant --fast5-basedirs FAST5_BASEDIRS
                                     [FAST5_BASEDIRS ...] --fast5-basedirs2
                                     FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                                     [--corrected-group CORRECTED_GROUP]
                                     [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                                     | --2d]
                                     [--overplot-threshold OVERPLOT_THRESHOLD]
                                     [--overplot-type {Downsample,Boxplot,Quantile,Violin}]
                                     [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                                     [--test-type {mw_utest,ttest}]
                                     [--fishers-method-offset FISHERS_METHOD_OFFSET]
                                     [--minimum-test-reads MINIMUM_TEST_READS]
                                     [--pdf-filename PDF_FILENAME]
                                     [--statistics-filename STATISTICS_FILENAME]
                                     [--q-value-threshold Q_VALUE_THRESHOLD]
                                     [--sequences-filename SEQUENCES_FILENAME]
                                     [--num-regions NUM_REGIONS]
                                     [--num-bases NUM_BASES] [--quiet]
                                     [--help]

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                        Second set of directories containing fast5 files to
                        compare.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000

Overplotting Arguments:
  --overplot-threshold OVERPLOT_THRESHOLD
                        Number of reads to trigger alternative plot type
                        instead of raw signal due to overplotting. Default: 50
  --overplot-type {Downsample,Boxplot,Quantile,Violin}
                        Plot type for regions with higher coverage. Choices:
                        Downsample (default), Boxplot , Quantile, Violin

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads for plotting baseed on threshold of
                        percentiles of the number of observations assigned to
                        a base (default no filter). Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]" E.g. reads
                        with 99th pctl <200 obs and max <5k obs would be
                        "99:200 100:5000".

Significance Test Arguments:
  --test-type {mw_utest,ttest}
                        Type of significance test to apply. Choices are:
                        mw_utest (default; mann-whitney u-test), ttest.
  --fishers-method-offset FISHERS_METHOD_OFFSET
                        Offset up and downstream over which to compute
                        combined p-values using Fisher's method. Default: 2.
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required from both samples to test for
                        significant difference in signal level. Default: 5

Miscellaneous Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        Nanopore_read_coverage.significant_difference.pdf
  --statistics-filename STATISTICS_FILENAME
                        Filename to save/load base by base signal difference
                        statistics. If file exists it will try to be loaded,
                        if it does not exist it will be created to save
                        statistics. Default: Don't save/load.
  --q-value-threshold Q_VALUE_THRESHOLD
                        Choose the number of regions to select by the FDR
                        corrected p-values. Note that --num-regions will be
                        ignored if this option is set.
  --sequences-filename SEQUENCES_FILENAME
                        Filename to store sequences for selected regions (e.g.
                        for PWM search). Sequences will be stored in FASTA
                        format. Default: None.
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 10
  --num-bases NUM_BASES
                        Number of bases to plot from region. Default: 51
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_plot_motif_with_stats

### Tool Description
Plot motif statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw plot_motif_with_stats --fast5-basedirs FAST5_BASEDIRS
                                     [FAST5_BASEDIRS ...] --fast5-basedirs2
                                     FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                                     --motif MOTIF
                                     [--corrected-group CORRECTED_GROUP]
                                     [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                                     | --2d]
                                     [--overplot-threshold OVERPLOT_THRESHOLD]
                                     [--overplot-type {Downsample,Boxplot,Quantile,Violin}]
                                     [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                                     [--test-type {mw_utest,ttest}]
                                     [--fishers-method-offset FISHERS_METHOD_OFFSET]
                                     [--minimum-test-reads MINIMUM_TEST_READS]
                                     [--pdf-filename PDF_FILENAME]
                                     [--statistics-filename STATISTICS_FILENAME]
                                     [--num-regions NUM_REGIONS]
                                     [--num-context NUM_CONTEXT]
                                     [--num-statistics NUM_STATISTICS]
                                     [--quiet] [--help]

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                        Second set of directories containing fast5 files to
                        compare.
  --motif MOTIF         A motif to plot the most significant regions genomic
                        regions as well as statistic distributions at each
                        genomic base in the region. Supports single letter
                        codes.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000

Overplotting Arguments:
  --overplot-threshold OVERPLOT_THRESHOLD
                        Number of reads to trigger alternative plot type
                        instead of raw signal due to overplotting. Default: 50
  --overplot-type {Downsample,Boxplot,Quantile,Violin}
                        Plot type for regions with higher coverage. Choices:
                        Downsample (default), Boxplot , Quantile, Violin

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads for plotting baseed on threshold of
                        percentiles of the number of observations assigned to
                        a base (default no filter). Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]" E.g. reads
                        with 99th pctl <200 obs and max <5k obs would be
                        "99:200 100:5000".

Significance Test Arguments:
  --test-type {mw_utest,ttest}
                        Type of significance test to apply. Choices are:
                        mw_utest (default; mann-whitney u-test), ttest.
  --fishers-method-offset FISHERS_METHOD_OFFSET
                        Offset up and downstream over which to compute
                        combined p-values using Fisher's method. Default: 2.
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required from both samples to test for
                        significant difference in signal level. Default: 5

Miscellaneous Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        Nanopore_read_coverage.statistics_around_motif.pdf
  --statistics-filename STATISTICS_FILENAME
                        Filename to save/load base by base signal difference
                        statistics. If file exists it will try to be loaded,
                        if it does not exist it will be created to save
                        statistics. Default: Don't save/load.
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 5
  --num-context NUM_CONTEXT
                        Number of bases surrounding motif of interest.
                        Default: 2
  --num-statistics NUM_STATISTICS
                        Number of regions at which to accumulate statistics
                        for distribution plots. Default: 200
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_plot_correction

### Tool Description
Plotting tool for Nanopore genome correction.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw plot_correction --fast5-basedirs FAST5_BASEDIRS
                               [FAST5_BASEDIRS ...]
                               [--region-type {random,start,end}]
                               [--corrected-group CORRECTED_GROUP]
                               [--basecall-subgroup BASECALL_SUBGROUP]
                               [--pdf-filename PDF_FILENAME]
                               [--num-reads NUM_READS] [--num-obs NUM_OBS]
                               [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Region Type Argument:
  --region-type {random,start,end}
                        Region to plot within each read. Choices are: random
                        (default), start, end.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000
  --basecall-subgroup BASECALL_SUBGROUP
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template or complement read is
                        stored. Default: BaseCalled_template

Miscellaneous Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        Nanopore_genome_correction.pdf
  --num-reads NUM_READS
                        Number of reads to plot (one region per read).
                        Default: 10
  --num-obs NUM_OBS     Number of observations to plot in each region.
                        Default: 500
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_plot_multi_correction

### Tool Description
Plot signal at specified genomic locations.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw plot_multi_correction --fast5-basedirs FAST5_BASEDIRS
                                     [FAST5_BASEDIRS ...]
                                     [--corrected-group CORRECTED_GROUP]
                                     [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]]
                                     [--pdf-filename PDF_FILENAME]
                                     [--genome-locations GENOME_LOCATIONS [GENOME_LOCATIONS ...]]
                                     [--include-original-basecalls]
                                     [--num-reads-per-plot NUM_READS_PER_PLOT]
                                     [--num-regions NUM_REGIONS]
                                     [--num-obs NUM_OBS] [--quiet] [--help]

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']

Miscellaneous Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        Nanopore_genome_multiread_correction.pdf
  --genome-locations GENOME_LOCATIONS [GENOME_LOCATIONS ...]
                        Plot signal at specified genomic locations. Format
                        locations as "chrm:position[:strand]
                        [chrm2:position2[:strand2] ...]" (strand not
                        applicable for all applications)
  --include-original-basecalls
                        Iclude original basecalls in plots.
  --num-reads-per-plot NUM_READS_PER_PLOT
                        Number of reads to plot per genomic region. Default: 5
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 10
  --num-obs NUM_OBS     Number of observations to plot in each region.
                        Default: 500
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_cluster_most_significant

### Tool Description
Compares two sets of fast5 files to find significant differences in signal levels.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw cluster_most_significant --fast5-basedirs FAST5_BASEDIRS
                                        [FAST5_BASEDIRS ...] --fast5-basedirs2
                                        FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                                        [--corrected-group CORRECTED_GROUP]
                                        [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                                        | --2d]
                                        [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                                        [--test-type {mw_utest,ttest}]
                                        [--fishers-method-offset FISHERS_METHOD_OFFSET]
                                        [--minimum-test-reads MINIMUM_TEST_READS]
                                        [--genome-fasta GENOME_FASTA]
                                        [--processes PROCESSES]
                                        [--pdf-filename PDF_FILENAME]
                                        [--statistics-filename STATISTICS_FILENAME]
                                        [--r-data-filename R_DATA_FILENAME]
                                        [--num-regions NUM_REGIONS]
                                        [--q-value-threshold Q_VALUE_THRESHOLD]
                                        [--num-bases NUM_BASES]
                                        [--slide-span SLIDE_SPAN] [--quiet]
                                        [--help]

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                        Second set of directories containing fast5 files to
                        compare.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads for plotting baseed on threshold of
                        percentiles of the number of observations assigned to
                        a base (default no filter). Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]" E.g. reads
                        with 99th pctl <200 obs and max <5k obs would be
                        "99:200 100:5000".

Significance Test Arguments:
  --test-type {mw_utest,ttest}
                        Type of significance test to apply. Choices are:
                        mw_utest (default; mann-whitney u-test), ttest.
  --fishers-method-offset FISHERS_METHOD_OFFSET
                        Offset up and downstream over which to compute
                        combined p-values using Fisher's method. Default: 2.
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required from both samples to test for
                        significant difference in signal level. Default: 5

FASTA Sequence Argument:
  --genome-fasta GENOME_FASTA
                        FASTA file used to map reads with "genome_resquiggle"
                        command.

Multiprocessing Argument:
  --processes PROCESSES
                        Number of processes. Default: 1

Miscellaneous Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        Nanopore_most_significant_clustering.pdf
  --statistics-filename STATISTICS_FILENAME
                        Filename to save/load base by base signal difference
                        statistics. If file exists it will try to be loaded,
                        if it does not exist it will be created to save
                        statistics. Default: Don't save/load.
  --r-data-filename R_DATA_FILENAME
                        Filename to save R data structure. Defualt: Don't save
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 10
  --q-value-threshold Q_VALUE_THRESHOLD
                        Choose the number of regions to select by the FDR
                        corrected p-values. Note that --num-regions will be
                        ignored if this option is set.
  --num-bases NUM_BASES
                        Number of bases to plot from region. Default: 5
  --slide-span SLIDE_SPAN
                        Number of bases to slide up and down when computing
                        distances for signal cluster plotting. Default: Exact
                        position
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_plot_kmer

### Tool Description
Plot k-mer distribution from FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw plot_kmer --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                         [--upstream-bases {0,1,2,3}]
                         [--downstream-bases {0,1,2,3}] [--read-mean]
                         [--num-kmer-threshold NUM_KMER_THRESHOLD]
                         [--corrected-group CORRECTED_GROUP]
                         [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                         | --2d] [--pdf-filename PDF_FILENAME]
                         [--num-reads NUM_READS]
                         [--r-data-filename R_DATA_FILENAME] [--dont-plot]
                         [--quiet] [--help]

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Data Processing Arguments:
  --upstream-bases {0,1,2,3}
                        Upstream bases in k-mer. Should be one of {0,1,2,3}.
                        Default: 1
  --downstream-bases {0,1,2,3}
                        Downstream bases in k-mer. Should be one of {0,1,2,3}.
                        Default: 2
  --read-mean           Plot kmer event means across reads as opposed to each
                        event.
  --num-kmer-threshold NUM_KMER_THRESHOLD
                        Number of each kmer required to include a read in read
                        level averages. Default: 4

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000

Miscellaneous Arguments:
  --pdf-filename PDF_FILENAME
                        PDF filename to store plot(s). Default:
                        Nanopore_kmer_distribution.pdf
  --num-reads NUM_READS
                        Number of reads to plot (one region per read).
                        Default: 500
  --r-data-filename R_DATA_FILENAME
                        Filename to save R data structure. Defualt: Don't save
  --dont-plot           Don't actually plot the result. Useful when you only
                        want the R data file.
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_write_most_significant_fasta

### Tool Description
Write the most significant regions to a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw write_most_significant_fasta --fast5-basedirs FAST5_BASEDIRS
                                            [FAST5_BASEDIRS ...]
                                            --fast5-basedirs2 FAST5_BASEDIRS2
                                            [FAST5_BASEDIRS2 ...]
                                            [--corrected-group CORRECTED_GROUP]
                                            [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                                            | --2d]
                                            [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                                            [--test-type {mw_utest,ttest}]
                                            [--fishers-method-offset FISHERS_METHOD_OFFSET]
                                            [--minimum-test-reads MINIMUM_TEST_READS]
                                            [--genome-fasta GENOME_FASTA]
                                            [--sequences-filename SEQUENCES_FILENAME]
                                            [--statistics-filename STATISTICS_FILENAME]
                                            [--num-regions NUM_REGIONS]
                                            [--q-value-threshold Q_VALUE_THRESHOLD]
                                            [--num-bases NUM_BASES] [--quiet]
                                            [--help]

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.
  --fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                        Second set of directories containing fast5 files to
                        compare.

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads for plotting baseed on threshold of
                        percentiles of the number of observations assigned to
                        a base (default no filter). Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]" E.g. reads
                        with 99th pctl <200 obs and max <5k obs would be
                        "99:200 100:5000".

Significance Test Arguments:
  --test-type {mw_utest,ttest}
                        Type of significance test to apply. Choices are:
                        mw_utest (default; mann-whitney u-test), ttest.
  --fishers-method-offset FISHERS_METHOD_OFFSET
                        Offset up and downstream over which to compute
                        combined p-values using Fisher's method. Default: 2.
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required from both samples to test for
                        significant difference in signal level. Default: 5

FASTA Sequence Argument:
  --genome-fasta GENOME_FASTA
                        FASTA file used to map reads with "genome_resquiggle"
                        command.

Miscellaneous Arguments:
  --sequences-filename SEQUENCES_FILENAME
                        Filename to store sequences for selected regions (e.g.
                        for PWM search). Sequences will be stored in FASTA
                        format. Default:
                        Nanopore_most_significant_regions.fasta.
  --statistics-filename STATISTICS_FILENAME
                        Filename to save/load base by base signal difference
                        statistics. If file exists it will try to be loaded,
                        if it does not exist it will be created to save
                        statistics. Default: Don't save/load.
  --num-regions NUM_REGIONS
                        Number of regions to plot. Default: 10
  --q-value-threshold Q_VALUE_THRESHOLD
                        Choose the number of regions to select by the FDR
                        corrected p-values. Note that --num-regions will be
                        ignored if this option is set.
  --num-bases NUM_BASES
                        Number of bases to plot from region. Default: 51
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_write_wiggles

### Tool Description
Write wiggle files for Nanopore data.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw write_wiggles --fast5-basedirs FAST5_BASEDIRS
                             [FAST5_BASEDIRS ...]
                             [--fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]]
                             [--wiggle-basename WIGGLE_BASENAME]
                             [--wiggle-types {coverage,signal,signal_sd,length,pvals,qvals,difference} [{coverage,signal,signal_sd,length,pvals,qvals,difference} ...]]
                             [--corrected-group CORRECTED_GROUP]
                             [--basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                             | --2d]
                             [--obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]]
                             [--test-type {mw_utest,ttest}]
                             [--fishers-method-offset FISHERS_METHOD_OFFSET]
                             [--minimum-test-reads MINIMUM_TEST_READS]
                             [--statistics-filename STATISTICS_FILENAME]
                             [--quiet] [--help]

optional arguments:
  --basecall-subgroups BASECALL_SUBGROUPS [BASECALL_SUBGROUPS ...]
                        FAST5 subgroup (under Analyses/[corrected-group])
                        where individual template and/or complement reads are
                        stored. Default: ['BaseCalled_template']
  --2d                  Input contains 2D reads. Equivalent to `--basecall-
                        subgroups BaseCalled_template BaseCalled_complement`

Required Argument:
  --fast5-basedirs FAST5_BASEDIRS [FAST5_BASEDIRS ...]
                        Directories containing fast5 files.

Comparison Group Argument:
  --fast5-basedirs2 FAST5_BASEDIRS2 [FAST5_BASEDIRS2 ...]
                        Second set of directories containing fast5 files to
                        compare.

Output Arguments:
  --wiggle-basename WIGGLE_BASENAME
                        Basename for output files. Two files (plus and minus
                        strand) will be produced for each --wiggle-types
                        supplied. Filenames will be formatted as "[wiggle-
                        basename].[wiggle-type].[group1/2]?.[plus/minus].wig".
                        Default: Nanopore_data
  --wiggle-types {coverage,signal,signal_sd,length,pvals,qvals,difference} [{coverage,signal,signal_sd,length,pvals,qvals,difference} ...]
                        Data types for which wiggles should be created (select
                        one or more data types). Choices: coverage, signal,
                        signal_sd, length, pvals, qvals (both negative log10),
                        difference. Note that signal, signal_sd and length
                        (number of observations per base) are means over all
                        reads at each base. Default: "coverage, pvals"

FAST5 Data Arguments:
  --corrected-group CORRECTED_GROUP
                        FAST5 group to access/plot created by
                        genome_resquiggle script. Default:
                        RawGenomeCorrected_000

Read Filtering Arguments:
  --obs-per-base-filter OBS_PER_BASE_FILTER [OBS_PER_BASE_FILTER ...]
                        Filter reads for plotting baseed on threshold of
                        percentiles of the number of observations assigned to
                        a base (default no filter). Format thresholds as
                        "percentile:thresh [pctl2:thresh2 ...]" E.g. reads
                        with 99th pctl <200 obs and max <5k obs would be
                        "99:200 100:5000".

Significance Test Arguments:
  --test-type {mw_utest,ttest}
                        Type of significance test to apply. Choices are:
                        mw_utest (default; mann-whitney u-test), ttest.
  --fishers-method-offset FISHERS_METHOD_OFFSET
                        Offset up and downstream over which to compute
                        combined p-values using Fisher's method. Default: 2.
  --minimum-test-reads MINIMUM_TEST_READS
                        Number of reads required from both samples to test for
                        significant difference in signal level. Default: 5

Miscellaneous Arguments:
  --statistics-filename STATISTICS_FILENAME
                        Filename to save/load base by base signal difference
                        statistics. If file exists it will try to be loaded,
                        if it does not exist it will be created to save
                        statistics. Default: Don't save/load.
  --quiet, -q           Don't print status information.
  --help, -h            Print this help message and exit
```


## nanoraw_Additional

### Tool Description
nanoraw: error: invalid choice: 'Additional' (choose from 'genome_resquiggle', 'plot_max_coverage', 'plot_genome_location', 'plot_motif_centered', 'plot_max_difference', 'plot_most_significant', 'plot_motif_with_stats', 'plot_correction', 'plot_multi_correction', 'cluster_most_significant', 'plot_kmer', 'write_most_significant_fasta', 'write_wiggles')

### Metadata
- **Docker Image**: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
- **Homepage**: https://github.com/marcus1487/nanoraw
- **Package**: https://anaconda.org/channels/bioconda/packages/nanoraw/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanoraw [-h] [-v]
               {genome_resquiggle,plot_max_coverage,plot_genome_location,plot_motif_centered,plot_max_difference,plot_most_significant,plot_motif_with_stats,plot_correction,plot_multi_correction,cluster_most_significant,plot_kmer,write_most_significant_fasta,write_wiggles}
               ...
nanoraw: error: invalid choice: 'Additional' (choose from 'genome_resquiggle', 'plot_max_coverage', 'plot_genome_location', 'plot_motif_centered', 'plot_max_difference', 'plot_most_significant', 'plot_motif_with_stats', 'plot_correction', 'plot_multi_correction', 'cluster_most_significant', 'plot_kmer', 'write_most_significant_fasta', 'write_wiggles')
```

