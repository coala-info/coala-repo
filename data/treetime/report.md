# treetime CWL Generation Report

## treetime_homoplasy

### Tool Description
Reconstructs ancestral sequences and maps mutations to the tree. The tree is then scanned for homoplasies. An excess number of homoplasies might suggest contamination, recombination, culture adaptation or similar.

### Metadata
- **Docker Image**: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
- **Homepage**: https://github.com/neherlab/treetime
- **Package**: https://anaconda.org/channels/bioconda/packages/treetime/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/treetime/overview
- **Total Downloads**: 186.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/neherlab/treetime
- **Stars**: N/A
### Original Help Text
```text
usage: TreeTime: Maximum Likelihood Phylodynamics homoplasy
       [-h] --aln ALN [--vcf-reference VCF_REFERENCE] [--tree TREE]
       [--rng-seed RNG_SEED] [--const CONST] [--rescale RESCALE] [--detailed]
       [--gtr GTR] [--gtr-params GTR_PARAMS [GTR_PARAMS ...]] [--aa]
       [--custom-gtr CUSTOM_GTR] [--zero-based] [-n N] [--drms DRMS]
       [--verbose VERBOSE] [--outdir OUTDIR]

Reconstructs ancestral sequences and maps mutations to the tree. The tree is
then scanned for homoplasies. An excess number of homoplasies might suggest
contamination, recombination, culture adaptation or similar.

options:
  -h, --help            show this help message and exit
  --aln ALN             alignment file (fasta)
  --vcf-reference VCF_REFERENCE
                        only for vcf input: fasta file of the sequence the VCF
                        was mapped to.
  --tree TREE           Name of file containing the tree in newick, nexus, or
                        phylip format, the branch length of the tree should be
                        in units of average number of nucleotide or protein
                        substitutions per site. If no file is provided,
                        treetime will attempt to build a tree from the
                        alignment using fasttree, iqtree, or raxml (assuming
                        they are installed).
  --rng-seed RNG_SEED   random number generator seed for treetime
  --const CONST         number of constant sites not included in alignment
  --rescale RESCALE     rescale branch lengths
  --detailed            generate a more detailed report
  --gtr GTR             GTR model to use. '--gtr infer' will infer a model
                        from the data. Alternatively, specify the model type.
                        If the specified model requires additional options,
                        use '--gtr-params' to specify those.
  --gtr-params GTR_PARAMS [GTR_PARAMS ...]
                        GTR parameters for the model specified by the --gtr
                        argument. The parameters should be feed as 'key=value'
                        list of parameters. Example: '--gtr K80 --gtr-params
                        kappa=0.2 pis=0.25,0.25,0.25,0.25'. See the exact
                        definitions of the parameters in the GTR creation
                        methods in treetime/nuc_models.py or
                        treetime/aa_models.py
  --aa                  use aminoacid alphabet
  --custom-gtr CUSTOM_GTR
                        filename of pre-defined custom GTR model in standard
                        TreeTime format
  --zero-based          zero based mutation indexing
  -n N                  number of mutations/nodes that are printed to screen
  --drms DRMS           TSV file containing DRM info. columns headers:
                        GENOMIC_POSITION, ALT_BASE, DRUG, GENE, SUBSTITUTION
  --verbose VERBOSE     verbosity of output 0-6
  --outdir OUTDIR       directory to write the output to
```


## treetime_ancestral

### Tool Description
Reconstructs ancestral sequences and maps mutations to the tree. The output consists of a file 'ancestral.fasta' with ancestral sequences and a tree 'annotated_tree.nexus' with mutations added as comments like A45G,G136T,..., number in SNPs used 1-based index by default. The inferred GTR model is written to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
- **Homepage**: https://github.com/neherlab/treetime
- **Package**: https://anaconda.org/channels/bioconda/packages/treetime/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TreeTime: Maximum Likelihood Phylodynamics ancestral
       [-h] --aln ALN [--vcf-reference VCF_REFERENCE] [--tree TREE]
       [--rng-seed RNG_SEED] [--gtr GTR]
       [--gtr-params GTR_PARAMS [GTR_PARAMS ...]] [--aa]
       [--custom-gtr CUSTOM_GTR] [--marginal] [--keep-overhangs]
       [--zero-based] [--reconstruct-tip-states] [--report-ambiguous]
       [--method-anc {parsimony,fitch,probabilistic,ml}] [--verbose VERBOSE]
       [--outdir OUTDIR]

