# sigprofilerplotting CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sigprofilerplotting_plotCNV | PASS |  |
| sigprofilerplotting_plotDBS | PASS | synthetic data: DBS78 matrix made by SigProfilerMatrixGenerator from planted doublets; the repo's own DBS78 example fails to plot (NaN counts) |
| sigprofilerplotting_plotID | PASS |  |
| sigprofilerplotting_plotSBS | PASS |  |
| sigprofilerplotting_plotSV | PASS |  |

## sigprofilerplotting_plotSBS

### Tool Description
Plot Single Base Substitutions.

### Metadata
- **Docker Image**: quay.io/biocontainers/sigprofilerplotting:1.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/alexandrovlab/SigProfilerPlotting
- **Package**: https://anaconda.org/channels/bioconda/packages/sigprofilerplotting/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SigProfilerPlotting plotSBS [-h] [--percentage [PERCENTAGE]]
                                   [--custom_text_upper CUSTOM_TEXT_UPPER]
                                   [--custom_text_middle CUSTOM_TEXT_MIDDLE]
                                   [--custom_text_bottom CUSTOM_TEXT_BOTTOM]
                                   [--savefig_format {pdf,png,pil_image}]
                                   [--volume VOLUME] [--dpi DPI]
                                   matrix_path output_path project plot_type

Generate SBS plots.

positional arguments:
  matrix_path           The path to the input matrix file.
  output_path           The directory where the plots will be saved.
  project               The name of the project.
  plot_type             The type of plot to generate.

options:
  -h, --help            show this help message and exit
  --percentage [PERCENTAGE]
                        Display percentages in the plot.
  --custom_text_upper CUSTOM_TEXT_UPPER
                        Custom text to display at the top of the plot.
  --custom_text_middle CUSTOM_TEXT_MIDDLE
                        Custom text to display in the middle of the plot.
  --custom_text_bottom CUSTOM_TEXT_BOTTOM
                        Custom text to display at the bottom of the plot.
  --savefig_format {pdf,png,pil_image}
                        The file format for saving the plot.
  --volume VOLUME       Specify a volume for Docker container usage.
  --dpi DPI             The resolution of the plot in dots per inch.
```

## sigprofilerplotting_plotID

### Tool Description
Plot small insertions and deletions.

### Metadata
- **Docker Image**: quay.io/biocontainers/sigprofilerplotting:1.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/alexandrovlab/SigProfilerPlotting
- **Package**: https://anaconda.org/channels/bioconda/packages/sigprofilerplotting/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SigProfilerPlotting plotID [-h] [--percentage [PERCENTAGE]]
                                  [--custom_text_upper CUSTOM_TEXT_UPPER]
                                  [--custom_text_middle CUSTOM_TEXT_MIDDLE]
                                  [--custom_text_bottom CUSTOM_TEXT_BOTTOM]
                                  [--savefig_format {pdf,png,pil_image}]
                                  [--volume VOLUME] [--dpi DPI]
                                  matrix_path output_path project plot_type

Generate ID plots.

positional arguments:
  matrix_path           The path to the input matrix file.
  output_path           The directory where the plots will be saved.
  project               The name of the project.
  plot_type             The type of plot to generate.

options:
  -h, --help            show this help message and exit
  --percentage [PERCENTAGE]
                        Display percentages in the plot.
  --custom_text_upper CUSTOM_TEXT_UPPER
                        Custom text to display at the top of the plot.
  --custom_text_middle CUSTOM_TEXT_MIDDLE
                        Custom text to display in the middle of the plot.
  --custom_text_bottom CUSTOM_TEXT_BOTTOM
                        Custom text to display at the bottom of the plot.
  --savefig_format {pdf,png,pil_image}
                        The file format for saving the plot.
  --volume VOLUME       Specify a volume for Docker container usage.
  --dpi DPI             The resolution of the plot in dots per inch.
```

## sigprofilerplotting_plotDBS

### Tool Description
Plot Doublet Base Substitutions.

