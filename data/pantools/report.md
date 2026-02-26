# pantools CWL Generation Report

## pantools_remove_functions

### Tool Description
Remove functional annotations from the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Total Downloads**: 36.0K
- **Last updated**: 2025-09-18
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Missing required parameter: '<databaseDirectory>'

Usage: pantools remove_functions [-m=<mode>] <databaseDirectory>

Remove functional annotations from the pangenome.

      <databaseDirectory>   Path to the database root directory.

  -m, --mode=<mode>         Remove function nodes and strip function properties
                              of mRNA nodes (default: all).
                            nodes: 'GO', 'pfam', 'tigrfam' and 'interpro' nodes.
                            properties: 'COG', 'phobius' and 'signalp'
                              properties.
                            all: combine the 'nodes' and 'properties' modes.
                            COG|phobius|signalp: Only remove a specific
                              property.
```


## pantools_deactivate_grouping

### Tool Description
Deactivate the currently active homology grouping.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required parameter: '<databaseDirectory>'

Usage: pantools deactivate_grouping [--fast] <databaseDirectory>

Deactivate the currently active homology grouping.

      <databaseDirectory>   Path to the database root directory.

      --fast                Do not remove is_similar relationships between mRNA
                              nodes.
```


## pantools_homology

### Tool Description
A comprehensive suite of tools for pangenome analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required subcommand

Usage: pantools <databaseDirectory> COMMAND

      <databaseDirectory>   Path to the database root directory.

Commands:

remove data from the pangenome or panproteome
  remove_pavs, remove_pav                Remove PAV data from the pangenome.
  remove_functions                       Remove functional annotations from the
                                           pangenome.
  deactivate_grouping                    Deactivate the currently active
                                           homology grouping.
  remove_grouping                        Remove an homology grouping from the
                                           pangenome.
  remove_annotations                     Remove all the genomic features that
                                           belong to annotations.
  remove_nodes                           Remove a selection of nodes and their
                                           relationships from the pangenome.
  remove_phenotypes                      Delete phenotype nodes or remove
                                           specific phenotype information from
                                           the nodes.
  remove_variants, remove_variant        Remove variant data from the pangenome.

phylogenetic methods
  core_phylogeny, core_snp_tree          Create a SNP tree from single-copy
                                           genes. By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants are present
                                           in the pangenome, these will be used
                                           as well.
  mlsa_find_genes                        Step 1/3 of mlsa. Search and filter
                                           suitable genes for the mlsa.
  consensus_tree                         Create a consensus tree by combining
                                           gene trees from homology groups
                                           using ASTRAL-Pro. By default, only
                                           nucleotide sequences are aligned for
                                           pangenome databases and only protein
                                           sequences are aligned for
                                           panproteome databases. If variants
                                           are present in the pangenome, these
                                           will be used as well.
  mlsa                                   Step 3/3 of mlsa. Run IQ-tree on the
                                           concatenated sequences.
  ani                                    Calculate Average Nucleotide Identity
                                           (ANI) scores between genomes.
  mlsa_concatenate                       Step 2/3 of mlsa. Concatenate the gene
                                           selection into a single continuous
                                           sequence.

add annotation features to the genome
  add_antismash                          Add antiSMASH gene clusters to the
                                           pangenome.
  busco_protein                          Identify BUSCO genes in the pangenome.
  add_variants, add_variant              Add variant data to the pangenome.
  add_functions                          Add functional annotations to the
                                           pangenome.
  add_phenotypes                         Add phenotype data to the pangenome.
  add_pavs, add_pav                      Add PAV data to the pangenome.
  add_annotations                        Construct or expand the annotations of
                                           an existing pangenome.
  add_phasing                            Add phasing information to the
                                           pangenome

find genes
  find_genes_by_annotation               Find genes of interest in the
                                           pangenome that share a functional
                                           annotation node and extract the
                                           nucleotide and protein sequence.
  find_genes_in_region                   Find genes in a given genomic region.
  blast                                  Search sequences in the database using
                                           BLAST
  find_genes_by_name                     Find your genes of interest in the
                                           pangenome by using the gene name and
                                           extract the nucleotide and protein
                                           sequence.

build a pangenome
  build_pangenome                        Build a pangenome from a set of
                                           genomes. Please see the manual with
                                           'build_pangenome --manual' for a
                                           description of the options.
  add_genomes                            Add additional genomes to an existing
                                           pangenome.

matrix files
  order_matrix                           Order the values of a matrix file
                                           created by PanTools.
  rename_matrix                          Rename the headers (first row and
                                           leftmost column) of CSV formatted
                                           matrix files.

Mutation rates
  calculate_dn_ds                        Calculate synonymous and
                                           non-synonymous mutation rates

characterization of functional annotations
  go_enrichment                          Identify over- or underrepresented GO
                                           terms in a set of genes.
  functional_classification              Classify functional annotations as
                                           core, accessory or unique.
  function_overview                      Create an overview table for each
                                           functional annotation type in the
                                           pangenome.

export pangenome
  export_pangenome                       Export a pangenome built with
                                           build_pangenome into node
                                           properties, relationship properties
                                           and node sequence anchors files.

sequence visualizations
  sequence_visualization                 Generate a visualization of multiple
                                           sequences with the possibility of
                                           different types of annotation bars.

homology group info
  group_info                             Report all available information of
                                           one or multiple homology groups.

Synteny methods
  calculate_synteny                      Calculate synteny between sequences
                                           with MCScanX
  synteny_overview, synteny_statistics   Generates metrics about the synteny
                                           blocks in the pangenome
  add_synteny                            Add synteny information to the
                                           pangenome

gene locations
  locate_genes                           Identify and compare gene clusters of
                                           from a set of homology groups.

characterization of gene and k-mer content
  core_unique_thresholds                 Test the effect of changing the core
                                           and unique threshold.
  pangenome_structure                    Determine the openness of the
                                           pangenome based on homology groups
                                           or k-mer sequences.
  gene_classification                    Classify the gene repertoire as core,
                                           accessory or unique.
  k_mer_classification, kmer_classification
                                         Calculate the number of core,
                                           accessory, unique, (and phenotype
                                           specific) k-mer sequences.
  grouping_overview                      Create an overview table for every
                                           homology grouping in the pangenome.

phylogenetic tree editing
  rename_phylogeny                       Update or alter the terminal nodes
                                           (leaves) of a phylogenic tree.
  create_tree_template                   Create templates for coloring
                                           phylogenetic trees in iTOL.
  root_phylogeny                         (Re)root a phylogenetic tree.

build a panproteome
  build_panproteome                      Build a panproteome from a set of
                                           proteins.

characterization of a pangenome
  variation_overview                     Write an overview of all accessions
                                           added to the pangenome (both VCF and
                                           PAV information).
  metrics                                Generates relevant metrics of the
                                           pangenome and the individual genomes
                                           and sequences.

