# lusstr CWL Generation Report

## lusstr_config

### Tool Description
Create config file for running STR pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/lusstr:0.11--pyhdfd78af_0
- **Homepage**: https://www.github.com/bioforensics/lusSTR
- **Package**: https://anaconda.org/channels/bioconda/packages/lusstr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lusstr/overview
- **Total Downloads**: 18.5K
- **Last updated**: 2025-06-17
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: lusstr config [-h] [-w W] [-a {uas,straitrazor,genemarker}]
                     [--input INPUT] [--out OUT] [--powerseq] [--sex]
                     [--nocombine] [--reference]
                     [--software {efm,mpsproto,strmix}]
                     [--str-type {ce,ngs,lusplus}] [--noinfo] [--separate]
                     [--nofiltering] [--snps] [--snp-type SNPTYPE]
                     [--kintelligence] [--snp-reference REF]
                     [--strand {uas,forward}] [--custom]

Create config file for running STR pipeline

options:
  -h, --help            show this help message and exit
  -w W, --workdir W     directory to add config file; default is current
                        working directory
  -a {uas,straitrazor,genemarker}, --analysis-software {uas,straitrazor,genemarker}
                        Analysis software program used prior to lusSTR.
                        Choices are uas, straitrazor or genemarker. Default is
                        uas.
  --input INPUT         Input file or directory
  --out OUT, -o OUT     Output file/directory name
  --powerseq            Use to indicate sequences were created using the
                        PowerSeq Kit.
  --sex                 Use if including the X and Y STR markers. Separate
                        reports for these markers will be created.
  --nocombine           Do not combine read counts for duplicate sequences
                        within the UAS region during the 'convert' step. By
                        default, read counts are combined for sequences not
                        run through the UAS.
  --reference           Use for creating Reference profiles for STR workflow
  --software {efm,mpsproto,strmix}
                        Specify the probabilistic genotyping software package
                        of choice. The final output files will be in the
                        correct format for direct use. Default is strmix.
  --str-type {ce,ngs,lusplus}
                        Data type for STRs. Options are: CE allele ('ce'),
                        sequence or bracketed sequence form('ngs'), or LUS+
                        allele ('lusplus'). Default is 'ngs'.
  --noinfo              Use to not create the Sequence Information File in the
                        'filter' step
  --separate            Use to separate EFM profiles in the 'filter' step. If
                        specifying for SNPs, each sample will also be
                        separated into 10 different bins for mixture
                        deconvolution.
  --nofiltering         For STRs, use to perform no filtering during the
                        'filter' step. For SNPs, only alleles specified as
                        'Typed' by the UAS will be included at the 'format'
                        step.
  --snps                Use to create a config file for the SNP workflow
  --snp-type SNPTYPE    Specify the type of SNPs to include in the final
                        report. 'p' will include only the Phenotype SNPs; 'a'
                        will include only the Ancestry SNPs; 'i' will include
                        only the Identity SNPs; and 'all' will include all
                        SNPs. More than one type can be specified (e.g. 'p,
                        a'). Default is all.
  --kintelligence       Use if processing Kintelligence SNPs within a
                        Kintellience Report(s)
  --snp-reference REF   Specify any references for SNP data for use in EFM.
  --strand {uas,forward}
                        Specify the strand orientation for the final output
                        files. UAS orientation is default for STRs; forward
                        strand is default for SNPs.
  --custom              Specifying custom sequence ranges.
```


## lusstr_gui

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/lusstr:0.11--pyhdfd78af_0
- **Homepage**: https://www.github.com/bioforensics/lusSTR
- **Package**: https://anaconda.org/channels/bioconda/packages/lusstr/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: lusstr gui [-h]

options:
  -h, --help  show this help message and exit
```


## lusstr_snps

### Tool Description
Running the SNP pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/lusstr:0.11--pyhdfd78af_0
- **Homepage**: https://www.github.com/bioforensics/lusSTR
- **Package**: https://anaconda.org/channels/bioconda/packages/lusstr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lusstr snps [-h] [-w W] {format,all}

Running the SNP pipeline

positional arguments:
  {format,all}       Steps to run. Specifying 'format' will run only 'format'.
                     Specifying 'all' will run all steps of the SNP workflow
                     ('format' and 'convert').

options:
  -h, --help         show this help message and exit
  -w W, --workdir W  working directory
```


## lusstr_strs

### Tool Description
Running the STR pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/lusstr:0.11--pyhdfd78af_0
- **Homepage**: https://www.github.com/bioforensics/lusSTR
- **Package**: https://anaconda.org/channels/bioconda/packages/lusstr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lusstr strs [-h] [-w W] {format,convert,all}

Running the STR pipeline

positional arguments:
  {format,convert,all}  Steps to run. Specifying 'format' will run only
                        'format'. Specifying 'convert' will run both 'format'
                        and 'convert'. Specifying 'all' will run all steps of
                        the STR workflow ('format', 'convert' and 'filter').

options:
  -h, --help            show this help message and exit
  -w W, --workdir W     working directory
```


## Metadata
- **Skill**: generated
