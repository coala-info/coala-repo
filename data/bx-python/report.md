# bx-python CWL Generation Report

## bx-python_maf_build_index.py

### Tool Description
Build an index file for a set of MAF alignment blocks.

### Metadata
- **Docker Image**: quay.io/biocontainers/bx-python:0.14.0--py312h5e9d817_0
- **Homepage**: https://github.com/bxlab/bx-python
- **Package**: https://anaconda.org/channels/bioconda/packages/bx-python/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bx-python/overview
- **Total Downloads**: 639.2K
- **Last updated**: 2025-07-31
- **GitHub**: https://github.com/bxlab/bx-python
- **Stars**: N/A
### Original Help Text
```text
Exception while parsing command line:
Traceback (most recent call last):
  File "/usr/local/bin/maf_build_index.py", line 26, in main
    maf_file = args[0]
               ~~~~^^^
IndexError: list index out of range


Build an index file for a set of MAF alignment blocks.

If index_file is not provided maf_file.index is used.

usage: /usr/local/bin/maf_build_index.py maf_file index_file
    -s, --species=a,b,c: only index the position of the block in the listed species
```


## bx-python_maf_extract_ranges_indexed.py

### Tool Description
Extract ranges from MAF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bx-python:0.14.0--py312h5e9d817_0
- **Homepage**: https://github.com/bxlab/bx-python
- **Package**: https://anaconda.org/channels/bioconda/packages/bx-python/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: maf_extract_ranges_indexed.py maf_fname1 maf_fname2 ... [options] < interval_file

Options:
  -h, --help            show this help message and exit
  -m MINCOLS, --mincols=MINCOLS
                        Minimum length (columns) required for alignment to be
                        output
  -c, --chop            Should blocks be chopped to only portion overlapping
                        (no by default)
  -s SRC, --src=SRC     Use this src for all intervals
  -p PREFIX, --prefix=PREFIX
                        Prepend this to each src before lookup
  -d DIR, --dir=DIR     Write each interval as a separate file in this
                        directory
  -S, --strand          Strand is included as an additional column, and the
                        blocks are reverse complemented (if necessary) so that
                        they are always on that strand w/r/t the src species.
  -C, --usecache        Use a cache that keeps blocks of the MAF files in
                        memory (requires ~20MB per MAF)
```


## Metadata
- **Skill**: not generated
