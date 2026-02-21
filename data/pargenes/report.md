# pargenes CWL Generation Report

## pargenes

### Tool Description
The provided text does not contain help information for the tool 'pargenes'. It appears to be an error log from a container runtime (Apptainer/Singularity) indicating that the executable was not found.

### Metadata
- **Docker Image**: quay.io/biocontainers/pargenes:1.2.0--py37hf7b2935_0
- **Homepage**: https://github.com/BenoitMorel/ParGenes
- **Package**: https://anaconda.org/channels/bioconda/packages/pargenes/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pargenes/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BenoitMorel/ParGenes
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/13 22:51:30  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "pargenes": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## pargenes_pargenes.py

### Tool Description
A tool for parallel phylogenomic analyses using RAxML-NG and ModelTest-NG.

### Metadata
- **Docker Image**: quay.io/biocontainers/pargenes:1.2.0--py37hf7b2935_0
- **Homepage**: https://github.com/BenoitMorel/ParGenes
- **Package**: https://anaconda.org/channels/bioconda/packages/pargenes/overview
- **Validation**: PASS
### Original Help Text
```text
usage: ['/usr/local/bin/pargenes.py', '--help', '--scheduler', 'fork']
       [-h] [-V] [--dry-run] [-a ALIGNMENTS_DIR] [-o OUTPUT_DIR] [-c CORES]
       [--seed SEED] [--continue] [--msa-filter MSA_FILTER] [-d {nt,aa}]
       [--scheduler {split,onecore,fork}]
       [--core-assignment {high,medium,low}] [--valgrind]
       [--job-failure-fatal]
       [--per-msa-raxml-parameters PER_MSA_RAXML_PARAMETERS]
       [-s RANDOM_STARTING_TREES] [-p PARSIMONY_STARTING_TREES]
       [-r RAXML_GLOBAL_PARAMETERS] [-R RAXML_GLOBAL_PARAMETERS_STRING]
       [-b BOOTSTRAPS] [--autoMRE] [--raxml-binary RAXML_BINARY]
       [--percentage-jobs-double-cores PERCENTAGE_JOBS_DOUBLE_CORES] [-m]
       [--modeltest-global-parameters MODELTEST_GLOBAL_PARAMETERS]
       [--per-msa-modeltest-parameters PER_MSA_MODELTEST_PARAMETERS]
       [--modeltest-criteria {AICc,AIC,BIC}]
       [--modeltest-perjob-cores MODELTEST_CORES]
       [--modeltest-binary MODELTEST_BINARY] [--use-astral]
       [--astral-global-parameters ASTRAL_GLOBAL_PARAMETERS]
       [--experiment-disable-jobs-sorting] [--retry RETRY]

optional arguments:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  --dry-run
  -a ALIGNMENTS_DIR, --alignments-dir ALIGNMENTS_DIR
                        Directory containing the fasta files
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Output directory
  -c CORES, --cores CORES
                        The number of computational cores available for
                        computation. Should at least 2.
  --seed SEED           Random seed, for reproductibility of RAxML-NG runs.
                        Set to 0 by default
  --continue            Allow pargenes to continue the analysis from the last
                        checkpoint
  --msa-filter MSA_FILTER
                        A file containing the names of the msa files to
                        process
  -d {nt,aa}, --datatype {nt,aa}
                        Alignments datatype
  --scheduler {split,onecore,fork}
                        Expert-user only.
  --core-assignment {high,medium,low}
                        Policy to decide the per-job number of cores (low
                        favors a low per-job number of cores)
  --valgrind            Run the scheduler with valgrind
  --job-failure-fatal   Stop ParGenes when a job fails
  --per-msa-raxml-parameters PER_MSA_RAXML_PARAMETERS
                        A file containing per-msa raxml parameters
  -s RANDOM_STARTING_TREES, --random-starting-trees RANDOM_STARTING_TREES
                        The number of starting trees
  -p PARSIMONY_STARTING_TREES, --parsimony-starting-trees PARSIMONY_STARTING_TREES
                        The number of starting parsimony trees
  -r RAXML_GLOBAL_PARAMETERS, --raxml-global-parameters RAXML_GLOBAL_PARAMETERS
                        A file containing the parameters to pass to raxml
  -R RAXML_GLOBAL_PARAMETERS_STRING, --raxml-global-parameters-string RAXML_GLOBAL_PARAMETERS_STRING
                        List of parameters to pass to raxml (see also --raxml-
                        global-parameters)
  -b BOOTSTRAPS, --bs-trees BOOTSTRAPS
                        The number of bootstrap trees to compute
  --autoMRE             Stop computing bootstrap trees after autoMRE bootstrap
                        convergence test. You have to specify the maximum
                        number of bootstrap trees with -b or --bs-tree
  --raxml-binary RAXML_BINARY
                        Custom path to raxml-ng executable. Please refer to
                        the wiki before setting this variable yourself.
  --percentage-jobs-double-cores PERCENTAGE_JOBS_DOUBLE_CORES
                        Percentage (between 0 and 1) of jobs that will receive
                        twice more cores
  -m, --use-modeltest   Autodetect the model with modeltest
  --modeltest-global-parameters MODELTEST_GLOBAL_PARAMETERS
                        A file containing the parameters to pass to modeltest
  --per-msa-modeltest-parameters PER_MSA_MODELTEST_PARAMETERS
                        A file containing per-msa modeltest parameters
  --modeltest-criteria {AICc,AIC,BIC}
                        Alignments datatype
  --modeltest-perjob-cores MODELTEST_CORES
                        Number of cores to assign to each modeltest core (at
                        least 4)
  --modeltest-binary MODELTEST_BINARY
                        Custom path to modeltest-ng executable. Please refer
                        to the wiki before setting this variable yourself.
  --use-astral          Infer a species tree with astral
  --astral-global-parameters ASTRAL_GLOBAL_PARAMETERS
                        A file containing additional parameters to pass to
                        astral
  --experiment-disable-jobs-sorting
                        For experimenting only! Removes the sorting step in
                        the scheduler
  --retry RETRY         Number of time the scheduler should try to restart
                        after an error
```

