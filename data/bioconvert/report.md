# bioconvert CWL Generation Report

## bioconvert_abi2fasta

### Tool Description
Convert file from (ABI,) to (FASTA,) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Total Downloads**: 49.2K
- **Last updated**: 2025-10-21
- **GitHub**: https://github.com/bioconvert/bioconvert
- **Stars**: N/A
### Original Help Text
```text
usage: bioconvert abi2fasta [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{biopython}]] [-s]
                            [input_file] [output_file]

Convert file from '('ABI',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython}], --method [{biopython}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_abi2fastq

### Tool Description
Convert file from '('ABI',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert abi2fastq [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{biopython}]] [-s]
                            [input_file] [output_file]

Convert file from '('ABI',)' to '('FASTQ',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython}], --method [{biopython}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_abi2qual

### Tool Description
Convert file from '('ABI',)' to '('QUAL',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert abi2qual [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                           [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                           [-T BENCHMARK_TAG] [-I]
                           [--benchmark-mode BENCHMARK_MODE]
                           [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                           [-e EXTRA_ARGUMENTS] [-m [{biopython}]] [-s]
                           [input_file] [output_file]

Convert file from '('ABI',)' to '('QUAL',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython}], --method [{biopython}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bam2bedgraph

### Tool Description
Convert file from '('BAM',)' to '('BEDGRAPH',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bam2bedgraph [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS]
                               [-m [{bedtools,mosdepth}]] [-s] [-t THREADS]
                               [input_file] [output_file]

Convert file from '('BAM',)' to '('BEDGRAPH',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bedtools,mosdepth}], --method [{bedtools,mosdepth}]
                        The method to use to do the conversion. (default:
                        bedtools)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bam2bigwig

### Tool Description
Convert file from ('BAM',) to ('BIGWIG',) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bam2bigwig [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS]
                             [-m [{bamCoverage,ucsc}]] [-s]
                             [--chrom-sizes CHROM_SIZES]
                             [input_file] [output_file]

Convert file from '('BAM',)' to '('BIGWIG',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bamCoverage,ucsc}], --method [{bamCoverage,ucsc}]
                        The method to use to do the conversion. (default:
                        bamCoverage)
  -s, --show-methods    A converter may have several methods (default: False)
  --chrom-sizes CHROM_SIZES
                        a two-column file/URL: <chromosome name> <size in
                        bases>. Used by the ucsc method only (default: None)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bam2cov

### Tool Description
Convert file from '('BAM',)' to '('COV',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bam2cov [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{bedtools,samtools}]] [-s]
                          [input_file] [output_file]

Convert file from '('BAM',)' to '('COV',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bedtools,samtools}], --method [{bedtools,samtools}]
                        The method to use to do the conversion. (default:
                        bedtools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bam2cram

### Tool Description
Convert file from '('BAM',)' to '('CRAM',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bam2cram [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                           [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                           [-T BENCHMARK_TAG] [-I]
                           [--benchmark-mode BENCHMARK_MODE]
                           [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                           [-e EXTRA_ARGUMENTS] [-m [{samtools}]] [-s]
                           [-t THREADS] [--reference REFERENCE]
                           [input_file] [output_file]

Convert file from '('BAM',)' to '('CRAM',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{samtools}], --method [{samtools}]
                        The method to use to do the conversion. (default:
                        samtools)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)
  --reference REFERENCE
                        the reference used (FASTA format). If not provided,
                        prompt will appear (default: None)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bam2fasta

### Tool Description
Convert file from ('BAM',) to ('FASTA',) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bam2fasta [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{samtools}]] [-s]
                            [input_file] [output_file]

Convert file from '('BAM',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{samtools}], --method [{samtools}]
                        The method to use to do the conversion. (default:
                        samtools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bam2fastq

### Tool Description
Convert file from '('BAM',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bam2fastq [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS]
                            [-m [{bedtools,samtools}]] [-s]
                            [input_file] [output_file]

Convert file from '('BAM',)' to '('FASTQ',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bedtools,samtools}], --method [{bedtools,samtools}]
                        The method to use to do the conversion. (default:
                        samtools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bam2json

### Tool Description
Convert file from '('BAM',)' to '('JSON',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bam2json [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                           [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                           [-T BENCHMARK_TAG] [-I]
                           [--benchmark-mode BENCHMARK_MODE]
                           [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                           [-e EXTRA_ARGUMENTS] [-m [{bamtools}]] [-s]
                           [input_file] [output_file]

Convert file from '('BAM',)' to '('JSON',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bamtools}], --method [{bamtools}]
                        The method to use to do the conversion. (default:
                        bamtools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bam2sam

### Tool Description
Convert file from '('BAM',)' to '('SAM',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bam2sam [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS]
                          [-m [{picard,pysam,sambamba,samtools}]] [-s]
                          [-t THREADS]
                          [input_file] [output_file]

Convert file from '('BAM',)' to '('SAM',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{picard,pysam,sambamba,samtools}], --method [{picard,pysam,sambamba,samtools}]
                        The method to use to do the conversion. (default:
                        sambamba)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bam2tsv

### Tool Description
Convert file from ('BAM',) to ('TSV',) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bam2tsv [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{pysam,samtools}]] [-s]
                          [input_file] [output_file]

Convert file from '('BAM',)' to '('TSV',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pysam,samtools}], --method [{pysam,samtools}]
                        The method to use to do the conversion. (default:
                        samtools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bam2wiggle

### Tool Description
Convert file from '('BAM',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bam2wiggle [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS] [-m [{wiggletools}]]
                             [-s]
                             [input_file] [output_file]

Convert file from '('BAM',)' to '('WIGGLE',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{wiggletools}], --method [{wiggletools}]
                        The method to use to do the conversion. (default:
                        wiggletools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bcf2vcf

### Tool Description
Convert file from '('BCF',)' to '('VCF',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bcf2vcf [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{bcftools}]] [-s]
                          [input_file] [output_file]

Convert file from '('BCF',)' to '('VCF',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bcftools}], --method [{bcftools}]
                        The method to use to do the conversion. (default:
                        bcftools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bcf2wiggle

### Tool Description
Convert file from '('BCF',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bcf2wiggle [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS] [-m [{wiggletools}]]
                             [-s]
                             [input_file] [output_file]

Convert file from '('BCF',)' to '('WIGGLE',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{wiggletools}], --method [{wiggletools}]
                        The method to use to do the conversion. (default:
                        wiggletools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bed2wiggle

### Tool Description
Convert file from '('BED',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bed2wiggle [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS] [-m [{wiggletools}]]
                             [-s]
                             [input_file] [output_file]

Convert file from '('BED',)' to '('WIGGLE',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{wiggletools}], --method [{wiggletools}]
                        The method to use to do the conversion. (default:
                        wiggletools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bedgraph2bigwig

### Tool Description
Convert file from '('BEDGRAPH',)' to '('BIGWIG',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bedgraph2bigwig [-h] [-f]
                                  [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                  [--raise-exception] [-X] [-b]
                                  [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                  [--benchmark-mode BENCHMARK_MODE]
                                  [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                  [-a] [-e EXTRA_ARGUMENTS] [-m [{ucsc}]] [-s]
                                  [--chrom-sizes CHROM_SIZES]
                                  [input_file] [output_file]

Convert file from '('BEDGRAPH',)' to '('BIGWIG',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{ucsc}], --method [{ucsc}]
                        The method to use to do the conversion. (default:
                        ucsc)
  -s, --show-methods    A converter may have several methods (default: False)
  --chrom-sizes CHROM_SIZES
                        a two-column file/URL: <chromosome name> <size in
                        bases> (default: None)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bedgraph2cov

### Tool Description
Convert file from ('BEDGRAPH',) to ('COV',) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bedgraph2cov [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS] [-m [{python}]] [-s]
                               [input_file] [output_file]

Convert file from '('BEDGRAPH',)' to '('COV',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{python}], --method [{python}]
                        The method to use to do the conversion. (default:
                        python)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bedgraph2wiggle

### Tool Description
Convert file from ('BEDGRAPH',) to ('WIGGLE',) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bedgraph2wiggle [-h] [-f]
                                  [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                  [--raise-exception] [-X] [-b]
                                  [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                  [--benchmark-mode BENCHMARK_MODE]
                                  [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                  [-a] [-e EXTRA_ARGUMENTS]
                                  [-m [{wiggletools}]] [-s]
                                  [input_file] [output_file]

Convert file from '('BEDGRAPH',)' to '('WIGGLE',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{wiggletools}], --method [{wiggletools}]
                        The method to use to do the conversion. (default:
                        wiggletools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bigbed2bed

### Tool Description
Convert file from ('BIGBED',) to ('BED',) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bigbed2bed [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS] [-m [{pybigwig}]] [-s]
                             [input_file] [output_file]

Convert file from '('BIGBED',)' to '('BED',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pybigwig}], --method [{pybigwig}]
                        The method to use to do the conversion. (default:
                        pybigwig)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bigbed2wiggle

### Tool Description
Convert file from '('BIGBED',)' to '('WIGGLE',)' format. See
bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bigbed2wiggle [-h] [-f]
                                [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                                [-T BENCHMARK_TAG] [-I]
                                [--benchmark-mode BENCHMARK_MODE]
                                [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                [-a] [-e EXTRA_ARGUMENTS] [-m [{wiggletools}]]
                                [-s]
                                [input_file] [output_file]

Convert file from '('BIGBED',)' to '('WIGGLE',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{wiggletools}], --method [{wiggletools}]
                        The method to use to do the conversion. (default:
                        wiggletools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bigwig2bedgraph

### Tool Description
Convert file from '('BIGWIG',)' to '('BEDGRAPH',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bigwig2bedgraph [-h] [-f]
                                  [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                  [--raise-exception] [-X] [-b]
                                  [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                  [--benchmark-mode BENCHMARK_MODE]
                                  [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                  [-a] [-e EXTRA_ARGUMENTS]
                                  [-m [{pybigwig,ucsc}]] [-s]
                                  [input_file] [output_file]

Convert file from '('BIGWIG',)' to '('BEDGRAPH',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pybigwig,ucsc}], --method [{pybigwig,ucsc}]
                        The method to use to do the conversion. (default:
                        pybigwig)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bigwig2wiggle

### Tool Description
Convert file from '('BIGWIG',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bigwig2wiggle [-h] [-f]
                                [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                                [-T BENCHMARK_TAG] [-I]
                                [--benchmark-mode BENCHMARK_MODE]
                                [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                [-a] [-e EXTRA_ARGUMENTS] [-m [{wiggletools}]]
                                [-s]
                                [input_file] [output_file]

Convert file from '('BIGWIG',)' to '('WIGGLE',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{wiggletools}], --method [{wiggletools}]
                        The method to use to do the conversion. (default:
                        wiggletools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bplink2plink

### Tool Description
Convert file from '('BPLINK',)' to '('PLINK',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bplink2plink [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS] [-m [{plink}]] [-s]
                               [input_file] [output_file]

Convert file from '('BPLINK',)' to '('PLINK',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{plink}], --method [{plink}]
                        The method to use to do the conversion. (default:
                        plink)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bplink2vcf

### Tool Description
Convert file from '('BPLINK',)' to '('VCF',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bplink2vcf [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS] [-m [{plink}]] [-s]
                             [input_file] [output_file]

Convert file from '('BPLINK',)' to '('VCF',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{plink}], --method [{plink}]
                        The method to use to do the conversion. (default:
                        plink)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_bz22gz

### Tool Description
Convert file from '('BZ2',)' to '('GZ',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert bz22gz [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                         [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                         [-T BENCHMARK_TAG] [-I]
                         [--benchmark-mode BENCHMARK_MODE]
                         [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                         [-e EXTRA_ARGUMENTS] [-m [{bz2_gz,python}]] [-s]
                         [-t THREADS]
                         [input_file] [output_file]

Convert file from '('BZ2',)' to '('GZ',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bz2_gz,python}], --method [{bz2_gz,python}]
                        The method to use to do the conversion. (default:
                        bz2_gz)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_clustal2phylip

### Tool Description
Convert file from '('CLUSTAL',)' to '('PHYLIP',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert clustal2phylip [-h] [-f]
                                 [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                 [--raise-exception] [-X] [-b]
                                 [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                 [--benchmark-mode BENCHMARK_MODE]
                                 [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                 [-a] [-e EXTRA_ARGUMENTS]
                                 [-m [{biopython,squizz}]] [-s]
                                 [input_file] [output_file]

Convert file from '('CLUSTAL',)' to '('PHYLIP',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,squizz}], --method [{biopython,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_clustal2stockholm

### Tool Description
Convert file from '('CLUSTAL',)' to '('STOCKHOLM',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert clustal2stockholm [-h] [-f]
                                    [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                    [--raise-exception] [-X] [-b]
                                    [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                    [--benchmark-mode BENCHMARK_MODE]
                                    [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                    [-a] [-e EXTRA_ARGUMENTS]
                                    [-m [{biopython,squizz}]] [-s]
                                    [input_file] [output_file]

Convert file from '('CLUSTAL',)' to '('STOCKHOLM',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,squizz}], --method [{biopython,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_cram2bam

### Tool Description
Convert file from '('CRAM',)' to '('BAM',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert cram2bam [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                           [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                           [-T BENCHMARK_TAG] [-I]
                           [--benchmark-mode BENCHMARK_MODE]
                           [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                           [-e EXTRA_ARGUMENTS] [-m [{samtools}]] [-s]
                           [-t THREADS] [--reference REFERENCE]
                           [input_file] [output_file]

Convert file from '('CRAM',)' to '('BAM',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{samtools}], --method [{samtools}]
                        The method to use to do the conversion. (default:
                        samtools)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)
  --reference REFERENCE
                        the reference used (FASTA format). If not provided,
                        prompt will appear (default: None)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_cram2fasta

### Tool Description
Convert file from '('CRAM',)' to '('FASTA',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert cram2fasta [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS] [-m [{samtools}]] [-s]
                             [-t THREADS]
                             [input_file] [output_file]

Convert file from '('CRAM',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{samtools}], --method [{samtools}]
                        The method to use to do the conversion. (default:
                        samtools)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_cram2fastq

### Tool Description
Convert file from '('CRAM',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert cram2fastq [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS] [-m [{samtools}]] [-s]
                             [-t THREADS]
                             [input_file] [output_file]

Convert file from '('CRAM',)' to '('FASTQ',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{samtools}], --method [{samtools}]
                        The method to use to do the conversion. (default:
                        samtools)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_cram2sam

### Tool Description
Convert file from '('CRAM',)' to '('SAM',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert cram2sam [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                           [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                           [-T BENCHMARK_TAG] [-I]
                           [--benchmark-mode BENCHMARK_MODE]
                           [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                           [-e EXTRA_ARGUMENTS] [-m [{samtools}]] [-s]
                           [-t THREADS] [--reference REFERENCE]
                           [input_file] [output_file]

Convert file from '('CRAM',)' to '('SAM',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{samtools}], --method [{samtools}]
                        The method to use to do the conversion. (default:
                        samtools)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)
  --reference REFERENCE
                        the reference used (FASTA format). If not provided,
                        prompt will appear (default: None)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_csv2tsv

### Tool Description
Convert file from '('CSV',)' to '('TSV',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert csv2tsv [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS]
                          [-m [{pandas,python,python_v2}]] [-s]
                          [--in-sep IN_SEP] [--out-sep OUT_SEP]
                          [--line-terminator LINE_TERMINATOR]
                          [input_file] [output_file]

Convert file from '('CSV',)' to '('TSV',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pandas,python,python_v2}], --method [{pandas,python,python_v2}]
                        The method to use to do the conversion. (default:
                        python)
  -s, --show-methods    A converter may have several methods (default: False)
  --in-sep IN_SEP       The separator used in the input file (default: ,)
  --out-sep OUT_SEP     The separator used in the output file (default: )
  --line-terminator LINE_TERMINATOR
                        The line terminator used in the output file (default:
                        )

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_csv2xls

### Tool Description
Convert file from '('CSV',)' to '('XLS',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert csv2xls [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{pandas,pyexcel}]] [-s]
                          [--sheet-name SHEET_NAME] [--in-sep IN_SEP]
                          [input_file] [output_file]

Convert file from '('CSV',)' to '('XLS',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pandas,pyexcel}], --method [{pandas,pyexcel}]
                        The method to use to do the conversion. (default:
                        pandas)
  -s, --show-methods    A converter may have several methods (default: False)
  --sheet-name SHEET_NAME
                        The name of the sheet to create (default: Sheet 1)
  --in-sep IN_SEP       The separator used in the input file (default: ,)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_dsrc2gz

### Tool Description
Convert file from '('DSRC',)' to '('GZ',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert dsrc2gz [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{dsrcpigz}]] [-s]
                          [-t THREADS]
                          [input_file] [output_file]

Convert file from '('DSRC',)' to '('GZ',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{dsrcpigz}], --method [{dsrcpigz}]
                        The method to use to do the conversion. (default:
                        dsrcpigz)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_embl2fasta

### Tool Description
Convert file from '('EMBL',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert embl2fasta [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS]
                             [-m [{biopython,squizz}]] [-s]
                             [input_file] [output_file]

Convert file from '('EMBL',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,squizz}], --method [{biopython,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_embl2genbank

### Tool Description
Convert file from ('EMBL',) to ('GENBANK',) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert embl2genbank [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS]
                               [-m [{biopython,squizz}]] [-s]
                               [input_file] [output_file]

Convert file from '('EMBL',)' to '('GENBANK',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,squizz}], --method [{biopython,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fast52pod5

### Tool Description
Convert file from '('FAST5',)' to '('POD5',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fast52pod5 [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS] [-m [{}]] [-s]
                             [-t THREADS]
                             [input_file] [output_file]

Convert file from '('FAST5',)' to '('POD5',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{}], --method [{}]
                        The method to use to do the conversion. (default:
                        pod5)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fasta2clustal

### Tool Description
Convert file from '('FASTA',)' to '('CLUSTAL',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fasta2clustal [-h] [-f]
                                [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                                [-T BENCHMARK_TAG] [-I]
                                [--benchmark-mode BENCHMARK_MODE]
                                [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                [-a] [-e EXTRA_ARGUMENTS]
                                [-m [{biopython,goalign,squizz}]] [-s]
                                [input_file] [output_file]

Convert file from '('FASTA',)' to '('CLUSTAL',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,goalign,squizz}], --method [{biopython,goalign,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fasta2faa

### Tool Description
Convert file from '('FASTA',)' to '('FAA',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fasta2faa [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{bioconvert}]] [-s]
                            [input_file] [output_file]

Convert file from '('FASTA',)' to '('FAA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bioconvert}], --method [{bioconvert}]
                        The method to use to do the conversion. (default:
                        bioconvert)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fasta2fasta_agp

### Tool Description
Convert file from '('FASTA',)' to '('FASTA', 'AGP')' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fasta2fasta_agp [-h] [-f]
                                  [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                  [--raise-exception] [-X] [-b]
                                  [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                  [--benchmark-mode BENCHMARK_MODE]
                                  [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                  [-a] [-e EXTRA_ARGUMENTS] [-m [{python}]]
                                  [-s]
                                  [--min-scaffold-length MIN_SCAFFOLD_LENGTH]
                                  [--min-stretch-of-N MIN_STRETCH_OF_N]
                                  input_file output_file output_file

Convert file from '('FASTA',)' to '('FASTA', 'AGP')' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            Path to the input scaffold FASTA file.
  output_file           contig FASTA file followed by the AGP file.

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{python}], --method [{python}]
                        The method to use to do the conversion. (default:
                        python)
  -s, --show-methods    A converter may have several methods (default: False)
  --min-scaffold-length MIN_SCAFFOLD_LENGTH
                        minimum scaffold length (default: 200)
  --min-stretch-of-N MIN_STRETCH_OF_N
                        minimum stretch of Ns to split a scaffold (default:
                        10)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fasta2fastq

### Tool Description
Convert file from '('FASTA',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fasta2fastq [-h] [-f]
                              [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                              [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                              [-T BENCHMARK_TAG] [-I]
                              [--benchmark-mode BENCHMARK_MODE]
                              [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                              [-a] [-e EXTRA_ARGUMENTS] [-m [{pysam}]] [-s]
                              [input_file] [output_file]

Convert file from '('FASTA',)' to '('FASTQ',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pysam}], --method [{pysam}]
                        The method to use to do the conversion. (default:
                        pysam)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fasta2genbank

### Tool Description
Convert file from '('FASTA',)' to '('GENBANK',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fasta2genbank [-h] [-f]
                                [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                                [-T BENCHMARK_TAG] [-I]
                                [--benchmark-mode BENCHMARK_MODE]
                                [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                [-a] [-e EXTRA_ARGUMENTS]
                                [-m [{bioconvert,biopython,squizz}]] [-s]
                                [input_file] [output_file]

Convert file from '('FASTA',)' to '('GENBANK',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bioconvert,biopython,squizz}], --method [{bioconvert,biopython,squizz}]
                        The method to use to do the conversion. (default:
                        bioconvert)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fasta2nexus

### Tool Description
Convert file from '('FASTA',)' to '('NEXUS',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fasta2nexus [-h] [-f]
                              [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                              [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                              [-T BENCHMARK_TAG] [-I]
                              [--benchmark-mode BENCHMARK_MODE]
                              [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                              [-a] [-e EXTRA_ARGUMENTS] [-m [{goalign}]] [-s]
                              [input_file] [output_file]

Convert file from '('FASTA',)' to '('NEXUS',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{goalign}], --method [{goalign}]
                        The method to use to do the conversion. (default:
                        goalign)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fasta2phylip

### Tool Description
Convert file from '('FASTA',)' to '('PHYLIP',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fasta2phylip [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS]
                               [-m [{biopython,goalign,squizz}]] [-s]
                               [input_file] [output_file]

Convert file from '('FASTA',)' to '('PHYLIP',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,goalign,squizz}], --method [{biopython,goalign,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fasta2twobit

### Tool Description
Convert file from '('FASTA',)' to '('TWOBIT',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fasta2twobit [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS] [-m [{ucsc}]] [-s]
                               [input_file] [output_file]

Convert file from '('FASTA',)' to '('TWOBIT',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{ucsc}], --method [{ucsc}]
                        The method to use to do the conversion. (default:
                        ucsc)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fasta_qual2fastq

### Tool Description
Convert file from '(FASTA', 'QUAL')' to '(FASTQ',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fasta_qual2fastq [-h] [-f]
                                   [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                   [--raise-exception] [-X] [-b]
                                   [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                   [--benchmark-mode BENCHMARK_MODE]
                                   [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                   [-a] [-e EXTRA_ARGUMENTS] [-m [{pysam}]]
                                   [-s]
                                   input_file input_file output_file

Convert file from '('FASTA', 'QUAL')' to '('FASTQ',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert.
  output_file           The path where the result will be stored.

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pysam}], --method [{pysam}]
                        The method to use to do the conversion. (default:
                        pysam)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fastq2fasta

### Tool Description
Convert file from (FASTQ,) to (FASTA,) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fastq2fasta [-h] [-f]
                              [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                              [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                              [-T BENCHMARK_TAG] [-I]
                              [--benchmark-mode BENCHMARK_MODE]
                              [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                              [-a] [-e EXTRA_ARGUMENTS]
                              [-m [{awk,bioconvert,mappy,mawk,perl,readfq,sed,seqkit,seqtk}]]
                              [-s] [-t THREADS]
                              [input_file] [output_file]

Convert file from '('FASTQ',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{awk,bioconvert,mappy,mawk,perl,readfq,sed,seqkit,seqtk}], --method [{awk,bioconvert,mappy,mawk,perl,readfq,sed,seqkit,seqtk}]
                        The method to use to do the conversion. (default:
                        bioconvert)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_fastq2fasta_qual

### Tool Description
Convert file from '('FASTQ',)' to '('FASTA', 'QUAL')' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert fastq2fasta_qual [-h] [-f]
                                   [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                   [--raise-exception] [-X] [-b]
                                   [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                   [--benchmark-mode BENCHMARK_MODE]
                                   [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                   [-a] [-e EXTRA_ARGUMENTS]
                                   [-m [{bioconvert}]] [-s]
                                   input_file output_file output_file

Convert file from '('FASTQ',)' to '('FASTA', 'QUAL')' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert.
  output_file           The path where the result will be stored.

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bioconvert}], --method [{bioconvert}]
                        The method to use to do the conversion. (default:
                        bioconvert)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_genbank2embl

### Tool Description
Convert file from '('GENBANK',)' to '('EMBL',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert genbank2embl [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS]
                               [-m [{biopython,squizz}]] [-s]
                               [input_file] [output_file]

Convert file from '('GENBANK',)' to '('EMBL',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,squizz}], --method [{biopython,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_gff32gff2

### Tool Description
Convert file from '('GFF3',)' to '('GFF2',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert gff32gff2 [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{bioconvert}]] [-s]
                            [input_file] [output_file]

Convert file from '('GFF3',)' to '('GFF2',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bioconvert}], --method [{bioconvert}]
                        The method to use to do the conversion. (default:
                        bioconvert)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_gff32gtf

### Tool Description
Convert file from ('GFF3',) to ('GTF',) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert gff32gtf [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                           [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                           [-T BENCHMARK_TAG] [-I]
                           [--benchmark-mode BENCHMARK_MODE]
                           [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                           [-e EXTRA_ARGUMENTS] [-m [{gffread}]] [-s]
                           [input_file] [output_file]

Convert file from '('GFF3',)' to '('GTF',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{gffread}], --method [{gffread}]
                        The method to use to do the conversion. (default:
                        gffread)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_gz2bz2

### Tool Description
Convert file from '('GZ',)' to '('BZ2',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert gz2bz2 [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                         [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                         [-T BENCHMARK_TAG] [-I]
                         [--benchmark-mode BENCHMARK_MODE]
                         [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                         [-e EXTRA_ARGUMENTS]
                         [-m [{gunzip_bzip2,pigz_pbzip2,python}]] [-s]
                         [-t THREADS]
                         [input_file] [output_file]

Convert file from '('GZ',)' to '('BZ2',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{gunzip_bzip2,pigz_pbzip2,python}], --method [{gunzip_bzip2,pigz_pbzip2,python}]
                        The method to use to do the conversion. (default:
                        pigz_pbzip2)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_gz2dsrc

### Tool Description
Convert file from '('GZ',)' to '('DSRC',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert gz2dsrc [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{pigzdsrc}]] [-s]
                          [-t THREADS]
                          [input_file] [output_file]

Convert file from '('GZ',)' to '('DSRC',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pigzdsrc}], --method [{pigzdsrc}]
                        The method to use to do the conversion. (default:
                        pigzdsrc)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_json2yaml

### Tool Description
Convert file from '('JSON',)' to '('YAML',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert json2yaml [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{yaml}]] [-s]
                            [input_file] [output_file]

Convert file from '('JSON',)' to '('YAML',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{yaml}], --method [{yaml}]
                        The method to use to do the conversion. (default:
                        yaml)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_maf2sam

### Tool Description
Convert file from '('MAF',)' to '('SAM',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert maf2sam [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{python}]] [-s]
                          [input_file] [output_file]

Convert file from '('MAF',)' to '('SAM',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{python}], --method [{python}]
                        The method to use to do the conversion. (default:
                        python)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_newick2nexus

### Tool Description
Convert file from '('NEWICK',)' to '('NEXUS',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert newick2nexus [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS] [-m [{gotree}]] [-s]
                               [input_file] [output_file]

Convert file from '('NEWICK',)' to '('NEXUS',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{gotree}], --method [{gotree}]
                        The method to use to do the conversion. (default:
                        gotree)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_newick2phyloxml

### Tool Description
Convert file from '('NEWICK',)' to '('PHYLOXML',)' format. See
bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert newick2phyloxml [-h] [-f]
                                  [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                  [--raise-exception] [-X] [-b]
                                  [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                  [--benchmark-mode BENCHMARK_MODE]
                                  [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                  [-a] [-e EXTRA_ARGUMENTS] [-m [{gotree}]]
                                  [-s]
                                  [input_file] [output_file]

Convert file from '('NEWICK',)' to '('PHYLOXML',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{gotree}], --method [{gotree}]
                        The method to use to do the conversion. (default:
                        gotree)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_nexus2clustal

### Tool Description
Convert file from '(NEXUS,)' to '(CLUSTAL,)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert nexus2clustal [-h] [-f]
                                [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                                [-T BENCHMARK_TAG] [-I]
                                [--benchmark-mode BENCHMARK_MODE]
                                [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                [-a] [-e EXTRA_ARGUMENTS]
                                [-m [{biopython,goalign,squizz}]] [-s]
                                [input_file] [output_file]

Convert file from '('NEXUS',)' to '('CLUSTAL',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,goalign,squizz}], --method [{biopython,goalign,squizz}]
                        The method to use to do the conversion. (default:
                        goalign)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_nexus2fasta

### Tool Description
Convert file from '('NEXUS',)' to '('FASTA',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert nexus2fasta [-h] [-f]
                              [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                              [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                              [-T BENCHMARK_TAG] [-I]
                              [--benchmark-mode BENCHMARK_MODE]
                              [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                              [-a] [-e EXTRA_ARGUMENTS]
                              [-m [{biopython,goalign,squizz}]] [-s]
                              [input_file] [output_file]

Convert file from '('NEXUS',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,goalign,squizz}], --method [{biopython,goalign,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_nexus2newick

### Tool Description
Convert file from '('NEXUS',)' to '('NEWICK',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert nexus2newick [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS]
                               [-m [{biopython,gotree}]] [-s]
                               [input_file] [output_file]

Convert file from '('NEXUS',)' to '('NEWICK',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,gotree}], --method [{biopython,gotree}]
                        The method to use to do the conversion. (default:
                        gotree)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_nexus2phylip

### Tool Description
Convert file from (NEXUS,) to (PHYLIP,) format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert nexus2phylip [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS] [-m [{goalign}]] [-s]
                               [input_file] [output_file]

Convert file from '('NEXUS',)' to '('PHYLIP',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{goalign}], --method [{goalign}]
                        The method to use to do the conversion. (default:
                        goalign)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_nexus2phyloxml

### Tool Description
Convert file from '('NEXUS',)' to '('PHYLOXML',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert nexus2phyloxml [-h] [-f]
                                 [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                 [--raise-exception] [-X] [-b]
                                 [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                 [--benchmark-mode BENCHMARK_MODE]
                                 [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                 [-a] [-e EXTRA_ARGUMENTS] [-m [{gotree}]]
                                 [-s]
                                 [input_file] [output_file]

Convert file from '('NEXUS',)' to '('PHYLOXML',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{gotree}], --method [{gotree}]
                        The method to use to do the conversion. (default:
                        gotree)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_ods2csv

### Tool Description
Convert file from '('ODS',)' to '('CSV',)' format. See
bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert ods2csv [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{pyexcel}]] [-s]
                          [--sheet-name SHEET_NAME] [--out-sep OUT_SEP]
                          [--line-terminator LINE_TERMINATOR]
                          [input_file] [output_file]

Convert file from '('ODS',)' to '('CSV',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pyexcel}], --method [{pyexcel}]
                        The method to use to do the conversion. (default:
                        pyexcel)
  -s, --show-methods    A converter may have several methods (default: False)
  --sheet-name SHEET_NAME
                        The name or id of the sheet to convert (default: 0)
  --out-sep OUT_SEP     The separator used in the output file (default: ,)
  --line-terminator LINE_TERMINATOR
                        The line terminator used in the output file (default:
                        )

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_pdb2faa

### Tool Description
Convert file from '('PDB',)' to '('FAA',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert pdb2faa [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{bioconvert}]] [-s]
                          [input_file] [output_file]

Convert file from '('PDB',)' to '('FAA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bioconvert}], --method [{bioconvert}]
                        The method to use to do the conversion. (default:
                        bioconvert)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_phylip2clustal

### Tool Description
Convert file from '('PHYLIP',)' to '('CLUSTAL',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert phylip2clustal [-h] [-f]
                                 [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                 [--raise-exception] [-X] [-b]
                                 [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                 [--benchmark-mode BENCHMARK_MODE]
                                 [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                 [-a] [-e EXTRA_ARGUMENTS]
                                 [-m [{biopython,squizz}]] [-s]
                                 [input_file] [output_file]

Convert file from '('PHYLIP',)' to '('CLUSTAL',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,squizz}], --method [{biopython,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_phylip2fasta

### Tool Description
Convert file from '('PHYLIP',)' to '('FASTA',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert phylip2fasta [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS]
                               [-m [{biopython,goalign,squizz}]] [-s]
                               [input_file] [output_file]

Convert file from '('PHYLIP',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,goalign,squizz}], --method [{biopython,goalign,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_phylip2nexus

### Tool Description
Convert file from '('PHYLIP',)' to '('NEXUS',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert phylip2nexus [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS] [-m [{goalign}]] [-s]
                               [input_file] [output_file]

Convert file from '('PHYLIP',)' to '('NEXUS',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{goalign}], --method [{goalign}]
                        The method to use to do the conversion. (default:
                        goalign)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_phylip2stockholm

### Tool Description
Convert file from '('PHYLIP',)' to '('STOCKHOLM',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert phylip2stockholm [-h] [-f]
                                   [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                   [--raise-exception] [-X] [-b]
                                   [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                   [--benchmark-mode BENCHMARK_MODE]
                                   [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                   [-a] [-e EXTRA_ARGUMENTS]
                                   [-m [{biopython,squizz}]] [-s]
                                   [input_file] [output_file]

Convert file from '('PHYLIP',)' to '('STOCKHOLM',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,squizz}], --method [{biopython,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_phylip2xmfa

### Tool Description
Convert file from '('PHYLIP',)' to '('XMFA',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert phylip2xmfa [-h] [-f]
                              [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                              [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                              [-T BENCHMARK_TAG] [-I]
                              [--benchmark-mode BENCHMARK_MODE]
                              [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                              [-a] [-e EXTRA_ARGUMENTS] [-m [{biopython}]]
                              [-s]
                              [input_file] [output_file]

Convert file from '('PHYLIP',)' to '('XMFA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython}], --method [{biopython}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_phyloxml2newick

### Tool Description
Convert file from '('PHYLOXML',)' to '('NEWICK',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert phyloxml2newick [-h] [-f]
                                  [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                  [--raise-exception] [-X] [-b]
                                  [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                  [--benchmark-mode BENCHMARK_MODE]
                                  [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                  [-a] [-e EXTRA_ARGUMENTS] [-m [{gotree}]]
                                  [-s]
                                  [input_file] [output_file]

Convert file from '('PHYLOXML',)' to '('NEWICK',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{gotree}], --method [{gotree}]
                        The method to use to do the conversion. (default:
                        gotree)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_phyloxml2nexus

### Tool Description
Convert file from '('PHYLOXML',)' to '('NEXUS',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert phyloxml2nexus [-h] [-f]
                                 [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                 [--raise-exception] [-X] [-b]
                                 [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                 [--benchmark-mode BENCHMARK_MODE]
                                 [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                 [-a] [-e EXTRA_ARGUMENTS] [-m [{gotree}]]
                                 [-s]
                                 [input_file] [output_file]

Convert file from '('PHYLOXML',)' to '('NEXUS',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{gotree}], --method [{gotree}]
                        The method to use to do the conversion. (default:
                        gotree)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_plink2bplink

### Tool Description
Convert file from '('PLINK',)' to '('BPLINK',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert plink2bplink [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS] [-m [{plink}]] [-s]
                               [input_file] [output_file]

Convert file from '('PLINK',)' to '('BPLINK',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{plink}], --method [{plink}]
                        The method to use to do the conversion. (default:
                        plink)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_plink2vcf

### Tool Description
Convert file from '('PLINK',)' to '('VCF',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert plink2vcf [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{plink}]] [-s]
                            [input_file] [output_file]

Convert file from '('PLINK',)' to '('VCF',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{plink}], --method [{plink}]
                        The method to use to do the conversion. (default:
                        plink)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_sam2bam

### Tool Description
Convert file from '('SAM',)' to '('BAM',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert sam2bam [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{samtools}]] [-s]
                          [-t THREADS]
                          [input_file] [output_file]

Convert file from '('SAM',)' to '('BAM',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{samtools}], --method [{samtools}]
                        The method to use to do the conversion. (default:
                        samtools)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_sam2cram

### Tool Description
Convert file from '('SAM',)' to '('CRAM',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert sam2cram [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                           [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                           [-T BENCHMARK_TAG] [-I]
                           [--benchmark-mode BENCHMARK_MODE]
                           [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                           [-e EXTRA_ARGUMENTS] [-m [{samtools}]] [-s]
                           [-t THREADS] [--reference REFERENCE]
                           [input_file] [output_file]

Convert file from '('SAM',)' to '('CRAM',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{samtools}], --method [{samtools}]
                        The method to use to do the conversion. (default:
                        samtools)
  -s, --show-methods    A converter may have several methods (default: False)
  -t THREADS, --threads THREADS
                        threads to be used (default: 4)
  --reference REFERENCE
                        reference used (default: None)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_sam2paf

### Tool Description
Convert file from '('SAM',)' to '('PAF',)' format. See
bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert sam2paf [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{python}]] [-s]
                          [input_file] [output_file]

Convert file from '('SAM',)' to '('PAF',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{python}], --method [{python}]
                        The method to use to do the conversion. (default:
                        python)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_scf2fasta

### Tool Description
Convert file from '('SCF',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert scf2fasta [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{python}]] [-s]
                            [input_file] [output_file]

Convert file from '('SCF',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{python}], --method [{python}]
                        The method to use to do the conversion. (default:
                        python)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_scf2fastq

### Tool Description
Convert file from '('SCF',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert scf2fastq [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{python}]] [-s]
                            [input_file] [output_file]

Convert file from '('SCF',)' to '('FASTQ',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{python}], --method [{python}]
                        The method to use to do the conversion. (default:
                        python)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_sra2fastq

### Tool Description
Convert file from '('SRA',)' to '('FASTQ',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert sra2fastq [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{fastq_dump}]] [-s]
                            [input_file] [output_file]

Convert file from '('SRA',)' to '('FASTQ',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{fastq_dump}], --method [{fastq_dump}]
                        The method to use to do the conversion. (default:
                        fastq_dump)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_stockholm2clustal

### Tool Description
Convert file from '(STOCKHOLM,)' to '(CLUSTAL,)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert stockholm2clustal [-h] [-f]
                                    [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                    [--raise-exception] [-X] [-b]
                                    [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                    [--benchmark-mode BENCHMARK_MODE]
                                    [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                    [-a] [-e EXTRA_ARGUMENTS]
                                    [-m [{biopython,squizz}]] [-s]
                                    [input_file] [output_file]

Convert file from '('STOCKHOLM',)' to '('CLUSTAL',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,squizz}], --method [{biopython,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_stockholm2phylip

### Tool Description
Convert file from '(STOCKHOLM,)' to '(PHYLIP,)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert stockholm2phylip [-h] [-f]
                                   [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                   [--raise-exception] [-X] [-b]
                                   [-N BENCHMARK_N] [-T BENCHMARK_TAG] [-I]
                                   [--benchmark-mode BENCHMARK_MODE]
                                   [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                                   [-a] [-e EXTRA_ARGUMENTS]
                                   [-m [{biopython,squizz}]] [-s]
                                   [input_file] [output_file]

Convert file from '('STOCKHOLM',)' to '('PHYLIP',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython,squizz}], --method [{biopython,squizz}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_tsv2csv

### Tool Description
Convert file from '('TSV',)' to '('CSV',)' format. See
bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert tsv2csv [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS]
                          [-m [{pandas,python,python_v2}]] [-s]
                          [--in-sep IN_SEP] [--out-sep OUT_SEP]
                          [--line-terminator LINE_TERMINATOR]
                          [input_file] [output_file]

Convert file from '('TSV',)' to '('CSV',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pandas,python,python_v2}], --method [{pandas,python,python_v2}]
                        The method to use to do the conversion. (default:
                        python)
  -s, --show-methods    A converter may have several methods (default: False)
  --in-sep IN_SEP       The separator used in the input file (default: )
  --out-sep OUT_SEP     The separator used in the output file (default: ,)
  --line-terminator LINE_TERMINATOR
                        The line terminator used in the output file (default:
                        )

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_twobit2fasta

### Tool Description
Convert file from '('TWOBIT',)' to '('FASTA',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert twobit2fasta [-h] [-f]
                               [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                               [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                               [-T BENCHMARK_TAG] [-I]
                               [--benchmark-mode BENCHMARK_MODE]
                               [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                               [-a] [-e EXTRA_ARGUMENTS] [-m [{py2bit,ucsc}]]
                               [-s]
                               [input_file] [output_file]

Convert file from '('TWOBIT',)' to '('FASTA',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{py2bit,ucsc}], --method [{py2bit,ucsc}]
                        The method to use to do the conversion. (default:
                        py2bit)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_vcf2bcf

### Tool Description
Convert file from '('VCF',)' to '('BCF',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert vcf2bcf [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{bcftools}]] [-s]
                          [input_file] [output_file]

Convert file from '('VCF',)' to '('BCF',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{bcftools}], --method [{bcftools}]
                        The method to use to do the conversion. (default:
                        bcftools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_vcf2bed

### Tool Description
Convert file from '('VCF',)' to '('BED',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert vcf2bed [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{awk}]] [-s]
                          [input_file] [output_file]

Convert file from '('VCF',)' to '('BED',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{awk}], --method [{awk}]
                        The method to use to do the conversion. (default: awk)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_vcf2bplink

### Tool Description
Convert file from '('VCF',)' to '('BPLINK',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert vcf2bplink [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS] [-m [{plink}]] [-s]
                             [input_file] [output_file]

Convert file from '('VCF',)' to '('BPLINK',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{plink}], --method [{plink}]
                        The method to use to do the conversion. (default:
                        plink)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_vcf2plink

### Tool Description
Convert file from '('VCF',)' to '('PLINK',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert vcf2plink [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                            [-T BENCHMARK_TAG] [-I]
                            [--benchmark-mode BENCHMARK_MODE]
                            [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                            [-a] [-e EXTRA_ARGUMENTS] [-m [{plink}]] [-s]
                            [input_file] [output_file]

Convert file from '('VCF',)' to '('PLINK',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{plink}], --method [{plink}]
                        The method to use to do the conversion. (default:
                        plink)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_vcf2wiggle

### Tool Description
Convert file from '('VCF',)' to '('WIGGLE',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert vcf2wiggle [-h] [-f]
                             [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                             [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                             [-T BENCHMARK_TAG] [-I]
                             [--benchmark-mode BENCHMARK_MODE]
                             [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                             [-a] [-e EXTRA_ARGUMENTS] [-m [{wiggletools}]]
                             [-s]
                             [input_file] [output_file]

Convert file from '('VCF',)' to '('WIGGLE',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{wiggletools}], --method [{wiggletools}]
                        The method to use to do the conversion. (default:
                        wiggletools)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_wig2bed

### Tool Description
Convert file from '('WIG',)' to '('BED',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert wig2bed [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{wig2bed}]] [-s]
                          [input_file] [output_file]

Convert file from '('WIG',)' to '('BED',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{wig2bed}], --method [{wig2bed}]
                        The method to use to do the conversion. (default:
                        wig2bed)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_xls2csv

### Tool Description
Convert file from '('XLS',)' to '('CSV',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert xls2csv [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                          [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                          [-T BENCHMARK_TAG] [-I]
                          [--benchmark-mode BENCHMARK_MODE]
                          [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                          [-e EXTRA_ARGUMENTS] [-m [{pandas,pyexcel}]] [-s]
                          [--sheet-name SHEET_NAME] [--out-sep OUT_SEP]
                          [--line-terminator LINE_TERMINATOR]
                          [input_file] [output_file]

Convert file from '('XLS',)' to '('CSV',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pandas,pyexcel}], --method [{pandas,pyexcel}]
                        The method to use to do the conversion. (default:
                        pandas)
  -s, --show-methods    A converter may have several methods (default: False)
  --sheet-name SHEET_NAME
                        The name or id of the sheet to convert (default: 0)
  --out-sep OUT_SEP     The separator used in the output file (default: ,)
  --line-terminator LINE_TERMINATOR
                        The line terminator used in the output file (default:
                        )

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_xlsx2csv

### Tool Description
Convert file from '('XLSX',)' to '('CSV',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert xlsx2csv [-h] [-f] [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                           [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                           [-T BENCHMARK_TAG] [-I]
                           [--benchmark-mode BENCHMARK_MODE]
                           [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]] [-a]
                           [-e EXTRA_ARGUMENTS] [-m [{pandas,pyexcel}]] [-s]
                           [--sheet-name SHEET_NAME] [--out-sep OUT_SEP]
                           [--line-terminator LINE_TERMINATOR]
                           [input_file] [output_file]

Convert file from '('XLSX',)' to '('CSV',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{pandas,pyexcel}], --method [{pandas,pyexcel}]
                        The method to use to do the conversion. (default:
                        pandas)
  -s, --show-methods    A converter may have several methods (default: False)
  --sheet-name SHEET_NAME
                        The name or id of the sheet to convert (default: 0)
  --out-sep OUT_SEP     The separator used in the output file (default: ,)
  --line-terminator LINE_TERMINATOR
                        The line terminator used in the output file (default:
                        )

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```


