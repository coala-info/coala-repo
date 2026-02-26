# gap CWL Generation Report

## gap

### Tool Description
run the Groups, Algorithms and Programming system, Version 4.8.10

### Metadata
- **Docker Image**: quay.io/biocontainers/gap:4.8.10--0
- **Homepage**: https://github.com/MacGapProject/MacGap1
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/gap/overview
- **Total Downloads**: 321.1K
- **Last updated**: 2026-01-28
- **GitHub**: https://github.com/MacGapProject/MacGap1
- **Stars**: N/A
### Original Help Text
```text
usage: gap [OPTIONS] [FILES]
       run the Groups, Algorithms and Programming system, Version 4.8.10

 -h, --help                   print this help and exit
 -b, --banner                 disable/enable the banner
 -q, --quiet                  enable/disable quiet mode
 -e                           disable/enable quitting on <ctr>-D
 -f                           force line editing
 -n                           prevent line editing
 -E, --readline               disable/enable use of readline library (if
                              possible)
 -x, --width        <num>     set line width
 -y, --lines        <num>     set number of lines

 -g, --gasinfo                show GASMAN messages (full/all/no garbage
                              collections)
 -m, --minworkspace <mem>     set the initial workspace size
 -o, --maxworkspace <mem>     set hint for maximal workspace size (GAP may
                              allocate more)
 -K, --limitworkspace <mem>  
                              set maximal workspace size (GAP never
                              allocates more)
 -c                 <mem>     set the cache size value
 -s                 <mem      set the initially mapped virtual memory
 -a                 <mem>     set amount to pre-malloc-ate
                              postfix 'k' = *1024, 'm' = *1024*1024,
                              'g' = *1024*1024*1024

 -l, --roots        <paths>   set the GAP root paths
                              Directories are separated using ';'.
                              Putting ';' on the start/end of list appends
                              directories to the end/start of existing list
                              of root paths
 -r                           disable/enable user GAP root dir
                              GAPInfo.UserGapRoot
 -A                           disable/enable autoloading of suggested
                              GAP packages
 -B                 <name>    current architecture
 -D                           enable/disable debugging the loading of files
 -M                           disable/enable loading of compiled modules
 -N                           unused, for backward compatibility only
 -O                           disable/enable loading of obsolete files
 -X                           enable/disable CRC checking for compiled modules
 -T                           disable/enable break loop
 -i                 <file>    change the name of the init file

 -L                 <file>    restore a saved workspace
 -R                           prevent restoring of workspace (ignoring -L)

 -p                           enable/disable package output mode
     --prof         <file>    Run ProfileLineByLine(<filename>) on GAP start
     --cover        <file>    Run CoverageLineByLine(<filename>) on GAP start
  Boolean options (b,q,e,r,A,D,E,M,N,T,X,Y) toggle the current value
  each time they are called. Default actions are indicated first.
```

