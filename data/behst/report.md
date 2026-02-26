# behst CWL Generation Report

## behst

### Tool Description
Genomic set enrichment analysis enhanced through integration of chromatin long-range interactions

### Metadata
- **Docker Image**: quay.io/biocontainers/behst:3.8--0
- **Homepage**: https://bitbucket.org/hoffmanlab/behst/overview
- **Package**: https://anaconda.org/channels/bioconda/packages/behst/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/behst/overview
- **Total Downloads**: 82.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: behst [-h] [-T BP] [-Q BP] [-d DATADIR] [-g FILE] [-t FILE] [-i FILE]
             [--no-gprofiler] [-v]
             BEDFILE

positional arguments:
  BEDFILE               path to query genomic region file (BED format) regions

optional arguments:
  -h, --help            show this help message and exit
  -T BP, --target-extension BP
                        extend target regions by BP base pairs (default 9400)
  -Q BP, --query-extension BP
                        extend query regions by BP base pairs (default 24100)
  -d DATADIR, --data DATADIR
                        path to directory with reference data (default
                        ~/.local/share/behst)
  -g FILE, --gene-annotation-file FILE
                        path of gene annotation file (GTF format, default
                        DATADIR/gencode.v19.annotation_withproteinids.gtf).
  -t FILE, --transcript-file FILE
                        path to the principal transcript file (BED format,
                        default DATADIR/appris_data_principal.bed)
  -i FILE, --interaction-file FILE
                        path to the chromatin interactions file (HICCUPS
                        Format, default DATADIR/hic_8celltypes.hiccups).
  --no-gprofiler        If activated, generate the gene list and do not call
                        g:ProfileR)
  -v, --version         print current BEHST version

Citation: Chicco D, Bi HS, Reimand J, Hoffman MM. 2018. "BEHST: Genomic set
enrichment analysis enhanced through integration of chromatin long-range
interactions". In preparation.
```


## Metadata
- **Skill**: generated