Reconstructs ancestral sequences and maps mutations to the tree. The output
consists of a file 'ancestral.fasta' with ancestral sequences and a tree
'annotated_tree.nexus' with mutations added as comments like A45G,G136T,...,
number in SNPs used 1-based index by default. The inferred GTR model is
written to stdout.

options:
  -h, --help            show this help message and exit
  --aln ALN             alignment file (fasta)
  --vcf-reference VCF_REFERENCE
                        only for vcf input: fasta file of the sequence the VCF
                        was mapped to.
  --tree TREE           Name of file containing the tree in newick, nexus, or
                        phylip format, the branch length of the tree should be
                        in units of average number of nucleotide or protein
                        substitutions per site. If no file is provided,
                        treetime will attempt to build a tree from the
                        alignment using fasttree, iqtree, or raxml (assuming
                        they are installed).
  --rng-seed RNG_SEED   random number generator seed for treetime
  --gtr GTR             GTR model to use. '--gtr infer' will infer a model
                        from the data. Alternatively, specify the model type.
                        If the specified model requires additional options,
                        use '--gtr-params' to specify those.
  --gtr-params GTR_PARAMS [GTR_PARAMS ...]
                        GTR parameters for the model specified by the --gtr
                        argument. The parameters should be feed as 'key=value'
                        list of parameters. Example: '--gtr K80 --gtr-params
                        kappa=0.2 pis=0.25,0.25,0.25,0.25'. See the exact
                        definitions of the parameters in the GTR creation
                        methods in treetime/nuc_models.py or
                        treetime/aa_models.py
  --aa                  use aminoacid alphabet
  --custom-gtr CUSTOM_GTR
                        filename of pre-defined custom GTR model in standard
                        TreeTime format
  --marginal            marginal reconstruction of ancestral sequences
  --keep-overhangs      do not fill terminal gaps
  --zero-based          zero based mutation indexing
  --reconstruct-tip-states
                        overwrite ambiguous states on tips with the most
                        likely inferred state
  --report-ambiguous    include transitions involving ambiguous states
  --method-anc {parsimony,fitch,probabilistic,ml}
                        method used for reconstructing ancestral sequences,
                        default is 'probabilistic'
  --verbose VERBOSE     verbosity of output 0-6
  --outdir OUTDIR       directory to write the output to
```


## treetime_mugration

### Tool Description
Reconstructs discrete ancestral states, for example geographic location, host, or similar. In addition to ancestral states, a GTR model of state transitions is inferred.

### Metadata
- **Docker Image**: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
- **Homepage**: https://github.com/neherlab/treetime
- **Package**: https://anaconda.org/channels/bioconda/packages/treetime/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TreeTime: Maximum Likelihood Phylodynamics mugration
       [-h] --tree TREE [--rng-seed RNG_SEED] [--name-column NAME_COLUMN]
       [--attribute ATTRIBUTE] --states STATES [--weights WEIGHTS]
       [--confidence] [--pc PC] [--missing-data MISSING_DATA]
       [--sampling-bias-correction SAMPLING_BIAS_CORRECTION]
       [--verbose VERBOSE] [--outdir OUTDIR]

Reconstructs discrete ancestral states, for example geographic location, host,
or similar. In addition to ancestral states, a GTR model of state transitions
is inferred.

options:
  -h, --help            show this help message and exit
  --tree TREE           Name of file containing the tree in newick, nexus, or
                        phylip format, the branch length of the tree should be
                        in units of average number of nucleotide or protein
                        substitutions per site. If no file is provided,
                        treetime will attempt to build a tree from the
                        alignment using fasttree, iqtree, or raxml (assuming
                        they are installed).
  --rng-seed RNG_SEED   random number generator seed for treetime
  --name-column NAME_COLUMN
                        label of the column to be used as taxon name
  --attribute ATTRIBUTE
                        attribute to reconstruct, e.g. country
  --states STATES       csv or tsv file with discrete characters.
                        #name,country,continent taxon1,micronesia,oceania ...
  --weights WEIGHTS     csv or tsv file with probabilities of that a randomly
                        sampled sequence at equilibrium has a particular
                        state. E.g. population of different continents or
                        countries. E.g.: #country,weight micronesia,0.1 ...
  --confidence          output confidence of mugration inference
  --pc PC               pseudo-counts higher numbers will results in 'flatter'
                        models
  --missing-data MISSING_DATA
                        string indicating missing data
  --sampling-bias-correction SAMPLING_BIAS_CORRECTION
                        a rough estimate of how many more events would have
                        been observed if sequences represented an even sample.
                        This should be roughly the (1-sum_i p_i^2)/(1-sum_i
                        t_i^2), where p_i are the equilibrium frequencies and
                        t_i are apparent ones.(or rather the time spent in a
                        particular state on the tree)
  --verbose VERBOSE     verbosity of output 0-6
  --outdir OUTDIR       directory to write the output to
```


