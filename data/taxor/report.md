# taxor CWL Generation Report

## taxor_See

### Tool Description
This program must be invoked with one of the following subcommands: - build - search - profile See the respective help page for further details (e.g. by calling taxor build -h). The following options below belong to the top-level parser and need to be specified before the subcommand key word. Every argument after the subcommand key word is passed on to the corresponding sub-parser.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
- **Homepage**: https://github.com/JensUweUlrich/Taxor
- **Package**: https://anaconda.org/channels/bioconda/packages/taxor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxor/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-05-07
- **GitHub**: https://github.com/JensUweUlrich/Taxor
- **Stars**: N/A
### Original Help Text
```text
taxor
=====

SUBCOMMANDS
    This program must be invoked with one of the following subcommands:
    - build
    - search
    - profile
    See the respective help page for further details (e.g. by calling taxor
    build -h).

    The following options below belong to the top-level parser and need to be
    specified before the subcommand key word. Every argument after the
    subcommand key word is passed on to the corresponding sub-parser.

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].

VERSION
    Last update:
    taxor version: 0.2.0
    SeqAn version: 3.4.0-rc.1
```


## taxor_build

### Tool Description
Creates an HIXF index of a given set of fasta files

### Metadata
- **Docker Image**: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
- **Homepage**: https://github.com/JensUweUlrich/Taxor
- **Package**: https://anaconda.org/channels/bioconda/packages/taxor/overview
- **Validation**: PASS

### Original Help Text
```text
taxor-build - Creates an HIXF index of a given set of fasta files
=================================================================

DESCRIPTION
    Creates an HIXF index using either k-mers or syncmers

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].

  Main options:
    --input-file (std::string)
          tab-separated-value file containing taxonomy information and
          reference file names
    --input-sequence-dir (std::string)
          directory containing the fasta reference files Default: .
    --output-filename (std::string)
          A file name for the resulting index. Default: .
    --kmer-size (signed 32 bit integer)
          size of kmers used for index construction Default: 20. Value must be
          in range [1,64].
    --syncmer-size (signed 32 bit integer)
          size of syncmer used for index construction Default: 10. Value must
          be in range [1,26].
    --window-size (signed 32 bit integer)
          window size of minimizer scheme used for index construction Default:
          20. Value must be in range [1,96].
    --scaling (signed 32 bit integer)
          factor for scaling down syncmer/minimizer sketches Default: 1. Value
          must be in range [10,1000].
    --threads (signed 32 bit integer)
          The number of threads to use. Default: 1. Value must be in range
          [1,32].
    --use-syncmer
          enable using syncmers for smaller index size

VERSION
    Last update:
    taxor-build version: 0.2.0
    SeqAn version: 3.4.0-rc.1

LEGAL
    Author: Jens-Uwe Ulrich
    Contact: jens-uwe.ulrich@hpi.de
    SeqAn Copyright: 2006-2023 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
```


## taxor_The

### Tool Description
This program must be invoked with one of the following subcommands: build, search, profile. See the respective help page for further details (e.g. by calling taxor build -h). The following options below belong to the top-level parser and need to be specified before the subcommand key word. Every argument after the subcommand key word is passed on to the corresponding sub-parser.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
- **Homepage**: https://github.com/JensUweUlrich/Taxor
- **Package**: https://anaconda.org/channels/bioconda/packages/taxor/overview
- **Validation**: PASS

### Original Help Text
```text
taxor
=====

SUBCOMMANDS
    This program must be invoked with one of the following subcommands:
    - build
    - search
    - profile
    See the respective help page for further details (e.g. by calling taxor
    build -h).

    The following options below belong to the top-level parser and need to be
    specified before the subcommand key word. Every argument after the
    subcommand key word is passed on to the corresponding sub-parser.

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].

VERSION
    Last update:
    taxor version: 0.2.0
    SeqAn version: 3.4.0-rc.1
```


## taxor_specified

### Tool Description
This program must be invoked with one of the following subcommands: build, search, profile. See the respective help page for further details (e.g. by calling taxor build -h). The following options below belong to the top-level parser and need to be specified before the subcommand key word. Every argument after the subcommand key word is passed on to the corresponding sub-parser.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
- **Homepage**: https://github.com/JensUweUlrich/Taxor
- **Package**: https://anaconda.org/channels/bioconda/packages/taxor/overview
- **Validation**: PASS

### Original Help Text
```text
taxor
=====

SUBCOMMANDS
    This program must be invoked with one of the following subcommands:
    - build
    - search
    - profile
    See the respective help page for further details (e.g. by calling taxor
    build -h).

    The following options below belong to the top-level parser and need to be
    specified before the subcommand key word. Every argument after the
    subcommand key word is passed on to the corresponding sub-parser.

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].

VERSION
    Last update:
    taxor version: 0.2.0
    SeqAn version: 3.4.0-rc.1
```


## taxor_subcommand

### Tool Description
This program must be invoked with one of the following subcommands: - build - search - profile See the respective help page for further details (e.g. by calling taxor build -h). The following options below belong to the top-level parser and need to be specified before the subcommand key word. Every argument after the subcommand key word is passed on to the corresponding sub-parser.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
- **Homepage**: https://github.com/JensUweUlrich/Taxor
- **Package**: https://anaconda.org/channels/bioconda/packages/taxor/overview
- **Validation**: PASS

### Original Help Text
```text
taxor
=====

SUBCOMMANDS
    This program must be invoked with one of the following subcommands:
    - build
    - search
    - profile
    See the respective help page for further details (e.g. by calling taxor
    build -h).

    The following options below belong to the top-level parser and need to be
    specified before the subcommand key word. Every argument after the
    subcommand key word is passed on to the corresponding sub-parser.

OPTIONS

  Basic options:
    -h, --help
          Prints the help page.
    -hh, --advanced-help
          Prints the help page including advanced options.
    --version
          Prints the version information.
    --copyright
          Prints the copyright/license information.
    --export-help (std::string)
          Export the help page information. Value must be one of [html, man].

VERSION
    Last update:
    taxor version: 0.2.0
    SeqAn version: 3.4.0-rc.1
```


## Metadata
- **Skill**: generated
