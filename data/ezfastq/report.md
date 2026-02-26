# ezfastq CWL Generation Report

## ezfastq

### Tool Description
Copy FASTQ files and use sample names to make filenames consistent

### Metadata
- **Docker Image**: quay.io/biocontainers/ezfastq:0.2--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/ezfastq/
- **Package**: https://anaconda.org/channels/bioconda/packages/ezfastq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ezfastq/overview
- **Total Downloads**: 572
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/bioforensics/ezfastq
- **Stars**: N/A
### Original Help Text
```text
Usage: ezfastq [-h] [-v] [-w PATH] [-s PATH] [-p P] [-m M] [-l] [-V]
               seq_path samples [samples ...]

Copy FASTQ files and use sample names to make filenames consistent

Positional Arguments:
  seq_path            path to directory containing sequences in FASTQ format;
                      subdirectories will be searched recursively
  samples             name of one or more samples to process; samples can
                      optionally be renamed by appending a colon and new name
                      to each sample name; alternatively, sample names can be
                      provided as a file with one sample name per line, or two
                      tab-separated values to rename samples

Options:
  -h, --help          show this help message and exit
  -v, --version       show program's version number and exit
  -w, --workdir PATH  project directory to which input files will be copied
                      and renamed; current directory is used by default
  -s, --subdir PATH   subdirectory path under --workdir to which sequence
                      files will be written; PATH=`seq` by default, but can
                      contain nesting (e.g. `seq/study`)
  -p, --prefix P      prefix to prepend to sample names; resulting file path
                      will be
                      '{workdir}/seq/{prefix}_{sample}_R{1,2}.fastq.gz'
  -m, --pair-mode M   specify 1 to indicate that all samples are single-end,
                      or 2 to indicate that all samples are paired-end; by
                      default, read layout is inferred automatically on a
                      per-sample basis
  -l, --link          symbolically link files rather than copying; only
                      supported for gzip-compressed files
  -V, --verbose       include source and destination in copy log

Examples:
    ezfastq /path/to/fastqs/ sample1 sample2 sample3
    ezfastq /path/to/fastqs/ s1:Sample1 s2:Sample2 s3:Sample3
    ezfastq /path/to/fastqs/ samplenames.txt
    ezfastq /path/to/fastqs/ samplenames.txt --workdir /path/to/projectdir/ --subdir seq/Run01/
    ezfastq /path/to/fastqs/ samplenames.txt --pair-mode 2
```

