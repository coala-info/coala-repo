# pypolca CWL Generation Report

## pypolca_citation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypolca:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/pypolca
- **Package**: https://anaconda.org/channels/bioconda/packages/pypolca/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pypolca/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-08-19
- **GitHub**: https://github.com/gbouras13/pypolca
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.13/site-packages/pypolca/utils/util.py:38: SyntaxWarning: invalid escape sequence '\|'
  | '_ \| | | | '_ \ / _ \| |/ __/ _` |
Please cite pypolca in your paper using:


Bouras G, Judd LM, Edwards RA, Vreugde S, Stinear TP, Wick RR. How low can you go? Short-read polishing of Oxford Nanopore bacterial genome assemblies. Microbial Genomics. 2024. doi: [https://doi.org/10.1099/mgen.0.001254](https://doi.org/10.1099/mgen.0.001254).

Zimin AV, Salzberg SL (2020) The genome polishing tool POLCA makes fast and accurate corrections in genome assemblies. PLoS Comput Biol 16(6): e1007981. [https://doi.org/10.1371/journal.pcbi.1007981](https://doi.org/10.1371/journal.pcbi.1007981).
```


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

