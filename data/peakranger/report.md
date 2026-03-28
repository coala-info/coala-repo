# peakranger CWL Generation Report

## peakranger_nr

### Tool Description
Not enough command options.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/peakranger/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
nr 1.18

Usage:

Input:
  -d [ --data ] arg               data file
  -c [ --control ] arg            control file
  --format arg                    the format of the data file, can be one of : 
                                  bowtie, sam, bam and bed

Qualities:
  -l [ --ext_length ] arg (=200)  read extension length

Other:
  -h [ --help ]                   show the usage
  --verbose                       show progress when possible
  --version                       output the version number

Not enough command options.

Provided args:
nr
```


## peakranger_lc

### Tool Description
PeakRanger LC

### Metadata
- **Docker Image**: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
lc 1.18

Usage:

Input:
  -d [ --data ] arg      the data file

Other:
  -h [ --help ]          show the usage
  --verbose              show progress when possible
  --version              output the version number

Not enough command options.

Provided args:
lc
```


## peakranger_wig

### Tool Description
Converts various genomic data formats to WIG format.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
- **Homepage**: https://github.com/fnaumenko/wigReg
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
wig 1.18

Usage:

Input:
  -d [ --data ] arg               data file
  --format arg                    the format of the data file, can be one of : 
                                  bowtie, sam, bam and bed

Output:
  -o [ --output ] arg             the output location
  -s [ --split ]                  generate one wig file per chromosome
  -z [ --gzip ]                   compress the output
  -x [ --strand ]                 generate one wig file per strand

Qualities:
  -l [ --ext_length ] arg (=200)  read extension length

Other:
  -h [ --help ]                   show the usage
  --verbose                       show progress
  --version                       output the version number

Not enough args

Provided args:
wig
```


## peakranger_wigpe

### Tool Description
WigPE 1.18

### Metadata
- **Docker Image**: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
WigPE 1.18

Usage:

Input:
  -d [ --data ] arg             the data file

Output:
  -o [ --output ] arg           the output location
  -s [ --split ]                generate one wig file per chromosome
  -z [ --gzip ]                 compress the output
  -x [ --strand ]               generate one wig file per strand

Qualities:
  -l [ --ext_length ] arg (=0)  read extension length

Other:
  -h [ --help ]                 show the usage
  --verbose                     show progress when possible
  --version                     output the version number

Not enough command options.

Provided args:
wigpe
```


## peakranger_ranger

### Tool Description
Peak calling tool for ChIP-seq data

### Metadata
- **Docker Image**: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
ranger 1.18

Usage:

Input:
  -d [ --data ] arg               data file
  -c [ --control ] arg            control file
  --format arg                    the format of the data file, can be one of : 
                                  bowtie, sam, bam and bed

Output:
  -o [ --output ] arg             the output location
  --report                        generate html reports
  --plot_region arg (=6000)       the length of the snapshort regions in the 
                                  report
  --gene_annot_file arg           the gene annotation file

Qualities:
  -p [ --pval ] arg (=0.0001)     p value cut-off
  -q [ --FDR ] arg (=0.01)        FDR cut-off
  -l [ --ext_length ] arg (=100)  read extension length
  -r [ --delta ] arg (=1)         sensitivity of the summit detector
  -b [ --bandwidth ] arg (=99)    smoothing bandwidth
  --pad                           pad read coverage profile to avoid false 
                                  positive summmits

Running modes:
  -t [ --thread ] arg (=19)       number of worker threads

Other:
  -h [ --help ]                   show the usage
  --verbose                       show progress
  --version                       output the version number


Not enough command options.

Provided args:
ranger
```


## peakranger_ccat

### Tool Description
ccat 1.18

### Metadata
- **Docker Image**: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
- **Homepage**: https://www.gnu.org/software/coreutils/
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
ccat 1.18

Usage:

Input:
  -d [ --data ] arg               data file
  -c [ --control ] arg            control file
  --format arg                    the format of the data file, can be one of : 
                                  bowtie, sam, bam and bed

Output:
  -o [ --output ] arg             the output location
  --report                        generate html reports
  --plot_region arg (=6000)       the length of the snapshort regions in the 
                                  report
  --gene_annot_file arg           the gene annotation file

Qualities:
  -q [ --FDR ] arg (=0.11)        FDR cut-off
  --win_size arg (=500)           sliding window size
  --win_step arg (=50)            window moving step
  --min_count arg (=4)            minimum window reads count
  --min_score arg (=5)            minimum window reads fold change
  -l [ --ext_length ] arg (=200)  read extension length

Running modes:
  -t [ --thread ] arg (=19)       number of worker threads

Other:
  -h [ --help ]                   show the usage
  --verbose                       show progress
  --version                       output the version number


Not enough command options.

Provided args:
ccat
```


## peakranger_bcp

### Tool Description
Peakranger BCP (Broadly Conserved Peaks) tool for identifying conserved peaks.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
bcp 1.18

Usage:

Input:
  -d [ --data ] arg               data file
  -c [ --control ] arg            control file
  --format arg                    the format of the data file, can be one of : 
                                  bowtie, sam, bam and bed

Output:
  -o [ --output ] arg             the output location
  --report                        generate html reports
  --plot_region arg (=6000)       the length of the snapshort regions in the 
                                  report
  --gene_annot_file arg           the gene annotation file

Qualities:
  -p [ --pval ] arg (=0.0001)     p value cut-off
  --win_size arg (=500)           sliding window size
  -l [ --ext_length ] arg (=200)  read extension length

Other:
  -h [ --help ]                   show the usage
  --verbose                       show progress
  --version                       output the version number

Not enough command options.

Provided args:
bcp
```


## Metadata
- **Skill**: generated
