# illumina-interop CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| illumina-interop_aggregate | PASS |  |
| illumina-interop_dumpbin | PASS |  |
| illumina-interop_dumptext | PASS |  |
| illumina-interop_imaging_table | PASS |  |
| illumina-interop_index-summary | Not completed | no usable test data: the available run folders have no index metrics, so the output is empty. |
| illumina-interop_plot_by_cycle | PASS |  |
| illumina-interop_plot_by_lane | PASS |  |
| illumina-interop_plot_flowcell | PASS |  |
| illumina-interop_plot_qscore_heatmap | PASS |  |
| illumina-interop_plot_qscore_histogram | PASS |  |
| illumina-interop_plot_sample_qc | Not completed | no usable test data: the available run folders have no index metrics, so the output is empty. |
| illumina-interop_summary | PASS |  |

## illumina-interop_dumptext

### Tool Description
Dump InterOp metric data as text

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
# Version: v3.0.35-src
Usage: interop_dumptext run_folder [--option1=value1] [--option2=value2]
	--subset[0]: Number of metrics to subsample
	--metric[]: Name of metric to load, e.g. --metric=Tile to load TileMetricsOut.bin
```

## illumina-interop_summary

### Tool Description
Summary of the run metrics (cluster density, quality, error rate) per read and lane

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: interop_summary run_folder [--option1=value1] [--option2=value2]
	--level[5]: Level of summary information: 0: total, 1: non-index, 2: Read, 3: Lane, 4: Surface
	--csv[0]: Format output as CSV only
```

## illumina-interop_index-summary

### Tool Description
Summary of the index (demultiplexing) metrics per lane

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: interop_index-summary run_folder [--option1=value1] [--option2=value2]
	--csv[0]: Format output as CSV only
```

## illumina-interop_aggregate

### Tool Description
Aggregate the tile metrics of a run into summary rows

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
# Version: v3.0.35-src
Usage: interop_aggregate run_folder [--option1=value1] [--option2=value2]
	--max-tile[0]: Maximum tile number to include
```

## illumina-interop_dumpbin

### Tool Description
Dump the raw binary InterOp files as numbers

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: interop_dumpbin run_folder [--option1=value1] [--option2=value2]
	--subset[0]: Display only a subset of records from each file
	--latest_version[0]: Display file as latest version of the format
```

## illumina-interop_imaging_table

### Tool Description
Table of per-tile, per-cycle imaging metrics for one or more run folders

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
Expected: $ imaging_table <run-folder1> <run-folder2> ... <run-folderN>
```

## illumina-interop_plot_by_cycle

### Tool Description
Plot a metric by cycle (gnuplot data on standard output)

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
# Version: v3.0.35-src
Usage: interop_plot_by_cycle run_folder [--option1=value1] [--option2=value2]
	--metric-name[Intensity]: Metric to plot
	--filter-by-lane[]: Only the data for the selected lane will be displayed
	--filter-by-channel[]: Only the data for the selected channel will be displayed
	--filter-by-base[]: Only the data for the selected base will be displayed
	--filter-by-surface[]: Only the data for the selected surface will be displayed
	--filter-by-read[]: Only the data for the selected read will be displayed
	--filter-by-cycle[]: Only the data for the selected cycle will be displayed
	--filter-by-tile-number[]: Only the data for the selected tile number will be displayed
	--filter-by-swath[]: Only the data for the selected swath will be displayed
	--filter-by-section[]: Only the data for the selected section will be displayed
```

## illumina-interop_plot_by_lane

### Tool Description
Plot a metric by lane (gnuplot data on standard output)

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
# Version: v3.0.35-src
Usage: interop_plot_by_lane run_folder [--option1=value1] [--option2=value2]
	--metric-name[ClusterCount]: Metric to plot
	--filter-by-lane[]: Only the data for the selected lane will be displayed
	--filter-by-channel[]: Only the data for the selected channel will be displayed
	--filter-by-base[]: Only the data for the selected base will be displayed
	--filter-by-surface[]: Only the data for the selected surface will be displayed
	--filter-by-read[]: Only the data for the selected read will be displayed
	--filter-by-cycle[]: Only the data for the selected cycle will be displayed
	--filter-by-tile-number[]: Only the data for the selected tile number will be displayed
	--filter-by-swath[]: Only the data for the selected swath will be displayed
	--filter-by-section[]: Only the data for the selected section will be displayed
```

## illumina-interop_plot_flowcell

### Tool Description
Plot a metric on the flowcell map (gnuplot data on standard output)

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
# Version: v3.0.35-src
Usage: interop_plot_flowcell run_folder [--option1=value1] [--option2=value2]
	--metric-name[Intensity]: Metric to plot
	--filter-by-lane[]: Only the data for the selected lane will be displayed
	--filter-by-channel[]: Only the data for the selected channel will be displayed
	--filter-by-base[]: Only the data for the selected base will be displayed
	--filter-by-surface[]: Only the data for the selected surface will be displayed
	--filter-by-read[]: Only the data for the selected read will be displayed
	--filter-by-cycle[]: Only the data for the selected cycle will be displayed
	--filter-by-tile-number[]: Only the data for the selected tile number will be displayed
	--filter-by-swath[]: Only the data for the selected swath will be displayed
	--filter-by-section[]: Only the data for the selected section will be displayed
```

## illumina-interop_plot_qscore_heatmap

### Tool Description
Plot the Q-score heat map (gnuplot data on standard output)

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
# Version: v3.0.35-src
Usage: interop_plot_qscore_heatmap run_folder [--option1=value1] [--option2=value2]
	--filter-by-lane[]: Only the data for the selected lane will be displayed
	--filter-by-channel[]: Only the data for the selected channel will be displayed
	--filter-by-base[]: Only the data for the selected base will be displayed
	--filter-by-surface[]: Only the data for the selected surface will be displayed
	--filter-by-read[]: Only the data for the selected read will be displayed
	--filter-by-cycle[]: Only the data for the selected cycle will be displayed
	--filter-by-tile-number[]: Only the data for the selected tile number will be displayed
	--filter-by-swath[]: Only the data for the selected swath will be displayed
	--filter-by-section[]: Only the data for the selected section will be displayed
```

## illumina-interop_plot_qscore_histogram

### Tool Description
Plot the Q-score histogram (gnuplot data on standard output)

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
# Version: v3.0.35-src
Usage: interop_plot_qscore_histogram run_folder [--option1=value1] [--option2=value2]
	--filter-by-lane[]: Only the data for the selected lane will be displayed
	--filter-by-channel[]: Only the data for the selected channel will be displayed
	--filter-by-base[]: Only the data for the selected base will be displayed
	--filter-by-surface[]: Only the data for the selected surface will be displayed
	--filter-by-read[]: Only the data for the selected read will be displayed
	--filter-by-cycle[]: Only the data for the selected cycle will be displayed
	--filter-by-tile-number[]: Only the data for the selected tile number will be displayed
	--filter-by-swath[]: Only the data for the selected swath will be displayed
	--filter-by-section[]: Only the data for the selected section will be displayed
```

## illumina-interop_plot_sample_qc

### Tool Description
Plot the sample QC (index) metrics (gnuplot data on standard output)

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-interop:1.9.0--h503566f_0
- **Homepage**: http://illumina.github.io/interop/index.html
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-interop/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: interop_plot_sample_qc run_folder
```

## Metadata
- **Skill**: generated
