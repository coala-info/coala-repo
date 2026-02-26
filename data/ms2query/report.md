# ms2query CWL Generation Report

## ms2query

### Tool Description
MS2Query is a tool for MSMS library matching, searching both for analogues and exact matches in one run

### Metadata
- **Docker Image**: quay.io/biocontainers/ms2query:1.5.4--pyhdfd78af_0
- **Homepage**: https://github.com/iomega/ms2query
- **Package**: https://anaconda.org/channels/bioconda/packages/ms2query/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ms2query/overview
- **Total Downloads**: 9.4K
- **Last updated**: 2025-05-22
- **GitHub**: https://github.com/iomega/ms2query
- **Stars**: N/A
### Original Help Text
```text
usage: MS2Query [-h] [--spectra SPECTRA] --library LIBRARY_FOLDER
                [--ionmode {positive,negative}] [--download]
                [--results RESULTS] [--filter_ionmode]
                [--additional_metadata ADDITIONAL_METADATA [ADDITIONAL_METADATA ...]]

MS2Query is a tool for MSMS library matching, searching both for analogues and
exact matches in one run

options:
  -h, --help            show this help message and exit
  --spectra SPECTRA     The MS2 query spectra that should be processed. If a
                        directory is specified all spectrum files in the
                        directory will be processed. Accepted formats are:
                        "mzML", "json", "mgf", "msp", "mzxml", "usi" or a
                        pickled matchms object
  --library LIBRARY_FOLDER
                        The directory containing the library spectra (in
                        sqlite), models and precalculated embeddings, to
                        download add --download
  --ionmode {positive,negative}
                        Specify the ionization mode used
  --download            This will download the most up to date model and
                        library.The model will be stored in the folder given
                        as the second argumentThe model will be downloaded in
                        the in the ionization mode specified under --mode
  --results RESULTS     The folder in which the results should be stored. The
                        default is a new results folder in the folder with the
                        spectra
  --filter_ionmode      Filter out all spectra that are not in the specified
                        ion-mode. The ion mode can be specified by using
                        --ionmode
  --additional_metadata ADDITIONAL_METADATA [ADDITIONAL_METADATA ...]
                        Return additional metadata columns in the results, for
                        example --additional_metadata retention_time
                        feature_id
```

