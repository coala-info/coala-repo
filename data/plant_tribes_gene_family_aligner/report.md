# plant_tribes_gene_family_aligner CWL Generation Report

## plant_tribes_gene_family_aligner_GeneFamilyAligner

### Tool Description
ALIGN GENE FAMILY SEQUENCES

### Metadata
- **Docker Image**: quay.io/biocontainers/plant_tribes_gene_family_aligner:1.0.4--hdfd78af_1
- **Homepage**: https://github.com/dePamphilis/PlantTribes
- **Package**: https://anaconda.org/channels/bioconda/packages/plant_tribes_gene_family_aligner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plant_tribes_gene_family_aligner/overview
- **Total Downloads**: 20.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dePamphilis/PlantTribes
- **Stars**: N/A
### Original Help Text
```text
Unknown option: help

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#                                  ALIGN GENE FAMILY SEQUENCES
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  Required Options:
#
#  --orthogroup_faa <string>       : Directory containing gene family classification orthogroup protein fasta files
#
#  --alignment_method <string>     : Multiple sequence alignment method:
#                                    If MAFFT algorithm: mafft
#                                    If PASTA algorithm: pasta 
#
# # # # # # # # # # # # # # # # # #
#  Codon Alignments: 
#
#  --codon_alignments              : Construct orthogroup multiple codon alignments - corresponding gene family classification
#                                    orthogroups CDS fasta files should be in the same directory with input orthogroups protein
#                                    fasta files.
#
# # # # # # # # # # # # # # # # # #
#  MSA Quality Control Options:
#
#  --automated_trimming            : Trims alignments using trimAl's ML heuristic trimming approach - incompatible "--gap_trimming"  
#                                    
#  --gap_trimming <float>          : Removes gappy sites in alignments (i.e. 0.1 removes sites with 90% gaps): [0.0 to 1.0]
#
#  --remove_sequences <float>      : Removes gappy sequences in alignments (i.e. 0.7 removes sequences with more than 30% gaps): [0.1 to 1.0]
#                                    - requires either "--automated_trimming" or "--gap_trimming"
#
#  --iterative_realignment <int>   : Iterative orthogroups realignment, trimming and fitering - requires "--remove_sequences"
#                                    (maximum number of iterations) 
#
# # # # # # # # # # # # # # # # # # 
#  Others Options:
#
#  --num_threads <int>             : number of threads (CPUs) to assign to external utilities (MAFFT and PASTA)
#                                    Default: 1 
#
#  --max_memory <int>              : maximum memory (in mb) available to PASTA's java tools - requires "--alignment_method = pasta" 
#                                    Default: 256
# 
#  --pasta_iter_limit <int>        : Maximum number of iteration that the PASTA algorithm will run - requires "--alignment_method = pasta"  
#                                    Default: 3
#
#  --pasta_script_path <string>    : Optional path to the location of the run_pasta.py script. which is used for running PASTA
#                                    from the command line (useful since the script is a .py file).  Using this will override
#                                    the default defined in ~home/config/plantTribes.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  Example Usage:
#
#  GeneFamilyAligner --orthogroup_faa integratedGeneFamilies_dir --alignment_method mafft
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
```

