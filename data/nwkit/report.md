# nwkit CWL Generation Report

## nwkit_constrain

### Tool Description
Constrain a newick tree based on taxonomic information.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Total Downloads**: 497
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/kfuku52/nwkit
- **Stars**: N/A
### Original Help Text
```text
usage: nwkit constrain [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                       [--quoted_node_names yes|no] [--species_list PATH]
                       [--taxid_tsv PATH]
                       [--backbone ncbi|ncbi_apgiv|ncbi_user|user]
                       [--rank no|species|genus|family|order|...]
                       [--collapse yes|no]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  --species_list PATH   default=None: Text file containing species names, one
                        per line. Expected formats are "GENUS SPECIES",
                        "GENUS_SPECIES", or "GENUS_SPECIES_OTHERINFO". e.g.,
                        "Arabidopsis thaliana" and
                        "Arabidopsis_thaliana_TAIR10"
  --taxid_tsv PATH      default=None: TSV file containing species names in the
                        "leaf_name" column and their NCBI Taxonomy IDs in the
                        "taxid" column. When specified, the provided NCBI
                        Taxonomy IDs are used instead of inferring them from
                        species names. Either --species_list or --taxid_tsv
                        must be specified, but not both. This option is
                        currently compatible only with --backbone ncbi.
  --backbone ncbi|ncbi_apgiv|ncbi_user|user
                        default=ncbi: The backbone for tree constraint.
                        --infile is not required except for "user". ncbi:
                        Infer NCBI Taxonomy ID from species name, and generate
                        a tree based on the ranks. ncbi_apgiv: Infer NCBI
                        Taxonomy ID from species name, and match it with the
                        order-level angiosperm phylogeny in APG IV
                        (https://doi.org/10.1111/boj.12385). ncbi_user: Infer
                        NCBI Taxonomy ID from species name, and match the
                        ranks with the labels of the user-provided tree. user:
                        User-provided tree in --infile.
  --rank no|species|genus|family|order|...
                        default=no: Constrain at a particular taxonomic rank
                        and above. For example, if "family" is specified,
                        "genus" and "species" are not considered. This option
                        is currently compatible only with --backbone ncbi
  --collapse yes|no     default=no: For tip names of
                        "GENUS_SPECIES_OTHERINFO", drop OTHERINFO and collapse
                        clades if GENUS_SPECIES is identical. The output file
                        may be used as a species tree for phylogeny
                        reconciliation.
```


## nwkit_dist

