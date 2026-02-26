# soapsnp CWL Generation Report

## soapsnp

### Tool Description
SoapSNP

### Metadata
- **Docker Image**: biocontainers/soapsnp:v1.03-3-deb_cv1
- **Homepage**: https://github.com/zzhangjii/soapsnp
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/soapsnp/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/zzhangjii/soapsnp
- **Stars**: N/A
### Original Help Text
```text
SoapSNP
Compulsory Parameters:
-i <FILE> Input SORTED Soap Result
-d <FILE> Reference Sequence in fasta format
-o <FILE> Output consensus file
Optional Parameters:(Default in [])
-z <Char> ASCII chracter standing for quality==0 [@]
-g <Double> Global Error Dependency Coefficient, 0.0(complete dependent)~1.0(complete independent)[0.9]
-p <Double> PCR Error Dependency Coefficient, 0.0(complete dependent)~1.0(complete independent)[0.5]
-r <Double> novel altHOM prior probability [0.0005]
-e <Double> novel HET prior probability [0.0010]
-t set transition/transversion ratio to 2:1 in prior probability
-s <FILE> Pre-formated dbSNP information
-2 specify this option will REFINE SNPs using dbSNPs information [Off]
-a <Double> Validated HET prior, if no allele frequency known [0.1]
-b <Double> Validated altHOM prior, if no allele frequency known[0.05]
-j <Double> Unvalidated HET prior, if no allele frequency known [0.02]
-k <Double> Unvalidated altHOM rate, if no allele frequency known[0.01]
-u Enable rank sum test to give HET further penalty for better accuracy. [Off]
-m Enable monoploid calling mode, this will ensure all consensus as HOM and you probably should SPECIFY higher altHOM rate. [Off]
-q Only output potential SNPs. Useful in Text output mode. [Off]
-M <FILE> Output the quality calibration matrix; the matrix can be reused with -I if you rerun the program
-I <FILE> Input previous quality calibration matrix. It cannot be used simutaneously with -M
-L <short> maximum length of read [45]
-Q <short> maximum FASTQ quality score [40]
-F <int> Output format. 0: Text; 1: GLFv2; 2: GPFv2.[0]
-E <String> Extra headers EXCEPT CHROMOSOME FIELD specified in GLFv2 output. Format is "TypeName1:DataName1:TypeName2:DataName2"[]
-T <FILE> Only call consensus on regions specified in FILE. Format: ChrName\tStart\tEnd.
-h Display this help
```


## Metadata
- **Skill**: generated
