# fseq CWL Generation Report

## fseq

### Tool Description
F-Seq Version 1.84

### Metadata
- **Docker Image**: quay.io/biocontainers/fseq:1.84--py35pl5.22.0_0
- **Homepage**: http://fureylab.web.unc.edu/software/fseq/
- **Package**: https://anaconda.org/channels/bioconda/packages/fseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fseq/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
F-Seq Version 1.84
usage: fseq [options]... [file(s)]...
 -b <background dir>     background directory (default=none)
 -c <arg>                genomic count of sequence reads (defualt =
                         calculated)
 -d <input dir>          input directory (default=current directory)
 -f <arg>                fragment size (default=estimated from data)
 -h                      print usage
 -l <arg>                feature length (default=600)
 -o <output dir>         output directory (default=current directory)
 -of <wig | bed | npf>   output format (default wig)
 -p <ploidy dir>         ploidy/input directory (default=none)
 -s <arg>                wiggle track step (default=1)
 -t <arg>                threshold (standard deviations) (default=4.0)
 -v                      verbose output
 -wg <arg>               wg threshold set (defualt = calculated)

You can also specify JVM parameters such as -D, -XX, or -Xm.
If you get an "OutOfMemory" error, simply increase the heap size by adding -Xmx parameter.
E.g. fseq -Xmx12g input.bed
```

