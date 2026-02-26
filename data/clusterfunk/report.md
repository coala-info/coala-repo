# clusterfunk CWL Generation Report

## clusterfunk_phylotype

### Tool Description
Assign phylotypes to a tree based on branch length thresholds.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cov-ert/clusterfunk
- **Stars**: N/A
### Original Help Text
```text
usage: clusterfunk phylotype [--threshold] [---prefix] --inputmy.tree --output my.phylotyped.tree

optional arguments:
  -h, --help            show this help message and exit
  --format {nexus,newick,nexml}
                        what format is the tree file. This is passed to
                        dendropy. default is 'nexus'
  -c COLLAPSE, --collapse_to_polytomies COLLAPSE
                        A optional flag to collapse branches with length <=
                        the input before running the rule.
  --threshold THRESHOLD
                        branch threshold used to distinguish new phylotype
                        (default: 5E-6)
  --prefix PREFIX       prefix for each phylotype. (default:p)

Required:
  -i input.tree, --input input.tree
                        The input tree file. Format can be specified with the
                        format flag.
  -o output.*, --output output.*
                        The output file
```


## clusterfunk_Assigns

### Tool Description
A tool for manipulating and annotating phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'Assigns' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_threshold

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'threshold' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_annotate_tips

### Tool Description
Annotate tips and nodes in a phylogenetic tree using taxon labels, metadata files, or MRCA rules.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk annotate  --input my.tree --output my.annotated.tree 

optional arguments:
  -h, --help            show this help message and exit
  --format {nexus,newick,nexml}
                        what format is the tree file. This is passed to
                        dendropy. default is 'nexus'
  -c COLLAPSE, --collapse_to_polytomies COLLAPSE
                        A optional flag to collapse branches with length <=
                        the input before running the rule.
  --where-trait <trait>_<qualifier>=<regex> [<trait>_<qualifier>=<regex> ...]
                        A boolean annotation will be added for each node with
                        the new trait specifying whether the annotation
                        <trait> not it matches this value. the new trait will
                        be called <trait>_<qualifier>
  -mrca MRCA [MRCA ...], --mrca MRCA [MRCA ...]
                        An optional list of traits for which the mrca of each
                        value in each traitwill be annotated with
                        '[trait_name]-mrca and assigned that value

Required:
  -i input.tree, --input input.tree
                        The input tree file. Format can be specified with the
                        format flag.
  -o output.*, --output output.*
                        The output file

Annotating from taxon labels:
  --from-taxon <trait>=<regex> [<trait>=<regex> ...]
                        Space separated list of regex group(s) parsing trait
                        values from taxon label

Annotation from metadata file:
  --in-metadata TRAITS_FILE
                        optional csv file with tip annotations
  --trait-columns TRAIT_COLUMNS [TRAIT_COLUMNS ...]
                        Space separated list of columns to annotate on tree
  --index-column INDEX_COLUMN
                        What column in the csv should be used to match the tip
                        names.
  --parse-data-key <regex>
                        regex defined group(s) to construct keys from the data
                        file to match the taxon labels
  --parse-taxon-key <regex>
                        regex defined group(s) to construct keys from the
                        taxon labels to match the data file keys
```


## clusterfunk_Annotates

### Tool Description
A suite of tools for manipulating and annotating phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'Annotates' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_ancestral_reconstruction

### Tool Description
Reconstruct ancestral states on a phylogenetic tree using ACCTRAN or DELTRAN rules.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk ancestral_reconstruction --acctran/--deltran [--ancestral_state] [--majority_rule] --traits country -i my.tree -o my.annotated.tree 

optional arguments:
  -h, --help            show this help message and exit
  --format {nexus,newick,nexml}
                        what format is the tree file. This is passed to
                        dendropy. default is 'nexus'
  -c COLLAPSE, --collapse_to_polytomies COLLAPSE
                        A optional flag to collapse branches with length <=
                        the input before running the rule.
  -acc, --acctran       Boolean flag to use acctran reconstruction
  -del, --deltran       Boolean flag to use deltran reconstruction
  --traits TRAITS [TRAITS ...]
                        the traits whose values will be reconstructed
  --ancestral_state ancestral_state [ancestral_state ...]
                        Option to set the ancestral state for the tree. In
                        same order of traits
  --majority_rule       A Boolean flag. In first stage of the Fitch algorithm,
                        at a polytomy, when there is no intersection of traits
                        from all childrenshould the trait that appears most in
                        the childrenbe assigned. Default:False - the union of
                        traits are assigned

Required:
  -i input.tree, --input input.tree
                        The input tree file. Format can be specified with the
                        format flag.
  -o output.*, --output output.*
                        The output file
```


