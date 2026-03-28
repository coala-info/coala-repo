# finaletoolkit CWL Generation Report

## finaletoolkit_coverage

### Tool Description
Calculates fragmentation coverage over intervals defined in a BED file based on alignment data from a BAM/CRAM/Fragment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Total Downloads**: 361
- **Last updated**: 2025-09-08
- **GitHub**: https://github.com/epifluidlab/FinaleToolkit
- **Stars**: N/A
### Original Help Text
```text
usage: finaletoolkit coverage [-h] [-o OUTPUT_FILE] [-n] [-s SCALE_FACTOR]
                              [-min MIN_LENGTH] [-max MAX_LENGTH]
                              [-p {midpoint,any}] [-q QUALITY_THRESHOLD]
                              [-w WORKERS] [-v]
                              input_file interval_file

Calculates fragmentation coverage over intervals defined in a BED file based
on alignment data from a BAM/CRAM/Fragment file.

positional arguments:
  input_file            Path to a BAM/CRAM/Fragment file containing fragment
                        data.
  interval_file         Path to a BED file containing intervals to calculate
                        coverage over.

options:
  -h, --help            show this help message and exit
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        A BED file containing coverage values over the
                        intervals specified in interval file.
  -n, --normalize       If flag set, multiplies by user inputed scale factor
                        if given and normalizes output by total coverage. May
                        lead to longer execution time for high-throughput
                        data.
  -s SCALE_FACTOR, --scale-factor SCALE_FACTOR
                        Scale factor for coverage values. Default is 1.
  -min MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum length for a fragment to be included in
                        coverage.
  -max MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum length for a fragment to be included in
                        coverage.
  -p {midpoint,any}, --intersect-policy {midpoint,any}
                        Specifies what policy is used to include fragments in
                        the given interval. See User Guide for more
                        information.
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold.
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_frag-length-bins

### Tool Description
Retrieves fragment lengths grouped in bins given a BAM/CRAM/Fragment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-frag-length-bins [-h] [-c CONTIG] [-S START] [-E STOP]
                                      [-min MIN_LENGTH] [-max MAX_LENGTH]
                                      [-p {midpoint,any}]
                                      [--bin-size BIN_SIZE] [-o OUTPUT_FILE]
                                      [-stats] [-sf SHORT_FRACTION]
                                      [--histogram-path HISTOGRAM_PATH]
                                      [-q QUALITY_THRESHOLD] [-v]
                                      input_file

Retrieves fragment lengths grouped in bins given a BAM/CRAM/Fragment file.

positional arguments:
  input_file            Path to a BAM/CRAM/Fragment file containing fragment
                        data.

options:
  -h, --help            show this help message and exit
  -c CONTIG, --contig CONTIG
                        Specify the contig or chromosome to select fragments
                        from. (Required if using --start or --stop.)
  -S START, --start START
                        Specify the 0-based left-most coordinate of the
                        interval to select fragments from. (Must also specify
                        --contig.)
  -E STOP, --stop STOP  Specify the 1-based right-most coordinate of the
                        interval to select fragments from. (Must also specify
                        --contig.)
  -min MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum length for a fragment to be included in
                        fragment length.
  -max MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum length for a fragment to be included in
                        fragment length.
  -p {midpoint,any}, --intersect-policy {midpoint,any}
                        Specifies what policy is used to include fragments in
                        the given interval. See User Guide for more
                        information.
  --bin-size BIN_SIZE   Specify the size of the bins to group fragment lengths
                        into.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        A .TSV file containing containing fragment lengths
                        binned according to the specified bin size.
  -stats, --summary-stats
                        Include summary statistics at the bottom of the output
                        tsv as comment lines (e.g. #max: 100)
  -sf SHORT_FRACTION, --short-fraction SHORT_FRACTION
                        When specified, a short fraction is included in
                        summary statistics.
  --histogram-path HISTOGRAM_PATH
                        Path to store histogram if specified.
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_frag-length-intervals

### Tool Description
Retrieves fragment length summary statistics over intervals defined in a BED file based on alignment data from a BAM/CRAM/Fragment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit frag-length-intervals [-h] [-min MIN_LENGTH]
                                           [-max MAX_LENGTH]
                                           [-p {midpoint,any}]
                                           [-o OUTPUT_FILE] [-s SHORT_READS]
                                           [-q QUALITY_THRESHOLD] [-w WORKERS]
                                           [-v]
                                           input_file interval_file

Retrieves fragment length summary statistics over intervals defined in a BED
file based on alignment data from a BAM/CRAM/Fragment file.

positional arguments:
  input_file            Path to a BAM/CRAM/Fragment file containing fragment
                        data.
  interval_file         Path to a BED file containing intervals to retrieve
                        fragment length summary statistics over.

options:
  -h, --help            show this help message and exit
  -min MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum length for a fragment to be included in
                        fragment length.
  -max MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum length for a fragment to be included in
                        fragment length.
  -p {midpoint,any}, --intersect-policy {midpoint,any}
                        Specifies what policy is used to include fragments in
                        the given interval. See User Guide for more
                        information.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        A BED file containing fragment length summary
                        statistics (mean, median, st. dev, min, max) over the
                        intervals specified in the interval file.
  -s SHORT_READS, --short-reads SHORT_READS
                        Threshold for short read fraction. Default is 150.
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold.
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_cleavage-profile

### Tool Description
Calculates cleavage proportion over intervals defined in a BED file based on alignment data from a BAM/CRAM/Fragment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-cleavage-profile [-h] [-o OUTPUT_FILE] [-min MIN_LENGTH]
                                      [-max MAX_LENGTH] [-lo MIN_LENGTH]
                                      [-hi MAX_LENGTH] [-q QUALITY_THRESHOLD]
                                      [-l LEFT] [-r RIGHT] [-w WORKERS] [-v]
                                      input_file interval_file chrom_sizes

Calculates cleavage proportion over intervals defined in a BED file based on
alignment data from a BAM/CRAM/Fragment file.

positional arguments:
  input_file            Path to a BAM/CRAM/Fragment file containing fragment
                        data.
  interval_file         Path to a BED file containing intervals to calculates
                        cleavage proportion over.
  chrom_sizes           A .chrom.sizes file containing chromosome names and
                        sizes.

options:
  -h, --help            show this help message and exit
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        A bigWig file containing the cleavage proportion
                        results over the intervals specified in interval file.
  -min MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum length for a fragment to be included.
  -max MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum length for a fragment to be included.
  -lo MIN_LENGTH, --fraction_low MIN_LENGTH
                        Minimum length for a fragment to be included in
                        cleavage proportion calculation. Deprecated. Use
                        --min-length instead.
  -hi MAX_LENGTH, --fraction-high MAX_LENGTH
                        Maximum length for a fragment to be included in
                        cleavage proportion calculation. Deprecated. Use
                        --max-length instead.
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold.
  -l LEFT, --left LEFT  Number of base pairs to subtract from start coordinate
                        to create interval. Useful when dealing with BED files
                        with only CpG coordinates. Default is 0.
  -r RIGHT, --right RIGHT
                        Number of base pairs to add to stop coordinate to
                        create interval. Useful when dealing with BED files
                        with only CpG coordinates. Default is 0.
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_wps

### Tool Description
Calculates Windowed Protection Score (WPS) over intervals defined in a BED file based on alignment data from a BAM/CRAM/Fragment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-wps [-h] [-c CHROM_SIZES] [-o OUTPUT_FILE]
                         [-i INTERVAL_SIZE] [-W WINDOW_SIZE] [-min MIN_LENGTH]
                         [-max MAX_LENGTH] [-lo MIN_LENGTH] [-hi MAX_LENGTH]
                         [-q QUALITY_THRESHOLD] [-w WORKERS] [-v]
                         input_file site_bed

Calculates Windowed Protection Score (WPS) over intervals defined in a BED
file based on alignment data from a BAM/CRAM/Fragment file.

positional arguments:
  input_file            Path to a BAM/CRAM/Fragment file containing fragment
                        data.
  site_bed              Path to a BED file containing sites to calculate WPS
                        over. The intervals in this BED file should be sorted,
                        first by `contig` then `start`.

options:
  -h, --help            show this help message and exit
  -c CHROM_SIZES, --chrom-sizes CHROM_SIZES
                        A .chrom.sizes file containing chromosome names and
                        sizes.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        A bigWig file containing the WPS results over the
                        intervals specified in interval file.
  -i INTERVAL_SIZE, --interval-size INTERVAL_SIZE
                        Size in bp of the intervals to calculate WPS over.
                        Thesenew intervals are centered over those specified
                        in the site_bed.Default is 5000
  -W WINDOW_SIZE, --window-size WINDOW_SIZE
                        Size of the sliding window used to calculate WPS
                        scores. Default is 120
  -min MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum length for a fragment to be included. Default
                        is 120, corresponding to L-WPS.
  -max MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum length for a fragment to be included. Default
                        is 180, corresponding to L-WPS.
  -lo MIN_LENGTH, --fraction_low MIN_LENGTH
                        Minimum length for a fragment to be included in WPS
                        calculation. Deprecated. Use --min-length instead.
  -hi MAX_LENGTH, --fraction_high MAX_LENGTH
                        Maximum length for a fragment to be included in WPS
                        calculation. Deprecated. Use --max-length instead.
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold. Default is 30
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_adjust-wps

### Tool Description
Adjusts raw Windowed Protection Score (WPS) by applying a median filter and Savitsky-Golay filter.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-adjust-wps [-h] [-o OUTPUT_FILE] [-i INTERVAL_SIZE]
                                [-m MEDIAN_WINDOW_SIZE]
                                [-s SAVGOL_WINDOW_SIZE] [-p SAVGOL_POLY_DEG]
                                [-S] [-w WORKERS] [--mean] [--subtract-edges]
                                [--edge-size EDGE_SIZE] [-v]
                                input_file interval_file chrom_sizes

Adjusts raw Windowed Protection Score (WPS) by applying a median filter and
Savitsky-Golay filter.

positional arguments:
  input_file            A bigWig file containing the WPS results over the
                        intervals specified in interval file.
  interval_file         Path to a BED file containing intervals to WPS was
                        calculated over.
  chrom_sizes           A .chrom.sizes file containing chromosome names and
                        sizes.

options:
  -h, --help            show this help message and exit
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        A bigWig file containing the adjusted WPS results over
                        the intervals specified in interval file.
  -i INTERVAL_SIZE, --interval_size INTERVAL_SIZE
                        Size in bp of each interval in the interval file.
  -m MEDIAN_WINDOW_SIZE, --median-window-size MEDIAN_WINDOW_SIZE
                        Size of the median filter or mean filter window used
                        to adjust WPS scores.
  -s SAVGOL_WINDOW_SIZE, --savgol-window-size SAVGOL_WINDOW_SIZE
                        Size of the Savitsky-Golay filter window used to
                        adjust WPS scores.
  -p SAVGOL_POLY_DEG, --savgol-poly-deg SAVGOL_POLY_DEG
                        Degree polynomial for Savitsky-Golay filter.
  -S, --exclude-savgol  Do not perform Savitsky-Golay filteringscores.
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  --mean                A mean filter is used instead of median.
  --subtract-edges      Take the median of the first and last 500 bases in a
                        window and subtract from the whole interval.
  --edge-size EDGE_SIZE
                        size of the edge subtracted from ends of window when
                        --subtract-edges is set. Default is 500.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_delfi

### Tool Description
Calculates DELFI features over genome, returning information about (GC-corrected) short fragments, long fragments, DELFI ratio, and total fragments.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-delfi [-h] [-b BLACKLIST_FILE] [-g GAP_FILE]
                           [-o OUTPUT_FILE] [-G] [-R] [-M] [-s WINDOW_SIZE]
                           [-q QUALITY_THRESHOLD] [-w WORKERS] [-v]
                           input_file chrom_sizes reference_file bins_file

Calculates DELFI features over genome, returning information about (GC-
corrected) short fragments, long fragments, DELFI ratio, and total fragments.

positional arguments:
  input_file            Path to a BAM/CRAM/Fragment file containing fragment
                        data.
  chrom_sizes           Tab-delimited file containing (1) chrom name and (2)
                        integer length of chromosome in base pairs. Should
                        contain only autosomes ifYou want to replicate the
                        original scripts.
  reference_file        The .2bit file for the associate reference genome
                        sequence used during alignment.
  bins_file             A BED file containing bins over which to calculate
                        DELFI. To replicate Cristiano et al.'s methodology,
                        use 100kb bins over human autosomes.

options:
  -h, --help            show this help message and exit
  -b BLACKLIST_FILE, --blacklist-file BLACKLIST_FILE
                        BED file containing regions to ignore when calculating
                        DELFI.
  -g GAP_FILE, --gap-file GAP_FILE
                        BED4 format file containing columns for "chrom",
                        "start","stop", and "type". The "type" column should
                        denote whether the entry corresponds to a
                        "centromere", "telomere", or "short arm", and entries
                        not falling into these categories are ignored. This
                        information corresponds to the "gap" track for hg19 in
                        the UCSC Genome Browser.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        BED, bed.gz, TSV, or CSV file to write DELFI data to.
                        If "-", writes to stdout.
  -G, --no-gc-correct   Skip GC correction.
  -R, --keep-nocov      Skip removal two regions in hg19 with no coverage. Use
                        this flag when not using hg19 human reference genome.
  -M, --no-merge-bins   Keep 100kb bins and do not merge to 5Mb size.
  -s WINDOW_SIZE, --window-size WINDOW_SIZE
                        Specify size of large genomic intervals to merge
                        smaller 100kb intervals (or whatever the user
                        specified in bins_file) into. Defaultis 5000000
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold.
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_delfi-gc-correct

### Tool Description
Performs gc-correction on raw delfi data. This command is deprecated and will be removed in a future version of FinaleToolkit. The delfi command has gc correction on by default.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-delfi-gc-correct [-h] [-o OUTPUT_FILE]
                                      [--header-lines HEADER_LINES] [-v]
                                      input_file

Performs gc-correction on raw delfi data. This command is deprecated and will
be removed in a future version of FinaleToolkit. The delfi command has gc
correction on by default.

positional arguments:
  input_file            BED file containing raw DELFI data. Raw DELFI data
                        should only have columns for "contig", "start",
                        "stop", "arm", "short", "long", "gc", "num_frags",
                        "ratio".

options:
  -h, --help            show this help message and exit
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        BED to print GC-corrected DELFI fractions. If "-",
                        will write to stdout.
  --header-lines HEADER_LINES
                        Number of header lines in BED.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_end-motifs

### Tool Description
Measures frequency of k-mer 5' end motifs.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-end-motifs [-h] [-k K] [-min MIN_LENGTH]
                                [-max MAX_LENGTH] [-B] [-n] [-o OUTPUT_FILE]
                                [-q QUALITY_THRESHOLD] [-w WORKERS] [-v]
                                input_file refseq_file

Measures frequency of k-mer 5' end motifs.

positional arguments:
  input_file            Path to a BAM/CRAM/Fragment file containing fragment
                        data.
  refseq_file           The .2bit file for the associate reference genome
                        sequence used during alignment.

options:
  -h, --help            show this help message and exit
  -k K                  Length of k-mer.
  -min MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum length for a fragment to be included. Default
                        is 50
  -max MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum length for a fragment to be included.
  -B, --no-both-strands
                        Set flag to only consider one strand for end-motifs.
  -n, --negative-strand
                        Set flag in conjunction with -B to only consider 5'
                        end motifs on the negative strand.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        TSV to print k-mer frequencies. If "-", will write to
                        stdout.
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold.
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_interval-end-motifs

### Tool Description
Measures frequency of k-mer 5' end motifs in each region specified in a BED file and writes data into a table.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-interval-end-motifs [-h] [-k K] [-min MIN_LENGTH]
                                         [-max MAX_LENGTH] [-lo MIN_LENGTH]
                                         [-hi MAX_LENGTH] [-B] [-n]
                                         [-o OUTPUT_FILE]
                                         [-q QUALITY_THRESHOLD] [-w WORKERS]
                                         [-v]
                                         input_file refseq_file intervals

Measures frequency of k-mer 5' end motifs in each region specified in a BED
file and writes data into a table.

positional arguments:
  input_file            Path to a BAM/CRAM/Fragment file containing fragment
                        data.
  refseq_file           The .2bit file for the associate reference genome
                        sequence used during alignment.
  intervals             Path to a BED file containing intervals to retrieve
                        end motif frequencies over.

options:
  -h, --help            show this help message and exit
  -k K                  Length of k-mer.
  -min MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum length for a fragment to be included. Default
                        is 50.
  -max MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum length for a fragment to be included.
  -lo MIN_LENGTH, --fraction-low MIN_LENGTH
                        Deprecated alias for --min-length
  -hi MAX_LENGTH, --fraction-high MAX_LENGTH
                        Deprecated alias for --max-length
  -B, --single-strand   Set flag to only consider one strand for end-motifs.
                        By default, the positive strand is calculated, but
                        with the -n flag, the 5' end motifs of the negative
                        strand are considered instead.
  -n, --negative-strand
                        Set flag in conjunction with -B to only consider 5'
                        end motifs on the negative strand.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        Path to TSV or CSV file to write end motif frequencies
                        to.
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold.
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_breakpoint-motifs

### Tool Description
Measures frequency of k-mer breakpoint motifs.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-breakpoint-motifs [-h] [-k K] [-min MIN_LENGTH]
                                       [-max MAX_LENGTH] [-B] [-n]
                                       [-o OUTPUT_FILE] [-q QUALITY_THRESHOLD]
                                       [-w WORKERS] [-v]
                                       input_file refseq_file

Measures frequency of k-mer breakpoint motifs.

positional arguments:
  input_file            Path to a BAM/CRAM/Fragment file containing fragment
                        data.
  refseq_file           The .2bit file for the associate reference genome
                        sequence used during alignment.

options:
  -h, --help            show this help message and exit
  -k K                  Length of k-mer.
  -min MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum length for a fragment to be included. Default
                        is 50
  -max MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum length for a fragment to be included.
  -B, --no-both-strands
                        Set flag to only consider one strand for breakpoint-
                        motifs.
  -n, --negative-strand
                        Set flag in conjunction with -B to only consider 5'
                        breakpoint motifs on the negative strand.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        TSV to print k-mer frequencies. If "-", will write to
                        stdout.
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold.
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_interval-breakpoint-motifs

### Tool Description
Measures frequency of k-mer 5' breakpoint motifs in each region specified in a BED file and writes data into a table.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-interval-ebreakpointnd-motifs [-h] [-k K]
                                                   [-min MIN_LENGTH]
                                                   [-max MAX_LENGTH]
                                                   [-lo MIN_LENGTH]
                                                   [-hi MAX_LENGTH] [-B] [-n]
                                                   [-o OUTPUT_FILE]
                                                   [-q QUALITY_THRESHOLD]
                                                   [-w WORKERS] [-v]
                                                   input_file refseq_file
                                                   intervals

Measures frequency of k-mer 5' breakpoint motifs in each region specified in a
BED file and writes data into a table.

positional arguments:
  input_file            Path to a BAM/CRAM/Fragment file containing fragment
                        data.
  refseq_file           The .2bit file for the associate reference genome
                        sequence used during alignment.
  intervals             Path to a BED file containing intervals to retrieve
                        breakpoint motif frequencies over.

options:
  -h, --help            show this help message and exit
  -k K                  Length of k-mer.
  -min MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum length for a fragment to be included. Default
                        is 50.
  -max MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum length for a fragment to be included.
  -lo MIN_LENGTH, --fraction-low MIN_LENGTH
                        Deprecated alias for --min-length
  -hi MAX_LENGTH, --fraction-high MAX_LENGTH
                        Deprecated alias for --max-length
  -B, --single-strand   Set flag to only consider one strand for breakpoint-
                        motifs. By default, the positive strand is calculated,
                        but with the -n flag, the 5' breakpoint motifs of the
                        negative strand are considered instead.
  -n, --negative-strand
                        Set flag in conjunction with -B to only consider 5'
                        breakpoint motifs on the negative strand.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        Path to TSV or CSV file to write breakpoint motif
                        frequencies to.
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold.
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_mds

### Tool Description
Calculate the frequency of end motifs in fragments.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/finaletoolkit", line 10, in <module>
    sys.exit(main_cli())
             ^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/finaletoolkit/cli/main_cli.py", line 1193, in main_cli
    function(**funcargs)
  File "/usr/local/lib/python3.12/site-packages/finaletoolkit/frag/_end_motifs.py", line 1052, in _cli_mds
    motifs = EndMotifFreqs.from_file(
             ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/finaletoolkit/frag/_end_motifs.py", line 156, in from_file
    line = lines[header].split(sep)
           ~~~~~^^^^^^^^
IndexError: list index out of range
```


