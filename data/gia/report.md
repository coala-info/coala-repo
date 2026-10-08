# gia CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gia_bam_convert | PASS | bed conversion works; the fastq option fails visibly because the tool does not implement it |
| gia_bam_coverage | PASS |  |
| gia_bam_filter | PASS |  |
| gia_bcf_filter | PASS |  |
| gia_closest | PASS |  |
| gia_cluster | PASS |  |
| gia_complement | PASS |  |
| gia_coverage | PASS |  |
| gia_extend | PASS |  |
| gia_flank | PASS |  |
| gia_get-fasta | PASS |  |
| gia_intersect | PASS |  |
| gia_join | PASS |  |
| gia_merge | PASS |  |
| gia_random | PASS |  |
| gia_sample | PASS |  |
| gia_segment | PASS |  |
| gia_shift | PASS |  |
| gia_sort | PASS |  |
| gia_spacing | PASS |  |
| gia_subtract | PASS |  |
| gia_unionbedg | PASS |  |
| gia_window | PASS |  |

## gia_closest

### Tool Description
Finds the closest interval in a secondary BED file for all intervals in a primary BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Finds the closest interval in a secondary BED file for all intervals in a primary BED file

Usage: gia closest [OPTIONS]

Options:
  -h, --help
          Print help (see a summary with '-h')

Dual Input Options:
  -a, --a <A>
          Primary BED file to use (default=stdin)

  -b, --b <B>...
          Secondary BED file(s) to use
          
          Multiple BED files can be provided, mixed format input will be demoted to the lowest rank BED provided.

Parameters:
  -u, --upstream
          Report only the closest upstream interval

  -d, --downstream
          Report only the closest downstream interval

  -s, --strandedness <STRANDEDNESS>
          Strand-specificity of closest intervals
          
          [default: i]
          [possible values: i, m, o]

  -S, --sorted
          Specify that the input files are already presorted

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_cluster

### Tool Description
Annotates the intervals of a BED file with their Cluster ID

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Annotates the intervals of a BED file with their Cluster ID

Usage: gia cluster [OPTIONS]

Options:
  -h, --help  Print help

Single Input Options:
  -i, --input <INPUT>                Input BED file to process (default=stdin)
  -T, --input-format <INPUT_FORMAT>  Format of input file [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]
  -N, --field-format <FIELD_FORMAT>  Allow for non-integer chromosome names [possible values: integer-based, string-based]

Parameters:
  -s, --sorted  Assume input is sorted (default=false)

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)
  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable [default: 1]
      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable [default: 6]
