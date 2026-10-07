# coconet-binning CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| coconet-binning_cluster | Failed | tool bug: config.yaml stores every path as the text of the Path class (path_to_str uses str(Path)), so cluster crashes when it reloads an earlier step's folder; 'coconet run' clusters fine. |
| coconet-binning_learn | PASS |  |
| coconet-binning_preprocess | PASS |  |
| coconet-binning_run | PASS |  |

## coconet-binning_preprocess

### Tool Description
Preprocess data

### Metadata
- **Docker Image**: quay.io/biocontainers/coconet-binning:1.1.0--py_0
- **Homepage**: https://github.com/Puumanamana/CoCoNet
- **Package**: https://anaconda.org/channels/bioconda/packages/coconet-binning/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coconet-binning/overview
- **Total Downloads**: 11.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Puumanamana/CoCoNet
- **Stars**: N/A
### Original Help Text
```text
usage: coconet preprocess [-h] [--fasta FASTA] [--h5 H5] [--output OUTPUT]
                          [-t THREADS] [--debug] [--quiet] [--silent]
                          [--continue] [--bam BAM [BAM ...]]
                          [--min-ctg-len MIN_CTG_LEN]
                          [--min-prevalence MIN_PREVALENCE]
                          [--min-mapping-quality MIN_MAPPING_QUALITY]
                          [--min-aln-coverage MIN_ALN_COVERAGE] [--flag FLAG]
                          [--tlen-range TLEN_RANGE TLEN_RANGE]
                          [--min-dtr-size MIN_DTR_SIZE]

optional arguments:
  -h, --help            show this help message and exit
  --fasta FASTA         Path to your assembly file (fasta formatted) (default:
                        None)
  --h5 H5               Experimental: coverage in hdf5 format (keys are
                        contigs, values are (sample, contig_len) ndarrays
                        (default: None)
  --output OUTPUT       Path to output directory (default: output)
  -t THREADS, --threads THREADS
                        Number of threads (default: 5)
  --debug               Print debugging statements (default: 20)
  --quiet               Less verbose (default: None)
  --silent              Only error messages (default: None)
  --continue            Start from last checkpoint. The output directory needs
                        to be the same. (default: False)
  --bam BAM [BAM ...]   List of paths to your coverage files (bam formatted)
                        (default: None)
  --min-ctg-len MIN_CTG_LEN
                        Minimum contig length (default: 2048)
  --min-prevalence MIN_PREVALENCE
                        Minimum contig prevalence for binning. Contig with
                        less that value are filtered out. (default: 2)
  --min-mapping-quality MIN_MAPPING_QUALITY
                        Minimum alignment quality (default: 30)
  --min-aln-coverage MIN_ALN_COVERAGE
                        Discard alignments with less than 50% aligned
                        nucleotides
  --flag FLAG           SAM flag for filtering (same as samtools "-F" option)
                        (default: 3596)
  --tlen-range TLEN_RANGE TLEN_RANGE
                        Only allow for paired alignments with spacing within
                        this range (default: None)
  --min-dtr-size MIN_DTR_SIZE
                        Minimum size of DTR to flag complete contigs (default:
                        10)
```

## coconet-binning_learn

### Tool Description
Train neural network on input data

