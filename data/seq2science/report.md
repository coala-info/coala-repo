# seq2science CWL Generation Report

## seq2science_init

### Tool Description
Initialises a default configuration and samples file for a specific workflow. Supported workflows: scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-seq, chip-seq.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq2science:1.2.4--pyhdfd78af_0
- **Homepage**: https://vanheeringen-lab.github.io/seq2science
- **Package**: https://anaconda.org/channels/bioconda/packages/seq2science/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seq2science/overview
- **Total Downloads**: 115.1K
- **Last updated**: 2025-05-14
- **GitHub**: https://github.com/vanheeringen-lab/seq2science
- **Stars**: N/A
### Original Help Text
```text
usage: seq2science init [-h] [--dir PATH] [-f] WORKFLOW

Each workflow requires a configuration and samples file to run. Running
"seq2science init {workflow}" initialises a default configuration and samples
file for the specific workflow. Supported workflows: scrna-seq, download-
fastq, rna-seq, alignment, atac-seq, scatac-seq, chip-seq

positional arguments:
  WORKFLOW

options:
  -h, --help   show this help message and exit
  --dir PATH   The path to the directory where to initialise the config and
               samples files.
  -f, --force  Overwrite existing samples.tsv and config.yaml silently.
```


## seq2science_run

### Tool Description
Run a complete workflow. This requires that a config and samples file are either present in the current directory, or passed as an argument. Supported workflows: scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-seq, chip-seq

### Metadata
- **Docker Image**: quay.io/biocontainers/seq2science:1.2.4--pyhdfd78af_0
- **Homepage**: https://vanheeringen-lab.github.io/seq2science
- **Package**: https://anaconda.org/channels/bioconda/packages/seq2science/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seq2science run [-h] [-j N] [-n] [-r] [--skip-rerun] [-k]
                       [--rerun-incomplete] [--unlock]
                       [--cleanup-metadata CLEANUP_METADATA [CLEANUP_METADATA ...]]
                       [--snakemakeOptions KEY=VAL [KEY=VAL ...]]
                       [-p PROFILE NAME] [-c FILE] [--debug]
                       WORKFLOW

Run a complete workflow. This requires that a config and samples file are
either present in the current directory, or passed as an argument. Supported
workflows: scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-
seq, chip-seq

positional arguments:
  WORKFLOW

options:
  -h, --help            show this help message and exit
  -j N, --cores N       Use at most N cores in parallel. Must be at least 2.
                        When executing on a cluster, this number controls the
                        maximum numberof parallel jobs.
  -n, --dryrun          Do not execute anything, and display what would be
                        done.
  -r, --reason          Print the reason for each executed rule.
  --skip-rerun          Skip the check if samples or configuration has been
                        changed.
  -k, --keep-going      Go on with independent jobs if a job fails.
  --rerun-incomplete    Re-run all jobs the output of which is recognized as
                        incomplete.
  --unlock              Remove a lock on the working directory.
  --cleanup-metadata CLEANUP_METADATA [CLEANUP_METADATA ...]
                        Just cleanup metadata of given list of output files
                        (default None).
  --snakemakeOptions KEY=VAL [KEY=VAL ...]
                        Extra arguments to pass along to snakemake. An example
                        could be seq2science run alignment --cores 12
                        --snakemakeOptions resources={mem_gb:100}
                        local_cores=3. Here we pass local_cores as KEY=VALUE
                        and additional resources can even be passed along in a
                        dictionary. Take a look at the snakemake API for a
                        complete list of all possible options:
                        https://snakemake-api.readthedocs.io/en/latest/api_ref
                        erence/snakemake.html
  -p PROFILE NAME, --profile PROFILE NAME
                        Use a seq2science profile. Profiles can be taken from:
                        https://github.com/vanheeringen-lab/seq2science-
                        profiles. Profiles are an experimental feature and
                        might not always work as intended. Please let us know
                        if something doesn't work properly!
  -c FILE, --configfile FILE
                        The path to the config file.
  --debug               For developers "only": prints helpful error messages
                        to debug issues.
```


## seq2science_explain

### Tool Description
Explains what has/will be done for the workflow. This prints a string which can serve as a skeleton for your material & methods section. Supported workflows: scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-seq, chip-seq

### Metadata
- **Docker Image**: quay.io/biocontainers/seq2science:1.2.4--pyhdfd78af_0
- **Homepage**: https://vanheeringen-lab.github.io/seq2science
- **Package**: https://anaconda.org/channels/bioconda/packages/seq2science/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seq2science explain [-h] [--hyperref]
                           [--snakemakeOptions KEY=VAL [KEY=VAL ...]]
                           [-p PROFILE NAME] [-c FILE] [--debug]
                           WORKFLOW

Explains what has/will be done for the workflow. This prints a string which
can serve as a skeleton for your material & methods section. Supported
workflows: scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-
seq, chip-seq

positional arguments:
  WORKFLOW

options:
  -h, --help            show this help message and exit
  --hyperref            Print urls as html hyperref
  --snakemakeOptions KEY=VAL [KEY=VAL ...]
                        Extra arguments to pass along to snakemake. An example
                        could be seq2science run alignment --cores 12
                        --snakemakeOptions resources={mem_gb:100}
                        local_cores=3. Here we pass local_cores as KEY=VALUE
                        and additional resources can even be passed along in a
                        dictionary. Take a look at the snakemake API for a
                        complete list of all possible options:
                        https://snakemake-api.readthedocs.io/en/latest/api_ref
                        erence/snakemake.html
  -p PROFILE NAME, --profile PROFILE NAME
                        Use a seq2science profile. Profiles can be taken from:
                        https://github.com/vanheeringen-lab/seq2science-
                        profiles. Profiles are an experimental feature and
                        might not always work as intended. Please let us know
                        if something doesn't work properly!
  -c FILE, --configfile FILE
                        The path to the config file.
  --debug               For developers "only": prints helpful error messages
                        to debug issues.
```


## seq2science_clean

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq2science:1.2.4--pyhdfd78af_0
- **Homepage**: https://vanheeringen-lab.github.io/seq2science
- **Package**: https://anaconda.org/channels/bioconda/packages/seq2science/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: seq2science clean [-h]

At the start of each workflow run, seq2science starts with installing
environments for each rule. It also stores the GEO soft files of public
samples in its cache. These environments can get large and it might be best to
remove them when you are done with an analysis. seq2science clean will clean
up these files for you.

options:
  -h, --help  show this help message and exit
```


## seq2science_docs

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq2science:1.2.4--pyhdfd78af_0
- **Homepage**: https://vanheeringen-lab.github.io/seq2science
- **Package**: https://anaconda.org/channels/bioconda/packages/seq2science/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: seq2science docs [-h]

The docs command tries to open your browser and open the docs' webpage, if
that didn't work it prints the url.

options:
  -h, --help  show this help message and exit
```


## Metadata
- **Skill**: generated
