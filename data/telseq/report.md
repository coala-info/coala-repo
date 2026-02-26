# telseq CWL Generation Report

## telseq

### Tool Description
Scan BAM and estimate telomere length.

### Metadata
- **Docker Image**: quay.io/biocontainers/telseq:0.0.2--h06902ac_8
- **Homepage**: https://github.com/zd1/telseq
- **Package**: https://anaconda.org/channels/bioconda/packages/telseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/telseq/overview
- **Total Downloads**: 13.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zd1/telseq
- **Stars**: N/A
### Original Help Text
```text
Program: TelSeq
Version: 0.0.1
Contact: Zhihao Ding [zhihao.ding@gmail.com]

Usage: telseq [OPTION] <in.1.bam> <in.2.bam> <...> 
Scan BAM and estimate telomere length. 
   <in.bam>                 one or more BAM files to be analysed. File names can also be passed from a pipe, 
                             with each row containing one BAM path.
   -f, --bamlist=STR        a file that contains a list of file paths of BAMs. It should has only one column, 
                            with each row a BAM file path. -f has higher priority than <in.bam>. When specified, 
                            <in.bam> are ignored.
   -o, --output_dir=STR     output file for results. Ignored when input is from stdin, in which case output will be stdout. 
   -H                       remove header line, which is printed by default.
   -h                       print the header line only. The text can be used to attach to result files, useful
                            when the headers of the result files are suppressed. 
   -m                       merge read groups by taking a weighted average across read groups of a sample, weighted by 
                            the total number of reads in read group. Default is to output each readgroup separately.
   -u                       ignore read groups. Treat all reads in BAM as if they were from a same read group.
   -k                       threshold of the amount of TTAGGG/CCCTAA repeats in read for a read to be considered telomeric. default = 7.

Testing functions
------------
   -r                       read length. default = 100
   -z                       use user specified pattern for searching [ATGC]*.
   -e, --exomebed=STR       specifiy exome regions in BED format. These regions will be excluded 
   -w,                      consider BAMs in the speicfied bamlist as one single BAM. This is useful when 
                            the initial alignemt is separated for some reason, such as one for mapped and one for ummapped reads. 
   --help                   display this help and exit

Report bugs to zhihao.ding@gmail.com
```

