# coprarna CWL Generation Report

## coprarna_CopraRNA2.pl

### Tool Description
CopraRNA is a tool for sRNA target prediction. It computes whole genome target predictions by combination of distinct whole genome IntaRNA predictions. As input CopraRNA requires at least 3 homologous sRNA sequences from 3 distinct organisms in FASTA format. Furthermore, each organisms' genome has to be part of the NCBI Reference Sequence (RefSeq) database (i.e. it should have exactly this NZ_* or this NC_XXXXXX format where * stands for any character and X stands for a digit between 0 and 9). Depending on sequence length (target and sRNA), amount of input organisms and genome sizes, CopraRNA can take up to 24h or longer to compute. In most cases it is significantly faster. It is suggested to run CopraRNA on a machine with at least 8 GB of memory.

CopraRNA produces a lot of file I/O. It is suggested to run CopraRNA in a dedicated empty directory to avoid unexpected behavior.

The central result table is CopraRNA_result.csv. Further explanations concerning the files in the run directory can be found in README.txt.

### Metadata
- **Docker Image**: quay.io/biocontainers/coprarna:2.1.4--hdfd78af_0
- **Homepage**: https://github.com/PatrickRWright/CopraRNA
- **Package**: https://anaconda.org/channels/bioconda/packages/coprarna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coprarna/overview
- **Total Downloads**: 33.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PatrickRWright/CopraRNA
- **Stars**: N/A
### Original Help Text
```text
CopraRNA 2.1.3

CopraRNA is a tool for sRNA target prediction. It computes whole genome target predictions
by combination of distinct whole genome IntaRNA predictions. As input CopraRNA requires
at least 3 homologous sRNA sequences from 3 distinct organisms in FASTA format.
Furthermore, each organisms' genome has to be part of the NCBI Reference Sequence (RefSeq)
database (i.e. it should have exactly this NZ_* or this NC_XXXXXX format where * stands
for any character and X stands for a digit between 0 and 9). Depending on sequence length
(target and sRNA), amount of input organisms and genome sizes, CopraRNA can take up to 24h
or longer to compute. In most cases it is significantly faster. It is suggested to run CopraRNA
on a machine with at least 8 GB of memory.

CopraRNA produces a lot of file I/O. It is suggested to run CopraRNA in a dedicated
empty directory to avoid unexpected behavior.

The central result table is CopraRNA_result.csv. Further explanations concerning the files
in the run directory can be found in README.txt.

The following options are available:

 --help                    this help

 --srnaseq                 FASTA file with small RNA sequences (def:input_sRNA.fa)
 --region                  region to scan in whole genome target prediction (def:5utr)
                           '5utr' for start codon
                           '3utr' for stop codon
                           'cds' for entire transcript
 --ntup                    amount of nucleotides upstream of '--region' to parse for targeting (def:200)
 --ntdown                  amount of nucleotides downstream of '--region' to parse for targeting (def:100)
 --cores                   amount of cores to use for parallel computation (def:1)
 --rcsize                  minimum amount (%) of putative target homologs that need to be available 
                           for a target cluster to be considered in the CopraRNA1 part (see --cop1) of the prediction (def:0.5)
 --winsize                 IntaRNA target (--tAccW) window size parameter (def:150)
 --maxbpdist               IntaRNA target (--tAccL) maximum base pair distance parameter (def:100)
 --cop1                    switch for CopraRNA1 prediction (def:off)
 --cons                    controls consensus prediction (def:0)
                           '0' for off
                           '1' for organism of interest based consensus
                           '2' for overall consensus based prediction
 --verbose                 switch to print verbose output to terminal during computation (def:off)
 --websrv                  switch to provide webserver output files (def:off)
 --noclean                 switch to prevent removal of temporary files (def:off)
 --enrich                  if entered then DAVID-WS functional enrichment is calculated with given amount of top predictions (def:off)
 --nooi                    if set then the CopraRNA2 prediction mode is set not to focus on the organism of interest (def:off)
 --ooifilt                 post processing filter for organism of interest p-value 0=off (def:0)
 --root                    specifies root function to apply to the weights (def:1)
 --topcount                specifies the amount of top predictions to return and use for the extended regions plots (def:200)

Example call: CopraRNA2.pl -srnaseq sRNAs.fa -ntup 200 -ntdown 100 -region 5utr -enrich 200 -topcount 200 -cores 4

License: MIT

References: 
1. Wright PR et al., Comparative genomics boosts target prediction for bacterial small RNAs
   Proc Natl Acad Sci USA, 2013, 110 (37), E3487–E3496
2. Wright PR et al., CopraRNA and IntaRNA: predicting small RNA targets, networks and interaction domains
   Nucleic Acids Research, 2014, 42 (W1), W119-W123
```

