# alevin-fry CWL Generation Report

## alevin-fry_generate-permit-list

### Tool Description
Generate a permit list of barcodes from a RAD file

### Metadata
- **Docker Image**: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
- **Homepage**: https://github.com/COMBINE-lab/alevin-fry
- **Package**: https://anaconda.org/channels/bioconda/packages/alevin-fry/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/alevin-fry/overview
- **Total Downloads**: 51.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/COMBINE-lab/alevin-fry
- **Stars**: N/A
### Original Help Text
```text
Generate a permit list of barcodes from a RAD file

Usage: alevin-fry generate-permit-list [OPTIONS] --input <INPUT> --expected-ori <EXPECTEDORI> --output-dir <OUTPUTDIR> <--knee-distance|--expect-cells <EXPECTCELLS>|--force-cells <FORCECELLS>|--valid-bc <VALIDBC>|--unfiltered-pl <UNFILTEREDPL>>

Options:
  -i, --input <INPUT>                 input directory containing the map.rad RAD file
  -d, --expected-ori <EXPECTEDORI>    the expected orientation of alignments [possible values: fw, rc, both, either]
  -o, --output-dir <OUTPUTDIR>        output directory
  -k, --knee-distance                 attempt to determine the number of barcodes to keep using the knee distance method.
  -t, --threads <THREADS>             number of threads to use for the first phase of permit-list generation [default: 2]
  -e, --expect-cells <EXPECTCELLS>    defines the expected number of cells to use in determining the (read, not UMI) based cutoff
  -f, --force-cells <FORCECELLS>      select the top-k most-frequent barcodes, based on read count, as valid (true)
  -b, --valid-bc <VALIDBC>            uses true barcode collected from a provided file
  -u, --unfiltered-pl <UNFILTEREDPL>  uses an unfiltered external permit list
  -m, --min-reads <MINREADS>          minimum read count threshold; only used with --unfiltered-pl [default: 10]
  -h, --help                          Print help
  -V, --version                       Print version
```


## alevin-fry_collate

### Tool Description
Collate a RAD file by corrected cell barcode

### Metadata
- **Docker Image**: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
- **Homepage**: https://github.com/COMBINE-lab/alevin-fry
- **Package**: https://anaconda.org/channels/bioconda/packages/alevin-fry/overview
- **Validation**: PASS

### Original Help Text
```text
Collate a RAD file by corrected cell barcode

Usage: alevin-fry collate [OPTIONS] --input-dir <INPUTDIR> --rad-dir <RADFILE>

Options:
  -i, --input-dir <INPUTDIR>      input directory made by generate-permit-list
  -r, --rad-dir <RADFILE>         the directory containing the RAD file to be collated
  -t, --threads <THREADS>         number of threads to use for processing [default: 2]
  -c, --compress                  compress the output collated RAD file
  -m, --max-records <MAXRECORDS>  the maximum number of read records to keep in memory at once [default: 30000000]
  -h, --help                      Print help
  -V, --version                   Print version
```


## alevin-fry_quant

### Tool Description
Quantify expression from a collated RAD file

### Metadata
- **Docker Image**: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
- **Homepage**: https://github.com/COMBINE-lab/alevin-fry
- **Package**: https://anaconda.org/channels/bioconda/packages/alevin-fry/overview
- **Validation**: PASS

