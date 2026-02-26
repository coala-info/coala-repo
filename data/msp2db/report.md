# msp2db CWL Generation Report

## msp2db

### Tool Description
Convert msp to SQLite or MySQL database

### Metadata
- **Docker Image**: quay.io/biocontainers/msp2db:0.0.9--py_0
- **Homepage**: https://github.com/computational-metabolomics/msp2db
- **Package**: https://anaconda.org/channels/bioconda/packages/msp2db/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msp2db/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/computational-metabolomics/msp2db
- **Stars**: N/A
### Original Help Text
```text
usage: PROG [-h] -m MSP_PTH -s SOURCE [-o OUT_PTH] [-t TYPE] [-d] [-l MSLEVEL]
            [-p POLARITY] [-c CHUNK] [-x SCHEMA] [-y]

Convert msp to SQLite or MySQL database

optional arguments:
  -h, --help            show this help message and exit
  -m MSP_PTH, --msp_pth MSP_PTH
                        Path to the MSP file (or directory of msp files)
  -s SOURCE, --source SOURCE
                        Name of data source (e.g. MassBank, LipidBlast)
  -o OUT_PTH, --out_pth OUT_PTH
                        File path for SQLite database
  -t TYPE, --db_type TYPE
                        Database type [mysql, sqlite]
  -d, --delete_tables   Delete tables
  -l MSLEVEL, --mslevel MSLEVEL
                        MS level of fragmentation if not detailed in msp file
  -p POLARITY, --polarity POLARITY
                        Polarity of fragmentation if not detailed in msp file
  -c CHUNK, --chunk CHUNK
                        Chunks of spectra to parse data (useful to control
                        memory usage)
  -x SCHEMA, --schema SCHEMA
                        Type of schema used (by default is "mona" msp style
                        but can use "massbank" style
  -y, --ignore_compound_lookup
                        ignore searching of compounds for each spectra based
                        on meta information in the MSP file

--------------
```

