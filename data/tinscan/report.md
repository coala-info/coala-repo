# tinscan CWL Generation Report

## tinscan_tinscan-prep

### Tool Description
Split multifasta genome files into directories for A and B genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/TE-insertion-scanner
- **Package**: https://anaconda.org/channels/bioconda/packages/tinscan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tinscan/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Adamtaranto/TE-insertion-scanner
- **Stars**: N/A
### Original Help Text
```text
usage: tinscan-prep [-h] -A TARGET -B QUERY [--adir ADIR] [--bdir BDIR]
                    [-d OUTDIR]

Split multifasta genome files into directories for A and B genomes.

options:
  -h, --help            show this help message and exit
  -A TARGET, --target TARGET
                        Multifasta containing A genome.
  -B QUERY, --query QUERY
                        Multifasta containing B genome.
  --adir ADIR           A genome sub-directory within outdir
  --bdir BDIR           B genome sub-directory within outdir
  -d OUTDIR, --outdir OUTDIR
                        Write split directories within this directory.
                        (Default: cwd)
```


## tinscan_tinscan-align

### Tool Description
Align B genome (query) sequences onto A genome (target) using LASTZ.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/TE-insertion-scanner
- **Package**: https://anaconda.org/channels/bioconda/packages/tinscan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tinscan-align [-h] --adir ADIR --bdir BDIR [--pairs PAIRS] [-d OUTDIR]
                     [--outfile OUTFILE] [-v] [--lzpath LZPATH]
                     [--minIdt MINIDT] [--minLen MINLEN]
                     [--hspthresh HSPTHRESH]

Align B genome (query) sequences onto A genome (target) using LASTZ.

options:
  -h, --help            show this help message and exit
  --adir ADIR           Name of directory containing sequences from A genome.
  --bdir BDIR           Name of directory containing sequences from B genome.
  --pairs PAIRS         Optional: Tab-delimited 2-col file specifying
                        target:query sequence pairs to be aligned
  -d OUTDIR, --outdir OUTDIR
                        Write output files to this directory. (Default: cwd)
  --outfile OUTFILE     Name of alignment result file.
  -v, --verbose         If set report LASTZ progress.
  --lzpath LZPATH       Custom path to LASTZ executable if not in $PATH.
  --minIdt MINIDT       Minimum alignment identity to report.
  --minLen MINLEN       Minimum alignment length to report.
  --hspthresh HSPTHRESH
                        LASTZ min HSP threshold. Increase for stricter
                        matches.
```


## tinscan_tinscan-find

### Tool Description
Parse whole genome alignments for signatures of transposon insertion.

### Metadata
- **Docker Image**: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/TE-insertion-scanner
- **Package**: https://anaconda.org/channels/bioconda/packages/tinscan/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tinscan-find [-h] -i INFILE [--outdir OUTDIR] [--gffOut GFFOUT]
                    [--noflanks] [--maxTSD MAXTSD] [--maxInsert MAXINSERT]
                    [--minInsert MININSERT] [--qGap QGAP]
                    [--minIdent MINIDENT] [--maxIdentDiff MAXIDENTDIFF]

Parse whole genome alignments for signatures of transposon insertion.

options:
  -h, --help            show this help message and exit
  -i INFILE, --infile INFILE
                        Input file containing tab delimited LASTZ alignment
                        data.
  --outdir OUTDIR       Optional: Directory to write output to.
  --gffOut GFFOUT       Write features to this file as gff3.
  --noflanks            If set, do not report flanking hit regions in GFF.
  --maxTSD MAXTSD       Maximum overlap of insertion flanking sequences in
                        QUERY genome to be considered as target site
                        duplication. Flank pairs with greater overlaps will be
                        discarded Note: Setting this value too high may result
                        in tandem duplications in the target genome being
                        falsely classified as insertion events.
  --maxInsert MAXINSERT
                        Maximum length of sequence to consider as an insertion
                        event.
  --minInsert MININSERT
                        Minimum length of sequence to consider as an insertion
                        event. Note: If too short may detect small non-TE
                        indels.
  --qGap QGAP           Maximum gap allowed between aligned flanks in QUERY
                        sequence. Equivalent to target sequence deleted upon
                        insertion event.
  --minIdent MINIDENT   Minimum identity for a hit to be considered.
  --maxIdentDiff MAXIDENTDIFF
                        Maximum divergence in identity (to query) allowed
                        between insert flanking sequences.
```

