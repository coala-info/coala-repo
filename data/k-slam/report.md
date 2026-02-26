# k-slam CWL Generation Report

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

