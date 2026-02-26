# flanker CWL Generation Report

## flanker

### Tool Description
Flanker (version 0.1.5). If you use Flanker in your work, please cite us: Matlock W, Lipworth S, Constantinides B, Peto TEA, Walker AS, Crook D, Hopkins S, Shaw LP, Stoesser N.Flanker: a tool for comparative genomics of gene flanking regions.BioRxiv. 2021. doi: https://doi.org/10.1101/2021.02.22.432255

### Metadata
- **Docker Image**: quay.io/biocontainers/flanker:0.1.5--py_0
- **Homepage**: https://github.com/wtmatlock/flanker
- **Package**: https://anaconda.org/channels/bioconda/packages/flanker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flanker/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wtmatlock/flanker
- **Stars**: N/A
### Original Help Text
```text
usage: flanker [-h] -i FASTA_FILE (-g GENE [GENE ...] | -log LIST_OF_GENES)
               [-cm] [-f FLANK] [-m MODE] [-circ] [-inc] [-db DATABASE]
               [-v [VERBOSE]] [-w WINDOW] [-wstop WINDOW_STOP]
               [-wstep WINDOW_STEP] [-cl] [-o OUTFILE] [-tr THRESHOLD]
               [-p THREADS] [-k KMER_LENGTH] [-s SKETCH_SIZE]

Flanker (version 0.1.5). If you use Flanker in your work, please cite us:
Matlock W, Lipworth S, Constantinides B, Peto TEA, Walker AS, Crook D, Hopkins
S, Shaw LP, Stoesser N.Flanker: a tool for comparative genomics of gene
flanking regions.BioRxiv. 2021. doi: https://doi.org/10.1101/2021.02.22.432255

optional arguments:
  -h, --help            show this help message and exit
  -g GENE [GENE ...], --gene GENE [GENE ...]
                        Gene(s) of interest (escape any special characters).
                        Use space seperation for multipe genes (default: None)
  -log LIST_OF_GENES, --list_of_genes LIST_OF_GENES
                        Line separated file containing genes of interest
                        (default: False)
  -cm, --closest_match  Find closest match to query (default: False)
  -f FLANK, --flank FLANK
                        Choose which side(s) of the gene to extract
                        (upstream/downstream/both) (default: both)
  -m MODE, --mode MODE  One of "default" - normal mode, "mm" - multi-allelic
                        cluster, or "sm" - salami-mode (default: default)
  -circ, --circ         Is sequence circularised (default: False)
  -inc, --include_gene  Include the gene of interest (default: False)
  -db DATABASE, --database DATABASE
                        Choose Abricate database e.g. NCBI, resfinder
                        (default: ncbi)
  -v [VERBOSE], --verbose [VERBOSE]
                        Increase verbosity: 0 = only warnings, 1 = info, 2 =
                        debug. No number means info. Default is no verbosity.
                        (default: 0)

required arguments:
  -i FASTA_FILE, --fasta_file FASTA_FILE
                        Input fasta file (default: None)

window options:
  -w WINDOW, --window WINDOW
                        Length of flanking sequence/first window length
                        (default: 1000)
  -wstop WINDOW_STOP, --window_stop WINDOW_STOP
                        Final window length (default: None)
  -wstep WINDOW_STEP, --window_step WINDOW_STEP
                        Step in window sequence (default: None)

clustering options:
  -cl, --cluster        Turn on clustering mode? (default: False)
  -o OUTFILE, --outfile OUTFILE
                        Prefix for the clustering file (default: out)
  -tr THRESHOLD, --threshold THRESHOLD
                        mash distance threshold for clustering (default:
                        0.001)
  -p THREADS, --threads THREADS
                        threads for mash to use (default: 1)
  -k KMER_LENGTH, --kmer_length KMER_LENGTH
                        kmer length for Mash (default: 21)
  -s SKETCH_SIZE, --sketch_size SKETCH_SIZE
                        sketch size for mash (default: 1000)
```


## Metadata
- **Skill**: generated
