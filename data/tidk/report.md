# tidk CWL Generation Report

## tidk_build

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
- **Homepage**: https://github.com/tolkit/telomeric-identifier
- **Package**: https://anaconda.org/channels/bioconda/packages/tidk/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/tidk/overview
- **Total Downloads**: 18.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tolkit/telomeric-identifier
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Warning! No clades found in the database. Run 'tidk build' to fetch the latest data.

error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: tidk build --help

For more information, try '--help'.
```


## tidk_find

### Tool Description
Supply the name of a clade your organsim belongs to, and this submodule will find all telomeric repeat matches for that clade.

### Metadata
- **Docker Image**: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
- **Homepage**: https://github.com/tolkit/telomeric-identifier
- **Package**: https://anaconda.org/channels/bioconda/packages/tidk/overview
- **Validation**: PASS

### Original Help Text
```text
Supply the name of a clade your organsim belongs to, and this submodule will find all telomeric repeat matches for that clade.

Usage: tidk find [OPTIONS] [FASTA]

Arguments:
  [FASTA]  The input fasta file

Options:
  -w, --window [<WINDOW>]  Window size to calculate telomeric repeat counts in [default: 10000]
  -c, --clade <CLADE>      The clade of organism to identify telomeres in
  -o, --output <OUTPUT>    Output filename for the TSVs (without extension)
  -d, --dir <DIR>          Output directory to write files to
  -p, --print              Print a table of clades, along with their telomeric sequences
      --log                Output a log file
  -h, --help               Print help
  -V, --version            Print version
```


## tidk_explore

### Tool Description
Use a range of kmer sizes to find potential telomeric repeats.
One of either length, or minimum and maximum must be specified.

### Metadata
- **Docker Image**: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
- **Homepage**: https://github.com/tolkit/telomeric-identifier
- **Package**: https://anaconda.org/channels/bioconda/packages/tidk/overview
- **Validation**: PASS

### Original Help Text
```text
Use a range of kmer sizes to find potential telomeric repeats.
One of either length, or minimum and maximum must be specified.

Usage: tidk explore [OPTIONS] <FASTA>

Arguments:
  <FASTA>  The input fasta file

Options:
  -l, --length [<LENGTH>]        Length of substring
  -m, --minimum [<MINIMUM>]      Minimum length of substring [default: 5]
  -x, --maximum [<MAXIMUM>]      Maximum length of substring [default: 12]
  -t, --threshold [<THRESHOLD>]  Positions of repeats are only reported if they occur sequentially in a greater number than the threshold [default: 100]
      --distance [<DISTANCE>]    The distance from the end of the chromosome as a proportion of chromosome length. Must range from 0-0.5. [default: 0.01]
  -v, --verbose                  Print verbose output.
      --log                      Output a log file.
  -h, --help                     Print help
  -V, --version                  Print version
```


## tidk_One

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
- **Homepage**: https://github.com/tolkit/telomeric-identifier
- **Package**: https://anaconda.org/channels/bioconda/packages/tidk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Warning! No clades found in the database. Run 'tidk build' to fetch the latest data.

error: unrecognized subcommand 'One'

Usage: tidk [COMMAND]

For more information, try '--help'.
```


## tidk_search

### Tool Description
Search the input genome with a specific telomeric repeat search string.

### Metadata
- **Docker Image**: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
- **Homepage**: https://github.com/tolkit/telomeric-identifier
- **Package**: https://anaconda.org/channels/bioconda/packages/tidk/overview
- **Validation**: PASS

### Original Help Text
```text
Search the input genome with a specific telomeric repeat search string.

Usage: tidk search [OPTIONS] --string <STRING> --output <OUTPUT> --dir <DIR> <FASTA>

Arguments:
  <FASTA>  The input fasta file

Options:
  -s, --string <STRING>          The DNA string to query the genome with
  -w, --window [<WINDOW>]        Window size to calculate telomeric repeat counts in [default: 10000]
  -o, --output <OUTPUT>          Output filename for the TSVs (without extension)
  -d, --dir <DIR>                Output directory to write files to
  -e, --extension [<EXTENSION>]  The extension, defining the output type of the file [default: tsv] [possible values: tsv, bedgraph]
      --log                      Output a log file
  -h, --help                     Print help
  -V, --version                  Print version
```


## tidk_plot

### Tool Description
SVG plot of TSV generated from tidk search.

### Metadata
- **Docker Image**: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
- **Homepage**: https://github.com/tolkit/telomeric-identifier
- **Package**: https://anaconda.org/channels/bioconda/packages/tidk/overview
- **Validation**: PASS

### Original Help Text
```text
SVG plot of TSV generated from tidk search.

Usage: tidk plot [OPTIONS] --tsv <TSV>

Options:
  -t, --tsv <TSV>                     The input TSV file
      --height [<HEIGHT>]             The height of subplots (px). [default: 200]
  -w, --width [<WIDTH>]               The width of plot (px) [default: 1000]
  -o, --output [<OUTPUT>]             Output filename for the SVG (without extension) [default: tidk-plot]
      --fontsize [<FONT_SIZE>]        The font size of the axis labels in the plot [default: 12]
      --strokewidth [<STROKE_WIDTH>]  The stroke width of the line graph in the plot [default: 2]
  -h, --help                          Print help
  -V, --version                       Print version
```

