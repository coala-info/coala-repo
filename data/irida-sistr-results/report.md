# irida-sistr-results CWL Generation Report

## irida-sistr-results

### Tool Description
Compile SISTR results from an IRIDA instance into a table.

### Metadata
- **Docker Image**: quay.io/biocontainers/irida-sistr-results:0.6.0--py36_0
- **Homepage**: http://github.com/phac-nml/irida-sistr-results
- **Package**: https://anaconda.org/channels/bioconda/packages/irida-sistr-results/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/irida-sistr-results/overview
- **Total Downloads**: 23.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phac-nml/irida-sistr-results
- **Stars**: N/A
### Original Help Text
```text
usage: irida-sistr-results [-h] [--irida-url IRIDA_URL]
                           [--client-id CLIENT_ID]
                           [--client-secret CLIENT_SECRET] [-u USERNAME]
                           [--password PASSWORD] [-v] [-p PROJECTS] [-a]
                           [--output-tab TABULAR_FILE] [-o EXCEL_FILE]
                           [--include-user-results]
                           [--exclude-user-existing-results]
                           [--reportable-serovars-file REPORTABLE_SEROVARS_FILE]
                           [--exclude-reportable-status] [-T TIMEOUT]
                           [-c CONFIG] [-V] [-w WORKFLOW_VERSIONS_OR_IDS]
                           [-d SAMPLES_CREATED_SINCE]

Compile SISTR results from an IRIDA instance into a table.

optional arguments:
  -h, --help            show this help message and exit
  --irida-url IRIDA_URL
                        The URL to the IRIDA instance.
  --client-id CLIENT_ID
                        The client id for an IRIDA instance.
  --client-secret CLIENT_SECRET
                        The client secret for the IRIDA instance.
  -u USERNAME, --username USERNAME
                        The username for the IRIDA instance.
  --password PASSWORD   The password for the IRIDA instance. Prompts for password if left blank.
  -v, --verbose         Turn on verbose logging.
  -p PROJECTS, --project PROJECTS
                        Projects to scan for SISTR results. If left blank will scan all projects the user has access to.
  -a, --all-projects    Explicitly load results from all projects the user has access to.  Will ignore the values given in --project.
  --output-tab TABULAR_FILE, --to-tab-file TABULAR_FILE
                        Print results to tab-deliminited file.
  -o EXCEL_FILE, --output-excel EXCEL_FILE, --to-excel-file EXCEL_FILE
                        Print results to the given excel file.
  --include-user-results
                        Include SISTR analysis results run directly by the user.
  --exclude-user-existing-results
                        If including user results, do not replace existing SISTR analysis that were automatically generated with user-run SISTR results.
  --reportable-serovars-file REPORTABLE_SEROVARS_FILE
                        The reportable serovars file [/usr/local/lib/python3.6/site-packages/irida_sistr_results/data/reportable_serovars.tsv].
  --exclude-reportable-status
                        Excludes printing of reportable serovar status in final output.
  -T TIMEOUT, --connection-timeout TIMEOUT
                        Connection timeout when getting results from IRIDA.
  -c CONFIG, --config CONFIG
                        Configuration file for IRIDA (overrides values in ['/usr/local/lib/python3.6/site-packages/irida_sistr_results/etc/config.ini', '/root/.local/share/irida-sistr-results/config.ini'])
  -V, --version         show program's version number and exit
  -w WORKFLOW_VERSIONS_OR_IDS, --workflow WORKFLOW_VERSIONS_OR_IDS
                        Only include results of these workflow versions (or uuids) ['0.1', '0.2', '0.3'] [all versions]
  -d SAMPLES_CREATED_SINCE, --samples-created-since SAMPLES_CREATED_SINCE
                        Only include samples created more recently than this date (in format YYYY-MM-DD) or this many days ago (as a number) [Include all samples]

Example:
	irida-sistr-results -a -u irida-user -o out.xlsx
		Exports all SISTR results from all projects to a file 'out.xlsx'

	irida-sistr-results -p 1 -p 2 -u irida-user -o out.xlsx
		Exports SISTR results from projects [1,2] to a file 'out.xlsx'

	irida-sistr-results -p 1 -w 0.3 -w 0.2 -u irida-user -o out.xlsx
		Exports only SISTR results from workflow versions 0.3 and 0.2 from project [1]
```

