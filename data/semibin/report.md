# semibin CWL Generation Report

## semibin_SemiBin2

### Tool Description
Neural network-based binning of metagenomic contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/semibin:2.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/SemiBin
- **Package**: https://anaconda.org/channels/bioconda/packages/semibin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/semibin/overview
- **Total Downloads**: 44.2K
- **Last updated**: 2025-12-07
- **GitHub**: https://github.com/BigDataBiology/SemiBin
- **Stars**: N/A
### Original Help Text
```text
usage: SemiBin2 [-h] [-v] [--verbose | --quiet]  ...

Neural network-based binning of metagenomic contigs

options:
  -h, --help            show this help message and exit
  -v, -V, --version     Print the version number
  --verbose             Verbose output (default: False)
  --quiet, -q           Quiet output (default: False)

SemiBin subcommands:
  
    single_easy_bin     Bin contigs (single or co-assembly) using one command.
    multi_easy_bin      Bin contigs (multi-sample mode) using one command.
    generate_sequence_features_single
                        Generate sequence features (kmer and abundance) as
                        training data for (semi/self)-supervised deep learning
                        model training (single or co-assembly mode). This will
                        produce the data.csv and data_split.csv files.
    generate_sequence_features_multi (generate_sequence_features_multi)
                        Generate sequence features (kmer and abundance) as
                        training data for (semi/self)-supervised deep learning
                        model training (multi-sample mode). This will produce
                        the data.csv and data_split.csv files.
    check_install       Check whether required dependencies are present.
    concatenate_fasta   concatenate fasta files for multi-sample binning
    split_contigs       Split contigs to generate data (only for strobealign-
                        aemb pipeline)
    train_self          Train the model with self-supervised learning
    bin (bin_short)     Group the contigs into bins.
    bin_long            Group the contigs from long reads into bins.
    train_semi          [deprecated] Train the model.
    generate_cannot_links (predict_taxonomy)
                        [deprecated] Run the contig annotation using mmseqs
                        with GTDB reference genome and generate cannot-link
                        file used in the semi-supervised deep learning model
                        training. This will download the GTDB database if not
                        downloaded before.
    download_GTDB       [deprecated] Download GTDB reference genomes.
    citation            Print citation information

For more information, see
https://semibin.readthedocs.io/en/latest/subcommands/
```