Repeat methods
  repeat_overview                        Generates metrics about the repeat
                                           sequences in the pangenome
  add_repeats                            Add repeat information to the pangenome

detect homology groups
  change_grouping                        Change the active version of the
                                           homology grouping.
  optimal_grouping                       Find the most suitable settings for
                                           group.
  group                                  Generate homology groups based on
                                           similarity of protein sequences.

retrieve regions or features
  retrieve_features                      Retrieve the sequence of annotated
                                           features from the pangenome.
  retrieve_regions                       Retrieve the sequence of genomic
                                           regions from the pangenome.

gene retention
  gene_retention                         Visualize gene retention of sequences
                                           to a selected query sequence

functional annotation info
  compare_go                             For two given GO terms, move up in the
                                           GO hierarchy to see if they are
                                           related.
  show_go                                For a given GO term, show the child
                                           terms, all parent terms higher in
                                           the hierarchy, and connected mRNA
                                           nodes.

read mapping
  map                                    Map single or paired-end short reads
                                           to one or multiple genomes in the
                                           pangenome. One SAM or BAM file is
                                           generated for each genome included
                                           in the analysis.

sequence alignments
  msa                                    Create multiple sequence alignments.
                                           By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants were added to
                                           a pangenome, these will be aligned
                                           by default. Required software:
                                           MAFFT, FastTree.

The full manual and tutorial can be accessed using pantools --manual, or go to
the latest stable version at https://pantools.readthedocs.io/en/stable/.
For more information on the required and optional parameters per command, call
pantools COMMAND --help; or call pantools COMMAND --manual to open the detailed
command explanation in browser.
```


## pantools_remove_grouping

### Tool Description
Remove an homology grouping from the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required options and parameters: '--grouping-version=<groupingVersion>', '<databaseDirectory>'

Usage: pantools remove_grouping [--fast] -v=<groupingVersion>
                                <databaseDirectory>

Remove an homology grouping from the pangenome.

      <databaseDirectory>   Path to the database root directory.

  -v, --grouping-version=<groupingVersion>
                            Specific grouping version to be removed. Must be a
                              number, 'all' or 'all-inactive'.
      --fast                Do not remove is_similar relationships between mRNA
                              nodes.
```


## pantools_remove_annotations

### Tool Description
Remove all the genomic features that belong to annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required parameter: '<databaseDirectory>'

Usage: pantools remove_annotations (-A=<annotationsFile> |
                                   [--selection-file=<selectionFile> |
                                   -i=<include> | -e=<exclude>])
                                   <databaseDirectory>

Remove all the genomic features that belong to annotations.

      <databaseDirectory>   Path to the database root directory.

  -A, --annotations=<annotationsFile>
                            A text file with the identifiers of annotations to
                              be removed, each on a separate line.
      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   A selection of genomes for which all annotations
                              will be removed.
  -e, --exclude=<exclude>   A selection of genomes excluded from the removal of
                              annotations.
```


## pantools_belong

### Tool Description
Path to the database root directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required subcommand

Usage: pantools <databaseDirectory> COMMAND

      <databaseDirectory>   Path to the database root directory.

Commands:

remove data from the pangenome or panproteome
  remove_pavs, remove_pav                Remove PAV data from the pangenome.
  remove_functions                       Remove functional annotations from the
                                           pangenome.
  deactivate_grouping                    Deactivate the currently active
                                           homology grouping.
  remove_grouping                        Remove an homology grouping from the
                                           pangenome.
  remove_annotations                     Remove all the genomic features that
                                           belong to annotations.
  remove_nodes                           Remove a selection of nodes and their
                                           relationships from the pangenome.
  remove_phenotypes                      Delete phenotype nodes or remove
                                           specific phenotype information from
                                           the nodes.
  remove_variants, remove_variant        Remove variant data from the pangenome.

phylogenetic methods
  core_phylogeny, core_snp_tree          Create a SNP tree from single-copy
                                           genes. By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants are present
                                           in the pangenome, these will be used
                                           as well.
  mlsa_find_genes                        Step 1/3 of mlsa. Search and filter
                                           suitable genes for the mlsa.
  consensus_tree                         Create a consensus tree by combining
                                           gene trees from homology groups
                                           using ASTRAL-Pro. By default, only
                                           nucleotide sequences are aligned for
                                           pangenome databases and only protein
                                           sequences are aligned for
                                           panproteome databases. If variants
                                           are present in the pangenome, these
                                           will be used as well.
  mlsa                                   Step 3/3 of mlsa. Run IQ-tree on the
                                           concatenated sequences.
  ani                                    Calculate Average Nucleotide Identity
                                           (ANI) scores between genomes.
  mlsa_concatenate                       Step 2/3 of mlsa. Concatenate the gene
                                           selection into a single continuous
                                           sequence.

add annotation features to the genome
  add_antismash                          Add antiSMASH gene clusters to the
                                           pangenome.
  busco_protein                          Identify BUSCO genes in the pangenome.
  add_variants, add_variant              Add variant data to the pangenome.
  add_functions                          Add functional annotations to the
                                           pangenome.
  add_phenotypes                         Add phenotype data to the pangenome.
  add_pavs, add_pav                      Add PAV data to the pangenome.
  add_annotations                        Construct or expand the annotations of
                                           an existing pangenome.
  add_phasing                            Add phasing information to the
                                           pangenome

find genes
  find_genes_by_annotation               Find genes of interest in the
                                           pangenome that share a functional
                                           annotation node and extract the
                                           nucleotide and protein sequence.
  find_genes_in_region                   Find genes in a given genomic region.
  blast                                  Search sequences in the database using
                                           BLAST
  find_genes_by_name                     Find your genes of interest in the
                                           pangenome by using the gene name and
                                           extract the nucleotide and protein
                                           sequence.

build a pangenome
  build_pangenome                        Build a pangenome from a set of
                                           genomes. Please see the manual with
                                           'build_pangenome --manual' for a
                                           description of the options.
  add_genomes                            Add additional genomes to an existing
                                           pangenome.

matrix files
  order_matrix                           Order the values of a matrix file
                                           created by PanTools.
  rename_matrix                          Rename the headers (first row and
                                           leftmost column) of CSV formatted
                                           matrix files.

Mutation rates
  calculate_dn_ds                        Calculate synonymous and
                                           non-synonymous mutation rates

characterization of functional annotations
  go_enrichment                          Identify over- or underrepresented GO
                                           terms in a set of genes.
  functional_classification              Classify functional annotations as
                                           core, accessory or unique.
  function_overview                      Create an overview table for each
                                           functional annotation type in the
                                           pangenome.

export pangenome
  export_pangenome                       Export a pangenome built with
                                           build_pangenome into node
                                           properties, relationship properties
                                           and node sequence anchors files.

sequence visualizations
  sequence_visualization                 Generate a visualization of multiple
                                           sequences with the possibility of
                                           different types of annotation bars.

homology group info
  group_info                             Report all available information of
                                           one or multiple homology groups.

Synteny methods
  calculate_synteny                      Calculate synteny between sequences
                                           with MCScanX
  synteny_overview, synteny_statistics   Generates metrics about the synteny
                                           blocks in the pangenome
  add_synteny                            Add synteny information to the
                                           pangenome

gene locations
  locate_genes                           Identify and compare gene clusters of
                                           from a set of homology groups.

characterization of gene and k-mer content
  core_unique_thresholds                 Test the effect of changing the core
                                           and unique threshold.
  pangenome_structure                    Determine the openness of the
                                           pangenome based on homology groups
                                           or k-mer sequences.
  gene_classification                    Classify the gene repertoire as core,
                                           accessory or unique.
  k_mer_classification, kmer_classification
                                         Calculate the number of core,
                                           accessory, unique, (and phenotype
                                           specific) k-mer sequences.
  grouping_overview                      Create an overview table for every
                                           homology grouping in the pangenome.

phylogenetic tree editing
  rename_phylogeny                       Update or alter the terminal nodes
                                           (leaves) of a phylogenic tree.
  create_tree_template                   Create templates for coloring
                                           phylogenetic trees in iTOL.
  root_phylogeny                         (Re)root a phylogenetic tree.

build a panproteome
  build_panproteome                      Build a panproteome from a set of
                                           proteins.

characterization of a pangenome
  variation_overview                     Write an overview of all accessions
                                           added to the pangenome (both VCF and
                                           PAV information).
  metrics                                Generates relevant metrics of the
                                           pangenome and the individual genomes
                                           and sequences.

Repeat methods
  repeat_overview                        Generates metrics about the repeat
                                           sequences in the pangenome
  add_repeats                            Add repeat information to the pangenome

detect homology groups
  change_grouping                        Change the active version of the
                                           homology grouping.
  optimal_grouping                       Find the most suitable settings for
                                           group.
  group                                  Generate homology groups based on
                                           similarity of protein sequences.

retrieve regions or features
  retrieve_features                      Retrieve the sequence of annotated
                                           features from the pangenome.
  retrieve_regions                       Retrieve the sequence of genomic
                                           regions from the pangenome.

gene retention
  gene_retention                         Visualize gene retention of sequences
                                           to a selected query sequence

functional annotation info
  compare_go                             For two given GO terms, move up in the
                                           GO hierarchy to see if they are
                                           related.
  show_go                                For a given GO term, show the child
                                           terms, all parent terms higher in
                                           the hierarchy, and connected mRNA
                                           nodes.

read mapping
  map                                    Map single or paired-end short reads
                                           to one or multiple genomes in the
                                           pangenome. One SAM or BAM file is
                                           generated for each genome included
                                           in the analysis.

sequence alignments
  msa                                    Create multiple sequence alignments.
                                           By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants were added to
                                           a pangenome, these will be aligned
                                           by default. Required software:
                                           MAFFT, FastTree.

The full manual and tutorial can be accessed using pantools --manual, or go to
the latest stable version at https://pantools.readthedocs.io/en/stable/.
For more information on the required and optional parameters per command, call
pantools COMMAND --help; or call pantools COMMAND --manual to open the detailed
command explanation in browser.
```


