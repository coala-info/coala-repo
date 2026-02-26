# gencore CWL Generation Report

## gencore

### Tool Description
Processes BAM/SAM files with reference and optional BED regions, generating consensus sequences and reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/gencore:0.17.2--he5ce664_4
- **Homepage**: https://github.com/OpenGene/gencore
- **Package**: https://anaconda.org/channels/bioconda/packages/gencore/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gencore/overview
- **Total Downloads**: 14.6K
- **Last updated**: 2025-07-24
- **GitHub**: https://github.com/OpenGene/gencore
- **Stars**: N/A
### Original Help Text
```text
option needs value: --html
Version: 0.17.2, usage: gencore --ref=string [options] ... 
options:
  -i, --in                       input sorted bam/sam file. STDIN will be read from if it's not specified (string [=-])
  -o, --out                      output bam/sam file. STDOUT will be written to if it's not specified (string [=-])
  -r, --ref                      reference fasta file name (should be an uncompressed .fa/.fasta file) (string)
  -b, --bed                      bed file to specify the capturing region, none by default (string [=])
  -x, --duplex_only              only output duplex consensus sequences, which means single stranded consensus sequences will be discarded.
      --no_duplex                don't merge single stranded consensus sequences to duplex consensus sequences.
  -u, --umi_prefix               the prefix for UMI, if it has. None by default. Check the README for the defails of UMI formats. (string [=auto])
  -s, --supporting_reads         only output consensus reads/pairs that merged by >= <supporting_reads> reads/pairs. The valud should be 1~10, and the default value is 1. (int [=1])
  -a, --ratio_threshold          if the ratio of the major base in a cluster is less than <ratio_threshold>, it will be further compared to the reference. The valud should be 0.5~1.0, and the default value is 0.8 (double [=0.8])
  -c, --score_threshold          if the score of the major base in a cluster is less than <score_threshold>, it will be further compared to the reference. The valud should be 1~20, and the default value is 6 (int [=6])
  -d, --umi_diff_threshold       if two reads with identical mapping position have UMI difference <= <umi_diff_threshold>, then they will be merged to generate a consensus read. Default value is 1. (int [=1])
  -D, --duplex_diff_threshold    if the forward consensus and reverse consensus sequences have <= <duplex_diff_threshold> mismatches, then they will be merged to generate a duplex consensus sequence, otherwise will be discarded. Default value is 2. (int [=2])
      --high_qual                the threshold for a quality score to be considered as high quality. Default 30 means Q30. (int [=30])
      --moderate_qual            the threshold for a quality score to be considered as moderate quality. Default 20 means Q20. (int [=20])
      --low_qual                 the threshold for a quality score to be considered as low quality. Default 15 means Q15. (int [=15])
      --coverage_sampling        the sampling rate for genome scale coverage statistics. Default 10000 means 1/10000. (int [=10000])
  -j, --json                     the json format report file name (string [=gencore.json])
  -h, --html                     the html format report file name (string [=gencore.html])
      --debug                    output some debug information to STDERR.
      --quit_after_contig        stop when <quit_after_contig> contigs are processed. Only used for fast debugging. Default 0 means no limitation. (int [=0])
  -?, --help                     print this message
```