```


## gia_complement

### Tool Description
Generates the complement of a BED file

This reports the regions that are not covered by the input BED file but excludes regions preceding the first interval and following the last interval.

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Generates the complement of a BED file

This reports the regions that are not covered by the input BED file but excludes regions preceding the first interval and following the last interval.

Usage: gia complement [OPTIONS]

Options:
  -h, --help
          Print help (see a summary with '-h')

Single Input Options:
  -i, --input <INPUT>
          Input BED file to process (default=stdin)

  -T, --input-format <INPUT_FORMAT>
          Format of input file
          
          [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]

  -N, --field-format <FIELD_FORMAT>
          Allow for non-integer chromosome names
          
          [possible values: integer-based, string-based]

Parameters:
  -s, --sorted
          Assume input is sorted (default=false)

  -S, --stream
          Stream the input file instead of loading it into memory
          
          Note that this requires the input file to be sorted and will result in undefined behavior if it is not.

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_coverage

### Tool Description
Calculates the coverage of intervals in Set A by intervals in Set B

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Calculates the coverage of intervals in Set A by intervals in Set B

Usage: gia coverage [OPTIONS]

Options:
  -h, --help
          Print help (see a summary with '-h')

Dual Input Options:
  -a, --a <A>
          Primary BED file to use (default=stdin)

  -b, --b <B>...
          Secondary BED file(s) to use
          
          Multiple BED files can be provided, mixed format input will be demoted to the lowest rank BED provided.

Parameters:
  -S, --sorted
          Assert that the intervals are presorted in BOTH files (unexpected behavior if they are not)

  -@, --threads <THREADS>
          Number of threads to use for parallel processing of intervals

  -C, --chunk-size <CHUNK_SIZE>
          Batch size used when writing to the output in parallel
          
          [default: 5000]

Overlap Predicates:
  -f, --fraction-query <FRACTION_QUERY>
          Minimum fraction of a's interval that must be covered by b's interval

  -F, --fraction-target <FRACTION_TARGET>
          Minimum fraction of b's interval that must be covered by a's interval

  -r, --reciprocal
          Require that the fraction provided with `-f` is reciprocal to both query and target

  -e, --either
          Requires that either fraction provided with `-f` or `-F` is met

  -s, --strandedness <STRANDEDNESS>
          Strand-specificity to use when comparing intervals
          
          i: Ignore strand (default)
          
          m: Match strand (+/+ or -/- only)
          
          o: Opposite strand (+/- or -/+ only)
          
          [default: i]
          [possible values: i, m, o]

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_extend

### Tool Description
Extends the intervals of a BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Extends the intervals of a BED file

The extension is either done on both sides at once or on the left and right side separately

Usage: gia extend [OPTIONS]

Options:
  -h, --help
          Print help (see a summary with '-h')

Single Input Options:
  -i, --input <INPUT>
          Input BED file to process (default=stdin)

  -T, --input-format <INPUT_FORMAT>
          Format of input file
          
          [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]

  -N, --field-format <FIELD_FORMAT>
          Allow for non-integer chromosome names
          
          [possible values: integer-based, string-based]

Growth Options:
  -t, --both <BOTH>
          Amount to apply to function on both sides of intervals

  -l, --left <LEFT>
          Amount to apply to function on the left side of intervals

  -r, --right <RIGHT>
          Amount to apply to function on the right side of intervals

  -p, --percent
          Convert values provided to percentages of the interval length

  -g, --genome <GENOME>
          Genome file to validate growth against

  -s, --stranded
          Follow strand specificity when applying growth
          
          i.e. if the strand is negative, apply growth to the right side of the interval when the left side is requested (and vice versa) [default = false]

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_flank

### Tool Description
Flanks the intervals of a BED file

This will crefate two new flanking intervals for each interval in the input file, one on the left and one on the right side.

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Flanks the intervals of a BED file

This will crefate two new flanking intervals for each interval in the input file, one on the left and one on the right side.

Usage: gia flank [OPTIONS]

Options:
  -h, --help
          Print help (see a summary with '-h')

Single Input Options:
  -i, --input <INPUT>
          Input BED file to process (default=stdin)

  -T, --input-format <INPUT_FORMAT>
          Format of input file
          
          [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]

  -N, --field-format <FIELD_FORMAT>
          Allow for non-integer chromosome names
          
          [possible values: integer-based, string-based]

Growth Options:
  -t, --both <BOTH>
          Amount to apply to function on both sides of intervals

  -l, --left <LEFT>
          Amount to apply to function on the left side of intervals

  -r, --right <RIGHT>
          Amount to apply to function on the right side of intervals

  -p, --percent
          Convert values provided to percentages of the interval length

  -g, --genome <GENOME>
          Genome file to validate growth against

  -s, --stranded
          Follow strand specificity when applying growth
          
          i.e. if the strand is negative, apply growth to the right side of the interval when the left side is requested (and vice versa) [default = false]

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_get-fasta

### Tool Description
Extracts FASTA sequences using intervals from a BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Extracts FASTA sequences using intervals from a BED file

Usage: gia get-fasta [OPTIONS] --fasta <FASTA>

Options:
  -h, --help
          Print help (see a summary with '-h')

Single Input Options:
  -i, --input <INPUT>
          Input BED file to process (default=stdin)

  -T, --input-format <INPUT_FORMAT>
          Format of input file
          
          [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]

  -N, --field-format <FIELD_FORMAT>
          Allow for non-integer chromosome names
          
          [possible values: integer-based, string-based]

  -f, --fasta <FASTA>
          FASTA file to extract sequences from (assumes <fasta>.fai exists)
          
          If the file ends with .gz, it will be treated as a BGZIP compressed file and decompressed on-the-fly. It will expect a corresponding .fai index and a gzip index file.

  -s, --stranded
          Reverse complement the sequence if the strand is negative Default is to ignore strand information

  -r, --rna
          The FASTA is RNA instead of DNA and reverse complement is handled accordingly

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_intersect

### Tool Description
Intersects two BED files

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Intersects two BED files

Usage: gia intersect [OPTIONS]

Options:
  -h, --help
          Print help (see a summary with '-h')

Dual Input Options:
  -a, --a <A>
          Primary BED file to use (default=stdin)

  -b, --b <B>...
          Secondary BED file(s) to use
          
          Multiple BED files can be provided, mixed format input will be demoted to the lowest rank BED provided.

Parameters:
      --stream
          Stream the input files instead of loading them into memory (only works if both files are sorted)

  -S, --sorted
          Assert the inputs are pre-sorted

Overlap Predicates:
  -f, --fraction-query <FRACTION_QUERY>
          Minimum fraction of a's interval that must be covered by b's interval

  -F, --fraction-target <FRACTION_TARGET>
          Minimum fraction of b's interval that must be covered by a's interval

  -r, --reciprocal
          Require that the fraction provided with `-f` is reciprocal to both query and target

  -e, --either
          Requires that either fraction provided with `-f` or `-F` is met

  -s, --strandedness <STRANDEDNESS>
          Strand-specificity to use when comparing intervals
          
          i: Ignore strand (default)
          
          m: Match strand (+/+ or -/- only)
          
          o: Opposite strand (+/- or -/+ only)
          
          [default: i]
          [possible values: i, m, o]

Output Predicates:
  -q, --with-query
          Return the records from a that overlap with b instead of the intersection

  -t, --with-target
          Return the records from b that overlap with a instead of the intersection

  -u, --unique
          Only write the query record once if it overlaps with multiple target records

  -v, --inverse
          Only report the intervals in the query that do not overlap with the target (i.e. the inverse of the intersection)

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_join

### Tool Description
Joins two BED files

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Joins two BED files

Usage: gia join [OPTIONS]

Options:
  -h, --help
          Print help (see a summary with '-h')

Dual Input Options:
  -a, --a <A>
          Primary BED file to use (default=stdin)

  -b, --b <B>...
          Secondary BED file(s) to use
          
          Multiple BED files can be provided, mixed format input will be demoted to the lowest rank BED provided.

Parameters:
  -H, --how <HOW>
          [default: inner]

          Possible values:
          - left:  Return all records in the left input even if no match is found in right
          - right: Return all records in the right input even if no match is found in left
          - inner: Return only records that have a match in both inputs

  -S, --sorted
          Assert the inputs are pre-sorted

Overlap Predicates:
  -f, --fraction-query <FRACTION_QUERY>
          Minimum fraction of a's interval that must be covered by b's interval

  -F, --fraction-target <FRACTION_TARGET>
          Minimum fraction of b's interval that must be covered by a's interval

  -r, --reciprocal
          Require that the fraction provided with `-f` is reciprocal to both query and target

  -e, --either
          Requires that either fraction provided with `-f` or `-F` is met

  -s, --strandedness <STRANDEDNESS>
          Strand-specificity to use when comparing intervals
          
          i: Ignore strand (default)
          
          m: Match strand (+/+ or -/- only)
          
          o: Opposite strand (+/- or -/+ only)
          
          [default: i]
          [possible values: i, m, o]

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_merge

### Tool Description
Merges intervals of a BED file with overlapping regions

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Merges intervals of a BED file with overlapping regions

Usage: gia merge [OPTIONS]

Options:
  -h, --help
          Print help (see a summary with '-h')

Single Input Options:
  -i, --input <INPUT>
          Input BED file to process (default=stdin)

  -T, --input-format <INPUT_FORMAT>
          Format of input file
          
          [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]

  -N, --field-format <FIELD_FORMAT>
          Allow for non-integer chromosome names
          
          [possible values: integer-based, string-based]

Parameters:
  -r, --stranded
          Only merge intervals that share strandedness (will ignore intervals that have unknown strand)

  -R, --specific <SPECIFIC>
          Only merge intervals that belong to a specific strand (will ignore all intervals that do not share the specified strand)
          
          [possible values: +, -]

  -d, --demote
          Demote all merged intervals into BED3 format if they are not already in that format

  -s, --sorted
          Assume input is sorted (default=false)

  -S, --stream
          Stream the input file instead of loading it into memory
          
          Note that this requires the input file to be sorted and will result in undefined behavior if it is not.
          
          Currently does not support non-integer chromosome names.

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_random

### Tool Description
Generates a random BED file given some parameterizations

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Generates a random BED file given some parameterizations

Usage: gia random [OPTIONS]

Options:
  -h, --help  Print help

Parameters:
  -n, --n-intervals <N_INTERVALS>  Number of intervals to generate (default = 10_000) [default: 10000]
  -l, --l-intervals <L_INTERVALS>  Length of intervals to generate (default = 150) [default: 150]
  -c, --n-chr <N_CHR>              Number of chromosomes to generate (default = 23) [default: 23]
  -m, --max-chr-len <MAX_CHR_LEN>  Maximum length of chromosomes (default = 250_000_000) [default: 250000000]
  -s, --seed <SEED>                Seed to use for random number generation (no default)
  -g, --genome <GENOME>            Genome file to set boundaries for random intervals
  -N, --named                      Allow for non-integer chromosome names in genome file + output
  -T, --format <FORMAT>            Set the output format [default: bed3] [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)
  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable [default: 1]
      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable [default: 6]
```

