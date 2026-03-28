# reseq CWL Generation Report

## reseq_illuminaPE

### Tool Description
ReSeq version 1.1 in illuminaPE mode

### Metadata
- **Docker Image**: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
- **Homepage**: https://github.com/schmeing/ReSeq/tree/devel
- **Package**: https://anaconda.org/channels/bioconda/packages/reseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/reseq/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/schmeing/ReSeq
- **Stars**: N/A
### Original Help Text
```text
>>> 25-02-26 13:40:42: info:  Running ReSeq version 1.1 in illuminaPE mode
>>> 25-02-26 13:40:42: info:  Detected 20 cores to be used.
!!! int main(int, char**) [/opt/conda/conda-bld/reseq_1734155457953/work/reseq/main.cpp:800]: error: refIn or refSim option mandatory.
Usage:  reseq illuminaPE -b <file.bam> -r <ref.fa> -1 <file1.fq> -2 <file2.fq> [options]
General:
  -h [ --help ]                         Prints help information and exits
  -j [ --threads ] arg (=0)             Number of threads used (0=auto)
  --verbosity arg (=4)                  Sets the level of verbosity 
                                        (4=everything, 0=nothing)
  --version                             Prints version info and exits

Stats:
  --adapterFile arg                     Fasta file with adapter sequences 
                                        [(AutoDetect)]
  --adapterMatrix arg                   0/1 matrix with valid adapter pairing 
                                        (first read in rows, second read in 
                                        columns) [(AutoDetect)]
  -b [ --bamIn ] arg                    Position sorted bam/sam file with reads
                                        mapped to refIn
  --binSizeBiasFit arg (=100000000)     Reference sequences large then this are
                                        split for bias fitting to limit memory 
                                        consumption
  --maxFragLen arg (=2000)              Maximum fragment length to include 
                                        pairs into statistics
  --minMapQ arg (=2)                    Minimum mapping quality to include 
                                        pairs into statistics
  --noBias                              Do not perform bias fit. Results in 
                                        uniform coverage if simulated from
  --noTiles                             Ignore tiles for the statistics 
                                        [default]
  -r [ --refIn ] arg                    Reference sequences in fasta format (gz
                                        and bz2 supported)
  --statsOnly                           Only generate the statistics
  -s [ --statsIn ] arg                  Skips statistics generation and reads 
                                        directly from stats file
  -S [ --statsOut ] arg                 Stores the real data statistics for 
                                        reuse in given file [<bamIn>.reseq]
  --tiles                               Use tiles for the statistics
  -v [ --vcfIn ] arg                    Ignore all positions with a listed 
                                        variant for stats generation

Probabilities:
  --ipfIterations arg (=200)            Maximum number of iterations for 
                                        iterative proportional fitting
  --ipfPrecision arg (=5)               Iterative proportional fitting 
                                        procedure stops after reaching this 
                                        precision (%)
  -p [ --probabilitiesIn ] arg          Loads last estimated probabilities and 
                                        continues from there if precision is 
                                        not met [<statsIn>.ipf]
  -P [ --probabilitiesOut ] arg         Stores the probabilities estimated by 
                                        iterative proportional fitting 
                                        [<probabilitiesIn>]
  --stopAfterEstimation                 Stop after estimating the probabilities

Simulation:
  -1 [ --firstReadsOut ] arg            Writes the simulated first reads into 
                                        this file [reseq-R1.fq]
  -2 [ --secondReadsOut ] arg           Writes the simulated second reads into 
                                        this file [reseq-R2.fq]
  -c [ --coverage ] arg (=0)            Approximate average read depth 
                                        simulated (0 = Corrected original 
                                        coverage)
  --errorMutliplier arg (=1)            Divides the original probability of 
                                        correct base calls(no substitution 
                                        error) by this value and renormalizes
  --methylation arg                     Extended bed graph file specifying 
                                        methylation for regions. Multiple score
                                        columns for individual alleles are 
                                        possible, but must match with vcfSim. 
                                        C->T conversions for 1-specified value 
                                        in region.
  --noInDelErrors                       Simulate reads without InDel errors
  --noSubstitutionErrors                Simulate reads without substitution 
                                        errors
  --numReads arg (=0)                   Approximate number of read pairs 
                                        simulated (0 = Use <coverage>)
  --readSysError arg                    Read systematic errors from file in 
                                        fastq format (seq=dominant error, 
                                        qual=error percentage)
  --recordBaseIdentifier arg (=ReseqRead)
                                        Base Identifier for the simulated fastq
                                        records, followed by a count and other 
                                        information about the read
  --refBias arg                         Way to select the reference biases for 
                                        simulation (keep [from refIn]/no 
                                        [biases]/draw [with replacement from 
                                        original biases]/file) [keep/no]
  --refBiasFile arg                     File to read reference biases from: One
                                        sequence per file (identifier bias)
  -R [ --refSim ] arg                   Reference sequences in fasta format to 
                                        simulate from [<refIn>]
  --seed arg                            Seed used for simulation, if none is 
                                        given random seed will be used
  -V [ --vcfSim ] arg                   Defines genotypes to simulate alleles 
                                        or populations
  --writeSysError arg                   Write the randomly drawn systematic 
                                        errors to file in fastq format 
                                        (seq=dominant error, qual=error 
                                        percentage)
```


## reseq_queryProfile

### Tool Description
Runs ReSeq in queryProfile mode

### Metadata
- **Docker Image**: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
- **Homepage**: https://github.com/schmeing/ReSeq/tree/devel
- **Package**: https://anaconda.org/channels/bioconda/packages/reseq/overview
- **Validation**: PASS

