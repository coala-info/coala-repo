# cmseq CWL Generation Report

## cmseq_breadth_depth.py

### Tool Description
calculate the Breadth and Depth of coverage of BAMFILE.

### Metadata
- **Docker Image**: quay.io/biocontainers/cmseq:1.0.4--pyhb7b1952_0
- **Homepage**: https://github.com/SegataLab/cmseq
- **Package**: https://anaconda.org/channels/bioconda/packages/cmseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cmseq/overview
- **Total Downloads**: 39.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SegataLab/cmseq
- **Stars**: N/A
### Original Help Text
```text
usage: breadth_depth.py [-h] [-c REFERENCE ID] [-f] [--sortindex]
                        [--minlen MINLEN] [--minqual MINQUAL]
                        [--mincov MINCOV] [--truncate TRUNCATE] [--combine]
                        BAMFILE

calculate the Breadth and Depth of coverage of BAMFILE.

positional arguments:
  BAMFILE               The file on which to operate

optional arguments:
  -h, --help            show this help message and exit
  -c REFERENCE ID, --contig REFERENCE ID
                        Focus on a subset of references in the BAM file. Can
                        be a list of references separated by commas or a FASTA
                        file (the IDs are used to subset)
  -f                    If set unmapped (FUNMAP), secondary (FSECONDARY), qc-
                        fail (FQCFAIL) and duplicate (FDUP) are excluded. If
                        unset ALL reads are considered (bedtools genomecov
                        style). Default: unset
  --sortindex           Sort and index the file
  --minlen MINLEN       Minimum Reference Length for a reference to be
                        considered
  --minqual MINQUAL     Minimum base quality. Bases with quality score lower
                        than this will be discarded. This is performed BEFORE
                        --mincov. Default: 30
  --mincov MINCOV       Minimum position coverage to perform the polymorphism
                        calculation. Position with a lower depth of coverage
                        will be discarded (i.e. considered as zero-coverage
                        positions). This is calculated AFTER --minqual.
                        Default: 1
  --truncate TRUNCATE   Number of nucleotides that are truncated at either
                        contigs end before calculating coverage values.
  --combine             Combine all contigs into one giant contig and report
                        it at the end
```


## cmseq_polymut.py

### Tool Description
Reports the polymorphic rate of each reference (polymorphic bases / total bases). Focuses only on covered regions (i.e. depth >= 1)

### Metadata
- **Docker Image**: quay.io/biocontainers/cmseq:1.0.4--pyhb7b1952_0
- **Homepage**: https://github.com/SegataLab/cmseq
- **Package**: https://anaconda.org/channels/bioconda/packages/cmseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: polymut.py [-h] [-c REFERENCE ID] [-f] [--sortindex] [--minlen MINLEN]
                  [--minqual MINQUAL] [--mincov MINCOV]
                  [--dominant_frq_thrsh DOMINANT_FRQ_THRSH]
                  [--gff_file GFF_FILE]
                  BAMFILE

Reports the polymorpgic rate of each reference (polymorphic bases / total
bases). Focuses only on covered regions (i.e. depth >= 1)

positional arguments:
  BAMFILE               The file on which to operate

optional arguments:
  -h, --help            show this help message and exit
  -c REFERENCE ID, --contig REFERENCE ID
                        Focus on a subset of references in the BAM file. Can
                        be a list of references separated by commas or a FASTA
                        file (the IDs are used to subset)
  -f                    If set unmapped (FUNMAP), secondary (FSECONDARY), qc-
                        fail (FQCFAIL) and duplicate (FDUP) are excluded. If
                        unset ALL reads are considered (bedtools genomecov
                        style). Default: unset
  --sortindex           Sort and index the file
  --minlen MINLEN       Minimum Reference Length for a reference to be
                        considered. Default: 0
  --minqual MINQUAL     Minimum base quality. Bases with quality score lower
                        than this will be discarded. This is performed BEFORE
                        --mincov. Default: 30
  --mincov MINCOV       Minimum position coverage to perform the polymorphism
                        calculation. Position with a lower depth of coverage
                        will be discarded (i.e. considered as zero-coverage
                        positions). This is calculated AFTER --minqual.
                        Default:1
  --dominant_frq_thrsh DOMINANT_FRQ_THRSH
                        Cutoff for degree of `allele dominance` for a position
                        to be considered polymorphic. Default: 0.8
  --gff_file GFF_FILE   GFF file used to extract protein-coding genes
```