## pantools_remove_nodes

### Tool Description
Remove a selection of nodes and their relationships from the pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required parameter: '<databaseDirectory>'

Usage: pantools remove_nodes (-n=<nodes> | [--label=<label>
                             [--selection-file=<selectionFile> | -e=<exclude> |
                             -i=<include>]]) <databaseDirectory>

Remove a selection of nodes and their relationships from the pangenome.

      <databaseDirectory>   Path to the database root directory.

  -n, --nodes=<nodes>       One or multiple node identifiers, separated by a
                              comma.
      --label=<label>       A node label.
      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -e, --exclude=<exclude>   Do not remove nodes of the selected genomes.
  -i, --include=<include>   Only remove nodes of the selected genomes.
```


## pantools_relationships

### Tool Description
A command-line tool for pangenome analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required subcommand

Usage: pantools <databaseDirectory> COMMAND

      <databaseDirectory>   Path to the database root directory.

Commands:

remove data from the pangenome or panproteome
  remove_pavs, remove_pav                Remove PAV data from the pangenome.
  remove_functions                       Remove functional annotations from the
                                           pangenome.
  deactivate_grouping                    Deactivate the currently active
                                           homology grouping.
  remove_grouping                        Remove an homology grouping from the
                                           pangenome.
  remove_annotations                     Remove all the genomic features that
                                           belong to annotations.
  remove_nodes                           Remove a selection of nodes and their
                                           relationships from the pangenome.
  remove_phenotypes                      Delete phenotype nodes or remove
                                           specific phenotype information from
                                           the nodes.
  remove_variants, remove_variant        Remove variant data from the pangenome.

phylogenetic methods
  core_phylogeny, core_snp_tree          Create a SNP tree from single-copy
                                           genes. By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants are present
                                           in the pangenome, these will be used
                                           as well.
  mlsa_find_genes                        Step 1/3 of mlsa. Search and filter
                                           suitable genes for the mlsa.
  consensus_tree                         Create a consensus tree by combining
                                           gene trees from homology groups
                                           using ASTRAL-Pro. By default, only
                                           nucleotide sequences are aligned for
                                           pangenome databases and only protein
                                           sequences are aligned for
                                           panproteome databases. If variants
                                           are present in the pangenome, these
                                           will be used as well.
  mlsa                                   Step 3/3 of mlsa. Run IQ-tree on the
                                           concatenated sequences.
  ani                                    Calculate Average Nucleotide Identity
                                           (ANI) scores between genomes.
  mlsa_concatenate                       Step 2/3 of mlsa. Concatenate the gene
                                           selection into a single continuous
                                           sequence.

add annotation features to the genome
  add_antismash                          Add antiSMASH gene clusters to the
                                           pangenome.
  busco_protein                          Identify BUSCO genes in the pangenome.
  add_variants, add_variant              Add variant data to the pangenome.
  add_functions                          Add functional annotations to the
                                           pangenome.
  add_phenotypes                         Add phenotype data to the pangenome.
  add_pavs, add_pav                      Add PAV data to the pangenome.
  add_annotations                        Construct or expand the annotations of
                                           an existing pangenome.
  add_phasing                            Add phasing information to the
                                           pangenome

find genes
  find_genes_by_annotation               Find genes of interest in the
                                           pangenome that share a functional
                                           annotation node and extract the
                                           nucleotide and protein sequence.
  find_genes_in_region                   Find genes in a given genomic region.
  blast                                  Search sequences in the database using
                                           BLAST
  find_genes_by_name                     Find your genes of interest in the
                                           pangenome by using the gene name and
                                           extract the nucleotide and protein
                                           sequence.

build a pangenome
  build_pangenome                        Build a pangenome from a set of
                                           genomes. Please see the manual with
                                           'build_pangenome --manual' for a
                                           description of the options.
  add_genomes                            Add additional genomes to an existing
                                           pangenome.

matrix files
  order_matrix                           Order the values of a matrix file
                                           created by PanTools.
  rename_matrix                          Rename the headers (first row and
                                           leftmost column) of CSV formatted
                                           matrix files.

Mutation rates
  calculate_dn_ds                        Calculate synonymous and
                                           non-synonymous mutation rates

characterization of functional annotations
  go_enrichment                          Identify over- or underrepresented GO
                                           terms in a set of genes.
  functional_classification              Classify functional annotations as
                                           core, accessory or unique.
  function_overview                      Create an overview table for each
                                           functional annotation type in the
                                           pangenome.

export pangenome
  export_pangenome                       Export a pangenome built with
                                           build_pangenome into node
                                           properties, relationship properties
                                           and node sequence anchors files.

sequence visualizations
  sequence_visualization                 Generate a visualization of multiple
                                           sequences with the possibility of
                                           different types of annotation bars.

homology group info
  group_info                             Report all available information of
                                           one or multiple homology groups.

Synteny methods
  calculate_synteny                      Calculate synteny between sequences
                                           with MCScanX
  synteny_overview, synteny_statistics   Generates metrics about the synteny
                                           blocks in the pangenome
  add_synteny                            Add synteny information to the
                                           pangenome

gene locations
  locate_genes                           Identify and compare gene clusters of
                                           from a set of homology groups.

characterization of gene and k-mer content
  core_unique_thresholds                 Test the effect of changing the core
                                           and unique threshold.
  pangenome_structure                    Determine the openness of the
                                           pangenome based on homology groups
                                           or k-mer sequences.
  gene_classification                    Classify the gene repertoire as core,
                                           accessory or unique.
  k_mer_classification, kmer_classification
                                         Calculate the number of core,
                                           accessory, unique, (and phenotype
                                           specific) k-mer sequences.
  grouping_overview                      Create an overview table for every
                                           homology grouping in the pangenome.

phylogenetic tree editing
  rename_phylogeny                       Update or alter the terminal nodes
                                           (leaves) of a phylogenic tree.
  create_tree_template                   Create templates for coloring
                                           phylogenetic trees in iTOL.
  root_phylogeny                         (Re)root a phylogenetic tree.

build a panproteome
  build_panproteome                      Build a panproteome from a set of
                                           proteins.

characterization of a pangenome
  variation_overview                     Write an overview of all accessions
                                           added to the pangenome (both VCF and
                                           PAV information).
  metrics                                Generates relevant metrics of the
                                           pangenome and the individual genomes
                                           and sequences.

Repeat methods
  repeat_overview                        Generates metrics about the repeat
                                           sequences in the pangenome
  add_repeats                            Add repeat information to the pangenome

detect homology groups
  change_grouping                        Change the active version of the
                                           homology grouping.
  optimal_grouping                       Find the most suitable settings for
                                           group.
  group                                  Generate homology groups based on
                                           similarity of protein sequences.

retrieve regions or features
  retrieve_features                      Retrieve the sequence of annotated
                                           features from the pangenome.
  retrieve_regions                       Retrieve the sequence of genomic
                                           regions from the pangenome.

gene retention
  gene_retention                         Visualize gene retention of sequences
                                           to a selected query sequence

functional annotation info
  compare_go                             For two given GO terms, move up in the
                                           GO hierarchy to see if they are
                                           related.
  show_go                                For a given GO term, show the child
                                           terms, all parent terms higher in
                                           the hierarchy, and connected mRNA
                                           nodes.

read mapping
  map                                    Map single or paired-end short reads
                                           to one or multiple genomes in the
                                           pangenome. One SAM or BAM file is
                                           generated for each genome included
                                           in the analysis.

sequence alignments
  msa                                    Create multiple sequence alignments.
                                           By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants were added to
                                           a pangenome, these will be aligned
                                           by default. Required software:
                                           MAFFT, FastTree.

The full manual and tutorial can be accessed using pantools --manual, or go to
the latest stable version at https://pantools.readthedocs.io/en/stable/.
For more information on the required and optional parameters per command, call
pantools COMMAND --help; or call pantools COMMAND --manual to open the detailed
command explanation in browser.
```


