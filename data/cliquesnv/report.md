# cliquesnv CWL Generation Report

## cliquesnv

### Tool Description
CliqueSNV is a tool for detecting sub-populations (cliques) of viruses or bacteria from NGS data.

### Metadata
- **Docker Image**: quay.io/biocontainers/cliquesnv:2.0.3--hdfd78af_0
- **Homepage**: https://github.com/vtsyvina/CliqueSNV
- **Package**: https://anaconda.org/channels/bioconda/packages/cliquesnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cliquesnv/overview
- **Total Downloads**: 15.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vtsyvina/CliqueSNV
- **Stars**: N/A
### Original Help Text
```text
CliqueSNV version: 2.0.3
Settings: {--help=true}
How to set arguments:
-m snv-illumina -- run one of predefined methods. Methods are: snv-pacbio, snv-illumina, snv-pacbio-vc, snv-illumina-vc
-in /usr/name/tmp/reads.sam -- input file
-outDir /usr/name/tmp/ -- folder with output.
-threads 4 -- how many threads to use in parallel. Usually just the number of cores is the best choice
Final command can look as follows:
java -jar clique-snv.jar -m snv-illumina -in data/flu.sam -outDir output/
More on parameters read at  https://github.com/vtsyvina/CliqueSNV
```

