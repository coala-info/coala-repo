# taxburst CWL Generation Report

## taxburst

### Tool Description
Visualize taxonomic assignments from sourmash csv_summary files.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxburst:0.3.2--pyhdfd78af_0
- **Homepage**: https://github.com/taxburst/taxburst
- **Package**: https://anaconda.org/channels/bioconda/packages/taxburst/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxburst/overview
- **Total Downloads**: 403
- **Last updated**: 2025-08-19
- **GitHub**: https://github.com/taxburst/taxburst
- **Stars**: N/A
### Original Help Text
```text
usage: taxburst [-h] [-F {csv_summary,tax_annotate,SingleM,krona,json}]
                [-o OUTPUT_HTML] [--save-json SAVE_JSON] [--check-tree]
                [--fail-on-error]
                tax_csv

positional arguments:
  tax_csv               input tax CSV, in sourmash csv_summary format

options:
  -h, --help            show this help message and exit
  -F, --input-format {csv_summary,tax_annotate,SingleM,krona,json}
  -o, --output-html OUTPUT_HTML
                        output HTML file to this location.
  --save-json SAVE_JSON
                        output a JSON file of the taxonomy
  --check-tree          check that tree makes sense
  --fail-on-error       fail if tree doesn't pass checks; implies --check-tree
```

