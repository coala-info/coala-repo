# parnas CWL Generation Report

## parnas

### Tool Description
Phylogenetic mAximum RepreseNtAtion Sampling (PARNAS)

### Metadata
- **Docker Image**: quay.io/biocontainers/parnas:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/flu-crew/parnas
- **Package**: https://anaconda.org/channels/bioconda/packages/parnas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/parnas/overview
- **Total Downloads**: 693
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/flu-crew/parnas
- **Stars**: N/A
### Original Help Text
```text
usage: parnas [-h] -t TREE [-n SAMPLES] [--prior PRIOR_REGEX]
              [--weights WEIGHTS_CSV] [--radius RADIUS] [--cover] [--binary]
              [--color OUT_PATH] [--diversity CSV_PATH]
              [--subtree SAMPLE_TREE_PATH] [--include-prior]
              [--clusters CLUSTERS_PATH] [--evaluate]
              [--exclude-rep EXCLUDE_REGEX] [--exclude-obj EOBJ_REGEX]
              [--exclude-fully FULL_REGEX] [--constrain-fully CONSTRAIN_REGEX]
              [--threshold PERCENT] [--nt NT_ALIGNMENT] [--aa AA_ALIGNMENT]

Phylogenetic mAximum RepreseNtAtion Sampling (PARNAS)

Arguments:
  -h, --help            show this help message and exit
  -t TREE, --tree TREE  Path to the input tree in newick or nexus format.
  -n SAMPLES            Number of representatives to be chosen. This argument
                        is required unless the --cover option is specified
  --prior PRIOR_REGEX   Indicate the previous representatives (if any) with a
                        regex. The regex should match a full taxon name.
                        PARNAS will then select centers that represent
                        diversity not covered by the previous representatives.
  --weights WEIGHTS_CSV
                        A CSV file specifying a weight for some or all taxa.
                        The column names must be "taxon" and "weight". If a
                        taxon is not listed in the file, its weight is assumed
                        to be 1. Maximum allowed weight is 1000 and weights
                        below 1e-8 are considered 0.
  --radius RADIUS       Each representative will "cover" all leaves within the
                        specified radius on the tree. PARNAS will then choose
                        representatives so that the amount of uncovered
                        diversity is minimized.
  --cover               Choose the best representatives (smallest number) that
                        cover all the tips within the specified
                        radius/threshold. If specified, a --radius or
                        --threshold argument must be specified as well.
  --binary              To be used with --radius. Instead of covering as much
                        diversity as possible, PARNAS will cover as many tips
                        as possible within the radius. Each leaf will have a
                        binary contribution to the objective: 0 if covered,
                        else its weight.

Output options:
  --color OUT_PATH      PARNAS will save a colored tree, where the chosen
                        representatives are highlighted and the tree is color-
                        partitioned respective to the representatives. If
                        prior centers are specified, they (and the subtrees
                        they represent) will be colored red.
  --diversity CSV_PATH  Save diversity scores for all k (number of
                        representatives) from 2 to n. Can be used to choose
                        the right number of representatives for a dataset.
  --subtree SAMPLE_TREE_PATH
                        Prune the tree to the sampled taxa and save to the
                        specified file in NEXUS format.
  --include-prior       To be used in conjuction with --subtree and --prior to
                        include the prior reps into the output subtree.
  --clusters CLUSTERS_PATH
                        PARNAS will save how it partitioned the tree based on
                        the representatives to the specified file. Output is a
                        tab-delimited file with lines as <taxon
                        name><tab><partition number>.
  --evaluate            Instead of finding new representatives, evaluate how
                        good are the prior representatives specified with "--
                        prior". This option will ignore any other output
                        options and the "--cover" flag.

Excluding taxa:
  --exclude-rep EXCLUDE_REGEX
                        Prohibits parnas to choose representatives from the
                        taxa matching this regex. However, the excluded taxa
                        will still contribute to the objective function.
  --exclude-obj EOBJ_REGEX
                        Matching taxa can be selected, but will not contribute
                        to the objective function. Can be used if one wants to
                        select taxa from a reference set.
  --exclude-fully FULL_REGEX
                        Completely ignore the taxa matching this regex.
  --constrain-fully CONSTRAIN_REGEX
                        Completely ignore the taxa NOT matching this regex.

Controlling sequence divergence:
  --threshold PERCENT   The sequence similarity threshold that works as
                        --radius. For example, "95" will imply that each
                        representative covers all leaves within 5% divergence
                        on the tree. To account for sequence divergence,
                        parnas will run TreeTime to infer ancestral
                        substitutions along the tree edges and re-weigh the
                        edges based on the number of sustitutions on them. A
                        sequence alignment (--nt or --aa) must be specified
                        with this option
  --nt NT_ALIGNMENT     Path to nucleotide sequence alignment associated with
                        the tree tips.
  --aa AA_ALIGNMENT     Path to amino acid sequence alignment associated with
                        the tree tips.
```