### Metadata
- **Docker Image**: quay.io/biocontainers/coconet-binning:1.1.0--py_0
- **Homepage**: https://github.com/Puumanamana/CoCoNet
- **Package**: https://anaconda.org/channels/bioconda/packages/coconet-binning/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coconet-binning/overview
- **Total Downloads**: 11.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Puumanamana/CoCoNet
- **Stars**: N/A
### Original Help Text
```text
usage: coconet learn [-h] [--fasta FASTA] [--h5 H5] [--output OUTPUT]
                     [-t THREADS] [--debug] [--quiet] [--silent] [--continue]
                     [--fragment-length FRAGMENT_LENGTH]
                     [--features {coverage,composition} [{coverage,composition} ...]]
                     [--fragment-step FRAGMENT_STEP] [--test-ratio TEST_RATIO]
                     [--n-train N_TRAIN] [--n-test N_TEST]
                     [--learning-rate LEARNING_RATE] [--batch-size BATCH_SIZE]
                     [--test-batch TEST_BATCH] [--patience PATIENCE]
                     [--load-batch LOAD_BATCH]
                     [--compo-neurons COMPO_NEURONS COMPO_NEURONS]
                     [--cover-neurons COVER_NEURONS COVER_NEURONS]
                     [--cover-filters COVER_FILTERS]
                     [--cover-kernel COVER_KERNEL]
                     [--cover-stride COVER_STRIDE]
                     [--merge-neurons MERGE_NEURONS] [-k KMER] [--no-rc]
                     [--wsize WSIZE] [--wstep WSTEP] [--n-frags N_FRAGS]

optional arguments:
  -h, --help            show this help message and exit
  --fasta FASTA         Path to your assembly file (fasta formatted) (default:
                        None)
  --h5 H5               Experimental: coverage in hdf5 format (keys are
                        contigs, values are (sample, contig_len) ndarrays
                        (default: None)
  --output OUTPUT       Path to output directory (default: output)
  -t THREADS, --threads THREADS
                        Number of threads (default: 5)
  --debug               Print debugging statements (default: 20)
  --quiet               Less verbose (default: None)
  --silent              Only error messages (default: None)
  --continue            Start from last checkpoint. The output directory needs
                        to be the same. (default: False)
  --fragment-length FRAGMENT_LENGTH
                        Length of contig fragments in bp. Default is half the
                        minimum contig length. (default: -1)
  --features {coverage,composition} [{coverage,composition} ...]
                        Features for binning (composition, coverage, or both)
                        (default: ['coverage', 'composition'])
  --fragment-step FRAGMENT_STEP
                        Fragments spacing (default: 128)
  --test-ratio TEST_RATIO
                        Ratio for train / test split (default: 0.1)
  --n-train N_TRAIN     Maximum number of training examples (default: 4000000)
  --n-test N_TEST       Number of test examples (default: 10000)
  --learning-rate LEARNING_RATE
                        Learning rate for gradient descent (default: 0.001)
  --batch-size BATCH_SIZE
                        Batch size for training (default: 256)
  --test-batch TEST_BATCH
                        Run test every 400 batches
  --patience PATIENCE   Early stopping if test accuracy does not improve for 5
                        consecutive tests
  --load-batch LOAD_BATCH
                        Number of coverage batch to load in memory. Consider
                        lowering this value if your RAM is limited. (default:
                        100)
  --compo-neurons COMPO_NEURONS COMPO_NEURONS
                        Number of neurons for the composition dense layers
                        (x2) (default: [64, 32])
  --cover-neurons COVER_NEURONS COVER_NEURONS
                        Number of neurons for the coverage dense layers (x2)
                        (default: [64, 32])
  --cover-filters COVER_FILTERS
                        Number of filters for convolution layer of coverage
                        network. (default: 16)
  --cover-kernel COVER_KERNEL
                        Kernel size for convolution layer of coverage network.
                        (default: 4)
  --cover-stride COVER_STRIDE
                        Convolution stride for convolution layer of coverage
                        network. (default: 2)
  --merge-neurons MERGE_NEURONS
                        Number of neurons for the merging layer (x1) (default:
                        32)
  -k KMER, --kmer KMER  k-mer size for composition vector (default: 4)
  --no-rc               Do not add the reverse complement k-mer occurrences to
                        the composition vector. (default: False)
  --wsize WSIZE         Smoothing window size for coverage vector (default:
                        64)
  --wstep WSTEP         Subsampling step for coverage vector (default: 32)
  --n-frags N_FRAGS     Number of fragments to split the contigs for the
                        clustering phase (default: 30)
```

## coconet-binning_cluster

### Tool Description
Bin contigs using neural network