### Metadata
- **Docker Image**: quay.io/biocontainers/sigprofilerplotting:1.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/alexandrovlab/SigProfilerPlotting
- **Package**: https://anaconda.org/channels/bioconda/packages/sigprofilerplotting/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SigProfilerPlotting plotDBS [-h] [--percentage [PERCENTAGE]]
                                   [--custom_text_upper CUSTOM_TEXT_UPPER]
                                   [--custom_text_middle CUSTOM_TEXT_MIDDLE]
                                   [--custom_text_bottom CUSTOM_TEXT_BOTTOM]
                                   [--savefig_format {pdf,png,pil_image}]
                                   [--volume VOLUME] [--dpi DPI]
                                   matrix_path output_path project plot_type

Generate DBS plots.

positional arguments:
  matrix_path           The path to the input matrix file.
  output_path           The directory where the plots will be saved.
  project               The name of the project.
  plot_type             The type of plot to generate.

options:
  -h, --help            show this help message and exit
  --percentage [PERCENTAGE]
                        Display percentages in the plot.
  --custom_text_upper CUSTOM_TEXT_UPPER
                        Custom text to display at the top of the plot.
  --custom_text_middle CUSTOM_TEXT_MIDDLE
                        Custom text to display in the middle of the plot.
  --custom_text_bottom CUSTOM_TEXT_BOTTOM
                        Custom text to display at the bottom of the plot.
  --savefig_format {pdf,png,pil_image}
                        The file format for saving the plot.
  --volume VOLUME       Specify a volume for Docker container usage.
  --dpi DPI             The resolution of the plot in dots per inch.
```

## sigprofilerplotting_plotSV

### Tool Description
Plot Structural Variations.

### Metadata
- **Docker Image**: quay.io/biocontainers/sigprofilerplotting:1.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/alexandrovlab/SigProfilerPlotting
- **Package**: https://anaconda.org/channels/bioconda/packages/sigprofilerplotting/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SigProfilerPlotting plotSV [-h] [--percentage [PERCENTAGE]]
                                  [--aggregate [AGGREGATE]]
                                  [--savefig_format {pdf,png,pil_image}]
                                  [--dpi DPI]
                                  matrix_path output_path project

Generate SV plots.

positional arguments:
  matrix_path           The path to the input matrix file.
  output_path           The directory where the plots will be saved.
  project               The name of the project.

options:
  -h, --help            show this help message and exit
  --percentage [PERCENTAGE]
                        Display percentages in the plot.
  --aggregate [AGGREGATE]
                        Aggregate all samples.
  --savefig_format {pdf,png,pil_image}
                        The file format for saving the plot.
  --dpi DPI             The resolution of the plot in dots per inch.
```

## sigprofilerplotting_plotCNV

### Tool Description
Plot Copy Number Variations.

### Metadata
- **Docker Image**: quay.io/biocontainers/sigprofilerplotting:1.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/alexandrovlab/SigProfilerPlotting
- **Package**: https://anaconda.org/channels/bioconda/packages/sigprofilerplotting/overview
- **Validation**: PASS

### Original Help Text
```text
usage: SigProfilerPlotting plotCNV [-h] [--percentage [PERCENTAGE]]
                                   [--aggregate [AGGREGATE]]
                                   [--read_from_file [READ_FROM_FILE]]
                                   [--savefig_format {pdf,png,pil_image}]
                                   [--dpi DPI]
                                   matrix_path output_path project

Generate CNV plots.

positional arguments:
  matrix_path           The path to the input matrix file.
  output_path           The directory where the plots will be saved.
  project               The name of the project.

options:
  -h, --help            show this help message and exit
  --percentage [PERCENTAGE]
                        Display percentages in the plot.
  --aggregate [AGGREGATE]
                        Aggregate data for the plot.
  --read_from_file [READ_FROM_FILE]
                        Read data from a file for the plot.
  --savefig_format {pdf,png,pil_image}
                        The file format for saving the plot.
  --dpi DPI             The resolution of the plot in dots per inch.
```

