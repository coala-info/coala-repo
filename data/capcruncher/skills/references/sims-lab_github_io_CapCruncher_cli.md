[ ]
[ ]

[Skip to content](#cli-reference)

CapCruncher Documentation

CLI Reference

Initializing search

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

CapCruncher Documentation

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

* [Home](..)
* [Installation](../installation/)
* [Pipeline](../pipeline/)
* [Cluster Setup](../cluster_config/)
* [Hints and Tips](../tips/)
* [Plotting CapCruncher output](../plotting/)
* [ ]
  [CLI Reference](./)
* [ ]

  API Reference

  API Reference
  + [ ]

    capcruncher

    capcruncher
    - [ ]

      api

      api
      * [annotate](../reference/capcruncher/api/annotate/)
      * [deduplicate](../reference/capcruncher/api/deduplicate/)
      * [filter](../reference/capcruncher/api/filter/)
      * [io](../reference/capcruncher/api/io/)
      * [pileup](../reference/capcruncher/api/pileup/)
      * [plotting](../reference/capcruncher/api/plotting/)
      * [statistics](../reference/capcruncher/api/statistics/)
      * [storage](../reference/capcruncher/api/storage/)

# CLI Reference[¶](#cli-reference "Permanent link")

This page provides documentation for CapCruncher command line tools.

# capcruncher[¶](#capcruncher "Permanent link")

An end to end solution for processing: Capture-C, Tri-C and Tiled-C data.

**Usage:**

```
capcruncher [OPTIONS] COMMAND [ARGS]...
```

**Options:**

```
  --version  Show the version and exit.
  --help     Show this message and exit.
```

## alignments[¶](#alignments "Permanent link")

Alignment annotation, identification and deduplication.

**Usage:**

```
capcruncher alignments [OPTIONS] COMMAND [ARGS]...
```

**Options:**

```
  --help  Show this message and exit.
```

### annotate[¶](#annotate "Permanent link")

Annotates a bed file with other bed files using bedtools intersect.

Whilst bedtools intersect allows for interval names and counts to be used for annotating intervals, this command
provides the ability to annotate intervals with both interval names and counts at the same time. As the pipeline allows
for empty bed files, this command has built in support to deal with blank/malformed bed files and will return default N/A values.

Prior to interval annotation, the bed file to be intersected is validated and duplicate entries/multimapping reads are removed
to ensure consistent annotations and prevent issues with reporter identification.

**Usage:**

```
capcruncher alignments annotate [OPTIONS] SLICES
```

**Options:**

```
  -a, --actions [get|count]       Determines if the overlaps are counted or if
                                  the name should just be reported
  -b, --bed_files TEXT            Bed file(s) to intersect with slices
  -n, --names TEXT                Names to use as column names for the output
                                  tsv file.
  -f, --overlap_fractions FLOAT   The minimum overlap required for an
                                  intersection between two intervals to be
                                  reported.
  -t, --dtypes TEXT               Data type for column
  -o, --output TEXT               Path for the annotated slices to be output.
  --duplicates [remove]           Method to use for reconciling duplicate
                                  slices (i.e. multimapping). Currently only
                                  'remove' is supported.
  -p, --n_cores INTEGER           Intersections are performed in parallel, set
                                  this to the number of intersections required
  --invalid_bed_action [ignore|error]
                                  Method to deal with invalid bed files e.g.
                                  blank or incorrectly formatted. Setting this
                                  to 'ignore' will report default N/A values
                                  (either '.' or 0) for invalid files
  --blacklist TEXT                Regions to remove from the BAM file prior to
                                  annotation
  --prioritize-cis-slices         Attempts to prevent slices on the most
                                  common chromosome in a fragment (ideally cis
                                  to the viewpoint) being removed by
                                  deduplication
  --priority-chroms TEXT          A comma separated list of chromosomes to
                                  prioritize during deduplication
  --help                          Show this message and exit.
```

### filter[¶](#filter "Permanent link")

Removes unwanted aligned slices and identifies reporters.

Parses a BAM file and merges this with a supplied annotation to identify unwanted slices.
Filtering can be tuned for Capture-C, Tri-C and Tiled-C data to ensure optimal filtering.

**Usage:**

```
capcruncher alignments filter [OPTIONS] {capture|tri|tiled}
```

**Options:**

```
  -b, --bam TEXT                Bam file to process  [required]
  -a, --annotations TEXT        Annotations for the bam file that must contain
                                the required columns, see description.
                                [required]
  --custom-filtering TEXT       Custom filtering to be used. This must be
                                supplied as a path to a yaml file.
  -o, --output_prefix TEXT      Output prefix for deduplicated fastq file(s)
  --statistics TEXT             Output path for stats file
  --sample-name TEXT            Name of sample e.g. DOX_treated_1
  --read-type [flashed|pe]      Type of read
  --fragments / --no-fragments  Determines if read fragment aggregations are
                                produced
  --help                        Show this message and exit.
```

## fastq[¶](#fastq "Permanent link")

Fastq splitting, deduplication and digestion.

**Usage:**

```
capcruncher fastq [OPTIONS] COMMAND [ARGS]...
```

**Options:**

```
  --help  Show this message and exit.
```

### deduplicate[¶](#deduplicate "Permanent link")

Identifies PCR duplicate fragments from Fastq files.

PCR duplicates are very commonly present in Capture-C/Tri-C/Tiled-C data and must be removed
for accurate analysis. These commands attempt to identify and remove duplicate reads/fragments
from fastq file(s) to speed up downstream analysis.

**Usage:**

```
capcruncher fastq deduplicate [OPTIONS]
```

**Options:**

```
  -1, --fastq1 TEXT         Read 1 FASTQ files  [required]
  -2, --fastq2 TEXT         Read 2 FASTQ files  [required]
  -o, --output-prefix TEXT  Output prefix for deduplicated FASTQ files
  --sample-name TEXT        Name of sample e.g. DOX_treated_1
  -s, --statistics TEXT     Statistics output file name
  --shuffle                 Shuffle reads before deduplication
  --help                    Show this message and exit.
```

### digest[¶](#digest "Permanent link")

Performs in silico digestion of one or a pair of fastq files.

**Usage:**

```
capcruncher fastq digest [OPTIONS] FASTQS...
```

**Options:**

```
  -r, --restriction_enzyme TEXT   Restriction enzyme name or sequence to use
                                  for in silico digestion.  [required]
  -m, --mode [flashed|pe]         Digestion mode. Combined (Flashed) or non-
                                  combined (PE) read pairs.  [required]
  -o, --output_file TEXT
  --minimum_slice_length INTEGER
  --statistics TEXT               Output path for stats file
  --sample-name TEXT              Name of sample e.g. DOX_treated_1. Required
                                  for correct statistics.
  --help                          Show this message and exit.
```

### split[¶](#split "Permanent link")

Splits fastq file(s) into equal chunks of n reads.

**Usage:**

```
capcruncher fastq split [OPTIONS] INPUT_FILES...
```

**Options:**

```
  -m, --method [python|unix]   Method to use for splitting
  -o, --output_prefix TEXT     Output prefix for deduplicated fastq file(s)
  --compression_level INTEGER  Level of compression for output files
  -n, --n_reads INTEGER        Number of reads per fastq file
  --gzip / --no-gzip           Determines if files are gziped or not
  -p, --n_cores INTEGER
  -s, --suffix TEXT            Suffix to add to output files (ignore
                               {read_number}.fastq as this is added
                               automatically)
  --help                       Show this message and exit.
```

## genome[¶](#genome "Permanent link")

Genome wide methods digestion.

**Usage:**

```
capcruncher genome [OPTIONS] COMMAND [ARGS]...
```

**Options:**

```
  --help  Show this message and exit.
```

### digest[¶](#digest_1 "Permanent link")

Performs in silico digestion of a genome in fasta format.

Digests the supplied genome fasta file and generates a bed file containing the
locations of all restriction fragments produced by the supplied restriction enzyme.

A log file recording the number of restriction fragments for the suplied genome is also
generated.

**Usage:**

```
capcruncher genome digest [OPTIONS] INPUT_FASTA
```

**Options:**

```
  -r, --recognition_site TEXT  Recognition enzyme or sequence  [required]
  -l, --logfile TEXT           Path for digestion log file
  -o, --output_file TEXT       Output file path
  --remove_cutsite BOOLEAN     Exclude the recognition sequence from the
                               output
  --sort                       Sorts the output bed file by chromosome and
                               start coord.
  --help                       Show this message and exit.
```

## interactions[¶](#interactions "Permanent link")

Reporter counting, storing, comparison and pileups

**Usage:**

```
capcruncher interactions [OPTIONS] COMMAND [ARGS]...
```

**Options:**

```
  --help  Show this message and exit.
```

### compare[¶](#compare "Permanent link")

Compare bedgraphs and CapCruncher cooler files.

These commands allow for specific viewpoints to be extracted from CapCruncher HDF5 files and perform:

```
1. User defined groupby aggregations.

2. Comparisons between conditions.

3. Identification of differential interactions between conditions.
```

See subcommands for details.

**Usage:**

```
capcruncher interactions compare [OPTIONS] COMMAND [ARGS]...
```

**Options:**

```
  --help  Show this message and exit.
```

#### concat[¶](#concat "Permanent link")

**Usage:**

```
capcruncher interactions compare concat [OPTIONS] INFILES...
```

**Options:**

```
  -f, --format [auto|bedgraph|cooler]
                                  Input file format
  -o, --output TEXT               Output file name
  -v, --viewpoint TEXT            Viewpoint to extract
  -r, --resolution TEXT           Resolution to extract
  --region TEXT                   Limit to specific coordinates in the format
                                  chrom:start-end
  --normalisation [raw|n_cis|region]
                                  Method to use interaction normalisation
  --normalisation-regions TEXT    Regions to use for interaction
                                  normalisation. The --normalisation method
                                  MUST be 'region'
  --scale_factor INTEGER          Scale factor to use for bedgraph
                                  normalisation
  -p, --n_cores INTEGER           Number of cores to use for extracting
                                  bedgraphs
  --help                          Show this message and exit.
```

#### differential[¶](#differential "Permanent link")

Perform differential testing on CapCruncher HDF5 files.

This command performs differential testing on CapCruncher HDF5 files. It requires a design matrix
and a contrast to test. The design matrix should be a tab separated file with the first column
containing the sample names and the remaining columns containing the conditions. The contrast
should specify the name of the column in the design matrix to test. The output is a tab separated bedgraph.

**Usage:**

```
capcruncher interactions compare differential [OPTIONS] INTERACTION_FILES...
```

**Options:**

```
  -o, --output-prefix TEXT        Output file prefix
  -v, --viewpoint TEXT            Viewpoint to extract  [required]
  -d, --design-matrix TEXT        Design matrix file  [required]
  -c, --contrast TEXT             Contrast to test
  -r, --regions-of-interest TEXT  Regions of interest to test for differential
                                  interactions
  --viewpoint-distance INTEGER    Distance from viewpoint to test for
                                  differential interactions
  --threshold-count INTEGER       Minimum number of interactions to test for
                                  differential interactions
  --threshold-q FLOAT             Minimum q-value to test for differential
                                  interactions
  --help                          Show this message and exit.
```

#### summarise[¶](#summarise "Permanent link")

**Usage:**

```
capcruncher interactions compare summarise [OPTIONS] INFILE
```

**Options:**

```
  -d, --design-matrix TEXT        Design matrix file, should be formatted as a
                                  tab separated file with the first column
                                  containing the sample names and the other
                                  column containing the conditions.
  -o, --output-prefix TEXT        Output file prefix
  -f, --output-format [bedgraph|tsv]
  -m, --summary-methods TEXT      Summary methods to use for aggregation. Can
                                  be any method in numpy or scipy.stats
  -n, --group-names TEXT          Group names for aggregation
  -c, --group-columns TEXT        Column names/numbers (0 indexed, the first
                                  column after the end coordinate counts as 0)
                                  for aggregation.
  --subtraction                   Perform subtration between aggregated groups
  --suffix TEXT                   Add a suffix before the file extension
  --help                          Show this message and exit.
```

### count[¶](#count "Permanent link")

Determines the number of captured restriction fragment interactions genome wide.

Counts the number of interactions between each restriction fragment and all other
restriction fragments in the fragment.

The output is a cooler formatted HDF5 file containing a single group containing
the interactions between restriction fragments.

See `https://cooler.readthedocs.io/en/latest/` for further details.

**Usage:**

```
capcruncher interactions count [OPTIONS] REPORTERS
```

**Options:**

```
  -o, --output TEXT            Name of output file
  --remove_exclusions          Prevents analysis of fragments marked as
                               proximity exclusions
  --remove_capture             Prevents analysis of capture fragment
                               interactions
  --subsample FLOAT            Subsamples reporters before analysis of
                               interactions
  -f, --fragment-map TEXT      Path to digested genome bed file
  -v, --viewpoint-path TEXT    Path to viewpoints