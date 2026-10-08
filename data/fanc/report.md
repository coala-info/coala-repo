# fanc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fanc_aggregate | PASS |  |
| fanc_boundaries | PASS |  |
| fanc_cis_trans | PASS |  |
| fanc_compare | PASS |  |
| fanc_compartments | PASS |  |
| fanc_directionality | PASS |  |
| fanc_downsample | PASS |  |
| fanc_dump | PASS |  |
| fanc_expected | PASS |  |
| fanc_fancplot | PASS |  |
| fanc_fragments | PASS |  |
| fanc_from_juicer | Failed | image problem: java and juicer_tools are not in the image, so the Juicer import cannot run. |
| fanc_from_txt | PASS |  |
| fanc_hic | PASS |  |
| fanc_insulation | PASS |  |
| fanc_loops | Not completed | runs on the repo test data but finds 14 of the 15 loops in the repo's expected BEDPE, so the output could not be confirmed |
| fanc_map | Failed | image problem: bowtie2 and bwa are not in the image, so fanc map stops with 'Cannot find bowtie2'. |
| fanc_overlap_peaks | PASS |  |
| fanc_pairs | PASS | Pair filters (-i/-o/-l/-p) crash with 'File type not recognised' when given in the same run as SAM input; they work in a second in-place run on the Pairs file. |
| fanc_pca | PASS |  |
| fanc_sort_sam | PASS |  |
| fanc_stats | PASS |  |
| fanc_subset | PASS |  |
| fanc_to_cooler | PASS |  |
| fanc_to_juicer | Failed | image problem: java and juicer_tools are not in the image, so the Juicer conversion cannot run. |
| fanc_upgrade | Failed | tool bug: fanc upgrade reads the class ID as bytes (b'HIC') and stops with 'No suitable upgrade method' on the legacy Hic test file from the fanc repo. |
| fanc_write_config | PASS |  |

## fanc_aggregate

### Tool Description
Make aggregate plots and matrices of a Hi-C matrix over regions (TADs, loops, ...).

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc aggregate [-h] [-m MATRIX_FILE] [-p PLOT_FILE] [--tads]
                      [--tads-imakaev] [--loops]
                      [--loop-strength LOOP_STRENGTH_FILE]
                      [--tad-strength TAD_STRENGTH_FILE] [-w WINDOW]
                      [--pixels PIXELS] [-v REGION_VIEWPOINT]
                      [-b BOUNDARY_MODE] [-i INTERPOLATION] [-r RELATIVE]
                      [-a ABSOLUTE] [-e] [-l] [--rescale]
                      [--colormap COLORMAP] [--vmin VMIN] [--vmax VMAX] [-tmp]
                      [-C] [--keep-submatrices] [-s] [--labels LABELS]
                      [--label-locations LABEL_LOCATIONS]
                      input [regions] [output]

Make aggregate plots with FAN-C

positional arguments:
  input                 FAN-C matrix file (e.g. Hic)
  regions               File with regions (BED, GFF, Tabix, ...) or region
                        pairs (BEDPE)
  output                Output AggregateMatrix file for further processing.See
                        -p and -m option for aggregate plot and matrix,
                        respectively.

optional arguments:
  -h, --help            show this help message and exit
  -m MATRIX_FILE, --save-matrix MATRIX_FILE
                        Path to save aggregate matrix (numpy txt format)
  -p PLOT_FILE, --save-plot PLOT_FILE
                        Path to save aggregate plot (PDF)
  --tads                Use presets for aggregate TADs: --relative 1.0
                        --expected --log --vmin -1 --vmax 1
  --tads-imakaev        Use presets for aggregate TADs: --relative 1.0
                        --expected--rescale
  --loops               Use presets for aggregate loops: --pixels 16 -l
  --loop-strength LOOP_STRENGTH_FILE
                        Calculate loop strengths and save to file. Only works
                        when providing BEDPE file, and Hi-C matrix.
  --tad-strength TAD_STRENGTH_FILE
                        Calculate tad strengths and save to file. Only works
                        with --tads preset
  -w WINDOW, --window WINDOW
                        Width of the region window used for aggregation. If
                        set, will only use the center position from the input
                        regions and extract a submatrix of width -w around
                        this region.
  --pixels PIXELS       Width of the output image in pixels. Default: 90
  -v REGION_VIEWPOINT, --region-viewpoint REGION_VIEWPOINT
                        Viewpoint relative to region when using -w. By
                        default, this measures the window from the region
                        center. You can change this to other locations within
                        each region using this parameter. Possible
                        values:start, end, five_prime, three_prime, center
  -b BOUNDARY_MODE, --boundary-mode BOUNDARY_MODE
                        Points outside the boundaries of the input are filled
                        according to the given mode. Options areconstant,
                        edge, symmetrix, reflect, and warp.Default: reflect.
  -i INTERPOLATION, --interpolation INTERPOLATION
                        Type of interpolation to use for resizing. 0: Nearest-
                        neighbor (default), 1: Bi-linear, 2: Bi-quadratic, 3:
                        Bi-cubic, 4: Bi-quartic, 5: Bi-quintic
  -r RELATIVE, --relative RELATIVE
                        Relative extension of each region as fraction of
                        region length (l). Final region in the image will be:
                        <start of region - e*l> to <end of region + e*l>.
                        Default: 1.0 (results in 3 times region size image).
                        Additive with "-a" parameter!
  -a ABSOLUTE, --absolute ABSOLUTE
                        Extension (e) of each region in base pairs. Final
                        region in the image will be: <start of TAD - e> to
                        <end of TAD + e>. Default: 0 (no extension). Additive
                        with "-r" parameter!
  -e, --expected-norm   Normalize matrix to expected values
  -l, --log             log2-transform normalized matrices. Only used in
                        conjunction with "-e".
  --rescale             Rescale normalized contact matrices using an a=-0.25
                        power law. Only used in conjunction with "-e".
  --colormap COLORMAP   Matplotlib colormap to use for matrix
  --vmin VMIN           Minimum saturation value in image
  --vmax VMAX           Maximum saturation value in image
  -tmp, --work-in-tmp   Work in temporary directory
  -C, --no-cache        Do not cache chromosome matrices. Slower, but saves a
                        lot of memory. Use this if you are having trouble with
                        memory usage.
  --keep-submatrices    Save all the individual matrices that make up the
                        aggregate matrix in the output object. Useful for
                        debugging and downstream processing. Potentially uses
                        a lot of memory and/or disk space.
  -s, --orient-by-strand
                        Flip submatrix if region is on the negative strand.
  --labels LABELS       Labels for the left, center, and right edge of the
                        matrix (comma-separated).
  --label-locations LABEL_LOCATIONS
                        Relative location of ticks on bottom and left of
                        aggregate plot (comma-separated). Ranges from 0
                        (left/bottom) to 1.0 (right/top). Default: 0,0.5,1.0
