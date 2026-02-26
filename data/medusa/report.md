# medusa CWL Generation Report

## medusa

### Tool Description
Medusa version 1.6

### Metadata
- **Docker Image**: quay.io/biocontainers/medusa:1.6--1
- **Homepage**: https://github.com/combogenomics/medusa
- **Package**: https://anaconda.org/channels/bioconda/packages/medusa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/medusa/overview
- **Total Downloads**: 4.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/combogenomics/medusa
- **Stars**: N/A
### Original Help Text
```text
Medusa version 1.6
usage: java -jar medusa.jar -i inputfile -v
available options:
 -d                                    OPTIONAL PARAMETER;The option *-d*
                                       allows for the estimation of the
                                       distance between pairs of contigs
                                       based on the reference genome(s):
                                       in this case the scaffolded contigs
                                       will be separated by a number of N
                                       characters equal to this estimate.
                                       The estimated distances are also
                                       saved in the
                                       <targetGenome>_distanceTable file.
                                       By default the scaffolded contigs
                                       are separated by 100 Ns
 -f <<draftsFolder>>                   OPTIONAL PARAMETER; The option *-f*
                                       is optional and indicates the path
                                       to the comparison drafts folder
 -gexf                                 OPTIONAL PARAMETER;Conting network
                                       and path cover are given in gexf
                                       format.
 -h                                    Print this help and exist.
 -i <<targetGenome>>                   REQUIRED PARAMETER;The option *-i*
                                       indicates the name of the target
                                       genome file.
 -n50 <<fastaFile>>                    OPTIONAL PARAMETER; The option
                                       *-n50* allows the calculation of
                                       the N50 statistic on a FASTA file.
                                       In this case the usage is the
                                       following: java -jar medusa.jar
                                       -n50 <name_of_the_fasta>. All the
                                       other options will be ignored.
 -o <<outputName>>                     OPTIONAL PARAMETER; The option *-o*
                                       indicates the name of output fasta
                                       file.
 -random <<numberOfRounds>>            OPTIONAL PARAMETER;The option
                                       *-random* is available (not
                                       required). This option allows the
                                       user to run a given number of
                                       cleaning rounds and keep the best
                                       solution. Since the variability is
                                       small 5 rounds are usually
                                       sufficient to find the best score.
 -scriptPath <<medusaScriptsFolder>>   OPTIONAL PARAMETER; The folder
                                       containing the medusa scripts.
                                       Default value: medusa_scripts
 -v                                    RECOMMENDED PARAMETER; The option
                                       *-v* (recommended) print on console
                                       the information given by the
                                       package MUMmer. This option is
                                       strongly suggested to understand if
                                       MUMmer is not running properly.
 -w2                                   OPTIONAL PARAMETER;The option *-w2*
                                       is optional and allows for a
                                       sequence similarity based weighting
                                       scheme. Using a different weighting
                                       scheme may lead to better results.
```

