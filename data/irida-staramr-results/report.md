# irida-staramr-results CWL Generation Report

## irida-staramr-results

### Tool Description
Exports StarAMR results available through IRIDA into a single excel report.

### Metadata
- **Docker Image**: quay.io/biocontainers/irida-staramr-results:0.3.1--pyh5e36f6f_0
- **Homepage**: https://github.com/phac-nml/irida-staramr-results
- **Package**: https://anaconda.org/channels/bioconda/packages/irida-staramr-results/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/irida-staramr-results/overview
- **Total Downloads**: 10.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phac-nml/irida-staramr-results
- **Stars**: N/A
### Original Help Text
```text
usage: irida-staramr-results [-h] [-v] -p PROJECT [-o OUTPUT] [-u USERNAME]
                             [-pw PASSWORD] -c CONFIG [-sr] [-fd FROM_DATE]
                             [-td TO_DATE]

Exports StarAMR results available through IRIDA into a single excel report.

options:
  -h, --help            show this help message and exit
  -v, --version         The current version of irida-staramr-results.
  -p PROJECT, --project PROJECT
                        Required. Project(s) to scan for StarAMR results.
  -o OUTPUT, --output OUTPUT
                        The name of the output excel file.
  -u USERNAME, --username USERNAME
                        This is your IRIDA account username.
  -pw PASSWORD, --password PASSWORD
                        This is your IRIDA account password.
  -c CONFIG, --config CONFIG
                        Required. Path to a configuration file.
  -sr, --split_results  Export each analysis results into separate output
                        files resulting to one excel file per analysis.
  -fd FROM_DATE, --from_date FROM_DATE
                        Download only results of the analysis that were
                        created FROM this date (YYYY-MM-DD).
  -td TO_DATE, --to_date TO_DATE
                        Download only results of the analysis that were
                        created UP UNTIL this date (YYYY-MM-DD).
```

