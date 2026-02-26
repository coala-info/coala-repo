# eklipse CWL Generation Report

## eklipse_eKLIPse.py

### Tool Description
eKLIPse: a tool for identifying circular DNA breakpoints

### Metadata
- **Docker Image**: quay.io/biocontainers/eklipse:1.8--hdfd78af_2
- **Homepage**: https://github.com/dooguypapua/eKLIPse
- **Package**: https://anaconda.org/channels/bioconda/packages/eklipse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/eklipse/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-06-25
- **GitHub**: https://github.com/dooguypapua/eKLIPse
- **Stars**: N/A
### Original Help Text
```text
[1;33m
   ___              __   __   ___ 
  |__  |__/ |    | |__) /__` |__  
  |___ |  \ |___ | |    .__/ |___ [0m[0;33m[v1-8]
[0m|  [1;33m

  USAGE: python eKLIPse -in <FILE with Alignment paths> -ref <GBK reference> [OPTIONS]

[0m[1;37m  OPTIONS:
[0m[0;37m    -out          <str>  : Output directory path                  [current]
[0m[0;37m    -tmp          <str>  : Temporary directory path               [/tmp]
[0m[0;37m    -scsize       <int>  : Soft-clipping minimal length           [25]
[0m[0;37m    -mapsize      <int>  : Upstream mapping length                [20]
[0m[0;37m    -downcov      <int>  : Downsampling reads number              [500000] (0=disable)
[0m[0;37m    -minq         <int>  : Read quality threshold                 [20]
[0m[0;37m    -minlen       <int>  : Read length threshold                  [100]
[0m[0;37m    -shift        <int>  : Breakpoint BLAST shift length          [5]
[0m[0;37m    -minblast     <int>  : Minimal number of BLAST per breakpoint [1]
[0m[0;37m    -bilateral    <bool> : Filter non-bilateral BLAST deletions   [True]
[0m[0;37m    -mitosize     <int>  : Minimal resulting mitochondria size    [1000]
[0m[0;37m    -id           <int>  : BLAST %identity threshold              [80]
[0m[0;37m    -cov          <int>  : BLAST %coverage threshold              [70]
[0m[0;37m    -gapopen      <int>  : BLAST cost to open a gap               [0:proton, 5:illumina]
[0m[0;37m    -gapext       <int>  : BLAST cost to extend a gap             [2]
[0m[0;37m    -thread       <int>  : Number of thread to use                [2]
[0m[0;37m    -samtools     <str>  : samtools bin path                      [$PATH]
[0m[0;37m    -blastn       <str>  : BLASTn bin path                        [$PATH]
[0m[0;37m    -makeblastdb  <str>  : makeblastdb bin path                   [$PATH]
[0m[0;37m    -circos       <str>  : circos bin path                        [$PATH]
[0m[0;37m    --test               : eKLIPse test
[0m[0;37m    --nocolor            : Disable output colors

[0m
```

