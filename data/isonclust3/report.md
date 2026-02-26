# isonclust3 CWL Generation Report

## isonclust3_isONclust3

### Tool Description
Rust implementation of a novel de novo clustering algorithm. isONclust3 is a tool for clustering either PacBio Iso-Seq reads, or Oxford Nanopore reads into clusters, where each cluster represents all reads that came from a gene family. Output is a tsv file with each read assigned to a cluster-ID and a folder 'fastq' containing one fastq file per cluster generated. Detailed information is available in the isONclust3 paper.

### Metadata
- **Docker Image**: quay.io/biocontainers/isonclust3:0.3.0--h4349ce8_0
- **Homepage**: https://github.com/aljpetri/isONclust3
- **Package**: https://anaconda.org/channels/bioconda/packages/isonclust3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/isonclust3/overview
- **Total Downloads**: 410
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/aljpetri/isONclust3
- **Stars**: N/A
### Original Help Text
```text
Rust implementation of a novel de novo clustering algorithm. isONclust3 is a tool for clustering either PacBio Iso-Seq reads, or Oxford Nanopore reads into clusters, where each cluster represents all reads that came from a gene family. Output is a tsv file with each read assigned to a cluster-ID and a folder 'fastq' containing one fastq file per cluster generated. Detailed information is available in the isONclust3 paper.

Usage: isONclust3 [OPTIONS] --fastq <FASTQ> --outfolder <OUTFOLDER> --mode <MODE>

Options:
  -f, --fastq <FASTQ>
          Path to consensus fastq file(s)
  -i, --init-cl <INIT_CL>
          Path to initial clusters (stored in fasta format), which is required when --gff is set
  -k <K>
          Kmer length
  -w <W>
           window size
  -s <S>
           syncmer length
  -t <T>
           minimum syncmer position
  -o, --outfolder <OUTFOLDER>
          Path to outfolder
  -n, --n <N>
          Minimum number of reads for cluster [default: 1]
  -g, --gff <GFF>
          Path to gff3 file (optional parameter), requires a reference added by calling --init-cl <REFERENCE.fasta>
      --noncanonical
          we do not want to use canonical seeds
      --mode <MODE>
          Run mode of isONclust (pacbio or ont
      --seeding <SEEDING>
          seeding approach we choose
      --quality-threshold <QUALITY_THRESHOLD>
          quality threshold used for the data (standard: 0.9) 
      --verbose
          print additional information
      --post-cluster
          Run the post clustering step during the analysis (small improvement for results but much higher runtime)
      --no-fastq
          Do not write the fastq_files (no write_fastq in isONclust1)
      --min-shared-minis <MIN_SHARED_MINIS>
          Minimum overlap threshold for reads to be clustered together (Experimental parameter)
  -h, --help
          Print help
  -V, --version
          Print version
```

