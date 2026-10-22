# trace2dbest CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| trace2dbest_rename_file | PASS |  |

## trace2dbest_rename_file

### Tool Description
Rename sets of trace files into EGTDC style trace names.

### Metadata
- **Docker Image**: biocontainers/trace2dbest:v3.0.1-1-deb_cv1
- **Homepage**: https://sourceforge.net/projects/trace2dbest/
- **Package**: https://anaconda.org/channels/bioconda/packages/trace2dbest/overview
- **Validation**: PASS

### Original Help Text
```text
Usage : rename_files.pl <list of arguments>
 -dir <txt> - set directory of traces <dir> to <txt>
 -add <txt> - <txt> gets added to the beginning of each
                    tracefile in directory <dir>
 -end <txt> - <txt> gets added to the end of each tracefile
 -txt <txt1> - <txt> gets removed from each file
 -sub <txt2> - (only with -txt set) txt1 is replaced by txt2
 -format         - Traces are reformatted to correct 96 well
                   nomenclature. Single digits are replaced by double
                   digits and row ID set to uppercase
                   In addition, if your files do not contain
                   plate coordinates, but are numbered sequentially
                   e.g. trace1, trace2, trace3 etc. this option will
                   convert the numbers into 96 well format
                   (it assumes 1-12 refer to row A columns 1-12 etc.)
 -help           - Get more detailed help
```

## Metadata
- **Skill**: not generated
