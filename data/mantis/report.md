# mantis CWL Generation Report

## mantis_build

### Tool Description
Build a CQF (Compressed Quotient Filter) from input filters.

### Metadata
- **Docker Image**: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
- **Homepage**: https://github.com/splatlab/mantis
- **Package**: https://anaconda.org/channels/bioconda/packages/mantis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mantis/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-11-27
- **GitHub**: https://github.com/splatlab/mantis
- **Stars**: N/A
### Original Help Text
```text
SYNOPSIS
        mantis build [-e] -s <log-slots> -i <input_list> -o <build_output>

OPTIONS
        -e, --eqclass_dist
                    write the eqclass abundance distribution

        <log-slots> log of number of slots in the output CQF

        <input_list>
                    file containing list of input filters

        <build_output>
                    directory where results should be written
```


## mantis_mst

### Tool Description
Mantis is a k-mer based de Bruijn graph construction and querying tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
- **Homepage**: https://github.com/splatlab/mantis
- **Package**: https://anaconda.org/channels/bioconda/packages/mantis/overview
- **Validation**: PASS

### Original Help Text
```text
Parsing command line failed with exception: The required input directory --help does not seem to exist.


SYNOPSIS
        mantis build [-e] -s <log-slots> -i <input_list> -o <build_output>
        mantis mst -p <index_prefix> [-t <num_threads>] (-k|-d)
        mantis validatemst -p <index_prefix> -n <num_experiments>
        mantis query [-1] [-j] [-k <kmer>] -p <query_prefix> [-o <output_file>] <query>
        mantis validate -i <input_list> -p <dbg_prefix> <query>
        mantis stats -p <index_prefix> -n <number_of_samples> [-t <type>] [-j <size-of-jmer>]
        mantis help
        mantis -v

OPTIONS
        -e, --eqclass_dist
                    write the eqclass abundance distribution

        <log-slots> log of number of slots in the output CQF

        <input_list>
                    file containing list of input filters

        <build_output>
                    directory where results should be written

        <index_prefix>
                    The directory where the index is stored.

        <num_threads>
                    number of threads

        -k, --keep-RRR
                    Keep the previous color class RRR representation.

        -d, --delete-RRR
                    Remove the previous color class RRR representation.

        <index_prefix>
                    The directory where the index is stored.

        <num_experiments>
                    Number of experiments.

        -1, --use-colorclasses
                    Use color classes as the color info representation instead of MST

        -j, --json  Write the output in JSON format
        <kmer>      size of k for kmer.

        <query_prefix>
                    Prefix of input files.

        <output_file>
                    Where to write query output.

        <query>     Prefix of input files.

        <input_list>
                    file containing list of input filters

        <dbg_prefix>
                    Directory containing the mantis dbg.

        <query>     Query file.

        <index_prefix>
                    The directory where the index is stored.

        <number_of_samples>
                    Number of experiments.

        <type>      what stats? (mono, cc_density, color_dist, jmerkmer), default: mono

        <size-of-jmer>
                    value of j for constituent jmers of a kmer (default: 23).

        -v, --version
                    show version
```


## mantis_validatemst

### Tool Description
Validates the MST structure of the de Bruijn graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
- **Homepage**: https://github.com/splatlab/mantis
- **Package**: https://anaconda.org/channels/bioconda/packages/mantis/overview
- **Validation**: PASS

