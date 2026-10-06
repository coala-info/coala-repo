# bloomfiltertrie CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bloomfiltertrie_build | PASS |  |
| bloomfiltertrie_load | Failed | tool bug: -add_genomes writes the loaded BFT unchanged because bft 0.8 never counts the files in the list (nb_files_2_read stays 0); loading, -query_kmers, -query_sequences and -extract_kmers give correct results. |

## Metadata
- **Skill**: generated

## bloomfiltertrie_build

### Tool Description
Build a Bloom Filter Trie (BFT) from k-mer files and write it to a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/bloomfiltertrie:0.8.7--h779adbc_2
- **Homepage**: https://github.com/GuillaumeHolley/BloomFilterTrie
- **Package**: https://anaconda.org/channels/bioconda/packages/bloomfiltertrie/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
bft build k {kmers|kmers_comp} list_genome_files output_file [Options]
bft load file_bft [-add_genomes {kmers|kmers_comp} list_genome_files output_file] [Options]

Options:
[-query_sequences threshold {canonical|non_canonical} list_sequence_files]
[-query_kmers {kmers|kmers_comp} list_kmer_files]
[-query_branching {kmers|kmers_comp} list_kmer_files]
[-extract_kmers {kmers|kmers_comp} compressed_kmers_file]
```

## bloomfiltertrie_load

### Tool Description
Load a Bloom Filter Trie (BFT) from a file, optionally add genomes, and query it.

### Metadata
- **Docker Image**: quay.io/biocontainers/bloomfiltertrie:0.8.7--h779adbc_2
- **Homepage**: https://github.com/GuillaumeHolley/BloomFilterTrie
- **Package**: https://anaconda.org/channels/bioconda/packages/bloomfiltertrie/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
bft build k {kmers|kmers_comp} list_genome_files output_file [Options]
bft load file_bft [-add_genomes {kmers|kmers_comp} list_genome_files output_file] [Options]

Options:
[-query_sequences threshold {canonical|non_canonical} list_sequence_files]
[-query_kmers {kmers|kmers_comp} list_kmer_files]
[-query_branching {kmers|kmers_comp} list_kmer_files]
[-extract_kmers {kmers|kmers_comp} compressed_kmers_file]
```

