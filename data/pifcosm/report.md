# pifcosm CWL Generation Report

## pifcosm

### Tool Description
FAIL to generate CWL: pifcosm not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pifcosm:0.1.1--hdfd78af_0
- **Homepage**: https://github.com/RybergGroup/PifCoSm
- **Package**: https://anaconda.org/channels/bioconda/packages/pifcosm/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pifcosm/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RybergGroup/PifCoSm
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pifcosm not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pifcosm not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pifcosm_PifCoSm.pl

### Tool Description
PifCoSm (Phylogenetic Information for Community Systematics) is a tool for parsing GenBank data, clustering sequences, and performing phylogenetic analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pifcosm:0.1.1--hdfd78af_0
- **Homepage**: https://github.com/RybergGroup/PifCoSm
- **Package**: https://anaconda.org/channels/bioconda/packages/pifcosm/overview
- **Validation**: PASS
### Original Help Text
```text
USAGE: [perl] PifCoSm.pl batch_file.txt
       [perl] PifCoSm.pl [options] (-o|--modules) module[,module..]
       [perl] PifCoSm.pl (-h|--help)

MODULES and OPTIONS:

gb_parser - will parse a text file in full GenBank format and store the
            information in a table called gb_data in the database.
        -d/--database
        -g/--gb_file
        -m/--max_seq_length

change_entries - will change the annotation gb_data table.
        -d/--database
        -H/--changes_files
        -ch/--change_option

define_individuals - will define individuals based on one or several columns.
        -d/--database
        -v/--individual_columns
        -V/--individual_condition

gene_parser - will try to match each sequence to hmms of different genes and
              sort out the different genes to separate tables.
        -d/--database
        -M/--hmm_database
        -Z/--print_non_match
        -l/--min_seq_length_gene
        -e/--e_value_cut_off
        -n/--n_cut_off
        -i/--inter_genes
        -P/--path

cluster_individuals - will cluster the sequences of each gene that belong to
                      the same individual as defined by define_individuals.
        -d/--database
        -l/--min_seq_length_gene

tree_clustering - will cluster sequences of each gene based on trees built for
                  each distinct taxon string.
        -d/--database
        -C/--tree_clust_type
        -s/--sim_cut_off
        -l/--min_seq_length_gene
        -T/--threads
        -P/--path

CD_hit_cluster - will cluster sequences based on similarity using CDhit-est.
        -d/--database
        -s/--sim_cut_off
        -l/--min_seq_length_gene
        -T/--threads
        -P/--path

similarity_cluster - will cluster sequences of each gene based on pairwise
                     sequence hamming distances.
        -d/--database
        -s/--sim_cut_off
        -l/--min_seq_length_gene
        -T/--threads
        -P/--path

alignment_groups - will define groups to align for each gene based on the
                   taxon string annotation.
        -d/--database
        -G/--group_on_genera

link_genes - will create the table alignments for the aligned sequences.
        -d/--database
        -L/--maximize_linking
        -l/--min_seq_length_gene

multimotu - will link genes using graph theory based on Chesters and Vogler
            (2013).
        -d/--database
        -cc/--comp_columns
        -ck/--comp_kind
        -cs/--comp_score

latin_names - will try to find appropriate species names for the ‘taxa’
              defined by linked_genes.
        -d/--database

align_sequences - will align the sequences that were linked by link_genes.
        -d/--database
        -T/--threads
        -E/--create_gene_trees
        -p/--phylo_method
        -B/--store_boot_trees
        -Y/--remove_outliers
        -k/--linked_genes
        -P/--path

refine_alignments - will refine the alignments created by align_sequences
                    using an algorithm based on Liu et al (2009 and 2012).
        -d/--database
        -p/--phylo_method
        -B/--store_boot_trees
        -r/--stop_criterion
        -ms/--max_alignment_group_size
        -ug/--use_guide_tree
        -T/--threads
        -u/--use_genes
        -k/--linked_genes
        -P/--path

gblocks - will remove poorly aligned regions using Gblocks.
        -d/--database
        -b0
        -b1
        -b2
        -b3
        -b4
        -b5
        -u/--use_genes
        -l/--min_seq_length_gene
        -P/--path

catenated_tree - will produce a tree from a catenated alignment of the given
                 genes, possibly partitioning the separate genes.
        -d/--database
        -c/--cat_phylo_method
        -T/--threads
        -B/--store_boot_trees
        -u/--use_genes
        -Q/--anchor_gene
        -P/--path

exclude_rogues - will identify rogue taxa using RogueNaRok.
        -d/--database
        -N/--out_file_name
        -w/--print_rogues
        -x/--output_no_rogues_tree
        -z/--rm_rogues_from_ml_tree
        -q/--rm_rogues_from_alignment
        -P/--path

get_distinct_entries - will output each unique entry in one or several columns
                       in the table gb_data.
        -d/--database
        -U/--column_name
        -N/--out_file_name

get_shared_values - will output values in a given column that are also present
                    in another given column in the table gb_data.
        -d/--database
        -U/--column_name
        -N/--out_file_name

get_alignments - will output a concatenated sequence alignment for the given
                ‘genes’ in either, fasta, phylip, or nexus format.
        -d/--database
        -a/--alignment_format
        -D/--interleaved
        -W/ --bases_per_row
        -A/--partition_file
        -N/--out_file_name
        -S/--sequence_name_column
        -u/--use_genes
        -Q/--anchor_gene

get_trees - will output one or more trees produced by PifCoSm as stored in
            PifCoSm.
        -d/--database
        -N/--out_file_name
        -t/--get_taxon
        -u/--use_genes
        -O/--only_show

switch_tip_names - will switch the tip names of a tree (and only one tree)
                   from accession numbers to species names as given in gb_data
                   or from ‘taxon’ names to species names as given by the
                   latin_names module.
        -d/--database
        -I/--tree_infile
        -R/--tree_file/--gene_tree
        -N/--out_file_name
        -P/--path

get_otu_taxonomy - will give a tab separated list of the taxonomic hierarchy
                   for each OTU for as long as it agrees for all sequences for
                   the given genes.
        -d/--database
        -u/--use_genes
        -Q/--anchor_gene
        -S/--sequence_name_column

stats - will present some statistics about either the clustering ('cluster')
        or the alignments ('alignment') for given genes.
        -d/--database
        --stats_type
        -u/--use_genes
        -Q/--anchor_gene (not used for cluster stats)
        -P/--path
```

