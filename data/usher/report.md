# usher CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| usher | PASS |  |
| usher_check_samples_place | PASS |  |
| usher_compareVCF | PASS |  |
| usher_faToVcf | PASS |  |
| usher_matOptimize | Failed | tool bug: the documented --epps_on_branch_len option silently leaves the output tree empty (only the Newick file is written); the default run works |
| usher_matUtils_annotate | PASS |  |
| usher_matUtils_extract | PASS |  |
| usher_matUtils_fix | PASS | tree had no grandparent reversions, so the output tree equals the input |
| usher_matUtils_introduce | PASS | tested with country labels taken from the sample names |
| usher_matUtils_mask | PASS |  |
| usher_matUtils_merge | PASS |  |
| usher_matUtils_summary | PASS |  |
| usher_matUtils_uncertainty | PASS |  |
| usher_ripples | PASS |  |
| usher_ripples-fast | PASS |  |
| usher_ripplesInit | PASS |  |
| usher_transpose_vcf | PASS |  |
| usher_transposed_vcf_print_name | PASS |  |
| usher_transposed_vcf_to_fa | PASS | output is always gzip-compressed, even without a .gz name |
| usher_transposed_vcf_to_vcf | PASS | output is always gzip-compressed, even without a .gz name |
| usher_usher-sampled | PASS | tested with an uncompressed VCF; the tiny .gz test VCF crashes the tool |

## usher

### Tool Description
UShER (v0.6.6)

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Total Downloads**: 285.9K
- **Last updated**: 2025-10-07
- **GitHub**: https://github.com/yatisht/usher
- **Stars**: N/A
### Original Help Text
```text
UShER (v0.6.6)
Options:
  -v [ --vcf ] arg                      Input VCF file (in uncompressed or 
                                        gzip-compressed .gz format) [REQUIRED]
  -t [ --tree ] arg                     Input tree file
  -d [ --outdir ] arg (=.)              Output directory to dump output and log
                                        files [DEFAULT uses current directory]
  -i [ --load-mutation-annotated-tree ] arg
                                        Load mutation-annotated tree object
  -o [ --save-mutation-annotated-tree ] arg
                                        Save output mutation-annotated tree 
                                        object to the specified filename
  -s [ --sort-before-placement-1 ]      Sort new samples based on computed 
                                        parsimony score and then number of 
                                        optimal placements before the actual 
                                        placement [EXPERIMENTAL].
  -S [ --sort-before-placement-2 ]      Sort new samples based on the number of
                                        optimal placements and then the 
                                        parsimony score before the actual 
                                        placement [EXPERIMENTAL].
  -A [ --sort-before-placement-3 ]      Sort new samples based on the number of
                                        ambiguous bases [EXPERIMENTAL].
  -r [ --reverse-sort ]                 Reverse the sorting order of sorting 
                                        options (sort-before-placement-1 or 
                                        sort-before-placement-2) [EXPERIMENTAL]
  -c [ --collapse-tree ]                Collapse internal nodes of the input 
                                        tree with no mutations and condense 
                                        identical sequences in polytomies into 
                                        a single node and the save the tree to 
                                        file condensed-tree.nh in outdir
  -C [ --collapse-output-tree ]         Collapse internal nodes of the output 
                                        tree with no mutations before the 
                                        saving the tree to file final-tree.nh 
                                        in outdir
  -e [ --max-uncertainty-per-sample ] arg (=1000000)
                                        Maximum number of equally parsimonious 
                                        placements allowed per sample beyond 
                                        which the sample is ignored
  -E [ --max-parsimony-per-sample ] arg (=1000000)
                                        Maximum parsimony score of the most 
                                        parsimonious placement(s) allowed per 
                                        sample beyond which the sample is 
                                        ignored
  -u [ --write-uncondensed-final-tree ] 
                                        Write the final tree in uncondensed 
                                        format and save to file 
                                        uncondensed-final-tree.nh in outdir
  -k [ --write-subtrees-size ] arg (=0) Write minimum set of subtrees covering 
                                        the newly added samples of size equal 
                                        to this value
  -K [ --write-single-subtree ] arg (=0)
                                        Similar to write-subtrees-size but 
                                        produces a single subtree with all 
                                        newly added samples along with random 
                                        samples up to the value specified by 
                                        this argument
  -p [ --write-parsimony-scores-per-node ] 
                                        Write the parsimony scores for adding 
                                        new samples at each existing node in 
                                        the tree without modifying the tree in 
                                        a file names parsimony-scores.tsv in 
                                        outdir
  -M [ --multiple-placements ] arg (=1) Create a new tree up to this limit for 
                                        each possibility of parsimony-optimal 
                                        placement
  -l [ --retain-input-branch-lengths ]  Retain the branch lengths from the 
                                        input tree in out newick files instead 
                                        of using number of mutations for the 
                                        branch lengths.
  -n [ --no-add ]                       Do not add new samples to the tree
  -D [ --detailed-clades ]              In clades.txt, write a histogram of 
                                        annotated clades and counts across all 
                                        equally parsimonious placements
  -T [ --threads ] arg (=20)            Number of threads to use when possible 
                                        [DEFAULT uses all available cores, 20 
                                        detected on this machine]
  --version                             Print version number
  -h [ --help ]                         Print help messages
```

## usher_matUtils_summary

