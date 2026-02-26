# hlaprofiler CWL Generation Report

## hlaprofiler_HLAProfiler.pl

### Tool Description
A tool for predicting HLA types using NGS Paired-end sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/hlaprofiler:1.0.5--0
- **Homepage**: https://github.com/ExpressionAnalysis/HLAProfiler
- **Package**: https://anaconda.org/channels/bioconda/packages/hlaprofiler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hlaprofiler/overview
- **Total Downloads**: 30.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ExpressionAnalysis/HLAProfiler
- **Stars**: N/A
### Original Help Text
```text
is not a valid HLAProfiler module.


HLAProfiler.pl v1.0

DESCRIPTION
A tool for predicting HLA types using NGS Paired-end sequencing data.

USAGE:
perl HLAProfiler.pl <module>

Global Modules. These module will run the process from start to finish.
  build			Build the HLAProfiler reference using a reference FASTA
  predict		Predict the HLA types using paired end sequencing data.
  test_modules		This modules simply tests whether HLAProfiler.pl can access the required accessory perl modules
  test			This modules runs unit tests.

Build Module Components. These module complete individual steps in the build module.
  create_taxonomy	Creates a taxonomy needed to create a HLA database
  build_taxonomy	Builds the taxonomy into a database
  create_profiles	Simulated reads from the HLA reference and creates kmer profiles

Predict Module Components. These module complete individual steps in the predict module.
  filter		Filters paired fastq files into HLA genes using and HLA database
  count_reads		Counts the reads in fastq files to create a read count file
  predict_only		Only predicts HLA type using previously filtered and counted reads

For module specific instructions run each individual module with the help flag.
i.e. perl HLAProfiler.pl  build -h

AUTHORS:
Martin Buchkovich:martin.buchkovich@q2labsolutions.com
Chad Brown

CREATED:
1 Oct 2016

LAST UPDATED:
14 Jul 2017

Copyright. Q2 Solutions|EA Genomics. 2016
```

