# plant_tribes_gene_family_classifier CWL Generation Report

## plant_tribes_gene_family_classifier_GeneFamilyClassifier

### Tool Description
GENE FAMILY CLASSIFICATION

### Metadata
- **Docker Image**: quay.io/biocontainers/plant_tribes_gene_family_classifier:1.0.4--0
- **Homepage**: https://github.com/dePamphilis/PlantTribes
- **Package**: https://anaconda.org/channels/bioconda/packages/plant_tribes_gene_family_classifier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plant_tribes_gene_family_classifier/overview
- **Total Downloads**: 38.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dePamphilis/PlantTribes
- **Stars**: N/A
### Original Help Text
```text
Unknown option: help
Use of uninitialized value $scaffold in concatenation (.) or string at /usr/local/bin/GeneFamilyClassifier line 126.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#                                  GENE FAMILY CLASSIFICATION
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  Required Options:
#
#  --proteins <string>             : Amino acids (proteins) sequences fasta file (proteins.fasta)
#
#  --scaffold <string>             : Orthogroups or gene families proteins scaffold.  This can either be an absolute
#                                    path to the directory containing the scaffolds (e.g., /home/scaffolds/22Gv1.1)
#                                    or just the scaffold (e.g., 22Gv1.1).  If the latter, ~home/data is prepended to
#                                    the scaffold to create the absolute path.
#                                    the scaffold to create the absolute path.
#                                    If Monocots clusters (version 1.0): 12Gv1.0
#                                    If Angiosperms clusters (version 1.0): 22Gv1.0
#                                    If Angiosperms clusters (version 1.1): 22Gv1.1
#                                    If Green plants clusters (version 1.0): 30Gv1.0
#                                    If Other non PlantTribes clusters: XGvY.Z, where "X" is the number species in the scaffold,
#                                    and "Y.Z" version number such as 12Gv1.0. Please look at one of the PlantTribes scaffold
#                                    data on how data files and directories are named, formated, and organized.	
#
#  --method <string>               : Protein clustering method
#                                    If GFam: gfam
#                                    If OrthoFinder: orthofinder
#                                    If OrthoMCL: orthomcl
#                                    If Other non PlantTribes method: methodname, where "methodname" a nonempty string of
#                                    word characters (alphanumeric or "_"). No embedded special charaters or white spaces.
#
#  --classifier <string>           : Protein classification method 
#                                    If BLASTP: blastp
#                                    If HMMScan: hmmscan
#                                    If BLASTP and HMMScan: both
#
# # # # # # # # # # # # # # # # # # 
#  Others Options:
#
#  --config_dir <string>           : (Optional) Absolute path to the directory containing the default configuration files
#                                    for the selected scaffold defined by the value of the --scaffold parameter (e.g.,
#                                    /home/configs/22Gv1.1). If this parameter is not used, the directory containing the
#                                    default configuration files is set to ~home/config.
#
#  --num_threads <int>             : number of threads (CPUs) to used for HMMScan, BLASTP, and MAFFT
#                                    Default: 1 
#
#  --super_orthogroups <string>    : SuperOrthogroups MCL clustering - blastp e-value matrix between all pairs of orthogroups
#                                    If minimum e-value: min_evalue (default) 
#                                    If average e-value: avg_evalue
#
#  --single_copy_custom <string>   : Configuration file for single copy orthogroup custom selection - incompatible with
#                                    "--single_copy_taxa".  This must be an absolute path to the configuration file
#                                    (e.g., '~/home/scaffolds/22Gv1.1.singleCopy.config') or the string 'default'.   If the
#                                    latter, the config is defined to be ~/config_dir/~scaffold.singleCopy.config.  See the
#                                    single copy configuration files the config sub-directory of the installation on how to
#                                    customize the single copy selection.
#
#  --single_copy_taxa <int>        : Minimum single copy taxa required in orthogroup - incompatible with "--single_copy_custom"
#
#  --taxa_present <int>            : Minimum taxa required in single copy orthogroup - requires "--single_copy_taxa"
#
#  --orthogroup_fasta              : Create orthogroup fasta files - requires "--coding_sequences" for CDS orthogroup fasta
#                                    
#  --coding_sequences <string>     : Corresponding coding sequences (CDS) fasta file (cds.fasta)
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  Example Usage:
#
#  GeneFamilyClassifier --proteins proteins.fasta --scaffold 22Gv1.1 --method orthomcl --classifier blastp 
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
```

