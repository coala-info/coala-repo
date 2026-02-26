# acdc CWL Generation Report

## acdc

### Tool Description
Automated contamination detection and confidence estimation for single-cell genome data

### Metadata
- **Docker Image**: quay.io/biocontainers/acdc:1.02--h4ac6f70_0
- **Homepage**: https://github.com/mlux86/acdc
- **Package**: https://anaconda.org/channels/bioconda/packages/acdc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/acdc/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mlux86/acdc
- **Stars**: N/A
### Original Help Text
```text
,/
      ,'/
    ,' /        █████╗  ██████╗██████╗  ██████╗  (a)utomated
  ,'  /_____,  ██╔══██╗██╔════╝██╔══██╗██╔════╝  (c)ontamination
.'____    ,'   ███████║██║     ██║  ██║██║       (d)etection and
     /  ,'     ██╔══██║██║     ██║  ██║██║       (c)onfidence estimation for single-cell genome data
    / ,'       ██║  ██║╚██████╗██████╔╝╚██████╗
   /,'         ╚═╝  ╚═╝ ╚═════╝╚═════╝  ╚═════╝
  /'

Usage:
  -h [ --help ]                             Display this help message
  -V [ --version ]                          Display the software version
  -v [ --verbose ]                          Verbose output (use -vv for more or -vvv for maximum verbosity)
  -q [ --quiet ]                            No output
  -R [ --random-seed ] arg                  Random seed number for reproducible results
  -i [ --input-fasta ] arg                  Input FASTA file
  -I [ --input-list ] arg                   File with a list of input FASTA files, one per line
  -d [ --tsne-dimension ] arg (=2)          T-SNE dimension
  -u [ --tsne-pca-dimension ] arg (=50)     T-SNE initial PCA dimension
  -p [ --tsne-perplexity ] arg              T-SNE perplexity (overrides automatic estimation)
  -t [ --tsne-theta ] arg (=0.5)            T-SNE parameter 'theta' of the underlying Barnes-Hut approximation
  -m [ --min-contig-length ] arg (=0)       Minimal length of contigs to consider for analysis
  -k [ --window-kmer-length ] arg (=4)      Length of the k-mers in the sequence vectorizer window
  -w [ --window-width ] arg                 Width of the sliding sequence vectorizer window (overrides automatic estimation using number of target points)
  -s [ --window-step ] arg                  Step of the sliding sequence vectorizer window (overrides automatic estimation using number of target points)
  -n [ --target-num-points ] arg (=1000)    Approximate number of target points for estimating window parameters
  -b [ --num-bootstraps ] arg (=10)         Number of bootstraps
  -r [ --bootstrap-ratio ] arg (=0.75)      Bootstrap subsampling ratio
  -T [ --num-threads ] arg (=20)            Number of threads for bootstrap analysis  (default: detect number of cores)
  -o [ --output-dir ] arg (=./results)      Result output directory
  -K [ --kraken-db ] arg                    Database to use for Kraken classification
  -a [ --aggressive-threshold ] arg (=5000) Aggressive threshold: Treat clusters having a bp size below this threshold as outliers. (Default = 0 = aggressive mode disabled)
  -x [ --taxonomy-file ] arg                File with external taxonomy information
  -X [ --target-taxonomy ] arg              Target taxonomy identifier, supports regular expressions
```

