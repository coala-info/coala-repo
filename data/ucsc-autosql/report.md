# ucsc-autosql CWL Generation Report

## ucsc-autosql_autoSql

### Tool Description
create SQL and C code for permanently storing a structure in database and loading it back into memory based on a specification file

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-autosql:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-autosql/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-autosql/overview
- **Total Downloads**: 24.2K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
autoSql - create SQL and C code for permanently storing
a structure in database and loading it back into memory
based on a specification file
usage:
    autoSql specFile outRoot {optional: -dbLink -withNull -json} 
This will create outRoot.sql outRoot.c and outRoot.h based
on the contents of specFile. 

options:
  -dbLink - optionally generates code to execute queries and
            updates of the table.
  -addBin - Add an initial bin field and index it as (chrom,bin)
  -withNull - optionally generates code and .sql to enable
              applications to accept and load data into objects
              with potential 'missing data' (NULL in SQL)
              situations.
  -defaultZeros - will put zero and or empty string as default value
  -django - generate method to output object as django model Python code
  -json - generate method to output the object in JSON (JavaScript) format.
```

