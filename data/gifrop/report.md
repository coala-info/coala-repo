# gifrop CWL Generation Report

## gifrop

### Tool Description
This script should be executed from a directory that contains a roary generated 'gene_presence_absence.csv' file and all of the prokka annotated gff files that were used to run roary.

### Metadata
- **Docker Image**: quay.io/biocontainers/gifrop:0.0.9--hdfd78af_0
- **Homepage**: https://github.com/jtrachsel/gifrop
- **Package**: https://anaconda.org/channels/bioconda/packages/gifrop/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gifrop/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jtrachsel/gifrop
- **Stars**: N/A
### Original Help Text
```text
This is gifrop 0.0.9

command issued: 
/usr/local/bin/gifrop -help
===== Dependencies check =====
parallel      .... good
abricate      .... good
Rscript       .... good
find          .... good
[1] "All required R packages were detected"
To run the main program, please specify "--get_islands"
     See the help below: 


Usage:

  gifrop [OPTION]...

This script should be executed from a directory that contains a roary generated
'gene_presence_absence.csv' file and all of the prokka annotated gff files
that were used to run roary.

 Options:
  -h, --help        Display this help and exit
  -t, --threads     Number of threads to use for parallel abricate commands
  -n, --no_plots    Don't generate plots
  -m, --min_genes   Only return islands with greater than this many genes (4)
  -f, --flank_dna   output this many bases of DNA on either side of each island (0)
  -v, --version     Output version information and exit
  -r, --reference   Find genomic islands relative to this reference
  --get_islands     Run the main program to extract genomic islands
  --split_islands   Write one fasta file for each genomic island
  --scut            prune edges with OC less than scut before secondary cluster (.5)
  --tcut            prune edges with OC less than tcut before tertiary cluster (.75)
  --qcut            prune edges with jaccard sim less than qcut before quat cluster (.75)


Example:

gifrop --get_islands --min_genes 5 --threads 16 --split_islands
```

