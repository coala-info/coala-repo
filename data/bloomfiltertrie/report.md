# bloomfiltertrie CWL Generation Report

## Metadata
- **Skill**: generated

## bloomfiltertrie_bft

### Tool Description
Bloom Filter Trie (BFT) tool for building, loading, and querying k-mer indexes from genome files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bloomfiltertrie:0.8.7--h779adbc_2
- **Homepage**: https://github.com/GuillaumeHolley/BloomFilterTrie
- **Package**: https://anaconda.org/channels/bioconda/packages/bloomfiltertrie/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage:
bft build k {kmers|kmers_comp} list_genome_files output_file [Options]
bft load file_bft [-add_genomes {kmers|kmers_comp} list_genome_files output_file] [Options]

Options:
[-query_sequences threshold {canonical|non_canonical} list_sequence_files]
[-query_kmers {kmers|kmers_comp} list_kmer_files]
[-query_branching {kmers|kmers_comp} list_kmer_files]
[-extract_kmers {kmers|kmers_comp} compressed_kmers_file]
```

