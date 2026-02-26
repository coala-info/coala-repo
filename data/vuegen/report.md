# vuegen CWL Generation Report

## vuegen

### Tool Description
Please provide a configuration file or directory path:

### Metadata
- **Docker Image**: quay.io/biocontainers/vuegen:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/Multiomics-Analytics-Group/vuegen
- **Package**: https://anaconda.org/channels/bioconda/packages/vuegen/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vuegen/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/Multiomics-Analytics-Group/vuegen
- **Stars**: N/A
### Original Help Text
```text
Please provide a configuration file or directory path:

usage: VueGen [-h] [-c CONFIG] [-dir DIRECTORY] [-rt REPORT_TYPE]
              [-output_dir OUTPUT_DIRECTORY] [-st_autorun] [-qt_checks]
              [-mdep MAX_DEPTH]

options:
  -h, --help            show this help message and exit
  -c, --config CONFIG   Path to the YAML configuration file.
  -dir, --directory DIRECTORY
                        Path to the directory from which the YAML config will
                        be inferred.
  -rt, --report_type REPORT_TYPE
                        Type of the report to generate: streamlit, html, pdf,
                        docx, odt, revealjs, pptx, or jupyter.
  -output_dir, --output_directory OUTPUT_DIRECTORY
                        Path to the output directory for the generated report.
  -st_autorun, --streamlit_autorun
                        Automatically run the Streamlit app after report
                        generation.
  -qt_checks, --quarto_checks
                        Check if Quarto is installed and available for report
                        generation.
  -mdep, --max_depth MAX_DEPTH
                        Maximum depth for the recursive search of files in the
                        input directory. Ignored if a config file is provided.
```

