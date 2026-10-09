# k-slam CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| k-slam_SLAM | PASS |  |
| k-slam_parse_fasta | PASS |  |
| k-slam_parse_genbank | PASS |  |
| k-slam_parse_taxonomy | PASS |  |

## k-slam_SLAM

### Tool Description
Align paired reads from R1FILE and R2FILE against DATABASE and perform metagenomic analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/k-slam:1.0--1
- **Homepage**: https://github.com/aindj/k-SLAM
- **Package**: https://anaconda.org/channels/bioconda/packages/k-slam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/k-slam/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aindj/k-SLAM
- **Stars**: N/A
### Original Help Text
```text
Usage	SLAM [option] --db=DATABASE R1FILE R2FILE
	Align paired reads from R1FILE and R2FILE against DATABASE and perform metagenomic analysis
or	SLAM [option] --db=DATABASE R1FILE
	Align reads from R1FILE against DATABASE and perform metagenomic analysis
Allowed options:
  --help                                produce help message
  --db arg                              SLAM database file which reads will be 
                                        aligned against
  --min-alignment-score arg (=0)        alignment score cutoff
  --score-fraction-threshold arg (=0.94999999999999996)
                                        screen alignments with scores < 
                                        this*top score
  --match-score arg (=2)                match score
  --mismatch-penalty arg (=3)           mismatch penalty (positive)
  --gap-open arg (=5)                   gap opening penalty (positive)
  --gap-extend arg (=2)                 gap extend penalty (positive)
  --num-reads arg (=4294967295)         Number of reads from R1/R2 File to 
                                        align
  --num-reads-at-once arg (=10000000)   Reduce RAM usage by only analysing 
                                        "arg" reads at once, this will increase
                                        execution time
  --output-file arg                     write to this file instead of stdout
  --sam-file arg                        write SAM output to this file
  --num-alignments arg (=10)            Number of alignments to report in SAM 
                                        file
  --sam-xa                              only output primary alignment lines, 
                                        use XA field for secondary alignments
  --version                             print version number
  --just-align                          only perform alignments, not 
                                        metagenomics
  --no-pseudo-assembly                  do not link alignments together
```

## k-slam_parse_fasta

### Tool Description
Build a k-SLAM index from FASTA files (SLAM --parse-fasta).

### Metadata
- **Docker Image**: quay.io/biocontainers/k-slam:1.0--1
- **Homepage**: https://github.com/aindj/k-SLAM
- **Package**: https://anaconda.org/channels/bioconda/packages/k-slam/overview
- **Validation**: PASS

### Original Help Text
```text
Build k-SLAM's index from any number of FASTA files (from the k-SLAM README):
  mkdir custom_db && cd custom_db
  SLAM --output-file database --parse-fasta file1.fa file2.fa file3.fa ...
Note: databases produced from FASTA files must be analysed using the "--just-align" flag.
```

## k-slam_parse_genbank

### Tool Description
Build a k-SLAM index from GenBank files (SLAM --parse-genbank).

### Metadata
- **Docker Image**: quay.io/biocontainers/k-slam:1.0--1
- **Homepage**: https://github.com/aindj/k-SLAM
- **Package**: https://anaconda.org/channels/bioconda/packages/k-slam/overview
- **Validation**: PASS

### Original Help Text
```text
Build k-SLAM's index from any number of Genbank files (from the k-SLAM README):
  SLAM --output-file database --parse-genbank file1.gbk file2.gbk file3.gbk ...
The taxonomy database (taxDB) must exist in the working directory.
```

## k-slam_parse_taxonomy

### Tool Description
Build a k-SLAM taxonomy database from NCBI names.dmp and nodes.dmp (SLAM --parse-taxonomy).

### Metadata
- **Docker Image**: quay.io/biocontainers/k-slam:1.0--1
- **Homepage**: https://github.com/aindj/k-SLAM
- **Package**: https://anaconda.org/channels/bioconda/packages/k-slam/overview
- **Validation**: PASS

### Original Help Text
```text
parses NCBI names.dmp and nodes.dmp file to produce a SLAM taxonomy database, usage SLAM --parse-taxonomy names.dmp nodes.dmp --output-file taxonomy
```

