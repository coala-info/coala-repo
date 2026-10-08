# epik CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| epik_place | PASS | New file for the real subcommand; placed 6 query proteins on the IPK repository's D140 test database, with sister sequences on adjacent edges. |
## epik_place

### Tool Description
Places .fasta files using the input IPK database.

### Metadata
- **Docker Image**: quay.io/biocontainers/epik:0.2.0--h077b44d_2
- **Homepage**: https://github.com/phylo42/epik
- **Package**: https://anaconda.org/channels/bioconda/packages/epik/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: epik.py place [OPTIONS] INPUT_FILE

  Places .fasta files using the input IPK database.

  epik.py place -s [nucl|amino] -i DB.ipk -o output file.fasta [file2.fasta
  ...]

  Examples:     epik.py place -i DB.ipk -o temp --max-ram 4G --threads 8
  query.fasta

Options:
  -i, --database FILE        Input database.  [required]
  -s, --states [nucl|amino]  States used in analysis.  [default: nucl;
                             required]
  --omega FLOAT              User omega value, determines the score threhold.
  --mu FLOAT                 The proportion of the database to keep.
  -o, --outputdir DIRECTORY  Output directory.  [required]
  --threads INTEGER          Number of threads used.  [default: 1]
  --max-ram TEXT             Approximate RAM limit to use. Database may not be
                             fully loaded
  --help                     Show this message and exit.
```


