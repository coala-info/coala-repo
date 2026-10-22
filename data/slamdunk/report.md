# slamdunk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| slamdunk_all | PASS | Galaxy test reads (12 reads, Actb region) run; T>C counts match the Galaxy expected table. |
| slamdunk_alleyoop_collapse | PASS | New CWL; the collapsed table for Actb matches the tcount values (rate 0.0222, 8 reads, 4 T>C reads). |
| slamdunk_alleyoop_dedup | PASS | New CWL; the 12 filtered Galaxy test reads were all retained (12 of 12) and the BAM has 12 reads. |
| slamdunk_alleyoop_dump | PASS | New CWL; the read info dump lists the test reads with sequence, mismatches and per-position T>C counts. |
| slamdunk_alleyoop_merge | PASS | New CWL; merged T>C rate for Actb is 0.5 (4 T>C reads over 8 reads), as TcReadCount / ReadCount gives. |
| slamdunk_alleyoop_positional-tracks | PASS | New CWL; Galaxy test reads gave the 8 genome-wide bedGraph tracks with plausible values (T>C conversions at chr5:120495). |
| slamdunk_alleyoop_rates | PASS | New CWL; the overall rates table is identical to the Galaxy expected reads1_overallrates.csv (only the version comment differs). |
| slamdunk_alleyoop_read-separator | PASS | New CWL; on the Galaxy test BAM with its SNP VCF (--vcf), the TC and background BAMs match the Galaxy expected reads exactly. |
| slamdunk_alleyoop_snpeval | Not completed | New CWL; alleyoop snpeval writes its CSV and PDF but its R plot script stops with an xy.coords error because the 12-read test set has no SNPs; no larger real data. |
| slamdunk_alleyoop_summary | PASS | New CWL; summary shows 12 sequenced, 12 mapped, 12 retained and 8 counted reads for the Galaxy test sample. |
| slamdunk_alleyoop_tccontext | PASS | New CWL; the T>C context table and PDF were written for the Galaxy test reads with plausible counts. |
| slamdunk_alleyoop_tcperreadpos | PASS | New CWL; per read position conversion table and PDF written for the Galaxy test reads. |
| slamdunk_alleyoop_tcperutrpos | PASS | New CWL; per UTR position conversion table and PDF written for the Actb UTR. |
| slamdunk_alleyoop_utrrates | PASS | New CWL; Actb UTR rates with 8 reads and a median T>C rate of 3.9 percent, consistent with the tcount result. |
| slamdunk_count | PASS | Galaxy test reads (12 reads, Actb region) run; T>C counts match the Galaxy expected table. |
| slamdunk_filter | PASS | Galaxy test reads (12 reads, Actb region) run; T>C counts match the Galaxy expected table. |
| slamdunk_map | PASS | Galaxy test reads (12 reads, Actb region) run; T>C counts match the Galaxy expected table. |
| slamdunk_snp | PASS | Galaxy test reads run on the filtered BAM; the SNP VCF has no records, as in the Galaxy expected file. |

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


## slamdunk_alleyoop_dedup

### Tool Description
Deduplicate SLAM-seq aligned data

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop dedup [-h] -o OUTPUTDIR [-tc TCMUTATIONS] [-t THREADS]
                      bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -tc TCMUTATIONS, --tcMutations TCMUTATIONS
                        Only select reads with x number of T>C mutations.
                        (default: 0)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```

## slamdunk_alleyoop_dump

### Tool Description
Print all info available for slamdunk reads

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop dump [-h] -r REFERENCEFILE [-s SNPDIR] [-v VCFFILE] -o
                     OUTPUTDIR [-mq MQ] [-t THREADS]
                     bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -r REFERENCEFILE, --reference REFERENCEFILE
                        Reference fasta file
  -s SNPDIR, --snp-directory SNPDIR
                        Directory containing SNP files.
  -v VCFFILE, --vcf VCFFILE
                        Skip SNP step and provide custom variant file.
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -mq MQ, --min-basequality MQ
                        Minimal base quality for SNPs (default: 0)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```

## slamdunk_alleyoop_read-separator

