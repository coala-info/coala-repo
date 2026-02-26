# hictk CWL Generation Report

## hictk_balance

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Total Downloads**: 21.8K
- **Last updated**: 2025-11-13
- **GitHub**: https://github.com/paulsengroup/hictk
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Balance Hi-C files using ICE, SCALE, or VC. 


hictk balance [OPTIONS] SUBCOMMAND


OPTIONS:
  -h,     --help              Print this help message and exit 

SUBCOMMANDS:
  ice                         Balance Hi-C files using ICE. 
  scale                       Balance Hi-C files using SCALE. 
  vc                          Balance Hi-C matrices using VC.
```


## hictk_convert

### Tool Description
Convert Hi-C files between different formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: PASS

### Original Help Text
```text
Convert Hi-C files between different formats. 


hictk convert [OPTIONS] input output


POSITIONALS:
  input TEXT:((.[ms]cool) OR (.hic)) AND (NOT .scool) REQUIRED
                              Path to the .hic, .cool or .mcool file to be converted. 
  output TEXT REQUIRED        Output path. File extension is used to infer output format. 

OPTIONS:
  -h,     --help              Print this help message and exit 
          --output-fmt TEXT:{cool,mcool,hic} [auto]  
                              Output format (by default this is inferred from the output file 
                              extension). 
                              Should be one of: 
                              - cool 
                              - mcool 
                              - hic 
                              
  -r,     --resolutions UINT:POSITIVE ... 
                              One or more resolutions to be converted. By default all 
                              resolutions are converted. 
          --normalization-methods TEXT [ALL]  ... 
                              Name of one or more normalization methods to be copied. 
                              By default, vectors for all known normalization methods are 
                              copied. 
                              Pass NONE to avoid copying the normalization vectors. 
          --fail-if-norm-not-found 
                              Fail if any of the requested normalization vectors are missing. 
  -g,     --genome TEXT       Genome assembly name. By default this is copied from the .hic 
                              file metadata. 
          --tmpdir TEXT:DIR   Path where to store temporary files. 
          --chunk-size UINT:POSITIVE [10000000]  
                              Batch size to use when converting .[m]cool to .hic. 
  -v,     --verbosity INT:INT in [1 - 4] [3]  
                              Set verbosity of output to the console. 
  -t,     --threads UINT:UINT in [2 - 20] [2]  
                              Maximum number of parallel threads to spawn. 
                              When converting from hic to cool, only two threads will be used. 
  -l,     --compression-lvl UINT:INT in [1 - 12] [6]  
                              Compression level used to compress interactions. 
                              Defaults to 6 and 10 for .cool and .hic files, respectively. 
          --skip-all-vs-all, --no-skip-all-vs-all{false} 
                              Do not generate All vs All matrix. 
                              Has no effect when creating .[m]cool files. 
          --count-type TEXT:{auto,int,float} [auto]  
                              Specify the strategy used to infer count types when converting 
                              .hic files to .[m]cool format. 
                              Can be one of: int, float, or auto. 
  -f,     --force             Overwrite existing files (if any).
```


## hictk_dump

### Tool Description
Read interactions and other kinds of data from .hic and Cooler files and write them to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: PASS

### Original Help Text
```text
Read interactions and other kinds of data from .hic and Cooler files and write 
them to stdout. 


hictk dump [OPTIONS] uri


POSITIONALS:
  uri TEXT:(.[ms]cool) OR (.hic) REQUIRED
                              Path to a .hic, .cool or .mcool file (Cooler URI syntax 
                              supported). 

