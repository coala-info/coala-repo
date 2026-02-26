# dupsifter CWL Generation Report

## dupsifter

### Tool Description
Program: dupsifter

### Metadata
- **Docker Image**: quay.io/biocontainers/dupsifter:1.3.0.20241113--h566b1c6_1
- **Homepage**: https://github.com/huishenlab/dupsifter
- **Package**: https://anaconda.org/channels/bioconda/packages/dupsifter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dupsifter/overview
- **Total Downloads**: 3.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/huishenlab/dupsifter
- **Stars**: N/A
### Original Help Text
```text
dupsifter: option '--h' is ambiguous; possibilities: '--has-barcode' '--help'

Program: dupsifter
Version: 1.3.0
Contact: Jacob Morrison <jacob.morrison@vai.org>

dupsifter [options] <ref.fa> [in.bam]

Output options:
    -o, --output STR             name of output file [stdout]
    -O, --stats-output STR       name of file to write statistics to (see Note 3 for details)
Input options:
    -s, --single-end             run for single-end data
    -m, --add-mate-tags          add MC and MQ mate tags to mate reads
    -W, --wgs-only               process WGS reads instead of WGBS
    -l, --max-read-length INT    maximum read length for paired end duplicate-marking [10000]
    -b, --min-base-qual INT      minimum base quality [0]
    -B, --has-barcode            reads in file have barcodes (see Note 4 for details)
    -r, --remove-dups            toggle to remove marked duplicate
    -v, --verbose                print extra messages
    -h, --help                   this help
        --version                print version info and exit

Note 1, [in.bam] must be name sorted. If not provided, assume the input is stdin.
Note 2, assumes either ALL reads are paired-end (default) or single-end.
    If a singleton read is found in paired-end mode, the code will break nicely.
Note 3, defaults to dupsifter.stat if streaming or (-o basename).dupsifter.stat 
    if the -o option is provided. If -o and -O are provided, then -O will be used.
Note 4, dupsifter first looks for a barcode in the CB SAM tag, then in the CR SAM tag, then
    tries to parse the read name. If the barcode is in the read name, it must be the last element
    and be separated by a ':' (i.e., @12345:678:9101112:1234_1:N:0:ACGTACGT). Any separators
    found in the barcode (e.g., '+' or '-') are treated as 'N's and the additional parts of the
    barcode are included up to a maximum length of 16 bases/characters. Barcodes can be read from
    single-end or paired-end (pulled from read 1 only) sequencing.
```

