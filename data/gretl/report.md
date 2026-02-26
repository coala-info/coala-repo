# gretl CWL Generation Report

## gretl_block

### Tool Description
Statistics on pangenome blocks

### Metadata
- **Docker Image**: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
- **Homepage**: https://github.com/moinsebi/gretl
- **Package**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/moinsebi/gretl
- **Stars**: N/A
### Original Help Text
```text
gretl-block 

Statistics on pangenome blocks

USAGE:
    gretl block --graph <gfa> --output <output>

FLAGS:
    -h, --help       Print help information
    -V, --version    Print version information

Input parameters:
    -g, --graph <gfa>      GFA input file
        --pansn <PanSN>    PanSN-spec separator [default: "\n"]

Block definition parameter:
    -s, --node-step <node-step>                Node step [default: 1000]
    -w, --node-window <node-window>            Window size (in nodes) [defaul: 1000]
        --sequence-step <sequence-step>        Sequence step
        --sequence-window <sequence-window>    Sequence window

Block extension criteria:
    -d, --distance <distance>    Distance till breaking the block [bp] [default: 10000]

Output parameter:
    -b, --blocks               Output all blocks in a this file
    -o, --output <output>      Output file name
    -t, --threads <threads>    Number of threads [default: 1]
```


## gretl_bootstrap

### Tool Description
Bootstrap approach

### Metadata
- **Docker Image**: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
- **Homepage**: https://github.com/moinsebi/gretl
- **Package**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Validation**: PASS

### Original Help Text
```text
gretl-bootstrap 

Bootstrap approach

USAGE:
    gretl bootstrap --gfa <gfa> --output <output>

FLAGS:
    -h, --help       Print help information
    -V, --version    Print version information

Input options:
    -g, --gfa <gfa>         Input GFA file
        --pansn <Pan-SN>    Separate by first entry in Pan-SN spec [default: "\n"]

Performance options:
    -t, --threads <threads>    Number of threads [default: 1]

Modification parameters:
        --nodes <nodes>      Run bootstrap only on these nodes
        --number <number>    How many bootstraps do you want to run [default: 20]

Output options:
        --meta-output <meta-output>    Output meta file
    -o, --output <output>              Output
```


## gretl_core

### Tool Description
General graph similarity statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
- **Homepage**: https://github.com/moinsebi/gretl
- **Package**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Validation**: PASS

### Original Help Text
```text
gretl-core 

General graph similarity statistics

USAGE:
    gretl core --gfa <gfa> --output <output>

FLAGS:
    -h, --help       Print help information
    -V, --version    Print version information

Input options:
    -g, --gfa <gfa>         Input GFA file
        --pansn <Pan-SN>    Separate by first entry in Pan-SN spec [default: "\n"]

Counting options:
    -s, --stats <statistics>    similarity, depth, node degree [default: similarity]

Performance options:
    -t, --threads <threads>    Number of threads to use [default: 1]

Output options:
    -o, --output <output>    Output
```


## gretl_find

### Tool Description
Find features in the graph and return a BED file for further analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
- **Homepage**: https://github.com/moinsebi/gretl
- **Package**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Validation**: PASS

### Original Help Text
```text
gretl-find 

Find features in the graph and return a BED file for further analysis

USAGE:
    gretl find --gfa <gfa> --features <features> --output <output> --length <length>

FLAGS:
    -h, --help       Print help information
    -V, --version    Print version information

OPTIONS:
    -f, --features <features>    Input feature file (one feature per line). Example: 1 (node), 1+
                                 (dirnode), 1+2+ (edge)
    -g, --gfa <gfa>              Input GFA file
    -l, --length <length>        Length
    -o, --output <output>        Output file
```


## gretl_id2int

### Tool Description
Convert node identifier to numeric values (not sorted)

### Metadata
- **Docker Image**: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
- **Homepage**: https://github.com/moinsebi/gretl
- **Package**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Validation**: PASS

### Original Help Text
```text
gretl-id2int 

Convert node identifier to numeric values (not sorted)

USAGE:
    gretl id2int --gfa <gfa> --output <output>

FLAGS:
    -h, --help       Print help information
    -V, --version    Print version information

Input options:
    -g, --gfa <gfa>            Input GFA file
    -t, --threads <threads>    Number of threads [default: 1]

Output options:
    -d, --dict <dict>        Write a dictionary for Old->New identifiers in this file.
    -o, --output <output>    Output file name
```


## gretl_node-list

### Tool Description
Statistics for each node

### Metadata
- **Docker Image**: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
- **Homepage**: https://github.com/moinsebi/gretl
- **Package**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Validation**: PASS

