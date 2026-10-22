# taxor CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| taxor_build | PASS | synthetic data: index of phages T7, T3 and lambda from NCBI built; baseCommand fixed from taxor-build to taxor build |
| taxor_profile | PASS | synthetic data: profile of the search result gave 71 percent T7 and T3, 29 percent lambda, as expected from genome sizes |
| taxor_search | PASS | synthetic data: 120 reads cut from the three phage genomes with 2 percent errors were all assigned to the right phage |

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

## taxor_search

### Tool Description
Queries files of DNA sequences against a list of HIXF index files

### Metadata
- **Docker Image**: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
- **Homepage**: https://github.com/JensUweUlrich/Taxor
- **Package**: https://anaconda.org/channels/bioconda/packages/taxor/overview
- **Validation**: PASS

### Original Help Text
```text
taxor-search - Queries files of DNA sequences against a list of HIXF index files
================================================================================

DESCRIPTION
    Query sequences against the taxor HIXF index structure

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
    --index-file (std::string)
          taxor index file containing HIXF index and reference sequence
          information
    --query-file (std::string)
          file containing sequences to query against the index Default: .
    --output-file (std::string)
          A file name for the resulting output. Default: .
    --threads (unsigned 8 bit integer)
          The number of threads to use. Default: 1. Value must be in range
          [1,32].
    --percentage (double)
          If set, this threshold is used instead of the k-mer/syncmer models.
          Default: -1. Value must be in range [0,1].
    --error-rate (double)
          Expected error rate of reads that will be queried Default: 0.04.
          Value must be in range [0,1].

VERSION
    Last update:
    taxor-search version: 0.2.0
    SeqAn version: 3.4.0-rc.1

LEGAL
    Author: Jens-Uwe Ulrich
    Contact: jens-uwe.ulrich@hpi.de
    SeqAn Copyright: 2006-2023 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
```

## taxor_profile

### Tool Description
Taxonomic profiling of a sample by giving read matching results of Taxor search

### Metadata
- **Docker Image**: quay.io/biocontainers/taxor:0.2.1--h4e8ebbd_0
- **Homepage**: https://github.com/JensUweUlrich/Taxor
- **Package**: https://anaconda.org/channels/bioconda/packages/taxor/overview
- **Validation**: PASS

### Original Help Text
```text
taxor-profile - Taxonomic profiling of a sample by giving read matching results of Taxor search
===============================================================================================

DESCRIPTION
    Taxonomic profiling of the given read set

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
    --search-file (std::string)
          taxor search file containing results of read querying against the
          HIXF index
    --cami-report-file (std::string)
          output file reporting genomic abundances in CAMI profiling format.
          This is the relative genome abundance in terms of the genome copy
          number for the respective TAXID in the overall sample. Note that
          this is not identical to the relative abundance in terms of assigned
          base pairs.
    --seq-abundance-file (std::string)
          output file reporting sequence abundance in CAMI profiling format
          (including unclassified reads). This is the relative sequence
          abundance in terms of sequenced base pairs for the respective TAXID
          in the overall sample. Note that this is not identical to the
          genomic abundance in terms of genome copy number for the respective
          TAXID. Default: .
    --binning-file (std::string)
          output file reporting read to taxa assignments in CAMI binning
          format
    --sample-id (std::string)
          Identifier of the analyzed sample
    --min-abundance (double)
          Minimum abundance to report (default: 0.001) Default: 0.001. Value
          must be in range [0,1].
    --em-steps (unsigned 16 bit integer)
          The number of steps for the expectation maximization (EM) algorithm
          (default: 100). Default: 100. Value must be in range [1,1000].

VERSION
    Last update:
    taxor-profile version: 0.2.0
    SeqAn version: 3.4.0-rc.1

LEGAL
    Author: Jens-Uwe Ulrich
    Contact: jens-uwe.ulrich@hpi.de
    SeqAn Copyright: 2006-2023 Knut Reinert, FU-Berlin; released under the
    3-clause BSDL.
```

## Metadata
- **Skill**: generated