OPTIONS:
  -h,     --help              Print this help message and exit 
          --resolution UINT:NONNEGATIVE 
                              HiC matrix resolution (ignored when file is in .cool format). 
          --matrix-type ENUM:{observed,oe,expected} [observed]  
                              Matrix type (ignored when file is not in .hic format). 
          --matrix-unit ENUM:{BP,FRAG} [BP]  
                              Matrix unit (ignored when file is not in .hic format). 
  -t,     --table TEXT:{chroms,bins,pixels,normalizations,resolutions,cells,weights} [pixels]  
                              Name of the table to dump. 
  -r,     --range TEXT [all]  Excludes: --query-file --cis-only --trans-only 
                              Coordinates of the genomic regions to be dumped following UCSC 
                              style notation (chr1:0-1000). 
          --range2 TEXT [all]  Needs: --range Excludes: --query-file --cis-only --trans-only 
                              Coordinates of the genomic regions to be dumped following UCSC 
                              style notation (chr1:0-1000). 
          --query-file TEXT:(FILE) OR ({-}) Excludes: --range --range2 --cis-only --trans-only 
                              Path to a BEDPE file with the list of coordinates to be fetched 
                              (pass - to read queries from stdin). 
          --cis-only Excludes: --range --range2 --query-file --trans-only 
                              Dump intra-chromosomal interactions only. 
          --trans-only Excludes: --range --range2 --query-file --cis-only 
                              Dump inter-chromosomal interactions only. 
  -b,     --balance TEXT [NONE]  
                              Balance interactions using the given method. 
          --sorted, --unsorted{false} 
                              Return interactions in ascending order. 
          --join, --no-join{false} 
                              Output pixels in BG2 format.
```


## hictk_files

### Tool Description
Blazing fast tools to work with .hic and .cool files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: PASS

### Original Help Text
```text
Blazing fast tools to work with .hic and .cool files. 


hictk [OPTIONS] [SUBCOMMANDS]


OPTIONS:
  -h,     --help              Print this help message and exit 
  -V,     --version           Display program version information and exit 
[Option Group: help]
  
  [At most 1 of the following options are allowed] 
  
  
OPTIONS:
          --help-cite         Print hictk's citation in Bibtex format and exit. 
          --help-build-meta   Print information regarding hictk's build options and third-party 
                              dependencies, and exit. 
          --help-docs         Print the URL to hictk's documentation and exit. 
          --help-license      Print the hictk license and exit. 
          --help-telemetry    Print information regarding telemetry collection and exit. 

SUBCOMMANDS:
  balance                     Balance Hi-C files using ICE, SCALE, or VC. 
  convert                     Convert Hi-C files between different formats. 
  dump                        Read interactions and other kinds of data from .hic and Cooler 
                              files and write them to stdout. 
  fix-mcool                   Fix corrupted .mcool files. 
  load                        Build .cool and .hic files from interactions in various text 
                              formats. 
  merge                       Merge multiple Cooler or .hic files into a single file. 
  metadata                    Print file metadata to stdout. 
  rename-chromosomes, rename-chromsRename chromosomes found in Cooler files. 
  validate                    Validate .hic and Cooler files. 
  zoomify                     Convert single-resolution Cooler and .hic files to 
                              multi-resolution by coarsening.
```


## hictk_fix-mcool

### Tool Description
Fix corrupted .mcool files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: PASS

### Original Help Text
```text
Fix corrupted .mcool files. 


hictk fix-mcool [OPTIONS] input output


POSITIONALS:
  input TEXT:.mcool REQUIRED  Path to a corrupted .mcool file. 
  output TEXT REQUIRED        Path where to store the restored .mcool. 

OPTIONS:
  -h,     --help              Print this help message and exit 
          --tmpdir TEXT:DIR   Path to a folder where to store temporary data. 
          --skip-balancing    Do not recompute or copy balancing weights. 
          --check-base-resolution 
                              Check whether the base resolution is corrupted. 
          --in-memory         Store all interactions in memory while balancing (greatly 
                              improves performance). 
          --chunk-size UINT:POSITIVE [10000000]  
                              Number of interactions to process at once during balancing. 
                              Ignored when using --in-memory. 
  -v,     --verbosity INT:INT in [1 - 4] [3]  
                              Set verbosity of output to the console. 
  -t,     --threads UINT:UINT in [1 - 20] [1]  
                              Maximum number of parallel threads to spawn (only applies to the 
                              balancing stage). 
  -l,     --compression-lvl INT:INT in [0 - 19] [3]  
                              Compression level used to compress temporary files using ZSTD 
                              (only applies to the balancing stage). 
  -f,     --force             Overwrite existing files (if any).
