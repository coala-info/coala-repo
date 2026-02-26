# cogclassifier CWL Generation Report

## cogclassifier_COGclassifier

### Tool Description
A tool for classifying prokaryote protein sequences into COG functional category

### Metadata
- **Docker Image**: quay.io/biocontainers/cogclassifier:2.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/moshi4/COGclassifier/
- **Package**: https://anaconda.org/channels/bioconda/packages/cogclassifier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cogclassifier/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/moshi4/COGclassifier
- **Stars**: N/A
### Original Help Text
```text
Usage: COGclassifier [OPTIONS]                                                 
                                                                                
 A tool for classifying prokaryote protein sequences into COG functional        
 category                                                                       
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --infile        -i        Input query protein fasta file [required]       │
│ *  --outdir        -o        Output directory [required]                     │
│    --download_dir  -d        Download COG & CDD resources directory          │
│                              [default: /root/.cache/cogclassifier_v2]        │
│    --thread_num    -t        RPS-BLAST num_thread parameter [default: 19]    │
│    --evalue        -e        RPS-BLAST e-value parameter [default: 0.01]     │
│    --quiet         -q        No print log on screen                          │
│    --version       -v        Print version information                       │
│    --help          -h        Show this message and exit.                     │
╰──────────────────────────────────────────────────────────────────────────────╯
```

