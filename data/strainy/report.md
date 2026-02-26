# strainy CWL Generation Report

## strainy

### Tool Description
strainy

### Metadata
- **Docker Image**: quay.io/biocontainers/strainy:1.2--pyhdfd78af_1
- **Homepage**: https://github.com/katerinakazantseva/strainy
- **Package**: https://anaconda.org/channels/bioconda/packages/strainy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/strainy/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/katerinakazantseva/strainy
- **Stars**: N/A
### Original Help Text
```text
usage: strainy [-h] -o OUTPUT [-g GFA_REF] -m {hifi,nano} -q FASTQ
               [-s {phase,transform,e2e}] [--snp SNP] [-t THREADS]
               [-f FASTA_REF] [-b BAM] [--link-simplify] [--debug]
               [--unitig-split-length UNITIG_SPLIT_LENGTH]
               [--only-split ONLY_SPLIT] [-d CLUSTER_DIVERGENCE]
               [-a ALLELE_FREQUENCY] [--min-unitig-length MIN_UNITIG_LENGTH]
               [--min-unitig-coverage MIN_UNITIG_COVERAGE]
               [--max-unitig-coverage MAX_UNITIG_COVERAGE] [-v]

options:
  -h, --help            show this help message and exit
  -s {phase,transform,e2e}, --stage {phase,transform,e2e}
                        stage to run: either phase, transform or e2e (phase +
                        transform) (default: e2e)
  --snp SNP             path to vcf file with SNP calls to use (default: None)
  -t THREADS, --threads THREADS
                        number of threads to use (default: 4)
  -f FASTA_REF, --fasta_ref FASTA_REF
                        input reference fasta to phase (default: None)
  -b BAM, --bam BAM     path to indexed alignment in bam format (default:
                        None)
  --link-simplify       Enable agressive graph simplification (default: False)
  --debug               Generate extra output for debugging (default: False)
  --unitig-split-length UNITIG_SPLIT_LENGTH
                        The length (in kb) which the unitigs that are longer
                        will be split, set 0 to disable (default: 50)
  --only-split ONLY_SPLIT
                        Do not run stRainy, only split long gfa unitigs
                        (default: False)
  -d CLUSTER_DIVERGENCE, --cluster-divergence CLUSTER_DIVERGENCE
                        cluster divergence (default: 0)
  -a ALLELE_FREQUENCY, --allele-frequency ALLELE_FREQUENCY
                        Set allele frequency for internal caller only (pileup)
                        (default: 0.2)
  --min-unitig-length MIN_UNITIG_LENGTH
                        The length (in kb) which the unitigs that are shorter
                        will not be phased (default: 1)
  --min-unitig-coverage MIN_UNITIG_COVERAGE
                        The minimum coverage threshold for phasing unitigs,
                        unitigs with lower coverage will not be phased
                        (default: 20)
  --max-unitig-coverage MAX_UNITIG_COVERAGE
                        The maximum coverage threshold for phasing unitigs,
                        unitigs with higher coverage will not be phased
                        (default: 500)
  -v, --version         show program's version number and exit

Required named arguments:
  -o OUTPUT, --output OUTPUT
                        output directory (default: None)
  -g GFA_REF, --gfa_ref GFA_REF
                        input reference gfa to uncollapse (default: None)
  -m {hifi,nano}, --mode {hifi,nano}
                        type of reads (default: None)
  -q FASTQ, --fastq FASTQ
                        fastq file with reads to phase / assemble (default:
                        None)
```