### Original Help Text
```text
gretl-node-list 

Statistics for each node

USAGE:
    gretl node-list --gfa <gfa> --output <output>

FLAGS:
    -h, --help       Print help information
    -V, --version    Print version information

Input options:
    -g, --gfa <gfa>         Input GFA file
    -s, --pansn <Pan-SN>    Separate by first entry in Pan-SN spec [default: "\n"]

Restrict your output parameters:
    -f, --feature <Features>    Name the features you need. If nothing is used, report everything.
                                Example -f 'Length,Core'

Performance options:
    -t, --threads <threads>    Number of threads [default: 1]

Output options:
    -o, --output <output>    Output
```


## gretl_nwindow

### Tool Description
Extending from a single node

### Metadata
- **Docker Image**: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
- **Homepage**: https://github.com/moinsebi/gretl
- **Package**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Validation**: PASS

### Original Help Text
```text
gretl-nwindow 

Extending from a single node

USAGE:
    gretl nwindow --gfa <gfa> --output <output>

FLAGS:
    -h, --help       Print help information
    -V, --version    Print version information

Input options:
    -g, --gfa <gfa>    Input GFA file

Stop criteria:
        --jumps                  Sum of 'id jumps' away from the starting node
        --sequence <sequence>    Amount of sequence away from the starting node
        --step <step>            Number of steps away from the starting node [default: 10]

Performance options:
    -t, --threads <threads>    Number of threads [default: 1]

Output option:
    -o, --output <output>    Output
```


## gretl_ps

### Tool Description
How much core, soft and private genome is in each sample?

### Metadata
- **Docker Image**: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
- **Homepage**: https://github.com/moinsebi/gretl
- **Package**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Validation**: PASS

### Original Help Text
```text
gretl-ps 

How much core, soft and private genome is in each sample?

USAGE:
    gretl ps --gfa <gfa> --output <output>

FLAGS:
    -h, --help       Print help information
    -V, --version    Print version information

Input options:
    -g, --gfa <gfa>        Input GFA file
        --pansn <PanSN>    Separate by first entry in Pan-SN spec [default: "\n"]

Performance options:
    -t, --threads <threads>    Number of threads to use [default: 1]

Output options:
    -o, --output <output>    Output
```


## gretl_stats

### Tool Description
Basic graph statistics for a single graph

### Metadata
- **Docker Image**: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
- **Homepage**: https://github.com/moinsebi/gretl
- **Package**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Validation**: PASS

### Original Help Text
```text
gretl-stats 

Basic graph statistics for a single graph

USAGE:
    gretl stats --gfa <gfa> --output <output>

FLAGS:
    -h, --help       Print help information
    -V, --version    Print version information

Input options:
    -g, --gfa <gfa>        Input GFA file
        --haplo            Make stats for each haplotype (not sample, not path). Only in combination
                           with Pan-SN
        --pansn <PanSN>    Separator for Pan-SN spec [default: "\n"]

Other options:
        --bins <bins>          Size of bins. Example: Format 10,20,30 -> (0-10, 11-20, 30+)[default:
                               1,50,100,1000]
    -p, --path                 Report path statistics (default:off -> report graph stats)
    -t, --threads <threads>    Number of threads [default: 1]

Output options:
    -o, --output <output>    Output
    -y                       Report output in YAML format (default:off -> report in tsv)
```


## gretl_window

### Tool Description
Sliding window analysis (path-centric)

### Metadata
- **Docker Image**: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
- **Homepage**: https://github.com/moinsebi/gretl
- **Package**: https://anaconda.org/channels/bioconda/packages/gretl/overview
- **Validation**: PASS

### Original Help Text
```text
gretl-window 

Sliding window analysis (path-centric)

USAGE:
    gretl window --gfa <gfa> --output <output>

FLAGS:
    -h, --help       Print help information
    -V, --version    Print version information

Input options:
    -g, --gfa <gfa>         Input GFA file
        --pansn <Pan-SN>    Separate by first entry in Pan-SN spec [default: "\n"]

Window parameter:
    -s, --step-size <step-size>        Step size [default: 100000]
    -w, --window-size <window-size>    Size of a single window [default: 100000]

Other options:
    -m, --metric <metric>      Which metric do you wanna have reported? Example: 'similarity',
                               'nodesize', 'depth' [default: similarity]
    -n, --node                 Window on node level ([default: off] -> on sequence)
    -t, --threads <threads>    Number of threads [default: 1]

Output options:
    -o, --output <output>    Output
```

