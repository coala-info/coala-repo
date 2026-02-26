# mapseq CWL Generation Report

## mapseq

### Tool Description
Classify a fasta file containing sequence reads to the default NCBI taxonomy and OTU classifications.

### Metadata
- **Docker Image**: quay.io/biocontainers/mapseq:2.1.1--ha34dc8c_0
- **Homepage**: https://github.com/jfmrod/MAPseq
- **Package**: https://anaconda.org/channels/bioconda/packages/mapseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mapseq/overview
- **Total Downloads**: 9.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jfmrod/MAPseq
- **Stars**: N/A
### Original Help Text
```text
# mapseq v1.2.6 (Jan 20 2023)
MAPseq v1.2.6
by Joao F. Matias Rodrigues, Thomas S. B. Schmidt, Janko Tackmann, and Christian von Mering
Institute of Molecular Life Sciences, University of Zurich, Switzerland
Matias Rodrigues JF, Schmidt TSB, Tackmann J, and von Mering C (2017) MAPseq: highly efficient k-mer search with confidence estimates, for rRNA sequence analysis. Bioinformatics. http://doi.org/10.1093/bioinformatics/btx517

Usage:
    mapseq input.fa [<db> <tax1> <tax2> ...]

Classify a fasta file containing sequence reads to the default NCBI taxonomy and OTU classifications.
Example: mapseq -nthreads 4 rawreads.fa

Optional arguments:
           -nthreads   <int>  number of threads to use [default: 4]

Performance/sensitivity:
            -tophits   <int>  number of reference sequences to include in alignment phase [default: 20]
            -topotus   <int>  number of internal reference otus to include in alignment phase [default: 10]

Search parameters:
           -minscore   <int>  minimum score cutoff to consider for a classification, should be reduced when searching very small sequences, i.e.: primer search [default: 30]
             -minid1   <int>  minimum number of shared kmers to consider hit in second phase kmer search [default: 1]
             -minid2   <int>  minimum number of shared kmers to consider hit in alignment phase [default: 1]
             -otulim   <int>  number of sequences per internal cluster to include in alignment phase [default: 50]

Extra information:
         -print_hits          outputs list of top hits for each input sequence
        -print_align          outputs alignments

Generating count summaries from mapseq output:
          -otucounts   <sample1.mseq>
                              computes summary of classification counts from the classification output file
           -otutable   <sample1.mseq> [sample2.mseq [...]]
                              generates a tsv file with taxonomic labels as rows and samples as columns from classification output files

Report bugs to: joao.rodrigues@imls.uzh.ch
http://meringlab.org/software/mapseq/
http://github.org/jfmrod/MAPseq/
```