### Metadata
- **Docker Image**: quay.io/biocontainers/coconet-binning:1.1.0--py_0
- **Homepage**: https://github.com/Puumanamana/CoCoNet
- **Package**: https://anaconda.org/channels/bioconda/packages/coconet-binning/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coconet-binning/overview
- **Total Downloads**: 11.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Puumanamana/CoCoNet
- **Stars**: N/A
### Original Help Text
```text
usage: coconet cluster [-h] [--output OUTPUT] [-t THREADS] [--debug] [--quiet]
                       [--silent] [--continue]
                       [--fragment-length FRAGMENT_LENGTH]
                       [--features {coverage,composition} [{coverage,composition} ...]]
                       [--max-neighbors MAX_NEIGHBORS]
                       [--vote-threshold VOTE_THRESHOLD]
                       [--algorithm {leiden,spectral}] [--theta THETA]
                       [--gamma1 GAMMA1] [--gamma2 GAMMA2]
                       [--n-clusters N_CLUSTERS] [--recruit-small-contigs]

optional arguments:
  -h, --help            show this help message and exit
  --output OUTPUT       Path to output directory (default: output)
  -t THREADS, --threads THREADS
                        Number of threads (default: 5)
  --debug               Print debugging statements (default: 20)
  --quiet               Less verbose (default: None)
  --silent              Only error messages (default: None)
  --continue            Start from last checkpoint. The output directory needs
                        to be the same. (default: False)
  --fragment-length FRAGMENT_LENGTH
                        Length of contig fragments in bp. Default is half the
                        minimum contig length. (default: -1)
  --features {coverage,composition} [{coverage,composition} ...]
                        Features for binning (composition, coverage, or both)
                        (default: ['coverage', 'composition'])
  --max-neighbors MAX_NEIGHBORS
                        Maximum number of neighbors to consider to compute the
                        adjacency matrix. (default: 250)
  --vote-threshold VOTE_THRESHOLD
                        When this parameter is not set, contig-contig edges
                        are computed by summing the probability between all
                        pairwise fragments between them.Otherwise, adopt a
                        voting strategy and sets a hard-threshold on the
                        probabilityfrom each pairwise comparison. (default:
                        None)
  --algorithm {leiden,spectral}
                        Algorithm for clustering the contig-contig graph.
                        Note: the number of cluster is required if "spectral"
                        is chosen. (default: leiden)
  --theta THETA         (leiden) Minimum percent of edges between two contigs
                        to form an edge between them (default: 0.8)
  --gamma1 GAMMA1       (leiden) CPM optimization value for the first run of
                        the Leiden clustering (default: 0.3)
  --gamma2 GAMMA2       (leiden) CPM optimization value for the second run of
                        the Leiden clustering (default: 0.4)
  --n-clusters N_CLUSTERS
                        (spectral clustering) Maximum number of clusters
                        (default: None)
  --recruit-small-contigs
                        Salvage short contigs (<2048) (default: False)
```

## coconet-binning_run

### Tool Description
Run complete workflow (recommended)