```


## hictk_load

### Tool Description
Build .cool and .hic files from interactions in various text formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: PASS

### Original Help Text
```text
Build .cool and .hic files from interactions in various text formats. 


hictk load [OPTIONS] interactions output-path


POSITIONALS:
  interactions TEXT:(FILE) OR ({-}) REQUIRED
                              Path to a file with the interactions to be loaded. 
                              Common compression formats are supported (namely, bzip2, gzip, 
                              lz4, lzo, xz, and zstd). 
                              Pass "-" to indicate that interactions should be read from stdin. 
  output-path TEXT REQUIRED   Path to output file. 
                              File extension will be used to infer the output format. 
                              This behavior can be overridden by explicitly specifying an 
                              output format through option --output-fmt. 

OPTIONS:
  -h,     --help              Print this help message and exit 
  -c,     --chrom-sizes TEXT:FILE Excludes: --bin-table 
                              Path to .chrom.sizes file. 
                              Required when interactions are not in 4DN pairs format. 
  -b,     --bin-size UINT:POSITIVE Excludes: --bin-table 
                              Bin size (bp). 
                              Required when --bin-table is not used. 
          --bin-table TEXT:FILE Excludes: --chrom-sizes --bin-size 
                              Path to a BED3+ file with the bin table. 
  -f,     --format TEXT:{4dn,validpairs,bg2,coo} REQUIRED 
                              Input format. 
          --output-fmt TEXT:{auto,cool,hic} [auto]  
                              Output format (by default this is inferred from the output file 
                              extension). 
                              Should be one of: 
                              - auto 
                              - cool 
                              - hic 
                              
          --force             Force overwrite existing output file(s). 
          --assembly TEXT [unknown]  
                              Assembly name. 
          --drop-unknown-chroms 
                              Ignore records referencing unknown chromosomes. 
          --one-based, --zero-based{false} 
                              Interpret genomic coordinates or bins as one/zero based. 
                              By default coordinates are assumed to be one-based for 
                              interactions in 4dn and validpairs formats and zero-based 
                              otherwise. 
          --count-as-float    Interactions are floats. 
          --skip-all-vs-all, --no-skip-all-vs-all{false} 
                              Do not generate All vs All matrix. 
                              Has no effect when creating .cool files. 
          --assume-sorted, --assume-unsorted{false} 
                              Assume input files are already sorted. 
          --validate-pixels, --no-validate-pixels{false} 
                              Toggle pixel validation on or off. 
                              When --no-validate-pixels is used and invalid pixels are 
                              encountered, hictk will either crash or produce invalid files. 
          --transpose-lower-triangular-pixels, --no-transpose-lower-triangular-pixels{false} 
                              Transpose pixels overlapping the lower-triangular matrix. 
                              When --no-transpose-lower-triangular-pixels is used and one or 
                              more pixels overlapping with the lower triangular matrix are 
                              encountered an exception will be raised. 
          --chunk-size UINT [10000000]  
                              Number of pixels to buffer in memory. 
  -l,     --compression-lvl UINT:INT bounded to [1 - 12] 
                              Compression level used to compress interactions. 
                              Defaults to 6 and 10 for .cool and .hic files, respectively. 
  -t,     --threads UINT:UINT in [2 - 20] [2]  
                              Maximum number of parallel threads to spawn. 
                              When loading interactions in a .cool file, only up to two threads 
                              will be used. 
          --tmpdir TEXT:DIR   Path to a folder where to store temporary data. 
  -v,     --verbosity INT:INT in [1 - 4] [3]  
                              Set verbosity of output to the console.