```

## fanc_boundaries

### Tool Description
Determine domain boundaries from insulation scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc boundaries [-h] [-w WINDOW] [-d DELTA] [-s MIN_SCORE] [-x] [-l]
                       [-m]
                       input output

Determine domain boundaries

positional arguments:
  input                 Input InsulationScores or regions file
  output                Path for boundary BED file. When specifying multiple
                        window sizes or if input file has multiple scores in
                        it, this forms the output file prefix and will be
                        appended by '<window size>.bed'

optional arguments:
  -h, --help            show this help message and exit
  -w WINDOW, --window-sizes WINDOW
                        Insulation index window size to calculate boundaries
                        on. Separate multiple window sizes with comma, e.g.
                        1mb,500kb,100kb
  -d DELTA, --delta DELTA
                        Window size for calculating the delta vector (in
                        bins). Calculation takes into account d bins upstream
                        and d bins downstream for a total window size of 2*d +
                        1 bins. Default 3.
  -s MIN_SCORE, --min-score MIN_SCORE
                        Report only peaks where the two surrounding extrema of
                        the delta vector have at least this difference in
                        height. Default: no threshold.
  -x, --sub-bin-precision
                        Report boundary positions with sub-bin precision. This
                        works because the minimum or the the insulation score
                        track can be determined with sub-bin precision.
                        Default: False
  -l, --log             log-transform index values before boundary calling.
  -m, --maxima          Call maxima of the insulation score instead of minima.
```

## fanc_cis_trans

### Tool Description
Calculate the cis/trans ratio of Hi-C objects.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc cis_trans [-h] [-o OUTPUT] [-n] hic [hic ...]

Calculate cis/trans ratio of this Hi-C object.

positional arguments:
  hic                   Hic object(s) for cis/trans calculation.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output file.
  -n, --norm            Normalise ratio to the prior ratio of possible cis /
                        trans contacts.
```

## fanc_compare

### Tool Description
Create pairwise comparisons of Hi-C matrices or region-based scores (fold-change or difference).

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc compare [-h] [-c COMPARISON] [-o OUTPUT_FORMAT] [-S] [-l]
                    [--log-matrix] [-Z] [-I] [-e] [-u] [-tmp]
                    input input output

Create pairwise comparisons of Hi-C comparison maps

positional arguments:
  input                 Input matrix (e.g. Hic) files.
  output                Output ComparisonMatrix file.

optional arguments:
  -h, --help            show this help message and exit
  -c COMPARISON, --comparison COMPARISON
                        Type of comparison. Default: fold-change, other
                        options are: difference
  -o OUTPUT_FORMAT, --output-format OUTPUT_FORMAT
                        Output format for region-based comparisons. Only
                        relevant when using BED, GFF, or another region-based
                        format as input.
  -S, --no-scale        Do not scale input matrices to the same number of
                        valid pairs
  -l, --log             Log2-convert comparison values (AFTER the comparison)
  --log-matrix          Log2-convert matrices (BEFORE the comparison)
  -Z, --ignore-zero     Do not consider pixels where one matrix entry is zero
  -I, --ignore-infinite
                        Do not consider pixels where the comparison yields
                        "inf"
  -e, --observed-expected
                        O/E transform matrix values before comparison. Only
                        has an effect on matrix comparisons.
  -u, --uncorrected     Compare uncorrected matrices. Only has an effect on
                        matrix comparisons.
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_compartments

### Tool Description
Calculate the AB compartment matrix, eigenvector, AB domains and enrichment profile.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc compartments [-h] [-d DOMAINS] [-v EIGENVECTOR]
                         [-e ENRICHMENT_FILE] [-m MATRIX_FILE] [-g GENOME]
                         [-w] [-r REGION] [-i EIGENVECTOR_INDEX]
                         [-p PERCENTILES [PERCENTILES ...]] [-c COLORMAP]
                         [-s SYMMETRIC_AT] [--enrichment-min VMIN]
                         [--enrichment-max VMAX] [-G]
                         [-x EXCLUDE [EXCLUDE ...]]
                         [--compartment-strength COMPARTMENT_STRENGTH_FILE]
                         [-tmp] [-f] [--recalculate]
                         matrix [ab_compartments]

Calculate AB compartment matrix

positional arguments:
  matrix                Input matrix (Hi-C, fold-change map, ...) or existing
                        AB compartment matrix.
  ab_compartments       AB compartment matrix file.

optional arguments:
  -h, --help            show this help message and exit
  -d DOMAINS, --domains DOMAINS
                        Write AB domains to this file. AB domains are output
                        in BED format, and include the domains type (A/B) in
                        the name field, and the eigenvector values (averaged
                        across all bins in the domain) in the score field
  -v EIGENVECTOR, --eigenvector EIGENVECTOR
                        Write eigenvector values to this file.Output format is
                        BED, containing of each matrix bin. The score field
                        contains the eigenvector value of the bin.
  -e ENRICHMENT_FILE, --enrichment-profile ENRICHMENT_FILE
                        Plot AB enrichment profile to this file.
  -m MATRIX_FILE, --enrichment-matrix MATRIX_FILE
                        Path to save enrichment profile matrix (numpy txt
                        format)
  -g GENOME, --genome GENOME
                        Genome file. Used to "orient" the eigenvector values
                        (change sign) using the average GC content of domains.
                        Possible input files are FASTA, folder with FASTA,
                        comma-separated list of FASTA) used to change sign of
                        eigenvector based on GC content.
  -w, --whole-genome    Calculate AB compartments on the whole genome matrix,
                        instead of individual chromosomes. Only enable if you
                        are sure your use-case requires it. This is likely to
                        introduce artefacts when working with matrices that
                        have been normalised per-chromosome.
  -r REGION, --region REGION
                        Only outputs domains / eigenvector values in this
                        region. Only works with the -d and -e arguments.
                        Compartmentalisation is always calculated on the whole
                        genome.
  -i EIGENVECTOR_INDEX, --eigenvector-index EIGENVECTOR_INDEX
                        Eigenvector index. By default, the first eigenvector
                        is output for eigenvector and domain analysis.
                        Sometimes, it is useful to choose a higher
                        eigenvector. E.g. for second eigenvector,specify "-i
                        2".
  -p PERCENTILES [PERCENTILES ...], --enrichment-percentiles PERCENTILES [PERCENTILES ...]
                        Percentiles to use for calculation of the enrichment
                        profile. By default uses 20, 40, 60, 80, 100. The 0
                        percentile is included by default.
  -c COLORMAP, --enrichment-colormap COLORMAP
                        Matplotlib colormap to use for plotting the enrichment
                        profile.
  -s SYMMETRIC_AT, --enrichment-symmetric-at SYMMETRIC_AT
                        Make enrichment profile plot symmetric around this
                        value (e.g. use 0 to ensure that 0 is in the center of
                        the plot).
  --enrichment-min VMIN
                        Minimum saturation value in enrichment profile.
                        Default -1
  --enrichment-max VMAX
                        Maximum saturation value in enrichment profile.
                        Default: 1
  -G, --only-gc         Only use GC content for enrichment profile
                        calculation, not the correlation matrix eigenvector.
  -x EXCLUDE [EXCLUDE ...], --enrichment-exclude EXCLUDE [EXCLUDE ...]
                        Chromosome names to exclude from enrichment profile
                        calculation
  --compartment-strength COMPARTMENT_STRENGTH_FILE
                        File for saving the compartment strength.
  -tmp, --work-in-tmp   Work in temporary directory
  -f, --force           Force overwriting of output files.
  --recalculate         Force recalculation of eigenvector even if a vector
                        with the same parameters has previously been
                        calculated.
```

## fanc_directionality

### Tool Description
Calculate directionality index for a Hic object.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc directionality [-h] [-o OUTPUT_FORMAT]
                           [-w WINDOW_SIZES [WINDOW_SIZES ...]] [-r REGION]
                           [-tmp]
                           input [output]

