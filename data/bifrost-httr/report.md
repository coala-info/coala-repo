# bifrost-httr CWL Generation Report

## bifrost-httr_compile-model

### Tool Description
Compile a Stan model file (uses built-in model if no file specified).

### Metadata
- **Docker Image**: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/seqera-services/bifrost-httr
- **Package**: https://anaconda.org/channels/bioconda/packages/bifrost-httr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bifrost-httr/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-10-17
- **GitHub**: https://github.com/seqera-services/bifrost-httr
- **Stars**: N/A
### Original Help Text
```text
Usage: bifrost-httr compile-model [OPTIONS] [STAN_FILE]

  Compile a Stan model file (uses built-in model if no file specified).

Options:
  --help  Show this message and exit.
```


## bifrost-httr_compress-output

### Tool Description
Compress intermediate output into a single pandas DataFrame.

### Metadata
- **Docker Image**: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/seqera-services/bifrost-httr
- **Package**: https://anaconda.org/channels/bioconda/packages/bifrost-httr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bifrost-httr compress-output [OPTIONS]

  Compress intermediate output into a single pandas DataFrame.

Options:
  -f, --fits-dir PATH        Directory containing probe .pkl files to process
                             [required]
  -o, --output PATH          Path to the output json  [required]
  -t, --test_substance TEXT  Test substance name (as it appears in the HTTr
                             meta data)
  -c, --cell_type TEXT       Cell type name (as it appears in the HTTr meta
                             data)
  -s, --seed INTEGER         Optional random seed for reproducibility
  --no-compression           Save output as plain JSON without compression
  --help                     Show this message and exit.
```


## bifrost-httr_create-report

### Tool Description
Create Bifrost HTTR reports using MultiQC.

### Metadata
- **Docker Image**: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/seqera-services/bifrost-httr
- **Package**: https://anaconda.org/channels/bioconda/packages/bifrost-httr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bifrost-httr create-report [OPTIONS]

  Create Bifrost HTTR reports using MultiQC.

Options:
  -s, --summary-file PATH         Path to the summary JSON file  [required]
  -t, --test-substance TEXT       Name of the test substance  [required]
  -c, --cell-type TEXT            Type of cell used in the test  [required]
  -o, --output-name TEXT          Name for the output report
  --timepoint TEXT                Exposure duration within experiment
  --conc-units [uM|ugml-1|mgml-1]
                                  Concentration units
  --interactive-plots             Force interactive plots (may be faster for
                                  large datasets)
  --n-fold-change-probes INTEGER  Number of most up/down regulated probes to
                                  show
  --cds-threshold FLOAT           Concentration-Dependency Score threshold for
                                  filtering probes
  --n-lowest-means INTEGER        Number of lowest mean PoD probes to show
  --n-pod-stats INTEGER           Number of probes to include in PoD
                                  statistics table
  --plot-height INTEGER           Height of concentration-response plots in
                                  pixels
  --pod-vs-fc-height INTEGER      Height of PoD vs Fold Change plot in pixels
  --no-cds-threshold              Do not filter probes by CDS threshold in
                                  summary tables and lowest mean PoDs section
  --custom-templates PATH         Path to custom template YAML file to
                                  override default report templates
  --help                          Show this message and exit.
```


## bifrost-httr_prepare-inputs

### Tool Description
Prepare Bifrost inputs from meta data and counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/seqera-services/bifrost-httr
- **Package**: https://anaconda.org/channels/bioconda/packages/bifrost-httr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bifrost-httr prepare-inputs [OPTIONS]

  Prepare Bifrost inputs from meta data and counts.

Options:
  -m, --meta-data PATH            Path to meta data CSV file  [required]
  --meta-mapper PATH              Optional: Path to meta data mapper YAML
                                  file. Not needed if metadata columns already
                                  match BIFROST's internal format.
  -c, --counts PATH               Path to counts CSV file  [required]
  --config PATH                   Path to configuration YAML file  [required]
  --batch-key TEXT                Field to use as batch key in the BIFROST
                                  model (default: 'N/A' - single batch for all
                                  samples)
  --min-percent-mapped-reads FLOAT
                                  Minimum percentage of mapped reads required
                                  (default: 50.0)
  --min-num-mapped-reads INTEGER  Minimum number of mapped reads required
                                  (default: 100000)
  --min-avg-treatment-count INTEGER
                                  Minimum average treatment count required
                                  (default: 5)
  --batch-matched-controls        Filter control samples to only those in
                                  batches containing treatments (default:
                                  False)
  -o, --output-dir PATH           Directory to store outputs  [required]
  --help                          Show this message and exit.
```


## bifrost-httr_run-analysis

### Tool Description
Run concentration-response analysis on BIFROST data files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/seqera-services/bifrost-httr
- **Package**: https://anaconda.org/channels/bioconda/packages/bifrost-httr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bifrost-httr run-analysis [OPTIONS]

  Run concentration-response analysis on BIFROST data files.

Options:
  -f, --data-files TEXT        List of probe .pkl files to process  [required]
  -m, --model-executable PATH  Path to compiled Stan model executable
                               (optional, will use default model if not
                               provided)
  -n, --n-cores INTEGER        Number of cores to use in multiprocessing
  -o, --output-dir PATH        Directory to store outputs  [required]
  -s, --seed INTEGER           Optional random seed for reproducibility
  --help                       Show this message and exit.
```


## bifrost-httr_split-data

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/seqera-services/bifrost-httr
- **Package**: https://anaconda.org/channels/bioconda/packages/bifrost-httr/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: bifrost-httr split-data [OPTIONS]
Try 'bifrost-httr split-data --help' for help.

Error: No such option: --h Did you mean --help?
```


## Metadata
- **Skill**: not generated
