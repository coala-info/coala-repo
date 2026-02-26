# mreps CWL Generation Report

## mreps

### Tool Description
finds tandemly repeated fragments in a DNA sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/mreps:2.6.01--h7b50bb2_6
- **Homepage**: http://mreps.univ-mlv.fr/
- **Package**: https://anaconda.org/channels/bioconda/packages/mreps/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mreps/overview
- **Total Downloads**: 19.3K
- **Last updated**: 2025-08-28
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage:
       mreps [ <options> ] { <sequencefile> | -s <sequence> }
finds tandemly repeated fragments in a DNA sequence 

The options are :
 -s <string>  : specifies the sequence in command line
 -fasta       : allows DNA sequences in FASTA format 

 -res n       : "resolution" (error level)
 -from n      : starting position n
 -to n        : end position n
 -minsize n   : repeats whose size is at least n
 -maxsize n   : repeats whose size is at most n
 -minperiod n : repeats whose period is at least n
 -maxperiod n : repeats whose period is at most n
 -exp x       : repeats whose exponent is at least x
 -allowsmall  : output small repeats that can occur randomly

 -win n       : process by sliding windows of size 2*n overlaping by n
 -version     : show version
 -xmloutput <file> : outputs to <file> in xml format
 -noprint     : if specified, the repetition sequences will not be output 

Example:
mreps -res 3 -exp 3.0 -from 10000 -to 12000 ecolim52.fas
```


## Metadata
- **Skill**: generated