Calculate directionality index for Hic object

positional arguments:
  input                 Input matrix (Hi-C, fold-change map, ...)
  output                Output file. Format will be determined by "-o". By
                        default, this is a FAN-C DirectionalityIndexes object,
                        for maximum compatibility with other analyses. If you
                        choose a text-based output format (BED, GFF, BigWig),
                        this parameter will be the file prefix, and the window
                        size will be appended.If not specified and output
                        format is one of bed, gff, or bigwig, the input file
                        name forms the output file prefix.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_FORMAT, --output-format OUTPUT_FORMAT
                        Format of the output file. By default, this is a FAN-C
                        DirectionalityIndex object, for maximum compatibility
                        with other analyses. Other options are "bed",
                        "bigwig", and "gff"
  -w WINDOW_SIZES [WINDOW_SIZES ...], --window-sizes WINDOW_SIZES [WINDOW_SIZES ...]
                        Window sizes in base pairs. You can also use
                        abbreviated number format (i.e. 1.5M, 250kb, etc). If
                        not specified, will choose the window sizes based on
                        the matrix resolution r when calculating scores.
                        Specifically: r*3, r*5, r*7, r*10, and r*15
  -r REGION, --region REGION
                        Region selector (<chr>:<start>-<end>) to only
                        calculate directionality index for this region.
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_downsample

### Tool Description
Downsample contacts from a Hic object (deprecated: fanc hic --downsample does the same).

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
*** fanc downsample is deprecated. Please use fanc hic --downsample instead! ***
usage: fanc downsample [-h] [-tmp] hic n output

Downsample contacts from a Hic object.

positional arguments:
  hic                  Hic object to be downsampled.
  n                    Sample size or reference Hi-C object. If sample size is
                       < 1,will be interpreted as a fraction of valid pairs.
  output               Downsampled Hic output.

optional arguments:
  -h, --help           show this help message and exit
  -tmp, --work-in-tmp  Work in temporary directory
```

## fanc_dump

### Tool Description
Dump a Hic file to txt file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc dump [-h] [-s SUBSET] [-S] [--only-intra] [-e] [-l] [-u] [-tmp]
                 hic [matrix] [regions]

Dump Hic file to txt file(s).

positional arguments:
  hic                   Hic file
  matrix                Output file for matrix entries. If not provided, will
                        write to stdout.
  regions               Output file for Hic regions. If not provided, will
                        write regions into matrix file.

optional arguments:
  -h, --help            show this help message and exit
  -s SUBSET, --subset SUBSET
                        Only output this matrix subset. Format:
                        <chr>[:<start>-<end>][--<chr>[:<start><end>]], e.g.:
                        "chr1--chr1" to extract only the chromosome 1
                        submatrix; "chr2:3400000-4200000" to extract contacts
                        of this region on chromosome 2 to all other regions in
                        the genome;
  -S, --no-sparse       Store full, square matrix instead of sparse format.
  --only-intra          Only dump intra-chromosomal data. Dumps everything by
                        default.
  -e, --observed-expected
                        O/E transform matrix values.
  -l, --log2            Log2-transform matrix values. Useful for O/E matrices
                        (-e option)
  -u, --uncorrected     Output uncorrected (not normalised) matrix values).
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_expected

### Tool Description
Calculate Hi-C expected values (distance decay).

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc expected [-h] [-p PLOT_FILE] [-l LABELS [LABELS ...]]
                     [-c CHROMOSOME] [-tmp] [--recalculate] [-N]
                     input [input ...] output

Calculate Hi-C expected values (distance decay)

positional arguments:
  input                 Input matrix (Hi-C, fold-change map, ...)
  output                Output expected contacts (tsv).

optional arguments:
  -h, --help            show this help message and exit
  -p PLOT_FILE, --plot PLOT_FILE
                        Output file for distance decay plot (pdf).
  -l LABELS [LABELS ...], --labels LABELS [LABELS ...]
                        Labels for input objects.
  -c CHROMOSOME, --chromosome CHROMOSOME
                        Specific chromosome to calculate expected values for.
  -tmp, --work-in-tmp   Work in temporary directory
  --recalculate         Recalculate expected values regardless of whether they
                        are already stored in the matrix object.
  -N, --no-norm         Calculate expected values on unnormalised data.
```

## fanc_fragments

### Tool Description
In-silico genome digestion: write restriction fragments (or fixed-size bins) of a genome in BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc fragments [-h] [-c CHROMOSOMES] input re_or_bin_size output

In-silico genome digestion

