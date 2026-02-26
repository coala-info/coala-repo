# epic2 CWL Generation Report

## epic2

### Tool Description
epic2, version: 0.0.54 (Visit github.com/endrebak/epic2 for examples and help. Run epic2-example for a simple example command.)

### Metadata
- **Docker Image**: quay.io/biocontainers/epic2:0.0.54--py310h5140242_0
- **Homepage**: http://github.com/endrebak/epic2
- **Package**: https://anaconda.org/channels/bioconda/packages/epic2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/epic2/overview
- **Total Downloads**: 95.4K
- **Last updated**: 2025-12-01
- **GitHub**: https://github.com/endrebak/epic2
- **Stars**: N/A
### Original Help Text
```text
usage: epic2 [-h] --treatment TREATMENT [TREATMENT ...]
             [--control CONTROL [CONTROL ...]] [--genome GENOME]
             [--keep-duplicates] [--original-algorithm] [--bin-size BIN_SIZE]
             [--gaps-allowed GAPS_ALLOWED] [--fragment-size FRAGMENT_SIZE]
             [--false-discovery-rate-cutoff FALSE_DISCOVERY_RATE_CUTOFF]
             [--effective-genome-fraction EFFECTIVE_GENOME_FRACTION]
             [--chromsizes CHROMSIZES] [--e-value E_VALUE]
             [--required-flag REQUIRED_FLAG] [--filter-flag FILTER_FLAG]
             [--mapq MAPQ] [--autodetect-chroms]
             [--discard-chromosomes-pattern DISCARD_CHROMOSOMES_PATTERN]
             [--output OUTPUT] [--original-statistics] [--guess-bampe]
             [--quiet] [--example] [--version]

epic2, version: 0.0.54 (Visit github.com/endrebak/epic2 for examples and help.
Run epic2-example for a simple example command.)

options:
  -h, --help            show this help message and exit
  --treatment TREATMENT [TREATMENT ...], -t TREATMENT [TREATMENT ...]
                        Treatment (pull-down) file(s) in one of these formats:
                        bed, bedpe, bed.gz, bedpe.gz or (single-end) bam, sam.
                        The --guess-bampe flag enables optional support for
                        (paired-end) bampe and sampe formats. Mixing file
                        formats is allowed.
  --control CONTROL [CONTROL ...], -c CONTROL [CONTROL ...]
                        Control (input) file(s) in one of these formats: bed,
                        bedpe, bed.gz, bedpe.gz or (single-end) bam, sam. The
                        --guess-bampe flag enables optional support for
                        (paired-end) bampe and sampe formats. Mixing file
                        formats is allowed.
  --genome GENOME, -gn GENOME
                        Which genome to analyze. Default: hg19. If
                        --chromsizes and --egf flag is given, --genome is not
                        required.
  --keep-duplicates, -kd
                        Keep reads mapping to the same position on the same
                        strand within a library. Default: False.
  --original-algorithm, -oa
                        Use the original SICER algorithm, without the epic2
                        fix. This will use all reads in your files to compute
                        the p-values, including those falling outside the
                        genome boundaries.
  --bin-size BIN_SIZE, -bin BIN_SIZE
                        Size of the windows to scan the genome. BIN-SIZE is
                        the smallest possible island. Default 200.
  --gaps-allowed GAPS_ALLOWED, -g GAPS_ALLOWED
                        This number is multiplied by the window size to
                        determine the number of gaps (ineligible windows)
                        allowed between two eligible windows. Must be an
                        integer. Default: 3.
  --fragment-size FRAGMENT_SIZE, -fs FRAGMENT_SIZE
                        (Single end reads only) Size of the sequenced
                        fragment. Each read is extended half the fragment size
                        from the 5' end. Default 150 (i.e. extend by 75).
  --false-discovery-rate-cutoff FALSE_DISCOVERY_RATE_CUTOFF, -fdr FALSE_DISCOVERY_RATE_CUTOFF
                        Remove all islands with an FDR above cutoff. Default
                        0.05.
  --effective-genome-fraction EFFECTIVE_GENOME_FRACTION, -egf EFFECTIVE_GENOME_FRACTION
                        Use a different effective genome fraction than the one
                        included in epic2. The default value depends on the
                        genome and readlength, but is a number between 0 and
                        1.
  --chromsizes CHROMSIZES, -cs CHROMSIZES
                        Set the chromosome lengths yourself in a file with two
                        columns: chromosome names and sizes. Useful to analyze
                        custom genomes, assemblies or simulated data. Only
                        chromosomes included in the file will be analyzed.
  --e-value E_VALUE, -e E_VALUE
                        The E-value controls the genome-wide error rate of
                        identified islands under the random background
                        assumption. Should be used when not using a control
                        library. Default: 1000.
  --required-flag REQUIRED_FLAG, -f REQUIRED_FLAG
                        (bampe/bam only.) Keep reads with these bits set in
                        flag. Same as `samtools view -f`. Default 0
  --filter-flag FILTER_FLAG, -F FILTER_FLAG
                        (bampe/bam only.) Discard reads with these bits set in
                        flag. Same as `samtools view -F`. Default 1540 (hex:
                        0x604). See
                        https://broadinstitute.github.io/picard/explain-
                        flags.html for more info.
  --mapq MAPQ, -m MAPQ  (bampe/bam only.) Discard reads with mapping quality
                        lower than this. Default 5.
  --autodetect-chroms, -a
                        (bampe/bam only.) Autodetect chromosomes from bam
                        file. Use with --discard-chromosomes flag to avoid
                        non-canonical chromosomes.
  --discard-chromosomes-pattern DISCARD_CHROMOSOMES_PATTERN, -d DISCARD_CHROMOSOMES_PATTERN
                        (bampe/bam only.) Discard reads from chromosomes
                        matching this pattern. Default '_'. Note that if you
                        are not interested in the results from non-canonical
                        chromosomes, you should ensure they are removed with
                        this flag, otherwise they will make the statistical
                        analysis too stringent.
  --output OUTPUT, -o OUTPUT
                        File to write results to. Default: stdout.
  --original-statistics
                        Use the original SICER way of computing the
                        statistics. Like SICER itself, this method raises an
                        error on large datasets. Only included for debugging-
                        purposes.
  --guess-bampe         Autodetect bampe file format based on flags from the
                        first 100 reads. If all of them are paired, then the
                        format is bampe. Only properly paired reads are
                        processed by default (0x1 and 0x2 samtools flags).
  --quiet, -q           Do not write output messages to stderr.
  --example, -ex        Show the paths of the example data and an example
                        command.
  --version, -v         show program's version number and exit
```

