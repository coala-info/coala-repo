# ucsc-ldhggene CWL Generation Report

## ucsc-ldhggene_ldHgGene

### Tool Description
load database with gene predictions from a gff file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-ldhggene:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-ldhggene/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-ldhggene/overview
- **Total Downloads**: 18.3K
- **Last updated**: 2025-06-30
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
ldHgGene - load database with gene predictions from a gff file.
usage:
     ldHgGene database table file(s).gff
options:
     -bin         Add bin column (now the default)
     -nobin       don't add binning (you probably don't want this)
     -exon=type   Sets type field for exons to specific value
     -oldTable    Don't overwrite what's already in table
     -noncoding   Forces whole prediction to be UTR
     -gtf         input is GTF, stop codon is not in CDS
     -predTab     input is already in genePredTab format
     -requireCDS  discard genes that don't have CDS annotation
     -out=gpfile  write output, in genePred format, instead of loading
                  table. Database is ignored.
     -genePredExt create a extended genePred, including frame
                  information and gene name
     -impliedStopAfterCds - implied stop codon in GFF/GTF after CDS
```

