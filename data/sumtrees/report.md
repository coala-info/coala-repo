# sumtrees CWL Generation Report

## sumtrees

### Tool Description
Summarizations collections of trees, e.g., MCMC samples from a posterior distribution, non-parametric bootstrap replicates, mapping posterior probability, support, or frequency that splits/clades are found in the source set of trees onto a target tree.

### Metadata
- **Docker Image**: biocontainers/sumtrees:v4.4.0-1-deb_cv1
- **Homepage**: https://github.com/brmassa/SumTree
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sumtrees/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/brmassa/SumTree
- **Stars**: N/A
### Original Help Text
```text
usage: sumtrees [-i FORMAT] [-b BURNIN] [--force-rooted] [--force-unrooted]
                [--weighted-trees] [--preserve-underscores]
                [-v ULTRAMETRICITY_PRECISION] [--taxon-name-filepath FILEPATH]
                [--tip-ages FILEPATH] [--tip-ages-format FORMAT]
                [--no-trim-tip-age-labels] [-t FILE] [-s SUMMARY-TYPE]
                [-f #.##] [--allow-unknown-target-tree-taxa]
                [--root-target-at-outgroup TAXON-LABEL]
                [--root-target-at-midpoint] [--set-outgroup TAXON-LABEL]
                [-e STRATEGY]
                [--force-minimum-edge-length FORCE_MINIMUM_EDGE_LENGTH]
                [--collapse-negative-edges] [--summarize-node-ages]
                [-l {support,keep,clear}] [--suppress-annotations] [-p] [-d #]
                [-o FILEPATH] [-F {nexus,newick,phylip,nexml}] [-x PREFIX]
                [--no-taxa-block] [--no-analysis-metainformation]
                [-c ADDITIONAL_COMMENTS] [-r] [-M] [-m NUM-PROCESSES]
                [-g LOG-FREQUENCY] [-q] [--ignore-missing-support] [-h]
                [--version] [--usage-examples] [--describe]
                [TREE-FILEPATH [TREE-FILEPATH ...]]

Summarizations collections of trees, e.g., MCMC samples from a posterior
distribution, non-parametric bootstrap replicates, mapping posterior
probability, support, or frequency that splits/clades are found in the source
set of trees onto a target tree.

Source Options:
  TREE-FILEPATH         Source(s) of trees to summarize. At least one valid
                        source of trees must be provided. Use '-' to specify
                        reading from standard input (note that this requires
                        the input file format to be explicitly set using the '
                        --source-format' option).
  -i FORMAT, --input-format FORMAT, --source-format FORMAT
                        Format of all input trees (defaults to handling either
                        NEXUS or NEWICK through inspection; it is more
                        efficient to explicitly specify the format if it is
                        known).
  -b BURNIN, --burnin BURNIN
                        Number of trees to skip from the beginning of *each*
                        tree file when counting support (default: 0).
  --force-rooted, --rooted
                        Treat source trees as rooted.
  --force-unrooted, --unrooted
                        Treat source trees as unrooted.
  --weighted-trees      Use weights of trees (as indicated by '[&W m/n]'
                        comment token) to weight contribution of splits found
                        on each tree to overall split frequencies.
  --preserve-underscores
                        Do not convert unprotected (unquoted) underscores to
                        spaces when reading NEXUS/NEWICK format trees.
  -v ULTRAMETRICITY_PRECISION, --ultrametricity-precision ULTRAMETRICITY_PRECISION, --edge-weight-epsilon ULTRAMETRICITY_PRECISION, --branch-length-epsilon ULTRAMETRICITY_PRECISION
                        Precision to use when validating ultrametricity
                        (default: 1e-05; specify '0' to disable validation).
  --taxon-name-filepath FILEPATH, --taxon-names-filepath FILEPATH
                        Path to file listing all the taxon names or labels
                        that will be found across the entire set of source
                        trees. This file should be a plain text file with a
                        single name list on each line. This file is only read
                        when multiprocessing ('-M' or '-m') is requested. When
                        multiprocessing using the '-M' or '-m' options, all
                        taxon names need to be defined in advance of any
                        actual tree analysis. By default this is done by
                        reading the first tree in the first tree source and
                        extracting the taxon names. At best, this is,
                        inefficient, as it involves an extraneous reading of
                        the tree. At worst, this can be errorneous, if the
                        first tree does not contain all the taxa. Explicitly
                        providing the taxon names via this option can avoid
                        these issues.
  --tip-ages FILEPATH, --tip-ages-filepath FILEPATH
                        Path to file providing ages (i.e., time from present)
                        of tips. For format of this file, see '--tip-age-
                        format'. If not specified, or for any taxon omitted
                        from the data, an age of 0.0 will be assumed.
  --tip-ages-format FORMAT
                        Format of the tip date data (default: 'tsv'):
                        - 'tsv'
                              A tab-delimited file. This should consist of two
                              columns separated by tabs. The first column
                              lists the taxon labels (matching the taxon label
                              of the input trees EXACTLY) and the second
                              column lists the ages of the corresponding tips.
                        - 'csv'
                              A comma-delimited file. This should consist of
                              two columns separated by commas. The first
                              column lists the taxon labels (matching the
                              taxon label of the input trees EXACTLY) and the
                              second column lists the ages of the
                              corresponding tips.
                        - 'json'
                              A JSON file. This should specify a single
                              dictionary at the top-level with keys being
                              taxon labels (matching the taxon labels of the
                              input trees EXACTLY) and values being the ages
                              of the corresponding tips.
  --no-trim-tip-age-labels
                        By default, whitespace will be trimmed from the labels
                        found in the tip ages data source. Specifing this
                        option suppresses this.

Target Tree Topology Options:
  -t FILE, --target-tree-filepath FILE
                        Summarize support and other information from the
                        source trees to topology or topologies given by the
                        tree(s) described in FILE. If no use-specified target
                        topologies are given, then a summary topology will be
                        used as the target. Use the '-s' or '--summary-target'
                        to specify the type of summary tree to use.
  -s SUMMARY-TYPE, --summary-target SUMMARY-TYPE
                        Construct and summarize support and other information
                        from the source trees to one of the following summary
                        topologies:
                        - 'consensus'
                              A consensus tree. The minimum frequency
                              threshold of clades to be included can be
                              specified using the '-f' or '--min-clade-freq'
                              flags. This is the DEFAULT if a user- specified
                              target tree is not given through the '-t' or '--
                              target-tree-filepath' options.
                        - 'mcct'
                              The maximum clade credibility tree. The tree
                              from the source set that maximizes the *product*
                              of clade posterior probabilities.
                        - 'msct'
                              The maximum sum of clade credibilities tree. The
                              tree from the source set that maximizes the
                              *sum* of clade posterior probabilities.

Target Tree Supplemental Options:
  -f #.##, --min-clade-freq #.##, --min-freq #.##, --min-split-freq #.##, --min-consensus-freq #.##
                        Minimum frequency or probability for a clade or a
                        split to be included in the summary target trees. If
                        user-defined or non-consensus trees are specified as
                        summary targets and a explicit value is provided for
                        this argument, then clades with support values below
                        this threshold will be collapsed. If a consensus tree
                        summary target is specified, then clades with support
                        values below this threshold will not be included, and
                        this threshold takes on a default value of greater
                        than 0.5 if not explicitly specified.
  --allow-unknown-target-tree-taxa
                        Do not fail with error if target tree(s) have taxa not
                        previously encountered in source trees or defined in
                        the taxon discovery file.

Target Tree Rooting Options:
  --root-target-at-outgroup TAXON-LABEL
                        Root target tree(s) using specified taxon as outgroup.
  --root-target-at-midpoint
                        Root target tree(s) at midpoint.
  --set-outgroup TAXON-LABEL
                        Rotate the target trees such the specified taxon is in
                        the outgroup position, but do not explicitly change
                        the target tree rooting.

Target Tree Edge Options:
  -e STRATEGY, --set-edges STRATEGY, --edges STRATEGY
                        Set the edge lengths of the target or summary trees
                        based on the specified summarization STRATEGY:
                        - 'mean-length'
                              Edge lengths will be set to the mean of the
                              lengths of the corresponding split or clade in
                              the source trees.
                        - 'median-length'
                               Edge lengths will be set to the median of the
                              lengths of the corresponding split or clade in
                              the source trees.
                        - 'mean-age'
                              Edge lengths will be adjusted so that the age of
                              subtended nodes will be equal to the mean age of
                              the corresponding split or clade in the source
                              trees. Source trees will need to to be
                              ultrametric for this option.
                        - 'median-age'
                              Edge lengths will be adjusted so that the age of
                              subtended nodes will be equal to the median age
                              of the corresponding split or clade in the
                              source trees. Source trees will need to to be
                              ultrametric for this option.
                        - support
                              Edge lengths will be set to the support value
                              for the split represented by the edge.
                        - 'keep'
                              Do not change the existing edge lengths. This is
                              the DEFAULT if target tree(s) are sourced from
                              an external file using the '-t' or '--target-
                              tree-filepath' option
                        - 'clear'
                              Edge lengths will be cleared from the target
                              trees if they are present.
                        Note the default settings varies according to the 
                        following, in order of preference:                  
                        (1) If target trees are specified using the '-t' or 
                            '--target-tree-filepath' option, then the default edge 
                            summarization strategy is: 'keep'. 
                        (2) If target trees are not specified, but the 
                            '--summarize-node-ages' option is specified, 
                            then the default edge summarization strategy is: 
                            'mean-age'. 
                        (3) If no target trees are specified and the 
                            node ages are NOT specified to be summarized, 
                            then the default edge summarization strategy is: 
                            'mean-length'. 
  --force-minimum-edge-length FORCE_MINIMUM_EDGE_LENGTH
                        (If setting edge lengths) force all edges to be at
                        least this length.
  --collapse-negative-edges
                        (If setting edge lengths) force parent node ages to be
                        at least as old as its oldest child when summarizing
                        node ages.

Target Tree Annotation Options:
  --summarize-node-ages, --ultrametric, --node-ages
                        Assume that source trees are ultrametic and summarize
                        node ages (distances from tips).
  -l {support,keep,clear}, --labels {support,keep,clear}
                        Set the node labels of the summary or target tree(s):
                        - 'support'
                              Node labels will be set to the support value for
                              the clade represented by the node. This is the
                              DEFAULT.
                        - 'keep'
                              Do not change the existing node labels.
                        - 'clear'
                              Node labels will be cleared from the target
                              trees if they are present.
  --suppress-annotations, --no-annotations
                        Do NOT annotate nodes and edges with any summarization
                        information metadata such as.support values, edge
                        length and/or node age summary statistcs, etc.

Support Expression Options:
  -p, --percentages     Indicate branch support as percentages (otherwise,
                        will report as proportions by default).
  -d #, --decimals #    Number of decimal places in indication of support
                        values (default: 8).

Output Options:
  -o FILEPATH, --output-tree-filepath FILEPATH, --output FILEPATH
                        Path to output file (if not specified, will print to
                        standard output).
  -F {nexus,newick,phylip,nexml}, --output-tree-format {nexus,newick,phylip,nexml}
                        Format of the output tree file (if not specifed,
                        defaults to input format, if this has been explicitly
                        specified, or 'nexus' otherwise).
  -x PREFIX, --extended-output PREFIX
                        If specified, extended summarization information will
                        be generated, consisting of the following files:
                        - '<PREFIX>.topologies.trees'
                              A collection of topologies found in the sources
                              reported with their associated posterior
                              probabilities as metadata annotations.
                        - '<PREFIX>.bipartitions.trees'
                              A collection of bipartitions, each represented
                              as a tree, with associated information as
                              metadataannotations.
                        - '<PREFIX>.bipartitions.tsv'
                              Table listing bipartitions as a group pattern as
                              the key column, and information regarding each
                              the bipartitions as the remaining columns.
                        - '<PREFIX>.edge-lengths.tsv'
                              List of bipartitions and corresponding edge
                              lengths. Only generated if edge lengths are
                              summarized.
                        - '<PREFIX>.node-ages.tsv'
                              List of bipartitions and corresponding ages.
                              Only generated if node ages are summarized.
  --no-taxa-block       When writing NEXUS format output, do not include a
                        taxa block in the output treefile (otherwise will
                        create taxa block by default).
  --no-analysis-metainformation, --no-meta-comments
                        Do not include meta-information describing the
                        summarization parameters and execution details.
  -c ADDITIONAL_COMMENTS, --additional-comments ADDITIONAL_COMMENTS
                        Additional comments to be added to the summary file.
  -r, --replace         Replace/overwrite output file without asking if it
                        already exists.

Parallel Processing Options:
  -M, --maximum-multiprocessing
                        Run in parallel mode using as many processors as
                        available, up to the number of sources.
  -m NUM-PROCESSES, --multiprocessing NUM-PROCESSES
                        Run in parallel mode with up to a maximum of NUM-
                        PROCESSES processes ('max' or '#' means to run in as
                        many processes as there are cores on the local
                        machine; i.e., same as specifying '-M' or '--maximum-
                        multiprocessing').

Program Logging Options:
  -g LOG-FREQUENCY, --log-frequency LOG-FREQUENCY
                        Tree processing progress logging frequency (default:
                        500; set to 0 to suppress).
  -q, --quiet           Suppress ALL logging, progress and feedback messages.

Program Error Options:
  --ignore-missing-support
                        Ignore missing support tree files (note that at least
                        one must exist).

Program Information Options:
  -h, --help            Show help information for program and exit.
  --version, --citation
                        Show version and citation information for program and
                        exit.
  --usage-examples      Show usage examples of program and exit.
  --describe            Show information regarding your DendroPy and Python
                        installations and exit.
```


## Metadata
- **Skill**: generated