## clusterfunk_Reconstructs

### Tool Description
A tool for manipulating and annotating phylogenetic trees. Available subcommands include phylotype, ancestral_reconstruction, prune, graft, and others.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'Reconstructs' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_Fitch

### Tool Description
A tool for phylogenetic tree manipulation and annotation. The provided help text indicates an invalid subcommand choice and lists available subcommands.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'Fitch' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_annotate_tips_from_nodes

### Tool Description
Annotate tips of a tree from its nodes based on specified traits.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk annotate_tips_from_nodes  --traits country -i my.tree -o my.annotated.tree 

optional arguments:
  -h, --help            show this help message and exit
  --format {nexus,newick,nexml}
                        what format is the tree file. This is passed to
                        dendropy. default is 'nexus'
  -c COLLAPSE, --collapse_to_polytomies COLLAPSE
                        A optional flag to collapse branches with length <=
                        the input before running the rule.
  -t traits [traits ...], --traits traits [traits ...]
                        Space separated list of discrete traits to annotate on
                        tree
  --stop-where-trait <trait>=<regex>
                        optional filter for when to stop pushing annotation
                        forward in preorder traversal from mrca.

Required:
  -i input.tree, --input input.tree
                        The input tree file. Format can be specified with the
                        format flag.
  -o output.*, --output output.*
                        The output file
```


## clusterfunk_This

### Tool Description
A suite of tools for manipulating and annotating phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'This' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_the

### Tool Description
A tool for phylogenetic tree manipulation and annotation. It provides various subcommands to process, prune, graft, and annotate trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'the' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_provided

### Tool Description
A suite of tools for manipulating and annotating phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'provided' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_descendent

### Tool Description
A suite of tools for manipulating and annotating phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'descendent' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_extract_tip_annotations

### Tool Description
Extract tip annotations from a phylogenetic tree file into a CSV.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk extract_annotations --traits country -i my.annotated.tree -o annotations.csv

optional arguments:
  -h, --help            show this help message and exit
  --format {nexus,newick,nexml}
                        what format is the tree file. This is passed to
                        dendropy. default is 'nexus'
  -c COLLAPSE, --collapse_to_polytomies COLLAPSE
                        A optional flag to collapse branches with length <=
                        the input before running the rule.
  -t traits [traits ...], --traits traits [traits ...]
                        Space separated list of traits to extract from tips

Required:
  -i input.tree, --input input.tree
                        The input tree file. Format can be specified with the
                        format flag.
  -o output.*, --output output.*
                        The output file
```


## clusterfunk_extracts

### Tool Description
A tool for manipulating and annotating phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'extracts' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_csv

### Tool Description
A tool for tree manipulation and annotation

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'csv' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_get_taxa

### Tool Description
Extract taxa from a tree file.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk get_taxa  -i input.tree -o taxa.txt

optional arguments:
  -h, --help            show this help message and exit
  --format {nexus,newick,nexml}
                        what format is the tree file. This is passed to
                        dendropy. default is 'nexus'
  -c COLLAPSE, --collapse_to_polytomies COLLAPSE
                        A optional flag to collapse branches with length <=
                        the input before running the rule.

Required:
  -i input.tree, --input input.tree
                        The input tree file. Format can be specified with the
                        format flag.
  -o output.*, --output output.*
                        The output file
```


## clusterfunk_label_transitions

### Tool Description
Label transitions of a trait on a phylogenetic tree and optionally output exploded trees for each transition.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk label_transitions --trait UK --from False --to True --transition_name introduction -i my.tree -o my.labeled.tree

optional arguments:
  -h, --help            show this help message and exit
  --format {nexus,newick,nexml}
                        what format is the tree file. This is passed to
                        dendropy. default is 'nexus'
  -c COLLAPSE, --collapse_to_polytomies COLLAPSE
                        A optional flag to collapse branches with length <=
                        the input before running the rule.
  --trait trait         Trait whose transitions are begin put on tree
  --from FROM           Label transitions from this state. Can be combined
                        with to.
  --to TO               Label transitions to this state. Can be combined with
                        from.
  --transition_name TRANSITION_NAME
                        The name of the annotation that will hold transitions.
  --transition_prefix TRANSITION_PREFIX
                        prefix for each transition value
  -e, --exploded_trees  A boolean flag to output a nexus for each transition.
                        In this case the ouput argument is treated as a
                        directory and made if it doesn't exist
  --include_parent      A boolean flag to inlcude transition parent node in
                        exploded trees

Required:
  -i input.tree, --input input.tree
                        The input tree file. Format can be specified with the
                        format flag.
  -o output.*, --output output.*
                        The output file
```


