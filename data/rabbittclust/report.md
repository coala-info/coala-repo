# rabbittclust CWL Generation Report

## rabbittclust_clust-mst

### Tool Description
minimum-spanning-tree-based module for RabbitTClust

### Metadata
- **Docker Image**: quay.io/biocontainers/rabbittclust:2.3.0--h43eeafb_0
- **Homepage**: https://github.com/RabbitBio/RabbitTClust
- **Package**: https://anaconda.org/channels/bioconda/packages/rabbittclust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rabbittclust/overview
- **Total Downloads**: 940
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RabbitBio/RabbitTClust
- **Stars**: N/A
### Original Help Text
```text
clust-mst v.2.2.1, minimum-spanning-tree-based module for RabbitTClust
Usage: clust-mst [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  -t,--threads INT            set the thread number, default all CPUs of the platform
  -m,--min-length UINT        set the filter minimum length (minLen), genome length less than minLen will be ignore, default 10,000
  -c,--containment INT        use AAF distance with containment coefficient, set the containCompress, the sketch size is in proportion with 1/containCompress
  -k,--kmer-size INT          set the kmer size
  -s,--sketch-size INT        set the sketch size for Jaccard Index and Mash distance, default 1000
  -l,--list                   input is genome list, one genome per line
  -e,--no-save                not save the intermediate files, such as sketches or MST
  -d,--threshold FLOAT        set the distance threshold for clustering
  -F,--function TEXT          set the sketch function, such as MinHash, KSSD, default MinHash
  -o,--output TEXT REQUIRED   set the output name of cluster result
  -i,--input TEXT Excludes: --append
                              set the input file, single FASTA genome file (without -l option) or genome list file (with -l option)
  --presketched TEXT          clustering by the pre-generated sketch files rather than genomes
  --premsted TEXT             clustering by the pre-generated mst files rather than genomes for clust-mst
  --newick-tree               output the newick tree format file for clust-mst
  --fast                      use the kssd algorithm for sketching and distance computing for clust-mst
  --drlevel INT               set the dimention reduction level for Kssd sketches, default 3 with a dimention reduction of 1/4096
  --no-dense                  not calculate the density and ANI datas
  --append TEXT Excludes: --input
                              append genome file or file list with the pre-generated sketch or MST files
```


## rabbittclust_clust-greedy

### Tool Description
greedy incremental clustering module for RabbitTClust

### Metadata
- **Docker Image**: quay.io/biocontainers/rabbittclust:2.3.0--h43eeafb_0
- **Homepage**: https://github.com/RabbitBio/RabbitTClust
- **Package**: https://anaconda.org/channels/bioconda/packages/rabbittclust/overview
- **Validation**: PASS

### Original Help Text
```text
clust-greedy v.2.2.1, greedy incremental clustering module for RabbitTClust
Usage: clust-greedy [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  -t,--threads INT            set the thread number, default all CPUs of the platform
  -m,--min-length UINT        set the filter minimum length (minLen), genome length less than minLen will be ignore, default 10,000
  -c,--containment INT        use AAF distance with containment coefficient, set the containCompress, the sketch size is in proportion with 1/containCompress
  -k,--kmer-size INT          set the kmer size
  -s,--sketch-size INT        set the sketch size for Jaccard Index and Mash distance, default 1000
  -l,--list                   input is genome list, one genome per line
  -e,--no-save                not save the intermediate files, such as sketches or MST
  -d,--threshold FLOAT        set the distance threshold for clustering
  -F,--function TEXT          set the sketch function, such as MinHash, KSSD, default MinHash
  -o,--output TEXT REQUIRED   set the output name of cluster result
  -i,--input TEXT Excludes: --append
                              set the input file, single FASTA genome file (without -l option) or genome list file (with -l option)
  --presketched TEXT          clustering by the pre-generated sketch files rather than genomes
  --append TEXT Excludes: --input
                              append genome file or file list with the pre-generated sketch or MST files
```


## Metadata
- **Skill**: generated