### Tool Description
matUtils summary: calculates basic statistics and counts samples, mutations, and clades in the input mutation-annotated tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
summary options:
  -i [ --input-mat ] arg              Input mutation-annotated tree file 
                                      [REQUIRED]. If only this argument is set,
                                      print the count of samples and nodes in 
                                      the tree.
  -g [ --input-gtf ] arg              Input GTF annotation file. Required for 
                                      --translate / -t
  -f [ --input-fasta ] arg            Input FASTA reference sequence. Required 
                                      for --translate / -t
  -d [ --output-directory ] arg (=./) Write output files to the target 
                                      directory. Default is current directory.
  -s [ --samples ] arg                Write a tsv listing all samples in the 
                                      tree, their parsimony score (terminal 
                                      branch length), and the ID of their 
                                      parent node.
  -c [ --clades ] arg                 Write a tsv listing all clades and the 
                                      (inclusive and exclusive of nested 
                                      clades) count of associated samples.
  -C [ --sample-clades ] arg          Write a tsv of all samples and their 
                                      associated clade values
  -m [ --mutations ] arg              Write a tsv listing all mutations in the 
                                      tree and their occurrence count.
  -t [ --translate ] arg              Write a tsv listing the amino acid and 
                                      nucleotide mutations at each node.
  -a [ --aberrant ] arg               Write a tsv listing duplicate sample 
                                      identifiers and internal nodes with no 
                                      mutations and/or branch length 0.
  -H [ --haplotype ] arg              Write a tsv listing haplotypes 
                                      represented by comma-delimited sets of 
                                      mutations and their total frequency 
                                      across the tree.
  -R [ --calculate-roho ] arg         Write a tsv containing the distribution 
                                      of RoHO values calculated for all 
                                      homoplasic mutations.
  -A [ --get-all-basic ]              Use default filenames and save samples, 
                                      clades, mutations, and aberrant summary 
                                      tables to the output directory.
  -T [ --threads ] arg (=20)          Number of threads to use when possible 
                                      [DEFAULT uses all available cores, 20 
                                      detected on this machine]
  -E [ --expanded-roho ]              Use to include date and other contextual 
                                      information in RoHO table output. 
                                      Significantly slows calculation time.
  -h [ --help ]                       Print help messages
  -M [ --mutation-stats ]             Print counts of different kinds of 
                                      mutations
  -N [ --node-stats ] arg             Write a tsv file containing, for each 
                                      internal node, the number of descendents,
                                      the number of mutations, the mutational 
                                      density, and the number of reversion 
                                      mutations since the last annotation.