## treetime_clock

### Tool Description
Calculates the root-to-tip regression and quantifies the 'clock-i-ness' of the tree. It will reroot the tree to maximize the clock-like signal and recalculate branch length unless run with --keep-root.

### Metadata
- **Docker Image**: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
- **Homepage**: https://github.com/neherlab/treetime
- **Package**: https://anaconda.org/channels/bioconda/packages/treetime/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TreeTime: Maximum Likelihood Phylodynamics clock [-h] --tree TREE
                                                        [--rng-seed RNG_SEED]
                                                        [--dates DATES]
                                                        [--name-column NAME_COLUMN]
                                                        [--date-column DATE_COLUMN]
                                                        [--sequence-length SEQUENCE_LENGTH]
                                                        [--aln ALN]
                                                        [--vcf-reference VCF_REFERENCE]
                                                        [--clock-filter CLOCK_FILTER]
                                                        [--clock-filter-method {residual,local}]
                                                        [--reroot REROOT [REROOT ...]
                                                        | --keep-root]
                                                        [--tip-slack TIP_SLACK]
                                                        [--covariation]
                                                        [--prune-outliers]
                                                        [--allow-negative-rate]
                                                        [--plot-rtt PLOT_RTT]
                                                        [--verbose VERBOSE]
                                                        [--outdir OUTDIR]

Calculates the root-to-tip regression and quantifies the 'clock-i-ness' of the
tree. It will reroot the tree to maximize the clock-like signal and
recalculate branch length unless run with --keep-root.

options:
  -h, --help            show this help message and exit
  --tree TREE           Name of file containing the tree in newick, nexus, or
                        phylip format, the branch length of the tree should be
                        in units of average number of nucleotide or protein
                        substitutions per site. If no file is provided,
                        treetime will attempt to build a tree from the
                        alignment using fasttree, iqtree, or raxml (assuming
                        they are installed).
  --rng-seed RNG_SEED   random number generator seed for treetime
  --dates DATES         csv file with dates for nodes with 'node_name, date'
                        where date is float (as in 2012.15) or in ISO-format
                        (YYYY-MM-DD). Imprecisely known dates can be specified
                        as '2023-XX-XX' or [2013.2:2013.7]
  --name-column NAME_COLUMN
                        label of the column to be used as taxon name
  --date-column DATE_COLUMN
                        label of the column to be used as sampling date
  --sequence-length SEQUENCE_LENGTH
                        length of the sequence, used to calculate expected
                        variation in branch length. Not required if alignment
                        is provided.
  --aln ALN             alignment file (fasta)
  --vcf-reference VCF_REFERENCE
                        only for vcf input: fasta file of the sequence the VCF
                        was mapped to.
  --clock-filter CLOCK_FILTER
                        ignore tips that don't follow a loose clock, 'clock-
                        filter=number of interquartile ranges from regression
                        (method=`residual`)' or z-score of local clock
                        deviation (method=`local`). Default=4.0, set to 0 to
                        switch off.
  --clock-filter-method {residual,local}
                        Use residuals from global clock (`residual`, default)
                        or local clock deviation (`clock`) to filter out tips
                        that don't follow the clock
  --reroot REROOT [REROOT ...]
                        Reroot the tree using root-to-tip regression. Valid
                        choices are 'min_dev', 'least-squares', and 'oldest'.
                        'least-squares' adjusts the root to minimize residuals
                        of the root-to-tip vs sampling time regression,
                        'min_dev' minimizes variance of root-to-tip distances.
                        'least-squares' can be combined with --covariation to
                        account for shared ancestry. Alternatively, you can
                        specify a node name or a list of node names to be used
                        as outgroup or use 'oldest' to reroot to the oldest
                        node. By default, TreeTime will reroot using 'least-
                        squares'. Use --keep-root to keep the current root.
  --keep-root           don't reroot the tree. Otherwise, reroot to minimize
                        the the residual of the regression of root-to-tip
                        distance and sampling time
  --tip-slack TIP_SLACK
                        excess variance associated with terminal nodes
                        accounting for overdispersion of the molecular clock
  --covariation         Account for covariation when estimating rates or
                        rerooting using root-to-tip regression, default False.
  --prune-outliers      remove detected outliers from the output tree
  --allow-negative-rate
                        By default, rates are forced to be positive. For trees
                        with little temporal signal it is advisable to remove
                        this restriction to achieve essentially mid-point
                        rooting.
  --plot-rtt PLOT_RTT   filename to save the plot to. Suffix will determine
                        format (choices pdf, png, svg, default=pdf)
  --verbose VERBOSE     verbosity of output 0-6
  --outdir OUTDIR       directory to write the output to
