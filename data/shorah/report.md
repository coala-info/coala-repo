# shorah CWL Generation Report

## shorah_shotgun

### Tool Description
Call SNVs from shotgun sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/shorah:1.99.2--py38h73782ee_8
- **Homepage**: https://github.com/cbg-ethz/shorah
- **Package**: https://anaconda.org/channels/bioconda/packages/shorah/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shorah/overview
- **Total Downloads**: 83.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cbg-ethz/shorah
- **Stars**: N/A
### Original Help Text
```text
usage: shorah <subcommand> [options] shotgun [-h] [-v] -b BAM -f REF
                                             [-a FLOAT] [-r chrm:start-stop]
                                             [-R INT] [-x INT] [-S FLOAT] [-I]
                                             [-p FLOAT]
                                             [-of {csv,vcf} [{csv,vcf} ...]]
                                             [-c INT] [-w INT] [-s INT] [-k]
                                             [-t INT]

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -a FLOAT, --alpha FLOAT
                        alpha in dpm sampling (controls the probability of
                        creating new classes)
  -r chrm:start-stop, --region chrm:start-stop
                        region in format 'chr:start-stop', e.g.
                        'chrm:1000-3000'
  -R INT, --seed INT    set seed for reproducible results
  -x INT, --maxcov INT  approximate max coverage allowed
  -S FLOAT, --sigma FLOAT
                        sigma value to use when calling SNVs
  -I, --ignore_indels   ignore SNVs adjacent to insertions/deletions (legacy
                        behaviour of 'fil', ignore this option if you don't
                        understand)
  -p FLOAT, --threshold FLOAT
                        pos threshold when calling variants from support files
  -of {csv,vcf} [{csv,vcf} ...], --out_format {csv,vcf} [{csv,vcf} ...]
                        output format of called SNVs
  -c INT, --win_coverage INT
                        coverage threshold. Omit windows with low coverage
  -w INT, --windowsize INT
                        window size
  -s INT, --winshifts INT
                        number of window shifts
  -k, --keep_files      keep all intermediate files
  -t INT, --threads INT
                        limit maximum number of parallel sampler threads (0:
                        CPUs count-1, n: limit to n)

required arguments:
  -b BAM, --bam BAM     sorted bam format alignment file
  -f REF, --fasta REF   reference genome in fasta format
```


## shorah_amplicon

### Tool Description
Call SNVs from amplicon sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/shorah:1.99.2--py38h73782ee_8
- **Homepage**: https://github.com/cbg-ethz/shorah
- **Package**: https://anaconda.org/channels/bioconda/packages/shorah/overview
- **Validation**: PASS

### Original Help Text
```text
usage: shorah <subcommand> [options] amplicon [-h] [-v] -b BAM -f REF
                                              [-a FLOAT] [-r chrm:start-stop]
                                              [-R INT] [-x INT] [-S FLOAT]
                                              [-I] [-p FLOAT]
                                              [-of {csv,vcf} [{csv,vcf} ...]]
                                              [-c INT] [-d] [-m FLOAT]

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -a FLOAT, --alpha FLOAT
                        alpha in dpm sampling (controls the probability of
                        creating new classes)
  -r chrm:start-stop, --region chrm:start-stop
                        region in format 'chr:start-stop', e.g.
                        'chrm:1000-3000'
  -R INT, --seed INT    set seed for reproducible results
  -x INT, --maxcov INT  approximate max coverage allowed
  -S FLOAT, --sigma FLOAT
                        sigma value to use when calling SNVs
  -I, --ignore_indels   ignore SNVs adjacent to insertions/deletions (legacy
                        behaviour of 'fil', ignore this option if you don't
                        understand)
  -p FLOAT, --threshold FLOAT
                        pos threshold when calling variants from support files
  -of {csv,vcf} [{csv,vcf} ...], --out_format {csv,vcf} [{csv,vcf} ...]
                        output format of called SNVs
  -c INT, --win_coverage INT
                        coverage threshold. Omit windows with low coverage
  -d, --diversity       detect the highest entropy region and run there
  -m FLOAT, --min_overlap FLOAT
                        fraction of read overlap to be included

required arguments:
  -b BAM, --bam BAM     sorted bam format alignment file
  -f REF, --fasta REF   reference genome in fasta format
```


## shorah_snv

### Tool Description
Call SNVs from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/shorah:1.99.2--py38h73782ee_8
- **Homepage**: https://github.com/cbg-ethz/shorah
- **Package**: https://anaconda.org/channels/bioconda/packages/shorah/overview
- **Validation**: PASS

### Original Help Text
```text
usage: shorah <subcommand> [options] snv [-h] [-v] -b BAM -f REF [-a FLOAT]
                                         [-r chrm:start-stop] [-R INT]
                                         [-x INT] [-S FLOAT] [-I] [-p FLOAT]
                                         [-of {csv,vcf} [{csv,vcf} ...]]
                                         [-i INT]

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -a FLOAT, --alpha FLOAT
                        alpha in dpm sampling (controls the probability of
                        creating new classes)
  -r chrm:start-stop, --region chrm:start-stop
                        region in format 'chr:start-stop', e.g.
                        'chrm:1000-3000'
  -R INT, --seed INT    set seed for reproducible results
  -x INT, --maxcov INT  approximate max coverage allowed
  -S FLOAT, --sigma FLOAT
                        sigma value to use when calling SNVs
  -I, --ignore_indels   ignore SNVs adjacent to insertions/deletions (legacy
                        behaviour of 'fil', ignore this option if you don't
                        understand)
  -p FLOAT, --threshold FLOAT
                        pos threshold when calling variants from support files
  -of {csv,vcf} [{csv,vcf} ...], --out_format {csv,vcf} [{csv,vcf} ...]
                        output format of called SNVs
  -i INT, --increment INT
                        value of increment to use when calling SNVs (1 used in
                        amplicon mode)

required arguments:
  -b BAM, --bam BAM     sorted bam format alignment file
  -f REF, --fasta REF   reference genome in fasta format
```


## Metadata
- **Skill**: generated