### Original Help Text
```text
Parsing command line failed with exception: The required input directory --help does not seem to exist.


SYNOPSIS
        mantis build [-e] -s <log-slots> -i <input_list> -o <build_output>
        mantis mst -p <index_prefix> [-t <num_threads>] (-k|-d)
        mantis validatemst -p <index_prefix> -n <num_experiments>
        mantis query [-1] [-j] [-k <kmer>] -p <query_prefix> [-o <output_file>] <query>
        mantis validate -i <input_list> -p <dbg_prefix> <query>
        mantis stats -p <index_prefix> -n <number_of_samples> [-t <type>] [-j <size-of-jmer>]
        mantis help
        mantis -v

OPTIONS
        -e, --eqclass_dist
                    write the eqclass abundance distribution

        <log-slots> log of number of slots in the output CQF

        <input_list>
                    file containing list of input filters

        <build_output>
                    directory where results should be written

        <index_prefix>
                    The directory where the index is stored.

        <num_threads>
                    number of threads

        -k, --keep-RRR
                    Keep the previous color class RRR representation.

        -d, --delete-RRR
                    Remove the previous color class RRR representation.

        <index_prefix>
                    The directory where the index is stored.

        <num_experiments>
                    Number of experiments.

        -1, --use-colorclasses
                    Use color classes as the color info representation instead of MST

        -j, --json  Write the output in JSON format
        <kmer>      size of k for kmer.

        <query_prefix>
                    Prefix of input files.

        <output_file>
                    Where to write query output.

        <query>     Prefix of input files.

        <input_list>
                    file containing list of input filters

        <dbg_prefix>
                    Directory containing the mantis dbg.

        <query>     Query file.

        <index_prefix>
                    The directory where the index is stored.

        <number_of_samples>
                    Number of experiments.

        <type>      what stats? (mono, cc_density, color_dist, jmerkmer), default: mono

        <size-of-jmer>
                    value of j for constituent jmers of a kmer (default: 23).

        -v, --version
                    show version
```


## mantis_query

### Tool Description
Query the de Bruijn graph index.

### Metadata
- **Docker Image**: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
- **Homepage**: https://github.com/splatlab/mantis
- **Package**: https://anaconda.org/channels/bioconda/packages/mantis/overview
- **Validation**: PASS

### Original Help Text
```text
Parsing command line failed with exception: The required input file --help does not seem to exist.


SYNOPSIS
        mantis build [-e] -s <log-slots> -i <input_list> -o <build_output>
        mantis mst -p <index_prefix> [-t <num_threads>] (-k|-d)
        mantis validatemst -p <index_prefix> -n <num_experiments>
        mantis query [-1] [-j] [-k <kmer>] -p <query_prefix> [-o <output_file>] <query>
        mantis validate -i <input_list> -p <dbg_prefix> <query>
        mantis stats -p <index_prefix> -n <number_of_samples> [-t <type>] [-j <size-of-jmer>]
        mantis help
        mantis -v

OPTIONS
        -e, --eqclass_dist
                    write the eqclass abundance distribution

        <log-slots> log of number of slots in the output CQF

        <input_list>
                    file containing list of input filters

        <build_output>
                    directory where results should be written

        <index_prefix>
                    The directory where the index is stored.

        <num_threads>
                    number of threads

        -k, --keep-RRR
                    Keep the previous color class RRR representation.

        -d, --delete-RRR
                    Remove the previous color class RRR representation.

        <index_prefix>
                    The directory where the index is stored.

        <num_experiments>
                    Number of experiments.

        -1, --use-colorclasses
                    Use color classes as the color info representation instead of MST

        -j, --json  Write the output in JSON format
        <kmer>      size of k for kmer.

        <query_prefix>
                    Prefix of input files.

        <output_file>
                    Where to write query output.

        <query>     Prefix of input files.

        <input_list>
                    file containing list of input filters

        <dbg_prefix>
                    Directory containing the mantis dbg.

        <query>     Query file.

        <index_prefix>
                    The directory where the index is stored.

        <number_of_samples>
                    Number of experiments.

        <type>      what stats? (mono, cc_density, color_dist, jmerkmer), default: mono

        <size-of-jmer>
                    value of j for constituent jmers of a kmer (default: 23).

        -v, --version
                    show version
```


## mantis_validate

### Tool Description
Mantis is a k-mer based sequence analysis tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
- **Homepage**: https://github.com/splatlab/mantis
- **Package**: https://anaconda.org/channels/bioconda/packages/mantis/overview
- **Validation**: PASS