## clusterfunk_counts

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'counts' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_prune

### Tool Description
Prune or extract subtrees from a phylogenetic tree based on taxa sets, metadata, or traits.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk prune --extract [--fasta file.fas] [--taxon taxon.set.txt] [--metadata metadata.csv/tsv --index-column taxon] [--where-trait <trait>=<regex> ] -i my.tree -o my.smaller.tree 

optional arguments:
  -h, --help            show this help message and exit
  --format {nexus,newick,nexml}
                        what format is the tree file. This is passed to
                        dendropy. default is 'nexus'
  -c COLLAPSE, --collapse_to_polytomies COLLAPSE
                        A optional flag to collapse branches with length <=
                        the input before running the rule.
  --parse-data-key <regex>
                        regex defined group(s) to construct keys from the data
                        file to match the taxon labels
  --parse-taxon-key <regex>
                        regex defined group(s) to construct keys from the
                        taxon labels to match the data file keys
  --extract             Boolean flag to extract and return the subtree defined
                        by the taxa

Required:
  -i input.tree, --input input.tree
                        The input tree file. Format can be specified with the
                        format flag.
  -o output.*, --output output.*
                        The output file

Defining the taxon set:
  --fasta FASTA         incoming fasta file defining taxon set
  --taxon TAXON         incoming text file defining taxon set with a new taxon
                        on each line
  --metadata METADATA   incoming csv/tsv file defining taxon set.
  --trait TRAIT         A discrete trait. The tree will be pruned the tree for
                        each value of the trait. In this case the output will
                        be interpreted as a directory.
  --where-trait <trait>=<regex> [<trait>=<regex> ...]
                        Taxa defined by annotation value

metadata options:
  --index-column INDEX_COLUMN
                        column of metadata that holds the taxon names
```


## clusterfunk_Prunes

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'Prunes' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_keeping

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'keeping' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_from

### Tool Description
A suite of tools for manipulating and annotating phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'from' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_graft

### Tool Description
Graft incoming trees onto an input guide tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk graft --scion [trees1.tree tree2.tree] -i my.guide.tree -o my.combined.tree 

optional arguments:
  -h, --help            show this help message and exit
  --format {nexus,newick,nexml}
                        what format is the tree file. This is passed to
                        dendropy. default is 'nexus'
  -c COLLAPSE, --collapse_to_polytomies COLLAPSE
                        A optional flag to collapse branches with length <=
                        the input before running the rule.
  --scion SCION [SCION ...]
                        The incoming trees that will be grafted onto the input
                        tree
  --full_graft          A boolean flag to remove any remaining original tips
                        from the guide tree that were not found in anyscion
                        tree. i.e. all tips in the output tree come from the
                        scions
  --annotate_scions ANNOTATE_SCIONS [ANNOTATE_SCIONS ...]
                        A list of annotation values to add to the scion trees
                        in the same order the trees are listed.
  --scion_annotation_name SCION_ANNOTATION_NAME
                        the annotation name to be used in annotation each
                        scion. default: scion_id

Required:
  -i input.tree, --input input.tree
                        The input tree file. Format can be specified with the
                        format flag.
  -o output.*, --output output.*
                        The output file
```


## clusterfunk_at

### Tool Description
A tool for annotating and manipulating phylogenetic trees. Note: The provided help text indicates 'at' is an invalid subcommand choice.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'at' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```


## clusterfunk_shared

### Tool Description
A tool for phylogenetic tree manipulation and annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
- **Homepage**: https://github.com/cov-ert/clusterfunk
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterfunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: clusterfunk <subcommand> <options>
clusterfunk: error: argument : invalid choice: 'shared' (choose from 'phylotype', 'phylotype_dat_tree', 'annotate_tips', 'annotate_dat_tips', 'ancestral_reconstruction', 'annotate_tips_from_nodes', 'extract_tip_annotations', 'extract_dat_tree', 'get_taxa', 'get_dat_taxa', 'label_transitions', 'label_dat_transition', 'prune', 'prune_dat_tree', 'graft', 'graft_dat_tree')
```

