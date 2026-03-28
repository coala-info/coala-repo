# teloclip CWL Generation Report

## teloclip_extend

### Tool Description
Extend contigs using overhang analysis from soft-clipped alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/teloclip:0.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/teloclip
- **Package**: https://anaconda.org/channels/bioconda/packages/teloclip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/teloclip/overview
- **Total Downloads**: 11.6K
- **Last updated**: 2025-11-12
- **GitHub**: https://github.com/Adamtaranto/teloclip
- **Stars**: N/A
### Original Help Text
```text
Usage: teloclip extend [OPTIONS] BAM_FILE REFERENCE_FASTA

  Extend contigs using overhang analysis from soft-clipped alignments.

Options:
  --output-fasta PATH             Extended FASTA output file
  --stats-report PATH             Statistics report output file
  --exclude-outliers              Exclude outlier contigs from extension
  --outlier-threshold FLOAT       Z-score threshold for outlier detection
                                  (default: 2.0)
  --min-overhangs INTEGER         Minimum supporting overhangs required
                                  (default: 1)
  --max-homopolymer INTEGER       Maximum homopolymer run length allowed
                                  (default: 500)
  --min-extension INTEGER         Minimum overhang length for extension
                                  (default: 1)
  --max-break INTEGER             Maximum gap allowed between alignment and
                                  contig end (default: 10)
  --min-anchor INTEGER            Minimum anchor length required for alignment
                                  (default: 100)
  --dry-run                       Report extensions without modifying
                                  sequences
  --count-motifs TEXT             Comma-delimited motif sequences to count in
                                  overhang regions (e.g., "TTAGGG,CCCTAA")
  --fuzzy-count                   Use fuzzy motif matching allowing ±1
                                  character variation when counting motifs
  --prefix TEXT                   Prefix for default output filenames
                                  (default: teloclip_extended)
  --screen-terminal-bases INTEGER
                                  Number of terminal bases to screen for
                                  motifs in original contigs (default: 0,
                                  disabled)
  --exclude-contigs TEXT          Comma-delimited list of contig names to
                                  exclude from extension (e.g.,
                                  "chrM,chrC,scaffold_123")
  --exclude-contigs-file PATH     Text file containing contig names to exclude
                                  (one per line)
  --log-level [debug|info|warning|error]
                                  Logging level (default: INFO).
  --help                          Show this message and exit.
```


## teloclip_extract

### Tool Description
Extract overhanging reads for each end of each reference contig. Reads are always written to output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/teloclip:0.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/teloclip
- **Package**: https://anaconda.org/channels/bioconda/packages/teloclip/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: teloclip extract [OPTIONS] [SAMFILE]

  Extract overhanging reads for each end of each reference contig. Reads are
  always written to output files.

Options:
  --ref-idx PATH                  Path to fai index for reference fasta. Index
                                  fasta using `samtools faidx FASTA`
                                  [required]
  --prefix TEXT                   Use this prefix for output files. Default:
                                  None.
  --extract-dir PATH              Write extracted reads to this directory.
                                  Default: cwd.
  --min-clip INTEGER              Require clip to extend past ref contig end
                                  by at least N bases. Default: 1
  --max-break INTEGER             Tolerate max N unaligned bases before contig
                                  end. Default: 50
  --min-anchor INTEGER            Minimum anchored alignment length required
                                  (default: 100).
  --min-mapq INTEGER              Minimum mapping quality required (default:
                                  0).
  --keep-secondary                If set, include secondary alignments in
                                  output. Default: Off (exclude secondary
                                  alignments).
  --include-stats                 Include mapping quality, clip length, and
                                  motif counts in FASTA headers.
  --count-motifs TEXT             Comma-delimited motif sequences to count in
                                  overhang regions (e.g., "TTAGGG,CCCTAA").
  --fuzzy-count                   Use fuzzy motif matching allowing ±1
                                  character variation when counting motifs.
  --buffer-size INTEGER           Number of sequences to buffer before writing
                                  (default: 1000).
  --output-format [fasta|fastq]   Output format for extracted sequences
                                  (default: fasta).
  --report-stats                  Write extraction statistics to file in
                                  output directory.
  --no-mask-overhangs             Do not convert overhang sequences to
                                  lowercase.
  --log-level [DEBUG|INFO|WARNING|ERROR]
                                  Logging level (default: INFO).
  --help                          Show this message and exit.
```


## teloclip_filter

### Tool Description
Filter SAM file for clipped alignments containing unassembled telomeric
  repeats.

### Metadata
- **Docker Image**: quay.io/biocontainers/teloclip:0.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/teloclip
- **Package**: https://anaconda.org/channels/bioconda/packages/teloclip/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: teloclip filter [OPTIONS] [SAMFILE]

  Filter SAM file for clipped alignments containing unassembled telomeric
  repeats.

Options:
  --ref-idx PATH                  Path to fai index for reference fasta. Index
                                  fasta using `samtools faidx FASTA`
                                  [required]
  --min-clip INTEGER              Require clip to extend past ref contig end
                                  by at least N bases. Default: 1
  --max-break INTEGER             Tolerate max N unaligned bases before contig
                                  end. Default: 50
  --motifs TEXT                   If set keep only reads containing given
                                  motif/s from comma delimited list of
                                  strings. By default also search for reverse
                                  complement of motifs. i.e. TTAGGG,TTAAGGG
                                  will also match CCCTAA,CCCTTAA
  --no-rev                        If set do NOT search for reverse complement
                                  of specified motifs.
  --keep-secondary                If set, include secondary alignments in
                                  output. Default: Off (exclude secondary
                                  alignments).
  --fuzzy                         If set, tolerate +/- 1 variation in motif
                                  homopolymer runs i.e. TTAGGG ->
                                  T{1,3}AG{2,4}. Default: Off
  -r, --min-repeats INTEGER       Minimum number of sequential pattern matches
                                  required for a hit to be reported. Default:
                                  1
  --min-anchor INTEGER            Minimum number of aligned bases (anchor)
                                  required on the non-clipped portion of the
                                  read. Default: 100
  --match-anywhere                If set, motif match may occur in unclipped
                                  region of reads.
  --log-level [debug|info|warning|error]
                                  Logging level (default: INFO).
  --help                          Show this message and exit.
```


## Metadata
- **Skill**: generated