## pantools_remove_phenotypes

### Tool Description
Delete phenotype nodes or remove specific phenotype information from the nodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required parameter: '<databaseDirectory>'

Usage: pantools remove_phenotypes [-p=<phenotype>]
                                  [--selection-file=<selectionFile> |
                                  -i=<include> | -e=<exclude>]
                                  <databaseDirectory>

Delete phenotype nodes or remove specific phenotype information from the nodes.

      <databaseDirectory>   Path to the database root directory.

      --selection-file=<selectionFile>
                            Text file with rules to use a specific set of
                              genomes and sequences. This automatically lowers
                              the threshold for core genes.
  -i, --include=<include>   Only remove nodes of the selected genomes.
  -e, --exclude=<exclude>   Do not remove nodes of the selected genomes.
  -p, --phenotype=<phenotype>
                            Name of the phenotype.
```


## pantools_specific

### Tool Description
A command-line tool for pangenome analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required subcommand

Usage: pantools <databaseDirectory> COMMAND

      <databaseDirectory>   Path to the database root directory.

Commands:

remove data from the pangenome or panproteome
  remove_pavs, remove_pav                Remove PAV data from the pangenome.
  remove_functions                       Remove functional annotations from the
                                           pangenome.
  deactivate_grouping                    Deactivate the currently active
                                           homology grouping.
  remove_grouping                        Remove an homology grouping from the
                                           pangenome.
  remove_annotations                     Remove all the genomic features that
                                           belong to annotations.
  remove_nodes                           Remove a selection of nodes and their
                                           relationships from the pangenome.
  remove_phenotypes                      Delete phenotype nodes or remove
                                           specific phenotype information from
                                           the nodes.
  remove_variants, remove_variant        Remove variant data from the pangenome.

phylogenetic methods
  core_phylogeny, core_snp_tree          Create a SNP tree from single-copy
                                           genes. By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants are present
                                           in the pangenome, these will be used
                                           as well.
  mlsa_find_genes                        Step 1/3 of mlsa. Search and filter
                                           suitable genes for the mlsa.
  consensus_tree                         Create a consensus tree by combining
                                           gene trees from homology groups
                                           using ASTRAL-Pro. By default, only
                                           nucleotide sequences are aligned for
                                           pangenome databases and only protein
                                           sequences are aligned for
                                           panproteome databases. If variants
                                           are present in the pangenome, these
                                           will be used as well.
  mlsa                                   Step 3/3 of mlsa. Run IQ-tree on the
                                           concatenated sequences.
  ani                                    Calculate Average Nucleotide Identity
                                           (ANI) scores between genomes.
  mlsa_concatenate                       Step 2/3 of mlsa. Concatenate the gene
                                           selection into a single continuous
                                           sequence.

add annotation features to the genome
  add_antismash                          Add antiSMASH gene clusters to the
                                           pangenome.
  busco_protein                          Identify BUSCO genes in the pangenome.
  add_variants, add_variant              Add variant data to the pangenome.
  add_functions                          Add functional annotations to the
                                           pangenome.
  add_phenotypes                         Add phenotype data to the pangenome.
  add_pavs, add_pav                      Add PAV data to the pangenome.
  add_annotations                        Construct or expand the annotations of
                                           an existing pangenome.
  add_phasing                            Add phasing information to the
                                           pangenome

find genes
  find_genes_by_annotation               Find genes of interest in the
                                           pangenome that share a functional
                                           annotation node and extract the
                                           nucleotide and protein sequence.
  find_genes_in_region                   Find genes in a given genomic region.
  blast                                  Search sequences in the database using
                                           BLAST
  find_genes_by_name                     Find your genes of interest in the
                                           pangenome by using the gene name and
                                           extract the nucleotide and protein
                                           sequence.

build a pangenome
  build_pangenome                        Build a pangenome from a set of
                                           genomes. Please see the manual with
                                           'build_pangenome --manual' for a
                                           description of the options.
  add_genomes                            Add additional genomes to an existing
                                           pangenome.

matrix files
  order_matrix                           Order the values of a matrix file
                                           created by PanTools.
  rename_matrix                          Rename the headers (first row and
                                           leftmost column) of CSV formatted
                                           matrix files.

Mutation rates
  calculate_dn_ds                        Calculate synonymous and
                                           non-synonymous mutation rates

characterization of functional annotations
  go_enrichment                          Identify over- or underrepresented GO
                                           terms in a set of genes.
  functional_classification              Classify functional annotations as
                                           core, accessory or unique.
  function_overview                      Create an overview table for each
                                           functional annotation type in the
                                           pangenome.

export pangenome
  export_pangenome                       Export a pangenome built with
                                           build_pangenome into node
                                           properties, relationship properties
                                           and node sequence anchors files.

sequence visualizations
  sequence_visualization                 Generate a visualization of multiple
                                           sequences with the possibility of
                                           different types of annotation bars.

homology group info
  group_info                             Report all available information of
                                           one or multiple homology groups.

Synteny methods
  calculate_synteny                      Calculate synteny between sequences
                                           with MCScanX
  synteny_overview, synteny_statistics   Generates metrics about the synteny
                                           blocks in the pangenome
  add_synteny                            Add synteny information to the
                                           pangenome

gene locations
  locate_genes                           Identify and compare gene clusters of
                                           from a set of homology groups.

characterization of gene and k-mer content
  core_unique_thresholds                 Test the effect of changing the core
                                           and unique threshold.
  pangenome_structure                    Determine the openness of the
                                           pangenome based on homology groups
                                           or k-mer sequences.
  gene_classification                    Classify the gene repertoire as core,
                                           accessory or unique.
  k_mer_classification, kmer_classification
                                         Calculate the number of core,
                                           accessory, unique, (and phenotype
                                           specific) k-mer sequences.
  grouping_overview                      Create an overview table for every
                                           homology grouping in the pangenome.

phylogenetic tree editing
  rename_phylogeny                       Update or alter the terminal nodes
                                           (leaves) of a phylogenic tree.
  create_tree_template                   Create templates for coloring
                                           phylogenetic trees in iTOL.
  root_phylogeny                         (Re)root a phylogenetic tree.

build a panproteome
  build_panproteome                      Build a panproteome from a set of
                                           proteins.

characterization of a pangenome
  variation_overview                     Write an overview of all accessions
                                           added to the pangenome (both VCF and
                                           PAV information).
  metrics                                Generates relevant metrics of the
                                           pangenome and the individual genomes
                                           and sequences.

Repeat methods
  repeat_overview                        Generates metrics about the repeat
                                           sequences in the pangenome
  add_repeats                            Add repeat information to the pangenome

detect homology groups
  change_grouping                        Change the active version of the
                                           homology grouping.
  optimal_grouping                       Find the most suitable settings for
                                           group.
  group                                  Generate homology groups based on
                                           similarity of protein sequences.

retrieve regions or features
  retrieve_features                      Retrieve the sequence of annotated
                                           features from the pangenome.
  retrieve_regions                       Retrieve the sequence of genomic
                                           regions from the pangenome.

gene retention
  gene_retention                         Visualize gene retention of sequences
                                           to a selected query sequence

functional annotation info
  compare_go                             For two given GO terms, move up in the
                                           GO hierarchy to see if they are
                                           related.
  show_go                                For a given GO term, show the child
                                           terms, all parent terms higher in
                                           the hierarchy, and connected mRNA
                                           nodes.

read mapping
  map                                    Map single or paired-end short reads
                                           to one or multiple genomes in the
                                           pangenome. One SAM or BAM file is
                                           generated for each genome included
                                           in the analysis.

sequence alignments
  msa                                    Create multiple sequence alignments.
                                           By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants were added to
                                           a pangenome, these will be aligned
                                           by default. Required software:
                                           MAFFT, FastTree.

The full manual and tutorial can be accessed using pantools --manual, or go to
the latest stable version at https://pantools.readthedocs.io/en/stable/.
For more information on the required and optional parameters per command, call
pantools COMMAND --help; or call pantools COMMAND --manual to open the detailed
command explanation in browser.
```


