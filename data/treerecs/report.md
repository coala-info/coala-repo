# treerecs CWL Generation Report

## treerecs

### Tool Description
Treerecs is a tool for gene tree species tree reconciliation, including rooting, rearrangement and many other features.

### Metadata
- **Docker Image**: quay.io/biocontainers/treerecs:1.2--h9f5acd7_3
- **Homepage**: https://project.inria.fr/treerecs/
- **Package**: https://anaconda.org/channels/bioconda/packages/treerecs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/treerecs/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Treerecs (1.2), Inria - Beagle
--------------------------------------------------
Usage:   treerecs -h | --help
   or:   treerecs -V | --version
   or:   treerecs --usage
   or:   treerecs -g GENETREE_FILE -s SPECIESTREE_FILE
                  [-S MAP_FILE] [-t BRANCH_SUPPORT_THRESHOLD] [...]
   or:   treerecs -g GENETREE_FILE --info

Options:
   -h, --help
	print this help, then exit.

   --usage
	print usage, then exit.

   -V, --version
	print version number, then exit.

   -v, --verbose
	verbose mode. Causes Treerecs to print messages about its progress.

   -Y, --superverbose
	super-verbose mode. Print even more messages than in verbose mode.

   -g, --genetree GENETREE_FILE
	input gene tree(s) (supported formats: Newick, NHX or PhyloXML).

   -s, --speciestree SPECIESTREE_FILE
	input species tree (supported formats: Newick, NHX or PhyloXML).

   -a, --alignments ALIGNMENTS_FILE
	input alignment file. Must contain:
	  * the pll substitution model to use
	  * the paths to the multiple alignments (one per gene-tree)

   -S, --smap SMAP_FILE
	input gene-to-species mapping file.

   -r, --reroot
	find the best root according to the reconciliation cost.

   -d, --dupcost VALUE
	specify gene duplication cost (default value = 2).

   -l, --losscost VALUE
	specify gene loss cost (default value = 1).

   -t, --threshold EXPRESSION | quantiles[N]
	specify branch support thresholds to use while contracting gene trees.

	* EXPRESSION can be any colon-separated combination of the following:
	  none: no contraction
	  all: contract all branches. The tree collapses into a single polytomy
	  VALUE: contract branches with support strictly lower than VALUE
	  VALUE+epsilon (short VALUE+e): contract branches with support equal to
	  or lower than VALUE

	* quantiles[N]: use several threshold values: none, all, and the
	  quantiles dividing the branch supports into N groups

   -n, --sample-size VALUE
	size of the tree sampling (default value = 1).

   -N, --tree-index VALUE
	only consider the VALUE-th gene tree in the gene tree file.

   -o, --outdir OUTPUT_DIR
	output directory (default: treerecs_output).

   -O, --output-format FORMAT
	output format(s): newick(default), nhx, phyloxml, recphyloxml or svg.
	repeat option or use a colon-separated list of formats to get multiple
	output

   -f, --force
	force possible overwrite of existing files.

   -c, --sep CHARACTER
	specify separator character for species names embedded in gene names
	(default = '_').

   -p, --prefix Y/N
	specify whether the species_name is a prefix of gene_name
	default = N).

   -P, --parallelize
	run in parallel if possible.

   -M, --save-map
	save map(s) used during execution.

   -q, --quiet
	silent mode (no print, no progression bar).

   -C, --costs-estimation
	estimate duplication and loss costs.

   --info
	print informations about genetree(s) with a branch support diagram.

   --case-sensitive
	use case sensitive mapping.

   --ale-evaluation
	compute ALE log likelihood for each solution.

   --output-without-description
	strip output from gene tree descriptions.

   --fevent
	create a file that summarizes orthology/paralogy relationships.


Treerecs 1.2
```


## Metadata
- **Skill**: not generated