```


## hictk_merge

### Tool Description
Merge multiple Cooler or .hic files into a single file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: PASS

### Original Help Text
```text
Merge multiple Cooler or .hic files into a single file. 


hictk merge [OPTIONS] input-files...


POSITIONALS:
  input-files TEXT:((.[ms]cool) OR (.hic)) AND (NOT .scool) x 2 REQUIRED
                              Path to two or more Cooler or .hic files to be merged (Cooler URI 
                              syntax supported). 

OPTIONS:
  -h,     --help              Print this help message and exit 
  -o,     --output-file TEXT REQUIRED 
                              Output Cooler or .hic file (Cooler URI syntax supported). 
          --output-fmt TEXT:{cool,hic} [auto]  
                              Output format (by default this is inferred from the output file 
                              extension). 
                              Should be one of: 
                              - cool 
                              - hic 
                              
          --resolution UINT:NONNEGATIVE 
                              Hi-C matrix resolution (ignored when input files are in .cool 
                              format). 
  -f,     --force             Force overwrite output file. 
          --chunk-size UINT [10000000]  
                              Number of pixels to store in memory before writing to disk. 
  -l,     --compression-lvl UINT:INT bounded to [1 - 12] 
                              Compression level used to compress interactions. 
                              Defaults to 6 and 10 for .cool and .hic files, respectively. 
  -t,     --threads UINT:UINT in [1 - 20] [1]  
                              Maximum number of parallel threads to spawn. 
                              When merging interactions in Cooler format, only a single thread 
                              will be used. 
          --tmpdir TEXT:DIR   Path to a folder where to store temporary data. 
          --skip-all-vs-all, --no-skip-all-vs-all{false} 
                              Do not generate All vs All matrix. 
                              Has no effect when merging .cool files. 
          --count-type TEXT:{int,float} [int]  
                              Specify the count type to be used when merging files. 
                              Ignored when the output file is in .hic format. 
  -v,     --verbosity INT:INT in [1 - 4] [3]  
                              Set verbosity of output to the console.
```


## hictk_metadata

### Tool Description
Print file metadata to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: PASS

### Original Help Text
```text
Print file metadata to stdout. 


hictk metadata [OPTIONS] uri


POSITIONALS:
  uri TEXT:(.[ms]cool) OR (.hic) REQUIRED
                              Path to a .hic or .[ms]cool file (Cooler URI syntax supported). 

OPTIONS:
  -h,     --help              Print this help message and exit 
  -f,     --output-format TEXT:{json,toml,yaml} [json]  
                              Format used to return file metadata. 
                              Should be one of: json, toml, or yaml. 
          --include-file-path, --exclude-file-path{false} 
                              Output the given input path using attribute "uri". 
          --recursive         Print metadata for each resolution or cell contained in a 
                              multi-resolution or single-cell file.
```


## hictk_validate

### Tool Description
Validate .hic and Cooler files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: PASS

### Original Help Text
```text
Validate .hic and Cooler files. 


hictk validate [OPTIONS] uri


POSITIONALS:
  uri TEXT REQUIRED           Path to a .hic or .[ms]cool file (Cooler URI syntax supported). 

OPTIONS:
  -h,     --help              Print this help message and exit 
          --validate-index    Validate Cooler index (may take a long time). 
          --validate-pixels   Validate pixels found in Cooler files (may take a long time). 
  -f,     --output-format TEXT:{json,toml,yaml} [json]  
                              Format used to report the outcome of file validation. 
                              Should be one of: json, toml, or yaml. 
          --include-file-path, --exclude-file-path{false} 
                              Output the given input path using attribute "uri". 
          --exhaustive, --fail-fast{false} 
                              When processing multi-resolution or single-cell files, do not 
                              fail as soon as the first error is detected. 
          --quiet             Don't print anything to stdout. Success/failure is reported 
                              through exit codes.
```


## hictk_zoomify

### Tool Description
Convert single-resolution Cooler and .hic files to multi-resolution by coarsening.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: PASS

### Original Help Text
```text
Convert single-resolution Cooler and .hic files to multi-resolution by 
coarsening. 