## gia_sample

### Tool Description
Randomly sample a BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Randomly sample a BED file

Usage: gia sample [OPTIONS]

Options:
  -h, --help  Print help

Single Input Options:
  -i, --input <INPUT>                Input BED file to process (default=stdin)
  -T, --input-format <INPUT_FORMAT>  Format of input file [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]
  -N, --field-format <FIELD_FORMAT>  Allow for non-integer chromosome names [possible values: integer-based, string-based]

Parameters:
  -n, --number <NUMBER>      Number of intervals to sample (choose one of n or f)
  -f, --fraction <FRACTION>  Fraction of intervals to sample (choose one of n or f)
  -s, --seed <SEED>          Seed to use for random number generation (no default)

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)
  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable [default: 1]
      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable [default: 6]
```


## gia_segment

### Tool Description
Segments a BED file into non-overlapping regions

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Segments a BED file into non-overlapping regions

Usage: gia segment [OPTIONS]

Options:
  -h, --help  Print help

Single Input Options:
  -i, --input <INPUT>                Input BED file to process (default=stdin)
  -T, --input-format <INPUT_FORMAT>  Format of input file [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]
  -N, --field-format <FIELD_FORMAT>  Allow for non-integer chromosome names [possible values: integer-based, string-based]

Parameters:
  -s, --sorted  Assume input is sorted (default=false)

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)
  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable [default: 1]
      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable [default: 6]
```


