# pypolca CWL Generation Report

## pypolca_run

### Tool Description
Python implementation of the POLCA polisher from MaSuRCA

### Metadata
- **Docker Image**: quay.io/biocontainers/pypolca:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/pypolca
- **Package**: https://anaconda.org/channels/bioconda/packages/pypolca/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypolca run [OPTIONS]

  Python implementation of the POLCA polisher from MaSuRCA

Options:
  -h, --help               Show this message and exit.
  -V, --version            Show the version and exit.
  -a, --assembly PATH      Path to assembly contigs or scaffolds.  [required]
  -1, --reads1 PATH        Path to polishing reads R1 FASTQ. Can be FASTQ or
                           FASTQ gzipped. Required.  [required]
  -2, --reads2 PATH        Path to polishing reads R2 FASTQ. Can be FASTQ or
                           FASTQ gzipped. Optional. Only use -1 if you have
                           single end reads.
  -t, --threads INTEGER    Number of threads.  [default: 1]
  -o, --output PATH        Output directory path  [default: output_pypolca]
  -f, --force              Force overwrites the output directory
  --min_alt INTEGER        Minimum alt allele count to make a change
                           [default: 2]
  --min_ratio FLOAT        Minimum alt allele to ref allele ratio to make a
                           change  [default: 2.0]
  --careful                Equivalent to --min_alt 4 --min_ratio 3
  --homopolymers INTEGER   Ignore all changes except for homopolymer-length
                           changes, with homopolymers defined by this length
  -n, --no_polish          do not polish, just create vcf file, evaluate the
                           assembly and exit
  -m, --memory_limit TEXT  Memory per thread to use in samtools sort, set to
                           2G or more for large genomes  [default: 2G]
  -p, --prefix TEXT        prefix for output files  [default: pypolca]
```

