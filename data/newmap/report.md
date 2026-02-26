# newmap CWL Generation Report

## newmap_index

### Tool Description
Create an index for a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/newmap:0.2--py312h9c9b0c2_1
- **Homepage**: https://github.com/hoffmangroup/newmap
- **Package**: https://anaconda.org/channels/bioconda/packages/newmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/newmap/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-07-07
- **GitHub**: https://github.com/hoffmangroup/newmap
- **Stars**: N/A
### Original Help Text
```text
usage: newmap index [-h] [--output FILE] [--compression-ratio RATIO]
                    [--seed-length LENGTH]
                    fasta_file

positional arguments:
  fasta_file            Reference sequence file in FASTA format

options:
  -h, --help            show this help message and exit
  --output FILE, -i FILE
                        Filename of the index file to write. (default:
                        fasta_file with the extension changed to '.awfmi')

performance tuning arguments:
  --compression-ratio RATIO, -c RATIO
                        Compression ratio for suffix array to be sampled.
                        Larger ratios reduce file size and increase the
                        average number of operations per query. (default: 8)
  --seed-length LENGTH, -s LENGTH
                        Length of k-mers to memoize in a lookup table to speed
                        up searches. Each value increase multiplies memory
                        usage of the index by 4. (default: 12)
```


## newmap_search

### Tool Description
Search for unique k-mers in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/newmap:0.2--py312h9c9b0c2_1
- **Homepage**: https://github.com/hoffmangroup/newmap
- **Package**: https://anaconda.org/channels/bioconda/packages/newmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: newmap search [-h] [--search-range RANGE] [--output-directory DIR]
                     [--include-sequences IDS] [--exclude-sequences IDS]
                     [--verbose] [--initial-search-length LENGTH]
                     [--kmer-batch-size SIZE] [--num-threads NUM]
                     fasta_file [index_file]

positional arguments:
  fasta_file            File of (gzipped) fasta file for kmer generation
  index_file            File of reference index file to count occurances in.
                        (default: basename of fasta_file with the awfmi
                        extension)

options:
  -h, --help            show this help message and exit

output arguments:
  --search-range RANGE, -r RANGE
                        Search set of sequence lengths to determine
                        uniqueness. Use a comma separated list of increasing
                        lengths or a full inclusive set of lengths separated
                        by a colon. Examples: 20,24,30 or 20:30. (default:
                        20:200)
  --output-directory DIR, -o DIR
                        Directory to write the binary files containing the
                        'unique' lengths to. (default: current working
                        directory)
  --include-sequences IDS, -i IDS
                        A comma separated list of sequence IDs to select from
                        fasta_file. Cannot be used with --exclude-sequences.
                        (default: all sequences in fasta_file)
  --exclude-sequences IDS, -x IDS
                        A comma separated list of sequence IDs to exclude from
                        fasta_file. Cannot be used with --include-sequences.
                        (default: all sequences in fasta_file)
  --verbose, -v         Print additional information to standard error

performance arguments:
  --initial-search-length LENGTH, -l LENGTH
                        Specify the initial search length. Only valid when the
                        search range is a continuous range separated by a
                        colon. (default: midpoint of the range)
  --kmer-batch-size SIZE, -s SIZE
                        Maximum number of k-mers to batch per reference
                        sequence from input fasta file. Use to control memory
                        usage. (default: 10000000)
  --num-threads NUM, -t NUM
                        Number of threads to parallelize k-mer counting.
                        (default: 1)
```


## newmap_track

### Tool Description
Calculate mappability values based on read length and unique count files.

### Metadata
- **Docker Image**: quay.io/biocontainers/newmap:0.2--py312h9c9b0c2_1
- **Homepage**: https://github.com/hoffmangroup/newmap
- **Package**: https://anaconda.org/channels/bioconda/packages/newmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: newmap track [-h] [--single-read FILE] [--multi-read FILE] [--verbose]
                    [read_length] unique_count_files [unique_count_files ...]

positional arguments:
  read_length           Mappability values to be calculated based on this read
                        length. (default is 24)
  unique_count_files    One or more unique count files to convert to
                        mappability files

options:
  -h, --help            show this help message and exit

output arguments:
  --single-read FILE, -s FILE
                        Filename for single-read mappability BED file output.
                        Use '-' for standard output. (default: '-' if not
                        multi-read not specified, otherwise nothing)
  --multi-read FILE, -m FILE
                        Filename for multi-read mappability WIG file output.
                        Use '-' for standard output. (default: nothing)
  --verbose, -v         Print additional information to standard error
```

