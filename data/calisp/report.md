# calisp CWL Generation Report

## calisp

### Tool Description
Calisp.py. (C) Marc Strous, Xiaoli Dong and Manuel Kleiner, 2018, 2021

### Metadata
- **Docker Image**: quay.io/biocontainers/calisp:3.1.4--pyhdfd78af_0
- **Homepage**: https://github.com/kinestetika/Calisp
- **Package**: https://anaconda.org/channels/bioconda/packages/calisp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/calisp/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kinestetika/Calisp
- **Stars**: N/A
### Original Help Text
```text
[00h:00m:00s] This is calisp.py, version 3.1.4
usage: calisp [-h] --spectrum_file SPECTRUM_FILE --peptide_file PEPTIDE_FILE
              [--output_file OUTPUT_FILE] [--mass_accuracy MASS_ACCURACY]
              [--bin_delimiter BIN_DELIMITER] [--threads THREADS]
              [--isotope {13C,14C,15N,17O,18O,2H,3H,33S,34S,36S}]
              [--compute_clumps]
              [--isotope_abundance_matrix ISOTOPE_ABUNDANCE_MATRIX]

Calisp.py. (C) Marc Strous, Xiaoli Dong and Manuel Kleiner, 2018, 2021

optional arguments:
  -h, --help            show this help message and exit
  --spectrum_file SPECTRUM_FILE
                        [.mzML] file or folder with [.mzML] file(s).
  --peptide_file PEPTIDE_FILE
                        Search-engine-generated [.mzID] or [.target-peptide-
                        spectrum-match] file or folder with these files.
  --output_file OUTPUT_FILE
                        The name of the folder the output gets written to.
                        Default: calisp-output
  --mass_accuracy MASS_ACCURACY
                        The maximum mass difference between theoretical mass
                        and experimental mass of a peptide
  --bin_delimiter BIN_DELIMITER
                        For metagenomic data, the delimiter that separates the
                        bin ID from the protein ID [default "_"]. Use "--" to
                        ignore bin ID entirely.
  --threads THREADS     The number of (virtual) processors that calisp will
                        use (default 4)
  --isotope {13C,14C,15N,17O,18O,2H,3H,33S,34S,36S}
                        The target isotope. Default: 13C
  --compute_clumps      To compute clumpiness of carbon assimilation. Only use
                        when samples are labeled tosaturation. Estimation of
                        clumpiness takes much additional time.
  --isotope_abundance_matrix ISOTOPE_ABUNDANCE_MATRIX
                        To use a custom isotope abundance matrix. This is
                        useful when estimating abundances of less abundant,
                        non-C isotopes (e.g. H, O, N, S)
```

