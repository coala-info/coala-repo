# jclusterfunk CWL Generation Report

## jclusterfunk_annotate

### Tool Description
Annotate tips and nodes from a metadata table.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/snake-flu/jclusterfunk
- **Stars**: N/A
### Original Help Text
```text
Missing required options: i, o, m

usage: jclusterfunk annotate [-c <column name>] [-f <nexus|newick>]
       [--field-delimiter <delimiter>] [-h] -i <file> [--ignore-missing]
       [-l <columns>] -m <file> [-n <field number>] -o <file> [-r]
       [--tip-attributes <columns>] [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: annotate

Annotate tips and nodes from a metadata table.

 -c,--id-column <column name>       metadata column to use to match tip
                                    labels (default first column)
 -f,--format <nexus|newick>         output file format (nexus or newick)
    --field-delimiter <delimiter>   the delimiter used to specify fields
                                    in the tip labels (default = '|')
 -h,--help                          display help
 -i,--input <file>                  input tree file
    --ignore-missing                ignore any missing matches in
                                    annotations table (default false)
 -l,--label-fields <columns>        a list of metadata columns to add as
                                    tip label fields
 -m,--metadata <file>               input metadata file
 -n,--id-field <field number>       tip label field to use to match
                                    metadata (default = whole label)
 -o,--output <file>                 output file
 -r,--replace                       replace the annotations or tip label
                                    headers rather than appending (default
                                    false)
    --tip-attributes <columns>      a list of metadata columns to add as
                                    tip attributes
 -v,--verbose                       write analysis details to console
    --version                       display version
```