### Original Help Text
```text
>>> 25-02-26 13:42:12: info:  Running ReSeq version 1.1 in queryProfile mode
!!! int main(int, char**) [/opt/conda/conda-bld/reseq_1734155457953/work/reseq/main.cpp:503]: error: Could not parse queryProfile command line arguments: unrecognised option '-help'
Usage:  reseq queryProfile -r <ref.fa> -s <stats.reseq>
General:
  -h [ --help ]             Prints help information and exits
  -j [ --threads ] arg (=0) Number of threads used (0=auto)
  --verbosity arg (=4)      Sets the level of verbosity (4=everything, 
                            0=nothing)
  --version                 Prints version info and exits

queryProfile:
  --maxLenDeletion          Output lengths of longest detected deletion to 
                            stdout
  --maxReadLength           Output lengths of longest detected read to stdout
  -r [ --ref ] arg          Reference sequences in fasta format (gz and bz2 
                            supported)
  --refSeqBias arg          Output reference sequence bias to file (tsv format;
                            - for stdout)
  -s [ --stats ] arg        Reseq statistics file to extract reference sequence
                            bias
```


## reseq_replaceN

### Tool Description
Replace Ns in reference sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
- **Homepage**: https://github.com/schmeing/ReSeq/tree/devel
- **Package**: https://anaconda.org/channels/bioconda/packages/reseq/overview
- **Validation**: PASS

### Original Help Text
```text
>>> 25-02-26 13:43:27: info:  Running ReSeq version 1.1 in replaceN mode
>>> 25-02-26 13:43:27: info:  Detected 20 cores to be used.
!!! int main(int, char**) [/opt/conda/conda-bld/reseq_1734155457953/work/reseq/main.cpp:651]: error: refIn option is mandatory.
Usage:  reseq replaceN -r <refIn.fa> -R <refSim.fa> [options]
General:
  -h [ --help ]             Prints help information and exits
  -j [ --threads ] arg (=0) Number of threads used (0=auto)
  --verbosity arg (=4)      Sets the level of verbosity (4=everything, 
                            0=nothing)
  --version                 Prints version info and exits

ReplaceN:
  -r [ --refIn ] arg        Reference sequences in fasta format (gz and bz2 
                            supported)
  -R [ --refSim ] arg       File to where reference sequences in fasta format 
                            with N's randomly replace should be written to
  --seed arg                Seed used for replacing N, if none is given random 
                            seed will be used
```


## reseq_seqToIllumina

### Tool Description
Converts a FASTA file to FASTQ format with simulated sequencing errors.

### Metadata
- **Docker Image**: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
- **Homepage**: https://github.com/schmeing/ReSeq/tree/devel
- **Package**: https://anaconda.org/channels/bioconda/packages/reseq/overview
- **Validation**: PASS

### Original Help Text
```text
>>> 25-02-26 13:44:21: info:  Running ReSeq version 1.1 in seqToIllumina mode
!!! int main(int, char**) [/opt/conda/conda-bld/reseq_1734155457953/work/reseq/main.cpp:1031]: error: Could not parse seqToIllumina command line arguments: unrecognised option '-help'
Usage:  reseq seqToIllumina -i <input.fa> -o <output.fq> -s <stats.reseq> [options]
General:
  -h [ --help ]                  Prints help information and exits
  -j [ --threads ] arg (=0)      Number of threads used (0=auto)
  --verbosity arg (=4)           Sets the level of verbosity (4=everything, 
                                 0=nothing)
  --version                      Prints version info and exits

seqToIllumina:
  --errorMutliplier arg (=1)     Divides the original probability of correct 
                                 base calls(no substitution error) by this 
                                 value and renormalizes
  -i [ --input ] arg             Input file (fasta format, gz and bz2 
                                 supported) [stdin]
  --ipfIterations arg (=200)     Maximum number of iterations for iterative 
                                 proportional fitting
  --ipfPrecision arg (=5)        Iterative proportional fitting procedure stops
                                 after reaching this precision (%)
  --noInDelErrors                Simulate reads without InDel errors
  --noSubstitutionErrors         Simulate reads without substitution errors
  -o [ --output ] arg            Output file (fastq format, gz and bz2 
                                 supported) [stdout]
  -p [ --probabilitiesIn ] arg   Loads last estimated probabilities and 
                                 continues from there if precision is not met 
                                 [<statsIn>.ipf]
  -P [ --probabilitiesOut ] arg  Stores the probabilities estimated by 
                                 iterative proportional fitting 
                                 [<probabilitiesIn>]
  --seed arg                     Seed used for simulation, if none is given 
                                 random seed will be used
  -s [ --statsIn ] arg           Profile file that contains the statistics used
                                 for simulation
```


## reseq_test

### Tool Description
Runs ReSeq in test mode

### Metadata
- **Docker Image**: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
- **Homepage**: https://github.com/schmeing/ReSeq/tree/devel
- **Package**: https://anaconda.org/channels/bioconda/packages/reseq/overview
- **Validation**: PASS

### Original Help Text
```text
>>> 25-02-26 13:44:46: info:  Running ReSeq version 1.1 in test mode
Usage: reseq test [options]
General:
  -h [ --help ]             Prints help information and exits
  -j [ --threads ] arg (=0) Number of threads used (0=auto)
  --verbosity arg (=4)      Sets the level of verbosity (4=everything, 
                            0=nothing)
  --version                 Prints version info and exits
```


## Metadata
- **Skill**: generated
