# knock-knock CWL Generation Report

## knock-knock_process-sample

### Tool Description
Process a sample using knock-knock.

### Metadata
- **Docker Image**: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/jeffhussmann/knock-knock
- **Package**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Total Downloads**: 4.3K
- **Last updated**: 2026-02-23
- **GitHub**: https://github.com/jeffhussmann/knock-knock
- **Stars**: N/A
### Original Help Text
```text
usage: knock-knock process-sample [-h] [--stages STAGES] [--progress]
                                  base_dir batch_name sample_name

positional arguments:
  base_dir         the base directory to store input data, reference
                   annotations, and analysis output for a project
  batch_name       batch name
  sample_name      sample name

options:
  -h, --help       show this help message and exit
  --stages STAGES
  --progress       show progress bars
```


## knock-knock_parallel

### Tool Description
Run knock-knock in parallel across multiple samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/jeffhussmann/knock-knock
- **Package**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knock-knock parallel [-h] [--batch BATCH] [--conditions CONDITIONS]
                            [--stages STAGES] [--use_logger_thread]
                            [--progress]
                            base_dir max_procs

positional arguments:
  base_dir              the base directory to store input data, reference
                        annotations, and analysis output for a project
  max_procs             maximum number of samples to process at once

options:
  -h, --help            show this help message and exit
  --batch BATCH         if specified, the single batch name to process; if not
                        specified, all batches will be processed
  --conditions CONDITIONS
                        if specified, conditions that samples must satisfy to
                        be processed, given as yaml; if not specified, all
                        samples will be processed
  --stages STAGES
  --use_logger_thread   write a consolidated log
  --progress            show progress bars
```


## knock-knock_table

### Tool Description
Generates a table of knock-knock results.

### Metadata
- **Docker Image**: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/jeffhussmann/knock-knock
- **Package**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knock-knock table [-h] [--batches BATCHES] [--title TITLE] [--unsorted]
                         [--vmax_multiple VMAX_MULTIPLE]
                         base_dir

positional arguments:
  base_dir              the base directory to store input data, reference
                        annotations, and analysis output for a project

options:
  -h, --help            show this help message and exit
  --batches BATCHES     if specified, a comma-separated list of batches to
                        include; if not specified, all batches in base_dir
                        will be generated
  --title TITLE         if specified, a title for output files
  --unsorted            don't sort samples
  --vmax_multiple VMAX_MULTIPLE
                        fractional value that corresponds to full horizontal
                        bar
```


## knock-knock_build-strategies

### Tool Description
Builds strategies for a project.

### Metadata
- **Docker Image**: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/jeffhussmann/knock-knock
- **Package**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knock-knock build-strategies [-h] base_dir batch_name

positional arguments:
  base_dir    the base directory to store input data, reference annotations,
              and analysis output for a project
  batch_name  batch name

options:
  -h, --help  show this help message and exit
```


## knock-knock_download-genome

### Tool Description
Download a genome and its associated annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/jeffhussmann/knock-knock
- **Package**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knock-knock download-genome [-h] base_dir genome_name

positional arguments:
  base_dir     the base directory to store input data, reference annotations,
               and analysis output for a project
  genome_name  name of genome to download

options:
  -h, --help   show this help message and exit
```


## knock-knock_build-indices

### Tool Description
Build indices for a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/jeffhussmann/knock-knock
- **Package**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knock-knock build-indices [-h] [--num-threads NUM_THREADS]
                                 base_dir genome_name

positional arguments:
  base_dir              the base directory to store input data, reference
                        annotations, and analysis output for a project
  genome_name           name of genome to build indices for

options:
  -h, --help            show this help message and exit
  --num-threads NUM_THREADS
                        number of threads to use
```


## knock-knock_install-example-data

### Tool Description
Installs example data for a knock-knock project.

### Metadata
- **Docker Image**: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/jeffhussmann/knock-knock
- **Package**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knock-knock install-example-data [-h] base_dir

positional arguments:
  base_dir    the base directory to store input data, reference annotations,
              and analysis output for a project

options:
  -h, --help  show this help message and exit
```


## knock-knock_install

### Tool Description
A tool for analyzing knock-knock sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/jeffhussmann/knock-knock
- **Package**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knock-knock [-h] [--version]
                   {process-sample,parallel,table,build-strategies,download-genome,build-indices,install-example-data,whos-there}
                   ...
knock-knock: error: argument subcommand: invalid choice: 'install' (choose from 'process-sample', 'parallel', 'table', 'build-strategies', 'download-genome', 'build-indices', 'install-example-data', 'whos-there')
```


## knock-knock_directory

### Tool Description
A tool for analyzing genomic data, with various subcommands for different tasks.

### Metadata
- **Docker Image**: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/jeffhussmann/knock-knock
- **Package**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Validation**: PASS

### Original Help Text
```text
usage: knock-knock [-h] [--version]
                   {process-sample,parallel,table,build-strategies,download-genome,build-indices,install-example-data,whos-there}
                   ...
knock-knock: error: argument subcommand: invalid choice: 'directory' (choose from 'process-sample', 'parallel', 'table', 'build-strategies', 'download-genome', 'build-indices', 'install-example-data', 'whos-there')
```


## knock-knock_whos-there

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/jeffhussmann/knock-knock
- **Package**: https://anaconda.org/channels/bioconda/packages/knock-knock/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: knock-knock whos-there [-h]

options:
  -h, --help  show this help message and exit
```


## Metadata
- **Skill**: generated