### Tool Description
Calculate distances between two Newick trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit dist [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                  [--quoted_node_names yes|no] -i2 PATH [-f2 INT] [-d STR]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -i2, --infile2 PATH   default=: Input newick file 2.
  -f2, --format2 INT    default=auto: ETE tree format for --infile2.
  -d, --dist STR        default=RF: Distance calculation method. RF=Robinson-
                        Foulds
```


## nwkit_drop

### Tool Description
Drop nodes from a newick tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit drop [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                  [--quoted_node_names yes|no] [-t all|root|leaf|intnode]
                  [--name yes|no] [--support yes|no] [--length yes|no]
                  [--fill STR/NUMERIC]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -t, --target all|root|leaf|intnode
                        default=all: Nodes to be edited.
  --name yes|no         default=no: Drop node names.
  --support yes|no      default=no: Drop support values.
  --length yes|no       default=no: Drop branch length.
  --fill STR/NUMERIC    default=None: Fill values instead of simply dropping
                        them.
```


## nwkit_info

### Tool Description
Show information about a newick file.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit info [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                  [--quoted_node_names yes|no]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
```


## nwkit_intersection

### Tool Description
Computes the intersection of two phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit intersection [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                          [--quoted_node_names yes|no] [-i2 PATH] [-f2 INT]
                          [-si PATH] [-so PATH] [-sf STR]
                          [--match complete|prefix|backward]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -i2, --infile2 PATH   default=: Input newick file 2. The intersected version
                        of this file will not be generated, so if necessary,
                        replace --infile and --infile2 and run again.
  -f2, --format2 INT    default=auto: ETE tree format for --infile2.
  -si, --seqin PATH     default=: Input sequence file.
  -so, --seqout PATH    default=: Output sequence file.
  -sf, --seqformat STR  default=fasta: Alignment format for --seqfile. See
                        https://biopython.org/wiki/SeqIO
  --match complete|prefix|backward
                        default=complete: Method for ID matching.
```


## nwkit_label

### Tool Description
Label nodes in a Newick tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit label [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                   [--quoted_node_names yes|no] [-t all|root|leaf|intnode]
                   [--prefix STR] [--force yes|no]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -t, --target all|root|leaf|intnode
                        default=all: Nodes to be edited.
  --prefix STR          default=n: Prefix for node labels.
  --force yes|no        default=no: Whether to overwrite existing node names.
```


## nwkit_mark

### Tool Description
Mark nodes in a Newick tree based on a pattern and target type.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit mark [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                  [--quoted_node_names yes|no] -p REGEX [-t mrca|clade|leaf]
                  [--target_only_clade yes|no] --insert_txt STR
                  [--insert_sep STR] [--insert_pos prefix|suffix]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -p, --pattern REGEX   default=.*: Regular expression for label search.
  -t, --target mrca|clade|leaf
                        default=clade: Nodes to be marked.
  --target_only_clade yes|no
                        default=yes: Mark the label of MRCA/clade whose clade
                        contains only target leaves. Use with --target
                        mrca/clade
  --insert_txt STR      default=: Label to insert to the target node labels.
  --insert_sep STR      default=: Separator for --insert_txt.
  --insert_pos prefix|suffix
                        default=suffix: Place to insert --insert_txt.
```


## nwkit_mcmctree

### Tool Description
Calculate divergence times for a given newick tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit mcmctree [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                      [--quoted_node_names yes|no] [--left_species STR]
                      [--right_species STR] [--lower_bound FLOAT]
                      [--lower_offset FLOAT] [--lower_scale FLOAT]
                      [--lower_tailProb FLOAT] [--upper_bound FLOAT]
                      [--upper_tailProb FLOAT] [--add_header]
                      [--timetree point|ci|no]
                      [--min_clade_prop 0.0<FLOAT<1.0]
                      [--higher_rank_search yes|no]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  --left_species STR    default=None: Any species in the left clade. If you
                        want to set a bound on the node splitting Homo_sapiens
                        and Mus_musculus, specify one of them (e.g.,
                        Homo_sapiens).
  --right_species STR   default=None: Any species in the right clade deriving
                        from the common ancestor. If you want to set a bound
                        on the node splitting Homo_sapiens and Mus_musculus,
                        specify the other one that is not used as the left
                        species (e.g., Mus_musculus).
  --lower_bound FLOAT   default=None: Lower bound of the calibration point.
  --lower_offset FLOAT  default=0.1:
  --lower_scale FLOAT   default=1:
  --lower_tailProb FLOAT
                        default=0.025: Lower tail probability. Use 1e-300 for
                        hard bound. Default=0.025
  --upper_bound FLOAT   default=None: Upper bound of the calibration point. A
                        point estimate can be specified by setting the same
                        age in both lower and upper bounds (e.g.,
                        --lower_bound 5.2 --upper_bound 5.2)
  --upper_tailProb FLOAT
                        default=0.025: Upper tail probability. Use 1e-300 for
                        hard bound. Default=0.025
  --add_header          default=False: Add the header required for mcmctree.
  --timetree point|ci|no
                        default=no: Obtain the divergence time from
                        timetree.org. Tip labels are expected to be
                        GENUS_SPECIES. point: point estimate, ci: 95 percent
                        confidence interval as upper and lower bounds. no:
                        disable the function.
  --min_clade_prop 0.0<FLOAT<1.0
                        default=0: Minimum proportion of the clade size to the
                        total number of species. If the clade proportion is
                        smaller than this value, time constraints are removed.
  --higher_rank_search yes|no
                        default=yes: Attempt to obtain timetree data using the
                        taxids for higher taxonomic ranks if the species-level
                        search failed.
```


## nwkit_nhx2nwk

### Tool Description
Convert NHX-annotated Newick trees to standard Newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit nhx2nwk [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                     [--quoted_node_names yes|no] [-p B|D|H|S|...]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -p, --node_label B|D|H|S|...
                        default=: NHX attribute to use as internal node
                        labels.
```


## nwkit_printlabel

### Tool Description
Print labels from a newick tree based on a pattern.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit printlabel [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                        [--quoted_node_names yes|no] -p STR
                        [-t all|root|leaf|intnode] [--sister yes|no]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -p, --pattern STR     default=.*: Regular expression for label search.
  -t, --target all|root|leaf|intnode
                        default=all: Nodes to be searched.
  --sister yes|no       default=no: Show labels of the sisters instead of
                        targets.
```


## nwkit_prune

### Tool Description
Prune leaves from a newick tree based on a pattern.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit prune [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                   [--quoted_node_names yes|no] -p STR [--invert_match yes|no]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -p, --pattern STR     default=.*: Regular expression for label search.
  --invert_match yes|no
                        default=no: Prune unmatched leaves.
```


## nwkit_rescale

### Tool Description
Rescale branch lengths of a newick tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit rescale [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                     [--quoted_node_names yes|no] [-t all|root|leaf|intnode]
                     --factor FLOAT

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -t, --target all|root|leaf|intnode
                        default=all: Nodes to be edited.
  --factor FLOAT        default=1.0: Rescaling factor of branch length.
```


## nwkit_root

### Tool Description
Root a newick tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit root [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                  [--quoted_node_names yes|no] [-i2 PATH] [-f2 INT]
                  [--method STR] [--outgroup STR]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -i2, --infile2 PATH   default=: Input newick file 2. Used when --method
                        "transfer". Leaf labels should be matched to those in
                        --infile.
  -f2, --format2 INT    default=auto: ETE tree format for --infile2.
  --method STR          default=midpoint: midpoint: Midpoint rooting.
                        outgroup: Outgroup rooting with --outgroup. transfer:
                        Transfer the root position from --infile2 to --infile.
                        The two trees should have the same bipartitions at the
                        root node. mad: Minimal Ancestor Deviation rooting
                        (Tria et al. 2017). mv: Minimum Variance rooting (Mai
                        et al. 2017).
  --outgroup STR        default=: An outgroup label or a comma-separated list
                        of outgroup labels. For the latter, the clade
                        containing all specified labels are used as an
                        outgroup, so all labels do not have to be specified
                        for a large clade.
```


## nwkit_sanitize

### Tool Description
Sanitize a Newick tree file.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit sanitize [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                      [--quoted_node_names yes|no] [--remove_singleton yes|no]
                      [--resolve_polytomy yes|no]
                      [--name_quote none|single|double]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  --remove_singleton yes|no
                        default=yes: Remove singleton nodes represented as
                        double brackets.
  --resolve_polytomy yes|no
                        default=no: Resolve multifurcation (polytomy) nodes
                        into dichotomies with zero-length branches.
  --name_quote none|single|double
                        default=none: Quotation of node and leaf names.none =
                        no quote, single = ', double = "
```


## nwkit_shuffle

### Tool Description
Shuffle newick trees

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit shuffle [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                     [--quoted_node_names yes|no] [--topology yes|no]
                     [--branch_length yes|no] [--label yes|no]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  --topology yes|no     default=no: Randomize entire tree topology and branch
                        length. Without --label yes, new topology preserve the
                        leaf label orders and is not completely randomized.
  --branch_length yes|no
                        default=no: Shuffle branch length. Automatically
                        activated when --topology yes.
  --label yes|no        default=no: Shuffle leaf labels.
```


## nwkit_skim

### Tool Description
Prunes a newick tree based on trait data.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit skim [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                  [--quoted_node_names yes|no] [--trait PATH] [--group_by STR]
                  [--retain_per_clade INT] [--prioritize_non_missing yes|no]
                  [--filter_by STR] [--filter_mode ascending|descending]
                  [--only_contrastive_clades yes|no]
                  [--output_groupfile yes|no]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  --trait PATH          default=None: Path to a trait table (TSV) containing
                        leaf names in the "leaf_name" column and one or more
                        trait columns. If not specified, all leaves are
                        treated as a single group and randomly sampled.
  --group_by STR        default=None: Column name in the trait table used to
                        group leaves before sampling. Leaves in a clade are
                        treated as a group if all non-missing values in the
                        specified column are identical. If not specified, all
                        leaves are treated as a single group.
  --retain_per_clade INT
                        default=1: Number of leaves to retain per clade
                        (group). If a clade (group) contains fewer leaves than
                        this value, all of its leaves are retained.
  --prioritize_non_missing yes|no
                        default=yes: Whether to prioritize leaves with non-
                        missing trait values when sampling.
  --filter_by STR       default=None: Column name in the trait table used to
                        rank leaves within each group before sampling. If not
                        specified, leaves are randomly sampled within each
                        group.
  --filter_mode ascending|descending
                        default=ascending: Sorting order for --filter_by
                        values. If multiple leaves within a group have the
                        same value, they are randomly sampled.
  --only_contrastive_clades yes|no
                        default=no: Whether to output a pruned tree retaining
                        only minimal clades with multiple non-missing trait
                        values.
  --output_groupfile yes|no
                        default=no: Whether to output group assignment files.
                        The output filenames are <output>.all.tsv and
                        <output>.sampled.tsv, where <output> is the value of
                        --outfile without the .nwk extension.
```


## nwkit_subtree

### Tool Description
Extract subtrees from a Newick file.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit subtree [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                     [--quoted_node_names yes|no] [--left_leaf STR]
                     [--right_leaf STR] [--leaves leaf1,leaf2,leaf3,...]
                     [--orthogroup yes|no] [--dup_conf_score_threshold FLOAT]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  --left_leaf STR       default=None: Any leaf names in the left clade. For
                        example, to extract the subtree with the root node
                        splitting Homo_sapiens and Mus_musculus, specify one
                        of them (e.g., Homo_sapiens).
  --right_leaf STR      default=None: Any leaf names in the right clade. For
                        example, to extract the subtree with the root node
                        splitting Homo_sapiens and Mus_musculus, specify the
                        other one that is not used as --left_leaf (e.g.,
                        Mus_musculus).
  --leaves leaf1,leaf2,leaf3,...
                        default=None: Comma-separated list of leaves. The
                        output subtree has their most-recent common ancestor
                        as the root. --left_leaf and --right_leaf are ignored
                        if this option is specified. Single leaf name may be
                        specified in combination with --orthogroup yes.
  --orthogroup yes|no   default=no: The output subtree represents
                        orthogroup(s) that contain all specified leaves. The
                        expected format of leaf names is
                        "GENUS_SPECIES_OTHERINFO".
  --dup_conf_score_threshold FLOAT
                        default=0: The threshold of duplication-confidence
                        score for orthogroup delimitation. 0 = most stringent,
                        1 = most relaxed. For the score, see https://www.ensem
                        bl.org/info/genome/compara/homology_types.html
```


## nwkit_transfer

### Tool Description
Transfer information between two Newick trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/nwkit:0.21.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/nwkit
- **Package**: https://anaconda.org/channels/bioconda/packages/nwkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nwkit transfer [-h] [-i PATH] [-o PATH] [-f INT] [-of INT]
                      [--quoted_node_names yes|no] [-i2 PATH] [-f2 INT]
                      [-t all|root|leaf|intnode] [--name yes|no]
                      [--support yes|no] [--length yes|no]
                      [--fill STR/NUMERIC]

options:
  -h, --help            show this help message and exit
  -i, --infile PATH     default=-: Input newick file. Use "-" for STDIN.
  -o, --outfile PATH    default=-: Output newick file. Use "-" for STDOUT.
  -f, --format INT      default=auto: ETE tree format. See here http://etetool
                        kit.org/docs/latest/tutorial/tutorial_trees.html
  -of, --outformat INT  ETE tree format for --outfile. "auto" indicates the
                        same format as --format.
  --quoted_node_names yes|no
                        default=yes: Whether node names are quoted in the
                        input file.
  -i2, --infile2 PATH   default=: Input newick file 2. Specified infor will be
                        transferred from this file to --infile. Topologies may
                        deviate but leaf labels should be matched between the
                        two trees.
  -f2, --format2 INT    default=auto: ETE tree format for --infile2.
  -t, --target all|root|leaf|intnode
                        default=all: Nodes to be edited.
  --name yes|no         default=no: transfer node names.
  --support yes|no      default=no: transfer support values.
  --length yes|no       default=no: transfer branch length.
  --fill STR/NUMERIC    default=None: Fill values instead of leaving as is, if
                        no corresponding node is found.
```