```


## treetime_arg

### Tool Description
Calculates the root-to-tip regression and quantifies the 'clock-i-ness' of the tree. It will reroot the tree to maximize the clock-like signal and recalculate branch length unless run with --keep_root.

### Metadata
- **Docker Image**: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
- **Homepage**: https://github.com/neherlab/treetime
- **Package**: https://anaconda.org/channels/bioconda/packages/treetime/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TreeTime: Maximum Likelihood Phylodynamics arg [-h]
                                                      [--rng-seed RNG_SEED]
                                                      --trees TREES TREES
                                                      --alignments ALIGNMENTS
                                                      ALIGNMENTS --mccs MCCS
                                                      [--clock-rate CLOCK_RATE]
                                                      [--clock-std-dev CLOCK_STD_DEV]
                                                      [--branch-length-mode {auto,input,joint,marginal}]
                                                      [--confidence]
                                                      [--time-marginal {false,true,assign,always,only-final,never}]
                                                      [--keep-polytomies]
                                                      [--stochastic-resolve]
                                                      [--greedy-resolve]
                                                      [--relax RELAX RELAX]
                                                      [--max-iter MAX_ITER]
                                                      [--coalescent COALESCENT]
                                                      [--n-skyline N_SKYLINE]
                                                      [--gen-per-year GEN_PER_YEAR]
                                                      [--n-branches-posterior]
                                                      [--plot-tree PLOT_TREE]
                                                      [--plot-rtt PLOT_RTT]
                                                      [--tip-labels]
                                                      [--no-tip-labels]
                                                      [--dates DATES]
                                                      [--name-column NAME_COLUMN]
                                                      [--date-column DATE_COLUMN]
                                                      [--sequence-length SEQUENCE_LENGTH]
                                                      [--aln ALN]
                                                      [--vcf-reference VCF_REFERENCE]
                                                      [--keep-overhangs]
                                                      [--zero-based]
                                                      [--reconstruct-tip-states]
                                                      [--report-ambiguous]
                                                      [--method-anc {parsimony,fitch,probabilistic,ml}]
                                                      [--clock-filter CLOCK_FILTER]
                                                      [--clock-filter-method {residual,local}]
                                                      [--reroot REROOT [REROOT ...]
                                                      | --keep-root]
                                                      [--tip-slack TIP_SLACK]
                                                      [--covariation]
                                                      [--verbose VERBOSE]
                                                      [--outdir OUTDIR]

Calculates the root-to-tip regression and quantifies the 'clock-i-ness' of the
tree. It will reroot the tree to maximize the clock-like signal and
recalculate branch length unless run with --keep_root.

options:
  -h, --help            show this help message and exit
  --rng-seed RNG_SEED   random number generator seed for treetime
  --trees TREES TREES
  --alignments ALIGNMENTS ALIGNMENTS
  --mccs MCCS
  --clock-rate CLOCK_RATE
                        if specified, the rate of the molecular clock won't be
                        optimized.
  --clock-std-dev CLOCK_STD_DEV
                        standard deviation of the provided clock rate estimate
  --branch-length-mode {auto,input,joint,marginal}
                        If set to 'input', the provided branch length will be
                        used without modification. Note that branch lengths
                        optimized by treetime are only accurate at short
                        evolutionary distances.
  --confidence          estimate confidence intervals of divergence times
                        using the marginal posterior distribution, if `--time-
                        marginal` is False (default) inferred divergence times
                        will still be calculated using the jointly most likely
                        tree configuration.
  --time-marginal {false,true,assign,always,only-final,never}
                        For 'false' or 'never', TreeTime uses the jointly most
                        likely values for the divergence times. For 'true' and
                        'always', it uses the marginal inference mode at every
                        round of optimization, for 'only-final' (or 'assign'
                        for compatibility with previous versions) only uses
                        the marginal distribution in the final round.
  --keep-polytomies     Don't resolve polytomies using temporal information.
  --stochastic-resolve  Resolve polytomies using a random coalescent tree.
  --greedy-resolve      Resolve polytomies greedily. Currently default, but
                        will switched to `stochastic-resolve` in future
                        versions.
  --relax RELAX RELAX   use an autocorrelated molecular clock. Strength of the
                        gaussian priors on branch specific rate deviation and
                        the coupling of parent and offspring rates can be
                        specified e.g. as --relax 1.0 0.5. Values around 1.0
                        correspond to weak priors, larger values constrain
                        rate deviations more strongly. Coupling 0 (--relax 1.0
                        0) corresponds to an un-correlated clock.
  --max-iter MAX_ITER   maximal number of iterations the inference cycle is
                        run. Note that for polytomy resolution and coalescence
                        models max_iter should be at least 2
  --coalescent COALESCENT
                        coalescent time scale -- sensible values are on the
                        order of the average hamming distance of
                        contemporaneous sequences. In addition, 'opt'
                        'skyline' are valid options and estimate a constant
                        coalescent rate or a piecewise linear coalescent rate
                        history
  --n-skyline N_SKYLINE
                        number of grid points in skyline coalescent model
  --gen-per-year GEN_PER_YEAR
                        number of generations per year - used for estimating
                        N_e in coalescent models
  --n-branches-posterior
                        add posterior LH to coalescent model: use the
                        posterior probability distributions of divergence
                        times for estimating the number of branches when
                        calculating the coalescent mergerrate or use inferred
                        time before present (default).
  --plot-tree PLOT_TREE
                        filename to save the plot to. Suffix will determine
                        format (choices pdf, png, svg, default=pdf)
  --plot-rtt PLOT_RTT   filename to save the plot to. Suffix will determine
                        format (choices pdf, png, svg, default=pdf)
  --tip-labels          add tip labels (default for small trees with <30
                        leaves)
  --no-tip-labels       don't show tip labels (default for small trees with
                        >=30 leaves)
  --dates DATES         csv file with dates for nodes with 'node_name, date'
                        where date is float (as in 2012.15) or in ISO-format
                        (YYYY-MM-DD). Imprecisely known dates can be specified
                        as '2023-XX-XX' or [2013.2:2013.7]
  --name-column NAME_COLUMN
                        label of the column to be used as taxon name
  --date-column DATE_COLUMN
                        label of the column to be used as sampling date
  --sequence-length SEQUENCE_LENGTH
                        length of the sequence, used to calculate expected
                        variation in branch length. Not required if alignment
                        is provided.
  --aln ALN             alignment file (fasta)
  --vcf-reference VCF_REFERENCE
                        only for vcf input: fasta file of the sequence the VCF
                        was mapped to.
  --keep-overhangs      do not fill terminal gaps
  --zero-based          zero based mutation indexing
  --reconstruct-tip-states
                        overwrite ambiguous states on tips with the most
                        likely inferred state
  --report-ambiguous    include transitions involving ambiguous states
  --method-anc {parsimony,fitch,probabilistic,ml}
                        method used for reconstructing ancestral sequences,
                        default is 'probabilistic'
  --clock-filter CLOCK_FILTER
                        ignore tips that don't follow a loose clock, 'clock-
                        filter=number of interquartile ranges from regression
                        (method=`residual`)' or z-score of local clock
                        deviation (method=`local`). Default=4.0, set to 0 to
                        switch off.
  --clock-filter-method {residual,local}
                        Use residuals from global clock (`residual`, default)
                        or local clock deviation (`clock`) to filter out tips
                        that don't follow the clock
  --reroot REROOT [REROOT ...]
                        Reroot the tree using root-to-tip regression. Valid
                        choices are 'min_dev', 'least-squares', and 'oldest'.
                        'least-squares' adjusts the root to minimize residuals
                        of the root-to-tip vs sampling time regression,
                        'min_dev' minimizes variance of root-to-tip distances.
                        'least-squares' can be combined with --covariation to
                        account for shared ancestry. Alternatively, you can
                        specify a node name or a list of node names to be used
                        as outgroup or use 'oldest' to reroot to the oldest
                        node. By default, TreeTime will reroot using 'least-
                        squares'. Use --keep-root to keep the current root.
  --keep-root           don't reroot the tree. Otherwise, reroot to minimize
                        the the residual of the regression of root-to-tip
                        distance and sampling time
  --tip-slack TIP_SLACK
                        excess variance associated with terminal nodes
                        accounting for overdispersion of the molecular clock
  --covariation         Account for covariation when estimating rates or
                        rerooting using root-to-tip regression, default False.
  --verbose VERBOSE     verbosity of output 0-6
  --outdir OUTDIR       directory to write the output to
```


## treetime_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
- **Homepage**: https://github.com/neherlab/treetime
- **Package**: https://anaconda.org/channels/bioconda/packages/treetime/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: TreeTime: Maximum Likelihood Phylodynamics version [-h]

print version

options:
  -h, --help  show this help message and exit
```


## Metadata
- **Skill**: generated
