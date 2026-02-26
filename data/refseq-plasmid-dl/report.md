# refseq-plasmid-dl CWL Generation Report

## refseq-plasmid-dl

### Tool Description
Download, curate, and filter plasmid sequences from the NCBI RefSeq database.

### Metadata
- **Docker Image**: quay.io/biocontainers/refseq-plasmid-dl:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/erinyoung/refseq-plasmid-dl
- **Package**: https://anaconda.org/channels/bioconda/packages/refseq-plasmid-dl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/refseq-plasmid-dl/overview
- **Total Downloads**: 46
- **Last updated**: 2025-12-04
- **GitHub**: https://github.com/erinyoung/refseq-plasmid-dl
- **Stars**: N/A
### Original Help Text
```text
usage: refseq-plasmid-dl [-h] [--version] [--outdir OUTDIR] [--indir INDIR]
                         [--dev-mode] [--force] [--organism ORGANISM]
                         [--taxid TAXID] [--strain STRAIN] [--isolate ISOLATE]
                         [--host HOST] [--plasmid-name PLASMID_NAME]
                         [--geo_loc_name GEO_LOC_NAME]
                         [--isolation_source ISOLATION_SOURCE]
                         [--min-length MIN_LENGTH] [--max-length MAX_LENGTH]
                         [--topology {circular,linear,all}]
                         [--min-date MIN_DATE] [--max-date MAX_DATE]
                         [--min-collection-date MIN_COLLECTION_DATE]
                         [--max-collection-date MAX_COLLECTION_DATE]

Download, curate, and filter plasmid sequences from the NCBI RefSeq database.

options:
  -h, --help            show this help message and exit
  --version, -v         Show the program version and exit.
  --outdir, -o OUTDIR   Directory to save FASTA files, reports, and final multi-FASTA (default: refseq_plasmids).
  --indir, -i INDIR     Directory where FASTA and GBFF files have already been downloaded. If provided, skips the download step.
  --dev-mode, -d        Enables development mode: fetches only a single test file group.
  --force               Force re-download of files even if they already exist locally.

Taxonomy Filters:
  --organism, -s ORGANISM
                        Filter by species/organism (e.g. "Salmonella"). Case-insensitive substring match. Default: all
  --taxid, -t TAXID     Filter by NCBI Taxonomy ID (e.g. "28901"). Default: all

Metadata Filters:
  --strain STRAIN       Filter by Strain (substring match).
  --isolate ISOLATE     Filter by Isolate (substring match).
  --host HOST           Filter by Host (substring match, e.g. "Homo sapiens").
  --plasmid-name PLASMID_NAME
                        Filter by Plasmid Name (substring match).
  --geo_loc_name GEO_LOC_NAME
                        Filter by Geographic Location Name (substring match).
  --isolation_source ISOLATION_SOURCE
                        Filter by Isolation Source (substring match).

Sequence Properties Filters:
  --min-length MIN_LENGTH
                        Minimum sequence length (bp).
  --max-length MAX_LENGTH
                        Maximum sequence length (bp).
  --topology {circular,linear,all}
                        Filter by topology (circular or linear). Default: circular

Date Filters:
  --min-date MIN_DATE   Include only records updated after YYYY-MM-DD.
  --max-date MAX_DATE   Include only records updated before YYYY-MM-DD.
  --min-collection-date MIN_COLLECTION_DATE
                        Include only records collected after YYYY-MM-DD.
  --max-collection-date MAX_COLLECTION_DATE
                        Include only records collected before YYYY-MM-DD.
```


## Metadata
- **Skill**: generated
