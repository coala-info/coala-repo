# metasbt CWL Generation Report

## metasbt_db

### Tool Description
List and retrieve public MetaSBT databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/cumbof/MetaSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Total Downloads**: 550
- **Last updated**: 2025-07-07
- **GitHub**: https://github.com/cumbof/MetaSBT
- **Stars**: N/A
### Original Help Text
```text
usage: db [-h] [--list] --download DOWNLOAD [--version VERSION]
          [--folder FOLDER]

List and retrieve public MetaSBT databases.

optional arguments:
  -h, --help           show this help message and exit
  --list               List official public MetaSBT databases. (default:
                       False)
  --download DOWNLOAD  The database name. (default: None)
  --version VERSION    The database version. It automatically select the most
                       recent one if a version is not provided. (default:
                       None)
  --folder FOLDER      Store the selected database under this folder.
                       (default: /)
```


## metasbt_index

### Tool Description
Index a set of reference genomes. This is used to build a first baseline of a MetaSBT database. Genomes must be known with a fully defined taxonomic label, from the kingdom up to the species level.

### Metadata
- **Docker Image**: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/cumbof/MetaSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: index [-h] --workdir WORKDIR --database DATABASE --references
             REFERENCES [--dereplicate DEREPLICATE] [--nproc NPROC] [--pack]
             [--filter-size FILTER_SIZE]
             [--increase-filter-size INCREASE_FILTER_SIZE]
             [--min-kmer-occurrences MIN_KMER_OCCURRENCES]
             [--kmer-size KMER_SIZE] [--limit-kmer-size LIMIT_KMER_SIZE]
             [--completeness COMPLETENESS] [--contamination CONTAMINATION]

Index a set of reference genomes. This is used to build a first baseline of a
MetaSBT database. Genomes must be known with a fully defined taxonomic label,
from the kingdom up to the species level.

optional arguments:
  -h, --help            show this help message and exit

General arguments:
  --workdir WORKDIR     Path to the working directory. (default: None)
  --database DATABASE   The database name. (default: None)
  --references REFERENCES
                        Path to the tab-separated-values file with the list of
                        reference genomes. It must contain two columns. The
                        first one with the path to the actual reference
                        genomes. The second one with their fully defined
                        taxonomic label in the following form: k__Kingdom|p__P
                        hylum|c__Class|o__Order|f__Family|g__Genus|s__Species
                        (default: None)
  --dereplicate DEREPLICATE
                        Dereplicate genomes based of their ANI distance
                        according the specified threshold. The dereplication
                        process is triggered in case of a threshold >0.0.
                        (default: 0.0)
  --nproc NPROC         Process the input genomes in parallel. (default: 20)
  --pack                Pack the database into a compressed tarball. (default:
                        False)

Estimate a proper bloom filter size:
  --filter-size FILTER_SIZE
                        This is the size of the bloom filters. It
                        automatically estimates a proper bloom filter size if
                        not provided. (default: None)
  --increase-filter-size INCREASE_FILTER_SIZE
                        Increase the estimated filter size by the specified
                        percentage. It is highly recommended to increase the
                        filter size by a good percentage in case you are
                        planning to update the index with new genomes.
                        (default: 50.0)
  --min-kmer-occurrences MIN_KMER_OCCURRENCES
                        Minimum number of occurrences of kmers to be
                        considered for estimating the bloom filter size and
                        for building the bloom filter files. (default: 2)

Estimate the optimal kmer size:
  --kmer-size KMER_SIZE
                        The kmer size. It automatically estimates a proper
                        bloom filter size if not provided. (default: None)
  --limit-kmer-size LIMIT_KMER_SIZE
                        Limit the estimation of the optimal kmer size with
                        kitsune to this size at most. (default: 32)

Assess the quality of input genomes:
  --completeness COMPLETENESS
                        Percentage threshold on genomes completeness.
                        (default: 0.0)
  --contamination CONTAMINATION
                        Percentage threshold on genomes contamination.
                        (default: 100.0)
```


## metasbt_kraken

### Tool Description
Export a MetaSBT database into a custom kraken database.

### Metadata
- **Docker Image**: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/cumbof/MetaSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kraken [-h] --workdir WORKDIR [--database DATABASE] --genomes GENOMES
              [--kmer-size KMER_SIZE] [--minimizer-length MINIMIZER_LENGTH]
              [--minimizer-spaces MINIMIZER_SPACES] [--threads THREADS]

Export a MetaSBT database into a custom kraken database.

optional arguments:
  -h, --help            show this help message and exit
  --workdir WORKDIR     Path to the working directory. (default: None)
  --database DATABASE   The database name. (default: MetaSBT)
  --genomes GENOMES     Path to the file with the list of paths to the
                        genomes. Genomes must be in the MetaSBT database in
                        order to be processed. (default: None)
  --kmer-size KMER_SIZE
                        The kmer size in bp. (default: 27)
  --minimizer-length MINIMIZER_LENGTH
                        The minimizer length in bp. (default: 21)
  --minimizer-spaces MINIMIZER_SPACES
                        Number of characters in minimizer that are ignored in
                        comparisons. (default: 5)
  --threads THREADS     Number of threads for kraken2-build. (default: 1)
```


## metasbt_pack

### Tool Description
Pack a MetaSBT database into a compressed tarball.

### Metadata
- **Docker Image**: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/cumbof/MetaSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pack [-h] --workdir WORKDIR [--database DATABASE]

Pack a MetaSBT database into a compressed tarball.