### Original Help Text
```text
Quantify expression from a collated RAD file

Usage: alevin-fry quant [OPTIONS] --input-dir <INPUTDIR> --tg-map <TGMAP> --output-dir <OUTPUTDIR> --resolution <RESOLUTION>

Options:
  -i, --input-dir <INPUTDIR>            input directory containing collated RAD file
  -m, --tg-map <TGMAP>                  transcript to gene map
  -o, --output-dir <OUTPUTDIR>          output directory where quantification results will be written
  -t, --threads <THREADS>               number of threads to use for processing [default: 1]
  -d, --dump-eqclasses                  flag for dumping equivalence classes
  -b, --num-bootstraps <NUMBOOTSTRAPS>  number of bootstraps to use [default: 0]
      --init-uniform                    flag for uniform sampling
      --summary-stat                    flag for storing only summary statistics
      --use-mtx                         flag for writing output matrix in matrix market format (default)
      --use-eds                         flag for writing output matrix in EDS format
      --quant-subset <SFILE>            file containing list of barcodes to quantify, those not in this list will be ignored
  -r, --resolution <RESOLUTION>         the resolution strategy by which molecules will be counted [possible values: trivial, cr-like, cr-like-em, parsimony-em, parsimony, parsimony-gene-em,
                                        parsimony-gene]
  -h, --help                            Print help
  -V, --version                         Print version
```


## alevin-fry_infer

### Tool Description
Perform inference on equivalence class count data

### Metadata
- **Docker Image**: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
- **Homepage**: https://github.com/COMBINE-lab/alevin-fry
- **Package**: https://anaconda.org/channels/bioconda/packages/alevin-fry/overview
- **Validation**: PASS

### Original Help Text
```text
Perform inference on equivalence class count data

Usage: alevin-fry infer [OPTIONS] --count-mat <EQCMAT> --eq-labels <EQLABELS> --output-dir <OUTPUTDIR>

Options:
  -c, --count-mat <EQCMAT>      matrix of cells by equivalence class counts
  -e, --eq-labels <EQLABELS>    file containing the gene labels of the equivalence classes
  -o, --output-dir <OUTPUTDIR>  output directory where quantification results will be written
  -t, --threads <THREADS>       number of threads to use for processing [default: 1]
      --usa                     flag specifying that input equivalence classes were computed in USA mode
      --quant-subset <SFILE>    file containing list of barcodes to quantify, those not in this list will be ignored
      --use-mtx                 flag for writing output matrix in matrix market format (default)
      --use-eds                 flag for writing output matrix in EDS format
  -h, --help                    Print help
  -V, --version                 Print version
```


## alevin-fry_convert

### Tool Description
Convert a BAM file to a RAD file

### Metadata
- **Docker Image**: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
- **Homepage**: https://github.com/COMBINE-lab/alevin-fry
- **Package**: https://anaconda.org/channels/bioconda/packages/alevin-fry/overview
- **Validation**: PASS

### Original Help Text
```text
Convert a BAM file to a RAD file

Usage: alevin-fry convert [OPTIONS] --bam <BAMFILE> --output <RADFILE>

Options:
  -b, --bam <BAMFILE>      input SAM/BAM file
  -t, --threads <THREADS>  number of threads to use for processing [default: 1]
  -o, --output <RADFILE>   output RAD file
  -h, --help               Print help
  -V, --version            Print version
```


## alevin-fry_view

### Tool Description
View the contents of a RAD file

### Metadata
- **Docker Image**: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
- **Homepage**: https://github.com/COMBINE-lab/alevin-fry
- **Package**: https://anaconda.org/channels/bioconda/packages/alevin-fry/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: alevin-fry view --rad <RADFILE> --help

For more information, try '--help'.
```


## alevin-fry_atac

### Tool Description
subcommand for processing scATAC-seq RAD files

### Metadata
- **Docker Image**: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
- **Homepage**: https://github.com/COMBINE-lab/alevin-fry
- **Package**: https://anaconda.org/channels/bioconda/packages/alevin-fry/overview
- **Validation**: PASS

### Original Help Text
```text
subcommand for processing scATAC-seq RAD files

Usage: alevin-fry atac [COMMAND]

Commands:
  generate-permit-list  Generate a permit list of barcodes from a whitelist file
  sort                  Produce coordinate sorted bed file
  collate               Collate a RAD file with corrected cell barcode
  deduplicate           Deduplicate the RAD file and output a BED file
  help                  Print this message or the help of the given subcommand(s)

Options:
  -h, --help     Print help
  -V, --version  Print version
```


## Metadata
- **Skill**: generated
