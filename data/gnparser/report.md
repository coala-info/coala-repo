# gnparser CWL Generation Report

## gnparser

### Tool Description
Parses scientific names into their semantic elements.

### Metadata
- **Docker Image**: quay.io/biocontainers/gnparser:1.14.2--he881be0_0
- **Homepage**: https://parser.globalnames.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/gnparser/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gnparser/overview
- **Total Downloads**: 19.6K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/gnames/gnparser
- **Stars**: N/A
### Original Help Text
```text
Parses scientific names into their semantic elements.

To see version:
gnparser -V

To parse one name in CSV format
gnparser "Homo sapiens Linnaeus 1758" [flags]
or (the same)
gnparser "Homo sapiens Linnaeus 1758" -f csv [flags]

To parse one name using JSON format:
gnparser "Homo sapiens Linnaeus 1758" -f compact [flags]
or
gnparser "Homo sapiens Linnaeus 1758" -f pretty [flags]

To parse with maximum amount of details:
gnparser "Homo sapiens Linnaeus 1758" -d -f pretty

To parse many names from a file (one name per line):
gnparser names.txt [flags] > parsed_names.txt

To leave HTML tags and entities intact when parsing (faster)
gnparser names.txt -n > parsed_names.txt

To start web service on port 8080 with 5 concurrent jobs:
gnparser -j 5 -p 8080

Usage:
  gnparser file_or_name [flags]

Flags:
  -b, --batch_size int              maximum number of names in a batch send for processing.
  -c, --capitalize                  capitalize the first letter of input name-strings
  -a, --compact-authors             remove spaces between initials of authors
  -C, --cultivar                    parse according to  cultivar code ICNCP
                                    (DEPRECATED, use nomenclatural-code instead)
  -d, --details                     provides more details
  -D, --diaereses                   preserve diaereses in names
  -F, --flatten-output              flattens nested JSON results
  -f, --format string               Sets the output format.
                                    
                                    Accepted values are:
                                      - 'csv': Comma-separated values
                                      - 'tsv': Tab-separated values
                                      - 'compact': Compact JSON format
                                      - 'pretty': Human-readable JSON format
                                    
                                    If not set, the output format defaults to 'csv'.
  -h, --help                        help for gnparser
  -i, --ignore_tags                 ignore HTML entities and tags when parsing.
  -j, --jobs int                    number of threads to run. CPU's threads number is the default.
  -n, --nomenclatural-code string   Modifies the parser's behavior in ambiguous cases, sometimes
                                    introducing additional parsing rules.
                                    
                                    Accepted values are:
                                      - 'bact', 'icnp', 'bacterial' for bacterial code
                                      - 'bot', 'icn', 'botanical' for botanical code
                                      - 'cult', 'icncp', 'cultivar' for cultivar code
                                      - 'vir', 'virus', 'viral', 'ictv', 'icvcn' for viral code
                                      - 'zoo', 'iczn', 'zoological' for zoological code
                                    
                                    If not set, the parser will attempt to determine the appropriate code/s.
  -p, --port int                    starts web site and REST server on the port.
  -q, --quiet                       do not show progress
      --species-group-cut           cut autonym/species group names to species for stemmed version
  -s, --stream                      parse one name at a time in a stream instead of a batch parsing
  -u, --unordered                   output and input are in different order
  -V, --version                     shows build version and date, ignores other flags.
```

