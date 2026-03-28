# slamdunk CWL Generation Report

## slamdunk_map

### Tool Description
Map sequencing reads to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Total Downloads**: 30.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/t-neumann/slamdunk
- **Stars**: N/A
### Original Help Text
```text
usage: slamdunk map [-h] -r REFERENCEFILE -o OUTPUTDIR [-5 TRIM5] [-n TOPN]
                    [-a MAXPOLYA] [-t THREADS] [-q] [-e] [-sn SAMPLENAME]
                    [-sy SAMPLETYPE] [-st SAMPLETIME] [-i SAMPLEINDEX] [-ss]
                    files [files ...]

positional arguments:
  files                 Single csv/tsv file (recommended) containing all
                        sample files and sample info or a list of all sample
                        BAM/FASTA(gz)/FASTQ(gz) files

optional arguments:
  -h, --help            show this help message and exit
  -r REFERENCEFILE, --reference REFERENCEFILE
                        Reference fasta file
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -5 TRIM5, --trim-5p TRIM5
                        Number of bp removed from 5' end of all reads.
                        (default: 12)
  -n TOPN, --topn TOPN  Max. number of alignments to report per read (default:
                        1)
  -a MAXPOLYA, --max-polya MAXPOLYA
                        Max number of As at the 3' end of a read. (default: 4)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
  -q, --quantseq        Run plain Quantseq alignment without SLAM-seq scoring
                        (default: False)
  -e, --endtoend        Use a end to end alignment algorithm for mapping.
                        (default: False)
  -sn SAMPLENAME, --sampleName SAMPLENAME
                        Use this sample name for all supplied samples
                        (default: None)
  -sy SAMPLETYPE, --sampleType SAMPLETYPE
                        Use this sample type for all supplied samples
                        (default: pulse)
  -st SAMPLETIME, --sampleTime SAMPLETIME
                        Use this sample time for all supplied samples
                        (default: 0)
  -i SAMPLEINDEX, --sample-index SAMPLEINDEX
                        Run analysis only for sample <i>. Use for distributing
                        slamdunk analysis on a cluster (index is 1-based).
                        (default: -1)
  -ss, --skip-sam       Output BAM while mapping. Slower but, uses less hard
                        disk. (default: False)
```


## slamdunk_filter

### Tool Description
Filter BAM files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: slamdunk filter [-h] -o OUTPUTDIR [-b BED] [-mq MQ] [-mi IDENTITY]
                       [-nm NM] [-t THREADS]
                       bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -b BED, --bed BED     BED file, overrides MQ filter to 0
  -mq MQ, --min-mq MQ   Minimum mapping quality (default: 2)
  -mi IDENTITY, --min-identity IDENTITY
                        Minimum alignment identity (default: 0.95)
  -nm NM, --max-nm NM   Maximum NM for alignments (default: -1)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```


## slamdunk_snp

### Tool Description
Call SNPs from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: slamdunk snp [-h] -o OUTPUTDIR -r FASTA [-c COV] [-f VAR] [-t THREADS]
                    bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -r FASTA, --reference FASTA
                        Reference fasta file
  -c COV, --min-coverage COV
                        Minimimum coverage to call variant (default: 10)
  -f VAR, --var-fraction VAR
                        Minimimum variant fraction to call variant (default:
                        0.8)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```


## slamdunk_count

