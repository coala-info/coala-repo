# tadtool CWL Generation Report

## tadtool_plot

### Tool Description
Main interactive TADtool plotting window

### Metadata
- **Docker Image**: quay.io/biocontainers/tadtool:0.84--pyh7cba7a3_0
- **Homepage**: https://github.com/vaquerizaslab/tadtool
- **Package**: https://anaconda.org/channels/bioconda/packages/tadtool/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tadtool/overview
- **Total Downloads**: 27.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vaquerizaslab/tadtool
- **Stars**: N/A
### Original Help Text
```text
usage: tadtool plot [-h] [-w WINDOW_SIZES [WINDOW_SIZES ...]] [-a ALGORITHM]
                    [-m MAX_DIST] [-n NORMALISATION_WINDOW] [-d DATA]
                    matrix regions plotting_region

Main interactive TADtool plotting window

positional arguments:
  matrix                Square Hi-C Matrix as tab-delimited or .npy file
                        (created with numpy.save) or sparse matrix format
                        (each line: <row region index> <column region index>
                        <matrix value>)
  regions               BED file (no header) with regions corresponding to the
                        number of rows in the provided matrix. Fourth column,
                        if present, denotes name field, which is used as an
                        identifier in sparse matrix notation.
  plotting_region       Region of the Hi-C matrix to display in plot. Format:
                        <chromosome>:<start>-<end>, e.g.
                        chr12:31000000-33000000

options:
  -h, --help            show this help message and exit
  -w WINDOW_SIZES [WINDOW_SIZES ...], --window-sizes WINDOW_SIZES [WINDOW_SIZES ...]
                        Window sizes in base pairs used for TAD calculation.
                        You can pass (1) a filename with whitespace-delimited
                        window sizes, (2) three integers denoting start, stop,
                        and step size to generate a range of window sizes, or
                        (3) more than three integers to define window sizes
                        directly. If left at default, window sizes will be
                        logarithmically spaced between 10**4 and 10**6, or
                        10**6.5 for the insulation and directionality index,
                        respectively.
  -a ALGORITHM, --algorithm ALGORITHM
                        TAD-calling algorithm. Options: insulation,
                        ninsulation, directionality. Default: insulation.
  -m MAX_DIST, --max-distance MAX_DIST
                        Maximum distance in base-pairs away from the diagonal
                        to be shown in Hi-C plot. Defaults to half the
                        plotting window.
  -n NORMALISATION_WINDOW, --normalisation-window NORMALISATION_WINDOW
                        Normalisation window in number of regions. Only
                        affects ninsulation algorithm. If not specified,
                        window will be the whole chromosome.
  -d DATA, --data DATA  Matrix with index data. Rows correspond to window
                        sizes, columns to Hi-C matrix bins. If provided,
                        suppresses inbuilt index calculation.
```


## tadtool_tads

### Tool Description
Call TADs with pre-defined parameters

### Metadata
- **Docker Image**: quay.io/biocontainers/tadtool:0.84--pyh7cba7a3_0
- **Homepage**: https://github.com/vaquerizaslab/tadtool
- **Package**: https://anaconda.org/channels/bioconda/packages/tadtool/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tadtool tads [-h] [-a ALGORITHM] [-n NORMALISATION_WINDOW] [-v]
                    matrix regions window_size cutoff [output]

Call TADs with pre-defined parameters

positional arguments:
  matrix                Square Hi-C Matrix as tab-delimited or .npy file
                        (created with numpy.save) or sparse matrix format
                        (each line: <row region index> <column region index>
                        <matrix value>)
  regions               BED file (no header) with regions corresponding to the
                        number of rows in the provided matrix. Fourth column,
                        if present, denotes name field, which is used as an
                        identifier in sparse matrix notation.
  window_size           Window size in base pairs
  cutoff                Cutoff for TAD-calling algorithm at given window size.
  output                Optional output file to save TADs.

options:
  -h, --help            show this help message and exit
  -a ALGORITHM, --algorithm ALGORITHM
                        TAD-calling algorithm. Options: insulation,
                        ninsulation, directionality. Default: insulation.
  -n NORMALISATION_WINDOW, --normalisation-window NORMALISATION_WINDOW
                        Normalisation window in number of regions. Only
                        affects ninsulation algorithm. If not specified,
                        window will be the whole chromosome.
  -v, --write-values    Write index values to file instead of TADs.
```


## tadtool_subset

### Tool Description
Reduce a matrix to a smaller region.

### Metadata
- **Docker Image**: quay.io/biocontainers/tadtool:0.84--pyh7cba7a3_0
- **Homepage**: https://github.com/vaquerizaslab/tadtool
- **Package**: https://anaconda.org/channels/bioconda/packages/tadtool/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tadtool subset [-h]
                      matrix regions sub_region output_matrix output_regions

Reduce a matrix to a smaller region.

positional arguments:
  matrix          Square Hi-C Matrix as tab-delimited or .npy file (created
                  with numpy.save) or sparse matrix format (each line: <row
                  region index> <column region index> <matrix value>)
  regions         BED file (no header) with regions corresponding to the
                  number of rows in the provided matrix. Fourth column, if
                  present, denotes name field, which is used as an identifier
                  in sparse matrix notation.
  sub_region      Region of the Hi-C matrix to display in plot. Format:
                  <chromosome>:<start>-<end>, e.g. chr12:31000000-33000000
  output_matrix   Output matrix file.
  output_regions  Output regions file.

options:
  -h, --help      show this help message and exit
```


## Metadata
- **Skill**: generated