### Tool Description
Separate TC-reads from background reads genome-wide

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop read-separator [-h] -o OUTPUTDIR [-s SNPDIR] [-v VCFFILE] -r
                               REF [-c CONVERSIONTHRESHOLD] [-q MINQUAL]
                               [-t THREADS]
                               bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for bam files.
  -s SNPDIR, --snp-directory SNPDIR
                        Directory containing SNP files.
  -v VCFFILE, --vcf VCFFILE
                        Skip SNP step and provide custom variant file.
  -r REF, --reference REF
                        Reference fasta file
  -c CONVERSIONTHRESHOLD, --conversion-threshold CONVERSIONTHRESHOLD
                        Number of T>C conversions required to count read as
                        T>C read (default: 1)
  -q MINQUAL, --min-base-qual MINQUAL
                        Min base quality for T -> C conversions (default: 27)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```

## slamdunk_alleyoop_tccontext

### Tool Description
Calculate T->C conversion context on SLAM-seq datasets

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop tccontext [-h] -o OUTPUTDIR -r REFERENCEFILE [-mq MQ]
                          [-t THREADS]
                          bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -r REFERENCEFILE, --reference REFERENCEFILE
                        Reference fasta file
  -mq MQ, --min-basequality MQ
                        Minimal base quality for SNPs (default: 0)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```

## slamdunk_alleyoop_tcperreadpos

### Tool Description
Calculate conversion rates per read position on SLAM-seq datasets

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop tcperreadpos [-h] -r REFERENCEFILE [-s SNPDIR] [-v VCFFILE]
                             [-l MAXLENGTH] -o OUTPUTDIR [-mq MQ] [-t THREADS]
                             bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -r REFERENCEFILE, --reference REFERENCEFILE
                        Reference fasta file
  -s SNPDIR, --snp-directory SNPDIR
                        Directory containing SNP files.
  -v VCFFILE, --vcf VCFFILE
                        Skip SNP step and provide custom variant file.
  -l MAXLENGTH, --max-read-length MAXLENGTH
                        Max read length in BAM file
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -mq MQ, --min-basequality MQ
                        Minimal base quality for SNPs (default: 27)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```

## slamdunk_alleyoop_tcperutrpos

### Tool Description
Calculate conversion rates per UTR position on SLAM-seq datasets

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop tcperutrpos [-h] -r REFERENCEFILE -b BED [-s SNPDIR]
                            [-v VCFFILE] [-l MAXLENGTH] -o OUTPUTDIR [-mq MQ]
                            [-t THREADS]
                            bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -r REFERENCEFILE, --reference REFERENCEFILE
                        Reference fasta file
  -b BED, --bed BED     BED file
  -s SNPDIR, --snp-directory SNPDIR
                        Directory containing SNP files.
  -v VCFFILE, --vcf VCFFILE
                        Skip SNP step and provide custom variant file.
  -l MAXLENGTH, --max-read-length MAXLENGTH
                        Max read length in BAM file
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -mq MQ, --min-basequality MQ
                        Minimal base quality for SNPs (default: 27)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```

## slamdunk_alleyoop_rates

### Tool Description
Calculate overall conversion rates on SLAM-seq datasets

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop rates [-h] -o OUTPUTDIR -r REFERENCEFILE [-mq MQ] [-t THREADS]
                      bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -r REFERENCEFILE, --reference REFERENCEFILE
                        Reference fasta file
  -mq MQ, --min-basequality MQ
                        Minimal base quality for SNPs (default: 27)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```

## slamdunk_alleyoop_snpeval

### Tool Description
Evaluate SNP calling

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop snpeval [-h] -o OUTPUTDIR -s SNPDIR -r REF -b BED [-c COV]
                        [-f VAR] [-m] [-l MAXLENGTH] [-q MINQUAL] [-t THREADS]
                        bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -s SNPDIR, --snp-directory SNPDIR
                        Directory containing SNP files.
  -r REF, --reference REF
                        Reference fasta file
  -b BED, --bed BED     BED file
  -c COV, --min-coverage COV
                        Minimum coverage to call variant (default: 10)
  -f VAR, --var-fraction VAR
                        Minimum variant fraction to call variant (default:
                        0.8)
  -m, --multiTCStringency
  -l MAXLENGTH, --max-read-length MAXLENGTH
                        Max read length in BAM file (default: None)
  -q MINQUAL, --min-base-qual MINQUAL
                        Min base quality for T -> C conversions (default: 27)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```