### Tool Description
Count T>C conversions in BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: slamdunk count [-h] -o OUTPUTDIR [-s SNPDIR] [-v VCFFILE] -r REF -b BED
                      [-c CONVERSIONTHRESHOLD] [-l MAXLENGTH] [-q MINQUAL]
                      [-t THREADS]
                      bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -s SNPDIR, --snp-directory SNPDIR
                        Directory containing SNP files.
  -v VCFFILE, --vcf VCFFILE
                        Externally provided custom variant file.
  -r REF, --reference REF
                        Reference fasta file
  -b BED, --bed BED     BED file
  -c CONVERSIONTHRESHOLD, --conversion-threshold CONVERSIONTHRESHOLD
                        Number of T>C conversions required to count read as
                        T>C read (default: 1)
  -l MAXLENGTH, --max-read-length MAXLENGTH
                        Max read length in BAM file
  -q MINQUAL, --min-base-qual MINQUAL
                        Min base quality for T -> C conversions (default: 27)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```


## slamdunk_all

### Tool Description
Run SLAM-seq analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: slamdunk all [-h] -r REFERENCEFILE -b BED [-fb FILTERBED] [-v VCFFILE]
                    -o OUTPUTDIR [-5 TRIM5] [-a MAXPOLYA] [-n TOPN]
                    [-t THREADS] [-q] [-e] [-m] [-mq MQ] [-mi IDENTITY]
                    [-nm NM] [-mc COV] [-mv VAR] [-c CONVERSIONTHRESHOLD]
                    [-rl MAXLENGTH] [-mbq MINQUAL] [-sn SAMPLENAME]
                    [-sy SAMPLETYPE] [-st SAMPLETIME] [-i SAMPLEINDEX] [-ss]
                    files [files ...]

positional arguments:
  files                 Single csv/tsv file (recommended) containing all
                        sample files and sample info or a list of all sample
                        BAM/FASTA(gz)/FASTQ(gz) files

optional arguments:
  -h, --help            show this help message and exit
  -r REFERENCEFILE, --reference REFERENCEFILE
                        Reference fasta file
  -b BED, --bed BED     BED file with 3'UTR coordinates
  -fb FILTERBED, --filterbed FILTERBED
                        BED file with 3'UTR coordinates to filter multimappers
                        (activates -m)
  -v VCFFILE, --vcf VCFFILE
                        Skip SNP step and provide custom variant file.
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for slamdunk run.
  -5 TRIM5, --trim-5p TRIM5
                        Number of bp removed from 5' end of all reads
                        (default: 12)
  -a MAXPOLYA, --max-polya MAXPOLYA
                        Max number of As at the 3' end of a read (default: 4)
  -n TOPN, --topn TOPN  Max. number of alignments to report per read (default:
                        1)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
  -q, --quantseq        Run plain Quantseq alignment without SLAM-seq scoring
  -e, --endtoend        Use a end to end alignment algorithm for mapping.
  -m, --multimap        Use reference to resolve multimappers (requires -n >
                        1).
  -mq MQ, --min-mq MQ   Minimum mapping quality (default: 2)
  -mi IDENTITY, --min-identity IDENTITY
                        Minimum alignment identity (default: 0.95)
  -nm NM, --max-nm NM   Maximum NM for alignments (default: -1)
  -mc COV, --min-coverage COV
                        Minimimum coverage to call variant (default: 10)
  -mv VAR, --var-fraction VAR
                        Minimimum variant fraction to call variant (default:
                        0.8)
  -c CONVERSIONTHRESHOLD, --conversion-threshold CONVERSIONTHRESHOLD
                        Number of T>C conversions required to count read as
                        T>C read (default: 1)
  -rl MAXLENGTH, --max-read-length MAXLENGTH
                        Max read length in BAM file
  -mbq MINQUAL, --min-base-qual MINQUAL
                        Min base quality for T -> C conversions (default: 27)
  -sn SAMPLENAME, --sampleName SAMPLENAME
                        Use this sample name for all supplied samples
  -sy SAMPLETYPE, --sampleType SAMPLETYPE
                        Use this sample type for all supplied samples
  -st SAMPLETIME, --sampleTime SAMPLETIME
                        Use this sample time for all supplied samples
  -i SAMPLEINDEX, --sample-index SAMPLEINDEX
                        Run analysis only for sample <i>. Use for distributing
                        slamdunk analysis on a cluster (index is 1-based).
  -ss, --skip-sam       Output BAM while mapping. Slower but, uses less hard
                        disk.
```


## Metadata
- **Skill**: generated
