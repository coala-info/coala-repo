# forwardgenomics CWL Generation Report

## forwardgenomics_forwardGenomics.R

### Tool Description
Forward Genomics: bold [0m

### Metadata
- **Docker Image**: quay.io/biocontainers/forwardgenomics:1.0--hdfd78af_0
- **Homepage**: https://github.com/hillerlab/ForwardGenomics
- **Package**: https://anaconda.org/channels/bioconda/packages/forwardgenomics/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/forwardgenomics/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hillerlab/ForwardGenomics
- **Stars**: N/A
### Original Help Text
```text
Package xtermStyle found
Package phangorn found
Package weights found
Package isotone found
Package caper found

Forward Genomics: bold[0m
 
      Mandatory arguments:
      --tree          = filename
                      Phylogenetic tree with branch lengths in newick format. The species names must be identical to the names in the percent ID files. Ancestors must be named (otherwise use tree_doctor -a)

      --elementIDs    = filename
                      File listing the ID of each element (genomic region) that should be processed. 
                      If you want to process all elements, you can get this list with 'tail -n +2 globalPercentID.file | cut -f1 -d " "'

      --listPheno     = filename
                      File listing the phenotype for all species (all leaves in the tree). Must be a space-separated file the header 'species pheno', where 0 means trait is lost and 1 means trait is present.

      --globalPid     = filename
                      Only if you run GLS: Space-separated input file with the global %id values arranged in elements (row) x species (columns). First column must be the element ID. The first line must start with 'species'. 

      --localPid      = filename
                      Only if you run the branch method: Space-separated input file with the local %id values. Must have the header 'branch id pid'. One line per element and per branch. 

      --outFile       = filename
                      Output file that will contain the element ID and the P-values from the methods.


      General optional arguments:
      --method        = 'branch', 'GLS', 'all'
                      Which method to run. GLS includes computing the margin of the perfect-match method. Default is all.

      --verbose       = TRUE / FALSE
                      Show much more info and create plots for each element. Default is FALSE

      --outPath       = /dir/to/outputScatterPlots/
                      If verbose==TRUE, this directory will be created and will contain scatter plots for each element. If verbose==FALSE, this parameter has no effect. Default directory '.'


      Optional arguments for GLS:
      --minLosses     = number
                      In case of missing data (no %id value for some species) only consider elements where at least this many independent loss events are supported with %id values. Can be used to exclude lineage-specific losses. Default 2

      --transf        = 'raw' or 'normalized'
                      Whether to use raw global %id values or normalize them for the differences in evolutionary rates. Default normalized


      Optional arguments for the branch method:
      --weights       = filename
                      File listing the weights per branch. Must have a header 'len w'. Default is the file for coding exons: lookUpData/branchWeights_CDS.txt. Use lookUpData/branchWeights_CNE.txt for non-coding genomic regions.

      --expectedPerIDs = filename
                      File listing the expected %id values for each branch length. Must have a header 'len mPid'. Default is the file for coding exons: lookUpData/expPercentID_CDS.txt. Use lookUpData/expPercentID_CNE.txt for non-coding genomic regions.

      --thresholdConserved = floating point number
                      Some element may have large indels on internal conserved branches, but descendant branches are highly conserved. We reject genomic elements if a local %id value is lower than this threshold for a conserved branch. Set to 0 to ignore this. Default: 0.5

      Example:
      forwardGenomics.R --tree=example/tree_ancestor.nh --elementIDs=example/IDlist.txt --listPheno=example/listPhenotype.txt --globalPid=example/globalPercentID_CDS.txt --localPid=example/localPercentID_CDS.txt --outFile=example/myOutput.txt
```


## forwardgenomics_tree_doctor

### Tool Description
Scale, prune, merge, and otherwise tweak phylogenetic trees. Expects input to be a tree model (.mod) file unless filename ends with '.nh' or -n option is used, in which case it will be expected to be a tree file in Newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/forwardgenomics:1.0--hdfd78af_0
- **Homepage**: https://github.com/hillerlab/ForwardGenomics
- **Package**: https://anaconda.org/channels/bioconda/packages/forwardgenomics/overview
- **Validation**: PASS

### Original Help Text
```text
PROGRAM:      tree_doctor

DESCRIPTION:  Scale, prune, merge, and otherwise tweak phylogenetic trees.
              Expects input to be a tree model (.mod) file unless
              filename ends with '.nh' or -n option is used, in which case 
              it will be expected to be a tree file in Newick format.

USAGE:        tree_doctor [OPTIONS] <file.mod>|<file.nh>

OPTIONS:
    --prune, -p <list>
        Remove all leaves whose names are included in the given list
        (comma-separated), then remove nodes and combine branches
        to restore as a complete binary tree (i.e., with each
        node having zero children or two children).  This option is
        applied *before* all other options.

    --prune-all-but, -P <list>
        Like --prune, but remove all leaves *except* the ones specified.

    --get-subtree, -g <node_name>
        Like --prune, but remove all leaves who are not descendants of 
        node.  (Note: implies --name-ancestors if given node not 
        explicitly named in input tree)

    --rename, -r <mapping>
        Rename leaves according to the given mapping.  The format of
        <mapping> must be: "oldname1 -> newname1 ; oldname2 ->
        newname2 ; ...".  This option is applied *after* all other
        options (i.e., old names will be used for --prune, --merge,
        etc.)

    --scale, -s <factor>
        Scale all branches by the specified factor.

    --name-ancestors, -a
        Ensure names are assigned to all ancestral nodes.  If a node
        is unnamed, create a name by concatenating the names of a leaf
        from its left subtree and a leaf from its right subtree.

   --label-subtree, -L <node[+]:label>
        Add a label to the subtree of the named node.  If the node name
        is followed by a "+" sign, then the branch leading to that node
        is included in the subtree.  This may be used multiple times to add
        more than one label, though a single branch may have only one
        label.  --label-subtree and --label-branches options are parsed in
        the order given, so that later uses may override earlier ones.
        Labels are applied *after* all pruning, re-rooting, and re-naming
        options are applied.

    --label-branches, -l <branch1,branch2,...:label>
        Add a label to the branches listed.  Branches are named by the name
        of the node which descends from that branch.  See --label-subtree
        above for more information.

    --tree-only, -t
        Output tree only in Newick format rather than complete tree model.

    --no-branchlen, -N
        (Implies --tree-only).  Output only topology in Newick format.

    --dissect, -d
        In place of ordinary output, print a description of the id,
        name, parent, children, and distance to parent for each node
        of the tree.  Sometimes useful for debugging.  Can be used with
        other options.

    --branchlen, -b
        In place of ordinary output, print the total branch length of
        the tree that would have been printed.

    --depth, -D <node_name>
        In place of ordinary output, report distance from named node to
        root

    --reroot, -R <node_name>
        Reroot tree at internal node with specified name.

    --subtree, -S <node_name>
        (for use with --scale)  Alter only the branches in the subtree 
        beneath the specified node.

    --with-branch, -B <node_name>
        (For use with --reroot or --subtree) include branch above specified
        node with subtree beneath it.

    --merge, -m <file2.mod> | <file2.nh>
        Merge with another tree model or tree.  The primary model
        (<file.mod>) must have a subset of the species (leaves) in the
        secondary model (<file2.mod>), and the primary tree must be a
        proper subtree of the secondary tree (i.e., the subtree of the
        secondary tree beneath the LCA of the species in the primary
        tree must equal the primary tree in terms of topology and
        species names).  If a full tree model is given for the
        secondary tree, only the tree will be considered.  The merged
        tree model will have the rate matrix, equilibrium frequencies,
        and rate distribution of the primary model, but a merged tree
        that includes all species from both models.  The trees will be
        merged by first scaling the secondary tree such that the
        subtree corresponding to the primary tree has equal overall
        length to the primary tree, then combining the primary tree
        with the non-overlapping portion of the secondary tree.  The
        names of matching species (leaves) must be exactly equal.

    --extrapolate, -e <phylog.nh> | default
        Extrapolate to a larger set of species based on the given
        phylogeny (Newick-format).  The primary tree must be a subtree
        of the phylogeny given in <phylog.nh>, but it need not be
        a "proper" subtree (see --merge).  A copy will be created
        of the larger phylogeny then scaled such that the total branch
        length of the subtree corresponding to the primary tree equals
        the total branch length of the primary tree; this new version
        will then be used in place of the primary tree.  If the string
        "default" is given instead of a filename, then a phylogeny
        for 25 vertebrate species, estimated from sequence data for
        Target 1 (CFTR) of the NISC Comparative Sequencing Program
        (Thomas et al., Nature 424:788-793, 2003), will be assumed.
        This option is similar to merge but differs in that the branch
        length proportions of the output tree come completely from the
        larger tree and the smaller tree doesn't have to be a proper
        subset of the larger tree.

    --newick,-n
        The input file is in Newick format (necessary if file name does
        not end in .nh)

    --help, -h
        Print this help message.
```


## Metadata
- **Skill**: generated
