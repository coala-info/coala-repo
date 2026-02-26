# plant_tribes_gene_family_integrator CWL Generation Report

## plant_tribes_gene_family_integrator_GeneFamilyIntegrator

### Tool Description
INTEGRATE SCAFFOLD AND CLASSIFIED GENE FAMILIES

### Metadata
- **Docker Image**: quay.io/biocontainers/plant_tribes_gene_family_integrator:1.0.4--0
- **Homepage**: https://github.com/dePamphilis/PlantTribes
- **Package**: https://anaconda.org/channels/bioconda/packages/plant_tribes_gene_family_integrator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plant_tribes_gene_family_integrator/overview
- **Total Downloads**: 21.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dePamphilis/PlantTribes
- **Stars**: N/A
### Original Help Text
```text
Unknown option: help
Use of uninitialized value $scaffold in concatenation (.) or string at /usr/local/bin/GeneFamilyIntegrator line 71.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#                                  INTEGRATE SCAFFOLD AND CLASSIFIED GENE FAMILIES 
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  Required Options:
#
#  --orthogroup_fasta <string>     : Directory containing gene family classification orthogroups fasta files
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
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  Example Usage:
#
#  GeneFamilyIntegrator --orthogroup_fasta geneFamilyClassification_dir/orthogroups_fasta --scaffold 22Gv1.1  --method orthomcl
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
```

