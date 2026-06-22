---
name: phykit
description: PhyKIT is a comprehensive UNIX shell toolkit designed for the bioinformatic analysis and manipulation of phylogenomic datasets. Use when user asks to calculate alignment statistics, modify tree structures, identify outlier taxa, or perform phylogenetic comparative methods.
homepage: https://jlsteenwyk.com/PhyKIT/usage/index.html
metadata:
  docker_image: "quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0"
---


# phykit

## Overview
PhyKIT is a comprehensive UNIX shell toolkit designed for the bioinformatic analysis of phylogenomic datasets. It provides over 100 functions to streamline workflows involving sequence alignments and phylogenetic trees. Use this skill to perform rapid summary statistics, identify outlier taxa, manipulate tree structures, and execute phylogenetic comparative methods without needing to write custom scripts for standard evolutionary biology tasks.

## General Usage Patterns
PhyKIT commands follow a standard structure: `phykit <command> [arguments]`. Every command has a short alias (e.g., `treeness` is `tness`) and a standalone executable version prefixed with `pk_` (e.g., `pk_treeness`).

### Alignment Quality & Statistics
Use these commands to evaluate the signal and composition of your MSAs:
- **Parsimony Informative Sites**: `phykit pis <alignment.fa>`
- **GC Content**: `phykit gc <alignment.fa>`
- **Identify Outlier Taxa**: `phykit aot <alignment.fa>` (use `--json` for machine-readable output)
- **Relative Composition Variability (RCV)**: `phykit rcv <alignment.fa>` to measure composition bias.

### Tree Manipulation & Summary
Quickly modify or extract data from Newick files:
- **Treeness**: `phykit treeness <tree.tre>` (calculates the ratio of internal branch lengths to total tree length).
- **Rooting**: `phykit root <tree.tre> -o <outgroup_taxon>`
- **Pruning**: `phykit prune <tree.tre> <taxa_list.txt>`
- **Renaming Tips**: `phykit rename_tree_tips <tree.tre> <names_file.txt>`
- **Total Tree Length**: `phykit ttl <tree.tre>`

### Evolutionary Analysis & Comparative Methods
Perform advanced statistical tests on phylogenetic data:
- **PGLS Regression**: `phykit pgls -t <tree.tre> -d <traits.tsv> --response <column> --predictor <column>`
- **Phylogenetic ANOVA**: `phykit panova -t <tree.tre> --traits <traits.tsv>`
- **Molecular Clock Test**: `phykit dvmc <tree.tre>` (Degree of Violation of the Molecular Clock).
- **Gene Tree Concordance**: `phykit qpie -t <species_tree.tre> -g <gene_trees.nwk>` to generate quartet pie charts.

## Expert Tips
- **Verbose Output**: Many summary statistic functions (like `bipartition_support_stats`) support a `-v` or `--verbose` flag to output the raw data underlying the calculations.
- **File Handling**: PhyKIT is designed for UNIX pipes. You can often chain operations or use standard shell redirects to handle large batches of phylogenomic files.
- **Help Access**: For any specific command, use `phykit <command> -h` to see all available flags and required input formats.



## Subcommands

