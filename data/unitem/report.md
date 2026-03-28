# unitem CWL Generation Report

## unitem_bin

### Tool Description
Apply binning methods to an assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/unitem:1.2.6--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/UniteM
- **Package**: https://anaconda.org/channels/bioconda/packages/unitem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unitem/overview
- **Total Downloads**: 19.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/UniteM
- **Stars**: N/A
### Original Help Text
```text
usage: unitem bin (--bam_files [BAM_FILES ...] | --cov_file COV_FILE) [--gm2]
                  [--max40] [--max107] [--mb2] [--mb_verysensitive]
                  [--mb_sensitive] [--mb_specific] [--mb_veryspecific]
                  [--mb_superspecific] [-s SEED] [-m MIN_CONTIG_LEN] [-c CPUS]
                  [--silent] [-h]
                  assembly_file output_dir

Apply binning methods to an assembly.

positional arguments:
  assembly_file         assembled contigs to bin (FASTA format)
  output_dir            output directory

required arguments (one of):
  --bam_files [BAM_FILES ...]
                        BAM file(s) to parse for coverage profile
  --cov_file COV_FILE   file indicating coverage information

binning methods:
  --gm2                 run GroopM v2
  --max40               run MaxBin with the 40 marker gene set
  --max107              run MaxBin with the 107 marker gene set
  --mb2                 run MetaBAT v2
  --mb_verysensitive    run MetaBAT v1 with the 'verysensitive' preset
                        settings
  --mb_sensitive        run MetaBAT v1 with the 'sensitive' preset settings
  --mb_specific         run MetaBAT v1 with the 'specific' preset settings
  --mb_veryspecific     run MetaBAT v1 with the 'veryspecific' preset settings
  --mb_superspecific    run MetaBAT v1 with the 'superspecific' preset
                        settings

optional arguments:
  -s, --seed SEED       set random seed; default is to use a random seed
                        (default: 0)
  -m, --min_contig_len MIN_CONTIG_LEN
                        minimum length of contigs to bin (>=1500 recommended)
                        (default: 2500)
  -c, --cpus CPUS       number of CPUs (default: 1)
  --silent              suppress output of logger
  -h, --help            show help message
```


## unitem_profile

### Tool Description
Identify marker genes and calculate assembly statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/unitem:1.2.6--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/UniteM
- **Package**: https://anaconda.org/channels/bioconda/packages/unitem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: unitem profile (-b [BIN_DIRS ...] | -f BIN_FILE)
                      [--marker_dir MARKER_DIR] [--keep_intermediate]
                      [-c CPUS] [--silent] [-h]
                      output_dir

Identify marker genes and calculate assembly statistics.

positional arguments:
  output_dir            output directory

required arguments (one of):
  -b, --bin_dirs [BIN_DIRS ...]
                        directories with bins from different binning methods
  -f, --bin_file BIN_FILE
                        tab-separated file indicating directories with bins
                        from binning methods (two columns: method name and
                        directory)

optional arguments:
  --marker_dir MARKER_DIR
                        directory containing Pfam and TIGRfam marker genes
                        data
  --keep_intermediate   keep intermediate gene calling results
  -c, --cpus CPUS       number of CPUs (default: 1)
  --silent              suppress output of logger
  -h, --help            show help message
```


## unitem_greedy

### Tool Description
Greedy bin selection across multiple binning methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/unitem:1.2.6--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/UniteM
- **Package**: https://anaconda.org/channels/bioconda/packages/unitem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: unitem greedy (-b [BIN_DIRS ...] | -f BIN_FILE) [-w WEIGHT]
                     [-q SEL_MIN_QUALITY] [-x SEL_MIN_COMP] [-y SEL_MAX_CONT]
                     [--marker_dir MARKER_DIR]
                     [--report_min_quality REPORT_MIN_QUALITY]
                     [--simple_headers] [-p BIN_PREFIX] [--silent] [-h]
                     profile_dir output_dir

Greedy bin selection across multiple binning methods.

positional arguments:
  profile_dir           directory with bin profiles (output of 'profile'
                        command)
  output_dir            output directory

required arguments (one of):
  -b, --bin_dirs [BIN_DIRS ...]
                        directories with bins from different binning methods
  -f, --bin_file BIN_FILE
                        tab-separated file indicating directories with bins
                        from binning methods (two columns: method name and
                        directory)

optional bin selection arguments:
  -w, --weight WEIGHT   weight given to contamination for assessing genome
                        quality (default: 2)
  -q, --sel_min_quality SEL_MIN_QUALITY
                        minimum quality of bin to consider during bin
                        selection process (default: 50)
  -x, --sel_min_comp SEL_MIN_COMP
                        minimum completeness of bin to consider during bin
                        selection process (default: 50)
  -y, --sel_max_cont SEL_MAX_CONT
                        maximum contamination of bin to consider during bin
                        selection process (default: 10)

optional arguments:
  --marker_dir MARKER_DIR
                        directory containing Pfam and TIGRfam marker genes
                        data
  --report_min_quality REPORT_MIN_QUALITY
                        minimum quality of bin to report (default: 10)
  --simple_headers      do not add additional information to FASTA headers
  -p, --bin_prefix BIN_PREFIX
                        prefix for output bins (default: bin_)
  --silent              suppress output of logger
  -h, --help            show help message
```