### Metadata
- **Docker Image**: quay.io/biocontainers/coconet-binning:1.1.0--py_0
- **Homepage**: https://github.com/Puumanamana/CoCoNet
- **Package**: https://anaconda.org/channels/bioconda/packages/coconet-binning/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coconet-binning/overview
- **Total Downloads**: 11.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Puumanamana/CoCoNet
- **Stars**: N/A
### Original Help Text
```text
usage: coconet run [-h] [--fasta FASTA] [--h5 H5] [--output OUTPUT]
                   [-t THREADS] [--debug] [--quiet] [--silent] [--continue]
                   [--bam BAM [BAM ...]] [--min-ctg-len MIN_CTG_LEN]
                   [--min-prevalence MIN_PREVALENCE]
                   [--min-mapping-quality MIN_MAPPING_QUALITY]
                   [--min-aln-coverage MIN_ALN_COVERAGE] [--flag FLAG]
                   [--tlen-range TLEN_RANGE TLEN_RANGE]
                   [--min-dtr-size MIN_DTR_SIZE]
                   [--fragment-step FRAGMENT_STEP] [--test-ratio TEST_RATIO]
                   [--n-train N_TRAIN] [--n-test N_TEST]
                   [--learning-rate LEARNING_RATE] [--batch-size BATCH_SIZE]
                   [--test-batch TEST_BATCH] [--patience PATIENCE]
                   [--load-batch LOAD_BATCH]
                   [--compo-neurons COMPO_NEURONS COMPO_NEURONS]
                   [--cover-neurons COVER_NEURONS COVER_NEURONS]
                   [--cover-filters COVER_FILTERS]
                   [--cover-kernel COVER_KERNEL] [--cover-stride COVER_STRIDE]
                   [--merge-neurons MERGE_NEURONS] [-k KMER] [--no-rc]
                   [--wsize WSIZE] [--wstep WSTEP] [--n-frags N_FRAGS]
                   [--max-neighbors MAX_NEIGHBORS]
                   [--vote-threshold VOTE_THRESHOLD]
                   [--algorithm {leiden,spectral}] [--theta THETA]
                   [--gamma1 GAMMA1] [--gamma2 GAMMA2]
                   [--n-clusters N_CLUSTERS] [--recruit-small-contigs]
                   [--fragment-length FRAGMENT_LENGTH]
                   [--features {coverage,composition} [{coverage,composition} ...]]

optional arguments:
  -h, --help            show this help message and exit
  --fasta FASTA         Path to your assembly file (fasta formatted) (default:
                        None)
  --h5 H5               Experimental: coverage in hdf5 format (keys are
                        contigs, values are (sample, contig_len) ndarrays
                        (default: None)
  --output OUTPUT       Path to output directory (default: output)
  -t THREADS, --threads THREADS
                        Number of threads (default: 5)
  --debug               Print debugging statements (default: 20)
  --quiet               Less verbose (default: None)
  --silent              Only error messages (default: None)
  --continue            Start from last checkpoint. The output directory needs
                        to be the same. (default: False)
  --bam BAM [BAM ...]   List of paths to your coverage files (bam formatted)
                        (default: None)
  --min-ctg-len MIN_CTG_LEN
                        Minimum contig length (default: 2048)
  --min-prevalence MIN_PREVALENCE
                        Minimum contig prevalence for binning. Contig with
                        less that value are filtered out. (default: 2)
  --min-mapping-quality MIN_MAPPING_QUALITY
                        Minimum alignment quality (default: 30)
  --min-aln-coverage MIN_ALN_COVERAGE
                        Discard alignments with less than 50% aligned
                        nucleotides
  --flag FLAG           SAM flag for filtering (same as samtools "-F" option)
                        (default: 3596)
  --tlen-range TLEN_RANGE TLEN_RANGE
                        Only allow for paired alignments with spacing within
                        this range (default: None)
  --min-dtr-size MIN_DTR_SIZE
                        Minimum size of DTR to flag complete contigs (default:
                        10)
  --fragment-step FRAGMENT_STEP
                        Fragments spacing (default: 128)
  --test-ratio TEST_RATIO
                        Ratio for train / test split (default: 0.1)
  --n-train N_TRAIN     Maximum number of training examples (default: 4000000)
  --n-test N_TEST       Number of test examples (default: 10000)
  --learning-rate LEARNING_RATE
                        Learning rate for gradient descent (default: 0.001)
  --batch-size BATCH_SIZE
                        Batch size for training (default: 256)
  --test-batch TEST_BATCH
                        Run test every 400 batches
  --patience PATIENCE   Early stopping if test accuracy does not improve for 5
                        consecutive tests
  --load-batch LOAD_BATCH
                        Number of coverage batch to load in memory. Consider
                        lowering this value if your RAM is limited. (default:
                        100)
  --compo-neurons COMPO_NEURONS COMPO_NEURONS
                        Number of neurons for the composition dense layers
                        (x2) (default: [64, 32])
  --cover-neurons COVER_NEURONS COVER_NEURONS
                        Number of neurons for the coverage dense layers (x2)
                        (default: [64, 32])
  --cover-filters COVER_FILTERS
                        Number of filters for convolution layer of coverage
                        network. (default: 16)
  --cover-kernel COVER_KERNEL
                        Kernel size for convolution layer of coverage network.
                        (default: 4)
  --cover-stride COVER_STRIDE
                        Convolution stride for convolution layer of coverage
                        network. (default: 2)
  --merge-neurons MERGE_NEURONS
                        Number of neurons for the merging layer (x1) (default:
                        32)
  -k KMER, --kmer KMER  k-mer size for composition vector (default: 4)
  --no-rc               Do not add the reverse complement k-mer occurrences to
                        the composition vector. (default: False)
  --wsize WSIZE         Smoothing window size for coverage vector (default:
                        64)
  --wstep WSTEP         Subsampling step for coverage vector (default: 32)
  --n-frags N_FRAGS     Number of fragments to split the contigs for the
                        clustering phase (default: 30)
  --max-neighbors MAX_NEIGHBORS
                        Maximum number of neighbors to consider to compute the
                        adjacency matrix. (default: 250)
  --vote-threshold VOTE_THRESHOLD
                        When this parameter is not set, contig-contig edges
                        are computed by summing the probability between all
                        pairwise fragments between them.Otherwise, adopt a
                        voting strategy and sets a hard-threshold on the
                        probabilityfrom each pairwise comparison. (default:
                        None)
  --algorithm {leiden,spectral}
                        Algorithm for clustering the contig-contig graph.
                        Note: the number of cluster is required if "spectral"
                        is chosen. (default: leiden)
  --theta THETA         (leiden) Minimum percent of edges between two contigs
                        to form an edge between them (default: 0.8)
  --gamma1 GAMMA1       (leiden) CPM optimization value for the first run of
                        the Leiden clustering (default: 0.3)
  --gamma2 GAMMA2       (leiden) CPM optimization value for the second run of
                        the Leiden clustering (default: 0.4)
  --n-clusters N_CLUSTERS
                        (spectral clustering) Maximum number of clusters
                        (default: None)
  --recruit-small-contigs
                        Salvage short contigs (<2048) (default: False)
  --fragment-length FRAGMENT_LENGTH
                        Length of contig fragments in bp. Default is half the
                        minimum contig length. (default: -1)
  --features {coverage,composition} [{coverage,composition} ...]
                        Features for binning (composition, coverage, or both)
                        (default: ['coverage', 'composition'])
```

## Metadata
- **Skill**: generated
