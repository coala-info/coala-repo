# symbiontscreener CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| symbiontscreener_build_k21 | Failed | image problem: meryl in the image is the old version (-B/-S/-M syntax), but the script calls meryl count, so it stops with Unknown option. |
| symbiontscreener_build_s40 | Failed | image problem: the script tests that a file named jellyfish exists in the working directory, so it stops although jellyfish is on PATH. |
| symbiontscreener_cluster_k21 | Not completed | needs the step01.k21 output of build_k21, which fails in this image (old meryl). |
| symbiontscreener_cluster_s40 | Not completed | needs the step01.s40 output of build_s40, which fails in this image (jellyfish path check). |
| symbiontscreener_consensus_cluster_k21 | Not completed | needs the step01.k21 output of build_k21, which fails in this image (old meryl). |
| symbiontscreener_consensus_cluster_s40 | Not completed | needs the step01.s40 output of build_s40, which fails in this image (jellyfish path check). |
| symbiontscreener_density_k21 | Not completed | needs the step01.k21 output of build_k21, which fails in this image (old meryl). |
| symbiontscreener_density_s40 | Not completed | needs the step01.s40 output of build_s40, which fails in this image (jellyfish path check). |
| symbiontscreener_trio_result_k21 | Not completed | needs the step01.k21 output of build_k21, which fails in this image (old meryl). |
| symbiontscreener_trio_result_s40 | Not completed | needs the step01.s40 output of build_s40, which fails in this image (jellyfish path check). |

## symbiontscreener_build_k21

### Tool Description
Build paternal-only, maternal-only and shared k-mer lists from paternal and maternal NGS reads with meryl.

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

### Original Help Text
```text
Usage    :
    ./sysc build_k21  [OPTION]

Options  :
        --thread            thread num.
                            [ optional, default 8 threads. ]

        --memory            x (GB) of memory to used by meryl.
                            [ optional, default 50GB. ]

        --mer               mer-size
                            [ optional, default 21. ]

        --paternal          paternal NGS reads file in FASTQ format.

        --maternal          maternal NGS reads file in FASTQ format.

        --m-lower           maternal kmer frequency table will ignore kmers with count < m-lower.
                            [ optional, default 0. ]
        --m-upper           maternal kmer frequency table will ignore kmers with count > m-upper.
                            [ optional, default 0. ]
        --p-lower           paternal kmer frequency table will ignore kmers with count < p-lower.
                            [ optional, default 0. ]
        --p-upper           paternal kmer frequency table will ignore kmers with count > p-upper.
                            [ optional, default 0. ]
        --auto_bounds       (0/1) automatically calcuate lower and upper bounds based on kmer analysis.
                            [ optional, default 1; ]
        --help              print this usage message.

Examples :

    ./sysc build_k21   --paternal father.fastq --maternal mater.fastq
```

## symbiontscreener_build_s40

### Tool Description
Build randstrobe(2,10,30,30) lists from paternal and maternal NGS reads with jellyfish.

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

### Original Help Text
```text
Usage    :
  ./sysc build_s40 [OPTION]

Build randstrobe(2,10,30,30) based on paternal and maternal NGS reads by jellyfish.

Options  :
  basic input:
        --paternal    paternal NGS reads file in FASTA/FASTQ format.
                      file in gzip format can be accepted, but filename must end by ".gz".
        --maternal    maternal NGS reads file in FASTA/FASTQ format.
                      file in gzip format can be accepted, but filename must end by ".gz".
  resources:
        --thread      thread number.
                      [ optional, default 8 threads. ]
        --size        initial hash table by jellyfish.
                      [ optional, default 1GB. ]
  detail configuration:
        --auto_bounds (0/1) automatically calcuate lower and upper bounds based on kmer analysis.
                      [ optional, default 1; ]
        --m-lower     maternal kmer frequency table will ignore kmers with count < m-lower.
                      [ optional, default 0. ]
        --m-upper     maternal kmer frequency table will ignore kmers with count > m-upper.
                      [ optional, default 0. ]
        --p-lower     paternal kmer frequency table will ignore kmers with count < p-lower.
                      [ optional, default 0. ]
        --p-upper     paternal kmer frequency table will ignore kmers with count > p-upper.
                      [ optional, default 0. ]
```

