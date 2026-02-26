# rapgreen CWL Generation Report

## rapgreen

### Tool Description
RAP-Green v1.0

### Metadata
- **Docker Image**: quay.io/biocontainers/rapgreen:1.0--hdfd78af_0
- **Homepage**: https://github.com/SouthGreenPlatform/rap-green
- **Package**: https://anaconda.org/channels/bioconda/packages/rapgreen/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rapgreen/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SouthGreenPlatform/rap-green
- **Stars**: N/A
### Original Help Text
```text
[1m
NAME:
[0m
	- RAP-Green v1.0 -
[1m
SYNOPSIS:
[0m
	rapgreen [command args]
[1m
MAIN OPTIONS:
[1m
-g[0m [4mgene_tree_file[0m
	The input gene tree file
[1m
-s[0m [4mspecies_tree_file[0m
	The input species tree file
[1m
-nhx[0m [4mgene_tree_nhx_file[0m
	The output tree file (annotated with duplications) in NHX format
[1m
-stats[0m [4mgene_tree_file[0m
	The output scoring statistic file
[1m
-gt[0m [4mgene_threshold[0m
	The support threshold for gene tree branch collapse (optional, default 80.0)
[1m
-st[0m [4mspecies_threshold[0m
	The length threshold for species tree branch collapse (optional, default 10.0)
[1m
-pt[0m [4mpolymorphism_threshold[0m
	The length depth threshold to deduce to polymorphism, allelism ... (optional, default 0.05)
[1m
CONFIDENTIAL OPTIONS:
[1m
-invert[0m
	Activate this option if your taxa identifier is in front of the sequence identifier
[1m
-pipe[0m
	Activate this option if your taxa identifier contains pipes instead of underscores
[1m
-start[0m [4mstarting_index[0m
	The starting index (0 default), if the gene tree input is a directory
[1m
-end[0m [4mending_index[0m
	The ending exclusive index (directory size default), if the gene tree input is a directory
[1m
-rerooted[0m [4mgene_tree_file[0m
	The simple unannotated rerooted gene tree file
[1m
-rerootedSpecies[0m [4mgene_tree_file[0m
	The simple unannotated rerooted gene tree file, with only species on the leaf (for supertrees for example)
[1m
-os[0m [4mspecies_tree_file[0m
	The output species tree file (limited to gene tree species)
[1m
-or[0m [4mreconciled_tree_file[0m
	The output reconciled tree file (consensus tree, with reductions and losses)
[1m
-outparalogous[0m
	Add outparalogous informations in stats file.
[1m
-prefix[0m [4mprefix[0m [4mtaxa[0m
	A prefix to be translated to a specific taxa, in sequence name.
[1m
-k[0m [4mk_level[0m
	The k-level of the subtree-neighbor measure (optional, default 2)
[1m
-idupw[0m [4mi_duplication_weight[0m
	The weight of intersection duplication in functional orthology scoring (0.0 for maximum weight, 1.0 for no weight, optional, default 0.90)
[1m
-tdupw[0m [4mt_duplication_weight[0m
	The weight of topological duplication in functional orthology scoring (0.0 for maximum weight, 1.0 for no weight, optional, default 0.95)
[1m
-specw[0m [4mspeciation_weight[0m
	The weight of speciation in functional orthology scoring (0.0 for maximum weight, 1.0 for no weight, optional, default 0.99)
[1m
-ultraw[0m [4multraparalogy_weight[0m
	The weight of an ultraparalogy node in functional orthology scoring (0.0 for maximum weight, 1.0 for no weight, optional, default 0.99)
[1m
-distw[0m [4mdistance_weight[0m
	The weight of evolutionary distance in functional orthology scoring (0.0 for maximum weight, 1.0 for no weight, optional, default 0.10)
[1m
DEPRECATED OPTIONS:
[1m
-og[0m [4mgene_tree_file[0m
	The output tree file (annotated with duplications)
[1m
-phyloxml[0m [4mgene_tree_phyloxml_file[0m
	The output tree file (annotated with duplications) in phyloXML format
```


## Metadata
- **Skill**: generated