hictk zoomify [OPTIONS] cooler/hic [m]cool/hic


POSITIONALS:
  cooler/hic TEXT:((.[ms]cool) OR (.hic)) AND (NOT .scool) REQUIRED
                              Path to a .cool or .hic file (Cooler URI syntax supported). 
  [m]cool/hic TEXT REQUIRED   Output path. 
                              When zoomifying Cooler files, providing a single resolution 
                              through --resolutions and specifying --no-copy-base-resolution, 
                              the output file will be in .cool format. 

OPTIONS:
  -h,     --help              Print this help message and exit 
          --force             Force overwrite existing output file(s). 
          --resolutions UINT:POSITIVE ... 
                              One or more resolutions to be used for coarsening. 
          --copy-base-resolution, --no-copy-base-resolution{false} 
                              Copy the base resolution to the output file. 
          --nice-steps, --pow2-steps{false} [--nice-steps]  
                              Use nice or power of two steps to automatically generate the list 
                              of resolutions. 
                              Example: 
                              Base resolution: 1000 
                              Pow2: 1000, 2000, 4000, 8000... 
                              Nice: 1000, 2000, 5000, 10000... 
                              
  -l,     --compression-lvl UINT:INT bounded to [1 - 12] [6]  
                              Compression level used to compress interactions. 
                              Defaults to 6 and 10 for .mcool and .hic files, respectively. 
  -t,     --threads UINT:UINT in [1 - 20] [1]  
                              Maximum number of parallel threads to spawn. 
                              When zoomifying interactions from a .cool file, only a single 
                              thread will be used. 
          --chunk-size UINT [10000000]  
                              Number of pixels to buffer in memory. 
                              Only used when zoomifying .hic files. 
          --skip-all-vs-all, --no-skip-all-vs-all{false} 
                              Do not generate All vs All matrix. 
                              Has no effect when zoomifying .cool files. 
          --tmpdir TEXT:DIR   Path to a folder where to store temporary data. 
  -v,     --verbosity INT:INT in [1 - 4] [3]  
                              Set verbosity of output to the console.
```


## hictk_multi-resolution

### Tool Description
Blazing fast tools to work with .hic and .cool files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
- **Homepage**: https://github.com/paulsengroup/hictk
- **Package**: https://anaconda.org/channels/bioconda/packages/hictk/overview
- **Validation**: PASS

### Original Help Text
```text
Blazing fast tools to work with .hic and .cool files. 


hictk [OPTIONS] [SUBCOMMANDS]


OPTIONS:
  -h,     --help              Print this help message and exit 
  -V,     --version           Display program version information and exit 
[Option Group: help]
  
  [At most 1 of the following options are allowed] 
  
  
OPTIONS:
          --help-cite         Print hictk's citation in Bibtex format and exit. 
          --help-build-meta   Print information regarding hictk's build options and third-party 
                              dependencies, and exit. 
          --help-docs         Print the URL to hictk's documentation and exit. 
          --help-license      Print the hictk license and exit. 
          --help-telemetry    Print information regarding telemetry collection and exit. 

SUBCOMMANDS:
  balance                     Balance Hi-C files using ICE, SCALE, or VC. 
  convert                     Convert Hi-C files between different formats. 
  dump                        Read interactions and other kinds of data from .hic and Cooler 
                              files and write them to stdout. 
  fix-mcool                   Fix corrupted .mcool files. 
  load                        Build .cool and .hic files from interactions in various text 
                              formats. 
  merge                       Merge multiple Cooler or .hic files into a single file. 
  metadata                    Print file metadata to stdout. 
  rename-chromosomes, rename-chromsRename chromosomes found in Cooler files. 
  validate                    Validate .hic and Cooler files. 
  zoomify                     Convert single-resolution Cooler and .hic files to 
                              multi-resolution by coarsening.
```