```

## usher_matUtils_extract

### Tool Description
matUtils extract: subsets the input mutation-annotated tree on various conditions and/or converts it to other formats (Newick, VCF, JSON).

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
extract options:
  -i [ --input-mat ] arg                Input mutation-annotated tree file 
                                        [REQUIRED]
  -g [ --input-gtf ] arg                Input GTF annotations file (only used 
                                        with --taxodium)
  -f [ --input-fasta ] arg              Input FASTA reference file (only used 
                                        with --taxodium)
  -s [ --samples ] arg                  Select samples by explicitly naming 
                                        them. One per line
  -M [ --metadata ] arg                 Comma-delineated paths to metadata 
                                        tsv/csvs containing categorical 
                                        metadata values for a json or taxodium 
                                        output. Used with -j and -l only
  -c [ --clade ] arg                    Select samples by membership in at 
                                        least one of the indicated clade(s), 
                                        comma delimited.
  -m [ --mutation ] arg                 Select samples by whether they contain 
                                        any of the indicated mutation(s), comma
                                        delimited.
  -H [ --match ] arg                    Select samples by whether their 
                                        identifier matches the indicated regex 
                                        pattern.
  -e [ --max-epps ] arg (=0)            Select samples by whether they have 
                                        less than the maximum indicated number 
                                        of equally parsimonious placements. 
                                        Note: calculation adds significantly to
                                        runtime.
  -a [ --max-parsimony ] arg (=-1)      Select samples by whether they have 
                                        less than the maximum indicated 
                                        parsimony score (terminal branch 
                                        length)
  -b [ --max-branch-length ] arg (=-1)  Select samples which don't have any 
                                        branches with than the indicated length
                                        in their ancestry.
  -P [ --max-path-length ] arg (=-1)    Select samples which have a total path 
                                        length (number of mutations different 
                                        from reference) less than or equal to 
                                        P.
  --max-mutation-density arg (=0)       Select samples descended from internal 
                                        nodes whose sum of descendant mutation 
                                        counts divided by number of descendants
                                        is at most arg, i.e. filter out 
                                        branches with a higher mutation 
                                        density.
  -k [ --nearest-k ] arg                Select a sample ID and the nearest k 
                                        samples to it, formatted as sample:k. 
                                        E.g. -k sample_1:50 gets sample 1 and 
                                        the nearest 50 samples to it as a 
                                        subtree.
  -K [ --nearest-k-batch ] arg          Pass a text file of sample IDs and a 
                                        number of the number of context 
                                        samples, formatted as 
                                        sample_file.txt:k.
  -z [ --set-size ] arg (=0)            Automatically add or remove samples at 
                                        random from the selected sample set 
                                        until it is the indicated size.
  -Z [ --limit-to-lca ]                 Use to limit random samples chosen with
                                        -z or -w to below the most recent 
                                        common ancestor of all other samples.
  -I [ --get-internal-descendents ] arg Select the set of samples descended 
                                        from the indicated internal node.
  -U [ --from-mrca ]                    Select all samples which are descended 
                                        from the most recent common ancestor of
                                        the indicated set of samples. Applied 
                                        before filling background with random 
                                        samples.
  -r [ --get-representative ] arg (=0)  Automatically select the indicated 
                                        number of representative samples per 
                                        clade in the tree after other selection
                                        steps and prune all other samples 
                                        (minimum 2).
  -p [ --prune ]                        Remove the selected samples instead of 
                                        keeping them in the output files.
  -R [ --resolve-polytomies ]           Resolve all polytomies by assigning 
                                        branch length 0 relationships 
                                        arbitrarily. Applied after selection; 
                                        prevents recondensing of the MAT.
  -d [ --output-directory ] arg (=./)   Write output files to the target 
                                        directory. Default is current 
                                        directory.
  -u [ --used-samples ] arg             Write a simple text file of selected 
                                        sample ids.
  -S [ --sample-paths ] arg             Write the path of mutations defining 
                                        each sample in the subtree.
  -C [ --clade-paths ] arg              Write the path of mutations defining 
                                        each clade in the subtree to the target
                                        file.
  -A [ --all-paths ] arg                Write mutations assigned to each node 
                                        in the subtree in depth-first traversal
                                        order to the target file.
  --write-diff arg                      Write MAPLE diff file representing 
                                        selected subtree. Default is full tree
  -v [ --write-vcf ] arg                Output VCF file representing selected 
                                        subtree. Default is full tree
  -n [ --no-genotypes ]                 Do not include sample genotype columns 
                                        in VCF output. Used only with the 
                                        write-vcf option
  -O [ --collapse-tree ]                Collapse the MAT before writing it to 
                                        output. Used only with the write-mat 
                                        option
  -o [ --write-mat ] arg                Write the selected tree as a new 
                                        protobuf to the target file.
  -j [ --write-json ] arg               Write the tree as a JSON to the 
                                        indicated file.
  -t [ --write-tree ] arg               Use to write a newick tree to the 
                                        indicated file.
  -l [ --write-taxodium ] arg           Write protobuf in alternate format 
                                        consumed by Taxodium.
  -G [ --x-scale ] arg (=0.200000003)   Specifies custom X-axis scaling value 
                                        for Taxodium output. Not necessary for 
                                        UShER SARS-CoV-2 trees.
  -B [ --title ] arg (=mutation_annotated_tree)
                                        Title of MAT to display in Taxodium or 
                                        Auspice (used with --write-taxodium or 
                                        -j).
  -D [ --description ] arg              Description of MAT to display in 
                                        Taxodium (used with --write-taxodium).
  -J [ --include-nt ]                   Include nucleotide mutations in 
                                        addition to protein mutations (used 
                                        with --write-taxodium)
  -F [ --extra-fields ] arg             Comma-separated list of additional 
                                        metadata column names beyond the 
                                        defaults of: strain, genbank_accession,
                                        country, date, pangolin_lineage (used 
                                        with --write-taxodium).
  -E [ --retain-branch-length ]         Use to not recalculate branch lengths 
                                        when saving newick output. Used only 
                                        with -t
  -N [ --minimum-subtrees-size ] arg (=0)
                                        Use to generate a series of JSON or 
                                        Newick format files representing 
                                        subtrees of the indicated size which 
                                        cover all queried samples. Uses and 
                                        overrides -j and -t output arguments.
  -y [ --reroot ] arg                   Indicate an internal node ID to reroot 
                                        the output tree to. Applied before all 
                                        other manipulation steps.
  -X [ --usher-single-subtree-size ] arg (=0)
                                        Use to produce an usher-style single 
                                        sample subtree of the indicated size 
                                        with all selected samples plus random 
                                        samples to fill. Produces .nh and .txt 
                                        files.
  -x [ --usher-minimum-subtrees-size ] arg (=0)
                                        Use to produce an usher-style minimum 
                                        set of subtrees of the indicated size 
                                        which include all of the selected 
                                        samples. Produces .nh and .txt files.
  --usher-clades-txt                    When producing usher-style subtree(s), 
                                        also write an usher-style clades.txt 
                                        file with clade annotations for 
                                        selected samples, if the tree has clade
                                        annotations.
  --usher-anchor-samples arg            Add samples from file to usher-style 
                                        subtree(s) (e.g. to provide 
                                        larger-scale context by including 
                                        well-known vaccine strains)
  -W [ --add-random ] arg (=0)          Add exactly W samples at random to your
                                        selection. Affected by -Z and 
                                        overridden by -z.
  -Y [ --select-nearest ] arg (=0)      Set to add to the sample selection the 
                                        y nearest samples to each of your 
                                        samples, without duplicates.
  -V [ --closest-relatives ] arg        Write a tsv file of the closest 
                                        relative(s) (in mutations) of each 
                                        selected sample to the indicated file. 
                                        All equidistant closest samples are 
                                        included unless --break-ties is set.
  -q [ --break-ties ]                   Only output one closest relative per 
                                        sample (used only with 
                                        --closest-relatives). If multiple 
                                        closest relatives are equidistant, the 
                                        lexicographically smallest sample ID is
                                        chosen.
  --within-distance arg                 Write a tsv file of the relatives 
                                        within --distance-thresold mutations of
                                        each selected sample to the indicated 
                                        file.
  --distance-threshold arg (=0)         Specifies the distance threshold used 
                                        in --within-distance.
  -Q [ --dump-metadata ] arg            Set to write all final stored metadata 
                                        to a tsv.
  -L [ --whitelist ] arg                Pass a list of samples, one per line, 
                                        to always retain regardless of any 
                                        other parameters.
  --load-all-metadata                   Use to load all input metadata from -M 
                                        regardless of sample selection. 
                                        Significantly increases memory usage.
  -T [ --threads ] arg (=20)            Number of threads to use when possible 
                                        [DEFAULT uses all available cores, 20 
                                        detected on this machine]
  -h [ --help ]                         Print help messages
```

