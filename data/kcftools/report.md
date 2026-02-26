# kcftools CWL Generation Report

## kcftools_getVariations

### Tool Description
Screen for reference kmers that are not present in the KMC database, and detect variation

### Metadata
- **Docker Image**: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
- **Homepage**: https://github.com/sivasubramanics/kcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Total Downloads**: 427
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/sivasubramanics/kcftools
- **Stars**: N/A
### Original Help Text
```text
Missing required options: '--reference=<refFasta>', '--kmc=<kmcDBprefix>', '--output=<outFile>', '--sample=<sampleName>', '--feature=<featureType>'
Usage: kcftools getVariations [-m] [-c=<minKmerCount>] -f=<featureType>
                              [-g=<gtfFile>] -k=<kmcDBprefix> -o=<outFile>
                              [-p=<stepSize>] -r=<refFasta> -s=<sampleName>
                              [-t=<nThreads>] [-w=<windowSize>]
                              [--wi=<innerDistanceWeight>]
                              [--wr=<kmerRatioWeight>]
                              [--wt=<tailDistanceWeight>]
 Screen for reference kmers that are not present in the KMC database, and
detect variation
  -r, --reference=<refFasta> Reference file name
  -k, --kmc=<kmcDBprefix>    KMC database prefix
  -o, --output=<outFile>     Output file name
  -s, --sample=<sampleName>  Sample name
  -f, --feature=<featureType>
                             Feature type ("window" or "gene" or "transcript")
  -t, --threads=<nThreads>   Number of threads [2]
  -m, --memory               Load KMC database into memory
      --wi=<innerDistanceWeight>
                             Inner kmer distance weight [0.3]
      --wt=<tailDistanceWeight>
                             Tail kmer distance weight [0.3]
      --wr=<kmerRatioWeight> Kmer ratio weight [0.4]
  -w, --window=<windowSize>  Window size
  -g, --gtf=<gtfFile>        GTF file name
  -c, --min-k-count=<minKmerCount>
                             Minimum kmer count to consider [1]
  -p, --step=<stepSize>      Step size for sliding window [window size]
```


## kcftools_cohort

### Tool Description
Create a cohort of samples kcf files

### Metadata
- **Docker Image**: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
- **Homepage**: https://github.com/sivasubramanics/kcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required option: '--output=<outFile>'
Usage: kcftools cohort [-l=<listFile>] -o=<outFile> [-i=<inFiles>[,
                       <inFiles>...]]...
Create a cohort of samples kcf files
  -i, --input=<inFiles>[,<inFiles>...]
                           List of samples kcf files
  -l, --list=<listFile>    File containing list of samples kcf files
  -o, --output=<outFile>   Output file name
```


## kcftools_findIBS

### Tool Description
Find IBS windows in a KCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
- **Homepage**: https://github.com/sivasubramanics/kcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: '--input=<inFile>', '--output=<outFile>'
Usage: kcftools findIBS [--bed] [--summary] [--var] -i=<inFile>
                        [--min=<minConsecutive>] -o=<outFile>
                        [--score=<scoreCutOff>]
Find IBS windows in a KCF file
      --bed                Write bed file [default: false]
  -i, --input=<inFile>     Input KCF file name
      --min=<minConsecutive>
                           Minimum number of consecutive windows [default: 4]
  -o, --output=<outFile>   Output KCF file name
      --score=<scoreCutOff>
                           Score cut-off [default: 95.00]
      --summary            Write summary tsv file [default: false]
      --var                Detect Variable Regions instead of IBS [default:
                             false]
```


## kcftools_splitKCF

### Tool Description
Split KCF file for each chromosome

### Metadata
- **Docker Image**: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
- **Homepage**: https://github.com/sivasubramanics/kcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: '--kcf=<kcfFile>', '--output=<outDir>'
Usage: kcftools splitKCF -k=<kcfFile> -o=<outDir> [-t=<nThreads>]
Split KCF file for each chromosome
  -k, --kcf=<kcfFile>        KCF file name
  -o, --output=<outDir>      Output directory
  -t, --threads=<nThreads>   Number of threads to use (default: auto-detected)
```


## kcftools_getAttributes

### Tool Description
Extract attributes from KCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
- **Homepage**: https://github.com/sivasubramanics/kcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: '--input=<kcfFile>', '--output=<outFile>'
Usage: kcftools getAttributes -i=<kcfFile> -o=<outFile> [-a=<attributes>[,
                              <attributes>...]]...
Extract attributes from KCF files
  -a, --attributes=<attributes>[,<attributes>...]
                           Attributes to extract. Default: all
                             - obs        : observed kmers
                             - var        : variations
                             - kd         : mean kmer count
                             - score      : score
                             - totalkmers : total kmers per window
                             - winlen     : effective window length
                             - inDist     : inner distance
                             - tailDist   : tail distance
  -i, --input=<kcfFile>    KCF file name
  -o, --output=<outFile>   Output file name prefix
```


