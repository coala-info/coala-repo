# ont-fast5-api CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ont-fast5-api_check_compression | PASS | ran on the repo's multi-read and single-read test fast5 files; read ids and counts are right |
| ont-fast5-api_compress_fast5 | PASS | ran on the repo's multi-read and single-read test fast5 files; read ids and counts are right |
| ont-fast5-api_fast5_subset | PASS | ran on the repo's multi-read and single-read test fast5 files; read ids and counts are right |
| ont-fast5-api_multi_to_single_fast5 | PASS | ran on the repo's multi-read and single-read test fast5 files; read ids and counts are right |
| ont-fast5-api_single_to_multi_fast5 | PASS | ran on the repo's multi-read and single-read test fast5 files; read ids and counts are right |

## Metadata
- **Skill**: generated

## ont-fast5-api_single_to_multi_fast5

### Tool Description
Convert single-read FAST5 files to multi-read FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/ont_fast5_api
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-fast5-api/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3635312479: no space left on device
```

## ont-fast5-api_multi_to_single_fast5

### Tool Description
Convert multi-read FAST5 files to single-read FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/ont_fast5_api
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-fast5-api/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  [-h] -i INPUT_PATH -s SAVE_PATH [--recursive] [--ignore_symlinks]
        [-t THREADS] [-v]

options:
  -h, --help            show this help message and exit
  -i INPUT_PATH, --input_path INPUT_PATH
                        MultiRead fast5 file or path to directory of MultiRead
                        files
  -s SAVE_PATH, --save_path SAVE_PATH
                        Folder to output SingleRead fast5 files to
  --recursive           Search recursively through folders for MultiRead fast5
                        files
  --ignore_symlinks     Ignore symlinks when searching recursively for fast5
                        files
  -t THREADS, --threads THREADS
                        Number of threads to use
  -v, --version         show program's version number and exit
```

## ont-fast5-api_fast5_subset

### Tool Description
Extract reads from multi-read FAST5 files by read id.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/ont_fast5_api
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-fast5-api/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Tool for extracting reads from a multi_read_fast5_file by read_id
       [-h] -i INPUT -s SAVE_PATH -l READ_ID_LIST [-f FILENAME_BASE]
       [-n BATCH_SIZE] [-t THREADS] [-r] [--ignore_symlinks]
       [-c {vbz_v1.alpha,vbz,gzip,None}] [--file_list FILE_LIST]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to Fast5 file or directory of Fast5 files
  -s SAVE_PATH, --save_path SAVE_PATH
                        Folder to output MultiRead subset to
  -l READ_ID_LIST, --read_id_list READ_ID_LIST
                        File containing list of read ids to extract (or
                        sequencing_summary.txt file)
  -f FILENAME_BASE, --filename_base FILENAME_BASE
                        Root of output filename, default='batch' ->
                        'batch0.fast5'
  -n BATCH_SIZE, --batch_size BATCH_SIZE
                        Number of reads per multi-read file (default 4000
  -t THREADS, --threads THREADS
                        Maximum number of threads to use
  -r, --recursive       Search recursively through folders for MultiRead fast5
                        files
  --ignore_symlinks     Ignore symlinks when searching recursively for fast5
                        files
  -c {vbz_v1.alpha,vbz,gzip,None}, --compression {vbz_v1.alpha,vbz,gzip,None}
                        Target output compression type
  --file_list FILE_LIST
                        File containing names of files to search in
```

## ont-fast5-api_compress_fast5

### Tool Description
Change the compression of FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/ont_fast5_api
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-fast5-api/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Tool for changing the compression of Fast5 files [-h] -i INPUT_PATH
                                                        (-s SAVE_PATH | --in_place)
                                                        -c
                                                        {vbz_v1.alpha,vbz,gzip}
                                                        [--sanitize]
                                                        [-t THREADS]
                                                        [--recursive]
                                                        [--ignore_symlinks]
                                                        [-v]

options:
  -h, --help            show this help message and exit
  -i INPUT_PATH, --input_path INPUT_PATH
                        Folder containing fast5 files
  -s SAVE_PATH, --save_path SAVE_PATH
                        Folder to output fast5 read files to
  --in_place            Replace the old files with new files in place
  -c {vbz_v1.alpha,vbz,gzip}, --compression {vbz_v1.alpha,vbz,gzip}
                        Target output compression type
  --sanitize            Clean output files of optional groups and datasets
                        (e.g. 'Analyses')
  -t THREADS, --threads THREADS
                        Maximum number of threads to use
  --recursive           Search recursively through folders for single_read
                        fast5 files
  --ignore_symlinks     Ignore symlinks when searching recursively for fast5
                        files
  -v, --version         show program's version number and exit
```

## ont-fast5-api_check_compression

### Tool Description
Check the compression type of raw data in FAST5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ont-fast5-api:4.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/ont_fast5_api
- **Package**: https://anaconda.org/channels/bioconda/packages/ont-fast5-api/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Tool for checking the compression type of raw data in fast5 files
       [-h] -i INPUT_PATH [--check_all_reads] [-r] [--ignore_symlinks]
       [--file_list FILE_LIST]

options:
  -h, --help            show this help message and exit
  -i INPUT_PATH, --input_path INPUT_PATH
                        Path to Fast5 file or directory of Fast5 files
  --check_all_reads     Check all reads in a file individually (default: check
                        only the first read)
  -r, --recursive       Search recursively through folders for MultiRead fast5
                        files
  --ignore_symlinks     Ignore symlinks when searching recursively for fast5
                        files
  --file_list FILE_LIST
                        File containing names of files to search in
```