## gia_shift

### Tool Description
Shifts the intervals of a BED file by a specified amount

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Shifts the intervals of a BED file by a specified amount

Usage: gia shift [OPTIONS] --amount <AMOUNT>

Options:
  -h, --help
          Print help (see a summary with '-h')

Single Input Options:
  -i, --input <INPUT>
          Input BED file to process (default=stdin)

  -T, --input-format <INPUT_FORMAT>
          Format of input file
          
          [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]

  -N, --field-format <FIELD_FORMAT>
          Allow for non-integer chromosome names
          
          [possible values: integer-based, string-based]

Parameters:
  -g, --genome <GENOME>
          Path to genome file to use for bounds when shifting

  -a, --amount <AMOUNT>
          Amount to shift intervals by (negative values shift to the left)

  -p, --percent
          Interprets the amount as a fraction of the interval length
          
          i.e. if the amount is 0.5, the interval will be shifted by half of its length. if the amount is 2, the interval will be shifted by twice its length.

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_sort

### Tool Description
Sorts a BED file by chromosome, start, and end

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Sorts a BED file by chromosome, start, and end

Usage: gia sort [OPTIONS]

Options:
  -h, --help  Print help

Single Input Options:
  -i, --input <INPUT>                Input BED file to process (default=stdin)
  -T, --input-format <INPUT_FORMAT>  Format of input file [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]
  -N, --field-format <FIELD_FORMAT>  Allow for non-integer chromosome names [possible values: integer-based, string-based]

Parameters:
  -t, --threads <THREADS>  Number of threads to use for sorting (default=1) [default: 1]

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)
  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable [default: 1]
      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable [default: 6]
```


## gia_spacing

### Tool Description
Calculates the spacing between intervals in a BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Calculates the spacing between intervals in a BED file

Usage: gia spacing [OPTIONS]

Options:
  -h, --help  Print help

Single Input Options:
  -i, --input <INPUT>                Input BED file to process (default=stdin)
  -T, --input-format <INPUT_FORMAT>  Format of input file [possible values: bed3, bed4, bed6, gtf, bed12, ambiguous, bed-graph]
  -N, --field-format <FIELD_FORMAT>  Allow for non-integer chromosome names [possible values: integer-based, string-based]

Parameters:
  -s, --is-sorted  

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)
  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable [default: 1]
      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable [default: 6]
```


## gia_subtract

### Tool Description
Subtracts two BED files

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Subtracts two BED files

Will subtract `b` from `a`

Usage: gia subtract [OPTIONS]

Options:
  -h, --help
          Print help (see a summary with '-h')

