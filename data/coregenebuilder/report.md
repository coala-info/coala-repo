# coregenebuilder CWL Generation Report

## coregenebuilder

### Tool Description
CoreGeneBuilder extracts a core genome or a persistent genome from a set of bacterial genomes. The core genome is the set of homologous genes (protein families) shared by all genomes. The persistent genome is the set of homologous genes (protein families) shared by less than 100% of the genomes.

### Metadata
- **Docker Image**: biocontainers/coregenebuilder:v1.0_cv2
- **Homepage**: https://github.com/C3BI-pasteur-fr/CoreGeneBuilder
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coregenebuilder/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/C3BI-pasteur-fr/CoreGeneBuilder
- **Stars**: N/A
### Original Help Text
```text
CoreGeneBuilder version 1.0

USAGE :
     /usr/local/bin/coregenebuilder [options] -d <input_directory> -n <name_of_4_chars>
   -d <inDirectory>  directory where are stored input and output files, it must contain at least a directory called assemblies where are genomic sequence fasta files
   -n <string>  four letter name (ex : esco (es:escherichia; co:coli))
  where 'options' are :
   ### PRE-PROCESSING OF GENOMIC SEQUENCES ###
   -f <int>     filtering out genomic sequences below this length value (bp) (default : 500); if 0, no filter
   -N <int>     cut sequences with mers of 'N' of size '-N' (scaffolds) into contigs (default : 10); if -1, no filter
   -y <int>     filtering out genomes having N50 below this N50 value (bp) (default : 0); if 0, no filter
   -c <int>     filtering out genomes having number of sequences above this value (default : -1); if -1, no filter
   ### DIVERSITY ###
   -s <int>     number of genomes to select for core genome construction (default : -1); if -1, no selection (all genomes are kept)
   ### CORE-GENOME ###
   -i <int>     similarity percent (default : 80) -- core genome construction step
   -l <float>   protein length ratio (default : 1.2) -- core genome construction step
   -S <int>     synteny - synteny threshold : minimal number of syntenic genes found in the neighborhood of a given homologous gene, 
                      the boundaries of explored neighborood are defined by window size (option -R); (default : 4); if 0, no synteny criteria is applied
   -R <int>     synteny - radius size around each analyzed homologous gene (a number of genes) (default : 5) -- window_size=(radius_size * 2 + 1)
   -p <int>     core genes are present at least in p% of the genomes (default : 95) -- if '-p 100' is supplied, core gene set is output; else if 'p' is lower than 100, persistent gene set is output
   ### GENERAL OPTIONS ###
   -z <STEPS>   steps to run ; ex : '-z DAC' or '-z DA' or '-z D' ; D : diversity - A : annotation - C : coregenome (default: DAC)
   -g <inFile>  reference genome fasta file -- annotation and core genome construction steps
   -a <inFile>  reference genome genbank file -- annotation step
   -e <inFile>  prefix string of contig ids found in the reference genome fasta and genbank files (eg id in fields LOCUS and ACCESSION of genbank file) (ex : 'NC_'; 'NZ_' ; 'AKAC' ; etc)
   -t <int>     number of threads used during diversity and annotation steps (default : 1)
   -r <int>     if 1, remove files from precedent run of this pipeline inside directory <input_directory> (default : 0)
   -v           print version number
   -h           print help

DESCRIPTION :
     CoreGeneBuilder version 1.0
     CoreGeneBuilder extracts a core genome or a persistent genome from a set of bacterial genomes.
     The core genome is the set of homologous genes (protein families) shared by all genomes.
     The persistent genome is the set of homologous genes (protein families) shared by less than 100% of the genomes.

CITATION :
     Please cite CoreGeneBuilder using the DOI of this release (see README.md file).

EXAMPLES :
     #provided reference genome and related genbank annotation, the functional annotation of reference genome will be transferred to the other genomes:
     /usr/local/bin/coregenebuilder -d klpn5refannot -n klpn -g MGH78578_NC.fasta -a MGH78578_NC.gb -e NC_ -p 95 -t 1 -s 3

     #provided reference genome but not provided related genbank annotation, the reference genome will be de novo annotated:
     /usr/local/bin/coregenebuilder -d klpn5refannot -n klpn -g MGH78578_NC.fasta -p 95 -t 1 -s 3

     #not provided reference genome and related genbank annotation, the reference genome will be the first on the genome list sorted alphabetically:
     /usr/local/bin/coregenebuilder -d klpn5refannot -n klpn -p 100 -t 1 -s 3
```