positional arguments:
  input                 Path to genome file (FASTA, folder with FASTA, hdf5
                        file), which will be used in conjunction with the type
                        of restriction enzyme to calculate fragments directly.
  re_or_bin_size        Restriction enzyme name or bin size to divide genome
                        into fragments. Restriction names can be any supported
                        by Biopython, which obtains data from REBASE
                        (http://rebase.neb.com/rebase/rebase.html). Use commas
                        to separate multiple restriction enzymes, e.g.
                        'HindIII,MboI'
  output                Output file with restriction fragments in BED format.

optional arguments:
  -h, --help            show this help message and exit
  -c CHROMOSOMES, --chromosomes CHROMOSOMES
                        Comma-separated list of chromosomes to include in
                        fragments BED file. Other chromosomes will be
                        excluded. The order of chromosomes will be as stated
                        in the list.
```

## fanc_from_juicer

### Tool Description
Import a Hi-C object from a Juicer (Aiden lab) .hic file. Needs juicer_tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc from_juicer [-h] [-c CHROMOSOMES [CHROMOSOMES ...]]
                        [--no-inter-chromosomal] [--juicer-norm JUICER_NORM]
                        [--juicer-tools-jar JUICER_TOOLS_JAR_PATH] [-tmp]
                        input genome resolution output

Import a Hi-C object from juicer (Aiden lab)

positional arguments:
  input                 Input .hic file, juicer format
  genome                Path to genome (FASTA, folder with FASTA, hdf5 file)
  resolution            Resolution in base pairs
  output                Output Hic file.

optional arguments:
  -h, --help            show this help message and exit
  -c CHROMOSOMES [CHROMOSOMES ...], --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        List of chromosomes to extract. Extracts all
                        chromosomes in genome by default.
  --no-inter-chromosomal
                        Do not extract inter-chromosomal matrices
  --juicer-norm JUICER_NORM
                        Juicer normalisation method. Default: NONE, see juicer
                        documentation for alternatives.
  --juicer-tools-jar JUICER_TOOLS_JAR_PATH
                        Path to juicer jar. You can also specify this in
                        fanc.conf
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_from_txt

### Tool Description
Import a Hi-C object from a sparse matrix txt format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc from-txt [-h] [-tmp] contacts regions output

Import a Hi-C object from a sparse matrix txt format

positional arguments:
  contacts             Contacts file in sparse matrix format, i.e. each row
                       should contain <bin1><tab><bin2><tab><weight>.
  regions              Path to file with genomic regions, for example in BED
                       format: <chromosome><tab><start><tab><end>. The BED can
                       optionally contain the bin index, as corresponding to
                       the index used in the contacts file.
  output               Output Hic file.

optional arguments:
  -h, --help           show this help message and exit
  -tmp, --work-in-tmp  Work in temporary directory
```

## fanc_hic

### Tool Description
Process, filter, and correct Hic files: turn FAN-C Pairs into a Hic object, merge, bin, filter and normalise it.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc hic [-h] [-b BIN_SIZE] [-l FILTER_LOW_COVERAGE]
                [-r FILTER_LOW_COVERAGE_RELATIVE] [-a] [-d FILTER_DIAGONAL]
                [--marginals-plot MARGINALS_PLOT] [--reset-filters]
                [--downsample DOWNSAMPLE] [--subset SUBSET] [-i] [-k] [-n]
                [-m NORM_METHOD] [-w] [-c] [--only-inter] [-s STATS]
                [--statistics-plot STATS_PLOT]
                [--chromosomes CHROMOSOMES [CHROMOSOMES ...]] [-f]
                [-t THREADS] [--deepcopy] [-tmp]
                input [input ...]

Process, filter, and correct Hic files

positional arguments:
  input                 IMPORTANT: The last positional argument will be the
                        output file, unless only a single Hic object is
                        provided. In that case, binning, filtering and
                        correcting will be done in place. Input files. If
                        these are FAN-C Pairs objects (see "fanc pairs"), they
                        will be turned into Hic objects. Hic objects (also the
                        ones converted from Pairs) will first be merged and
                        the merged object will be binned, filtered and
                        corrected as specified in the remaining parameters.

optional arguments:
  -h, --help            show this help message and exit
  -b BIN_SIZE, --bin-size BIN_SIZE
                        Bin size in base pairs. You can use human-readable
                        formats,such as 10k, or 1mb. If omitted, the command
                        will end after the merging step.
  -l FILTER_LOW_COVERAGE, --filter-low-coverage FILTER_LOW_COVERAGE
                        Filter bins with low coverage (lower than specified
                        absolute number of contacts)
  -r FILTER_LOW_COVERAGE_RELATIVE, --filter-low-coverage-relative FILTER_LOW_COVERAGE_RELATIVE
                        Filter bins using a relative low coverage threshold
                        (lower than the specified fraction of the median
                        contact count)
  -a, --low-coverage-auto
                        Filter bins with "low coverage" (under 10% of median
                        coverage for all non-zero bins)
  -d FILTER_DIAGONAL, --diagonal FILTER_DIAGONAL
                        Filter bins along the diagonal up to this specified
                        distance. Use 0 for only filtering the diagonal.
  --marginals-plot MARGINALS_PLOT
                        Plot Hi-C marginals to determine low coverage
                        thresholds.
  --reset-filters       Remove all filters from the Hic object.
  --downsample DOWNSAMPLE
                        Downsample a binned Hi-C object before filtering and
                        correcting. Sample size or reference Hi-C object. If
                        sample size is < 1,will be interpreted as a fraction
                        of valid pairs.
  --subset SUBSET       Comma-separated list of regions that will be used in
                        the output Hic object. All contacts between these
                        regions will be in the output object. For example,
                        "chr1,chr3" will result in a Hic object with all
                        regions in chromosomes 1 and 3, plus all contacts
                        within chromosome 1, all contacts within chromosome 3,
                        and all contacts between chromosome 1 and 3. "chr1"
                        will only contain regions and contactswithin
                        chromosome 1.
  -i, --ice-correct     DEPRECATED. Use ICE iterative correction on the binned
                        Hic matrix
  -k, --kr-correct      DEPRECATED. Use Knight-Ruiz matrix balancing to
                        correct the binned Hic matrix
  -n, --normalise       Normalise Hi-C matrix according to --norm-method
  -m NORM_METHOD, --norm-method NORM_METHOD
                        Normalisation method used for -n. Options are: KR
                        (default) = Knight-Ruiz matrix balancing (Fast,
                        accurate, but memory-intensive normalisation); ICE =
                        ICE matrix balancing (less accurate, but more memory-
                        efficient); VC = vanilla coverage (a single round of
                        ICE balancing);VC-SQRT = vanilla coverage square root
                        (reduces overcorrection compared to VC)
  -w, --whole-matrix    Correct the whole matrix at once, rather than
                        individual chromosomes.
  -c, --restore-coverage
                        Restore coverage to the original total number of
                        reads. Otherwise matrix entries will be contact
                        probabilities.
  --only-inter          Calculate bias vector only on inter-chromosomal
                        contacts. Ignores all intra-chromosomal contacts.
                        Always uses whole-matrix balancing, i.e. implicitly
                        sets -w
  -s STATS, --statistics STATS
                        Path for saving filter statistics
  --statistics-plot STATS_PLOT
                        Path for saving filter statistics plot (PDF)
  --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        Limit output Hic object to these chromosomes. Only
                        available in conjunction with "-b" option.
  -f, --force-overwrite
                        If the specified output file exists, it will be
                        overwritten without warning.
  -t THREADS, --threads THREADS
                        Number of threads (currently used for binning only)
  --deepcopy            Deep copy Hi-C file. Can be used
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_insulation

### Tool Description
Calculate insulation scores for a Hic object.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc insulation [-h] [-o OUTPUT_FORMAT]
                       [-w WINDOW_SIZES [WINDOW_SIZES ...]] [-r REGION] [-i]
                       [--offset OFFSET] [-L] [-N]
                       [--normalisation-window NORMALISATION_WINDOW] [-s] [-g]
                       [--trim-mean TRIM_MEAN] [-tmp]
                       input [output]

Calculate insulation scores for Hic object

positional arguments:
  input                 Input matrix (Hi-C, fold-change map, ...)
  output                Output file. Format will be determined by "-o". By
                        default, this is a FAN-C InsulationScores object, for
                        maximum compatibility with other analyses. If you
                        choose a text-based output format (BED, GFF, BigWig),
                        this parameter will be the file prefix, and the window
                        size will be appended.If not specified and output
                        format is one of bed, gff, or bigwig, the input file
                        name forms the output file prefix.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_FORMAT, --output-format OUTPUT_FORMAT
                        Format of the output file. By default, this is a FAN-C
                        InsulationScore object, for maximum compatibility with
                        other analyses. Other options are "bed", "bigwig", and
                        "gff"
  -w WINDOW_SIZES [WINDOW_SIZES ...], --window-sizes WINDOW_SIZES [WINDOW_SIZES ...]
                        Window sizes in base pairs. You can also use
                        abbreviated number format (i.e. 1.5M, 250kb, etc). If
                        not specified, will choose the window sizes based on
                        the matrix resolution r when calculating scores.
                        Specifically: r*3, r*5, r*7, r*10, and r*15
  -r REGION, --region REGION
                        Region selector (<chr>:<start>-<end>) to only
                        calculate II for this region.
  -i, --impute          Impute missing values in matrix. If set, missing
                        matrix values (where an entire Hi-C bin has 0
                        contacts) will be replaced by the expected value at
                        the given distance.
  --offset OFFSET       Window offset in base pairs from the diagonal.
  -L, --no-log          Do not log2-transform insulation index after
                        normalisation. Log-transformation roughly centers
                        values around 0, but if you need this to be exactly
                        centered, use the "--geom-mean" option.
  -N, --no-norm         Do not normalise index to insulation average Default
                        is whole chromosome normalisation - to normalise to
                        smaller regions, use --normalisation-window.
  --normalisation-window NORMALISATION_WINDOW
                        Size of the normalisation window (moving average) in
                        bins. Default: whole chromosome.
  -s, --subtract-mean   Subtract mean instead of dividing by it when "-n" is
                        enabled. You probably do not want this, unless you are
                        working with log-transformed matrices (e.g. fold-
                        change matrices)
  -g, --geom-mean       Use geometric mean for normalisation (rather than
                        arithmetic mean). Useful in conjunction with --log to
                        center the distribution at 0. This is very important
                        when comparing insulation scores, for example using
                        the "fanc compare" command!
  --trim-mean TRIM_MEAN
                        Use a trimmed mean for insulation index normalisation
                        with this cutoff (fraction of scores)
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_loops

### Tool Description
Call loops in a Hic object using the FAN-C implementation of HICCUPS (Rao, Huntley et al. 2014).

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc loops [-h] [-c CHROMOSOMES [CHROMOSOMES ...]] [-p PEAK_SIZE]
                  [-w WIDTH] [-t THREADS] [-d MIN_DIST]
                  [-m MAPPABILITY_GLOBAL_CUTOFF]
                  [--mappability-donut MAPPABILITY_DONUT_CUTOFF]
                  [--mappability-horizontal MAPPABILITY_HORIZONTAL_CUTOFF]
                  [--mappability-vertical MAPPABILITY_VERTICAL_CUTOFF]
                  [--mappability-lower-left MAPPABILITY_LOWER_LEFT_CUTOFF]
                  [-q FDR_GLOBAL_CUTOFF] [--fdr-donut FDR_DONUT_CUTOFF]
                  [--fdr-horizontal FDR_HORIZONTAL_CUTOFF]
                  [--fdr-vertical FDR_VERTICAL_CUTOFF]
                  [--fdr-lower-left FDR_LOWER_LEFT_CUTOFF]
                  [-e ENRICHMENT_GLOBAL_CUTOFF]
                  [--enrichment-donut ENRICHMENT_DONUT_CUTOFF]
                  [--enrichment-horizontal ENRICHMENT_HORIZONTAL_CUTOFF]
                  [--enrichment-vertical ENRICHMENT_VERTICAL_CUTOFF]
                  [--enrichment-lower-left ENRICHMENT_LOWER_LEFT_CUTOFF]
                  [-o OBSERVED] [--rh-filter] [--sge]
                  [--batch-size BATCH_SIZE] [-j]
                  [--merge-distance MERGE_DISTANCE] [-s] [--fdr-sum FDR_SUM]
                  [-b BEDPE] [-f] [-tmp]
                  input [output]

Call loops in a Hic object using FAN-C implementation of HICCUPS. See. Rao,
Huntley et al. (2014), Cell, for details.

positional arguments:
  input                 Input Hic file
  output                Output file. If input file is already a FAN-C
                        compatible loops object, filtering can also be done in
                        place.

optional arguments:
  -h, --help            show this help message and exit
  -c CHROMOSOMES [CHROMOSOMES ...], --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        Chromosomes to be investigated.
  -p PEAK_SIZE, --peak-size PEAK_SIZE
                        Size of the expected peak in pixels. If not set, will
                        be estimated to correspond to ~ 25kb.
  -w WIDTH, --neighborhood-width WIDTH
                        Width of the investigated area surrounding pixels. If
                        not set, will be estimated at p+3
  -t THREADS, --threads THREADS
                        Number of threads for parallel processing. Default: 1
                        - it is advised to set this as high as possible, since
                        loop calling is very computationally expensive!
  -d MIN_DIST, --min-distance MIN_DIST
                        Minimum distance in bins for two loci to be considered
                        as loops. Default: peak size. Set this value higher to
                        exclude loops close to the diagonal.
  -m MAPPABILITY_GLOBAL_CUTOFF, --mappability MAPPABILITY_GLOBAL_CUTOFF
                        Global mappability filter for all
                        neighborhoods.Minimum mappable fraction of a pixel
                        neighborhood to consider pixel as loop. Can be
                        overridden by filters for local neighborhoods.
  --mappability-donut MAPPABILITY_DONUT_CUTOFF
                        Mappability filter for donut neighborhood. Value
                        between 0 and 1.
  --mappability-horizontal MAPPABILITY_HORIZONTAL_CUTOFF
                        Mappability filter for horizontal neighborhood. Value
                        between 0 and 1.
  --mappability-vertical MAPPABILITY_VERTICAL_CUTOFF
                        Mappability filter for vertical neighborhood. Value
                        between 0 and 1.
  --mappability-lower-left MAPPABILITY_LOWER_LEFT_CUTOFF
                        Mappability filter for lower-left neighborhood. Value
                        between 0 and 1.
  -q FDR_GLOBAL_CUTOFF, --fdr FDR_GLOBAL_CUTOFF
                        Global FDR filter all neighborhoods. Individual
                        neighborhood filters can override this global setting.
                        Value between 0 and 1.
  --fdr-donut FDR_DONUT_CUTOFF
                        FDR filter for donut neighborhood. Value between 0 and
                        1.
  --fdr-horizontal FDR_HORIZONTAL_CUTOFF
                        FDR filter for horizontal neighborhood. Value between
                        0 and 1.
  --fdr-vertical FDR_VERTICAL_CUTOFF
                        FDR filter for vertical neighborhood. Value between 0
                        and 1.
  --fdr-lower-left FDR_LOWER_LEFT_CUTOFF
                        FDR filter for lower-left neighborhood. Value between
                        0 and 1.
  -e ENRICHMENT_GLOBAL_CUTOFF, --enrichment ENRICHMENT_GLOBAL_CUTOFF
                        Global observed/expected filter all neighborhoods.
                        Individual neighborhood filters can override this
                        global setting.
  --enrichment-donut ENRICHMENT_DONUT_CUTOFF
                        Observed/expected enrichment filter for donut
                        neighborhood.
  --enrichment-horizontal ENRICHMENT_HORIZONTAL_CUTOFF
                        Observed/expected enrichment filter for horizontal
                        neighborhood.
  --enrichment-vertical ENRICHMENT_VERTICAL_CUTOFF
                        Observed/expected enrichment filter for vertical
                        neighborhood.
  --enrichment-lower-left ENRICHMENT_LOWER_LEFT_CUTOFF
                        Observed/expected enrichment filter for lower-left
                        neighborhood.
  -o OBSERVED, --observed OBSERVED
                        Minimum observed value (integer, uncorrected).
                        Default: 1
  --rh-filter           Filter peaks as in Rao, Huntley et al. (2014), Cell.
                        It only retains peaks that are at least 2-fold
                        enriched over either the donut or lower-left
                        neighborhood, at least 1.5-fold enriched over the
                        horizontal and vertical neighborhoods, at least
                        1.75-fold enriched over both the donut and lower-left
                        neighborhood, and have an FDR <= 0.1 in every
                        neighborhood
  --sge                 Run on SGE cluster. This option is highly recommended
                        if you are running "fanc loops" on a Sun/Oracle Grid
                        Engine Cluster. The "-t" option specifies the number
                        of SGE slots if this flag is set. The main process
                        will then submit jobs to the grid using "gridmap" and
                        collect the results. (https://gridmap.readthedocs.io/)
  --batch-size BATCH_SIZE
                        Width of submatrix examined per process. Default: 200
  -j, --merge-pixels    Merge individual pixels into peaks after filtering.
  --merge-distance MERGE_DISTANCE
                        Maximum distance in base pairs at which to merge two
                        pixels. Default 20000
  -s, --remove-singlets
                        Remove isolated pixels after merging step.
  --fdr-sum FDR_SUM     FDR sum filter for merged peaks. Merged peaks where
                        the sum of donut FDR values of all constituent pixels
                        is larger than the specified cutoff are filtered.
  -b BEDPE, --bedpe BEDPE
                        BEDPE output file. When set, merged loops will be
                        written to this file after all filtering steps have
                        completed.
  -f, --force-overwrite
                        If the specified output file exists, it will be
                        overwritten without warning.
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_map

### Tool Description
Map reads in a FASTQ file to a reference genome (iterative mapping with Bowtie 2 or BWA).

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc map [-h] [-m MIN_SIZE] [-s STEP_SIZE] [--trim-front] [-t THREADS]
                [-q QUALITY] [-r RESTRICTION_ENZYME] [-k MAX_ALIGNMENTS] [-a]
                [-b BATCH_SIZE] [--fanc-parallel] [--split-fastq]
                [--memory-map] [--no-iterative] [-tmp]
                input [input ...] index output

Map reads in a FASTQ file to a reference genome.

positional arguments:
  input                 File name of the input FASTQ file (or gzipped FASTQ)
  index                 Bowtie 2 or BWA genome index base. Index type will be
                        determined automatically.
  output                Output file or folder. When providing multiple input
                        files, this must be the path to an output folder.

optional arguments:
  -h, --help            show this help message and exit
  -m MIN_SIZE, --min-size MIN_SIZE
                        Minimum length of read before extension. Default 25.
  -s STEP_SIZE, --step-size STEP_SIZE
                        Number of base pairs to extend at each round of
                        mapping. Default is 10.
  --trim-front          Trim reads from front instead of back.
  -t THREADS, --threads THREADS
                        Number of threads used for mapping. Default: 1
  -q QUALITY, --quality QUALITY
                        Mapping quality cutoff. Alignments with a quality
                        score lower than this will be sent to another mapping
                        iteration. Default: 3 (BWA), 30 (Bowtie2)
  -r RESTRICTION_ENZYME, --restriction-enzyme RESTRICTION_ENZYME
                        Name (case sensitive) of restriction enzyme used in
                        Hi-C experiment. Will be used to split reads by
                        predicted ligation junction before mapping. You can
                        omit this if you do not want to split your reads by
                        ligation junction. Restriction names can be any
                        supported by Biopython, which obtains data from REBASE
                        (http://rebase.neb.com/rebase/rebase.html). For
                        restriction enzyme cocktails, separate enzyme names
                        with ","
  -k MAX_ALIGNMENTS, --max-alignments MAX_ALIGNMENTS
                        Maximum number of alignments per read to be reported.
  -a, --all-alignments  Report all valid alignments of a read Warning: very
                        slow!.
  -b BATCH_SIZE, --batch-size BATCH_SIZE
                        Number of reads processed (mapped and merged) in one
                        go per worker. The default 100000 works well for large
                        indexes (e.g. human, mouse). Smaller indexes (e.g.
                        yeast) will finish individual bowtie2 processes very
                        quickly - set this number higher to spawn new
                        processes less frequently.
  --fanc-parallel       Use FAN-C parallelisation, which launches multiple
                        mapper jobs. This may be faster in some cases than
                        relying on the internal paralellisation of the mapper,
                        but has potentially high disk I/O and memory usage.
  --split-fastq         Split FASTQ file into 10M chunks before mapping.
                        Easier on tmp partitions.
  --memory-map          Map Bowtie2 index to memory. Enable if you you system
                        has enough memory to hold the entire Bowtie2 index.
  --no-iterative        Do not use iterative mapping strategy. (much faster,
                        less sensitive).
  -tmp, --work-in-tmp   Copy original file to temporary directory.Reduces
                        network I/O.
```

## fanc_overlap_peaks

### Tool Description
Overlap peaks (loops) from multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc overlap-peaks [-h] [-d DISTANCE] [-n [NAMES [NAMES ...]]] [-tmp]
                          input [input ...] output

Overlap peaks from multiple samples

positional arguments:
  input                 Input Peak files. Two or more.
  output                Output directory. Overlapped peaks and stats are
                        written there.

optional arguments:
  -h, --help            show this help message and exit
  -d DISTANCE, --distance DISTANCE
                        Maximum distance between peaks for merging them.
                        Default=3x bin size
  -n [NAMES [NAMES ...]], --names [NAMES [NAMES ...]]
                        Names for input Peak samples. Default: Use file names
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_pairs

### Tool Description
Process and filter read pairs: build a FAN-C Pairs object from two name-sorted SAM/BAM files, a HiC-Pro or 4DN pairs file, and filter it.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc pairs [-h] [-g GENOME] [-r RESTRICTION_ENZYME] [-m] [-u] [-us]
                  [-q QUALITY] [-c CONTAMINANT] [-i INWARD] [-o OUTWARD]
                  [--filter-ligation-auto] [-d REDIST] [-l] [-p DUP_THRESH]
                  [-s STATS] [--reset-filters] [--statistics-plot STATS_PLOT]
                  [--re-dist-plot RE_DIST_PLOT]
                  [--ligation-error-plot LIGATION_ERROR_PLOT] [-t THREADS]
                  [-b BATCH_SIZE] [-S] [-f] [--bwa] [-tmp]
                  input [input ...]

Process and filter read pairs

positional arguments:
  input                 IMPORTANT: The last positional argument will be the
                        output file, unless only a single Pairs object is
                        provided. In that case, filtering and correcting will
                        be done in place. Possible inputs are: two SAM/BAM
                        files (paired-end reads, sorted by read name) and an
                        output file; a HiC-Pro pairs file (format: name<tab>ch
                        r1<tab>pos1<tab>strand1<tab>chr2<tab>pos2<tab>strand2)
                        and an output file; a pairs file in 4D Nucleome format
                        (https://github.com/4dn-
                        dcic/pairix/blob/master/pairs_format_specification.md)
                        and an output file, or an existing fanc Pairs object.
                        In case of SAM/BAM, HiC-Pro, or 4D Nucleome you must
                        also provide the --genome argument, and if --genome is
                        not a file with restriction fragments (or Hi-C bins),
                        you must also provide the --restriction-enzyme
                        argument.

optional arguments:
  -h, --help            show this help message and exit
  -g GENOME, --genome GENOME
                        Path to region-based file (BED, GFF, ...) containing
                        the non-overlapping regions to be used for Hi-C
                        binning. Typically restriction-enzyme fragments.
                        Alternatively: Path to genome file (FASTA, folder with
                        FASTA, HDF5 file), which will be used in conjunction
                        with the type of restriction enzyme to calculate
                        fragments directly.
  -r RESTRICTION_ENZYME, --restriction_enzyme RESTRICTION_ENZYME
                        Name of the restriction enzyme used in the experiment,
                        e.g. HindIII, or MboI. Case-sensitive, only necessary
                        when --genome is provided as FASTA. Restriction names
                        can be any supported by Biopython, which obtains data
                        from REBASE
                        (http://rebase.neb.com/rebase/rebase.html). Separate
                        multiple restriction enzymes with ","
  -m, --filter-unmappable
                        Filter read pairs where one or both halves are
                        unmappable. Only applies to SAM/BAM input!
  -u, --filter-multimapping
                        Filter reads that map multiple times. If the other
                        mapping locations have a lower score than the best
                        one, the best read is kept. Only applies to SAM/BAM
                        input!
  -us, --filter-multimapping-strict
                        Strictly filter reads that map multiple times. Only
                        applies to SAM/BAM input!
  -q QUALITY, --filter-quality QUALITY
                        Cutoff for the minimum mapping quality of a read. For
                        numbers larger than 1, will filter on MAPQ. If a
                        number between 0 and 1 is provided, will filter on the
                        AS tag instead of mapping quality (only BWA). The
                        quality cutoff is then interpreted as the fraction of
                        bases that have to be matched for any given read. Only
                        applies to SAM/BAM input! Default: no mapping quality
                        filter.
  -c CONTAMINANT, --filter-contaminant CONTAMINANT
                        Filter contaminating reads from other organism. Path
                        to mapped SAM/BAM file. Will filter out reads with the
                        same name. Only applies to SAM/BAM input! Default: no
                        contaminant filter
  -i INWARD, --filter-inward INWARD
                        Minimum distance for inward-facing read pairs.
                        Default: no inward ligation error filter
  -o OUTWARD, --filter-outward OUTWARD
                        Minimum distance for outward-facing read pairs.
                        Default: no outward ligation error filter
  --filter-ligation-auto
                        Auto-guess settings for inward/outward read pair
                        filters. Overrides --filter-outward and --filter-
                        inward if set. This is highly experimental and known
                        to overshoot in some cases. It is generally
                        recommended to specify cutoffs manually.
  -d REDIST, --filter-re-distance REDIST
                        Maximum distance for a read to the nearest restriction
                        site. Default: no RE distance filter
  -l, --filter-self-ligations
                        Remove read pairs representing self-ligated
                        fragments.Default: no self-ligation filter.
  -p DUP_THRESH, --filter-pcr-duplicates DUP_THRESH
                        If specified, filter read pairs for PCR duplicates.
                        Parameter determines distance between alignment starts
                        below which they are considered starting at same
                        position. Sensible values are between 1 and 5.
                        Default: no PCR duplicates filter
  -s STATS, --statistics STATS
                        Path for saving filter statistics
  --reset-filters       Remove all filters from the ReadPairs object.
  --statistics-plot STATS_PLOT
                        Path for saving filter statistics plot (PDF)
  --re-dist-plot RE_DIST_PLOT
                        Plot the distribution of restriction site distances of
                        all read pairs (sum left and right read).
  --ligation-error-plot LIGATION_ERROR_PLOT
                        Plot the relative orientation of read pairs mapped to
                        the reference genome as a fraction of reads oriented
                        in the same direction. Allows the identification of
                        ligation errors as a function of genomic distance.
  -t THREADS, --threads THREADS
                        Number of threads to use for extracting fragment
                        information. Default: 1
  -b BATCH_SIZE, --batch-size BATCH_SIZE
                        Batch size for read pairs to be submitted to
                        individual processes. Default: 1000000
  -S, --no-check-sorted
                        Assume SAM files are sorted and do not check if that
                        is actually the case
  -f, --force-overwrite
                        If the specified output file exists, it will be
                        overwritten without warning.
  --bwa                 Use filters appropriate for BWA and not Bowtie2. This
                        will typically be identified automatically from the
                        SAM/BAM header. Set this flag if you are having
                        problems during filtering (typically 0 reads pass the
                        filtering threshold).
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_pca

### Tool Description
Do a PCA on multiple Hi-C objects.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc pca [-h] [-p PLOT] [-s SAMPLE_SIZE] [--inter-chromosomal]
                [-r REGION] [-e EXPECTED_FILTER] [-b BACKGROUND_FILTER]
                [--min-distance MIN_DISTANCE] [--max-distance MAX_DISTANCE]
                [-n NAMES [NAMES ...]] [--strategy STRATEGY]
                [-c COLORS [COLORS ...]] [-m MARKERS [MARKERS ...]]
                [-v EIGENVECTORS EIGENVECTORS] [-Z] [-S] [-f] [-tmp]
                input [input ...] output

Do a PCA on multiple Hi-C objects

positional arguments:
  input                 Input Hic files
  output                Output file with PCA results.

optional arguments:
  -h, --help            show this help message and exit
  -p PLOT, --plot PLOT  Output plot. Path to PDF file where the PCA plot will
                        be saved.
  -s SAMPLE_SIZE, --sample-size SAMPLE_SIZE
                        Sample size for contacts to do the PCA on.Default:
                        50000
  --inter-chromosomal   Also include inter-chromosomal contacts in PCA. By
                        default, only intra-schromosomal contacts are
                        considered.
  -r REGION, --region REGION
                        Region to do PCA on. You could put a specific
                        chromosome here, for example. By default, the whole
                        genome is considered. Comma-separate multiple regions.
  -e EXPECTED_FILTER, --expected-filter EXPECTED_FILTER
                        Minimum fold-enrichment over expected value. Contacts
                        with a strength lower than <b>*E(d), where d is the
                        distance between two loci and E is the corresponding
                        expected contact strength, are filtered out before
                        PCA. Default: no filter.
  -b BACKGROUND_FILTER, --background-filter BACKGROUND_FILTER
                        Minimum fold-enrichment over average inter-chromosomal
                        contacts. Default: no filter.
  --min-distance MIN_DISTANCE
                        Minimum distance of matrix bins in base pairs. You can
                        use abbreviated formats such as 1mb, 10k, etc.
  --max-distance MAX_DISTANCE
                        Maximum distance of matrix bins in base pairs. You can
                        use abbreviated formats such as 1mb, 10k, etc.
  -n NAMES [NAMES ...], --names NAMES [NAMES ...]
                        Sample names for plot labelling.
  --strategy STRATEGY   Mechanism to select pairs from Hi-C matrix. Default:
                        variance. Possible values are: variance (select
                        contacts with the largest variance in strength across
                        samples first), fold-change (select pairs with the
                        largest fold-change across samples first), and
                        passthrough (no preference on pairs).
  -c COLORS [COLORS ...], --colors COLORS [COLORS ...]
                        Colors for plotting.
  -m MARKERS [MARKERS ...], --markers MARKERS [MARKERS ...]
                        Markers for plotting. Follows Matplotlib marker
                        definitions:
                        http://matplotlib.org/api/markers_api.html
  -v EIGENVECTORS EIGENVECTORS, --eigenvectors EIGENVECTORS EIGENVECTORS
                        Which eigenvectors to plot. Default: 1 2
  -Z, --no-zeros        Ignore pixels with no contacts in any sample.
  -S, --no-scaling      Do not scale input matrices to the same number of
                        valid pairs. Use this only if you are sure matrices
                        are directly comparable.
  -f, --force-overwrite
                        If the specified output file exists, it will be
                        overwritten without warning.
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_sort_sam

### Tool Description
Sort a SAM/BAM file by read name (same as 'samtools sort -n').

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc sort_sam [-h] [-t THREADS] [-tmp] sam [output]

Convenience function to sort a SAM file by name. Exactly the same as 'samtools
sort -n', but potentiallyfaster if sambamba is available.

positional arguments:
  sam                   Input SAM/BAM
  output                Output SAM/BAM. If not provided, will replace input
                        file with sorted version after sorting.

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        Number of sorting threads (only when sambamba is
                        available). Default: 1
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_stats

### Tool Description
Get statistics on the number of reads used at each step of a pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc stats [-h] [-f FASTQ [FASTQ ...]] [-p PAIRS [PAIRS ...]]
                  [-c HIC [HIC ...]]
                  output

Get statistics on number of reads used at each step of a pipeline.

positional arguments:
  output                Output file (.txt) to store statistics.

optional arguments:
  -h, --help            show this help message and exit
  -f FASTQ [FASTQ ...], --fastq FASTQ [FASTQ ...]
                        List of FASTQ files or folders containing FASTQ files.
  -p PAIRS [PAIRS ...], --pairs PAIRS [PAIRS ...]
                        List of Pairs files or folders containing Pairs files
                        ('.pairs ending').
  -c HIC [HIC ...], --hic HIC [HIC ...]
                        List of Hic files or folders containing Hic files
                        ('.hic ending').
```

## fanc_subset

### Tool Description
Create a new Hic object by subsetting it to some regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc subset [-h] input output regions [regions ...]

Create a new Hic object by subsetting.

positional arguments:
  input       Input Hic file.
  output      Output Hic file.
  regions     List of regions that will be used in the output Hic object. All
              contacts between these regions will be in the output object. For
              example, "chr1 chr3" will result in a Hic object with all
              regions in chromosomes 1 and 3, plus all contacts within
              chromosome 1, all contacts within chromosome 3, and all contacts
              between chromosome 1 and 3. "chr1" will only contain regions and
              contactswithin chromosome 1.

optional arguments:
  -h, --help  show this help message and exit
```

## fanc_to_cooler

### Tool Description
Convert a FAN-C Hic file into cooler format (multi-resolution by default).

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc hic_to_cooler [-h] [-u] [-t THREADS] [-M]
                          [-r RESOLUTIONS [RESOLUTIONS ...]] [-S] [-tmp]
                          input output

Convert a Hic file into cooler format. See https://github.com/mirnylab/cooler
for details. If input Hi-C matrix is uncorrected, the uncorrected matrix is
stored. If it is corrected, the uncorrected matrix is stored and the bias
vector. Cooler always calculates corrected matrix on-the-fly from the
uncorrected matrix and the bias vector.

positional arguments:
  input                 Input .hic file, fanc format.
  output                Output cooler file.

optional arguments:
  -h, --help            show this help message and exit
  -u, --uncorrected     Output uncorrected matrix.
  -t THREADS, --threads THREADS
                        Number of threads used for balancing.
  -M, --no-multi        Do not produce a multi-resolution file. This is fast,
                        as it does not "coarsen" the matrix at multiple
                        resolutions, but the resulting file will be
                        incompatible with HiGlass!
  -r RESOLUTIONS [RESOLUTIONS ...], --resolutions RESOLUTIONS [RESOLUTIONS ...]
                        Resolutions in bp at which to "coarsen" the cooler
                        matrix. Default resolutions are calculated as base-
                        resolution * 2 ** z, where z is an increasing integer
                        zoom level.
  -S, --no-natural-sort
                        Do not sort regions by their natural chromosome order.
                        When using this option, chromosomes will appear in the
                        Cooler file in the order they are listed in the FAN-C
                        file.
  -tmp, --work-in-tmp   Work in temporary directory
```

## fanc_to_juicer

### Tool Description
Convert FAN-C ReadPairs files to Juicer .hic format. Needs juicer_tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc hic_to_juicer [-h] [--juicer-tools-jar JUICER_TOOLS_JAR_PATH]
                          [-tmp] [-r RESOLUTIONS [RESOLUTIONS ...]]
                          input [input ...] output

Convert a ReadPairs file to Juicer .hic format

positional arguments:
  input                 Input .pairs file(s), FAN-C format.
  output                Output Juicer file.

optional arguments:
  -h, --help            show this help message and exit
  --juicer-tools-jar JUICER_TOOLS_JAR_PATH
                        Path to juicer jar. You can also specify this in
                        fanc.conf
  -tmp, --work-in-tmp   Work in temporary directory
  -r RESOLUTIONS [RESOLUTIONS ...], --resolutions RESOLUTIONS [RESOLUTIONS ...]
                        Resolutions in bp at which to "zoom" the juicer
                        matrix.
```

## fanc_upgrade

### Tool Description
Upgrade FAN-C objects from old FAN-C versions.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc upgrade [-h] [-f] [-tmp] hic [output]

Upgrade objects from old FAN-C versions.

positional arguments:
  hic                  Hic object to be upgraded.
  output               Output file. If omitted, will try to perform upgrade in
                       place.

optional arguments:
  -h, --help           show this help message and exit
  -f, --force          Force upgrade even if object can be loaded.
  -tmp, --work-in-tmp  Work in temporary directory
```

## fanc_write_config

### Tool Description
Write the default FAN-C config file to a location.

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fanc write_config [-h] [-f] [config_file]

Write default config file to specified location.

positional arguments:
  config_file  Output file for default configuration.

optional arguments:
  -h, --help   show this help message and exit
  -f, --force  Force overwrite of existing config file.
```

## Metadata
- **Skill**: generated

## fanc_fancplot

### Tool Description
fancplot plotting tool for fanc

### Metadata
- **Docker Image**: quay.io/biocontainers/fanc:0.9.0--py37h73a75cf_1
- **Homepage**: https://github.com/vaquerizaslab/fanc
- **Package**: https://anaconda.org/channels/bioconda/packages/fanc/overview
- **Validation**: PASS
### Original Help Text
```text
usage: fancplot [<fancplot global parameters>] <region> [<region> ...]
            --plot <plot type> [<plot parameters>] <plot data file(s)> [...]

            Run fancplot --plot <plot type> -h for help on a specific subplot.

Plot types:

-- Matrix --
triangular    Triangular Hi-C plot
square        Square Hi-C plot
split         Matrix vs matrix plot
mirror        "Mirrored" matrix comparison plot

-- Region --
scores        Region scores plot with parameter dependency
line          Line plot
bar           Bar plot for region scores
layer         Layered feature plot
gene          Gene plot

fancplot plotting tool for fanc

positional arguments:
  regions               List of region selectors (<chr>:<start>-<end>) or
                        files with region information (BED, GTF, ...).

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Suppresses interactive plotting window and redirects
                        plot to file. Specify path to file when plotting a
                        single region, and path to a folder for plotting
                        multiple regions.
  -s SCRIPT, --script SCRIPT
                        Use a script file to define plot.
  -p PLOT, --plot PLOT  New plot, type will be chosen automatically by file
                        type, unless "-t" is provided.
  -n NAME, --name NAME  Plot name to be used as prefix when plotting multiple
                        regions. Is ignored for single region and interactive
                        plot.
  --width WIDTH         Width of the figure in inches. Default: 4
  -w WINDOW_SIZE, --window-size WINDOW_SIZE
                        Plotting region size in base pairs. If provided, the
                        actual size of the given region is ignored and instead
                        a region <chromosome>:<region center - window size/2>
                        - <region center + window size/2> will be plotted.
  --invert-x            Invert x-axis for this plot
  --tick-locations TICK_LOCATIONS [TICK_LOCATIONS ...]
                        Manually define the locations of the tick labels on
                        the genome axis.
  -V, --version         Print version information
```

