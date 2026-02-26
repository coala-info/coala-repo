# shark CWL Generation Report

## shark

### Tool Description
missing required files

### Metadata
- **Docker Image**: quay.io/biocontainers/shark:1.2.0--h077b44d_5
- **Homepage**: https://algolab.github.io/shark/
- **Package**: https://anaconda.org/channels/bioconda/packages/shark/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shark/overview
- **Total Downloads**: 13.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
shark : missing required files

Usage: shark -r <references> -1 <sample1> [OPTIONAL ARGUMENTS]

Arguments:
      -r, --reference                   reference sequences in FASTA format (can be gzipped)
      -1, --sample1                     sample in FASTQ (can be gzipped)

Optional arguments:
      -h, --help                        display this help and exit
      -2, --sample2                     second sample in FASTQ (optional, can be gzipped)
      -o, --out1                        first output sample in FASTQ (default: sharked_sample.1)
      -p, --out2                        second output sample in FASTQ (default: sharked_sample.2)
      -k, --kmer-size                   size of the kmers to index (default:17, max:31)
      -c, --confidence                  confidence for associating a read to a gene (default:0.6)
      -b, --bf-size                     bloom filter size in GB (default:1)
      -q, --min-base-quality            minimum base quality (assume FASTQ Illumina 1.8+ Phred scale, default:0, i.e., no filtering)
      -s, --single                      report an association only if a single gene is found
      -t, --threads                     number of threads (default:1)
      -v, --verbose                     verbose mode
```

