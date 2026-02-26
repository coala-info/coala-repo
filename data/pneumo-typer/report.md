# pneumo-typer CWL Generation Report

## pneumo-typer

### Tool Description
A comprehensive prediction and visualization of serotype and sequence type for streptococcus pneumoniae using assembled genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pneumo-typer:2.0.1--hdfd78af_0
- **Homepage**: https://www.microbialgenomic.cn/Pneumo-Typer.html
- **Package**: https://anaconda.org/channels/bioconda/packages/pneumo-typer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pneumo-typer/overview
- **Total Downloads**: 82.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Thu Feb 26 18:35:07 2026: pneumo-typer.pl start...


=NAME

Pneumo-Typer

=DESCRIPTION

    A comprehensive prediction and visualization of serotype and sequence type for streptococcus pneumoniae using assembled genomes. 

=USAGE

pneumo-typer.pl -d genbank_file_directory [options]

FOR EXAMPLE: 

perl pneumo-typer.pl -d Test_data -t 10  -p T


#######################################################################################################################################
=ARGUMENTS
=======================
    REQUIRED ARGUMENTS:
    ~~~~~~~~~~~~~~~~~~~
       -d, --genbank_file_directory
           A directory containing files in GenBank format, FASTA format, or a combination of both.                           
    OPTIONAL ARGUMENTS:
    ~~~~~~~~~~~~~~~~~~~
       -o, --output_directory
           An output directory holding all the generated files by pneumo-typer.pl. if this option is not set,  a directory named "pneumo-typer_workplace" will be created in the bin directory from where pneumo-typer.pl was invoked.
       -t, --multiple_threads
           Set thread number (Default: 1)
       -Ss, --skip_sequence_processing 
           Skip the process of sequence processing (STEP-1) (Default: F).  
       -hgc, --homologous_gene_cutoff
           Set E-value, Identify, Coverage (Query and Subject), Match_length (alignment length) cutoff in Blastn analysis (default: E-value=1e-5, Identify=70, Coverage=95, Match_length=100).
       -Sb, --skip_blastn
           Skip the process of doing blastn during serotype analysis.
       -p, --prodigal_annotation
           Annotate all genomes using prodigal (Default: T). 
       -m, --mlst
           Perform mlst analysis (Default: T). 
       -c, --cgmlst
           Perform cgmlst analysis. It needs about 3 mins for one genome (Default: F).
       -Rh, --recreate_heatmap                             
           Re-create the heatmap of cps gene distribution in genomes (Default: F). At this step, users can add a parameter "phylogenetic_tree" or "strain_reorder_file". 
       -Rf, --recreate_figure
           Re-create the figure of the genetic organization of cps gene cluster for genomes (Default: F). At this step, users can add a parameter "phylogenetic_tree" or "strain_reorder_file".
       -tree, --phylogenetic_tree
           A Newick format tree file is used by Pneumo-Typer to automatically associate the genomes with their phylogeny. Meanwhile, Pneumo-Typer will output a file named "temp_strain_reorder_file-svg.txt", which contains the order information of genomes in the tree from up to down. It should be noted that all node names in the provided tree must completely match the input file names of all genomes.
       -srf, --strain_reorder_file
           A two-column tab-delimited text file is used to sort genomes from up to down according to users' requirements. Each row must consist of a strain name followed by the numerical order that is used for sorting genomes. It should be noted that all strain names must completely match the input file names of all genomes.
       -Ts, --test
           Run pneumo-typer using Test_data as input to check whether Pneumo-Typer is installed successfully (Default: F).
       -V, --version
           The version of Pneumo-Typer.
       -h, --help
           Show this message.

=AUTHOR

Dr. Xiangyang Li (E-mail: lixiangyang@fudan.edu.cn), Kaili University; Bacterial Genome Data mining & Bioinformatic Analysis (www.microbialgenomic.cn/).

=COPYRIGHT

Copyright 2024, Xiangyang Li. All Rights Reserved.
```