## usher_matUtils_annotate

### Tool Description
matUtils annotate: assigns clade identities to nodes of the mutation-annotated tree, directly or by inference.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
annotate options:
  -i [ --input-mat ] arg                Input mutation-annotated tree file 
                                        [REQUIRED]
  -o [ --output-mat ] arg               Path to output processed 
                                        mutation-annotated tree file [REQUIRED]
  -c [ --clade-names ] arg              Path to a tsv file containing clade 
                                        assignments of samples. An algorithm 
                                        automatically locates and annotates 
                                        clade root nodes.  If a clade has been 
                                        found already using --clade-paths or 
                                        appears in --clade-mutations then the 
                                        clade's assignments in this file are 
                                        ignored.
  -C [ --clade-to-nid ] arg             Path to a tsv file mapping clades to 
                                        their respective internal node 
                                        identifiers.  Cannot be used in 
                                        conjunction with --clade-paths, 
                                        --clade-mutations or --clade-names.
  -P [ --clade-paths ] arg              Path to a tsv file mapping clades to 
                                        mutation paths.  A warning is printed 
                                        if a path is not found exactly as 
                                        specified.  Format is the same as the 
                                        first and third columns of the output 
                                        of matUtils extract --clade-paths.
  -M [ --clade-mutations ] arg          Path to a tsv file mapping clades to 
                                        sets of mutations (separated by spaces,
                                        commas and/or >s) which will be used 
                                        instead of extracting mutations from 
                                        samples named in the --clade-names 
                                        file.  This method is more robust to 
                                        small changes in paths, but 
                                        significantly slower than 
                                        --clade-paths.  If used together with 
                                        --clade-paths, --clade-paths takes 
                                        precedence.  If used together with 
                                        --clade-names, this takes precedence.
  -f [ --allele-frequency ] arg (=0.800000012)
                                        Minimum allele frequency in input 
                                        samples for finding the best clade 
                                        root. Used only with -c
  -m [ --mask-frequency ] arg (=0.200000003)
                                        Minimum allele frequency below -f in 
                                        input samples that should be masked for
                                        finding the best clade root. Used only 
                                        with -c
  -s [ --set-overlap ] arg (=0.600000024)
                                        Minimum fraction of the clade samples 
                                        that should be desecendants of the 
                                        assigned clade root. Used only with -c
  -p [ --clip-sample-frequency ] arg (=0.100000001)
                                        Maximum proportion of samples in a 
                                        branch that are exemplars from -c to 
                                        consider when sorting candidate clade 
                                        root nodes
  -l [ --clear-current ]                Use to remove current annotations 
                                        before applying new values.
  -d [ --output-directory ] arg (=./)   Write output files to the target 
                                        directory. Default is current 
                                        directory.
  -u [ --write-mutations ] arg          Write a tsv listing each clade and the 
                                        mutations found in at least [-f] of 
                                        samples. Used only with -c
  -D [ --write-details ] arg            Write a tsv with details about the 
                                        nodes considered for each clade root. 
                                        Used only with -c
  -T [ --threads ] arg (=20)            Number of threads to use when possible 
                                        [DEFAULT uses all available cores, 20 
                                        detected on this machine]
  -h [ --help ]                         Print help messages
```

## usher_matUtils_uncertainty

### Tool Description
matUtils uncertainty: calculates sample placement uncertainty metrics and writes the results to tsv.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
uncertainty options:
  -i [ --input-mat ] arg         Input mutation-annotated tree file [REQUIRED]
  -s [ --samples ] arg           Path to a simple text file of sample names to 
                                 calculate uncertainty for.
  -e [ --find-epps ] arg         Name for an Auspice-compatible tsv file output
                                 of equally parsimonious placements and 
                                 neighborhood sizes for input samples.
  -o [ --record-placements ] arg Name for an Auspice-compatible two-column tsv 
                                 which records potential parents for each 
                                 sample in the query set.
  -d [ --dropout-mutations ] arg Name a file to calculate and save mutations 
                                 which may be associated with primer dropout 
                                 [EXPERIMENTAL].
  -T [ --threads ] arg (=20)     Number of threads to use when possible 
                                 [DEFAULT uses all available cores, 20 detected
                                 on this machine]
  -h [ --help ]                  Print help messages
```

## usher_matUtils_introduce

