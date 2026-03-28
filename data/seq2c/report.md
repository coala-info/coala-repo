# seq2c CWL Generation Report

## seq2c_seq2cov.pl

### Tool Description
Calculate candidate variance for a given region(s) in an indexed BAM file. The default input is IGV's one or more entries in refGene.txt, but can be regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
- **Homepage**: https://github.com/AstraZeneca-NGS/Seq2C
- **Package**: https://anaconda.org/channels/bioconda/packages/seq2c/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seq2c/overview
- **Total Downloads**: 37.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AstraZeneca-NGS/Seq2C
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/seq2cov.pl [-hz] [-n name_reg] [-b bam] [-c chr] [-S start] [-E end] [-s seg_starts] [-e seg_ends] [-x #_nu] [-g gene] [-o ori] [-d depth] region_info

    The program will calculate candidate variance for a given region(s) in an indexed BAM file.  The default
    input is IGV's one or more entries in refGene.txt, but can be regions

    -h Print this help
    -a int:float
       Indicate that it's PCR amplicon based calling.  Each line in region_info represents a PCR amplicon (including primers).
       Two numbers in option are parameter to decide whether a particular read or pairs belongs to the amplicon. First is the 
       number of base pairs.  The second is the fraction of overlapped portion to the length of read or pairs.  If the edges of 
       reads (paired for Illumina) are within defined base pairs to the edges of amplicons and overlapped portion greater then
       the fraction, it's considered belonging to the amplicon.  Suggested values are: 10:0.95.  When given a 6 column amplicon
       format BED files, it'll be set to 10:0.95 automatically, but can still be overwritten by -a option.
    -n name_reg
       The regular expression to extract sample name from bam filename
    -N name
       Mutual exclusive to -n.  Set the sample name to name
    -b bam
       The indexed BAM file
    -c chr
       The column for chr
    -S start
       The column for region start, e.g. gene start
    -E end
       The column for region end, e.g. gene end
    -s seg_starts
       The column for segment starts in the region, e.g. exon starts
    -e seg_ends
       The column for segment ends in the region, e.g. exon ends
    -g gene
       The column for gene name
    -x num
       The number of nucleotide to extend for each segment, default: 0
    -z 
       Indicate whether it's zero based numbering, default is 1-based

AUTHOR
       Written by Zhongwu Lai, AstraZeneca, Boston, USA

REPORTING BUGS
       Report bugs to zhongwu@yahoo.com

COPYRIGHT
       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
```


## seq2c_cov2lr.pl

### Tool Description
The cov2lr.pl program will convert a coverage file to copy number profile.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
- **Homepage**: https://github.com/AstraZeneca-NGS/Seq2C
- **Package**: https://anaconda.org/channels/bioconda/packages/seq2c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/cov2lr.pl [-aH] [-c control] mapping_reads coverage.txt

    The /usr/local/bin/cov2lr.pl program will convert a coverage file to copy number profile.

    Arguments are:
    mapping_reads: Required.  A file containing # of mapped or sequenced reads for samples.  At least two columns.
                   First is the sample name, 2nd is the number of mapped or sequenced reads.
    coverage.txt:  The coverage output file from seq2cov.pl script.  Can also take from standard in or more than
                   one file.

    Options are:

    -a Indicate this is amplicon or exon based calling.  By default, it will aggregate at gene level.

    -M Indicate to adjust the MAD when transforming the distribution.  Default: no, or just simple linear function.
       If not sure, do not use this option.  It might have better performance when cohort size is over 30.

    -c sample(s)
       Specify the control sample(s), if aplicable.  Multiple controls are allowed, which are separated by ":"

    -F double
       The failed factor for individual amplicons.  If (the 80th percentile of an amplicon depth)/(the global median depth)
       is less than the argument, the amplicon is considered failed and will not be used in calculation.  Default: 0.2.
    
    -G Gender
       Take a file of gender information.  Two columns, first is sample name, second is either M or F.  If not provided,
       the program will try to guess.

    -Y chrYratio
       For gender testing, if chrY is designed.  Default: 0.15.  If chrY is carefully designed, such as Foundation's assay,
       default is good.  For exome, the number should be higher, such as 0.3.

    -Z Indicate to output the frozen_file and all parameters into file Seq2C.frozen.txt

    -z frozen_file

AUTHOR
       Written by Zhongwu Lai, AstraZeneca, Boston, USA

REPORTING BUGS
       Report bugs to zhongwu@yahoo.com

COPYRIGHT
       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
```


## seq2c_lr2gene.pl

### Tool Description
The lr2gene.pl program will convert a coverage file to copy number profile. The default parameters are designed for detecting such aberrations for high tumor purity samples, such as cancer cell lines.

### Metadata
- **Docker Image**: quay.io/biocontainers/seq2c:2019.05.30--pl526_0
- **Homepage**: https://github.com/AstraZeneca-NGS/Seq2C
- **Package**: https://anaconda.org/channels/bioconda/packages/seq2c/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/lr2gene.pl [-aPH] [-cy] [-F float] [-s min_amplicon_#] [-A float] [-D float] cov2lr.txt

    The /usr/local/bin/lr2gene.pl program will convert a coverage file to copy number profile.  The default parameters are designed for
    detecting such aberrations for high tumor purity samples, such as cancer cell lines.  For clinical samples,
    many parameters need to be adjusted.

    Arguments are:
    cov2lr.txt:  The coverage output file from cov2lr.pl script.  Can also take from standard in or more than
                   one file.

    Options are:

    -c Indidate that control sample is used for normalization
    -y Debugging mode

    -s int
       The minimum consecutive amplicons to look for deletions and amplifications.  Default: 1.  Use with caution
       when it is less than 3.  There might be more false positives.  Though it has been successfully applied with
       option "-s 1" and identified one-exon deletion of PTEN and TP53 that were confirmed by RNA-seq.


    For whole gene:
    -A float
       Minimum log2 ratio for a whole gene to be considered amplified.  Default: 1.50

    -D float
       Minimum log2 ratio for a whole gene to be considered deleted.  Default: -2.00


    For < 3 exons:
    -E float
       Minimum mean log2 ratio difference for <3 exon deletion/amplification to be called.  Default: 1.25

    -M float
       When considering partial deletions less than 3 exons/amplicons, the minimum MAD value, in addition to -E,
       before considering it to be amplified or deleted.  Default: 10

    -d float
       When considering >=3 exons deletion/amplification within a gene, the minimum differences between the log2 of two segments.
       Default: 0.5

    -p float (0-1)
       The p-value for t-test when consecutive exons/amplicons are >= 3.  Default: 0.00001


    For break point in the middle of the gene:
    -e float
       When considering breakpoint in the middle of a gene, the minimum number of exons.  Default: 5

    -t float
       When considering breakpoint in the middle of a gene, the minimum differences between the log2 of two segments.
       Default: 0.4

    -P float (0-1)
       The p-value for t-test when the breakpoint is in the middle with min exons/amplicons >= [-e].  Default: 0.000001

    For cohort level aberrations:
    -R float (0-1)
       If a breakpoint has been detected more than "float" fraction of samples, it is considered false positive and removed.
       Default: 0.03, or 3%.  Use in combination with -N

    -N int
       If a breakpoint has been detected more than "int" samples, it is considered false positives and removed.
       Default: 5.  Use in combination with -R.

AUTHOR
       Written by Zhongwu Lai, AstraZeneca, Boston, USA

REPORTING BUGS
       Report bugs to zhongwu@yahoo.com

COPYRIGHT
       This is free software: you are free to change and redistribute it.  There is NO WARRANTY, to the extent permitted by law.
```


## Metadata
- **Skill**: generated