### Original Help Text
```text
Parsing command line failed with exception: The required input file --help does not seem to exist.


SYNOPSIS
        mantis build [-e] -s <log-slots> -i <input_list> -o <build_output>
        mantis mst -p <index_prefix> [-t <num_threads>] (-k|-d)
        mantis validatemst -p <index_prefix> -n <num_experiments>
        mantis query [-1] [-j] [-k <kmer>] -p <query_prefix> [-o <output_file>] <query>
        mantis validate -i <input_list> -p <dbg_prefix> <query>
        mantis stats -p <index_prefix> -n <number_of_samples> [-t <type>] [-j <size-of-jmer>]
        mantis help
        mantis -v

OPTIONS
        -e, --eqclass_dist
                    write the eqclass abundance distribution

        <log-slots> log of number of slots in the output CQF

        <input_list>
                    file containing list of input filters

        <build_output>
                    directory where results should be written

        <index_prefix>
                    The directory where the index is stored.

        <num_threads>
                    number of threads

        -k, --keep-RRR
                    Keep the previous color class RRR representation.

        -d, --delete-RRR
                    Remove the previous color class RRR representation.

        <index_prefix>
                    The directory where the index is stored.

        <num_experiments>
                    Number of experiments.

        -1, --use-colorclasses
                    Use color classes as the color info representation instead of MST

        -j, --json  Write the output in JSON format
        <kmer>      size of k for kmer.

        <query_prefix>
                    Prefix of input files.

        <output_file>
                    Where to write query output.

        <query>     Prefix of input files.

        <input_list>
                    file containing list of input filters

        <dbg_prefix>
                    Directory containing the mantis dbg.

        <query>     Query file.

        <index_prefix>
                    The directory where the index is stored.

        <number_of_samples>
                    Number of experiments.

        <type>      what stats? (mono, cc_density, color_dist, jmerkmer), default: mono

        <size-of-jmer>
                    value of j for constituent jmers of a kmer (default: 23).

        -v, --version
                    show version
```


## mantis_stats

### Tool Description
Mantis is a k-mer based de Bruijn graph construction and querying tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
- **Homepage**: https://github.com/splatlab/mantis
- **Package**: https://anaconda.org/channels/bioconda/packages/mantis/overview
- **Validation**: PASS

### Original Help Text
```text
Parsing command line failed with exception: The required input directory --help does not seem to exist.


SYNOPSIS
        mantis build [-e] -s <log-slots> -i <input_list> -o <build_output>
        mantis mst -p <index_prefix> [-t <num_threads>] (-k|-d)
        mantis validatemst -p <index_prefix> -n <num_experiments>
        mantis query [-1] [-j] [-k <kmer>] -p <query_prefix> [-o <output_file>] <query>
        mantis validate -i <input_list> -p <dbg_prefix> <query>
        mantis stats -p <index_prefix> -n <number_of_samples> [-t <type>] [-j <size-of-jmer>]
        mantis help
        mantis -v

OPTIONS
        -e, --eqclass_dist
                    write the eqclass abundance distribution

        <log-slots> log of number of slots in the output CQF

        <input_list>
                    file containing list of input filters

        <build_output>
                    directory where results should be written

        <index_prefix>
                    The directory where the index is stored.

        <num_threads>
                    number of threads

        -k, --keep-RRR
                    Keep the previous color class RRR representation.

        -d, --delete-RRR
                    Remove the previous color class RRR representation.

        <index_prefix>
                    The directory where the index is stored.

        <num_experiments>
                    Number of experiments.

        -1, --use-colorclasses
                    Use color classes as the color info representation instead of MST

        -j, --json  Write the output in JSON format
        <kmer>      size of k for kmer.

        <query_prefix>
                    Prefix of input files.

        <output_file>
                    Where to write query output.

        <query>     Prefix of input files.

        <input_list>
                    file containing list of input filters

        <dbg_prefix>
                    Directory containing the mantis dbg.

        <query>     Query file.

        <index_prefix>
                    The directory where the index is stored.

        <number_of_samples>
                    Number of experiments.

        <type>      what stats? (mono, cc_density, color_dist, jmerkmer), default: mono

        <size-of-jmer>
                    value of j for constituent jmers of a kmer (default: 23).

        -v, --version
                    show version
```


## Metadata
- **Skill**: generated
