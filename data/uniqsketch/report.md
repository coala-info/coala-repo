# uniqsketch CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| uniqsketch | PASS |  |
| uniqsketch_comparesketch | PASS |  |
| uniqsketch_querysketch | PASS |  |

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

## uniqsketch_querysketch

### Tool Description
Identify references and their abundance in FILE(S).

### Metadata
- **Docker Image**: quay.io/biocontainers/uniqsketch:1.1.0--h077b44d_0
- **Homepage**: https://github.com/amazon-science/uniqsketch
- **Package**: https://anaconda.org/channels/bioconda/packages/uniqsketch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: querysketch [OPTIONS] [ARGS]
Identify references and their abundance in FILE(S).

Acceptable file formats: fastq in compressed formats gz, bz, zip, xz.

 Options:

  -t, --threads=N	use N parallel threads [1]
  -b, --bit=N		use N bits per element in Bloom filter [64]
  -o, --out=STRING	the output file name
  -l, --r1=STRING	input read 1
  -r, --r2=STRING	input read 2
  -g, --ref=STRING	input uniqsketch reference
  -h, --hit=N		number of uniqsketch hits to call a reference [10]
  -a, --acutoff=N	abundance cutoff to report [0.0]
  -s, --rcutoff=N	read cutoff to report [2]
      --sensitive	sets sensitivity parameter h=10
      --very-sensitive	sets sensitivity parameter h=5
      --solid		only use solid k-mers in reads
      --help		display this help and exit
      --versions	version information and exit
```

## uniqsketch_comparesketch

### Tool Description
Compare two sets of fasta reference files.

### Metadata
- **Docker Image**: quay.io/biocontainers/uniqsketch:1.1.0--h077b44d_0
- **Homepage**: https://github.com/amazon-science/uniqsketch
- **Package**: https://anaconda.org/channels/bioconda/packages/uniqsketch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: comparesketch [OPTION] LIST1 LIST2
Compare two sets of fasta reference files |LIST1|*|LIST2|.
fasta files can be in compressed formats such as gz, bz, zip.
Two lists of files containing file paths in each row.

 Options:

  -t, --threads=N	use N parallel threads [1]
  -k, --kmer=N		the length of kmer [81]
  -b, --bit=N		use N bits per element in Bloom filter [16]
  -d, --hash=N		Bloom filter hash number [3]
  -g, --gsize=N		approximate size for reference sequence [5000000]
  -o, --out=STRING	the output similarity file name [reference_similarity.tsv]
      --help		display this help and exit
      --version		output version information and exit
```

