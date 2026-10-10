# mutmap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mutmap | PASS | synthetic data: simulated reads on a 30 kb genome; SNP-index is 0.87 inside the planted locus and 0.58 elsewhere |
| mutmap_mutplot | PASS | synthetic data: VCF from the mutmap test; writes the SNP-index tables and the plot |

## mutmap

### Tool Description
MutMap version 2.3.9

### Metadata
- **Docker Image**: quay.io/biocontainers/mutmap:2.3.9--pyhdfd78af_0
- **Homepage**: https://github.com/YuSugihara/MutMap
- **Package**: https://anaconda.org/channels/bioconda/packages/mutmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mutmap/overview
- **Total Downloads**: 44.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/YuSugihara/MutMap
- **Stars**: N/A
### Original Help Text
```text
usage: mutmap -r <FASTA> -c <BAM|FASTQ> -b <BAM|FASTQ>
              -n <INT> -o <OUT_DIR> [-T] [-e <DATABASE>]

MutMap version 2.3.9

optional arguments:
  -h, --help         show this help message and exit
  -r , --ref         Reference FASTA file.
  -c , --cultivar    FASTQ or BAM file of cultivar. If specifying
                     FASTQ, separate paired-end files with a comma,
                     e.g., -c fastq1,fastq2. This option can be
                     used multiple times.
  -b , --bulk        FASTQ or BAM file of mutant bulk. If specifying
                     FASTQ, separate paired-end files with a comma,
                     e.g., -b fastq1,fastq2. This option can be
                     used multiple times.
  -n , --N-bulk      Number of individuals in the mutant bulk.
  -o , --out         Output directory. The specified directory must not
                     already exist.
  -t , --threads     Number of threads. If a value less than 1 is specified,
                     MutMap will use the maximum available threads. [2]
  -w , --window      Window size in kilobases (kb). [2000]
  -s , --step        Step size in kilobases (kb). [100]
  -D , --max-depth   Maximum depth of variants to be used. This cutoff
                     applies to both the cultivar and the bulk. [250]
  -d , --min-depth   Minimum depth of variants to be used. This cutoff
                     applies to both the cultivar and the bulk. [8]
  -N , --N-rep       Number of replicates for simulations to generate
                     null distribution. [5000]
  -T, --trim         Trim FASTQ files using Trimmomatic.
  -a , --adapter     FASTA file containing adapter sequences. This option
                     is used when "-T" is specified for trimming.
  --trim-params      Parameters for Trimmomatic. Input parameters
                     must be comma-separated in the following order:
                     Phred score, ILLUMINACLIP, LEADING, TRAILING,
                      SLIDINGWINDOW, MINLEN. To remove Illumina adapters,
                     specify the adapter FASTA file with "--adapter".
                     If not specified, adapter trimming will be skipped.
                     [33,<ADAPTER_FASTA>:2:30:10,20,20,4:15,75]
  -e , --snpEff      Predict causal variants using SnpEff. Check
                     available databases in SnpEff.
  --line-colors      Colors for threshold lines in plots. Specify a
                     comma-separated list in the order of SNP-index,
                     p95, and p99. ["#D55D00,#009E72,#FDB003"]
  --dot-color        Color of the dots in plots. ["#B3B8DD"]
  --mem              Maximum memory per thread when sorting BAM files;
                     suffixes K/M/G are recognized. [1G]
  -q , --min-MQ      Minimum mapping quality for mpileup. [40]
  -Q , --min-BQ      Minimum base quality for mpileup. [18]
  -C , --adjust-MQ   Adjust the mapping quality for mpileup. The default
                     setting is optimized for BWA. [50]
  -v, --version      show program's version number and exit
```

## mutmap_mutplot

### Tool Description
Calculate SNP-index from a VCF file of cultivar and mutant bulk and plot it

### Metadata
- **Docker Image**: quay.io/biocontainers/mutmap:2.3.9--pyhdfd78af_0
- **Homepage**: https://github.com/YuSugihara/MutMap
- **Package**: https://anaconda.org/channels/bioconda/packages/mutmap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mutplot -v <VCF> -o <OUT_DIR> -n <INT> [-w <INT>] [-s <INT>]
               [-D <INT>] [-d <INT>] [-N <INT>] [-m <FLOAT>]
               [-S <INT>] [-e <DATABASE>] [--igv] [--indel]

MutPlot version 2.3.9

optional arguments:
  -h, --help            show this help message and exit
  -v , --vcf            VCF file which contains cultivar and mutant bulk.
                        in this order. This VCF file must have AD field.
  -o , --out            Output directory. The specified directory can already
                        exist.
  -n , --N-bulk         Number of individuals in the mutant bulk.
  -w , --window         Window size in kilobases (kb). [2000]
  -s , --step           Step size in kilobases (kb). [100]
  -D , --max-depth      Maximum depth of variants to be used. This cutoff
                        applies to both the cultivar and the bulk. [250]
  -d , --min-depth      Minimum depth of variants to be used. This cutoff
                        applies to both the cultivar and the bulk. [8]
  -N , --N-rep          Number of replicates for simulations to generate
                        null distribution. [5000]
  -m , --min-SNPindex   Cutoff of minimum SNP-index for clear results. [0.3]
  -S , --strand-bias    Filter out spurious homozygous genotypes in the cultivar
                        based on strand bias. If ADF (or ADR) is higher than
                        this cutoff when ADR (or ADF) is 0, that SNP will be
                        filtered out. If you want to disable this filtering,
                        set this cutoff to 0. [7]
  -e , --snpEff         Predict causal variants using SnpEff. Check
                        available databases in SnpEff.
  --igv                 Output IGV format file to check results on IGV.
  --indel               Plot SNP-index with INDEL.
  --line-colors         Colors for threshold lines in plots. Specify a
                        comma-separated list in the order of SNP-index,
                        p95, and p99. ["#D55D00,#009E72,#FDB003"]
  --dot-color           Color of the dots in plots. ["#B3B8DD"]
  --fig-width           Width allocated in chromosome figure. [7.5]
  --fig-height          Height allocated in chromosome figure. [4.0]
  --white-space         White space between figures. (This option
                        only affects vertical direction.) [0.6]
  -f , --format         Specify the format of an output image.
                        eps/jpeg/jpg/pdf/pgf/png/rgba/svg/svgz/tif/tiff
  --version             show program's version number and exit
```

