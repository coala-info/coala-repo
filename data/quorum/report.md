# quorum CWL Generation Report

## quorum

### Tool Description
Run the quorum error corrector on the given fastq file. If the --paired-files switch is given, quorum expect an even number of files on the command line, each pair files containing pair end reads. The output will be two files (<prefix>_1.fa and <prefix>_2.fa) containing error corrected pair end reads.

### Metadata
- **Docker Image**: biocontainers/quorum:v1.1.1-2-deb_cv1
- **Homepage**: https://github.com/Consensys/quorum
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/quorum/overview
- **Total Downloads**: 7.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Consensys/quorum
- **Stars**: N/A
### Original Help Text
```text
/usr/bin/quorum [options] .fastq [.fastq]+
    
Run the quorum error corrector on the given fastq file. If the --paired-files
switch is given, quorum expect an even number of files on the command line,
each pair files containing pair end reads. The output will be two files
(<prefix>_1.fa and <prefix>_2.fa) containing error corrected pair end reads.

Options:
 -s, --size              Mer database size (default 200M)
 -t, --threads           Number of threads (default number of cpus)
 -p, --prefix            Output prefix (default quorum_corrected)
 -k, --kmer-len          Kmer length (default 24)
 -q, --min-q-char        Minimum quality char. Usually 33 or 64 (autodetect)
 -m, --min-quality       Minimum above -q for high quality base (5)
 -w, --window            Window size for trimming
 -e, --error             Maximum number of errors in a window
     --min-count         Minimum count for a k-mer to be good
     --skip              Number of bases to skip to find anchor kmer
     --anchor            Numer of good kmer in a row for anchor
     --anchor-count      Minimum count for an anchor kmer
     --contaminant       Contaminant sequences
     --trim-contaminant  Trim sequences with contaminant mers
 -d, --no-discard        Do not discard reads, output a single N (false)
 -P, --paired-files      Preserve mate pairs in two files
     --homo-trim         Trim homo-polymer on 3' end
     --debug             Display debugging information
     --version           Display version
 -h, --help              This message
```

