# mgcod CWL Generation Report

## mgcod_multiprocess_mgcod.py

### Tool Description
Runs Mgcod on many contigs in parallel.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgcod:1.0.2--hdfd78af_0
- **Homepage**: https://github.com/gatech-genemark/Mgcod
- **Package**: https://anaconda.org/channels/bioconda/packages/mgcod/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mgcod/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gatech-genemark/Mgcod
- **Stars**: N/A
### Original Help Text
```text
usage: multiprocess_mgcod.py [-h] --genomes GENOMES [-p PATH_TO_PREDICTIONS]
                             [-o PATH_TO_OUTPUT] [-m PATH_TO_PLOTS] [-r]
                             [--isoforms] [-n CONSECUTIVE_WINDOWS]
                             [-g CONSECUTIVE_GENE_LABELS] [-w WINDOW_SIZE]
                             [-st STRIDE] [-t TOLERANCE] [-d] [-AA] [-NT]
                             [--short_contigs] [--logfile LOGFILE]
                             [--threads THREADS] [--batch_size BATCH_SIZE]
                             [--version]

Runs Mgcod on many contigs in parallel.

required arguments:
  --genomes GENOMES     path to txt file with genomes

optional arguments:
  -h, --help            show this help message and exit
  -p PATH_TO_PREDICTIONS, --path_to_mgm_predictions PATH_TO_PREDICTIONS
                        Directory where to save MGM predictions so that they
                        can be re-used. If path does not exist, it will be
                        created. [./mgm_results/]
  -o PATH_TO_OUTPUT, --path_to_output PATH_TO_OUTPUT
                        Directory where to save final gene annotations and
                        supporting outputs. If path does not exist, it will be
                        created. If -AA or -NT flag is set, sequences will be
                        saved here, too. [./results/]
  -m PATH_TO_PLOTS, --path_to_plots PATH_TO_PLOTS
                        Directory where to save plots. Plots logodd ratio per
                        window for different MGM models. Only available with
                        isoform prediction. If path does not exist, it will be
                        created
  -r, --circular        Set if sequence is circular. Only relevant for isoform
                        prediction
  --isoforms            Enable prediction of isoforms
  -n CONSECUTIVE_WINDOWS, --consecutive_windows CONSECUTIVE_WINDOWS
                        Number of consecutive windows to be required with same
                        genetic code to keep. Only relevant for isoform
                        prediction. Minimum is 2. [3]
  -g CONSECUTIVE_GENE_LABELS, --consecutive_gene_labels CONSECUTIVE_GENE_LABELS
                        Number of consecutive gene labels to be required with
                        same genetic code to keep. Only relevant for isoform
                        prediction. Minimum is 2. [5]
  -w WINDOW_SIZE, --window_size WINDOW_SIZE
                        Window size in bp applied to search for isoform. Only
                        relevant for isoform prediction. [5000]
  -st STRIDE, --stride STRIDE
                        Step size in bp, with which window will be moved along
                        sequence. Only relevant for isoform prediction. [If
                        sequence <= 100 kb 2500 bp else 5000 bp]
  -t TOLERANCE, --tolerance TOLERANCE
                        The maximally tolerated difference in prediction of
                        gene start or gene stop to consider the prediction of
                        two models isoforms. Only relevent for isoform
                        prediction. [30]
  -d, --delete          Delete intermediary files (prediction of the different
                        MGM models).
  -AA, --amino_acids    Extract amino acid sequences of predicted proteins.
  -NT, --nucleotides    Extract nucleotide sequences of predicted proteins.
  --short_contigs       Predict genetic codes of contigs < 5000bp. Prediction
                        may not be reliable
  --logfile LOGFILE     Path to log file
  --threads THREADS     Number of processes. [8]
  --batch_size BATCH_SIZE
                        Batch size for multiprocessing. [256]
  --version             show program's version number and exit
```