## kcftools_kcf2tsv

### Tool Description
Convert KCF file to TSV file (IBSpy like)

### Metadata
- **Docker Image**: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
- **Homepage**: https://github.com/sivasubramanics/kcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: '--input=<kcfFile>', '--output=<outFile>'
Usage: kcftools kcf2tsv -i=<kcfFile> -o=<outFile> [-s=<sampleName>]
Convert KCF file to TSV file (IBSpy like)
  -i, --input=<kcfFile>    KCF file name
  -o, --output=<outFile>   Output file name Prefix
  -s, --sample=<sampleName>
                           Sample name
```


## kcftools_increaseWindow

### Tool Description
Increase the window size of a KCF file by merging windows

### Metadata
- **Docker Image**: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
- **Homepage**: https://github.com/sivasubramanics/kcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: '--input=<inFile>', '--output=<outFile>', '--window=<windowSize>'
Usage: kcftools increaseWindow -i=<inFile> -o=<outFile> -w=<windowSize>
Increase the window size of a KCF file by merging windows
  -i, --input=<inFile>     Input KCF file
  -o, --output=<outFile>   Output KCF file
  -w, --window=<windowSize>
                           Window size
```


## kcftools_kcf2plink

### Tool Description
Convert KCF windows to PED format

### Metadata
- **Docker Image**: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
- **Homepage**: https://github.com/sivasubramanics/kcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: '--input=<inFile>', '--output=<outPrefix>'
Usage: kcftools kcf2plink [-a=<scoreA>] [-b=<scoreB>] [--chrs=<chrsFile>]
                          -i=<inFile> [--maf=<minMAF>]
                          [--max-missing=<maxMissing>] -o=<outPrefix>
                          [--score_n=<scoreN>]
Convert KCF windows to PED format
  -a, --score_a=<scoreA>     Lower score cut-off for reference allele
  -b, --score_b=<scoreB>     Lower score cut-off for alternate allele
      --chrs=<chrsFile>      List file with chromosomes to include
  -i, --input=<inFile>       Input KCF file
      --maf=<minMAF>         Minimum allele frequency to consider a window valid
      --max-missing=<maxMissing>
                             Maximum proportion of missing data to consider a
                               window valid
  -o, --output=<outPrefix>   Output PED file prefix
      --score_n=<scoreN>     Score value for missing data (default = 30.0)
```


## kcftools_scoreRecalc

### Tool Description
Recalculate scores in a KCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
- **Homepage**: https://github.com/sivasubramanics/kcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: '--input=<inFile>', '--output=<outFile>'
Usage: kcftools scoreRecalc -i=<inFile> -o=<outFile>
                            [--wi=<innerDistanceWeight>]
                            [--wr=<kmerRatioWeight>] [--wt=<tailDistanceWeight>]
Recalculate scores in a KCF file
  -i, --input=<inFile>     Input KCF file
  -o, --output=<outFile>   Output KCF file
      --wi=<innerDistanceWeight>
                           Inner kmer distance weight [0.3]
      --wr=<kmerRatioWeight>
                           Kmer ratio weight [0.4]
      --wt=<tailDistanceWeight>
                           Tail kmer distance weight [0.3]
```


## kcftools_kcf2gt

### Tool Description
Convert KCF to Genotype Table

### Metadata
- **Docker Image**: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
- **Homepage**: https://github.com/sivasubramanics/kcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/kcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options: '--input=<inFile>', '--output=<outFile>'
Usage: kcftools kcf2gt [--chrs=<chrsFile>] -i=<inFile> [--maf=<minMAF>]
                       [--max-missing=<maxMissing>] -o=<outFile>
                       [--score_a=<scoreA>] [--score_b=<scoreB>]
                       [--score_n=<scoreN>]
Convert KCF to Genotype Table
      --chrs=<chrsFile>    List file with chromosomes to include
  -i, --input=<inFile>     Input KCF file
      --maf=<minMAF>       minimum allele frequency to consider a window valid
      --max-missing=<maxMissing>
                           maximum proportion of missing data to consider a
                             window valid
  -o, --output=<outFile>   Output file
      --score_a=<scoreA>   Lower score cut-off for reference allele (default =
                             95.0)
      --score_b=<scoreB>   Lower score cut-off for alternate allele (default =
                             60.0)
      --score_n=<scoreN>   Score value for missing data (default = 30.0)
```

