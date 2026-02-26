# uc-echo CWL Generation Report

## uc-echo

### Tool Description
Error correction tool

### Metadata
- **Docker Image**: biocontainers/uc-echo:v1.12-11-deb_cv1
- **Homepage**: https://github.com/dh-orko/Help-me-get-rid-of-unhumans
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/uc-echo/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/dh-orko/Help-me-get-rid-of-unhumans
- **Stars**: N/A
### Original Help Text
```text
Usage: ErrorCorrection.py [options] read_file_name

Options:
  -h, --help            show this help message and exit
  -o OUTPUT_FILENAME, --output=OUTPUT_FILENAME
                        Output file name
  -l LOG_FILENAME, --log=LOG_FILENAME
                        Log file name
  --DD=TMP_DIRECTORY, --tmp_dir=TMP_DIRECTORY
                        Temporary data directory
  -u NCPU, --ncpu=NCPU  Number of processes used in training
  -b BSIZE, --block_size=BSIZE
                        Split data into blocks of specified size
  --nh=NHASH, --n_hash_block=NHASH
                        Split hash table into n tables
  --rm=READ_MERGE, --read_merge_size=READ_MERGE
                        Merge n hash tables at a time
  --hm=HASH_MERGE, --hash_merge_batch_size=HASH_MERGE
                        Merge n adjacency lists at a time
  -k K, --kmer=K        k-mer size used for hashing
  -e E, --min_error_tolerance=E
                        Minimum error tolerance for parameter searching
  -E E, --max_error_tolerance=E
                        Maximum error tolerance for parameter searching
  --hh=H, --min_minimum_overlap=H
                        Minimum minimum overlap length for parameter searching
  --hH=H, --max_minimum_overlap=H
                        Maximum minimum overlap length for parameter searching
  --h_rate=H_RATE, --heterozygous_rate=H_RATE
                        Rate for heterozygous site
  --model_selection_size=MSIZE
                        Model selection data set size
  --keep_all_files      Keep all temporary files. By default, temporary files
                        are deleted automatically.
```


## Metadata
- **Skill**: generated

## uc-echo

### Tool Description
Error correction tool

### Metadata
- **Docker Image**: biocontainers/uc-echo:v1.12-11-deb_cv1
- **Homepage**: https://github.com/dh-orko/Help-me-get-rid-of-unhumans
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: ErrorCorrection.py [options] read_file_name

Options:
  -h, --help            show this help message and exit
  -o OUTPUT_FILENAME, --output=OUTPUT_FILENAME
                        Output file name
  -l LOG_FILENAME, --log=LOG_FILENAME
                        Log file name
  --DD=TMP_DIRECTORY, --tmp_dir=TMP_DIRECTORY
                        Temporary data directory
  -u NCPU, --ncpu=NCPU  Number of processes used in training
  -b BSIZE, --block_size=BSIZE
                        Split data into blocks of specified size
  --nh=NHASH, --n_hash_block=NHASH
                        Split hash table into n tables
  --rm=READ_MERGE, --read_merge_size=READ_MERGE
                        Merge n hash tables at a time
  --hm=HASH_MERGE, --hash_merge_batch_size=HASH_MERGE
                        Merge n adjacency lists at a time
  -k K, --kmer=K        k-mer size used for hashing
  -e E, --min_error_tolerance=E
                        Minimum error tolerance for parameter searching
  -E E, --max_error_tolerance=E
                        Maximum error tolerance for parameter searching
  --hh=H, --min_minimum_overlap=H
                        Minimum minimum overlap length for parameter searching
  --hH=H, --max_minimum_overlap=H
                        Maximum minimum overlap length for parameter searching
  --h_rate=H_RATE, --heterozygous_rate=H_RATE
                        Rate for heterozygous site
  --model_selection_size=MSIZE
                        Model selection data set size
  --keep_all_files      Keep all temporary files. By default, temporary files
                        are deleted automatically.
```

