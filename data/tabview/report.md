# tabview CWL Generation Report

## tabview

### Tool Description
View a tab-delimited file in a spreadsheet-like display. Press F1 or '?' while running for a list of available keybindings.

### Metadata
- **Docker Image**: quay.io/biocontainers/tabview:1.4.3--pyh4bbf42b_0
- **Homepage**: https://github.com/firecat53/tabview
- **Package**: https://anaconda.org/channels/bioconda/packages/tabview/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tabview/overview
- **Total Downloads**: 12.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/firecat53/tabview
- **Stars**: N/A
### Original Help Text
```text
usage: tabview [-h] [--encoding ENCODING] [--delimiter DELIMITER]
               [--quoting {QUOTE_ALL,QUOTE_MINIMAL,QUOTE_NONE,QUOTE_NONNUMERIC}]
               [--start_pos START_POS] [--width WIDTH] [--double_width]
               [--quote-char QUOTE_CHAR]
               filename

View a tab-delimited file in a spreadsheet-like display. Press F1 or '?' while
running for a list of available keybindings.

positional arguments:
  filename              File to read. Use '-' to read from the standard input
                        instead.

optional arguments:
  -h, --help            show this help message and exit
  --encoding ENCODING, -e ENCODING
                        Encoding, if required. If the file is UTF-8,
                        Latin-1(iso8859-1) or a few other common encodings, it
                        should be detected automatically. If not, you can pass
                        'CP720', or 'iso8859-2', for example.
  --delimiter DELIMITER, -d DELIMITER
                        CSV delimiter. Not typically necessary since automatic
                        delimiter sniffing is used.
  --quoting {QUOTE_ALL,QUOTE_MINIMAL,QUOTE_NONE,QUOTE_NONNUMERIC}
                        CSV quoting style. Not typically required.
  --start_pos START_POS, -s START_POS
                        Initial cursor display position. Single number for
                        just y (row) position, or two comma-separated numbers
                        (--start_pos 2,3) for both. Alternatively, you can
                        pass the numbers in the more classic +y:[x] format
                        without the --start_pos label. Like 'tabview <fn>
                        +5:10'
  --width WIDTH, -w WIDTH
                        Specify column width. 'max' or 'mode' (default) for
                        variable widths, or an integer value for fixed column
                        width.
  --double_width        Force full handling of double-width characters for
                        large files (with a performance penalty)
  --quote-char QUOTE_CHAR, -q QUOTE_CHAR
                        Quote character. Not typically necessary.
```

