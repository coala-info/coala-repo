# cameo CWL Generation Report

## cameo_design

### Tool Description
Compute strain designs for desired product.

### Metadata
- **Docker Image**: quay.io/biocontainers/cameo:0.13.6--pyhdfd78af_0
- **Homepage**: http://cameo.bio
- **Package**: https://anaconda.org/channels/bioconda/packages/cameo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cameo/overview
- **Total Downloads**: 13.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: cameo design [OPTIONS] PRODUCT

  Compute strain designs for desired product.

Options:
  -o, --output PATH               Output filename. Multiple output files can
                                  be provided (pair with respective format
                                  options).
  -f, --format [xlsx|csv|tsv|pickle]
                                  Output file format (default csv).
  -h, --host [ecoli|scerevisiae]  The host organisms to consider (default:
                                  all). Multiple hosts can be specified by
                                  repeating --host HOST.
  --aerobic / --anaerobic         Make oxygen available to the host organism
                                  (default).
  --cores INTEGER RANGE           Number of CPU cores to use (default 1).
                                  [1<=x<=20]
  --differential-fva / --no-differential-fva
                                  Perform differential flux variability
                                  analysis to determine flux modulation
                                  targets (default).
  --heuristic-optimization / --no-heuristic-optimization
                                  Find gene knockout targets through heuristic
                                  optimization (default).
  --max-pathway-predictions INTEGER
                                  Maximum number of heterologous pathways to
                                  predict (default 1).
  --differential-fva-points INTEGER
                                  Grid points for differential FVA (default
                                  10).
  --pathway-prediction-timeout INTEGER
                                  Time limit (min) for individual pathway
                                  predictions (default 10 min).
  --heuristic-optimization-timeout INTEGER
                                  Time limit (min) on individual heuristic
                                  optimizations (default 45 min).
  --logging [CRITICAL|ERROR|WARNING|INFO|DEBUG]
                                  Logging level (default WARNING).
  --help                          Show this message and exit.
```


## cameo_search

### Tool Description
Search for available products.

### Metadata
- **Docker Image**: quay.io/biocontainers/cameo:0.13.6--pyhdfd78af_0
- **Homepage**: http://cameo.bio
- **Package**: https://anaconda.org/channels/bioconda/packages/cameo/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cameo search [OPTIONS] PRODUCT

  Search for available products.

  PRODUCT: The target product. You can search by name, InChI, and metanetx ID.

  Examples
  --------
  $ cameo search chebi:30838  # search for itaconate

Options:
  --help  Show this message and exit.
```


## Metadata
- **Skill**: not generated
