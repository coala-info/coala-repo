# epic CWL Generation Report

## epic

### Tool Description
Diffuse domain ChIP-Seq caller based on SICER. (Visit github.com/endrebak/epic for examples and help.)

### Metadata
- **Docker Image**: quay.io/biocontainers/epic:0.2.12--py35h24bf2e0_1
- **Homepage**: http://github.com/endrebak/epic
- **Package**: https://anaconda.org/channels/bioconda/packages/epic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/epic/overview
- **Total Downloads**: 119.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/endrebak/epic
- **Stars**: N/A
### Original Help Text
```text
usage: epic [-h] --treatment TREATMENT [TREATMENT ...] --control CONTROL
            [CONTROL ...] [--number-cores NUMBER_CORES] [--genome GENOME]
            [--keep-duplicates] [--window-size WINDOW_SIZE]
            [--gaps-allowed GAPS_ALLOWED] [--fragment-size FRAGMENT_SIZE]
            [--false-discovery-rate-cutoff FALSE_DISCOVERY_RATE_CUTOFF]
            [--effective-genome-fraction EFFECTIVE_GENOME_FRACTION]
            [--chromsizes CHROMSIZES] [--store-matrix STORE_MATRIX]
            [--bigwig BIGWIG]
            [--individual-log2fc-bigwigs INDIVIDUAL_LOG2FC_BIGWIGS]
            [--chip-bigwig CHIP_BIGWIG] [--input-bigwig INPUT_BIGWIG]
            [--log2fc-bigwig LOG2FC_BIGWIG] [--bed BED] [--log LOG]
            [--outfile OUTFILE] [--version]

Diffuse domain ChIP-Seq caller based on SICER. (Visit github.com/endrebak/epic
for examples and help.)

optional arguments:
  -h, --help            show this help message and exit
  --treatment TREATMENT [TREATMENT ...], -t TREATMENT [TREATMENT ...]
                        Treatment (pull-down) file(s) in (b/gzipped) bed/bedpe
                        format.
  --control CONTROL [CONTROL ...], -c CONTROL [CONTROL ...]
                        Control (input) file(s) in (b/gzipped) bed/bedpe
                        format.
  --number-cores NUMBER_CORES, -cpu NUMBER_CORES
                        Number of cpus to use. Can use at most one per
                        chromosome. Default: 1.
  --genome GENOME, -gn GENOME
                        Which genome to analyze. Default: hg19. If
                        --chromsizes flag is given, --genome is not required.
  --keep-duplicates, -k
                        Keep reads mapping to the same position on the same
                        strand within a library. Default is to remove all but
                        the first duplicate.
  --window-size WINDOW_SIZE, -w WINDOW_SIZE
                        Size of the windows to scan the genome. WINDOW_SIZE is
                        the smallest possible island. Default 200.
  --gaps-allowed GAPS_ALLOWED, -g GAPS_ALLOWED
                        This number is multiplied by the window size to
                        determine the gap size. Must be an integer. Default:
                        3.
  --fragment-size FRAGMENT_SIZE, -fs FRAGMENT_SIZE
                        (Single end reads only) Size of the sequenced
                        fragment. The center of the the fragment will be taken
                        as half the fragment size. Default 150.
  --false-discovery-rate-cutoff FALSE_DISCOVERY_RATE_CUTOFF, -fdr FALSE_DISCOVERY_RATE_CUTOFF
                        Remove all islands with an FDR below cutoff. Default
                        0.05.
  --effective-genome-fraction EFFECTIVE_GENOME_FRACTION, -egf EFFECTIVE_GENOME_FRACTION
                        Use a different effective genome fraction than the one
                        included in epic. The default value depends on the
                        genome and readlength, but is a number between 0 and
                        1.
  --chromsizes CHROMSIZES, -cs CHROMSIZES
                        Set the chromosome lengths yourself in a file with two
                        columns: chromosome names and sizes. Useful to analyze
                        custom genomes, assemblies or simulated data. Only
                        chromosomes included in the file will be analyzed.
  --store-matrix STORE_MATRIX, -sm STORE_MATRIX
                        Store the matrix of counts per bin for ChIP and input
                        to gzipped file <STORE_MATRIX>.
  --bigwig BIGWIG, -bw BIGWIG
                        For each file, store a bigwig of both enriched and
                        non-enriched regions to folder <BIGWIG>. Requires
                        different basenames for each file.
  --individual-log2fc-bigwigs INDIVIDUAL_LOG2FC_BIGWIGS, -i2bw INDIVIDUAL_LOG2FC_BIGWIGS
                        For each file, store a bigwig of the log2fc of
                        ChIP/(Sum Input) to folder <INDIVIDUAL-LOG2FC-
                        BIGWIGS>. Requires different basenames for each file.
  --chip-bigwig CHIP_BIGWIG, -cbw CHIP_BIGWIG
                        Store an RPKM-normalized summed bigwig for all ChIP
                        files in file <CHIP-BIGWIG>.
  --input-bigwig INPUT_BIGWIG, -ibw INPUT_BIGWIG
                        Store an RPKM-normalized summed bigwig for all Input
                        files in file <INPUT-BIGWIG>.
  --log2fc-bigwig LOG2FC_BIGWIG, -2bw LOG2FC_BIGWIG
                        Store an log2(ChIP/Input) bigwig in file <LOG2FC-
                        BIGWIG>. (Both ChIP and Input are RPKM-normalized
                        before dividing.)
  --bed BED, -b BED     A summary bed file of all regions for display in the
                        UCSC genome browser or downstream analyses with e.g.
                        bedtools. The score field is log2(#ChIP/#Input) * 100
                        capped at a 1000.
  --log LOG, -l LOG     File to write log messages to.
  --outfile OUTFILE, -o OUTFILE
                        File to write results to. By default sent to stdout.
  --version, -v         show program's version number and exit
```

