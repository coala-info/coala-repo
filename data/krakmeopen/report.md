# krakmeopen CWL Generation Report

## krakmeopen

### Tool Description
A Kraken2 downstream analysis toolkit. More specifically, calculate a series
of quality metrics for Kraken2 classifications.

### Metadata
- **Docker Image**: quay.io/biocontainers/krakmeopen:0.1.5--pyh3252c3a_0
- **Homepage**: https://github.com/danisven/KrakMeOpen
- **Package**: https://anaconda.org/channels/bioconda/packages/krakmeopen/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/krakmeopen/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/danisven/KrakMeOpen
- **Stars**: N/A
### Original Help Text
```text
usage: krakmeopen [--input FILE | --input_pickle FILE | --input_file_list FILE] [--output FILE | --output_pickle FILE] --names FILE --nodes FILE [--tax_id INT | --tax_id_file FILE] --kmer_tally_table FILE

A Kraken2 downstream analysis toolkit. More specifically, calculate a series
of quality metrics for Kraken2 classifications.

optional arguments:
  -h, --help            show this help message and exit
  --input FILE          Kraken2 read-by-read classifications file.
  --input_pickle FILE   A pickle file containing kmer tallies, produced with
                        --output_pickle
  --input_file_list FILE
                        A file containing file paths to multiple pickles, one
                        per line. Will calculate metrics on the sum of kmer
                        counts from all pickles.
  --output FILE         The file to write the quality metrics output to.
  --output_pickle FILE  The pickle file to write kmer tallies to. Use this
                        argument to supress calculation of quality metrics and
                        only output kmer counts to a pickled file. Input the
                        pickled file using --input_pickle.
  --kmer_tally_table FILE
                        File to output the complete kmer tally table for each
                        tax ID to. Optional.
  --names FILE          NCBI style taxonomy names dump file (names.dmp).
                        Required.
  --nodes FILE          NCBI style taxonomy nodes dump file (nodes.dmp).
                        Required.
  --tax_id INT          A taxonomic ID for a clade that you wish to calculate
                        quality metrics for.
  --tax_id_file FILE    Supply multiple taxonomic IDs at once. A textfile with
                        one taxonomic ID per line. Calculate quality metrics
                        for the clades rooted at the taxonomic IDs in the
                        file.

The metrics are calculated on the clade-level. All kmers from all reads that
are classified to any of the nodes in the clades rooted at the supplied tax
IDs are aggregated, and metrics are calculated on those aggregations. Input is
Kraken2 read-by-read classification files (can be gzipped). Output is a tab
separated file containing the metrics.
```

