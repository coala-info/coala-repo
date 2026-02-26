# sccaller CWL Generation Report

## sccaller

### Tool Description
SCcaller, v2.0.0; Xiao Dong, biosinodx@gmail.com, xiao.dong@einstein.yu.edu; Yujue Wang, spsc83@gmail.com

### Metadata
- **Docker Image**: quay.io/biocontainers/sccaller:2.0.0--0
- **Homepage**: https://github.com/biosinodx/SCcaller
- **Package**: https://anaconda.org/channels/bioconda/packages/sccaller/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sccaller/overview
- **Total Downloads**: 14.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biosinodx/SCcaller
- **Stars**: N/A
### Original Help Text
```text
Usage: sccaller[-h] [-d WKDIR] [-l LAMB] [--bias NUM] [--minvar NUM] [--mapq NUM] [--min_depth NUM] [--RD NUM] [--null NUM] [--bulk BAM] [--bulk_min_depth NUM] [--bulk_min_mapq NUM] [--bulk_min_var NUM] [--format {bed,vcf}] [--head NUM] [--tail NUM] [-e {pysam, samtools}] [--cpu_num NUM] [-w NUM] [-n NUM] -t {dbsnp,hsnp} -b BAM -f FASTA -s SNP_IN -o OUTPUT

Description: SCcaller, v2.0.0; Xiao Dong, biosinodx@gmail.com, xiao.dong@einstein.yu.edu; Yujue Wang, spsc83@gmail.com

Arguments:
-b, --bam:      bamfile of a single cell
-f, --fasta:    fasta file of reference genome
-o, --output:   output file name
-s, --snp_in:   Candidate snp input file, either from dbsnp data or heterozygous snp (hsnp) data of the bulk, for known heterogous call. file type: bed (1-based) or vcf.
-t, --snp_type: SNP type for --snp_in. It could be either "dbsnp" or "hsnp". When choosing dbsnp, --bulk bulk_bamfile is required.

Optional arguments:
--RD:           min. read depth of known heterogous SNP called from bulk when choosing -t dbsnp. Default: 20. Recommand: 10,15,20, depending on average read depth
--bias:         default theta (bias) for SNVs whose theta cannot be estimated. Default=0.75
--bulk:         bamfile of bulk DNA sequencing
--bulk_min_depth:min. reads for bulk. Default: 20
--bulk_min_mapq:min. mapQ for bulk. Default: 20
--bulk_min_var: min. num. variant supporting reads for bulk. Default: 1
--format:       output file format. bed or vcf. Default: vcf
--head:         first chromosome as sorted as in fasta file to analyze (1-based). Default: the first chr. in the fasta
--mapq:         min. mapQ. Default: 40
--min_depth:    min. reads. Default: 10
--minvar:       min. num. variant supporting reads. Default: 4
--null:         min. allelic fraction considered. Default=0.03
--tail:         last chromosome as sorted as in fasta file to analyze (1-based). Default: the last chr. in the fasta
-d, --wkdir:    work dir. Default: ./
-e, --engine:   pileup engine. samtools or pysam. Default: pysam
-h, --help:     Help
-l, --lamb:     lambda for bias estimation. Default=10000
-n, --cpu_num:  num. processes. Default: 1
-w, --work_num: num. splits per chromosome for multi-process computing. Default: 100
```

