# usher CWL Generation Report

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

