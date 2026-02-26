# sccaf CWL Generation Report

## sccaf

### Tool Description
sccaf

### Metadata
- **Docker Image**: quay.io/biocontainers/sccaf:0.0.10--py_0
- **Homepage**: https://github.com/SCCAF/sccaf
- **Package**: https://anaconda.org/channels/bioconda/packages/sccaf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sccaf/overview
- **Total Downloads**: 26.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SCCAF/sccaf
- **Stars**: N/A
### Original Help Text
```text
usage: sccaf [-h] [-i INPUT_FILE] [-o OUTPUT_FILE]
             [-e EXTERNAL_CLUSTERING_TSV] [--optimise] [--skip-assessment]
             [-s SLOT_FOR_EXISTING_CLUSTERING] [-r RESOLUTION]
             [-a MIN_ACCURACY] [-p PREFIX] [-c CORES]
             [-u UNDERCLUSTER_BOUNDARY] [--produce-rounds-summary]
             [--optimisation-plots-output OPTIMISATION_PLOTS_OUTPUT]
             [--conf-sampling-iterations CONF_SAMPLING_ITERATIONS]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input-file INPUT_FILE
                        Path to input in AnnData or Loom
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        Path for output file
  -e EXTERNAL_CLUSTERING_TSV, --external-clustering-tsv EXTERNAL_CLUSTERING_TSV
                        Path to external clustering in TSV
  --optimise            Not only run assessment, but also optimise the
                        clustering
  --skip-assessment     If --optimise given, then this allows to optionally
                        skip the original assessment of the clustering
  -s SLOT_FOR_EXISTING_CLUSTERING, --slot-for-existing-clustering SLOT_FOR_EXISTING_CLUSTERING
                        Use clustering pre-computed in the input object,
                        available in this slot of the object.
  -r RESOLUTION, --resolution RESOLUTION
                        Resolution for running clustering when no internal or
                        external clustering is given.
  -a MIN_ACCURACY, --min-accuracy MIN_ACCURACY
                        Accuracy threshold for convergence of the optimisation
                        procedure.
  -p PREFIX, --prefix PREFIX
                        Prefix for clustering labels
  -c CORES, --cores CORES
                        Number of processors to use
  -u UNDERCLUSTER_BOUNDARY, --undercluster-boundary UNDERCLUSTER_BOUNDARY
                        Label for the underclustering boundary to use in the
                        optimisation. It should be present in the annData
                        object
  --produce-rounds-summary
                        Set to produce summary files for each round of
                        optimisation
  --optimisation-plots-output OPTIMISATION_PLOTS_OUTPUT
                        PDF file output path for all optimisation plots.
  --conf-sampling-iterations CONF_SAMPLING_ITERATIONS
                        How many samples are taken of cells per clusters prior
                        to the confusion matrix calculation.Higher numbers
                        will produce more stable results in terms of rounds,
                        but will take longer. Default: 3.
```

