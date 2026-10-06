# perl-graphviz CWL Generation Report

## Metadata
- **Skill**: generated

## perl-graphviz_circo

### Tool Description
Graphviz circo graph layout engine

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-graphviz:2.26--pl5321h46c88eb_0
- **Homepage**: https://metacpan.org/pod/GraphViz
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-graphviz/overview
- **Validation**: PASS

### Original Help Text
```text
Error: circo: option -- unrecognized

Usage: /usr/local/bin/circo [-Vv?] [-(GNE)name=val] [-(KTlso)<val>] <dot files>
(additional options for neato)    [-x] [-n<v>]
(additional options for fdp)      [-L(gO)] [-L(nUCT)<val>]
(additional options for config)  [-cv]

 -V          - Print version and exit
 -v          - Enable verbose mode 
 -Gname=val  - Set graph attribute 'name' to 'val'
 -Nname=val  - Set node attribute 'name' to 'val'
 -Ename=val  - Set edge attribute 'name' to 'val'
 -Tv         - Set output format to 'v'
 -Kv         - Set layout engine to 'v' (overrides default based on command name)
 -lv         - Use external library 'v'
 -ofile      - Write output to 'file'
 -O          - Automatically generate an output filename based on the input filename with a .'format' appended. (Causes all -ofile options to be ignored.) 
 -P          - Internally generate a graph of the current plugins. 
 -q[l]       - Set level of message suppression (=1)
 -s[v]       - Scale input by 'v' (=72)
 -y          - Invert y coordinate in output

 -n[v]       - No layout mode 'v' (=1)
 -x          - Reduce graph

 -Lg         - Don't use grid
 -LO         - Use old attractive force
 -Ln<i>      - Set number of iterations to i
 -LU<i>      - Set unscaled factor to i
 -LC<v>      - Set overlap expansion factor to v
 -LT[*]<v>   - Set temperature (temperature factor) to v

 -c          - Configure plugins (Writes $prefix/lib/graphviz/config 
               with available plugin information.  Needs write privilege.)
 -?          - Print usage and exit
```
