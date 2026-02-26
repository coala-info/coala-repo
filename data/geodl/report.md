# geodl CWL Generation Report

## geodl_geoDL

### Tool Description
Download fastq from The European Nucleotide Archive (ENA) http://www.ebi.ac.uk/ena website using a GSE geo http://www.ncbi.nlm.nih.gov/geo/info/seq.html accession, ENA study accession or a metadata file from ENA

### Metadata
- **Docker Image**: quay.io/biocontainers/geodl:1.0b5.1--py36_0
- **Homepage**: https://github.com/jduc/geoDL
- **Package**: https://anaconda.org/channels/bioconda/packages/geodl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/geodl/overview
- **Total Downloads**: 15.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jduc/geoDL
- **Stars**: N/A
### Original Help Text
```text
[34m
################################################################################
               ___  _
  __ _ ___ ___|   \| |
 / _` / -_) _ \ |) | |__
 \__, \___\___/___/|____|
 |___/                   v1.0.b5

################################################################################
[39m
usage: geoDL [-h] [--dry] [--samples [SAMPLES [SAMPLES ...]]]
             [--colname COLNAME]
             {geo,meta,ena} GSE|metadata|ENA

Download fastq from The European Nucleotide Archive (ENA)
<http://www.ebi.ac.uk/ena> website using a GSE geo
<http://www.ncbi.nlm.nih.gov/geo/info/seq.html> accession, ENA study accession
or a metadata file from ENA

positional arguments:
  {geo,meta,ena}        Specify which type of input
  GSE|metadata|ENA      geo:  GSE accession number, eg: GSE13373
                              Map the GSE accession to the ENA study accession and fetch the metadata
                        
                        meta: Use metadata file instead of fetching it on ENA website (bypass GEO)
                              Meta data should include at minima the following columns: ['Fastq files
                              (ftp)', 'Submitter's sample name']
                        
                        ena:  ENA study accession number, eg: PRJEB13373
                              Fetch the metadata directely on the ENA website

optional arguments:
  -h, --help            show this help message and exit
  --dry                 Don't actually download anything, just print the wget
                        cmds
  --samples [SAMPLES [SAMPLES ...]]
                        Space separated list of GSM samples to download. For
                        ENA mode, subset the metadata
  --colname COLNAME     Name of the column to use in the metadata file to name
                        the samples

Made with <3 at the batcave
```

