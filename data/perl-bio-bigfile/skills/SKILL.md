---
name: perl-bio-bigfile
description: The `perl-bio-bigfile` skill provides a specialized interface for high-performance access to UCSC BigWig and BigBed files.
homepage: https://metacpan.org/pod/Bio::DB::BigFile
---

# perl-bio-bigfile

## Overview

The `perl-bio-bigfile` skill provides a specialized interface for high-performance access to UCSC BigWig and BigBed files. Unlike high-level BioPerl modules, this tool offers a low-level, memory-efficient way to perform random access queries across local or remote genomic datasets. It is particularly useful for bioinformatics workflows requiring rapid calculation of summary statistics (like mean coverage or standard deviation) across specific genomic windows or for dumping large-scale signal data into text formats.

## Core Usage Patterns

### Opening Files
Always use the specific opener for the file type. These return a `Bio::DB::bbiFile` object.
```perl
use Bio::DB::BigFile;
use Bio::DB::BigFile::Constants;

# Open BigWig
my $bw = Bio::DB::BigFile->bigWigFileOpen('data.bw');

# Open BigBed
my $bb = Bio::DB::BigFile->bigBedFileOpen('data.bb');
```

### Querying Signal Intervals
To retrieve raw data points from a BigWig file, use `bigWigIntervalQuery`. Note that coordinates are **0-based, half-open**.
```perl
my $query = $bw->bigWigIntervalQuery('chr1', 1000, 2000);
my $head  = $query->head;

while ($head) {
    printf("Start: %d, End: %d, Value: %f\n", $head->start, $head->end, $head->val);
    $head = $head->next;
}
```

### Generating Summary Statistics
One of the most powerful features is the ability to bin data and calculate statistics directly from the indexed file without loading the entire range into memory.

**Available Operations:** `bbiSumMean`, `bbiSumMax`, `bbiSumMin`, `bbiSumCoverage`, `bbiSumStandardDeviation`.

```perl
# Divide a 1MB region into 100 bins and get the mean for each
my $bins = $bw->bigWigSummaryArray('chr3', 0, 1_000_000, bbiSumMean, 100);

# Accessing extended summaries (min, max, sum, sumSquares)
my $ext_bins = $bw->bigWigSummaryArrayExtended('chr3', 0, 1_000_000, 100);
my $first_bin = $ext_bins->[0];
print "Max in bin 1: " . $first_bin->{maxVal};
```

### Metadata and Chromosome Info
To iterate through all chromosomes defined in the big file:
```perl
my $chroms = $bw->chromList()->head;
while ($chroms) {
    print $chroms->name . " (Size: " . $chroms->size . ")\n";
    $chroms = $chroms->next;
}
```

## Expert Tips

*   **Coordinate Systems**: This low-level API strictly uses 0-based half-open intervals (e.g., `0, 100` covers bases 0 through 99). If you are coming from a high-level BioPerl background or GFF3 files (1-based), you must subtract 1 from the start coordinate.
*   **Remote Access Cache**: When accessing files via URL, the module defaults to `/tmp/udcCache`. If you are running on a cluster with limited `/tmp` space, redirect the cache:
    `Bio::DB::BigFile->udcSetDefaultDir('/path/to/large/scratch/space');`
*   **Memory Management**: Do not `undef` the list head object (the result of a query) while you are still iterating through the individual interval or chromosome objects, as the underlying C structures are linked.
*   **File Creation**: While `createBigWig` exists, it is often more robust to use the UCSC command-line utilities `wigToBigWig` or `bedToBigBed` for initial file generation, using this Perl module primarily for downstream analysis and data extraction.

## Reference documentation
- [Bio::DB::BigFile Documentation](./references/metacpan_org_pod_Bio__DB__BigFile.md)