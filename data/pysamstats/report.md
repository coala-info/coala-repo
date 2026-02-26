# pysamstats CWL Generation Report

## pysamstats

### Tool Description
Calculate statistics against genome positions based on sequence alignments from a SAM or BAM file and print them to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/pysamstats:1.1.2--py311h384fd50_15
- **Homepage**: https://github.com/alimanfoo/pysamstats
- **Package**: https://anaconda.org/channels/bioconda/packages/pysamstats/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pysamstats/overview
- **Total Downloads**: 105.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/alimanfoo/pysamstats
- **Stars**: N/A
### Original Help Text
```text
Usage: pysamstats [options] FILE

Calculate statistics against genome positions based on sequence alignments
from a SAM or BAM file and print them to stdout.

Options:
  -h, --help            show this help message and exit
  -t TYPE, --type=TYPE  Type of statistics to print, one of: alignment_binned,
                        baseq, baseq_ext, baseq_ext_strand, baseq_strand,
                        coverage, coverage_binned, coverage_ext,
                        coverage_ext_binned, coverage_ext_strand, coverage_gc,
                        coverage_strand, mapq, mapq_binned, mapq_strand, tlen,
                        tlen_binned, tlen_strand, variation, variation_strand.
  -c CHROMOSOME, --chromosome=CHROMOSOME
                        Chromosome name.
  -s START, --start=START
                        Start position (1-based).
  -e END, --end=END     End position (1-based).
  -z, --zero-based      Use zero-based coordinates (default is false, i.e.,
                        use one-based coords).
  -u, --truncate        Truncate pileup-based stats so no records are emitted
                        outside the specified range.
  -S STEPPER, --stepper=STEPPER
                        Stepper to provide to underlying pysam call. Options
                        are:"all" (default): all reads are returned, except
                        where flags BAM_FUNMAP, BAM_FSECONDARY, BAM_FQCFAIL,
                        BAM_FDUP set; "nofilter" applies no filter to returned
                        reads; "samtools": filter & read processing as in
                        _csamtools_ pileup. This requires a fasta file. For
                        complete details see the pysam documentation.
  -d, --pad             Pad pileup-based stats so a record is emitted for
                        every position (default is only covered positions).
  -D MAX_DEPTH, --max-depth=MAX_DEPTH
                        Maximum read depth permitted in pileup-based
                        statistics. The default limit is 8000.
  -f FASTA, --fasta=FASTA
                        Reference sequence file, only required for some
                        statistics.
  -o, --omit-header     Omit header row from output.
  -p N, --progress=N    Report progress every N rows.
  --window-size=N       Size of window for binned statistics (default is 300).
  --window-offset=N     Window offset to use for deciding which genome
                        position to report binned statistics against. The
                        default is 150, i.e., the middle of 300bp window.
  --format=FORMAT       Output format, one of {tsv, csv, hdf5} (defaults to
                        tsv). N.B., hdf5 requires PyTables to be installed.
  --output=OUTPUT       Path to output file. If not provided, write to stdout.
  --fields=FIELDS       Comma-separated list of fields to output (defaults to
                        all fields).
  --hdf5-group=HDF5_GROUP
                        Name of HDF5 group to write to (defaults to the root
                        group).
  --hdf5-dataset=HDF5_DATASET
                        Name of HDF5 dataset to create (defaults to "data").
  --hdf5-complib=HDF5_COMPLIB
                        HDF5 compression library (defaults to zlib).
  --hdf5-complevel=HDF5_COMPLEVEL
                        HDF5 compression level (defaults to 5).
  --hdf5-chunksize=HDF5_CHUNKSIZE
                        Size of chunks in number of bytes (defaults to 2**20).
  --min-mapq=MIN_MAPQ   Only reads with mapping quality equal to or greater
                        than this value will be counted (0 by default).
  --min-baseq=MIN_BASEQ
                        Only reads with base quality equal to or greater than
                        this value will be counted (0 by default). Only
                        applies to pileup-based statistics.
  --no-dup              Don't count reads flagged as duplicate.
  --no-del              Don't count reads aligned with a deletion at the given
                        position. Only applies to pileup-based statistics.

Pileup-based statistics types (each row has statistics over reads in a pileup column):

    * coverage            - Number of reads aligned to each genome position
                            (total and properly paired).
    * coverage_strand     - As coverage but with forward/reverse strand counts.
    * coverage_ext        - Various additional coverage metrics, including
                            coverage for reads not properly paired (mate
                            unmapped, mate on other chromosome, ...).
    * coverage_ext_strand - As coverage_ext but with forward/reverse strand counts.
    * coverage_gc         - As coverage but also includes a column for %GC.
    * variation           - Numbers of matches, mismatches, deletions,
                            insertions, etc.
    * variation_strand    - As variation but with forward/reverse strand counts.
    * tlen                - Insert size statistics.
    * tlen_strand         - As tlen but with statistics by forward/reverse strand.
    * mapq                - Mapping quality statistics.
    * mapq_strand         - As mapq but with statistics by forward/reverse strand.
    * baseq               - Base quality statistics.
    * baseq_strand        - As baseq but with statistics by forward/reverse strand.
    * baseq_ext           - Extended base quality statistics, including qualities
                            of bases matching and mismatching reference.
    * baseq_ext_strand    - As baseq_ext but with statistics by forward/reverse strand.

Binned statistics types (each row has statistics over reads aligned starting within a genome window):

    * coverage_binned     - As coverage but binned.
    * coverage_ext_binned - As coverage_ext but binned.
    * mapq_binned         - Similar to mapq but binned.
    * alignment_binned    - Aggregated counts from cigar strings.
    * tlen_binned         - As tlen but binned.

Examples:

    pysamstats --type coverage example.bam > example.coverage.txt
    pysamstats --type coverage --chromosome Pf3D7_v3_01 --start 100000 --end 200000 example.bam > example.coverage.txt

Version: 1.1.2 (pysam 0.23.0)
```

