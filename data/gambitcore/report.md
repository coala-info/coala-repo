# gambitcore CWL Generation Report

## gambitcore

### Tool Description
How complete is an assembly compared to the core genome of its species?

### Metadata
- **Docker Image**: quay.io/biocontainers/gambitcore:0.0.2--py310h1fe012e_0
- **Homepage**: https://github.com/gambit-suite/gambitcore
- **Package**: https://anaconda.org/channels/bioconda/packages/gambitcore/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gambitcore/overview
- **Total Downloads**: 497
- **Last updated**: 2025-04-29
- **GitHub**: https://github.com/gambit-suite/gambitcore
- **Stars**: N/A
### Original Help Text
```text
usage: gambitcore [options]

How complete is an assembly compared to the core genome of its species?

positional arguments:
  gambit_directory      A directory containing GAMBIT files (database and
                        signatures)
  fasta_filenames       A list of FASTA files of genomes

options:
  -h, --help            show this help message and exit
  --concise, -e         concise output (default: False)
  --cpus CPUS, -p CPUS  Number of cpus to use (default: 1)
  --max_species_genomes MAX_SPECIES_GENOMES, -t MAX_SPECIES_GENOMES
                        Max number of genomes in a species to consider, ignore
                        all others above this (default: 100000)
  --core_proportion CORE_PROPORTION, -c CORE_PROPORTION
                        Proportion of genomes a kmer must be in for a species
                        to be considered core (default: 0.98)
  --kmer KMER           Length of the k-mer to use. Dont change these, must
                        match database parameters. (default: 11)
  --kmer_prefix KMER_PREFIX
                        Kmer prefix. Dont change these, must match database
                        parameters. (default: ATGAC)
  --num_genomes_per_species NUM_GENOMES_PER_SPECIES, -r NUM_GENOMES_PER_SPECIES
                        Number of genomes to keep for a species (0 means keep
                        all). Dont change this. (default: 1)
  --verbose, -v         Turn on verbose output (default: False)
  --version             show program's version number and exit
```

