# pmidcite CWL Generation Report

## pmidcite_icite

### Tool Description
Run NIH's iCite given PubMed IDs

### Metadata
- **Docker Image**: quay.io/biocontainers/pmidcite:0.3.1--pyhdfd78af_0
- **Homepage**: http://github.com/dvklopfenstein/pmidcite
- **Package**: https://anaconda.org/channels/bioconda/packages/pmidcite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pmidcite/overview
- **Total Downloads**: 865
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/dvklopfenstein/pmidcite
- **Stars**: N/A
### Original Help Text
```text
usage: icite [-h] [--version] [--cite] [-i [INFILE ...]] [-H] [-k] [-v] [-l]
             [-c] [-r] [-R] [-a APPEND_OUTFILE] [-o OUTFILE] [-O] [-f] [-D]
             [-p] [-1 group1_min] [-2 group2_min] [-3 group3_min]
             [-4 group4_min] [--print-NIH-dividers]
             [--dir_icite_py DIR_ICITE_PY] [--dir_icite DIR_ICITE]
             [--dir_pubmed_txt DIR_PUBMED_TXT] [--md] [--generate-rcfile]
             [--print-rcfile]
             [PMID ...]

Run NIH's iCite given PubMed IDs

positional arguments:
  PMID                  PubMed IDs (PMIDs)

options:
  -h, --help            Print this help message and exit (also --help)
  --version             Print pmidcite's`icite` version number and exit
  --cite                publication citation for the pmidcite project
  -i, --infile [INFILE ...]
                        Read PMIDs from a file containing one PMID per line.
  -H, --print_header    Print column headings on one line.
  -k, --print_keys      Print the keys describing the abbreviations.
  -v, --verbose         Load and print a descriptive list of citations and
                        references for each paper.
  -l, --long-format     Print a multi-line description for each paper.
  -c, --load_citations  Load and print of papers and clinical studies that
                        cited the requested paper.
  -r, --load_references
                        Load and print the references for each requested
                        paper.
  -R, --no_references   (DEPRECATED) Do not load or print a descriptive list
                        of references. DEPRECATED -- Use instead: -c -r
  -a, --append_outfile APPEND_OUTFILE
                        Append current citation report to an ASCII text file.
                        Create if needed.
  -o, --outfile OUTFILE
                        Write current citation report to an ASCII text file.
  -O                    Write each PMIDs' iCite report with
                        citations/references to <dir_icite>/PMID.txt
  -f, --force_write     if an existing outfile file exists, overwrite it.
  -D, --force_download  Download PMID iCite information to a Python file,
                        over-writing if necessary.
  -p, --pubmed          Download PubMed entry containing title, abstract,
                        authors, journal, MeSH, etc.
  -1 group1_min         Minimum NIH percentile to be placed in group 1
                        (default: 2.1)
  -2 group2_min         Minimum NIH percentile to be placed in group 2
                        (default: 30.0)
  -3 group3_min         Minimum NIH percentile to be placed in group 3
                        (default: 60.0)
  -4 group4_min         Minimum NIH percentile to be placed in group 4
                        (default: 94.0)
  --print-NIH-dividers  Print the NIH percentile grouper divider percentages
  --dir_icite_py DIR_ICITE_PY
                        Write PMID iCite information into directory which
                        contains temporary working files (default=None)
  --dir_icite DIR_ICITE
                        Write PMID icite reports into directory (default=None)
  --dir_pubmed_txt DIR_PUBMED_TXT
                        Write PubMed entry into directory (default=None)
  --md                  Print using markdown table format.
  --generate-rcfile     Generate a sample configuration file according to the
                        current configuration.
  --print-rcfile        Print the location of the pmidcite configuration file

Help message printed because: -h or --help == True
```


## pmidcite_sumpaps

### Tool Description
Summarize NIH's citation data on a set(s) of papers

### Metadata
- **Docker Image**: quay.io/biocontainers/pmidcite:0.3.1--pyhdfd78af_0
- **Homepage**: http://github.com/dvklopfenstein/pmidcite
- **Package**: https://anaconda.org/channels/bioconda/packages/pmidcite/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sumpaps [-h] [-1 group1_min] [-2 group2_min] [-3 group3_min]
               [-4 group4_min] [--print-NIH-dividers] [--print-rcfile]
               [-p [labels ...]]
               [FILES ...]

Summarize NIH's citation data on a set(s) of papers

positional arguments:
  FILES                 File(s) containing NIH citation data for numerous
                        papers with PMIDs

options:
  -h, --help            print this help message and exit (also --help)
  -1 group1_min         Minimum NIH percentile to be placed in group 1
                        (default: 2.1)
  -2 group2_min         Minimum NIH percentile to be placed in group 2
                        (default: 30.0)
  -3 group3_min         Minimum NIH percentile to be placed in group 3
                        (default: 60.0)
  -4 group4_min         Minimum NIH percentile to be placed in group 4
                        (default: 94.0)
  --print-NIH-dividers  Print the NIH percentile grouper divider percentages
  --print-rcfile        Print the location of the pmidcite configuration file
                        (env var: PMIDCITECONF)
  -p [labels ...]       Paper label choices: TOP CIT CLI REF CITS ALL
                        (default: TOP)
```

