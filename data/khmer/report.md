# khmer CWL Generation Report

## khmer

### Tool Description
The provided text contains system error messages regarding a container runtime failure (no space left on device) and does not contain help documentation or usage instructions for the khmer tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Total Downloads**: 101.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dib-lab/khmer
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2174569568: no space left on device
```


## Metadata
- **Skill**: generated

## khmer_normalize-by-median.py

### Tool Description
The provided text does not contain help information or usage instructions. It appears to be an error log related to a Singularity/Apptainer environment failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3696593123: no space left on device
```

## khmer_load-into-counting.py

### Tool Description
The provided text does not contain help documentation for the tool. It contains system logs and a fatal error message indicating a failure to build the container image due to lack of disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3334130967: no space left on device
```

## khmer_filter-abund.py

### Tool Description
Trim sequences at a minimum k-mer abundance.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter-abund.py [--version] [--info] [-h] [-T THREADS] [-C CUTOFF] [-V]
                       [-Z NORMALIZE_TO] [-o optional_output_filename] [-f]
                       [-q] [--gzip | --bzip]
                       input_count_graph_filename input_sequence_filename
                       [input_sequence_filename ...]

Trim sequences at a minimum k-mer abundance.

positional arguments:
  input_count_graph_filename
                        The input k-mer countgraph filename
  input_sequence_filename
                        Input FAST[AQ] sequence filename

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -T THREADS, --threads THREADS
                        Number of simultaneous threads to execute (default: 1)
  -C CUTOFF, --cutoff CUTOFF
                        Trim at k-mers below this abundance. (default: 2)
  -V, --variable-coverage
                        Only trim low-abundance k-mers from sequences that
                        have high coverage. (default: False)
  -Z NORMALIZE_TO, --normalize-to NORMALIZE_TO
                        Base the variable-coverage cutoff on this median k-mer
                        abundance. (default: 20)
  -o optional_output_filename, --output optional_output_filename
                        Output the trimmed sequences into a single file with
                        the given filename instead of creating a new file for
                        each input file. (default: None)
  -f, --force           Overwrite output file if it exists (default: False)
  -q, --quiet
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)

Trimmed sequences will be placed in "${input_sequence_filename}.abundfilt" for
each input sequence file. If the input sequences are from RNAseq or metagenome
sequencing then `--variable-coverage` should be used.

Example:

    load-into-counting.py -k 20 -x 5e7 countgraph data/100k-filtered.fa
    filter-abund.py -C 2 countgraph data/100k-filtered.fa
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

|| This is the script filter-abund.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * Q Zhang et al., http://dx.doi.org/10.1371/journal.pone.0101271
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_load-graph.py

### Tool Description
The provided text does not contain help information for the tool. It contains system error messages related to a container runtime (Apptainer/Singularity) failing to pull a Docker image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-4285407582: no space left on device
```

## khmer_partition-graph.py

### Tool Description
Partition a sequence graph based upon waypoint connectivity

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: partition-graph.py [--version] [--info] [-h] [-S filename]
                          [-s SUBSET_SIZE] [--no-big-traverse] [-f]
                          [-T THREADS]
                          basename

Partition a sequence graph based upon waypoint connectivity

positional arguments:
  basename              basename of the input k-mer nodegraph + tagset files

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -S filename, --stoptags filename
                        Use stoptags in this file during partitioning
                        (default: )
  -s SUBSET_SIZE, --subset-size SUBSET_SIZE
                        Set subset size (usually 1e5-1e6 is good) (default:
                        100000)
  --no-big-traverse     Truncate graph joins at big traversals (default:
                        False)
  -f, --force           Overwrite output file if it exists (default: False)
  -T THREADS, --threads THREADS
                        Number of simultaneous threads to execute (default: 1)

The resulting partition maps are saved as "${basename}.subset.#.pmap" files.
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

|| This is the script partition-graph.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * J Pell et al., http://dx.doi.org/10.1073/pnas.1121464109
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_merge-partition.py

### Tool Description
The provided text does not contain help information for the tool. It appears to be a system error log related to a container runtime (Singularity/Apptainer) failing due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-4189371579: no space left on device
```

## khmer_extract-partitions.py

### Tool Description
The provided text does not contain help information for the tool. It is an error log indicating a failure to build a Singularity/Apptainer container due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3100002425: no space left on device
```

## khmer_interleave-reads.py

### Tool Description
Produce interleaved files from R1/R2 paired files

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: interleave-reads.py [--version] [--info] [-h] [-o filename]
                           [--no-reformat] [-f] [--gzip | --bzip]
                           left right

Produce interleaved files from R1/R2 paired files

positional arguments:
  left
  right

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -o filename, --output filename
  --no-reformat         Do not reformat read names or enforce consistency
                        (default: False)
  -f, --force           Overwrite output file if it exists (default: False)
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)

The output is an interleaved set of reads, with each read in <R1> paired with a
read in <R2>. By default, the output goes to stdout unless `-o`/`--output` is
specified.

As a "bonus", this file ensures that if read names are not already formatted
properly, they are reformatted consistently, such that they look like the
pre-1.8 Casava format (`@name/1`, `@name/2`). This reformatting can be switched
off with the `--no-reformat` flag.

Example:

    interleave-reads.py tests/test-data/paired.fq.1 \
            tests/test-data/paired.fq.2 -o paired.fq
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

|| This is the script interleave-reads.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_split-paired-reads.py

### Tool Description
The provided text does not contain help information as the tool failed to execute due to a system error (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1381859622: no space left on device
```

## khmer_fastq-to-fasta.py

### Tool Description
Converts FASTQ format (.fq) files to FASTA format (.fa).

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastq-to-fasta.py [--version] [--info] [-h] [-o filename] [-n]
                         [--gzip | --bzip]
                         input_sequence

Converts FASTQ format (.fq) files to FASTA format (.fa).

positional arguments:
  input_sequence        The name of the input FASTQ sequence file.

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -o filename, --output filename
                        The name of the output FASTA sequence file. (default:
                        <_io.TextIOWrapper name='<stdout>' mode='w'
                        encoding='ANSI_X3.4-1968'>)
  -n, --n_keep          Option to keep reads containing 'N's in input_sequence
                        file. Default is to drop reads (default: False)
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

|| This is the script fastq-to-fasta.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
