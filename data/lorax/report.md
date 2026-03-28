# lorax CWL Generation Report

## lorax_tithreads

### Tool Description
Tells you the ploidy of a tumor sample based on its BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-07-02
- **GitHub**: https://github.com/tobiasrausch/lorax
- **Stars**: N/A
### Original Help Text
```text
Usage: lorax tithreads [OPTIONS] -g <ref.fa> -m <control.bam> <tumor.bam>

Options:
  -? [ --help ]                       show help message
  -q [ --qual ] arg (=1)              min. mapping quality
  -c [ --clip ] arg (=25)             min. clipping length
  -s [ --split ] arg (=3)             min. split-read support
  -p [ --ploidy ] arg (=2)            ploidy
  -l [ --chrlen ] arg (=40000000)     min. chromosome length
  -i [ --minsize ] arg (=100)         min. segment size
  -j [ --maxsize ] arg (=10000)       max. segment size
  -n [ --contam ] arg (=0)            max. fractional tumor-in-normal 
                                      contamination
  -e [ --entropy ] arg (=1.79999995)  min. sequence entropy
  -d [ --sd ] arg (=3)                SD for coverage deviation
  -g [ --genome ] arg                 genome fasta file
  -m [ --matched ] arg                matched control BAM
  -o [ --outprefix ] arg (=out)       output prefix
```


## lorax_amplicon

### Tool Description
Amplicon analysis tool

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lorax amplicon [OPTIONS] -g <ref.fa> -b amplicons.bed -s NA12878 -v <snps.bcf> <tumor.bam>

Options:
  -? [ --help ]                   show help message
  -q [ --quality ] arg (=10)      min. sequence quality
  -c [ --minclip ] arg (=100)     min. clipping length
  -n [ --wincov ] arg (=1000)     coverage window length
  -u [ --uncertain ] arg (=1000)  breakpoint uncertainty (in bp)
  -p [ --ploidy ] arg (=2)        ploidy
  -s [ --sample ] arg (=NA12878)  sample name (as in VCF/BCF file)
  -v [ --vcffile ] arg            input VCF/BCF file
  -b [ --bedfile ] arg            amplicon regions in BED format
  -g [ --genome ] arg             genome fasta file
  -o [ --outprefix ] arg (=out)   output prefix
```


## lorax_pct

### Tool Description
Calculate and output statistics about the alignment of a sample to a reference genome or pan-genome graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
Linear reference genome: lorax pct [OPTIONS] -r <ref.fa> <sample.bam>
Pan-genome graph: lorax pct [OPTIONS] <sample.gaf.gz>

Generic options:
  -? [ --help ]                      show help message
  -r [ --reference ] arg             genome fasta file
  -o [ --outfile ] arg (="out.tsv")  output statistics
```


## lorax_extract

### Tool Description
Extracts reads from a BAM file based on a list of reads and a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lorax extract [OPTIONS] -g <genome.fa> -r <reads.lst> <contig.bam>

Generic options:
  -? [ --help ]                         show help message
  -g [ --genome ] arg                   reference fasta file
  -r [ --reads ] arg                    list of reads
  -o [ --outfile ] arg (="out.match.gz")
                                        gzipped match file
  -f [ --fafile ] arg (="out.fa.gz")    gzipped fasta/q file
  -a [ --hashes ]                       list of reads are hashes
  -q [ --fastq ]                        output fastq
```


## lorax_telomere

### Tool Description
Identify telomeric repeats in BAM or FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lorax telomere [OPTIONS] -g <ref.fa> <tumor.bam>
       lorax telomere [OPTIONS] <reads.fasta>

Options:
  -? [ --help ]                         show help message
  -c [ --minclip ] arg (=18)            min. clipping length
  -m [ --movavg ] arg (=51)             rolling average window
  -s [ --medsize ] arg (=501)           rolling median window
  -t [ --thres ] arg (=0.34999999999999998)
                                        repeat threshold
  -l [ --chrlen ] arg (=40000000)       min. chromosome length
  -r [ --repeats ] arg (=TTAGGG,TCAGGG,TGAGGG,TTGGGG)
                                        repeat units
  -g [ --genome ] arg                   genome fasta file
  -o [ --outprefix ] arg (=out)         output file prefix
```


## lorax_repeat

### Tool Description
Finds tandem repeats in a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
- **Homepage**: https://github.com/tobiasrausch/lorax
- **Package**: https://anaconda.org/channels/bioconda/packages/lorax/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lorax repeat [OPTIONS] <ref.fa>

Options:
  -? [ --help ]                         show help message
  -l [ --chrlen ] arg (=40000000)       min. chromosome length
  -r [ --repeats ] arg (=TTAGGG,TCAGGG,TGAGGG,TTGGGG)
                                        repeat units
  -p [ --period ] arg (=3)              repeat period
  -w [ --window ] arg (=1000)           window length
  -e [ --chrend ] arg (=0)              chromosome end window [0: deactivate]
  -o [ --outfile ] arg (="out.tsv")     output file
  -n [ --nomix ]                        do not mix repeat units
```


## Metadata
- **Skill**: generated
