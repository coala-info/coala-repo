# bygul CWL Generation Report

## bygul_simulate-proportions

### Tool Description
Simulate proportions for genomes, primers, and reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/bygul:1.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/Bygul
- **Package**: https://anaconda.org/channels/bioconda/packages/bygul/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bygul/overview
- **Total Downloads**: 383
- **Last updated**: 2026-01-17
- **GitHub**: https://github.com/andersen-lab/Bygul
- **Stars**: N/A
### Original Help Text
```text
Usage: bygul simulate-proportions [OPTIONS] GENOMES PRIMERS REFERENCE

Options:
  --proportions TEXT              Read proportions for each sample,
                                  e.g.(0.8,0.2) must sum to 1.0. If not
                                  provided, the program will randomly assign
                                  proportions  [default: NA]
  --outdir PATH                   Output directory  [default: results]
  --simulator [wgsim|mason]       Select the simulator to use (wgsim or mason)
                                  [default: wgsim]
  --outerdistance INTEGER         Outer distance for simulation using wgsim
                                  [default: 150]
  --seed INTEGER                  seed for simulation
  --readcnt INTEGER               Number of reads per amplicon  [default: 500]
  --read_length INTEGER           Read length for simulation  [default: 150]
  --error_rate FLOAT              Base error rate (e.g., 0.02) for simulation
                                  using both wgsim and mason  [default: 0.004]
  --standard_deviation INTEGER    Standard deviation of insert size for wgsim
                                  [default: 50]
  --mean_quality_begin FLOAT      Mean sequence quality in beginning of the
                                  read for mason simulator only  [default: 40]
  --mean_quality_end FLOAT        Mean sequence quality in end of the read for
                                  mason simulator only  [default: 39.5]
  --mutation_rate FLOAT           Mutation rate (e.g., 0.001) for simulation
                                  for wgsim  [default: 0.001]
  --indel_fraction FLOAT          Fraction of indels (e.g., 0.15) for
                                  simulation,this will be both insertion and
                                  deletion probablity for mason  [default:
                                  5e-05]
  --indel_extend_probability FLOAT
                                  Probability an indel is extended (e.g.,
                                  0.3)for simulation for wgsim  [default:
                                  5e-05]
  --maxmismatch INTEGER           Maximum number of mismatches allowed in
                                  primer region  [default: 1]
  --haplotype                     use this to simulate reads for a haploid
                                  organism for wgsim  [default: True]
  --redo                          Overwrite the output directory if it already
                                  exists.
  --help                          Show this message and exit.
```