## pantools_the

### Tool Description
Path to the database root directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS

### Original Help Text
```text
Missing required subcommand

Usage: pantools <databaseDirectory> COMMAND

      <databaseDirectory>   Path to the database root directory.

Commands:

remove data from the pangenome or panproteome
  remove_pavs, remove_pav                Remove PAV data from the pangenome.
  remove_functions                       Remove functional annotations from the
                                           pangenome.
  deactivate_grouping                    Deactivate the currently active
                                           homology grouping.
  remove_grouping                        Remove an homology grouping from the
                                           pangenome.
  remove_annotations                     Remove all the genomic features that
                                           belong to annotations.
  remove_nodes                           Remove a selection of nodes and their
                                           relationships from the pangenome.
  remove_phenotypes                      Delete phenotype nodes or remove
                                           specific phenotype information from
                                           the nodes.
  remove_variants, remove_variant        Remove variant data from the pangenome.

phylogenetic methods
  core_phylogeny, core_snp_tree          Create a SNP tree from single-copy
                                           genes. By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants are present
                                           in the pangenome, these will be used
                                           as well.
  mlsa_find_genes                        Step 1/3 of mlsa. Search and filter
                                           suitable genes for the mlsa.
  consensus_tree                         Create a consensus tree by combining
                                           gene trees from homology groups
                                           using ASTRAL-Pro. By default, only
                                           nucleotide sequences are aligned for
                                           pangenome databases and only protein
                                           sequences are aligned for
                                           panproteome databases. If variants
                                           are present in the pangenome, these
                                           will be used as well.
  mlsa                                   Step 3/3 of mlsa. Run IQ-tree on the
                                           concatenated sequences.
  ani                                    Calculate Average Nucleotide Identity
                                           (ANI) scores between genomes.
  mlsa_concatenate                       Step 2/3 of mlsa. Concatenate the gene
                                           selection into a single continuous
                                           sequence.

add annotation features to the genome
  add_antismash                          Add antiSMASH gene clusters to the
                                           pangenome.
  busco_protein                          Identify BUSCO genes in the pangenome.
  add_variants, add_variant              Add variant data to the pangenome.
  add_functions                          Add functional annotations to the
                                           pangenome.
  add_phenotypes                         Add phenotype data to the pangenome.
  add_pavs, add_pav                      Add PAV data to the pangenome.
  add_annotations                        Construct or expand the annotations of
                                           an existing pangenome.
  add_phasing                            Add phasing information to the
                                           pangenome

find genes
  find_genes_by_annotation               Find genes of interest in the
                                           pangenome that share a functional
                                           annotation node and extract the
                                           nucleotide and protein sequence.
  find_genes_in_region                   Find genes in a given genomic region.
  blast                                  Search sequences in the database using
                                           BLAST
  find_genes_by_name                     Find your genes of interest in the
                                           pangenome by using the gene name and
                                           extract the nucleotide and protein
                                           sequence.

build a pangenome
  build_pangenome                        Build a pangenome from a set of
                                           genomes. Please see the manual with
                                           'build_pangenome --manual' for a
                                           description of the options.
  add_genomes                            Add additional genomes to an existing
                                           pangenome.

matrix files
  order_matrix                           Order the values of a matrix file
                                           created by PanTools.
  rename_matrix                          Rename the headers (first row and
                                           leftmost column) of CSV formatted
                                           matrix files.

Mutation rates
  calculate_dn_ds                        Calculate synonymous and
                                           non-synonymous mutation rates

characterization of functional annotations
  go_enrichment                          Identify over- or underrepresented GO
                                           terms in a set of genes.
  functional_classification              Classify functional annotations as
                                           core, accessory or unique.
  function_overview                      Create an overview table for each
                                           functional annotation type in the
                                           pangenome.

export pangenome
  export_pangenome                       Export a pangenome built with
                                           build_pangenome into node
                                           properties, relationship properties
                                           and node sequence anchors files.

sequence visualizations
  sequence_visualization                 Generate a visualization of multiple
                                           sequences with the possibility of
                                           different types of annotation bars.

homology group info
  group_info                             Report all available information of
                                           one or multiple homology groups.

Synteny methods
  calculate_synteny                      Calculate synteny between sequences
                                           with MCScanX
  synteny_overview, synteny_statistics   Generates metrics about the synteny
                                           blocks in the pangenome
  add_synteny                            Add synteny information to the
                                           pangenome

gene locations
  locate_genes                           Identify and compare gene clusters of
                                           from a set of homology groups.

characterization of gene and k-mer content
  core_unique_thresholds                 Test the effect of changing the core
                                           and unique threshold.
  pangenome_structure                    Determine the openness of the
                                           pangenome based on homology groups
                                           or k-mer sequences.
  gene_classification                    Classify the gene repertoire as core,
                                           accessory or unique.
  k_mer_classification, kmer_classification
                                         Calculate the number of core,
                                           accessory, unique, (and phenotype
                                           specific) k-mer sequences.
  grouping_overview                      Create an overview table for every
                                           homology grouping in the pangenome.

phylogenetic tree editing
  rename_phylogeny                       Update or alter the terminal nodes
                                           (leaves) of a phylogenic tree.
  create_tree_template                   Create templates for coloring
                                           phylogenetic trees in iTOL.
  root_phylogeny                         (Re)root a phylogenetic tree.

build a panproteome
  build_panproteome                      Build a panproteome from a set of
                                           proteins.

characterization of a pangenome
  variation_overview                     Write an overview of all accessions
                                           added to the pangenome (both VCF and
                                           PAV information).
  metrics                                Generates relevant metrics of the
                                           pangenome and the individual genomes
                                           and sequences.

Repeat methods
  repeat_overview                        Generates metrics about the repeat
                                           sequences in the pangenome
  add_repeats                            Add repeat information to the pangenome

detect homology groups
  change_grouping                        Change the active version of the
                                           homology grouping.
  optimal_grouping                       Find the most suitable settings for
                                           group.
  group                                  Generate homology groups based on
                                           similarity of protein sequences.

retrieve regions or features
  retrieve_features                      Retrieve the sequence of annotated
                                           features from the pangenome.
  retrieve_regions                       Retrieve the sequence of genomic
                                           regions from the pangenome.

gene retention
  gene_retention                         Visualize gene retention of sequences
                                           to a selected query sequence

functional annotation info
  compare_go                             For two given GO terms, move up in the
                                           GO hierarchy to see if they are
                                           related.
  show_go                                For a given GO term, show the child
                                           terms, all parent terms higher in
                                           the hierarchy, and connected mRNA
                                           nodes.

read mapping
  map                                    Map single or paired-end short reads
                                           to one or multiple genomes in the
                                           pangenome. One SAM or BAM file is
                                           generated for each genome included
                                           in the analysis.

sequence alignments
  msa                                    Create multiple sequence alignments.
                                           By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants were added to
                                           a pangenome, these will be aligned
                                           by default. Required software:
                                           MAFFT, FastTree.

The full manual and tutorial can be accessed using pantools --manual, or go to
the latest stable version at https://pantools.readthedocs.io/en/stable/.
For more information on the required and optional parameters per command, call
pantools COMMAND --help; or call pantools COMMAND --manual to open the detailed
command explanation in browser.
```