### Tool Description
matUtils introduce: given sample region information, heuristically identifies points of geographic introduction along the phylogeny.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
introduce options:
  -i [ --input-mat ] arg                Input mutation-annotated tree file 
                                        [REQUIRED]
  -s [ --population-samples ] arg       Names of samples from the population of
                                        interest [REQUIRED].
  -a [ --additional-info ]              Set to calculate additional 
                                        phylogenetic trait association 
                                        statistics for whole regions and 
                                        individual introductions. WARNING: Adds
                                        significantly to runtime.
  -c [ --clade-regions ] arg            Set to optionally record, for each 
                                        clade root in the tree, the support for
                                        that clade root being IN each region in
                                        the input, as a tsv with the indicated 
                                        name.
  -M [ --date-metadata ] arg            Pass a TSV or CSV containing a 'date' 
                                        column to use for date information. If 
                                        not used, date will be inferred from 
                                        the sample name where possible.
  -o [ --full-output ] arg              Name of the file to save by-sample 
                                        introduction information to.
  -C [ --origin-confidence ] arg (=0.5) Set the threshold for recording of 
                                        putative origins of introductions. 
                                        Default is 0.5
  -E [ --evaluate-metadata ]            Set to assign each leaf a confidence 
                                        value based on ancestor distance and 
                                        confidence.
  -D [ --dump-assignments ] arg         Indicate a directory to which 
                                        two-column text files containing node 
                                        assignment values should be dumped for 
                                        downstream processing.
  -l [ --latest-date ] arg (=1500/1/1)  Use to filter to clusters which have 
                                        samples after the indicated date.
  -u [ --cluster-output ] arg           Write by-cluster summary output to the 
                                        indicated file.
  -L [ --earliest-date ] arg (=1500/1/1)
                                        Use to filter to clusters which have 
                                        ALL samples after the indicated date.
  -r [ --num-to-report ] arg (=1)       Report the top r potential origins for 
                                        any given cluster from a region in 
                                        multi-region mode. Set to 0 to report 
                                        as many as possible.
  -R [ --minimum-to-report ] arg (=0.0500000007)
                                        Set to never report origins below the 
                                        indicated confidence value. Default 
                                        0.05.
  -X [ --num-to-look ] arg (=0)         Called introduction nodes must have 
                                        this many nodes forward to root with 
                                        lower confidences. Set to higher 
                                        integers to merge nested clusters. 
                                        Default 0
  -G [ --minimum-gap ] arg (=0)         The minimum number of mutations between
                                        the last ancestor inferred to be in 
                                        region to its parent to use the 
                                        ancestor to define the cluster instead 
                                        of the parent. Set to higher values to 
                                        merge sibling clusters. Default 0.
  -T [ --threads ] arg (=20)            Number of threads to use when possible 
                                        [DEFAULT uses all available cores, 20 
                                        detected on this machine]
  -h [ --help ]                         Print help messages
```

## usher_matUtils_merge

### Tool Description
matUtils merge: merges all samples of two input mutation-annotated trees into a single output tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
merge options:
  --input-mat-1 arg            Input mutation-annotated tree file [REQUIRED]. 
                               If only this argument is set, print the count of
                               samples and nodes in the tree.
  --input-mat-2 arg            Input mutation-annotated tree file [REQUIRED]. 
                               If only this argument is set, print the count of
                               samples and nodes in the tree.
  -o [ --output-mat ] arg      Write output files to the target directory. 
                               Default is current directory.
  -d [ --max-depth ] arg (=20) Max depth to consider in the subtree rooted at 
                               the consistent node.
  -T [ --threads ] arg (=20)   Number of threads to use when possible [DEFAULT 
                               uses all available cores, 20 detected on this 
                               machine]
```

## usher_matUtils_mask

### Tool Description
matUtils mask: masks the input samples of a mutation-annotated tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
mask options:
  -i [ --input-mat ] arg             Input mutation-annotated tree file 
                                     [REQUIRED]
  -o [ --output-mat ] arg            Path to output masked mutation-annotated 
                                     tree file [REQUIRED]
  -S [ --simplify ]                  Use to automatically remove identifying 
                                     information from the tree, including all 
                                     sample names and private mutations.
  -s [ --restricted-samples ] arg    Sample names to restrict. Use to perform 
                                     masking
  -r [ --rename-samples ] arg        Name of the TSV file containing names of 
                                     the samples to be renamed and their new 
                                     names
  -m [ --mask-mutations ] arg        Name of a TSV or CSV containing mutations 
                                     to be masked in the first column and 
                                     locations to mask downstream from in the 
                                     second. If only one column is passed, all 
                                     instances of that mutation on the tree are
                                     masked.
  -c [ --condense-tree ]             Use to recondense the tree before saving.
  -D [ --max-snp-distance ] arg (=0) Maximum distance allowed between 
                                     neigboring samples that will be processed 
                                     for post-placement sample masking.
  -f [ --maple-file ] arg            Concatenated, MAPLE-formatted variant file
                                     containing phylogeny samples to be checked
                                     for post-placement sample masking. Samples
                                     not included in file will not be checked 
                                     for masking. To be used with -D flag
  -M [ --move-nodes ] arg            Name of the TSV file containing names of 
                                     the nodes to be moved and their new 
                                     parents. Use to move nodes around the tree
                                     between paths containing identical sets of
                                     mutations.
  -T [ --threads ] arg (=20)         Number of threads to use when possible 
                                     [DEFAULT uses all available cores, 20 
                                     detected on this machine]
  -h [ --help ]                      Print help messages
```

## usher_matUtils_fix

### Tool Description
matUtils fix: fixes grandparent-reversion structures in a mutation-annotated tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
fix options:
  -i [ --input-mat ] arg                Input mutation-annotated tree file 
                                        [REQUIRED]
  -o [ --output-mat ] arg               Path to output fixed mutation-annotated
                                        tree file [REQUIRED]
  -n [ --iterations ] arg (=1)          Number of iterations to run
  -c [ --min-descendent-count ] arg (=1)
                                        Minimum number of descendents required 
                                        to move a node
  -h [ --help ]                         Print help messages
```

## usher_usher-sampled