## unitem_consensus

### Tool Description
Consensus clustering across multiple binning methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/unitem:1.2.6--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/UniteM
- **Package**: https://anaconda.org/channels/bioconda/packages/unitem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: unitem consensus (-b [BIN_DIRS ...] | -f BIN_FILE) [-w WEIGHT]
                        [-q SEL_MIN_QUALITY] [-x SEL_MIN_COMP]
                        [-y SEL_MAX_CONT] [-r REMOVE_PERC] [-a ADD_PERC]
                        [-m ADD_MATCHES] [--marker_dir MARKER_DIR]
                        [--report_min_quality REPORT_MIN_QUALITY]
                        [--simple_headers] [-p BIN_PREFIX] [--silent] [-h]
                        profile_dir output_dir

Consensus clustering across multiple binning methods.

positional arguments:
  profile_dir           directory with bin profiles (output of 'profile'
                        command)
  output_dir            output directory

required arguments (one of):
  -b, --bin_dirs [BIN_DIRS ...]
                        directories with bins from different binning methods
  -f, --bin_file BIN_FILE
                        tab-separated file indicating directories with bins
                        from binning methods (two columns: method name and
                        directory)

optional bin selection arguments:
  -w, --weight WEIGHT   weight given to contamination for assessing genome
                        quality (default: 2)
  -q, --sel_min_quality SEL_MIN_QUALITY
                        minimum quality of bin to consider during bin
                        selection process (default: 50)
  -x, --sel_min_comp SEL_MIN_COMP
                        minimum completeness of bin to consider during bin
                        selection process (default: 50)
  -y, --sel_max_cont SEL_MAX_CONT
                        maximum contamination of bin to consider during bin
                        selection process (default: 10)
  -r, --remove_perc REMOVE_PERC
                        minimum percentage of bins required to remove contigs
                        from highest-quality bin (default: 50.0)
  -a, --add_perc ADD_PERC
                        minimum percentage of matched bins required to add
                        contigs to highest-quality bin (default: 50.0)
  -m, --add_matches ADD_MATCHES
                        minimum number of matched bins required to 'add'
                        contigs (default: 3)

optional arguments:
  --marker_dir MARKER_DIR
                        directory containing Pfam and TIGRfam marker genes
                        data
  --report_min_quality REPORT_MIN_QUALITY
                        minimum quality of bin to report (default: 10)
  --simple_headers      do not add additional information to FASTA headers
  -p, --bin_prefix BIN_PREFIX
                        prefix for output bins (default: bin_)
  --silent              suppress output of logger
  -h, --help            show help message
```


## unitem_unanimous

### Tool Description
Unanimous bin filtering across multiple binning methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/unitem:1.2.6--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/UniteM
- **Package**: https://anaconda.org/channels/bioconda/packages/unitem/overview
- **Validation**: PASS

### Original Help Text
```text
usage: unitem unanimous (-b [BIN_DIRS ...] | -f BIN_FILE) [-w WEIGHT]
                        [-q SEL_MIN_QUALITY] [-x SEL_MIN_COMP]
                        [-y SEL_MAX_CONT] [--marker_dir MARKER_DIR]
                        [--report_min_quality REPORT_MIN_QUALITY]
                        [--simple_headers] [-p BIN_PREFIX] [--silent] [-h]
                        profile_dir output_dir

Unanimous bin filtering across multiple binning methods.

positional arguments:
  profile_dir           directory with bin profiles (output of 'profile'
                        command)
  output_dir            output directory

required arguments (one of):
  -b, --bin_dirs [BIN_DIRS ...]
                        directories with bins from different binning methods
  -f, --bin_file BIN_FILE
                        tab-separated file indicating directories with bins
                        from binning methods (two columns: method name and
                        directory)

optional bin selection arguments:
  -w, --weight WEIGHT   weight given to contamination for assessing genome
                        quality (default: 2)
  -q, --sel_min_quality SEL_MIN_QUALITY
                        minimum quality of bin to consider during bin
                        selection process (default: 50)
  -x, --sel_min_comp SEL_MIN_COMP
                        minimum completeness of bin to consider during bin
                        selection process (default: 50)
  -y, --sel_max_cont SEL_MAX_CONT
                        maximum contamination of bin to consider during bin
                        selection process (default: 10)

optional arguments:
  --marker_dir MARKER_DIR
                        directory containing Pfam and TIGRfam marker genes
                        data
  --report_min_quality REPORT_MIN_QUALITY
                        minimum quality of bin to report (default: 10)
  --simple_headers      do not add additional information to FASTA headers
  -p, --bin_prefix BIN_PREFIX
                        prefix for output bins (default: bin_)
  --silent              suppress output of logger
  -h, --help            show help message
```


## Metadata
- **Skill**: generated