## Metadata
- **Skill**: generated

## pantools_pantools build

### Tool Description
Path to the database root directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS
### Original Help Text
```text
Missing required subcommand

Usage: pantools <databaseDirectory> COMMAND

      <databaseDirectory>   Path to the database root directory.

Commands:

remove data from the pangenome or panproteome
  remove_pavs, remove_pav                Remove PAV data from the pangenome.
  remove_functions                       Remove functional annotations from the
                                           pangenome.
  deactivate_grouping                    Deactivate the currently active
                                           homology grouping.
  remove_grouping                        Remove an homology grouping from the
                                           pangenome.
  remove_annotations                     Remove all the genomic features that
                                           belong to annotations.
  remove_nodes                           Remove a selection of nodes and their
                                           relationships from the pangenome.
  remove_phenotypes                      Delete phenotype nodes or remove
                                           specific phenotype information from
                                           the nodes.
  remove_variants, remove_variant        Remove variant data from the pangenome.

phylogenetic methods
  core_phylogeny, core_snp_tree          Create a SNP tree from single-copy
                                           genes. By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants are present
                                           in the pangenome, these will be used
                                           as well.
  mlsa_find_genes                        Step 1/3 of mlsa. Search and filter
                                           suitable genes for the mlsa.
  consensus_tree                         Create a consensus tree by combining
                                           gene trees from homology groups
                                           using ASTRAL-Pro. By default, only
                                           nucleotide sequences are aligned for
                                           pangenome databases and only protein
                                           sequences are aligned for
                                           panproteome databases. If variants
                                           are present in the pangenome, these
                                           will be used as well.
  mlsa                                   Step 3/3 of mlsa. Run IQ-tree on the
                                           concatenated sequences.
  ani                                    Calculate Average Nucleotide Identity
                                           (ANI) scores between genomes.
  mlsa_concatenate                       Step 2/3 of mlsa. Concatenate the gene
                                           selection into a single continuous
                                           sequence.

add annotation features to the genome
  add_antismash                          Add antiSMASH gene clusters to the
                                           pangenome.
  busco_protein                          Identify BUSCO genes in the pangenome.
  add_variants, add_variant              Add variant data to the pangenome.
  add_functions                          Add functional annotations to the
                                           pangenome.
  add_phenotypes                         Add phenotype data to the pangenome.
  add_pavs, add_pav                      Add PAV data to the pangenome.
  add_annotations                        Construct or expand the annotations of
                                           an existing pangenome.
  add_phasing                            Add phasing information to the
                                           pangenome

find genes
  find_genes_by_annotation               Find genes of interest in the
                                           pangenome that share a functional
                                           annotation node and extract the
                                           nucleotide and protein sequence.
  find_genes_in_region                   Find genes in a given genomic region.
  blast                                  Search sequences in the database using
                                           BLAST
  find_genes_by_name                     Find your genes of interest in the
                                           pangenome by using the gene name and
                                           extract the nucleotide and protein
                                           sequence.

build a pangenome
  build_pangenome                        Build a pangenome from a set of
                                           genomes. Please see the manual with
                                           'build_pangenome --manual' for a
                                           description of the options.
  add_genomes                            Add additional genomes to an existing
                                           pangenome.

matrix files
  order_matrix                           Order the values of a matrix file
                                           created by PanTools.
  rename_matrix                          Rename the headers (first row and
                                           leftmost column) of CSV formatted
                                           matrix files.

Mutation rates
  calculate_dn_ds                        Calculate synonymous and
                                           non-synonymous mutation rates

characterization of functional annotations
  go_enrichment                          Identify over- or underrepresented GO
                                           terms in a set of genes.
  functional_classification              Classify functional annotations as
                                           core, accessory or unique.
  function_overview                      Create an overview table for each
                                           functional annotation type in the
                                           pangenome.

export pangenome
  export_pangenome                       Export a pangenome built with
                                           build_pangenome into node
                                           properties, relationship properties
                                           and node sequence anchors files.

sequence visualizations
  sequence_visualization                 Generate a visualization of multiple
                                           sequences with the possibility of
                                           different types of annotation bars.

homology group info
  group_info                             Report all available information of
                                           one or multiple homology groups.

Synteny methods
  calculate_synteny                      Calculate synteny between sequences
                                           with MCScanX
  synteny_overview, synteny_statistics   Generates metrics about the synteny
                                           blocks in the pangenome
  add_synteny                            Add synteny information to the
                                           pangenome

gene locations
  locate_genes                           Identify and compare gene clusters of
                                           from a set of homology groups.

characterization of gene and k-mer content
  core_unique_thresholds                 Test the effect of changing the core
                                           and unique threshold.
  pangenome_structure                    Determine the openness of the
                                           pangenome based on homology groups
                                           or k-mer sequences.
  gene_classification                    Classify the gene repertoire as core,
                                           accessory or unique.
  k_mer_classification, kmer_classification
                                         Calculate the number of core,
                                           accessory, unique, (and phenotype
                                           specific) k-mer sequences.
  grouping_overview                      Create an overview table for every
                                           homology grouping in the pangenome.

phylogenetic tree editing
  rename_phylogeny                       Update or alter the terminal nodes
                                           (leaves) of a phylogenic tree.
  create_tree_template                   Create templates for coloring
                                           phylogenetic trees in iTOL.
  root_phylogeny                         (Re)root a phylogenetic tree.

build a panproteome
  build_panproteome                      Build a panproteome from a set of
                                           proteins.

characterization of a pangenome
  variation_overview                     Write an overview of all accessions
                                           added to the pangenome (both VCF and
                                           PAV information).
  metrics                                Generates relevant metrics of the
                                           pangenome and the individual genomes
                                           and sequences.

Repeat methods
  repeat_overview                        Generates metrics about the repeat
                                           sequences in the pangenome
  add_repeats                            Add repeat information to the pangenome

detect homology groups
  change_grouping                        Change the active version of the
                                           homology grouping.
  optimal_grouping                       Find the most suitable settings for
                                           group.
  group                                  Generate homology groups based on
                                           similarity of protein sequences.

retrieve regions or features
  retrieve_features                      Retrieve the sequence of annotated
                                           features from the pangenome.
  retrieve_regions                       Retrieve the sequence of genomic
                                           regions from the pangenome.

gene retention
  gene_retention                         Visualize gene retention of sequences
                                           to a selected query sequence

functional annotation info
  compare_go                             For two given GO terms, move up in the
                                           GO hierarchy to see if they are
                                           related.
  show_go                                For a given GO term, show the child
                                           terms, all parent terms higher in
                                           the hierarchy, and connected mRNA
                                           nodes.

read mapping
  map                                    Map single or paired-end short reads
                                           to one or multiple genomes in the
                                           pangenome. One SAM or BAM file is
                                           generated for each genome included
                                           in the analysis.

sequence alignments
  msa                                    Create multiple sequence alignments.
                                           By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants were added to
                                           a pangenome, these will be aligned
                                           by default. Required software:
                                           MAFFT, FastTree.

The full manual and tutorial can be accessed using pantools --manual, or go to
the latest stable version at https://pantools.readthedocs.io/en/stable/.
For more information on the required and optional parameters per command, call
pantools COMMAND --help; or call pantools COMMAND --manual to open the detailed
command explanation in browser.
```