## finaletoolkit_interval-mds

### Tool Description
Reads k-mer frequencies from a file and calculates a motif diversity score (MDS) for each interval using normalized Shannon entropy as described by Jiang et al (2020).

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-interval-mds [-h] [-s SEP] [--header HEADER]
                                  [file_path] file_out

Reads k-mer frequencies from a file and calculates a motif diversity score
(MDS) for each interval using normalized Shannon entropy as described by Jiang
et al (2020).

positional arguments:
  file_path          Tab-delimited or similar file containing one column for
                     all k-mers a one column for frequency. Reads from stdin
                     by default.
  file_out           Path to the output BED/BEDGraph file containing MDS for
                     each interval.

options:
  -h, --help         show this help message and exit
  -s SEP, --sep SEP  Separator used in tabular file.
  --header HEADER    Number of header rows to ignore. Default is 0
```


## finaletoolkit_filter-file

### Tool Description
Filters a BED/BAM/CRAM file so that all reads/intervals, when applicable,are in mapped pairs, exceed a certain MAPQ, are not flagged for quality, are read1, are not secondary or supplementary alignments, are within/excluding specified intervals, and are on the same reference sequence as the mate.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-filter-file [-h] [-W WHITELIST_FILE] [-B BLACKLIST_FILE]
                                 [-o OUTPUT_FILE] [-q QUALITY_THRESHOLD]
                                 [-min MIN_LENGTH] [-max MAX_LENGTH]
                                 [-p {midpoint,any}] [-lo MIN_LENGTH]
                                 [-hi MAX_LENGTH] [-w WORKERS] [-v]
                                 input_file

Filters a BED/BAM/CRAM file so that all reads/intervals, when applicable,are
in mapped pairs, exceed a certain MAPQ, are not flagged for quality, are
read1, are not secondary or supplementary alignments, are within/excluding
specified intervals, and are on the same reference sequence as the mate.

positional arguments:
  input_file            Path to BAM file.

options:
  -h, --help            show this help message and exit
  -W WHITELIST_FILE, --whitelist-file WHITELIST_FILE
                        Only output alignments overlapping the intervals in
                        this BED file will be included.
  -B BLACKLIST_FILE, --blacklist-file BLACKLIST_FILE
                        Only output alignments outside of the intervals in
                        this BED file will be included.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        Output BED/BAM/CRAM file path.
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        Minimum mapping quality threshold.
  -min MIN_LENGTH, --min-length MIN_LENGTH
                        Minimum length for a fragment to be included.
  -max MAX_LENGTH, --max-length MAX_LENGTH
                        Maximum length for a fragment to be included.
  -p {midpoint,any}, --intersect-policy {midpoint,any}
                        Specifies what policy is used to include/exclude
                        fragments in the given interval. See User Guide for
                        more information.
  -lo MIN_LENGTH, --fraction-low MIN_LENGTH
                        Deprecated alias for --min-length
  -hi MAX_LENGTH, --fraction-high MAX_LENGTH
                        Deprecated alias for --max-length
  -w WORKERS, --workers WORKERS
                        Number of worker processes.
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_agg-bw

### Tool Description
Aggregates a bigWig signal over constant-length intervals defined in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-agg-wps [-h] [-o OUTPUT_FILE] [-m MEDIAN_WINDOW_SIZE]
                             [-a] [-v]
                             input_file interval_file

Aggregates a bigWig signal over constant-length intervals defined in a BED
file.

positional arguments:
  input_file            A bigWig file containing signals over the intervals
                        specified in interval file.
  interval_file         Path to a BED file containing intervals over which
                        signals were calculated over.

options:
  -h, --help            show this help message and exit
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        A wiggle file containing the aggregate signal over the
                        intervals specified in interval file.
  -m MEDIAN_WINDOW_SIZE, --median-window-size MEDIAN_WINDOW_SIZE
                        Size of the median filter window used to aggregate
                        scores. Set to 120 if aggregating WPS signals.
  -a, --mean            use mean instead
  -v, --verbose         Enable verbose mode to display detailed processing
                        information.
```


## finaletoolkit_gap-bed

### Tool Description
Creates a BED4 file containing centromeres, telomeres, and short-arm
intervals, similar to the gaps annotation track for hg19 found on the UCSC
Genome Browser (Kent et al 2002). Currently only supports hg19, b37,
human_g1k_v37, hg38, and GRCh38

### Metadata
- **Docker Image**: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
- **Homepage**: https://github.com/epifluidlab/FinaleToolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/finaletoolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: finaletoolkit-gap-bed [-h]
                             {hg19,b37,human_g1k_v37,hg38,GRCh38} output_file

Creates a BED4 file containing centromeres, telomeres, and short-arm
intervals, similar to the gaps annotation track for hg19 found on the UCSC
Genome Browser (Kent et al 2002). Currently only supports hg19, b37,
human_g1k_v37, hg38, and GRCh38

positional arguments:
  {hg19,b37,human_g1k_v37,hg38,GRCh38}
                        Reference genome to provide gaps for.
  output_file           Path to write BED file to. If "-" used, writes to
                        stdout.

options:
  -h, --help            show this help message and exit

Gap is used liberally in this command, and in the case hg38/GRCh38, may refer
to regions where there no longer are gaps in the reference sequence.
```


## Metadata
- **Skill**: generated
