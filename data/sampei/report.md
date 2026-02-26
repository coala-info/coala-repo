# sampei CWL Generation Report

## sampei

### Tool Description
SAMPEI is a searching method leveraging high quality query spectra within the same or different dataset to assign target spectra with peptide sequence and undefined modification (mass shift).

### Metadata
- **Docker Image**: quay.io/biocontainers/sampei:0.0.9--py_0
- **Homepage**: https://github.com/FenyoLab/SAMPEI
- **Package**: https://anaconda.org/channels/bioconda/packages/sampei/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sampei/overview
- **Total Downloads**: 11.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/FenyoLab/SAMPEI
- **Stars**: N/A
### Original Help Text
```text
usage: SAMPEI [-h] [--max-peaks-per-scan MAX_PEAKS_PER_SCAN]
              [--fragment-mass-error FRAGMENT_MASS_ERROR]
              [--matched-query-intensity MATCHED_QUERY_INTENSITY]
              [--error-type {ppm,dalton}] [-O OUTPUT_DIRECTORY] [--no-filter]
              [--largest-gap-percent LARGEST_GAP_PERCENT]
              [--matched-peptide-intensity MATCHED_PEPTIDE_INTENSITY]
              [--min-diff-dalton-bin MIN_DIFF_DALTON_BIN]
              [--xtandem-xml XTANDEM_XML] [--write-intermediate] [-v]
              mgf_query_file mgf_target_file id_file

SAMPEI is a searching method leveraging high quality query spectra within the
same or different dataset to assign target spectra with peptide sequence and
undefined modification (mass shift).

positional arguments:
  mgf_query_file        Query mgf file with full path containing query scans
                        have been identified by DB search
  mgf_target_file       Target mgf file with full path containing target scans
                        with undefined modifications
  id_file               File in which query scans have been identified by DB
                        search

optional arguments:
  -h, --help            show this help message and exit
  --max-peaks-per-scan MAX_PEAKS_PER_SCAN
                        (default = 20)
  --fragment-mass-error FRAGMENT_MASS_ERROR
                        (default = 20)
  --matched-query-intensity MATCHED_QUERY_INTENSITY
                        The percentage of MS2 intensity of query scan matched
                        to target scan over the summation of total MS2
                        intensity in the query scan. (default = 0.3)
  --error-type {ppm,dalton}
                        (default = ppm)
  -O OUTPUT_DIRECTORY, --output-directory OUTPUT_DIRECTORY
                        Full path to the directory where output is stored. If
                        this directory does not exist it will be created.
                        (default = output)
  --no-filter           Disable the filter and keep DB identified scans in the
                        target mgf file
  --largest-gap-percent LARGEST_GAP_PERCENT
                        The percentage of the largest consecutive b/y ion
                        missing over the length of the peptide sequence.
                        (default = 0.4)
  --matched-peptide-intensity MATCHED_PEPTIDE_INTENSITY
                        The percentage of MS2 intensity of target scan matched
                        to the theoretical fragments of peptide sequence over
                        the summation of total MS2 intensity in the target
                        scan. (default = 0.5)
  --min-diff-dalton-bin MIN_DIFF_DALTON_BIN
                        The absolute minimum dalton difference between the
                        query scan and the target scan. (default = 10)
  --xtandem-xml XTANDEM_XML
                        The path to an X!tandem xml file which will be used to
                        filter the results.
  --write-intermediate  Write files for each step of filtering.
  -v, --version         show program's version number and exit
```

