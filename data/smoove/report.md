# smoove CWL Generation Report

## smoove_call

### Tool Description
Runs lumpy and sends output to {outdir}/{name}-smoove.vcf.gz if --genotype is requested, the output goes to {outdir}/{name}-smoove.genotyped.vcf.gz

### Metadata
- **Docker Image**: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
- **Homepage**: https://github.com/brentp/smoove
- **Package**: https://anaconda.org/channels/bioconda/packages/smoove/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smoove/overview
- **Total Downloads**: 54.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/smoove
- **Stars**: N/A
### Original Help Text
```text
this runs lumpy ands sends output to {outdir}/{name}-smoove.vcf.gz if --genotype is requested, the output goes to {outdir}/{name}-smoove.genotyped.vcf.gz
Usage: smoove --name NAME --fasta FASTA [--exclude EXCLUDE] [--excludechroms EXCLUDECHROMS] [--processes PROCESSES] [--outdir OUTDIR] [--noextrafilters] [--support SUPPORT] [--genotype] [--duphold] [--removepr] BAMS [BAMS ...]

Positional arguments:
  BAMS                   path to bam(s) to call.

Options:
  --name NAME, -n NAME   project name used in output files.
  --fasta FASTA, -f FASTA
                         fasta file.
  --exclude EXCLUDE, -e EXCLUDE
                         BED of exclude regions.
  --excludechroms EXCLUDECHROMS, -C EXCLUDECHROMS
                         ignore SVs with either end in this comma-delimited list of chroms. If this starts with ~ it is treated as a regular expression to exclude. [default: hs37d5,~:,~^GL,~decoy]
  --processes PROCESSES, -p PROCESSES
                         number of processors to parallelize. [default: 3]
  --outdir OUTDIR, -o OUTDIR
                         output directory.
  --noextrafilters, -F   use lumpy_filter only without extra smoove filters.
  --support SUPPORT, -S SUPPORT
                         mininum support required to report a variant. [default: 4]
  --genotype             stream output to svtyper for genotyping
  --duphold, -d          run duphold on output. only works with --genotype
  --removepr, -x         remove PRPOS and PREND tags from INFO (only used with --gentoype).
  --help, -h             display this help and exit
```


## smoove_merge

### Tool Description
Merge VCF files from smoove runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
- **Homepage**: https://github.com/brentp/smoove
- **Package**: https://anaconda.org/channels/bioconda/packages/smoove/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: smoove --name NAME [--outdir OUTDIR] --fasta FASTA VCFS [VCFS ...]

Positional arguments:
  VCFS                   path to vcfs.

Options:
  --name NAME, -n NAME   project name used in output files.
  --outdir OUTDIR, -o OUTDIR
                         output directory. [default: ./]
  --fasta FASTA, -f FASTA
                         fasta file.
  --help, -h             display this help and exit
```


## smoove_genotype

### Tool Description
Call genotypes for a given set of BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
- **Homepage**: https://github.com/brentp/smoove
- **Package**: https://anaconda.org/channels/bioconda/packages/smoove/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: smoove --name NAME [--outdir OUTDIR] --fasta FASTA [--removepr] [--duphold] [--processes PROCESSES] --vcf VCF BAMS [BAMS ...]

Positional arguments:
  BAMS                   path to bam to call.

Options:
  --name NAME, -n NAME   project name used in output files.
  --outdir OUTDIR, -o OUTDIR
                         output directory.
  --fasta FASTA, -f FASTA
                         fasta file.
  --removepr, -x         remove PRPOS and PREND tags from INFO.
  --duphold, -d          run duphold on output.
  --processes PROCESSES, -p PROCESSES
                         number of processors to use. [default: 3]
  --vcf VCF, -v VCF      vcf to genotype (use - for stdin). [default: -]
  --help, -h             display this help and exit
```


## smoove_paste

### Tool Description
square VCF files from different samples with the same number of records

### Metadata
- **Docker Image**: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
- **Homepage**: https://github.com/brentp/smoove
- **Package**: https://anaconda.org/channels/bioconda/packages/smoove/overview
- **Validation**: PASS

### Original Help Text
```text
square VCF files from different samples with the same number of records
Usage: smoove --name NAME [--outdir OUTDIR] VCFS [VCFS ...]

Positional arguments:
  VCFS                   path to vcfs.

Options:
  --name NAME, -n NAME   project name used in output files.
  --outdir OUTDIR, -o OUTDIR
                         output directory. [default: ./]
  --help, -h             display this help and exit
```


## smoove_plot-counts

### Tool Description
Generate an HTML report of counts from smoove

### Metadata
- **Docker Image**: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
- **Homepage**: https://github.com/brentp/smoove
- **Package**: https://anaconda.org/channels/bioconda/packages/smoove/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: smoove --vcf VCF --html HTML

Options:
  --vcf VCF, -v VCF      path to input VCF from smoove 0.2.3 or greater.
  --html HTML, -h HTML   path to output html file to be written.
  --help, -h             display this help and exit
```


## smoove_annotate

### Tool Description
GFF3 annotation files can be downloaded from Ensembl:
ftp://ftp.ensembl.org/pub/current_gff3/homo_sapiens/
ftp://ftp.ensembl.org/pub/grch37/release-84/gff3/homo_sapiens/

### Metadata
- **Docker Image**: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
- **Homepage**: https://github.com/brentp/smoove
- **Package**: https://anaconda.org/channels/bioconda/packages/smoove/overview
- **Validation**: PASS

### Original Help Text
```text
GFF3 annotation files can be downloaded from Ensembl:
ftp://ftp.ensembl.org/pub/current_gff3/homo_sapiens/
ftp://ftp.ensembl.org/pub/grch37/release-84/gff3/homo_sapiens/ 
Usage: smoove [--gff GFF] VCF

Positional arguments:
  VCF                    path to VCF(s) to annotate.

Options:
  --gff GFF, -g GFF      path to GFF for gene annotation
  --help, -h             display this help and exit
```


## smoove_hipstr

### Tool Description
Call STRs in BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
- **Homepage**: https://github.com/brentp/smoove
- **Package**: https://anaconda.org/channels/bioconda/packages/smoove/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: smoove --regions REGIONS --fasta FASTA BAMS [BAMS ...]

Positional arguments:
  BAMS                   bams in which to call STRs

Options:
  --regions REGIONS, -r REGIONS
                         BED file of regions containing STRs
  --fasta FASTA, -f FASTA
                         path to reference fasta file
  --help, -h             display this help and exit
```


## smoove_duphold

### Tool Description
Call germline structural variants from sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
- **Homepage**: https://github.com/brentp/smoove
- **Package**: https://anaconda.org/channels/bioconda/packages/smoove/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: smoove --fasta FASTA --vcf VCF [--processes PROCESSES] [--snps SNPS] --outvcf OUTVCF BAMS [BAMS ...]

Positional arguments:
  BAMS                   paths to sample BAM/CRAMs

Options:
  --fasta FASTA, -f FASTA
                         fasta file.
  --vcf VCF, -v VCF      path to input SV VCF
  --processes PROCESSES, -p PROCESSES
                         number of threads ot use. [default: 20]
  --snps SNPS, -s SNPS   optional path to SNP/Indel VCF containing these samples for annotation with allele balance.
  --outvcf OUTVCF, -o OUTVCF
                         path to output SV VCF
  --help, -h             display this help and exit
```

