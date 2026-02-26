# uniqsketch CWL Generation Report

## uniqsketch

### Tool Description
Creates unique sketch from a list of fasta reference files. A list of files containing file names in each row can be passed with @ prefix.

### Metadata
- **Docker Image**: quay.io/biocontainers/uniqsketch:1.1.0--h077b44d_0
- **Homepage**: https://github.com/amazon-science/uniqsketch
- **Package**: https://anaconda.org/channels/bioconda/packages/uniqsketch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/uniqsketch/overview
- **Total Downloads**: 416
- **Last updated**: 2025-06-08
- **GitHub**: https://github.com/amazon-science/uniqsketch
- **Stars**: N/A
### Original Help Text
```text
Usage: uniqsketch [OPTION] @LIST_FILES (or FILES)
Creates unique sketch from a list of fasta reference files.
A list of files containing file names in each row can be passed with @ prefix.

 Options:

  -t, --threads=N	use N parallel threads [1]
  -k, --kmer=N		the length of kmer [81]
  -b, --bit=N		use N bits per element in Bloom filter [128]
  -d, --hash1=N		distinct Bloom filter hash number [5]
  -s, --hash2=N		repeat Bloom filter hash number [5]
  -c, --cov=N		number of unique k-mers to represent a reference [100]
  -f, --outdir=STRING	dir for universe unique k-mers [outdir_uniqsketch]
  -o, --out=STRING	the output sketch file name [sketch_uniq.tsv]
  -r, --stat=STRING	the output unique kmer stat file name [db_uniq_count.tsv]
  -e, --entropy		sets the aggregate entropy rate threshold [0.65]
      --sensitive	sets sensitivity parameter c to 100
      --very-sensitive	sets sensitivity parameter c to 1000
      --help		display this help and exit
      --version		output version information and exit
```

