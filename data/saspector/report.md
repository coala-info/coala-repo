# saspector CWL Generation Report

## saspector_SASpector

### Tool Description
Short-read Assembly inSpector

### Metadata
- **Docker Image**: quay.io/biocontainers/saspector:0.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/alejocrojo09/SASpector
- **Package**: https://anaconda.org/channels/bioconda/packages/saspector/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/saspector/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/alejocrojo09/SASpector
- **Stars**: N/A
### Original Help Text
```text
usage: SASpector - Short-read Assembly inSpector [-h] -draft Contigs FASTA
                                                 [-ref [Reference FASTA]]
                                                 [-p [Prefix]] -dir Output
                                                 path [--force]
                                                 [-fl [Length flanks bp]]
                                                 [-db [Protein FASTA file]]
                                                 [-trf]
                                                 [-msh [mash sketch file]]
                                                 [-k [k size]] [-q]
                                                 [-c [BAM file]]

optional arguments:
  -h, --help            show this help message and exit
  -draft Contigs FASTA, --draft Contigs FASTA
                        Illumina FASTA file as contigs/draft genome
  -ref [Reference FASTA], --reference [Reference FASTA]
                        Completed assembly FASTA file as reference genome
  -p [Prefix], --prefix [Prefix]
                        Set the prefix of the files, use for example the
                        strain name
  -dir Output path, --outdir Output path
                        Output directory
  --force               Force output directory overwrite
  -fl [Length flanks (bp)], --flanking [Length flanks (bp)]
                        Add flanking regions [Default = 100 bp]
  -db [Protein FASTA file], --proteindb [Protein FASTA file]
                        BLAST protein database FASTA file
  -trf, --tandem_repeats
                        Run tandem repeat finder within missing regions
  -msh [mash sketch file], --mash_selection [mash sketch file]
                        Automatic selection of genome amongst RefSeq 202
                        database (complete genomes) /!\ Experimental feature!
  -k [k size], --kmers [k size]
                        Sourmash analysis
  -q, --quast           Run QUAST for unmapped regions against reference
                        assembly
  -c [BAM file], --coverage [BAM file]
                        Run SAMtools bedcov to look at short-read coverage in
                        the missing regions.Needs alignment of reads to the
                        reference genome in BAM format
```

