# jclusterfunk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| jclusterfunk_annotate | Failed | tool bug: --field-delimiter is silently ignored (the source reads it under the misspelled name 'field-delimeter'), so labels are always split on '\|'; annotation with the default delimiter works. |
| jclusterfunk_assign | Failed | tool bug: --field-delimiter is ignored (option name typo in the tool source), so tip labels are always split on the default delimiter; main mode works |
| jclusterfunk_cluster | PASS |  |
| jclusterfunk_collapse | PASS |  |
| jclusterfunk_convert | PASS |  |
| jclusterfunk_divide | PASS |  |
| jclusterfunk_extract | Failed | tool bug: --field-delimiter is ignored (option name typo in the tool source); main mode works |
| jclusterfunk_insert | Failed | tool bug: --field-delimiter is ignored (option name typo in the tool source); main mode ran on synthetic data (insert list planted from real tip names) |
| jclusterfunk_merge | Failed | tool bug: --add-columns is ignored (all columns of the second table are merged); main mode works |
| jclusterfunk_prune | Failed | tool bug: --field-delimiter is ignored (option name typo in the tool source); main mode works |
| jclusterfunk_reorder | Failed | tool bug: --sort-by crashes (not implemented), --field-delimiter is ignored, and --increasing/--decreasing give the reverse clade-size order |
| jclusterfunk_reroot | Failed | tool bug: --field-delimiter and --id-field are ignored (option name mismatch in the tool source); outgroup and midpoint rooting work |
| jclusterfunk_sample | Failed | tool bug: --field-delimiter is ignored (option name typo in the tool source); main mode works |
| jclusterfunk_scale | PASS |  |
| jclusterfunk_split | Failed | tool bug: --output-metadata is ignored (no metadata file is written); main mode works |
| jclusterfunk_statistics | Failed | tool bug: output file is always empty (writer is never closed) |

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

## jclusterfunk_assign

### Tool Description
Clean and assign lineage annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, m, o, a