## bioconvert_xmfa2phylip

### Tool Description
Convert file from '('XMFA',)' to '('PHYLIP',)' format. See bioconvert.readthedocs.io for details

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
- **Homepage**: http://bioconvert.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconvert/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconvert xmfa2phylip [-h] [-f]
                              [-v {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                              [--raise-exception] [-X] [-b] [-N BENCHMARK_N]
                              [-T BENCHMARK_TAG] [-I]
                              [--benchmark-mode BENCHMARK_MODE]
                              [-M BENCHMARK_METHODS [BENCHMARK_METHODS ...]]
                              [-a] [-e EXTRA_ARGUMENTS] [-m [{biopython}]]
                              [-s]
                              [input_file] [output_file]

Convert file from '('XMFA',)' to '('PHYLIP',)' format. See
bioconvert.readthedocs.io for details

positional arguments:
  input_file            The path to the file to convert. (default: None)
  output_file           The path where the result will be stored. (default:
                        None)

options:
  -h, --help            show this help message and exit
  -f, --force           if outfile exists, it is overwritten with this option
                        (default: False)
  -v {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --verbosity {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the outpout verbosity. (default: ERROR)
  --raise-exception     Let exception ending the execution be raised and
                        displayed (default: False)
  -X, --batch           Allow conversion of a set of files using wildcards.
                        You must use quotes to escape the wildcards. For
                        instance: --batch 'test*fastq' (default: False)
  -b, --benchmark       Running all available methods (default: False)
  -N BENCHMARK_N, --benchmark-N BENCHMARK_N
                        Number of trials for each methods (default: 5)
  -T BENCHMARK_TAG, --benchmark-tag BENCHMARK_TAG
                        Save results (json and image) named after this tag.
                        You may include sub directories (default: bioconvert)
  -I, --benchmark-save-image
                        Save results as an image (using the same tag as from
                        --benchmark-tag) (default: False)
  --benchmark-mode BENCHMARK_MODE
                        Set the mode of the benchmark, which can be time, CPU
                        or memory. Defaults to time) (default: time)
  -M BENCHMARK_METHODS [BENCHMARK_METHODS ...], --benchmark-methods BENCHMARK_METHODS [BENCHMARK_METHODS ...]
                        Methods to include. Provide list as space-separated
                        method names. Use -s to get the full list. (default:
                        all)
  -a, --allow-indirect-conversion
                        Allow to chain converter when direct conversion is
                        absent (default: False)
  -e EXTRA_ARGUMENTS, --extra-arguments EXTRA_ARGUMENTS
                        Any arguments accepted by the method's tool (default:
                        )
  -m [{biopython}], --method [{biopython}]
                        The method to use to do the conversion. (default:
                        biopython)
  -s, --show-methods    A converter may have several methods (default: False)

Bioconvert is an open source collaborative project. Please feel free to join
us at https://github/biokit/bioconvert
```

