# sr2silo CWL Generation Report

## sr2silo_process-from-vpipe

### Tool Description
V-PIPE to SILO conversion with amino acids and special metadata. Processing only - use 'submit-to-loculus' command to upload and submit to SILO.

### Metadata
- **Docker Image**: quay.io/biocontainers/sr2silo:1.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/sr2silo
- **Package**: https://anaconda.org/channels/bioconda/packages/sr2silo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sr2silo/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/cbg-ethz/sr2silo
- **Stars**: N/A
### Original Help Text
```text
Usage: sr2silo process-from-vpipe [OPTIONS]                                    
                                                                                
 V-PIPE to SILO conversion with amino acids and special metadata. Processing    
 only - use 'submit-to-loculus' command to upload and submit to SILO.           
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input-file           -i                     PATH  Path to the input     │
│                                                        file.                 │
│                                                        [required]            │
│ *  --sample-id            -s                     TEXT  Sample ID to use for  │
│                                                        metadata.             │
│                                                        [required]            │
│ *  --output-fp            -o                     PATH  Path to the output    │
│                                                        file. Must end with   │
│                                                        .ndjson.              │
│                                                        [required]            │
│ *  --timeline-file        -t                     PATH  Path to the timeline  │
│                                                        file.                 │
│                                                        [required]            │
│    --organism                                    TEXT  Organism identifier   │
│                                                        (e.g., 'covid',       │
│                                                        'rsva'). Used to      │
│                                                        locate local          │
│                                                        reference files at    │
│                                                        resources/references… │
│                                                        Falls back to LAPIS   │
│                                                        URL if provided. Can  │
│                                                        also be set via       │
│                                                        ORGANISM environment  │
│                                                        variable.             │
│    --lapis-url            -r                     TEXT  URL of LAPIS          │
│                                                        instance, hosting     │
│                                                        SILO database. Used   │
│                                                        to fetch the          │
│                                                        nucleotide / amino    │
│                                                        acid reference.       │
│                                                        References are cached │
│                                                        to                    │
│                                                        ~/.cache/sr2silo/ref… │
│    --nuc-ref                                     PATH  Path to nucleotide    │
│                                                        reference FASTA file. │
│                                                        If not provided,      │
│                                                        fetched from LAPIS or │
│                                                        loaded from cache.    │
│    --aa-ref                                      PATH  Path to amino acid    │
│                                                        reference FASTA file. │
│                                                        If not provided,      │
│                                                        fetched from LAPIS or │
│                                                        loaded from cache.    │
│    --skip-merge               --no-skip-merge          Skip merging of       │
│                                                        paired-end reads.     │
│                                                        [default:             │
│                                                        no-skip-merge]        │
│    --reference-accession                         TEXT  Filter reads to only  │
│                                                        include those aligned │
│                                                        to this reference     │
│                                                        accession. Should     │
│                                                        match @SQ SN field in │
│                                                        BAM header (find      │
│                                                        with: samtools view   │
│                                                        -H file.bam | grep    │
│                                                        @SQ). If not          │
│                                                        specified, all reads  │
│                                                        are processed.        │
│    --help                                              Show this message and │
│                                                        exit.                 │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## sr2silo_submit-to-loculus

### Tool Description
Upload processed file to S3 and submit to SILO/Loculus.

### Metadata
- **Docker Image**: quay.io/biocontainers/sr2silo:1.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/sr2silo
- **Package**: https://anaconda.org/channels/bioconda/packages/sr2silo/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sr2silo submit-to-loculus [OPTIONS]                                     
                                                                                
 Upload processed file to S3 and submit to SILO/Loculus.                        
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --nucleotide-alignment  -a      PATH     Path to nucleotide alignment     │
│                                             file (e.g., .bam) used to create │
│                                             the processed .ndjson.zst file.  │
│                                             [required]                       │
│ *  --processed-file        -f      PATH     Path to the processed            │
│                                             .ndjson.zst file to upload and   │
│                                             submit.                          │
│                                             [required]                       │
│    --keycloak-token-url            TEXT     Keycloak authentication URL.     │
│                                             Falls back to KEYCLOAK_TOKEN_URL │
│                                             environment variable.            │
│    --backend-url                   TEXT     Loculus backend URL. Falls back  │
│                                             to BACKEND_URL environment       │
│                                             variable.                        │
│    --group-id                      INTEGER  Group ID for submission. Falls   │
│                                             back to GROUP_ID environment     │
│                                             variable.                        │
│    --organism                      TEXT     Organism identifier for          │
│                                             submission. Falls back to        │
│                                             ORGANISM environment variable.   │
│    --username                      TEXT     Username for authentication.     │
│                                             Falls back to USERNAME           │
│                                             environment variable.            │
│    --password                      TEXT     Password for authentication.     │
│                                             Falls back to PASSWORD           │
│                                             environment variable.            │
│    --auto-release          -r               Automatically release/approve    │
│                                             sequences after submission.      │
│                                             Falls back to AUTO_RELEASE       │
│                                             environment variable. Default:   │
│                                             False.                           │
│    --release-delay                 INTEGER  Seconds to wait before releasing │
│                                             sequences (to allow backend      │
│                                             processing). Only used when      │
│                                             --auto-release is enabled.       │
│                                             Default: 180.                    │
│                                             [default: 180]                   │
│    --help                                   Show this message and exit.      │
╰──────────────────────────────────────────────────────────────────────────────╯
```

