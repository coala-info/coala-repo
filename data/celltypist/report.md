# celltypist CWL Generation Report

## celltypist

### Tool Description
Celltypist: a tool for semi-automatic cell type annotation

### Metadata
- **Docker Image**: quay.io/biocontainers/celltypist:1.7.1--pyhdfd78af_0
- **Homepage**: https://github.com/Teichlab/celltypist
- **Package**: https://anaconda.org/channels/bioconda/packages/celltypist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/celltypist/overview
- **Total Downloads**: 77.0K
- **Last updated**: 2025-06-25
- **GitHub**: https://github.com/Teichlab/celltypist
- **Stars**: N/A
### Original Help Text
```text
Usage: celltypist [OPTIONS]

  Celltypist: a tool for semi-automatic cell type annotation

Options:
  -i, --indata FILE               Path to the input count matrix
                                  (.csv/txt/tsv/tab/mtx) or AnnData (.h5ad).
                                  Genes should be provided as gene symbols.
  -m, --model TEXT                Model used for predictions. If not provided,
                                  default to using the `Immune_All_Low.pkl`
                                  model.
  --transpose-input               Transpose the input matrix if `-i /
                                  --indata` file is provided in the gene-by-
                                  cell format. Note Celltypist requires the
                                  cell-by-gene format.
  -gf, --gene-file PATH           Path to the file which stores each gene per
                                  line corresponding to the genes used in the
                                  provided mtx file. Ignored if `-i /
                                  --indata` is not provided in the mtx format.
  -cf, --cell-file PATH           Path to the file which stores each cell per
                                  line corresponding to the cells used in the
                                  provided mtx file. Ignored if `-i /
                                  --indata` is not provided in the mtx format.
  -mo, --mode [best_match|prob_match]
                                  Choose the cell type with the largest
                                  score/probability as the final prediction
                                  (`best_match`), or enable a multi-label
                                  classification (`prob_match`), which assigns
                                  0 (i.e., unassigned), 1, or >=2 cell type
                                  labels to each query cell.  [default:
                                  best_match]
  -ps, --p-thres FLOAT            Probability threshold for the multi-label
                                  classification. Ignored if `--mode` is
                                  `best_match`.  [default: 0.5]
  --majority-voting               Refine the predicted labels by running the
                                  majority voting classifier after over-
                                  clustering.
  -oc, --over-clustering TEXT     Input file with the over-clustering result
                                  of one cell per line, or a string key
                                  specifying an existing metadata column in
                                  the AnnData object. If not provided, default
                                  to using a heuristic over-clustering
                                  approach according to the size of input
                                  data. Ignored if `--majority-voting` is not
                                  set.  [default: auto]
  --use-GPU                       Whether to use GPU for over clustering on
                                  the basis of `rapids-singlecell`. Ignored if
                                  `--majority-voting` is not set.
  -mp, --min-prop FLOAT           For the dominant cell type within a
                                  subcluster, the minimum proportion of cells
                                  required to support naming of the subcluster
                                  by this cell type. Ignored if `--majority-
                                  voting` is not set.  [default: 0]
  -o, --outdir PATH               Directory to store the output files and (if
                                  `--plot-results` is set) figures. Default to
                                  the current working directory.
  -p, --prefix TEXT               Prefix for the output files and (if `--plot-
                                  results` is set) figures. Default to no
                                  prefix used.
  --xlsx                          Merge output tables into a single Excel
                                  (.xlsx).
  --plot-results                  Plot the prediction results as multiple
                                  figures as well.
  --update-models                 Download the latest models from the remote
                                  server.
  --show-models                   Show all the available models and their
                                  descriptions.
  --quiet                         Hide the banner and configuration
                                  information during the run.
  --help                          Show this message and exit.
```