optional arguments:
  -h, --help           show this help message and exit
  --workdir WORKDIR    Path to the working directory. (default: None)
  --database DATABASE  The database name. (default: MetaSBT)
```


## metasbt_profile

### Tool Description
Profile a set of genomes. This is used to report the closest kingdom, phylum, class, order, family, genus, species, and the closest genome in a specific database.

### Metadata
- **Docker Image**: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/cumbof/MetaSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: profile [-h] --workdir WORKDIR [--database DATABASE] --genome GENOME
               --genomes GENOMES [--uncertainty UNCERTAINTY]
               [--pruning-threshold PRUNING_THRESHOLD] [--nproc NPROC]

Profile a set of genomes. This is used to report the closest kingdom, phylum,
class, order, family, genus, species, and the closest genome in a specific
database.

optional arguments:
  -h, --help            show this help message and exit
  --workdir WORKDIR     Path to the working directory. (default: None)
  --database DATABASE   The database name. (default: MetaSBT)
  --genome GENOME       Path to the input genome. (default: None)
  --genomes GENOMES     Path to the file with a list of paths to the input
                        genomes. (default: None)
  --uncertainty UNCERTAINTY
                        Uncertainty percentage for considering multiple best
                        hits. (default: 20.0)
  --pruning-threshold PRUNING_THRESHOLD
                        Threshold for pruning the Sequence Bloom Tree.
                        (default: 0.0)
  --nproc NPROC         Process the input genomes in parallel. (default: 20)
```


## metasbt_sketch

### Tool Description
Sketch the input genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/cumbof/MetaSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sketch [-h] --workdir WORKDIR [--database DATABASE] --genome GENOME
              --genomes GENOMES [--nproc NPROC]

Sketch the input genomes.

optional arguments:
  -h, --help           show this help message and exit
  --workdir WORKDIR    Path to the working directory. (default: None)
  --database DATABASE  The database name. (default: MetaSBT)
  --genome GENOME      Path to the input genome. (default: None)
  --genomes GENOMES    Path to the file with a list of paths to the input
                       genomes. (default: None)
  --nproc NPROC        Process the input genomes in parallel. (default: 20)
```


## metasbt_summarize

### Tool Description
Summarize the content of a MetaSBT database.

### Metadata
- **Docker Image**: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/cumbof/MetaSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: summarize [-h] --workdir WORKDIR [--database DATABASE]

Summarize the content of a MetaSBT database.

optional arguments:
  -h, --help           show this help message and exit
  --workdir WORKDIR    Path to the working directory. (default: None)
  --database DATABASE  The database name. (default: MetaSBT)
```


## metasbt_test

### Tool Description
Check for software dependencies and run unit tests.

### Metadata
- **Docker Image**: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/cumbof/MetaSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: test [-h] --references REFERENCES --mags MAGS

Check for software dependencies and run unit tests.

optional arguments:
  -h, --help            show this help message and exit
  --references REFERENCES
                        Path to the file with the list of paths to the
                        reference genomes and their taxonomies. (default:
                        None)
  --mags MAGS           Path to the file with the list of paths to the
                        metagenome-assembled genomes. (default: None)
```


## metasbt_unpack

### Tool Description
Unack a local MetaSBT tarball database.

### Metadata
- **Docker Image**: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/cumbof/MetaSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: unpack [-h] --workdir WORKDIR [--database DATABASE] [--tarball TARBALL]

Unack a local MetaSBT tarball database.

optional arguments:
  -h, --help           show this help message and exit
  --workdir WORKDIR    Path to the working directory. (default: None)
  --database DATABASE  The database name. (default: MetaSBT)
  --tarball TARBALL    Path to the MetaSBT tarball database. (default: None)
```


## metasbt_update

### Tool Description
Update a MetaSBT database with new genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
- **Homepage**: https://github.com/cumbof/MetaSBT
- **Package**: https://anaconda.org/channels/bioconda/packages/metasbt/overview
- **Validation**: PASS

### Original Help Text
```text
usage: update [-h] --workdir WORKDIR --database DATABASE --genome GENOME
              --genomes GENOMES [--dereplicate DEREPLICATE]
              [--completeness COMPLETENESS] [--contamination CONTAMINATION]
              [--nproc NPROC] [--pack] [--uncertainty UNCERTAINTY]
              [--pruning-threshold PRUNING_THRESHOLD]

Update a MetaSBT database with new genomes.

optional arguments:
  -h, --help            show this help message and exit
  --workdir WORKDIR     Path to the working directory. (default: None)
  --database DATABASE   The database name. (default: None)
  --genome GENOME       Path to the input genome. (default: None)
  --genomes GENOMES     Path to the file with a list of paths to the input
                        genomes. (default: None)
  --dereplicate DEREPLICATE
                        Dereplicate genomes based of their ANI distance
                        according the specified threshold. The dereplication
                        process is triggered in case of a threshold >0.0.
                        (default: 0.0)
  --completeness COMPLETENESS
                        Percentage threshold on genomes completeness.
                        (default: 0.0)
  --contamination CONTAMINATION
                        Percentage threshold on genomes contamination.
                        (default: 100.0)
  --nproc NPROC         Process the input genomes in parallel. (default: 20)
  --pack                Pack the database into a compressed tarball. (default:
                        False)
  --uncertainty UNCERTAINTY
                        Uncertainty percentage for considering multiple best
                        hits while profiling input genomes. (default: 20.0)
  --pruning-threshold PRUNING_THRESHOLD
                        Threshold for pruning the Sequence Bloom Tree while
                        profiling input genomes. (default: 0.0)
```


## Metadata
- **Skill**: generated
