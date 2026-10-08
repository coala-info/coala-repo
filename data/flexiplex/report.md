# flexiplex CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| flexiplex | Failed | tool bug: 1.02.5 silently writes an N-padded UMI when the UMI is placed before the barcode; barcode-then-UMI layout is correct. |
| flexiplex_flexiplex-filter | PASS |  |

## flexiplex

### Tool Description
A versatile demultiplexer and search tool for omics data, used for searching and reporting barcodes, UMIs, and flanking sequences in sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/flexiplex:1.02.5--py313h9948957_1
- **Homepage**: https://github.com/DavidsonGroup/flexiplex/
- **Package**: https://anaconda.org/channels/bioconda/packages/flexiplex/overview
- **Validation**: PASS

### Original Help Text
```text
FLEXIPLEX 1.02.5
usage: flexiplex [options] [reads_input]

  reads_input: a .fastq or .fasta file. Will read from stdin if empty.

  options: 
     -k known_list   Either 1) a text file of expected barcodes in the first column,
                     one row per barcode, or 2) a comma separate string of barcodes.
                     Without this option, flexiplex will search and report possible barcodes.
                     The generated list can be used for known_list in subsequent runs.
     -i true/false   Replace read ID with barcodes+UMI, remove search strings
                     including flanking sequenence and split read if multiple
                     barcodes found (default: true).
     -s true/false   Sort reads into separate files by barcode (default: false)
     -c true/false   Add a _C suffix to the read identifier of any chimeric reads
                     (default: false). For instance if,
                       @BC_UMI#READID_+1of2
                     is chimeric, it will become:
                       @BC_UMI#READID_+1of2_C
     -n prefix       Prefix for output filenames.
     -e N            Maximum edit distance to barcode (default 2).
     -f N            Maximum edit distance to primer+polyT (default 8).
     -p N            Number of threads (default: 1).

  Specifying adaptor / barcode structure : 
     -x sequence Append flanking sequence to search for
     -b sequence Append the barcode pattern to search for
     -u sequence Append the UMI pattern to search for
     Notes:
          The order of these options matters
          ? - can be used as a wildcard
     When no search pattern x,b,u option is provided, the following default pattern is used: 
          primer: CTACACGACGCTCTTCCGATCT
          barcode: ????????????????
          UMI: ????????????
          polyT: TTTTTTTTT
     which is the same as providing: 
         -x CTACACGACGCTCTTCCGATCT -b ???????????????? -u ???????????? -x TTTTTTTTT

  Predefined search schemes:
    -d 10x3v2		10x version 2 chemistry 3', equivalent to:
				-x CTACACGACGCTCTTCCGATCT -b ???????????????? -u ?????????? -x TTTTTTTTT -f 8 -e 2
    -d 10x3v3		10x version 3 chemistry 3', equivalent to:
				-x CTACACGACGCTCTTCCGATCT -b ???????????????? -u ???????????? -x TTTTTTTTT -f 8 -e 2
    -d 10x5v2		10x version 2 chemistry 5', equivalent to:
				-x CTACACGACGCTCTTCCGATCT -b ???????????????? -u ?????????? -x TTTCTTATATGGG -f 8 -e 2
    -d grep		Simple grep-like search (edit distance up to 2), equivalent to:
				-f 2 -k ? -b '' -u '' -i false

     -h     Print this usage information.

Have a different barcode scheme you would like Flexiplex to work with? Post a request at:
https://github.com/DavidsonGroup/flexiplex/issues

If you use Flexiplex in your research, please cite our paper:
O. Cheng et al., Flexiplex: a versatile demultiplexer and search tool for omics data, Bioinformatics, Volume 40, Issue 3, 2024
```

## flexiplex_flexiplex-filter

### Tool Description
Finds the inflection point when demultiplexing using flexiplex and filters the barcode counts file.

### Metadata
- **Docker Image**: quay.io/biocontainers/flexiplex:1.02.5--py313h9948957_1
- **Homepage**: https://github.com/DavidsonGroup/flexiplex/
- **Package**: https://anaconda.org/channels/bioconda/packages/flexiplex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: flexiplex-filter [-h] [-v] [-o <file>] [--dry-run] [--no-inflection]
                        [-l <r>] [-u <r>] [-g] [--list-points <n>]
                        [--use-predetermined-rank <r>] [-w <file>]
                        [filename]

finds the inflection point when demultiplexing using flexiplex

positional arguments:
  filename              input file, typically called
                        flexiplex_barcodes_counts.txt. defaults to stdin if
                        not given

options:
  -h, --help            show this help message and exit
  -v, --verbose         output verbose and debugging information, and also
                        display more potential inflection points
  -o, --outfile <file>  output file, defaults to stdout if not given (ignored
                        if --dry-run is active)
  --dry-run             only output discovered inflection points, without
                        performing the actual filtering

filter by inflection point:
  --no-inflection       do not search for an inflection point
  -l, --min-rank <r>    lowest rank to search
  -u, --max-rank <r>    highest rank to search. set to 0 to search to the end

fine-tune/visualise an inflection point:
  -g, --graph           show a graph with the inflection point marked,
                        requires matplotlib. will also enable --dry-run.
  --list-points <n>     show multiple potential points. will also enable
                        --dry-run.
  --use-predetermined-rank <r>
                        use predetermined inflection point. this will disable
                        searching, but will still filter for all ranks <= r

filter by whitelist file:
  -w, --whitelist <file>
                        a whitelist file for known chemistry barcodes. if not
                        given, this program will not perform whitelist
                        filtering.
```

## Metadata
- **Skill**: generated

