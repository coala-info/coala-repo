# alloshp CWL Generation Report

## alloshp_WGA

### Tool Description
Whole Genome Alignment tool for comparing two genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0
- **Homepage**: https://github.com/eead-csic-compbio/AlloSHP
- **Package**: https://anaconda.org/channels/bioconda/packages/alloshp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/alloshp/overview
- **Total Downloads**: 1.0K
- **Last updated**: 2025-10-06
- **GitHub**: https://github.com/eead-csic-compbio/AlloSHP
- **Stars**: N/A
### Original Help Text
```text
usage: /usr/local/bin/WGA [options]

-h this message
-A FASTA file of genome A              (example: -A speciesA.fna[.gz])
-B FASTA file of genome B              (example: -B speciesB.fna[.gz])
-o output folder                       (optional, default: speciesA.speciesB)
-l min contig length [Mbp]             (optional, default: -l 1)
-m FASTA files already soft-masked     (optional, default: masked with Red
-n number of cores                     (optional, some tasks only, default: 4
-g use multithreaded GSAlign algorithm (optional, default: Cgaln)
-C parameters for Cgaln aligner        (optional, default: -C '-X4000')
-N parameters for Cgaln indexer        (optional, default: -N '-K11 -BS10000')
-G parameters for GSAlign aligner      (optional, default: -G '-no_vcf -one')
-M parameters for utils/mapcoords.pl   (optional, default: -M '0.25 0.05' ,
                                        1st: max ratio of mapped positions in other blocks,
                                        2nd: max ratio of coordinates with multiple positions in same block)
-t path to dir for temp files          (optional, default: -t /tmp)
-c print credits and checks install    (recommended)

version: 2025.09.12
```


## alloshp_vcf2alignment

### Tool Description
Convert VCF files to multiple sequence alignments (MSA) with optional filtering and configuration.

### Metadata
- **Docker Image**: quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0
- **Homepage**: https://github.com/eead-csic-compbio/AlloSHP
- **Package**: https://anaconda.org/channels/bioconda/packages/alloshp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/vcf2alignment [options]

-h this message
-v input VCF file                                  (example: -v data.vcf.gz)
-c input TSV config file                           (example: -c config.tsv)
-l output report file name, 1-based coordinates    (example: -l vcf.report.log.gz)
-o output MSA file name                            (optional, example: -o out.fasta)
-d min read depth at each position for each sample (optional, example: -d 3, default -d 3,
                                                              use -d 0 if VCF file lacks DP)
-m max missing samples                             (optional, example: -m 10, default -m 10
-f output format                                   (optional, example: -f nexus, default -f fasta)
-p take only polymorphic sites                     (optional, by default all sites, constant and SNPs, are taken)
-H take also heterozygous sites                    (optional, by default only homozygous are taken)

version: 2025.09.12

Primary citation: https://www.biorxiv.org/content/10.1101/2025.07.17.665301v1
```


## alloshp_vcf2synteny

### Tool Description
Convert VCF files to synteny FASTA/VCF formats based on a configuration file and reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0
- **Homepage**: https://github.com/eead-csic-compbio/AlloSHP
- **Package**: https://anaconda.org/channels/bioconda/packages/alloshp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/vcf2synteny [options]

-h this message
-v input VCF file                          (example: -v data.vcf.gz)
-l report file from vcf2alignment, 1-based (example: -l vcf.rport.log.gz)
-c input TSV config file                   (example: -c config.synteny.tsv)
-o output FASTA file name                  (example: -o out.fasta)
-r master reference genome                 (example: -r Bdis)
-d min depth of called SNPs                (optional, example: -d 3, default -d 3)
-m max missing samples                     (optional, example: -m 10, default -m 10
-V output VCF file name                    (optional, coordinates from -r genome, example: -f out.vcf)
-1 syntenic coords are 1-based             (optional, 0-based/BED by default, WGA in -c config.synteny.tsv)
-p take only polymorphic sites             (optional, by default all sites, constant and SNPs, are taken)
-H take also heterozygous sites            (optional, by default only homozygous, requires -l report from vcf2alignment -H)
-N new temp files, don't re-use            (optional, by default temp files are re-used if available at -t)
-t path to dir for temp file               (optional, default: -t /tmp)

version: 2025.09.12

Primary citation: https://www.biorxiv.org/content/10.1101/2025.07.17.665301v1
```