### Tool Description
usher-sampled: places new samples from a VCF onto a mutation-annotated tree (sampled order, with optimization).

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
UShER (v0.6.6)
[e64386ea004f:00001] mca_base_component_repository_open: unable to open mca_btl_openib: librdmacm.so.1: cannot open shared object file: No such file or directory (ignored)
Options:
  -v [ --vcf ] arg                      Input VCF file (in uncompressed or 
                                        gzip-compressed .gz format) [REQUIRED]
  -t [ --tree ] arg                     Input tree file
  -d [ --outdir ] arg (=.)              Output directory to dump output and log
                                        files [DEFAULT uses current directory]
  -i [ --load-mutation-annotated-tree ] arg
                                        Load mutation-annotated tree object
  -o [ --save-mutation-annotated-tree ] arg
                                        Save output mutation-annotated tree 
                                        object to the specified filename
  -s [ --sort-before-placement-1 ]      Sort new samples based on computed 
                                        parsimony score and then number of 
                                        optimal placements before the actual 
                                        placement [EXPERIMENTAL].
  -S [ --sort-before-placement-2 ]      Sort new samples based on the number of
                                        optimal placements and then the 
                                        parsimony score before the actual 
                                        placement [EXPERIMENTAL].
  -A [ --sort-before-placement-3 ]      Sort new samples based on the number of
                                        ambiguous bases [EXPERIMENTAL].
  -r [ --reverse-sort ]                 Reverse the sorting order of sorting 
                                        options (sort-before-placement-1 or 
                                        sort-before-placement-2) [EXPERIMENTAL]
  -c [ --collapse-tree ]                Collapse internal nodes of the input 
                                        tree with no mutations and condense 
                                        identical sequences in polytomies into 
                                        a single node and the save the tree to 
                                        file condensed-tree.nh in outdir
  -C [ --collapse-output-tree ]         Collapse internal nodes of the output 
                                        tree with no mutations before the 
                                        saving the tree to file final-tree.nh 
                                        in outdir
  -e [ --max-uncertainty-per-sample ] arg (=1000000)
                                        Maximum number of equally parsimonious 
                                        placements allowed per sample beyond 
                                        which the sample is ignored
  -E [ --max-parsimony-per-sample ] arg (=1000000)
                                        Maximum parsimony score of the most 
                                        parsimonious placement(s) allowed per 
                                        sample beyond which the sample is 
                                        ignored
  -u [ --write-uncondensed-final-tree ] 
                                        Write the final tree in uncondensed 
                                        format and save to file 
                                        uncondensed-final-tree.nh in outdir
  -k [ --write-subtrees-size ] arg (=0) Write minimum set of subtrees covering 
                                        the newly added samples of size equal 
                                        to this value
  -K [ --write-single-subtree ] arg (=0)
                                        Similar to write-subtrees-size but 
                                        produces a single subtree with all 
                                        newly added samples along with random 
                                        samples up to the value specified by 
                                        this argument
  --anchor-samples arg                  Add samples from file to subtree(s) 
                                        generated by --write-subtrees-size 
                                        and/or --write-single-subtree (e.g. to 
                                        provide larger-scale context by 
                                        including well-known vaccine strains)
  -M [ --multiple-placements ] arg (=1) Create a new tree up to this limit for 
                                        each possibility of parsimony-optimal 
                                        placement
  -l [ --retain-input-branch-lengths ]  Retain the branch lengths from the 
                                        input tree in out newick files instead 
                                        of using number of mutations for the 
                                        branch lengths.
  -n [ --no-add ]                       Do not add new samples to the tree
  -D [ --detailed-clades ]              In clades.txt, write a histogram of 
                                        annotated clades and counts across all 
                                        equally parsimonious placements
  --diff arg                            diff file from MAPLE, to be used with 
                                        reference sequence
  --ref arg                             reference sequence, only needed for 
                                        MAPLE
  -T [ --threads ] arg (=20)            Number of threads to use when possible 
                                        [DEFAULT uses all available cores, 20 
                                        detected on this machine]
  -B [ --reduce-back-mutation ]         Reassign states of internal nodes to 
                                        reduce back mutation count.
  --version                             Print version number
  -h [ --help ]                         Print help messages
  --optimization_radius arg (=4)        The search radius for optimization when
                                        parsimony score increase exceeds the 
                                        thresholdSet to 0 to disable 
                                        optimiationOnly newly placed samples 
                                        and nodes within this radius will be 
                                        searched
  --optimization_minutes arg (=5)       Optimization time of each iterations in
                                        minutesSet to 0 to disable 
                                        optimiationOnly newly placed samples 
                                        and nodes within this radius will be 
                                        searched
  --last_optimization_minutes arg (=120)
                                        Optimization radius for the last round
  --batch_size_per_process arg (=5)     The number of samples each process 
                                        search simultaneously
  --parsimony_threshold arg (=100000)   Optimize after the parsimony score 
                                        increase by this amount
  --first_n_samples arg (=18446744073709551615)
                                        [TESTING ONLY] Only place first n 
                                        samples
  --no-ignore-prefix arg                prefix samples already in the tree to 
                                        force placement
