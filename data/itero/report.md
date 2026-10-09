# itero CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| itero_assemble_local | PASS |  |
| itero_assemble_mpi | Not completed | needs mpirun with at least two MPI processes; one process fails |

## itero_assemble_local

### Tool Description
Assemble reads using local CPUs for assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/itero:1.1.2--py27_0
- **Homepage**: https://github.com/faircloth-lab/itero
- **Package**: https://anaconda.org/channels/bioconda/packages/itero/overview
- **Validation**: PASS

### Original Help Text
```text
usage: itero assemble local [-h] [--config CONFIG] [--subfolder SUBFOLDER]
                            [--iterations ITERATIONS]
                            [--local-cores LOCAL_CORES] [--clean]
                            [--only-single-locus] [--allow-multiple-contigs]
                            [--do-not-zip] [--verbosity {INFO,WARN,CRITICAL}]
                            [--log-path LOG_PATH] --output OUTPUT

Assemble reads using local CPUs for assembly.

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG       A configuration file containing reads to assemble
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
  --iterations ITERATIONS
                        The number of iterations to run for each locus
  --local-cores LOCAL_CORES
                        The number of cores to use on the main node
  --clean               Cleanup all intermediate files
  --only-single-locus   Assemble only to a single contig
  --allow-multiple-contigs
                        Allow assembly stages to produce multiple contigs
  --do-not-zip          Do not zip the iteration files, which is the default
                        behavior.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --output OUTPUT       The directory in which to store the output
```

## itero_assemble_mpi

### Tool Description
Assemble reads using MPI for assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/itero:1.1.2--py27_0
- **Homepage**: https://github.com/faircloth-lab/itero
- **Package**: https://anaconda.org/channels/bioconda/packages/itero/overview
- **Validation**: PASS

### Original Help Text
```text
usage: itero assemble mpi [-h] [--config CONFIG] [--subfolder SUBFOLDER]
                          [--iterations ITERATIONS]
                          [--local-cores LOCAL_CORES] [--clean]
                          [--only-single-locus] [--allow-multiple-contigs]
                          [--do-not-zip] [--verbosity {INFO,WARN,CRITICAL}]
                          [--log-path LOG_PATH] --output OUTPUT

Assemble reads using MPI for assembly.

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG       A configuration file containing reads to assemble
  --subfolder SUBFOLDER
                        A subdirectory, below the level of the group,
                        containing the reads
  --iterations ITERATIONS
                        The number of iterations to run for each locus
  --local-cores LOCAL_CORES
                        The number of cores to use on the main node
  --clean               Cleanup all intermediate files
  --only-single-locus   Assemble only to a single contig
  --allow-multiple-contigs
                        Allow assembly stages to produce multiple contigs
  --do-not-zip          Do not zip the iteration files, which is the default
                        behavior.
  --verbosity {INFO,WARN,CRITICAL}
                        The logging level to use.
  --log-path LOG_PATH   The path to a directory to hold logs.
  --output OUTPUT       The directory in which to store the output
```

## Metadata
- **Skill**: generated
