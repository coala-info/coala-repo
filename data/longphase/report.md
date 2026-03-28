# longphase CWL Generation Report

## longphase_phase

### Tool Description
Phases genomic reads using SNP and optionally SV information.

### Metadata
- **Docker Image**: quay.io/biocontainers/longphase:2.0.1--hfc4162c_0
- **Homepage**: https://github.com/twolinin/longphase
- **Package**: https://anaconda.org/channels/bioconda/packages/longphase/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/longphase/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2026-02-25
- **GitHub**: https://github.com/twolinin/longphase
- **Stars**: N/A
### Original Help Text
```text
phase: option requires an argument -- 'h'
phase: missing arguments. --ont or --pb
phase: missing SNP file.
phase: missing reference.

Usage:  phase [OPTION] ... READSFILE
   --help                                 display this help and exit.

require arguments:
   -s, --snp-file=NAME                    input SNP vcf file.
   -b, --bam-file=NAME                    input bam file.
   -r, --reference=NAME                   reference fasta.
   --ont, --pb                            ont: Oxford Nanopore genomic reads.
                                          pb: PacBio HiFi/CCS genomic reads.

optional arguments:
   --sv-file=NAME                         input SV vcf file.
   --mod-file=NAME                        input modified vcf file.(produce by longphase modcall)
   -t, --threads=Num                      number of thread. default:1
   -o, --out-prefix=NAME                  prefix of phasing result. default: result
   --indels                               phase small indel. default: False
   --indelQuality=Num                     filter indels with QUAL less than threshold (only effective when --indels is enabled). default: 0
   --dot                                  each contig/chromosome will generate dot file. 

parse alignment arguments:
   -q, --mappingQuality=Num               filter alignment if mapping quality is lower than threshold. default:1
   -x, --mismatchRate=Num                 mark reads as false if mismatchRate of them are higher than threshold. default:3

phasing graph arguments:
   -p, --baseQuality=[0~90]               change edge's weight to --edgeWeight if base quality is lower than the threshold. default:12
   -e, --edgeWeight=[0~1]                 if one of the bases connected by the edge has a quality lower than --baseQuality
                                          its weight is reduced from the normal 1. default:0.1
   -a, --connectAdjacent=Num              connect adjacent N SNPs. default:35
   -d, --distance=Num                     phasing two variant if distance less than threshold. default:300000
   -1, --edgeThreshold=[0~1]              give up SNP-SNP phasing pair if the number of reads of the 
                                          two combinations are similar. default:0.7
   -L, --overlapThreshold=[0~1]           filtering different alignments of the same read if there is overlap. default:0.2
   -w, --sv-window=NUM                    window size for evaluating surrounding CIGAR operations. default:20
   -h, --sv-threshold=[0~1]               relative difference threshold for read to support a SV. default:0.10

haplotag read correction arguments:
   -m, --readConfidence=[0.5~1]           The confidence of a read being assigned to any haplotype. default:0.65
   -n, --snpConfidence=[0.5~1]            The confidence of assigning two alleles of a SNP to different haplotypes. default:0.75
```


## longphase_haplotag

### Tool Description
Tag alignments with haplotype information based on SNP and SV data.

### Metadata
- **Docker Image**: quay.io/biocontainers/longphase:2.0.1--hfc4162c_0
- **Homepage**: https://github.com/twolinin/longphase
- **Package**: https://anaconda.org/channels/bioconda/packages/longphase/overview
- **Validation**: PASS

### Original Help Text
```text
haplotag: option requires an argument -- 'h'
haplotag: missing SNP file.
haplotag: missing bam file.
haplotag: missing reference.

Usage:  haplotag [OPTION] ... READSFILE
      --help                          display this help and exit.

require arguments:
      -s, --snp-file=NAME             input SNP vcf file.
      -b, --bam-file=NAME             input bam file.
      -r, --reference=NAME            reference fasta.
optional arguments:
      --tagSupplementary              tag supplementary alignment. default:false
      --sv-file=NAME                  input phased SV vcf file.
      --mod-file=NAME                 input a modified VCF file (produced by longphase modcall and processed by longphase phase).
      -q, --qualityThreshold=Num      not tag alignment if the mapping quality less than threshold. default:1
      -p, --percentageThreshold=Num   the alignment will be tagged according to the haplotype corresponding to most alleles.
                                      if the alignment has no obvious corresponding haplotype, it will not be tagged. default:0.6
      -w, --sv-window=NUM             window size for evaluating surrounding CIGAR operations. default: 20
      -h, --sv-threshold=[0~1]        relative difference threshold for read to support a SV. default: 0.10
      -t, --threads=Num               number of thread. default:1
      -o, --out-prefix=NAME           prefix of phasing result. default:result
      --cram                          the output file will be in the cram format. default:bam
      --region=REGION                 tagging include only reads/variants overlapping those regions. default:""(all regions)
                                      input format:chrom (consider entire chromosome)
                                                   chrom:start (consider region from this start to end of chromosome)
                                                   chrom:start-end
      --log                           an additional log file records the result of each read. default:false
```


## longphase_modcall

### Tool Description
modcall

### Metadata
- **Docker Image**: quay.io/biocontainers/longphase:2.0.1--hfc4162c_0
- **Homepage**: https://github.com/twolinin/longphase
- **Package**: https://anaconda.org/channels/bioconda/packages/longphase/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  modcall [OPTION] ... READSFILE
      --help                        display this help and exit.
require arguments:
      -b, --bam-file=NAME           modified sorted bam file.
      -r, --reference=NAME          reference fasta.
optional arguments:
      -s, --snp-file=NAME           input SNP vcf file.
      -o, --out-prefix=NAME         prefix of phasing result. default: modcall_result
      -t, --threads=Num             number of thread. default:1
      --all                         output all coordinates where modifications have been detected.
phasing arguments:
      -m, --modThreshold=[0~1]      value extracted from MM tag and ML tag. 
                                    above the threshold means modification occurred. default: 0.8
      -u, --unModThreshold=[0~1]    value extracted from MM tag and ML tag. 
                                    above the threshold means no modification occurred. default: 0.2
      -e, --heterRatio=[0~1]        modified and unmodified scales. 
                                    a higher threshold means that the two quantities need to be closer. default: 0.7
      -i, --noiseRatio=[0~1]        not being judged as modified and unmodified is noise.
                                    higher threshold means lower noise needs. default: 0.2
      -a, --connectAdjacent=Num     connect adjacent N METHs. default:6
      -c, --connectConfidence=[0~1] determine the confidence of phasing two ASMs.
                                    higher threshold requires greater consistency in the reads. default: 0.9
```


## Metadata
- **Skill**: generated