## slamdunk_alleyoop_collapse

### Tool Description
Collapse UTRs

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop collapse [-h] -o OUTPUTDIR [-t THREADS] tcount [tcount ...]

positional arguments:
  tcount                Tcount file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```

## slamdunk_alleyoop_utrrates

### Tool Description
Calculate conversion rates per UTR on SLAM-seq datasets

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop utrrates [-h] -o OUTPUTDIR -r REFERENCEFILE [-mq MQ] [-m]
                         [-t THREADS] -b BED [-l MAXLENGTH]
                         bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for mapped BAM files.
  -r REFERENCEFILE, --reference REFERENCEFILE
                        Reference fasta file
  -mq MQ, --min-basequality MQ
                        Minimal base quality for SNPs (default: 27)
  -m, --multiTCStringency
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
  -b BED, --bed BED     BED file
  -l MAXLENGTH, --max-read-length MAXLENGTH
                        Max read length in BAM file (default: None)
```

## slamdunk_alleyoop_positional-tracks

### Tool Description
Genome-wide positional tracks as bedgraph

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop positional-tracks [-h] -o OUTPUTDIR [-s SNPDIR] [-v VCFFILE]
                                  -r REF [-c CONVERSIONTHRESHOLD]
                                  [-a COVERAGECUTOFF] [-q MINQUAL]
                                  [-t THREADS]
                                  bam [bam ...]

positional arguments:
  bam                   Bam file(s)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory for bedGraph files.
  -s SNPDIR, --snp-directory SNPDIR
                        Directory containing SNP files.
  -v VCFFILE, --vcf VCFFILE
                        Skip SNP step and provide custom variant file.
  -r REF, --reference REF
                        Reference fasta file
  -c CONVERSIONTHRESHOLD, --conversion-threshold CONVERSIONTHRESHOLD
                        Number of T>C conversions required to count read as
                        T>C read (default: 1)
  -a COVERAGECUTOFF, --coverage-cutoff COVERAGECUTOFF
                        Minimum coverage required to report nucleotide-
                        conversion rate (default: 1). Anything less than 1
                        will be set to 1 to avoid division by zero.
  -q MINQUAL, --min-base-qual MINQUAL
                        Min base quality for T -> C conversions (default: 27)
  -t THREADS, --threads THREADS
                        Thread number (default: 1)
```

## slamdunk_alleyoop_summary

### Tool Description
Display summary information and statistics on read numbers

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop summary [-h] -o OUTPUTFILE [-t COUNTDIRECTORY] bam [bam ...]

positional arguments:
  bam                   Filtered BAM files (produced by slamdunk filter or
                        all)

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTFILE, --output OUTPUTFILE
                        Output file
  -t COUNTDIRECTORY, --tcountDir COUNTDIRECTORY
                        Folder containing tcount files
```

## slamdunk_alleyoop_merge

### Tool Description
Merge T->C rates from multiple sample in one TSV file

### Metadata
- **Docker Image**: quay.io/biocontainers/slamdunk:0.4.3--py_0
- **Homepage**: http://t-neumann.github.io/slamdunk
- **Package**: https://anaconda.org/channels/bioconda/packages/slamdunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: alleyoop merge [-h] -o OUTPUTFILE [-c COLUMN] [-n COLUMNNAME]
                      countFiles [countFiles ...]

positional arguments:
  countFiles            tCount files

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTFILE, --output OUTPUTFILE
                        Output file
  -c COLUMN, --column COLUMN
                        Column or expression used to summarize files.
                        (default: TcReadCount / ReadCount)
  -n COLUMNNAME, --columnname COLUMNNAME
                        Index of meta data field to use as column name.
                        (default: 2)
```

## Metadata
- **Skill**: generated
