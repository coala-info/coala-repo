[![Logo](../_static/logo.png)](../index.html)

* [About](../about/index.html)
* Usage
  + [Quick start](#quick-start)
  + [General usage](#general-usage)
    - [Calling functions](#calling-functions)
    - [Function aliases](#function-aliases)
    - [Command line interfaces](#command-line-interfaces)
  + [Functions by analytical category](#functions-by-analytical-category)
    - [Alignment quality & statistics](#alignment-quality-statistics)
    - [Alignment & dataset utilities](#alignment-dataset-utilities)
    - [Tree summary statistics](#tree-summary-statistics)
    - [Tree manipulation & utilities](#tree-manipulation-utilities)
    - [Tree comparison & consensus](#tree-comparison-consensus)
    - [Introgression & gene flow](#introgression-gene-flow)
    - [Phylogenetic signal](#phylogenetic-signal)
    - [Trait evolution](#trait-evolution)
    - [Phylogenetic comparative methods](#phylogenetic-comparative-methods)
    - [Evolutionary rate analysis](#evolutionary-rate-analysis)
    - [Homology assessment](#homology-assessment)
    - [Saturation & model adequacy](#saturation-model-adequacy)
  + [Alignment-based functions](#alignment-based-functions)
    - [Alignment entropy](#alignment-entropy)
    - [Alignment length](#alignment-length)
    - [Alignment length no gaps](#alignment-length-no-gaps)
    - [Alignment outlier taxa](#alignment-outlier-taxa)
    - [Alignment recoding](#alignment-recoding)
    - [Alignment subsampling](#alignment-subsampling)
    - [Column score](#column-score)
    - [Composition per taxon](#composition-per-taxon)
    - [Compositional bias per site](#compositional-bias-per-site)
    - [Create concatenation matrix](#create-concatenation-matrix)
    - [Evolutionary Rate per Site](#evolutionary-rate-per-site)
    - [Faidx](#faidx)
    - [Guanine-cytosine (GC) content](#guanine-cytosine-gc-content)
    - [Identity matrix](#cmd-identity-matrix)
    - [Mask alignment](#mask-alignment)
    - [Occupancy filter](#occupancy-filter)
    - [Occupancy per taxon](#occupancy-per-taxon)
    - [Pairwise identity](#pairwise-identity)
    - [Parsimony informative sites](#parsimony-informative-sites)
    - [Phylo GWAS](#phylo-gwas)
    - [Plot alignment QC](#plot-alignment-qc)
    - [Protein-to-nucleotide alignment](#protein-to-nucleotide-alignment)
    - [Relative composition variability](#relative-composition-variability)
    - [Relative composition variability, taxon](#relative-composition-variability-taxon)
    - [Rename FASTA entries](#rename-fasta-entries)
    - [Sum-of-pairs score](#sum-of-pairs-score)
    - [Taxon groups](#taxon-groups)
    - [Variable sites](#variable-sites)
  + [Tree-based functions](#tree-based-functions)
    - [Ancestral state reconstruction](#ancestral-state-reconstruction)
    - [Bipartition support statistics](#bipartition-support-statistics)
    - [Branch length multiplier](#branch-length-multiplier)
    - [Character map (synapomorphy/homoplasy mapping)](#character-map-synapomorphy-homoplasy-mapping)
    - [Chronogram](#chronogram)
    - [Collapse bipartitions](#collapse-bipartitions)
    - [Concordance-aware ancestral state reconstruction](#concordance-aware-ancestral-state-reconstruction)
    - [Consensus network](#consensus-network)
    - [Consensus tree](#consensus-tree)
    - [Continuous trait evolution model comparison (fitContinuous)](#continuous-trait-evolution-model-comparison-fitcontinuous)
    - [Continuous trait mapping (contMap)](#continuous-trait-mapping-contmap)
    - [Cophylogenetic plot (tanglegram)](#cophylogenetic-plot-tanglegram)
    - [Covarying evolutionary rates](#covarying-evolutionary-rates)
    - [D-statistic (ABBA-BABA test)](#d-statistic-abba-baba-test)
    - [Degree of violation of the molecular clock](#degree-of-violation-of-the-molecular-clock)
    - [Density map](#density-map)
    - [DFOIL test (Pease & Hahn 2015)](#dfoil-test-pease-hahn-2015)
    - [Discordance asymmetry](#discordance-asymmetry)
    - [Discrete trait evolution model comparison (fitDiscrete)](#discrete-trait-evolution-model-comparison-fitdiscrete)
    - [Disparity through time (DTT)](#disparity-through-time-dtt)
    - [Evolutionary rate](#evolutionary-rate)
    - [Evolutionary tempo mapping](#evolutionary-tempo-mapping)
    - [Faith's phylogenetic diversity](#faith-s-phylogenetic-diversity)
    - [Hidden paralogy check](#hidden-paralogy-check)
    - [Hybridization analysis](#hybridization-analysis)
    - [Independent contrasts (PIC)](#independent-contrasts-pic)
    - [Internal branch statistics](#internal-branch-statistics)
    - [Internode labeler](#internode-labeler)
    - [Kuhner-Felsenstein distance](#kuhner-felsenstein-distance)
    - [Last common ancestor subtree](#last-common-ancestor-subtree)
    - [Lineage-through-time plot and gamma statistic](#lineage-through-time-plot-and-gamma-statistic)
    - [Long branch score](#long-branch-score)
    - [Monophyly check](#monophyly-check)
    - [Multi-regime OU models (OUwie)](#multi-regime-ou-models-ouwie)
    - [Nearest neighbor interchange](#nearest-neighbor-interchange)
    - [NeighborNet](#neighbornet)
    - [Network signal](#network-signal)
    - [OU shift detection (l1ou)](#ou-shift-detection-l1ou)
    - [Parsimony score](#parsimony-score)
    - [Patristic distances](#patristic-distances)
    - [Phenogram (traitgram)](#phenogram-traitgram)
    - [Phylogenetic ANOVA / MANOVA](#phylogenetic-anova-manova)
    - [Phylogenetic GLM](#phylogenetic-glm)
    - [Phylogenetic heatmap](#phylogenetic-heatmap)
    - [Phylogenetic imputation](#phylogenetic-imputation)
    - [Phylogenetic Logistic Regression](#phylogenetic-logistic-regression)
    - [Phylogenetic Ordination](#phylogenetic-ordination)
    - [Phylogenetic path analysis](#phylogenetic-path-analysis)
    - [Phylogenetic regression (PGLS)](#phylogenetic-regression-pgls)
    - [Phylogenetic signal](#cmd-phylogenetic-signal)
    - [Phylomorphospace](#phylomorphospace)
    - [Polytomy testing](#polytomy-testing)
    - [Print tree](#print-tree)
    - [Prune tree](#prune-tree)
    - [Quartet network](#quartet-network)
    - [Quartet pie chart](#quartet-pie-chart)
    - [Rate heterogeneity test (multi-rate Brownian motion)](#rate-heterogeneity-test-multi-rate-brownian-motion)
    - [Rename tree tips](#rename-tree-tips)
    - [Robinson-Foulds distance](#robinson-foulds-distance)
    - [Root tree](#root-tree)
    - [SIMMAP summary](#simmap-summary)
    - [Spectral discordance decomposition](#spectral-discordance-decomposition)
    - [Spurious homolog identification](#spurious-homolog-identification)
    - [Stochastic character mapping (SIMMAP)](#stochastic-character-mapping-simmap)
    - [Subtree pruning and regrafting](#subtree-pruning-and-regrafting)
    - [Terminal branch statistics](#terminal-branch-statistics)
    - [Threshold model](#threshold-model)
    - [Tip labels](#tip-labels)
    - [Tip-to-tip distance](#tip-to-tip-distance)
    - [Tip-to-tip node distance](#tip-to-tip-node-distance)
    - [Total tree length](#total-tree-length)
    - [Trait correlation](#trait-correlation)
    - [Trait rate map](#trait-rate-map)
    - [Transfer annotations](#transfer-annotations)
    - [Tree space visualization](#tree-space-visualization)
    - [Treeness](#treeness)
  + [Alignment- and tree-based functions](#alignment-and-tree-based-functions)
    - [Relative rate test](#relative-rate-test)
    - [Saturation](#saturation)
    - [Treeness over RCV](#treeness-over-rcv)
* [Tutorials](../tutorials/index.html)
* [Change log](../change_log/index.html)
* [Other software](../other_software/index.html)
* [FAQ](../frequently_asked_questions/index.html)

[phykit](../index.html)

* Usage

---

# Usage[](#usage "Link to this heading")

PhyKIT provides 100+ functions for processing and analyzing multiple sequence
alignments and phylogenies. Functions span alignment quality assessment,
tree manipulation, phylogenetic comparative methods, trait evolution modeling,
introgression detection, and more.

Some help messages indicate that summary statistics are reported (e.g.,
bipartition\_support\_stats). Summary statistics include mean, median, 25th percentile,
75th percentile, minimum, maximum, standard deviation, and variance. These functions
typically have a verbose option that allows users to get the underlying data
used to calculate summary statistics.

## Quick start[](#quick-start "Link to this heading")

Here is a typical workflow showing a few common PhyKIT operations:

```
# Check alignment quality
phykit pis alignment.fa                  # count parsimony informative sites
phykit aot alignment.fa --json           # flag outlier taxa

# Summarize tree properties
phykit treeness species.tre              # treeness (internal/total branch length)
phykit dvmc species.tre                  # degree of violation of a molecular clock

# Phylogenetic comparative methods
phykit pgls -t species.tre -d traits.tsv \
    --response brain_size --predictor body_mass   # PGLS regression
phykit panova -t species.tre \
    --traits traits.tsv --pairwise                # phylogenetic ANOVA

# Visualize gene tree concordance
phykit qpie -t species.tre -g gene_trees.nwk \
    -o concordance.png --branch-labels            # quartet pie chart
```

## General usage[](#general-usage "Link to this heading")

### Calling functions[](#calling-functions "Link to this heading")

```
phykit <command> [optional command arguments]
```

Command specific help messages can be viewed by adding a
-h/--help argument after the command. For example, to see the help message
for the command 'treeness', execute:

```
phykit treeness -h
# or
phykit treeness --help
```

### Function aliases[](#function-aliases "Link to this heading")

Each function comes with aliases to save the user some
key strokes. For example, to get the help message for the 'treeness'
function, you can type:

```
phykit tness -h
```

### Command line interfaces[](#command-line-interfaces "Link to this heading")

As of version 1.2.0, all functions (including aliases) can be executed using
a command line interface that starts with *pk\_*. For example, instead of typing
the previous command to get the help message of the treeness function, you can type:

```
pk_treeness -h
# or
pk_tness -h
```

All possible function names are specified at the top of each function section.

## Functions by analytical category[](#functions-by-analytical-category "Link to this heading")

The functions above are organized by input type. Below, the same functions
are grouped by analytical purpose to help you find the right tool for your analysis.

### Alignment quality & statistics[](#alignment-quality-statistics "Link to this heading")

* [Alignment entropy](#cmd-alignment-entropy): Shannon entropy across alignment sites
* [Alignment length](#cmd-alignment-length): Length of an input alignment
* [Alignment length no gaps](#cmd-alignment-length-no-gaps): Alignment length excluding gapped sites
* [Alignment outlier taxa](#cmd-alignment-outlier-taxa): Identify outlier taxa in alignments
* [Column score](#cmd-column-score): Column score for alignment quality
* [Composition per taxon](#cmd-composition-per-taxon): Nucleotide or amino acid composition per taxon
* [Compositional bias per site](#cmd-compositional-bias-per-site): Detect compositional bias across sites
* [Evolutionary rate per site](#cmd-evolutionary-rate-per-site): Site-specific evolutionary rate estimation
* [Guanine-cytosine (GC) content](#cmd-gc-content): GC content of an alignment
* [Identity matrix](#cmd-identity-matrix): Pairwise sequence identity heatmap
* [Occupancy per taxon](#cmd-occupancy-per-taxon): Taxon occupancy in alignment columns
* [Pairwise identity](#cmd-pairwise-identity): Pairwise sequence identity in an alignment
* [Parsimony informative sites](#cmd-parsimony-informative-sites): Count parsimony informative sites
* [Plot alignment QC](#cmd-plot-alignment-qc): Visual quality control plots for alignments
* [Relative composition variability](#cmd-relative-composition-variability): Composition variability across taxa
* [Relative composition variability, taxon](#cmd-relative-composition-variability-taxon): Per-taxon relative composition variability
* [Sum-of-pairs score](#cmd-sum-of-pairs-score): Sum-of-pairs alignment quality score
* [Variable sites](#cmd-variable-sites): Count variable sites in an alignment

### Alignment & dataset utilities[](#alignment-dataset-utilities "Link to this heading")

* [Alignment recoding](#cmd-alignment-recoding): Recode alignment into reduced alphabets
* [Alignment subsampling](#cmd-alignment-subsample): Randomly subsample genes, partitions, or sites
* [Create concatenation matrix](#cmd-create-concatenation-matrix): Concatenate multiple alignments into a supermatrix
* [Faidx](#cmd-faidx): Extract entries from FASTA files
* [Mask alignment](#cmd-mask-alignment): Mask sites in an alignment
* [Occupancy filter](#cmd-occupancy-filter): Filter alignments or trees by cross-file taxon occupancy (works with both FASTA and Newick)
* [Protein-to-nucleotide alignment](#cmd-thread-dna): Thread nucleotide onto protein alignment
* [Rename FASTA entries](#cmd-rename-fasta-entries): Rename entries in a FASTA file
* [Taxon groups](#cmd-taxon-groups): Group alignment or tree files by shared taxon sets (works with both FASTA and Newick)

### Tree summary statistics[](#tree-summary-statistics "Link to this heading")

* [Bipartition support statistics](#cmd-bipartition-support-stats): Summary statistics of bipartition support values
* [Degree of violation of the molecular clock](#cmd-degree-of-violation-of-a-molecular-clock): Measure molecular clock violation
* [Evolutionary rate](#cmd-evolutionary-rate): Calculate tree-based evolutionary rate
* [Faith's phylogenetic diversity](#cmd-faiths-pd): Sum of branch lengths spanning a community of tips
* [Internal branch statistics](#cmd-internal-branch-stats): Summary statistics of internal branch lengths
* [Lineage-through-time plot and gamma statistic](#cmd-ltt): Lineage-through-time analysis and gamma statistic
* [Long branch score](#cmd-long-branch-score): Identify long branches in a tree
* [Patristic distances](#cmd-patristic-distances): Pairwise patristic distances between taxa
* [Terminal branch statistics](#cmd-terminal-branch-stats): Summary statistics of terminal branch lengths
* [Tip-to-tip distance](#cmd-tip-to-tip-distance): Distance between two tips in a tree
* [Tip-to-tip node distance](#cmd-tip-to-tip-node-distance): Node distance between two tips
* [Total tree length](#cmd-total-tree-length): Sum of all branch lengths
* [Treeness](#cmd-treeness): Ratio of internal to total branch lengths

### Tree manipulation & utilities[](#tree-manipulation-utilities "Link to this heading")

* [Branch length multiplier](#cmd-branch-length-multiplier): Multiply branch lengths by a factor
* [Chronogram](#cmd-chronogram): Time-calibrated tree with geological timescale (rectangular or circular)
* [Collapse bipartitions](#cmd-collapse-branches): Collapse 