## pantools_pantools analyze

### Tool Description
Path to the database root directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
- **Homepage**: https://git.wur.nl/bioinformatics/pantools
- **Package**: https://anaconda.org/channels/bioconda/packages/pantools/overview
- **Validation**: PASS
### Original Help Text
```text
Missing required subcommand

Usage: pantools <databaseDirectory> COMMAND

      <databaseDirectory>   Path to the database root directory.

Commands:

remove data from the pangenome or panproteome
  remove_pavs, remove_pav                Remove PAV data from the pangenome.
  remove_functions                       Remove functional annotations from the
                                           pangenome.
  deactivate_grouping                    Deactivate the currently active
                                           homology grouping.
  remove_grouping                        Remove an homology grouping from the
                                           pangenome.
  remove_annotations                     Remove all the genomic features that
                                           belong to annotations.
  remove_nodes                           Remove a selection of nodes and their
                                           relationships from the pangenome.
  remove_phenotypes                      Delete phenotype nodes or remove
                                           specific phenotype information from
                                           the nodes.
  remove_variants, remove_variant        Remove variant data from the pangenome.

phylogenetic methods
  core_phylogeny, core_snp_tree          Create a SNP tree from single-copy
                                           genes. By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants are present
                                           in the pangenome, these will be used
                                           as well.
  mlsa_find_genes                        Step 1/3 of mlsa. Search and filter
                                           suitable genes for the mlsa.
  consensus_tree                         Create a consensus tree by combining
                                           gene trees from homology groups
                                           using ASTRAL-Pro. By default, only
                                           nucleotide sequences are aligned for
                                           pangenome databases and only protein
                                           sequences are aligned for
                                           panproteome databases. If variants
                                           are present in the pangenome, these
                                           will be used as well.
  mlsa                                   Step 3/3 of mlsa. Run IQ-tree on the
                                           concatenated sequences.
  ani                                    Calculate Average Nucleotide Identity
                                           (ANI) scores between genomes.
  mlsa_concatenate                       Step 2/3 of mlsa. Concatenate the gene
                                           selection into a single continuous
                                           sequence.

add annotation features to the genome
  add_antismash                          Add antiSMASH gene clusters to the
                                           pangenome.
  busco_protein                          Identify BUSCO genes in the pangenome.
  add_variants, add_variant              Add variant data to the pangenome.
  add_functions                          Add functional annotations to the
                                           pangenome.
  add_phenotypes                         Add phenotype data to the pangenome.
  add_pavs, add_pav                      Add PAV data to the pangenome.
  add_annotations                        Construct or expand the annotations of
                                           an existing pangenome.
  add_phasing                            Add phasing information to the
                                           pangenome

find genes
  find_genes_by_annotation               Find genes of interest in the
                                           pangenome that share a functional
                                           annotation node and extract the
                                           nucleotide and protein sequence.
  find_genes_in_region                   Find genes in a given genomic region.
  blast                                  Search sequences in the database using
                                           BLAST
  find_genes_by_name                     Find your genes of interest in the
                                           pangenome by using the gene name and
                                           extract the nucleotide and protein
                                           sequence.

build a pangenome
  build_pangenome                        Build a pangenome from a set of
                                           genomes. Please see the manual with
                                           'build_pangenome --manual' for a
                                           description of the options.
  add_genomes                            Add additional genomes to an existing
                                           pangenome.

matrix files
  order_matrix                           Order the values of a matrix file
                                           created by PanTools.
  rename_matrix                          Rename the headers (first row and
                                           leftmost column) of CSV formatted
                                           matrix files.

Mutation rates
  calculate_dn_ds                        Calculate synonymous and
                                           non-synonymous mutation rates

characterization of functional annotations
  go_enrichment                          Identify over- or underrepresented GO
                                           terms in a set of genes.
  functional_classification              Classify functional annotations as
                                           core, accessory or unique.
  function_overview                      Create an overview table for each
                                           functional annotation type in the
                                           pangenome.

export pangenome
  export_pangenome                       Export a pangenome built with
                                           build_pangenome into node
                                           properties, relationship properties
                                           and node sequence anchors files.

sequence visualizations
  sequence_visualization                 Generate a visualization of multiple
                                           sequences with the possibility of
                                           different types of annotation bars.

homology group info
  group_info                             Report all available information of
                                           one or multiple homology groups.

Synteny methods
  calculate_synteny                      Calculate synteny between sequences
                                           with MCScanX
  synteny_overview, synteny_statistics   Generates metrics about the synteny
                                           blocks in the pangenome
  add_synteny                            Add synteny information to the
                                           pangenome

gene locations
  locate_genes                           Identify and compare gene clusters of
                                           from a set of homology groups.

characterization of gene and k-mer content
  core_unique_thresholds                 Test the effect of changing the core
                                           and unique threshold.
  pangenome_structure                    Determine the openness of the
                                           pangenome based on homology groups
                                           or k-mer sequences.
  gene_classification                    Classify the gene repertoire as core,
                                           accessory or unique.
  k_mer_classification, kmer_classification
                                         Calculate the number of core,
                                           accessory, unique, (and phenotype
                                           specific) k-mer sequences.
  grouping_overview                      Create an overview table for every
                                           homology grouping in the pangenome.

phylogenetic tree editing
  rename_phylogeny                       Update or alter the terminal nodes
                                           (leaves) of a phylogenic tree.
  create_tree_template                   Create templates for coloring
                                           phylogenetic trees in iTOL.
  root_phylogeny                         (Re)root a phylogenetic tree.

build a panproteome
  build_panproteome                      Build a panproteome from a set of
                                           proteins.

characterization of a pangenome
  variation_overview                     Write an overview of all accessions
                                           added to the pangenome (both VCF and
                                           PAV information).
  metrics                                Generates relevant metrics of the
                                           pangenome and the individual genomes
                                           and sequences.

Repeat methods
  repeat_overview                        Generates metrics about the repeat
                                           sequences in the pangenome
  add_repeats                            Add repeat information to the pangenome

detect homology groups
  change_grouping                        Change the active version of the
                                           homology grouping.
  optimal_grouping                       Find the most suitable settings for
                                           group.
  group                                  Generate homology groups based on
                                           similarity of protein sequences.

retrieve regions or features
  retrieve_features                      Retrieve the sequence of annotated
                                           features from the pangenome.
  retrieve_regions                       Retrieve the sequence of genomic
                                           regions from the pangenome.

gene retention
  gene_retention                         Visualize gene retention of sequences
                                           to a selected query sequence

functional annotation info
  compare_go                             For two given GO terms, move up in the
                                           GO hierarchy to see if they are
                                           related.
  show_go                                For a given GO term, show the child
                                           terms, all parent terms higher in
                                           the hierarchy, and connected mRNA
                                           nodes.

read mapping
  map                                    Map single or paired-end short reads
                                           to one or multiple genomes in the
                                           pangenome. One SAM or BAM file is
                                           generated for each genome included
                                           in the analysis.

sequence alignments
  msa                                    Create multiple sequence alignments.
                                           By default, only nucleotide
                                           sequences are aligned for pangenome
                                           databases and only protein sequences
                                           are aligned for panproteome
                                           databases. If variants were added to
                                           a pangenome, these will be aligned
                                           by default. Required software:
                                           MAFFT, FastTree.

The full manual and tutorial can be accessed using pantools --manual, or go to
the latest stable version at https://pantools.readthedocs.io/en/stable/.
For more information on the required and optional parameters per command, call
pantools COMMAND --help; or call pantools COMMAND --manual to open the detailed
command explanation in browser.
```