| Command | Description |
|---------|-------------|
| phykit alignment_entropy | Calculate alignment entropy. Site-wise entropy is calculated using Shannon entropy. By default, this function prints the mean site entropy. With the -v/--verbose option, entropy is printed for each site in the alignment. |
| phykit alignment_length | Length of an input alignment is calculated using this function. Longer alignments are associated with strong phylogenetic signal. |
| phykit alignment_length_no_gaps | Calculate alignment length excluding sites with gaps. PhyKIT reports three tab delimited values: number of sites without gaps, total number of sites, and percentage of sites without gaps. |
| phykit alignment_outlier_taxa | Identify potential outlier taxa in an alignment based on features like gap rate, occupancy, composition distance, long branch proxy, rcvt, and entropy burden. |
| phykit alignment_recoding | Recode alignments using reduced character states. Alignments can be recoded using established or custom recoding schemes. |
| phykit alignment_subsample | Randomly subsample genes, partitions, or sites from phylogenomic datasets. |
| phykit ancestral_state_reconstruction | Estimate ancestral states using maximum likelihood. Supports continuous (Brownian Motion) and discrete (Mk) models. |
| phykit bipartition_support_stats | Calculate summary statistics for bipartition support. High bipartition support values are thought to be desirable because they are indicative of greater certainty in tree topology. |
| phykit branch_length_multiplier | Multiply branch lengths in a phylogeny by a given factor. This can help modify reference trees when conducting simulations or other analyses. |
| phykit character_map | Map discrete character changes onto a phylogenetic tree using Fitch parsimony, classifying each change as a synapomorphy, convergence, or reversal. |
| phykit chronogram | Plot a chronogram (time-calibrated phylogeny) with geological timescale bands. Requires an ultrametric tree and the root age in millions of years (Ma). |
| phykit collapse_branches | Collapse branches on a phylogeny according to bipartition support. Bipartitions will be collapsed if they are less than the user specified value. |
| phykit column_score | Calculates column score, an accuracy metric for a multiple alignment relative to a reference alignment. It is calculated by summing the correctly aligned columns over all columns in an alignment. |
| phykit composition_per_taxon | Calculate sequence composition per taxon in an alignment. Composition is reported as symbol:frequency values for each taxon, where frequencies are calculated from valid (non-gap/non-ambiguous) characters. |
| phykit compositional_bias_per_site | Calculates compositional bias per site in an alignment using site-wise chi-squared tests. |
| phykit concordance_asr | Concordance-aware ancestral state reconstruction (ASR) that incorporates gene tree discordance into ancestral estimates. |
| phykit consensus_network | Extract bipartition splits from a collection of gene trees and summarize conflicting phylogenetic signal. Counts how frequently each non-trivial bipartition appears across input trees and filters by a minimum frequency threshold. |
| phykit consensus_tree | Infer a consensus tree from a collection of trees. Input can be either: 1) a file with one Newick tree per line, or 2) a file with one tree-file path per line. |
| phykit cont_map | Continuous Trait Map (contMap) visualization. Runs ancestral state reconstruction internally and produces a phylogram with branches colored by a continuous gradient representing inferred trait values. |
| phykit cophylo | Cophylogenetic (tanglegram) plot of two phylogenies. Draws two trees facing each other with connecting lines between matching taxa, analogous to R's phytools::cophylo(). |
| phykit covarying_evolutionary_rates | Determine if two genes have a signature of covariation with one another by calculating the correlation among relative evolutionary rates between two phylogenies. |
| phykit create_concatenation_matrix | Create a concatenated alignment file. This function is used to help in the construction of multi-locus data matrices. PhyKIT will output three files: a fasta file, a partition file, and an occupancy file. |
| phykit degree_of_violation_of_a_molecular_clock | Calculate degree of violation of a molecular clock (or DVMC) in a phylogeny. Lower DVMC values are thought to be desirable because they are indicative of a lower degree of violation in the molecular clock assumption. |
| phykit density_map | Density Map visualization of posterior discrete state probabilities along each branch of a phylogeny. Runs stochastic character mapping internally (N simulations), then for each point along each branch computes the fraction of simulations in each state. |
| phykit dfoil | Compute DFOIL statistics (Pease & Hahn 2015) for detecting and polarizing introgression in a 5-taxon symmetric phylogeny. |
| phykit dstatistic | Compute Patterson's D-statistic (ABBA-BABA test) for detecting introgression or gene flow. Supports site patterns from an alignment or quartet topologies from gene trees. |
| phykit dtt | Disparity through time (DTT) analysis. Computes how morphological disparity partitions among subclades through time (Harmon et al. 2003). |
| phykit evo_rate_per_site | Estimate evolutionary rate per site. Evolutionary rate per site is one minus the sum of squared frequency of different characters at a given site. Values may range from 0 (slow evolving) to 1 (fast evolving). |
| phykit evolutionary_rate | Calculate a tree-based estimation of the evolutionary rate of a gene. Evolutionary rate is the total tree length divided by the number of terminals. |
| phykit faidx | Extracts sequence entry from fasta file. This function works similarly to the faidx function in samtools, but does not requiring an indexing step. |
| phykit faiths_pd | Calculate Faith's phylogenetic diversity (PD) for a community of tips on a phylogeny. Faith's PD is the sum of branch lengths in the minimum subtree that connects a set of taxa. |
| phykit fit_continuous | Compare models of continuous trait evolution on a phylogeny. Fits up to 7 models (BM, OU, EB, Lambda, Delta, Kappa, White) and ranks them by AIC, BIC, and AIC weights — analogous to R's geiger::fitContinuous(). |
| phykit fit_discrete | Compare models of discrete trait evolution on a phylogeny. Fits ER (Equal Rates), SYM (Symmetric), and ARD (All Rates Different) Mk models of discrete character evolution via maximum likelihood. Compares models using AIC and BIC. |
| phykit gc_content | Calculate GC content of a fasta file. GC content is negatively correlated with phylogenetic signal. If there are multiple entries, use the -v/--verbose option to determine the GC content of each fasta entry separately. |
| phykit hidden_paralogy_check | Scan tree for evidence of hidden paralogy. This analysis examines if a set of well known monophyletic taxa are, in fact, monophyletic. If they are not, the evolutionary history of the gene may be subject to hidden paralogy. |
| phykit hybridization | Estimate the minimum number of reticulation (hybridization) events and localize where hybridization likely occurred on a species tree using four-group decomposition and binomial tests. |
| phykit identity_matrix | Compute a pairwise sequence identity matrix from an alignment and plot it as a clustered heatmap. |
| phykit independent_contrasts | Compute Felsenstein's (1985) phylogenetically independent contrasts (PIC) for a continuous trait on a phylogeny. |
| phykit internal_branch_stats | Calculate summary statistics for internal branch lengths in a phylogeny. Internal branch lengths can be useful for phylogeny diagnostics. To obtain all internal branch lengths, use the -v/--verbose option. |
| phykit internode_labeler | Appends numerical identifiers to bipartitions in place of support values. This is helpful for pointing to specific internodes in supplementary files or otherwise. |
| phykit kf_distance | Calculate Kuhner-Felsenstein (KF) branch score distance between two trees. Unlike Robinson-Foulds distance which only considers topology, KF distance incorporates both topology and branch length differences. PhyKIT will print out col 1: the plain KF distance and col 2: the normalized KF distance. |
| phykit l1ou | Automatic OU shift detection using LASSO (l1ou approach). Discovers where on the phylogeny the adaptive optimum changed, using the LASSO-based approach from Khabbazian et al. (2016). No regime file is needed — only a tree and trait data. |
| phykit last_common_ancestor_subtree | Obtains subtree from a phylogeny by getting the last common ancestor from a list of taxa. |
| phykit long_branch_score | Calculate long branch (LB) scores in a phylogeny. LB score is the mean pairwise patristic distance of taxon i compared to all other taxa over the average pairwise patristic distance. PhyKIT reports summary statistics. To obtain LB scores for each taxa, use the -v/--verbose option. |
| phykit ltt | Lineage-through-time plot and gamma statistic. Computes the Pybus & Harvey (2000) gamma statistic to test for temporal variation in diversification rates. Optionally generates a lineage-through-time plot. |
| phykit mask_alignment | Mask alignment sites based on threshold criteria. Sites are retained when they pass all active thresholds: maximum gap fraction, minimum occupancy, and maximum site entropy. |
| phykit monophyly_check | Check for monophyly of a lineage. This analysis can be used to determine if a set of taxa are monophyletic. Requires a taxa file, which specifies which tip names are expected to be monophyletic. The output will have six columns including monophyly status, bipartition support values, and additional monophyletic taxa. |
| phykit nearest_neighbor_interchange | Generate all nearest neighbor interchange moves for a binary rooted tree. The output file will also include the original phylogeny. |
| phykit neighbor_net | Construct a NeighborNet phylogenetic network from pairwise distances and visualize it as a planar splits graph. |
| phykit network_signal | Measures phylogenetic signal (Bloomberg's K and/or Pagel's lambda) on a phylogenetic network by incorporating hybrid edges inferred from quartet concordance factors. |
| phykit occupancy_filter | Filter alignments and/or trees by cross-file taxon occupancy. Counts how many files each taxon appears in and retains only taxa meeting a minimum threshold. Outputs filtered copies of each input file. |
| phykit occupancy_per_taxon | Calculate occupancy per taxon in an alignment. Occupancy is the fraction of valid (non-gap/non-ambiguous) characters for each taxon. |
| phykit ouwie | Fit multi-regime Ornstein-Uhlenbeck models of continuous trait evolution (Beaulieu et al. 2012), analogous to R's OUwie package. |
| phykit pairwise_identity | Calculate the average pairwise identity among sequences. Pairwise identity is defined as the number of identical columns (including gaps) between two aligned sequences divided by the number of columns in the alignment. |
| phykit parsimony_informative_sites | Calculate the number and percentage of parsimony informative sites in an alignment. PhyKIT reports three tab delimited values: number of parsimony informative sites, total number of sites, and percentage of parsimony informative sites. |
| phykit parsimony_score | Compute the Fitch (1971) maximum parsimony score of a tree given an alignment. The parsimony score is the minimum number of character state changes required to explain the alignment on the given tree topology. |
| phykit patristic_distances | Calculate summary statistics among patristic distances in a phylogeny. Patristic distances are all tip-to-tip distances in a phylogeny. |
| phykit phenogram | Plot a phenogram (traitgram) showing continuous trait evolution across a phylogeny. X-axis shows distance from root (time), Y-axis shows trait values. Tips are plotted at observed values, internal nodes at ML ancestral estimates. Analogous to R's phytools::phenogram(). |
| phykit phylo_anova | Phylogenetic ANOVA / MANOVA using the Residual Randomization Permutation Procedure (RRPP). Tests whether a continuous trait (ANOVA) or multiple traits (MANOVA) differ across discrete groups while accounting for phylogenetic non-independence. |
| phykit phylo_gwas | Phylogenetic genome-wide association study following the Pease et al. (2016) approach. Performs per-site association tests between alignment columns and a phenotype, applies Benjamini-Hochberg FDR correction, and optionally classifies associations using a phylogenetic tree. |
| phykit phylo_heatmap | Draw a phylogenetic heatmap: a phylogeny alongside a color-coded matrix of numeric trait values. Rows are aligned to tree tips. |
| phykit phylo_impute | Phylogenetic imputation of missing trait values using conditional multivariate normal distributions. Captures both phylogenetic relationships and between-trait correlations to predict missing values. |
| phykit phylo_logistic | Fit a Phylogenetic Logistic Regression for binary (0/1) response data while accounting for phylogenetic non-independence among species (Ives & Garland 2010). |
| phykit phylo_path | Phylogenetic path analysis (von Hardenberg & Gonzalez-Voyer 2013). Compare competing causal DAGs using d-separation tests via PGLS with Pagel's lambda, rank models by CICc, and estimate model-averaged path coefficients. |
| phykit phylogenetic_glm | Fit a Phylogenetic Generalized Linear Model (GLM) for binary or count response data while accounting for phylogenetic non-independence among species. |
| phykit phylogenetic_ordination | Perform phylogenetic ordination (PCA, t-SNE, or UMAP) on continuous multi-trait data while accounting for phylogenetic non-independence among species. |
| phykit phylogenetic_regression | Fit a Phylogenetic Generalized Least Squares (PGLS) regression while accounting for phylogenetic non-independence among species, analogous to R's caper::pgls(). |
| phykit phylogenetic_signal | Calculate phylogenetic signal for continuous trait data. Supports Blomberg's K and Pagel's lambda methods. |
| phykit phylomorphospace | Plot a phylomorphospace: two raw traits in trait space with the phylogeny overlaid via ML-reconstructed ancestral states at internal nodes. |
| phykit plot_alignment_qc | Generate a multi-panel alignment quality-control plot. The figure summarizes per-taxon occupancy and gap rates, composition-distance versus long-branch proxy, and counts of feature-based outlier flags. |
| phykit polytomy_test | Conduct a polytomy test for three clades in a phylogeny using gene support frequencies and a chi-squared test. |
| phykit print_tree | Print ascii tree of input phylogeny. Phylogeny can be printed with or without branch lengths. By default, the phylogeny will be printed with branch lengths but branch lengths can be removed using the -r/--remove argument. |
| phykit prune_tree | Prune tips from a phylogeny. Provide a single column file with the names of the tips in the input phylogeny you would like to prune from the tree. |
| phykit quartet_network | Quartet-based network inference (NANUQ-style). Computes quartet concordance factors from gene trees, classifies each quartet as tree-like, hybrid, or unresolved using two chi-squared tests, and optionally visualizes the result. |
| phykit quartet_pie | Draw a phylogram with pie charts at internal nodes showing quartet concordance proportions. |
| phykit rate_heterogeneity | Test for rate heterogeneity across phylogenetic regimes using multi-rate Brownian motion. Fits single-rate vs. multi-rate BM models and performs a likelihood ratio test. |
| phykit relative_composition_variability | Calculate RCV (relative composition variability) for an alignment. Lower RCV values represent a lower composition bias in an alignment. Statistically, RCV describes the average variability in sequence composition among taxa. |
| phykit relative_composition_variability_taxon | Calculate RCVT (relative composition variability, taxon) for an alignment. RCVT is the relative composition variability metric for individual taxa, facilitating identification of specific taxa that may have compositional biases. |
| phykit relative_rate_test | Tajima's relative rate test. Tests whether two ingroup lineages evolve at equal rates relative to an outgroup. The tree must be rooted with a single outgroup taxon. All pairwise ingroup comparisons are performed with Bonferroni and BH-FDR correction. |
| phykit rename_fasta_entries | Renames fasta entries based on a tab-delimited identifier map. |
| phykit rename_tree_tips | Renames tips in a phylogeny based on a tab-delimited identifier map. |
| phykit robinson_foulds_distance | Calculate Robinson-Foulds (RF) distance between two trees. This function prints out two values, the plain RF value and the normalized RF value, which are separated by a tab. Prior to calculating an RF value, PhyKIT will first determine the number of shared tips between the two input phylogenies and prune them to a common set of tips. |
| phykit root_tree | Roots phylogeny using user-specified taxa. A list of taxa to root the phylogeny on should be specified using the -r argument. The root_taxa file should be a single-column file with taxa names. The outputted file will have the same name as the inputted tree file but with the suffix ".rooted". |
| phykit saturation | Calculate saturation for a given tree and alignment. Saturation is defined as sequences in multiple sequence alignments that have undergone numerous substitutions such that the distances between taxa are underestimated. |
| phykit simmap_summary | Run N stochastic character maps and summarize per-branch dwelling time proportions, expected transitions, and posterior state probabilities at each node. This extends stochastic_character_map by providing a detailed per-branch summary analogous to phytools::describe.simmap() in R. |
| phykit spectral_discordance | Spectral discordance decomposition — decompose gene tree space via PCA on a bipartition presence/absence (or branch-length) matrix, with spectral clustering and automatic cluster detection via the eigengap heuristic. |
| phykit spurious_sequence | Determines potentially spurious homologs using branch lengths by identifying long terminal branches defined as branches that are equal to or 20 times (or a user-specified factor) the median length of all branches. |
| phykit stochastic_character_map | Perform Stochastic Character Mapping (SIMMAP) of discrete traits onto a phylogeny, analogous to R's phytools::make.simmap(). Fits a continuous-time Markov chain (CTMC) rate matrix Q via maximum likelihood, then simulates character histories conditioned on tip states. |
| phykit subtree_prune_regraft | Generate all possible SPR (Subtree Pruning and Regrafting) rearrangements for a specified subtree on a tree. The subtree is identified by specifying one or more taxa whose MRCA defines the clade to prune. The pruned subtree is then regrafted onto every other branch in the remaining tree, producing one Newick tree per regraft position. |
| phykit sum_of_pairs_score | Calculates sum-of-pairs score, an accuracy metric for a multiple alignment relative to a reference alignment. It is calculated by summing the correctly aligned residue pairs over all pairs of sequences. |
| phykit taxon_groups | Determine which tree or FASTA files share the same set of taxa. Reads a file listing paths to gene trees or alignments and groups them by their taxon set (exact match). Reports groups sorted by size (largest first), with the taxa present in each group. |
| phykit thread_dna | Thread DNA sequence onto a protein alignment to create a codon-based alignment. This function requires input alignments are in fasta format. Codon alignments are then printed to stdout. Note, paired sequences are assumed to have the same name between the protein and nucleotide file. |
| phykit threshold_model | Estimates the correlation between two traits (binary discrete and/or continuous) using a latent-liability Brownian motion model and MCMC sampling. Equivalent of phytools::threshBayes in R. |
| phykit tip_labels | Prints the tip labels (or names) a phylogeny. |
| phykit tip_to_tip_distance | Calculate distance between two tips (or leaves) in a phylogeny. Distances are in substitutions per site. |
| phykit tip_to_tip_node_distance | Calculate distance between two tips (or leaves) in a phylogeny. Distance is measured by the number of nodes between one tip and another. |
| phykit total_tree_length | Calculate total tree length, which is a sum of all branches. |
| phykit trait_correlation | Compute phylogenetic correlations between all pairs of traits and display them as a heatmap with significance indicators. Uses GLS-centering via the tree's variance-covariance matrix to account for phylogenetic non-independence. |
| phykit trait_rate_map | Estimate per-branch evolutionary rates for a continuous trait and display them as a branch-colored phylogram. |
| phykit transfer_annotations | Transfer internal node annotations from one tree onto another. Matches nodes by bipartition (descendant taxa set) and copies the annotation labels. Typical use case: transfer wASTRAL support annotations from an annotated ASTRAL tree onto a branch-length-optimized topology. |
| phykit tree_space | Tree space visualization — visualize how gene trees cluster in topology space using MDS, t-SNE, or UMAP on pairwise tree distance matrices. |
| phykit treeness | Calculate treeness statistic for a phylogeny. Treeness describes the proportion of the tree distance found on internal branches. Treeness can be used as a measure of the signal-to-noise ratio in a phylogeny. |
| phykit treeness_over_rcv | Calculate treeness/RCV for a given alignment and tree. Higher treeness/RCV values are thought to be desirable because they harbor a high signal-to-noise ratio and are least susceptible to composition bias. |
| phykit variable_sites | Calculate the number of variable sites in an alignment. Reports three tab delimited values: number of variable sites, total number of sites, and percentage of variable sites. |

## Reference documentation
- [PhyKIT Usage Documentation](./references/jlsteenwyk_com_PhyKIT_usage_index.html.md)
- [PhyKIT GitHub README](./references/github_com_jlsteenwyk_phykit_blob_master_README.md)