# snver CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| snver | PASS | fixed baseCommand to snver, added index files and default prefix; SARS-CoV-2 nf-core BAM gives one 1/1 SNP |
| snver_pool | PASS | new CWL; SARS-CoV-2 nf-core BAM directory gives the same SNP as snver |

## snver

### Tool Description
SNVerIndividual Usage

### Metadata
- **Docker Image**: quay.io/biocontainers/snver:0.5.3--0
- **Homepage**: http://snver.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snver/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snver/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
[SNVerIndividual Usage]
Usage: java -jar SNVerIndividual.jar -i input_file -r reference_file [options]
Input file must be a standard bam file
	-i	<input file (required) >
	-r	<reference file (required) >
Options:
	-l	<target region bed file (default is null) >
	-o	<prefix output file (default is input_file name) >
	-n	<the number of haploids (default is 2) >
	-het	<heterozygosity (default is 0.001) >
	-mq	<mapping quality threshold (default is 20) >
	-bq	<base quality threshold (default is 17) >
	-s	<strand bias threshold (default is 0.0001) >
	-f	<fisher exact threshold (default is 0.0001) >
	-p	<p-value threshold (default is bonferroni=0.05) >
	-a	<at least how many reads supporting each strand for alternative allele (default is 1)>
	-b	<discard locus with ratio of alt/ref below the threshold (default is 0.25)>
	-u	<inactivate -s and -f above this threshold (default is 30)  >
	-db	<path for dbSNP, column number of chr, pos and snp_id (format: dbsnp,1,2,3; default null)>
```

## snver_pool

### Tool Description
SNVerPool calls SNVs and indels in pooled sequencing data from a directory of BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/snver:0.5.3--0
- **Homepage**: http://snver.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/snver/overview
- **Validation**: PASS

### Original Help Text
```text
[SNVerPool Usage]
Usage: java -jar SNVerPool.jar -i input_directory -r reference_file [-c pool_info_file | -n number_of_haploids] [options]
Input directory must be a directory contains a batch of standard bam files
	-i	<input directory (required) >
	-r	<reference file (required) >
	-c	<pool info file (preferred) >
	-n	<the number of haploids (required when option "-c" is not given)>
Options:
	-l	<target region bed file (default is null) >
	-o	<prefix output file (default is input_file name) >
	-mq	<mapping quality threshold (default is 20) >
	-bq	<base quality threshold (default is 17) >
	-s	<strand bias threshold (default is 0.0001) >
	-f	<fisher exact threshold (default is 0.0001) >
	-p	<p-value threshold (default is bonferroni=0.05) >
	-a	<at least how many reads supporting each strand for alternative allele (default is 1)>
	-t	<allele frequency threshold (default is 0)>
	-u	<inactivate -s and -f above this threshold (default is 30)  >
	-db	<path for dbSNP, column number of chr, pos and snp_id (format: dbsnp,1,2,3; default null)>
```