Dual Input Options:
  -a, --a <A>
          Primary BED file to use (default=stdin)

  -b, --b <B>...
          Secondary BED file(s) to use
          
          Multiple BED files can be provided, mixed format input will be demoted to the lowest rank BED provided.

Parameters:
  -u, --unmerged
          Keep the query records unmerged (i.e. report all subtractions)
          
          By default, the query records are merged to remove overlapping regions.

Overlap Predicates:
  -f, --fraction-query <FRACTION_QUERY>
          Minimum fraction of a's interval that must be covered by b's interval

  -F, --fraction-target <FRACTION_TARGET>
          Minimum fraction of b's interval that must be covered by a's interval

  -r, --reciprocal
          Require that the fraction provided with `-f` is reciprocal to both query and target

  -e, --either
          Requires that either fraction provided with `-f` or `-F` is met

  -s, --strandedness <STRANDEDNESS>
          Strand-specificity to use when comparing intervals
          
          i: Ignore strand (default)
          
          m: Match strand (+/+ or -/- only)
          
          o: Opposite strand (+/- or -/+ only)
          
          [default: i]
          [possible values: i, m, o]

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_unionbedg

### Tool Description
Combines multiple BedGraph files into a single file and shows coverage over segmented intervals of each BedGraph file as a separate column

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Combines multiple BedGraph files into a single file and shows coverage over segmented intervals of each BedGraph file as a separate column

Assumes all input files contain non-overlapping intervals internally

Usage: gia unionbedg [OPTIONS] --inputs <INPUTS> <INPUTS>...

Options:
  -h, --help
          Print help (see a summary with '-h')

Multi Input Options:
  -i, --inputs <INPUTS> <INPUTS>...
          Input BED files to process

Parameters:
  -s, --sorted
          Assume *ALL* input is sorted (default=false)

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_window

### Tool Description
Finds all the overlapping intervals in Set B after adding a window around all intervals in Set A

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Finds all the overlapping intervals in Set B after adding a window around all intervals in Set A

Usage: gia window [OPTIONS]

Options:
  -h, --help
          Print help (see a summary with '-h')

Dual Input Options:
  -a, --a <A>
          Primary BED file to use (default=stdin)

  -b, --b <B>...
          Secondary BED file(s) to use
          
          Multiple BED files can be provided, mixed format input will be demoted to the lowest rank BED provided.

Parameters:
  -v, --inverse
          Only report the intervals in the query that do not overlap with the target (i.e. the inverse of the intersection)

Growth Options:
  -t, --both <BOTH>
          Amount to apply to function on both sides of intervals

  -l, --left <LEFT>
          Amount to apply to function on the left side of intervals

  -r, --right <RIGHT>
          Amount to apply to function on the right side of intervals

  -p, --percent
          Convert values provided to percentages of the interval length

  -g, --genome <GENOME>
          Genome file to validate growth against

  -s, --stranded
          Follow strand specificity when applying growth
          
          i.e. if the strand is negative, apply growth to the right side of the interval when the left side is requested (and vice versa) [default = false]

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```


## gia_bam_convert

### Tool Description
Convert BAM to different formats

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Convert BAM to different formats

Usage: gia bam convert [OPTIONS]

Options:
  -h, --help  Print help

Single BAM Input Options:
  -i, --input <INPUT>  Input BAM file to process (default=stdin)

Parameters:
  -t, --threads <THREADS>  Number of threads to use when reading BAM file [default: 1]
  -c, --conv <CONV>        [default: bed] [possible values: bed, fastq]

BED Conversion Options:
  -C, --cigar  Include CIGAR string in BED output
```

## gia_bam_coverage

### Tool Description
Measure coverage of BAM records over interval regions

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Measure coverage of BAM records over interval regions

Usage: gia bam coverage [OPTIONS] --bed <BED>

Options:
  -h, --help
          Print help (see a summary with '-h')

Mixed BAM/Bed Dual Input:
  -a, --bam <BAM>
          Input BAM file to process (default=stdin)

  -b, --bed <BED>
          Input BED file to process

Parameters:
  -S, --sorted
          Assert that the intervals are presorted in BOTH files (unexpected behavior if they are not)

  -t, --threads <THREADS>
          Number of threads to use when reading BAM file
          
          [default: 1]

