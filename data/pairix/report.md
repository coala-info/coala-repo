# pairix CWL Generation Report

## pairix

### Tool Description
PAIRs file IndeXer

### Metadata
- **Docker Image**: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
- **Homepage**: https://github.com/4dn-dcic/pairix
- **Package**: https://anaconda.org/channels/bioconda/packages/pairix/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pairix/overview
- **Total Downloads**: 173.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/4dn-dcic/pairix
- **Stars**: N/A
### Original Help Text
```text
Program: pairix (PAIRs file IndeXer)
Version: 0.3.8

Usage:   pairix <in.pairs.gz> [region1 [region2 [...]]]

Options: -p STR     preset: pairs, merged_nodups, old_merged_nodups, gff, bed, sam, vcf, psltbl [gff]
         -s INT     sequence name column [1]
         -d INT     second sequence name column [null]
         -b INT     start1 column [4]
         -e INT     end1 column; can be identical to '-b' [5]
         -u INT     start2 column [null]
         -v INT     end2 column; can be identical to '-u' [null or identical to the start2 specified by -u]
         -T         delimiter is space instead of tab.
         -L         query region is not a string but a file listing query regions
         -S INT     skip first INT lines [0]
         -c CHAR    symbol for comment/meta lines [#]
         -w CHAR    symbol for query region separator [|]
         -r FILE    replace the header with the content of FILE [null]
         -0         zero-based coordinate
         -h         print also the header lines
         -H         print only the header lines
         -B         print only the number of bgzf blocks for existing chromosome (pairs)
         -W         print only the region split character
         -Y         Only check if the file is a triangle (i.e. a chromosome pair occurs only in one direction (e.g. if chr1|chr2 exists, chr2|chr1 doesn't))
         -l         list chromosome names
         -n         print only the total line count (same as gunzip -c | wc -l but much faster)
         -f         force to overwrite the index
         -a         autoflip query when the matching chromosome pair doesn't exist
         --help     print usage with exit 0
```

