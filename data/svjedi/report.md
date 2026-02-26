# svjedi CWL Generation Report

## svjedi_svjedi.py

### Tool Description
Structural variations genotyping using long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/svjedi:1.1.6--hdfd78af_1
- **Homepage**: https://github.com/llecompte/SVJedi
- **Package**: https://anaconda.org/channels/bioconda/packages/svjedi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svjedi/overview
- **Total Downloads**: 10.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/llecompte/SVJedi
- **Stars**: N/A
### Original Help Text
```text
usage: svjedi.py [-h] [--version] -v <vcffile> [-r <refgenomefile>]
                 [-a <refallelefile>] [-i [<readfile> ...]] [-p <paffile>]
                 [-t <nb_threads>] [-o <output>] [-dover <dist_overlap>]
                 [-dend <dist_end>] [-ladj <allele_size>] [-ms <minNbAln>]
                 [-d [<seq data type>]]

Structural variations genotyping using long reads

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -v <vcffile>, --vcf <vcffile>
                        vcf format
  -r <refgenomefile>, --ref <refgenomefile>
                        fasta format
  -a <refallelefile>, --allele <refallelefile>
                        fasta format
  -i [<readfile> ...], --input [<readfile> ...]
                        reads
  -p <paffile>, --paf <paffile>
                        PAF format
  -t <nb_threads>, --threads <nb_threads>
                        Number of threads
  -o <output>, --output <output>
                        genotype output file
  -dover <dist_overlap>
                        breakpoint distance overlap
  -dend <dist_end>      soft clipping length allowed for semi global
                        alingments
  -ladj <allele_size>   Sequence allele adjacencies at each side of the SV
  -ms <minNbAln>, --minsupport <minNbAln>
                        Minimum number of alignments to genotype a SV
                        (default: 3>=)
  -d [<seq data type>], --data [<seq data type>]
```

