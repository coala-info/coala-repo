# cami-opal CWL Generation Report

## cami-opal_opal.py

### Tool Description
OPAL: Open-community Profiling Assessment tooL

### Metadata
- **Docker Image**: quay.io/biocontainers/cami-opal:1.0.13--pyhdfd78af_0
- **Homepage**: https://github.com/CAMI-challenge/OPAL
- **Package**: https://anaconda.org/channels/bioconda/packages/cami-opal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cami-opal/overview
- **Total Downloads**: 20.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CAMI-challenge/OPAL
- **Stars**: N/A
### Original Help Text
```text
usage: opal.py -g GOLD_STANDARD_FILE -o OUTPUT_DIR [-n] [-f FILTER] [-p]
               [-l LABELS] [-t TIME] [-m MEMORY] [-d DESC] [-r RANKS]
               [--metrics_plot_rel METRICS_PLOT_REL]
               [--metrics_plot_abs METRICS_PLOT_ABS] [--silent] [-v] [-h]
               [-b BRANCH_LENGTH_FUNCTION] [--normalized_unifrac]
               profiles_files [profiles_files ...]

OPAL: Open-community Profiling Assessment tooL

required arguments:
  profiles_files        Files of profiles
  -g GOLD_STANDARD_FILE, --gold_standard_file GOLD_STANDARD_FILE
                        Gold standard file
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Directory to write the results to

optional arguments:
  -n, --normalize       Normalize samples
  -f FILTER, --filter FILTER
                        Filter out the predictions with the smallest relative
                        abundances summing up to [FILTER]% within a rank
  -p, --plot_abundances
                        Plot abundances in the gold standard (can take some
                        minutes)
  -l LABELS, --labels LABELS
                        Comma-separated profiles names
  -t TIME, --time TIME  Comma-separated runtimes in hours
  -m MEMORY, --memory MEMORY
                        Comma-separated memory usages in gigabytes
  -d DESC, --desc DESC  Description for HTML page
  -r RANKS, --ranks RANKS
                        Highest and lowest taxonomic ranks to consider in
                        performance rankings, comma-separated. Valid ranks:
                        superkingdom, phylum, class, order, family, genus,
                        species, strain (default:superkingdom,species)
  --metrics_plot_rel METRICS_PLOT_REL
                        Metrics for spider plot of relative performances,
                        first character, comma-separated. Valid metrics:
                        w:weighted Unifrac, l:L1 norm, c:completeness,
                        p:purity, f:false positives, t:true positives
                        (default: w,l,c,p,f)
  --metrics_plot_abs METRICS_PLOT_ABS
                        Metrics for spider plot of absolute performances,
                        first character, comma-separated. Valid metrics:
                        c:completeness, p:purity, b:Bray-Curtis (default: c,p)
  --silent              Silent mode
  -v, --version         show program's version number and exit
  -h, --help            Show this help message and exit

UniFrac arguments:
  -b BRANCH_LENGTH_FUNCTION, --branch_length_function BRANCH_LENGTH_FUNCTION
                        UniFrac tree branch length function (default: "lambda
                        x: 1/x", where x=tree depth)
  --normalized_unifrac  Compute normalized version of weighted UniFrac by
                        dividing by the theoretical max unweighted UniFrac
```

