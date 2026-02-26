# mtbseq CWL Generation Report

## mtbseq_MTBseq

### Tool Description
This pipeline generates mappings and calls variants from input samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/mtbseq:1.1.0--hdfd78af_1
- **Homepage**: https://github.com/ngs-fzb/MTBseq_source
- **Package**: https://anaconda.org/channels/bioconda/packages/mtbseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mtbseq/overview
- **Total Downloads**: 13.3K
- **Last updated**: 2025-05-07
- **GitHub**: https://github.com/ngs-fzb/MTBseq_source
- **Stars**: N/A
### Original Help Text
```text
MTBseq 1.1.0 - Copyright (C) 2018   Thomas A. Kohl, Robin Koch, Christian Utpatel,
                                 Maria Rosaria De Filippo, Viola Schleusener,
                                 Patrick Beckert, Daniela M. Cirillo, Stefan Niemann

   This program comes with ABSOLUTELY NO WARRANTY. This is free software,
   and you are welcome to redistribute it under certain conditions.


   [USAGE]: MTBseq [--OPTION PARAMETER]

   [DESCRIPTION]: This pipeline generates mappings and calls variants from input samples.

   [OPTIONS & PARAMETER]: Please read the README.pdf for detailed information about the parameter!

   --help         This help message
   --version      Version of MTBseq
   --check        Check the dependencies of MTBseq
   --step
      <ESSENTIAL> This is an essential option! Choose your pipeline step as a parameter!
      TBfull      Full workflow
      TBbwa       Read mapping
      TBrefine    Refinement of mapping(s)
      TBpile      Creation of mpileup file(s)
      TBlist      Creation of position list(s)
      TBvariants  Calling variants
      TBstats     Statisitcs of mapping(s) and variant calling(s)
      TBstrains   Calling lineage from sample(s)
      TBjoin      Joint variant analysis from defined samples
      TBamend     Amending joint variant table(s)
      TBgroups    Detecting groups of samples

   --continue
   <OPTIONAL> Ensures that the pipeline continues after selecting a certain pipeline step that is not TBfull.

   --samples
   <OPTIONAL> Specifies a column separated text file with sampleID in column 1 and libID in column 2 for pipeline steps after TBstats.

   --project
   <OPTIONAL> Specifiies a project name to identify your joint analysis. Essential for TBamend and TBgroups.

   --resilist
   <OPTIONAL> Specifies a  file of resistance mediating SNPs for resistance prediction. See the README.pdf for file properties.

   --intregions
   <OPTIONAL> Specifies an interesting region files for extended resistance prediction. See the README.pdf for file properties.

   --categories
   <OPTIONAL> Specifies a gene categories file to detect essential and non-essential genes as well as repetitive regions. See the README.pdf for file properties.

   --basecalib
   <OPTIONAL> Specifies file for base quality recalibration. See the README.pdf for file properties.

   --ref M._tuberculosis_H37Rv_2015-11-13
   <OPTIONAL> Reference genome for mapping without .fasta extension.

   --minbqual 13
   <OPTIONAL> Defines minimum positional mapping quality during variant calling.

   --all_vars
   <OPTIONAL> If set, all variant (unambiguous and ambiguous) and invariant sites will be reported.

   --snp_vars
   <OPTIONAL> If set, only unambigous SNPs will be reported. No Insertions nd Deletions will be reported.

   --lowfreq_vars
   <OPTIONAL> If set, alternative low frequency alleles competing with majority reference alleles will be reported (useful for the detection of subpopulations).

   --mincovf 4
   <OPTIONAL> Defines minimum forward read coverage for a putative variant position.

   --mincovr 4
   <OPTIONAL> Defines minimum reverse read coverage for a putative variant position.

   --minphred20 4
   <OPTIONAL> Defines the minimum number of reads having a phred score above or equal 20 to be considered as a putative variant.

   --minfreq 75
   <OPTIONAL> Defines minimum allele frequency for majority allele.

   --unambig 95
   <OPTIONAL> Defines minimum percentage of samples having unambigous base call in TBamend analysis.

   --window 12
   <OPTIONAL> Defines window for SNP cluster look up. Reduces putative false positives in TBamend.

   --distance 12
   <OPTIONAL> Defines SNP distance for the single linkage clustering in TBgroups.

   --quiet
   <OPTIONAL> Turns off Display logging process.

   --threads 1
   <OPTIONAL> Defines number of CPUs to use. The usage of 8 CPUs is maximum.

   [EXAMPLES]:

   MTBseq --step TBfull
   Default values and execute the whole pipeline.

   MTBseq --step TBrefine
   Default values and execute only the "TBrefine" step.

   MTBseq --step TBbwa --continue
   Default values and execute the "TBbwa" module as well as the downstream modules.

   MTBseq --step TBfull --threads 8 --lowfreq_vars --minfreq 20 --mincovf 2 --mincovr 2 --intregions /path/to/intregions/file
   Execute the whole pipeline with 8 threads, reporting low frequency variants with altered minimum threshholds and using an alternative intregions file.
```

