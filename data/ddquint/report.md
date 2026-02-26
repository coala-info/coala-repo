# ddquint CWL Generation Report

## ddquint

### Tool Description
ddQuint: Digital Droplet PCR Multiplex Analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/ddquint:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/globuzzz2000/ddQuint
- **Package**: https://anaconda.org/channels/bioconda/packages/ddquint/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ddquint/overview
- **Total Downloads**: 73
- **Last updated**: 2025-08-12
- **GitHub**: https://github.com/globuzzz2000/ddQuint
- **Stars**: N/A
### Original Help Text
```text
usage: ddquint [-h] [--dir DIR] [--batch] [--output OUTPUT] [--verbose]
               [--debug] [--config [CONFIG]] [--template [TEMPLATE]]
               [--QXtemplate [QXTEMPLATE]] [--parameters]

ddQuint: Digital Droplet PCR Multiplex Analysis

options:
  -h, --help            show this help message and exit
  --dir DIR             Directory containing CSV files to process
  --batch               Process multiple directories (allows selection of
                        multiple folders)
  --output OUTPUT       Output directory for results (defaults to input
                        directory)
  --verbose             Enable verbose output
  --debug               Enable debug mode with detailed logging
  --config [CONFIG]     Configuration file or command (display, template, or
                        path to config file)
  --template [TEMPLATE]
                        Template file path for well names, or 'prompt' to
                        select via GUI
  --QXtemplate [QXTEMPLATE]
                        Create a plate template from a sample list
                        (CSV/Excel). Optionally provide a path or use 'prompt'
                        for a GUI selector.
  --parameters          Open parameter editor GUI for EXPECTED_CENTROIDS and
                        HDBSCAN settings

Examples:
  ddquint                           # Interactive analysis mode with GUI
  ddquint --dir /path/to/csv        # Process specific directory
  ddquint --batch                   # Process multiple directories with GUI selection
  ddquint --parameters              # Open parameter editor GUI
  ddquint --QXtemplate              # Interactively create a plate template
  ddquint --QXtemplate list.xlsx    # Create template from a specific file
  ddquint --config                  # Display configuration
  ddquint --config template         # Generate config template
```

