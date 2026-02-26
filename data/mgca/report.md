# mgca CWL Generation Report

## mgca

### Tool Description
microbial genome component and annotation pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/mgca:0.0.0--pl5321hdfd78af_0
- **Homepage**: https://github.com/liaochenlanruo/mgca/blob/master/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/mgca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mgca/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/liaochenlanruo/mgca
- **Stars**: N/A
### Original Help Text
```text
VERSION:   0.0.0

SYNOPSIS:  microbial genome component and annotation pipeline

AUTHOR:    Hualin Liu

USAGE:     mgca <MODULE> <OPTIONS>

GENERAL
  --help                 This help.
  --version              Print version and exit.
  --citation             Print citation for referencing Prokka.

MODULES
  --PI                   Calculate statistics of protein properties and print pI of all protein sequences.
  --IS                   Predict genomic island from GenBank files.
  --PROPHAGE             Predict prophage sequences from GenBank files.
  --CRISPR               Finding CRISPR-Cas systems in genomics or metagenomics datasets.

Parameters of PI
  --AAsPath [X]          Amino acids of all strains as fasta file paths [].
  --aa_suffix [X]        Specify the suffix of Protein sequence files [.faa].

Parameters of IS
  --gbkPath [X]          GenBank file path [].
  --gbk_suffix [X]       Specify the suffix of GenBank files [.gbk].

Parameters of PROPHAGE
  --gbkPath [X]          GenBank file path [].
  --gbk_suffix [X]       Specify the suffix of GenBank files [.gbk].
  --phmms [X]            Specify the path of pVOG.hmm [/usr/local/bin/pVOGs.hmm].
  --min_contig_size [N]  Minimum contig size (in bp) to be included in the analysis. Smaller contigs will be dropped [5000].
  --phage_genes [N]      The minimum number of genes that must be identified as belonging to a phage for the region to be included [1].
  --threads [N]          Number of threads to use [6].

Parameters of CRISPR
  --scafPath [X]         Genome/Scaffolds/Contigs file path [].
  --scaf_suffix [X]      Specify the suffix of Genome/Scaffolds/Contigs files [.fa].
  --casDBpath [X]        The full path of cas database, not include the database name and the last '/' of the path [/usr/local/bin].
  --threads [N]          Number of threads to use [6].

COMMANDS

# Module PI: Calculate statistics of protein properties and print pI of all protein sequences
  mgca --PI --AAsPath <PATH> --aa_suffix <.faa>

# Module IS: Predict genomic island from GenBank files
  mgca --IS --gbkPath <PATH> --gbk_suffix <.gbk>

# Module PROPHAGE: Predict prophage sequences from GenBank files
  mgca --PROPHAGE --gbkPath <PATH> --gbk_suffix <.gbk> --phmms <Path of pVOG.hmm> --phage_genes <1> --min_contig_size <5000> --threads <6>

# Module CRISPR: Finding CRISPR-Cas systems in genomics or metagenomics datasets
  mgca --CRISPR --scafPath <PATH> --scaf_suffix <.fa> --casDBpath <db path> --threads <6>
```


## Metadata
- **Skill**: not generated