usage: jclusterfunk assign -a <attribute_name> [-c <column name>] [-d
       <file>] [-f <nexus|newick>] [--field-delimiter <delimiter>] [-h] -i
       <file> -m <file> [-n <field number>] -o <file> [--out-attribute
       <name>] [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: assign

Clean and assign lineage annotations.

 -a,--attribute <attribute_name>    the attribute name
 -c,--id-column <column name>       metadata column to use to match tip
                                    labels (default first column)
 -d,--output-metadata <file>        output a metadata file to match the
                                    output tree
 -f,--format <nexus|newick>         output file format (nexus or newick)
    --field-delimiter <delimiter>   the delimiter used to specify fields
                                    in the tip labels (default = '|')
 -h,--help                          display help
 -i,--input <file>                  input tree file
 -m,--metadata <file>               input metadata file
 -n,--id-field <field number>       tip label field to use to match
                                    metadata (default = whole label)
 -o,--output <file>                 output file
    --out-attribute <name>          the new attribute name in output
 -v,--verbose                       write analysis details to console
    --version                       display version
```

## jclusterfunk_cluster

### Tool Description
label clusters by number based on node attributes.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, o, a, value, cluster-name

usage: jclusterfunk cluster -a <attribute_name> --cluster-name <name>
       [--cluster-prefix <prefix>] [-d <file>] [-f <nexus|newick>] [-h] -i
       <file> -o <file> [-v] --value <attribute_value> [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: cluster

label clusters by number based on node attributes.

 -a,--attribute <attribute_name>   the attribute name
    --cluster-name <name>          the cluster name
    --cluster-prefix <prefix>      the cluster prefix (default = just a
                                   number)
 -d,--output-metadata <file>       output a metadata file to match the
                                   output tree
 -f,--format <nexus|newick>        output file format (nexus or newick)
 -h,--help                         display help
 -i,--input <file>                 input tree file
 -o,--output <file>                output file
 -v,--verbose                      write analysis details to console
    --value <attribute_value>      the attribute value
    --version                      display version
```

## jclusterfunk_collapse

### Tool Description
collapse branch lengths below a threshold into polytomies

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, o, t

usage: jclusterfunk collapse [-f <nexus|newick>] [-h] -i <file> -o <file>
       -t <length> [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: collapse

collapse branch lengths below a threshold into polytomies

 -f,--format <nexus|newick>   output file format (nexus or newick)
 -h,--help                    display help
 -i,--input <file>            input tree file
 -o,--output <file>           output file
 -t,--threshold <length>      the threshold for branch lengths to be
                              collapsed into polytomies
 -v,--verbose                 write analysis details to console
    --version                 display version
```

## jclusterfunk_extract

### Tool Description
Extract tip annotations as a metadata csv.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, o

usage: jclusterfunk extract [-c <column name>] [--field-delimiter
       <delimiter>] [-h] -i <file> [--ignore-missing] [-n <field number>]
       -o <file> [--taxon-file <file>] [--tip-attributes <columns>] [-v]
       [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: extract

Extract tip annotations as a metadata csv.

 -c,--id-column <column name>       metadata column to use to match tip
                                    labels (default first column)
    --field-delimiter <delimiter>   the delimiter used to specify fields
                                    in the tip labels (default = '|')
 -h,--help                          display help
 -i,--input <file>                  input tree file
    --ignore-missing                ignore any missing matches in
                                    annotations table (default false)
 -n,--id-field <field number>       tip label field to use to match
                                    metadata (default = whole label)
 -o,--output <file>                 output file
    --taxon-file <file>             file of taxa (in a CSV table or tree)
    --tip-attributes <columns>      a list of metadata columns to add as
                                    tip attributes
 -v,--verbose                       write analysis details to console
    --version                       display version
```

## jclusterfunk_convert

### Tool Description
Convert tree from one format to another.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, o

usage: jclusterfunk convert [-f <nexus|newick>] [-h] -i <file> -o <file>
       [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: convert

Convert tree from one format to another.

 -f,--format <nexus|newick>   output file format (nexus or newick)
 -h,--help                    display help
 -i,--input <file>            input tree file
 -o,--output <file>           output file
 -v,--verbose                 write analysis details to console
    --version                 display version
```

## jclusterfunk_divide

### Tool Description
Divide tree into approximately equal sized subtrees.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, p

usage: jclusterfunk divide [-f <nexus|newick>] [-h] -i <file> [--max-count
       <count> | --min-size <size>]  [-o <path>] -p <file_prefix>
       [--require-outgroup] [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: divide

Divide tree into approximately equal sized subtrees.

 -f,--format <nexus|newick>   output file format (nexus or newick)
 -h,--help                    display help
 -i,--input <file>            input tree file
    --max-count <count>       maximum number of subtrees
    --min-size <size>         minimum number of tips in a subtree
 -o,--output <path>           output path
 -p,--prefix <file_prefix>    output file prefix
    --require-outgroup        only divide subtrees where the
                              representative is an outgroup (default
                              false)
 -v,--verbose                 write analysis details to console
    --version                 display version
```

## jclusterfunk_insert

### Tool Description
Insert tips into the tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, m, o

usage: jclusterfunk insert [-c <column name>] [--destination-column
       <column name>] [-f <nexus|newick>] [--field-delimiter <delimiter>]
       [-h] -i <file> [--ignore-missing] -m <file> [-n <field number>] -o
       <file> [--unique-only] [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: insert

Insert tips into the tree.

 -c,--id-column <column name>            metadata column to use to match
                                         tip labels (default first column)
    --destination-column <column name>   metadata column for destination
                                         to insert tips
 -f,--format <nexus|newick>              output file format (nexus or
                                         newick)
    --field-delimiter <delimiter>        the delimiter used to specify
                                         fields in the tip labels (default
                                         = '|')
 -h,--help                               display help
 -i,--input <file>                       input tree file
    --ignore-missing                     ignore any missing matches in
                                         annotations table (default false)
 -m,--metadata <file>                    input metadata file
 -n,--id-field <field number>            tip label field to use to match
                                         metadata (default = whole label)
 -o,--output <file>                      output file
    --unique-only                        only place tips that have an
                                         unique position (default false)
 -v,--verbose                            write analysis details to console
    --version                            display version
```

## jclusterfunk_merge

### Tool Description
Merge two metadata tables

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, m, o

usage: jclusterfunk merge [-a <columns>] [-c <column name>] [--extract]
       [-h] -i <file> -m <file> -o <file> [--overwrite] [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: merge

Merge two metadata tables

 -a,--add-columns <columns>     a list of metadata columns to add
 -c,--id-column <column name>   metadata column to use to match tip labels
                                (default first column)
    --extract                   extract only the matching rows (default
                                false)
 -h,--help                      display help
 -i,--input <file>              input tree file
 -m,--metadata <file>           input metadata file
 -o,--output <file>             output file
    --overwrite                 overwrite existing values (default false)
 -v,--verbose                   write analysis details to console
    --version                   display version
```

## jclusterfunk_prune

### Tool Description
Prune out taxa from a list or based on metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, o

usage: jclusterfunk prune [-c <column name>] [-d <file>] [-f
       <nexus|newick>] [--field-delimiter <delimiter>] [-h] -i <file>
       [--ignore-missing] [-k] [-m <file>] [-n <field number>] -o <file>
       [-t <taxon-ids>] [--taxon-file <file>] [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: prune

Prune out taxa from a list or based on metadata.

 -c,--id-column <column name>       metadata column to use to match tip
                                    labels (default first column)
 -d,--output-metadata <file>        output a metadata file to match the
                                    output tree
 -f,--format <nexus|newick>         output file format (nexus or newick)
    --field-delimiter <delimiter>   the delimiter used to specify fields
                                    in the tip labels (default = '|')
 -h,--help                          display help
 -i,--input <file>                  input tree file
    --ignore-missing                ignore any missing matches in
                                    annotations table (default false)
 -k,--keep-taxa                     keep only the taxa specifed (default
                                    false)
 -m,--metadata <file>               input metadata file
 -n,--id-field <field number>       tip label field to use to match
                                    metadata (default = whole label)
 -o,--output <file>                 output file
 -t,--taxa <taxon-ids>              a list of taxon ids
    --taxon-file <file>             file of taxa (in a CSV table or tree)
 -v,--verbose                       write analysis details to console
    --version                       display version
```

## jclusterfunk_reorder

### Tool Description
Re-order nodes in ascending or descending clade size.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, o

usage: jclusterfunk reorder [-c <column name>] [--decreasing |
       --increasing | --sort-by <columns>] [-f <nexus|newick>]
       [--field-delimiter <delimiter>] [-h] -i <file>  [-m <file>] [-n
       <field number>] -o <file>  [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: reorder

Re-order nodes in ascending or descending clade size.

 -c,--id-column <column name>       metadata column to use to match tip
                                    labels (default first column)
    --decreasing                    order nodes by decreasing clade size
 -f,--format <nexus|newick>         output file format (nexus or newick)
    --field-delimiter <delimiter>   the delimiter used to specify fields
                                    in the tip labels (default = '|')
 -h,--help                          display help
 -i,--input <file>                  input tree file
    --increasing                    order nodes by increasing clade size
 -m,--metadata <file>               input metadata file
 -n,--id-field <field number>       tip label field to use to match
                                    metadata (default = whole label)
 -o,--output <file>                 output file
    --sort-by <columns>             a list of metadata columns to sort by
                                    (prefix by ^ to reverse order)
 -v,--verbose                       write analysis details to console
    --version                       display version
```

## jclusterfunk_reroot

### Tool Description
Re-root the tree using an outgroup.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, o

usage: jclusterfunk reroot [-f <nexus|newick>] [--field-delimiter
       <delimiter>] [-h] -i <file> [--midpoint | --outgroups <tips>] [-n
       <field number>] -o <file>  [--root-location <fraction>] [-v]
       [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: reroot

Re-root the tree using an outgroup.

 -f,--format <nexus|newick>         output file format (nexus or newick)
    --field-delimiter <delimiter>   the delimiter used to specify fields
                                    in the tip labels (default = '|')
 -h,--help                          display help
 -i,--input <file>                  input tree file
    --midpoint                      midpoint root the tree
 -n,--id-field <field number>       tip label field to use to match
                                    metadata (default = whole label)
 -o,--output <file>                 output file
    --outgroups <tips>              a list of tips to use as an outgroup
                                    for re-rooting
    --root-location <fraction>      location on the root branch for the
                                    root as a fraction of the branch
                                    length from the ingroup
 -v,--verbose                       write analysis details to console
    --version                       display version
```

## jclusterfunk_sample

### Tool Description
Sample taxa down using metadata attributes.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, m, p

usage: jclusterfunk sample [-c <column name>] [--clump-by
       <attribute_name>] [--collapse-by <attribute_name>] [-f
       <nexus|newick>] [--field-delimiter <delimiter>] [-h] -i <file>
       [--ignore-missing] -m <file> [--max-soft <size>] [--min-clumped
       <size>] [--min-collapsed <size>] [-n <field number>] [-o <path>] -p
       <file_prefix> [-t <taxon-ids>] [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: sample

Sample taxa down using metadata attributes.

 -c,--id-column <column name>        metadata column to use to match tip
                                     labels (default first column)
    --clump-by <attribute_name>      an attribute to clump homogenous
                                     children by
    --collapse-by <attribute_name>   an attribute to collapse homogenous
                                     subtrees by
 -f,--format <nexus|newick>          output file format (nexus or newick)
    --field-delimiter <delimiter>    the delimiter used to specify fields
                                     in the tip labels (default = '|')
 -h,--help                           display help
 -i,--input <file>                   input tree file
    --ignore-missing                 ignore any missing matches in
                                     annotations table (default false)
 -m,--metadata <file>                input metadata file
    --max-soft <size>                maximum number of tips in a soft
                                     collapsed node
    --min-clumped <size>             minimum number of tips in a clump
    --min-collapsed <size>           minimum number of tips in a collapsed
                                     subtree
 -n,--id-field <field number>        tip label field to use to match
                                     metadata (default = whole label)
 -o,--output <path>                  output path
 -p,--prefix <file_prefix>           output file prefix
 -t,--taxa <taxon-ids>               a list of taxon ids
 -v,--verbose                        write analysis details to console
    --version                        display version
```

## jclusterfunk_scale

### Tool Description
Scale all the branch lengths in a tree by a factor.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, o, s

usage: jclusterfunk scale [-f <nexus|newick>] [-h] -i <file> -o <file> -s
       <value> [-t <length>] [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: scale

Scale all the branch lengths in a tree by a factor.

 -f,--format <nexus|newick>   output file format (nexus or newick)
 -h,--help                    display help
 -i,--input <file>            input tree file
 -o,--output <file>           output file
 -s,--factor <value>          the factor to scale all branches by
 -t,--threshold <length>      the threshold for branch lengths to be
                              collapsed into polytomies
 -v,--verbose                 write analysis details to console
    --version                 display version
```

## jclusterfunk_split

### Tool Description
Split out subtrees based on tip annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, p, a

usage: jclusterfunk split -a <attribute_name> [-d <file>] [-f
       <nexus|newick>] [-h] -i <file> [-m <file>] [-o <path>] -p
       <file_prefix> [-v] [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: split

Split out subtrees based on tip annotations.

 -a,--attribute <attribute_name>   the attribute name
 -d,--output-metadata <file>       output a metadata file to match the
                                   output tree
 -f,--format <nexus|newick>        output file format (nexus or newick)
 -h,--help                         display help
 -i,--input <file>                 input tree file
 -m,--metadata <file>              input metadata file
 -o,--output <path>                output path
 -p,--prefix <file_prefix>         output file prefix
 -v,--verbose                      write analysis details to console
    --version                      display version
```

## jclusterfunk_statistics

### Tool Description
Extract statistics and information from trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
- **Homepage**: https://github.com/snake-flu/jclusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/jclusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: i, o, stats

usage: jclusterfunk statistics [-h] -i <file> -o <file> --stats [-v]
       [--version]
jclusterfunk v0.0.25
Bunch of functions for trees

Command: statistics

Extract statistics and information from trees.

 -h,--help            display help
 -i,--input <file>    input tree file
 -o,--output <file>   output file
    --stats           a list of statistics to include in the output (see
                      docs for details)
 -v,--verbose         write analysis details to console
    --version         display version
```