```

## usher_matOptimize

### Tool Description
matOptimize: optimizes a mutation-annotated tree by parsimony-improving subtree moves.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
[aa934d1347fc:00001] mca_base_component_repository_open: unable to open mca_btl_openib: librdmacm.so.1: cannot open shared object file: No such file or directory (ignored)
Running with 1 processes
matOptimize (v0.6.6)
Options:
  -v [ --vcf ] arg                      Input VCF file (in uncompressed or 
                                        gzip-compressed .gz format) 
  -t [ --tree ] arg                     Input tree file
  -T [ --threads ] arg (=20)            Number of threads to use when possible 
                                        [DEFAULT uses all available cores, 20 
                                        detected on this machine]
  -i [ --load-mutation-annotated-tree ] arg
                                        Load mutation-annotated tree object
  -o [ --save-mutation-annotated-tree ] arg
                                        Save output mutation-annotated tree 
                                        object to the specified filename 
                                        [REQUIRED]
  -E [ --epps_on_branch_len ] arg       Output a newick with number of equally 
                                        parsimonious placements on the branch 
                                        length field 
  -r [ --radius ] arg (=-1)             Radius in which to restrict the SPR 
                                        moves.
  -S [ --profitable-src-log ] arg (=/dev/null)
                                        The file to log from which node a 
                                        profitable move can be found.
  -a [ --ambi-protobuf ] arg            Continue from intermediate protobuf
  -s [ --minutes-between-save ] arg (=0)
                                        Minutes between saving intermediate 
                                        protobuf
  -m [ --min-improvement ] arg (=0.000500000024)
                                        Minimum improvement in the parsimony 
                                        score as a fraction of the previous 
                                        score in ordder to perform another 
                                        iteration.
  -d [ --drift_iteration ] arg (=0)     Iterations permiting equally 
                                        parsimonious moves after parsimony 
                                        score no longer improves
  -n [ --do-not-write-intermediate-files ] 
                                        Do not write intermediate files.
  -N [ --max-iterations ] arg (=1000)   Maximum number of optimization 
                                        iterations to perform.
  -M [ --max-hours ] arg (=0)           Maximium number of hours to run
  -V [ --transposed-vcf-path ] arg      Auxiliary transposed VCF for ambiguous 
                                        bases, used in combination with usher 
                                        protobuf (-i)
  -D [ --diff_file_path ] arg           Diff file from MAPLE, used with newick 
                                        tree (-t)
  -R [ --reference ] arg                Reference file, use with diff file (-D)
  --version                             Print version number
  -z [ --node_proportion ] arg (=2)     the proportion of nodes to search
  -y [ --node_sel ] arg                 Random seed for selecting nodes to 
                                        search
  -b [ --drift_nwk_file ] arg           Newick filename stem for drifting
  --black_list_node_file arg            Nodes that won't be moved
  -c [ --no_reduce_back_mutations ]     skip FS that reduce back mutations in 
                                        the end
  -h [ --help ]                         Print help messages
```

## usher_ripples

### Tool Description
ripples: detects recombination events in a mutation-annotated tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
optimize options:
  -i [ --input-mat ] arg                Input mutation-annotated tree file to 
                                        optimize [REQUIRED].
  -l [ --branch-length ] arg (=3)       Minimum length of the branch to 
                                        consider to recombination events
  -r [ --min-coordinate-range ] arg (=1000)
                                        Minimum range of the genomic 
                                        coordinates of the mutations on the 
                                        recombinant branch
  -R [ --max-coordinate-range ] arg (=10000000)
                                        Maximum range of the genomic 
                                        coordinates of the mutations on the 
                                        recombinant branch
  -d [ --outdir ] arg (=.)              Output directory to dump output files 
                                        [DEFAULT uses current directory]
  -s [ --samples-filename ] arg         Restrict the search to the ancestors of
                                        the samples specified in the input file
  -p [ --parsimony-improvement ] arg (=3)
                                        Minimum improvement in parsimony score 
                                        of the recombinant sequence during the 
                                        partial placement
  -n [ --num-descendants ] arg (=10)    Minimum number of leaves that node 
                                        should have to be considered for 
                                        recombination.
  -T [ --threads ] arg (=20)            Number of threads to use when possible 
                                        [DEFAULT uses all available cores, 20 
                                        detected on this machine]
  -S [ --start-index ] arg (=-1)        start index [EXPERIMENTAL]
  -E [ --end-index ] arg (=-1)          end index [EXPERIMENTAL]
  -h [ --help ]                         Print help messages
```

## usher_ripples-fast

### Tool Description
ripples-fast: faster version of ripples to detect recombination events in a mutation-annotated tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
optimize options:
  -i [ --input-mat ] arg                Input mutation-annotated tree file to 
                                        optimize [REQUIRED].
  -l [ --branch-length ] arg (=3)       Minimum length of the branch to 
                                        consider to recombination events
  -r [ --min-coordinate-range ] arg (=1000)
                                        Minimum range of the genomic 
                                        coordinates of the mutations on the 
                                        recombinant branch
  -R [ --max-coordinate-range ] arg (=10000000)
                                        Maximum range of the genomic 
                                        coordinates of the mutations on the 
                                        recombinant branch
  -d [ --outdir ] arg (=.)              Output directory to dump output files 
                                        [DEFAULT uses current directory]
  -s [ --samples-filename ] arg         Restrict the search to the ancestors of
                                        the samples specified in the input file
  -p [ --parsimony-improvement ] arg (=3)
                                        Minimum improvement in parsimony score 
                                        of the recombinant sequence during the 
                                        partial placement
  -n [ --num-descendants ] arg (=10)    Minimum number of leaves that node 
                                        should have to be considered for 
                                        recombination.
  -T [ --threads ] arg (=20)            Number of threads to use when possible 
                                        [DEFAULT uses all available cores, 20 
                                        detected on this machine]
  -S [ --start-index ] arg (=-1)        start index [EXPERIMENTAL]
  -E [ --end-index ] arg (=-1)          end index [EXPERIMENTAL]
  -h [ --help ]                         Print help messages
```

## usher_ripplesInit

### Tool Description
ripplesInit: counts the long branches (candidate recombinant nodes) of a mutation-annotated tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
optimize options:
  -i [ --input-mat ] arg            Input mutation-annotated tree file 
                                    [REQUIRED].
  -l [ --branch-length ] arg (=3)   Minimum length of the branch to consider to
                                    recombination events
  -n [ --num-descendants ] arg (=2) Minimum number of leaves that node should 
                                    have to be considered for recombination.
