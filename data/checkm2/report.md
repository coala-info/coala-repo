# checkm2 CWL Generation Report

## checkm2_predict

### Tool Description
Predict the completeness and contamination of genome bins in a folder.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm2:1.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/chklovski/CheckM2
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/checkm2/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chklovski/CheckM2
- **Stars**: N/A
### Original Help Text
```text
usage: checkm2 predict [-h] [--debug] [--version] [--quiet] [--lowmem] --input
                       INPUT [INPUT ...] --output-directory OUTPUT_DIRECTORY
                       [--general] [--specific] [--allmodels] [--genes]
                       [-x EXTENSION] [--tmpdir TMPDIR] [--force] [--resume]
                       [--threads num_threads] [--stdout]
                       [--remove_intermediates] [--ttable ttable]
                       [--database_path DATABASE_PATH] [--dbg_cos]
                       [--dbg_vectors]

Predict the completeness and contamination of genome bins in a folder. Example usage: 

	checkm2 predict --threads 30 --input <folder_with_bins> --output-directory <output_folder>

options:
  -h, --help            show this help message and exit
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --lowmem              Low memory mode. Reduces DIAMOND blocksize to significantly reduce RAM usage at the expense of longer runtime

required arguments:
  --input INPUT [INPUT ...], -i INPUT [INPUT ...]
                        Path to folder containing MAGs or list of MAGS to be analyzed
  --output-directory OUTPUT_DIRECTORY, --output_directory OUTPUT_DIRECTORY, -o OUTPUT_DIRECTORY
                        Path output to folder

additional arguments:
  --general             Force the use of the general quality prediction model (gradient boost)
  --specific            Force the use of the specific quality prediction model (neural network)
  --allmodels           Output quality prediction for both models for each genome.
  --genes               Treat input files as protein files. [Default: False]
  -x EXTENSION, --extension EXTENSION
                        Extension of input files. [Default: .fna]
  --tmpdir TMPDIR       specify an alternative directory for temporary files
  --force               overwrite output directory [default: do not overwrite]
  --resume              Reuse Prodigal and DIAMOND results found in output directory [default: not set]
  --threads num_threads, -t num_threads
                        number of CPUS to use [default: 1]
  --stdout              Print results to stdout [default: write to file]
  --remove_intermediates
                        Remove all intermediate files (protein files, diamond output) [default: don't]
  --ttable ttable       Provide a specific progidal translation table for bins [default: automatically determine either 11 or 4]
  --database_path DATABASE_PATH
                        Provide a location for the CheckM2 database for a given predict run [default: use either internal path set via <checkm2 database> or CHECKM2DB environmental variable]
  --dbg_cos             DEBUG: write cosine similarity values to file [default: don't]
  --dbg_vectors         DEBUG: dump pickled feature vectors to file [default: don't]
```


## checkm2_directory

### Tool Description
checkm2: error: argument subparser_name: invalid choice: 'directory' (choose from predict, testrun, database)

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm2:1.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/chklovski/CheckM2
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm2 [-h] [--debug] [--version] [--quiet] [--lowmem]
               {predict,testrun,database} ...
checkm2: error: argument subparser_name: invalid choice: 'directory' (choose from predict, testrun, database)
```


## checkm2_testrun

### Tool Description
Runs Checkm2 on internal test genomes to ensure it runs without errors.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkm2:1.1.0--pyh7e72e81_1
- **Homepage**: https://github.com/chklovski/CheckM2
- **Package**: https://anaconda.org/channels/bioconda/packages/checkm2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: checkm2 testrun [-h] [--debug] [--version] [--quiet] [--lowmem]
                       [--threads num_threads] [--database_path DATABASE_PATH]

Runs Checkm2 on internal test genomes to ensure it runs without errors. Example usage: 

	 checkm2 testrun --threads 10

options:
  -h, --help            show this help message and exit
  --debug               output debug information
  --version             output version information and quit
  --quiet               only output errors
  --lowmem              Low memory mode. Reduces DIAMOND blocksize to significantly reduce RAM usage at the expense of longer runtime
  --threads num_threads, -t num_threads
                        number of CPUS to use [default: 1]
  --database_path DATABASE_PATH
                        Provide a location for the CheckM2 database for a given predict run [default: use either internal path set via <checkm2 database> or CHECKM2DB environmental variable]
```