Overlap Predicates:
  -f, --fraction-query <FRACTION_QUERY>
          Minimum fraction of a's interval that must be covered by b's interval

  -F, --fraction-target <FRACTION_TARGET>
          Minimum fraction of b's interval that must be covered by a's interval

  -r, --reciprocal
          Require that the fraction provided with `-f` is reciprocal to both query and target

  -e, --either
          Requires that either fraction provided with `-f` or `-F` is met

  -s, --strandedness <STRANDEDNESS>
          Strand-specificity to use when comparing intervals
          
          i: Ignore strand (default)
          
          m: Match strand (+/+ or -/- only)
          
          o: Opposite strand (+/- or -/+ only)
          
          [default: i]
          [possible values: i, m, o]

Output Options:
  -o, --output <OUTPUT>
          Output BED file to write to (default=stdout)

  -j, --compression-threads <COMPRESSION_THREADS>
          Compression threads to use for output files if applicable
          
          [default: 1]

      --compression-level <COMPRESSION_LEVEL>
          Compression level to use for output files if applicable
          
          [default: 6]
```

## gia_bam_filter

### Tool Description
Filter BAM records based on overlap criteria to other regions

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Filter BAM records based on overlap criteria to other regions

Usage: gia bam filter [OPTIONS] --bed <BED>

Options:
  -h, --help
          Print help (see a summary with '-h')

Mixed BAM/Bed Dual Input:
  -a, --bam <BAM>
          Input BAM file to process (default=stdin)

  -b, --bed <BED>
          Input BED file to process

Overlap Predicates:
  -f, --fraction-query <FRACTION_QUERY>
          Minimum fraction of a's interval that must be covered by b's interval

  -F, --fraction-target <FRACTION_TARGET>
          Minimum fraction of b's interval that must be covered by a's interval

  -r, --reciprocal
          Require that the fraction provided with `-f` is reciprocal to both query and target

  -e, --either
          Requires that either fraction provided with `-f` or `-F` is met

  -s, --strandedness <STRANDEDNESS>
          Strand-specificity to use when comparing intervals
          
          i: Ignore strand (default)
          
          m: Match strand (+/+ or -/- only)
          
          o: Opposite strand (+/- or -/+ only)
          
          [default: i]
          [possible values: i, m, o]

Output Predicates:
  -v, --invert
          Only return the records from a that DON'T overlap with b

BAM Output Options:
  -o, --output <OUTPUT>
          Output BAM file to write to (default=stdout)

  -O, --format <FORMAT>
          Output Format to write to (default=BAM)
          
          [default: bam]
          [possible values: bam, sam, cram]

  -t, --threads <THREADS>
          Threads to use when writing BAM files
          
          [default: 1]
```

## gia_bcf_filter

### Tool Description
Filter BCF records based on overlap criteria to other regions

### Metadata
- **Docker Image**: quay.io/biocontainers/gia:0.2.23--h588a25a_0
- **Homepage**: https://github.com/noamteyssier/gia
- **Package**: https://anaconda.org/channels/bioconda/packages/gia/overview
- **Validation**: PASS

### Original Help Text
```text
Filter BCF records based on overlap criteria to other regions

Usage: gia bcf filter [OPTIONS] --bed <BED>

Options:
  -h, --help
          Print help (see a summary with '-h')

Mixed BAM/Bed Dual Input:
  -a, --bcf <BCF>
          Input BCF/VCF file to process (default=stdin)

  -b, --bed <BED>
          Input BED file to process

Overlap Predicates:
  -f, --fraction-query <FRACTION_QUERY>
          Minimum fraction of a's interval that must be covered by b's interval

  -F, --fraction-target <FRACTION_TARGET>
          Minimum fraction of b's interval that must be covered by a's interval

  -r, --reciprocal
          Require that the fraction provided with `-f` is reciprocal to both query and target

  -e, --either
          Requires that either fraction provided with `-f` or `-F` is met

  -s, --strandedness <STRANDEDNESS>
          Strand-specificity to use when comparing intervals
          
          i: Ignore strand (default)
          
          m: Match strand (+/+ or -/- only)
          
          o: Opposite strand (+/- or -/+ only)
          
          [default: i]
          [possible values: i, m, o]

Output Predicates:
  -v, --invert
          Only return the records from a that DON'T overlap with b

BAM Output Options:
  -o, --output <OUTPUT>
          Output BCF file to write to (default=stdout)

  -O, --format <FORMAT>
          Output Format to write to
          
          v/z: VCF (uncompressed/compressed)
          
          u/b: BCF (uncompressed/compressed)
          
          [default: b]
          [possible values: z, v, b, u]

  -t, --threads <THREADS>
          Threads to use when writing BCF/VCF files
          
          [default: 1]
```

## Metadata
- **Skill**: generated