## symbiontscreener_density_k21

### Tool Description
Calculate the paternal-only, maternal-only and shared k-mer density of each offspring read.

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

### Original Help Text
```text
Usage    :
    ./sysc density_k21 [OPTION]

Options  :

        --offspring         Offspring sequence file.
                            gzip format file is supported but should end by '.gz' 
        --offspring_format  fasta/fastq (default fasta)

        --thread            thread num.
                            [ optional, default 8 threads. ]
Examples :

    ./sysc density_k21   --offspring test.fa
```

## symbiontscreener_density_s40

### Tool Description
Calculate the paternal-only, maternal-only and shared k-mer density of each offspring read.

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

### Original Help Text
```text
Usage    :
    ./sysc density_s40 [OPTION]

Options  :
        --offspring         Offspring sequence file.
                            gzip format file is supported but should end by '.gz' 
        --offspring_format  fasta/fastq 
                            [ optional, default fasta]
        --thread            thread num.
                            [ optional, default 8 threads. ]
```

## symbiontscreener_trio_result_k21

### Tool Description
Filter offspring reads by parental and shared k-mer density (trio-only result).

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

### Original Help Text
```text
Usage    :
    ./sysc trio_result_k21_sh [OPTION]

Options  :
        --threshold1        minimum density of parental kmer density(default 0.003)
        --threshold2        minimum density of shared kmer density(default 0.01)
```

## symbiontscreener_trio_result_s40

### Tool Description
Filter offspring reads by parental and shared k-mer density (trio-only result).

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

### Original Help Text
```text
Usage    :
    ./sysc trio_result_s40 [OPTION]

Options  :
        --threshold1        minimum density of parental kmer density(default 0.003)
        --threshold2        minimum density of shared kmer density(default 0.01)
```

## symbiontscreener_cluster_k21

### Tool Description
Cluster offspring reads with a Bayesian Gaussian mixture model on trio k-mer density and GC/n-mer features.

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

### Original Help Text
```text
Usage    :
    ./sysc cluster_k21  [OPTION]

Options  :
        --offspring         Offspring sequence file.
                            gzip format file is supported but should end by '.gz' 
        --offspring_format  fasta/fastq (default fasta)

        --threshold1        minimum density of parental kmer density(default 0.003)
        --threshold2        minimum density of shared kmer density(default 0.01)
        --shortest          shortest for cluster (default 5000)

        --thread            thread num.
                            [ optional, default 8 threads. ]
        --help              print this usage message.
```

## symbiontscreener_cluster_s40

### Tool Description
Cluster offspring reads with a Bayesian Gaussian mixture model on trio k-mer density and GC/n-mer features.

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

### Original Help Text
```text
Usage    :
    ./sysc cluster_s40  [OPTION]

Options  :
        --offspring         Offspring sequence file.
                            gzip format file is supported but should end by '.gz' 
        --offspring_format  fasta/fastq (default fasta)

        --threshold1        minimum density of parental kmer density(default 0.003)
        --threshold2        minimum density of shared kmer density(default 0.01)
        --shortest          shortest for cluster (default 5000)

        --thread            thread num.
                            [ optional, default 8 threads. ]
        --help              print this usage message.
```

## symbiontscreener_consensus_cluster_k21

### Tool Description
Select reads with enough hits in the best and second best cluster (consensus clustering).

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

### Original Help Text
```text
Usage    :
    ./sysc consensus_cluster_k21 [OPTION]

Options  :
        --min_hit           minimum hit in best and second best cluster
        --help              print this usage message.
```

## symbiontscreener_consensus_cluster_s40

### Tool Description
Select reads with enough hits in the best and second best cluster (consensus clustering).

### Metadata
- **Docker Image**: quay.io/biocontainers/symbiontscreener:1.0.0--h5ca1c30_2
- **Homepage**: https://github.com/BGI-Qingdao/Symbiont-Screener
- **Package**: https://anaconda.org/channels/bioconda/packages/symbiontscreener/overview
- **Validation**: PASS

### Original Help Text
```text
Usage    :
    ./sysc consensus_cluster_s40 [OPTION]

Options  :
        --min_hit           minimum hit in best and second best cluster
        --help              print this usage message.
```

