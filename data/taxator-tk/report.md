# taxator-tk CWL Generation Report

## taxator-tk_fasta-strip-identifier

### Tool Description
Strips the identifier from FASTA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxator-tk:1.3.3e--0
- **Homepage**: https://github.com/fungs/taxator-tk
- **Package**: https://anaconda.org/channels/bioconda/packages/taxator-tk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxator-tk/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fungs/taxator-tk
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fasta-strip-identifier", line 21, in <module>
    while line_outer:
NameError: name 'line_outer' is not defined
```


## taxator-tk_taxator

### Tool Description
Specify a taxonomy mapping file for the reference sequence identifiers

### Metadata
- **Docker Image**: quay.io/biocontainers/taxator-tk:1.3.3e--0
- **Homepage**: https://github.com/fungs/taxator-tk
- **Package**: https://anaconda.org/channels/bioconda/packages/taxator-tk/overview
- **Validation**: PASS

### Original Help Text
```text
Specify a taxonomy mapping file for the reference sequence identifiers
Allowed options:
  -h [ --help ]                      show help message
  --citation                         show citation info
  --advanced-options                 show advanced program options
  -a [ --algorithm ] arg (=rpa)      set the algorithm that is used to predict 
                                     taxonomic ids from alignments
  -g [ --seqid-taxid-mapping ] arg   filename of seqid->taxid mapping for 
                                     reference
  -q [ --query-sequences ] arg       query sequences FASTA
  -v [ --query-sequences-index ] arg query sequences FASTA index, for 
                                     out-of-memory operation; is created if not
                                     existing
  -f [ --ref-sequences ] arg         reference sequences FASTA
  -i [ --ref-sequences-index ] arg   FASTA file index, for out-of-memory 
                                     operation; is created if not existing
  -p [ --processors ] arg (=1)       sets number of threads, number > 2 will 
                                     heavily profit from multi-core 
                                     architectures, set to 0 for max. 
                                     performance
  -l [ --logfile ] arg (=/dev/null)  specify name of file for logging 
                                     (appending lines)
```


## Metadata
- **Skill**: generated