```

## usher_transpose_vcf

### Tool Description
transpose_vcf: converts a VCF file into the transposed VCF format used by matOptimize.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
  -v [ --vcf ] arg           Input VCF file (in uncompressed or gzip-compressed
                             .gz format) 
  -T [ --threads ] arg (=20) Number of threads to use when possible [DEFAULT 
                             uses all available cores, 20 detected on this 
                             machine]
  -o [ --output_path ] arg   Save transposed VCF
  -i [ --input_path ] arg    Input transposed VCF for renaming
  -r [ --rename_file ] arg   Input 2 column tsv for renaming
  -f [ --filter ]            remove samples not in rename file
```

## usher_transposed_vcf_to_fa

### Tool Description
transposed_vcf_to_fa: converts a transposed VCF file to a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
  -o [ --fa ] arg            Output FASTA file (in uncompressed or 
                             gzip-compressed .gz format) 
  -T [ --threads ] arg (=20) Number of threads to use when possible [DEFAULT 
                             uses all available cores, 20 detected on this 
                             machine]
  -r [ --reference ] arg     Reference file
  -s [ --samples ] arg       rename file
  -i [ --output_path ] arg   Load transposed VCF
```

## usher_transposed_vcf_to_vcf

### Tool Description
transposed_vcf_to_vcf: converts a transposed VCF file back to a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
Options:
  -v [ --vcf ] arg           Output VCF file (in uncompressed or 
                             gzip-compressed .gz format) 
  -T [ --threads ] arg (=20) Number of threads to use when possible [DEFAULT 
                             uses all available cores, 20 detected on this 
                             machine]
  -r [ --reference ] arg     Reference file
  -s [ --samples ] arg       rename file
  -i [ --output_path ] arg   Load transposed VCF
```

## usher_transposed_vcf_print_name

### Tool Description
transposed_vcf_print_name: prints the sample names stored in a transposed VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
(no help is printed by transposed_vcf_print_name; usage taken from the UShER source,
src/matOptimize/transpose_vcf/transposed_vcf_print_name.cpp)
usage:
   transposed_vcf_print_name transposed.vcf
Prints the sample names stored in a transposed VCF file (made by transpose_vcf), one per line.
```

## usher_faToVcf

### Tool Description
faToVcf: converts a FASTA alignment file to Variant Call Format (VCF) single-nucleotide diffs.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
-help is not a valid option

faToVcf - Convert a FASTA alignment file to Variant Call Format (VCF) single-nucleotide diffs
usage:
   faToVcf in.fa out.vcf
options:
   -ambiguousToN         Treat all IUPAC ambiguous bases (N, R, V etc) as N (no call).
   -excludeFile=file     Exclude sequences named in file which has one sequence name per line
   -includeNoAltN        Include base positions with no alternate alleles observed, but at
                         least one N (missing base / no-call)
   -includeRef           Include the reference in the genotype columns
                         (default: omitted as redundant)
   -maskSites=file       Exclude variants in positions recommended for masking in file
                         (typically https://github.com/W-L/ProblematicSites_SARS-CoV2/raw/master/problematic_sites_sarsCov2.vcf)
   -maxDiff=N            Exclude sequences with more than N mismatches with the reference
                         (if -windowSize is used, sequences are masked accordingly first)
   -minAc=N              Ignore alternate alleles observed fewer than N times
   -minAf=F              Ignore alternate alleles observed in less than F of non-N bases
   -minAmbigInWindow=N   When -windowSize is provided, mask any base for which there are at
                         least this many N, ambiguous or gap characters within the window.
                         (default: 2)
   -noGenotypes          Output 8-column VCF, without the sample genotype columns
   -ref=seqName          Use seqName as the reference sequence; must be present in faFile
                         (default: first sequence in faFile)
   -resolveAmbiguous     For IUPAC ambiguous characters like R (A or G), if the character
                         represents two bases and one is the reference base, convert it to the
                         non-reference base.  Otherwise convert it to N.
   -startOffset=N        Add N bases to each position (for trimmed alignments)
   -vcfChrom=seqName     Use seqName for the CHROM column in VCF (default: ref sequence)
   -windowSize=N         Mask any base for which there are at least -minAmbigWindow bases in a
                         window of +-N bases around the base.  Masking approach adapted from
                         https://github.com/roblanf/sarscov2phylo/ file scripts/mask_seq.py
                         Use -windowSize=7 for same results.
in.fa must contain a series of sequences with different names and the same length.
Both N and - are treated as missing information.
```

## usher_compareVCF

### Tool Description
compareVCF: compares the genotypes of the samples in two VCF files and reports differences.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
(no help is printed by compareVCF; usage taken from the UShER source, src/compareVCF.cpp)
usage:
   compareVCF file1.vcf[.gz] file2.vcf[.gz]
Compares the genotypes of the samples present in both VCF files (uncompressed or gzip-compressed).
Differences are written to standard error ("At <position> , sample <name> , <allele> in file ..."),
samples missing in the second file are written to standard output.
```

## usher_check_samples_place

### Tool Description
check_samples_place: checks that samples are placed with the same mutations in a new mutation-annotated tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
- **Homepage**: https://github.com/yatisht/usher
- **Package**: https://anaconda.org/channels/bioconda/packages/usher/overview
- **Validation**: PASS

### Original Help Text
```text
(no help is printed by check_samples_place; usage taken from the UShER source, src/check_samples_place/main.cpp)
usage:
   check_samples_place original_tree.pb samples.vcf new_tree.pb [ignore_missing]
Checks that every sample of original_tree.pb (with the genotypes in samples.vcf) is placed in
new_tree.pb with the same mutations. Problems are written to standard error. Any fourth argument
makes missing samples be ignored.
```

