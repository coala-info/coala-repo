# plant_tribes_gene_family_phylogeny_builder CWL Generation Report

## plant_tribes_gene_family_phylogeny_builder_GeneFamilyPhylogenyBuilder

### Tool Description
GENE FAMILY PHYLOGENETIC INFERENCE

### Metadata
- **Docker Image**: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
- **Homepage**: https://github.com/dePamphilis/PlantTribes
- **Package**: https://anaconda.org/channels/bioconda/packages/plant_tribes_gene_family_phylogeny_builder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plant_tribes_gene_family_phylogeny_builder/overview
- **Total Downloads**: 21.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dePamphilis/PlantTribes
- **Stars**: N/A
### Original Help Text
```text
Unknown option: help

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#                                  GENE FAMILY PHYLOGENETIC INFERENCE
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  Required Options:
#
#  --orthogroup_aln <string>       : Directory containing gene family orthogroup alignment files
#
#  --tree_inference <string>       : Phylogenetic trees inference method
#                                    If RAxML: raxml
#                                    If FastTree: fasttree
#
# # # # # # # # # # # # # # # # # #
#  Others Options:
#
#  --scaffold <string>             : Orthogroups or gene families proteins scaffold.  This can either be an absolute
#                                    path to the directory containing the scaffolds (e.g., /home/scaffolds/22Gv1.1)
#                                    or just the scaffold (e.g., 22Gv1.1).  If the latter, ~home/data is prepended to
#                                    the scaffold to create the absolute path.
#                                    If Monocots clusters (version 1.0): 12Gv1.0
#                                    If Angiosperms clusters (version 1.0): 22Gv1.0
#                                    If Angiosperms clusters (version 1.1): 22Gv1.1
#                                    If Green plants clusters (version 1.0): 30Gv1.0
#                                    If Other non PlantTribes clusters: XGvY.Z, where "X" is the number species in the scaffold,
#                                    and "Y.Z" version number such as 12Gv1.0. Please look at one of the PlantTribes scaffold
#                                    data on how data files and directories are named, formated, and organized.
#
#  --method <string>               : Protein clustering method for the classification scaffold
#                                    If GFam: gfam
#                                    If OrthoFinder: orthofinder
#                                    If OrthoMCL: orthomcl
#                                    If Other non PlantTribes method: methodname, where "methodname" a nonempty string of
#                                    word characters (alphanumeric or "_"). No embedded special charaters or white spaces.
#
#  --config_dir <string>           : (Optional) Absolute path to the directory containing the default configuration files
#                                    for the selected scaffold defined by the value of the --scaffold parameter (e.g.,
#                                    /home/configs/22Gv1.1). If this parameter is not used, the directory containing the
#                                    default configuration files is set to ~home/config.
#
#  --max_orthogroup_size <int>     : Maximum number of sequences in orthogroup alignments
#                                    Default: 100  
#
#  --min_orthogroup_size <int>     : Minimum number of sequences in orthogroup alignments
#                                    Default: 4
#
#  --rooting_order <string>        : File with a list of string fragments matching sequences identifiers of species in the 
#                                    classification (including scaffold taxa) to be used for determining the most basal taxa in
#                                    the orthogroups for rooting trees. Should be listed in decreasing order from older to younger
#                                    lineages. If the file is not provided, trees will be rooted using the most distant taxon
#                                    present in the orthogroup (see example rooting order configuration files in config sub-directory
#                                    of the installation). 
#                                    - requires "--tree_inference" with RAxML
#
#  --bootstrap_replicates <int>    : Number of replicates for rapid bootstrap analysis and search for the best-scoring ML tree
#                                    - requires "--tree_inference" with RAxML
#                                    Default: 100
#
#  --num_threads <int>             : number of threads (CPUs) to assign to external utilities (RAxML)
#                                    Default: 1 
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  Example Usage:
#
#  GeneFamilyPhylogenyBuilder --orthogroup_aln geneFamilyAlignments_dir/orthogroups_aln_faa --tree_inference fasttree
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
```

