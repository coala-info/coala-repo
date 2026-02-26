# treeshrink CWL Generation Report

## treeshrink_run_treeshrink.py

### Tool Description
TreeShrink is a tool for inferring gene trees that are consistent with a species tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/treeshrink:1.3.9--pyhdfd78af_1
- **Homepage**: https://github.com/uym2/TreeShrink
- **Package**: https://anaconda.org/channels/bioconda/packages/treeshrink/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/treeshrink/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-06-07
- **GitHub**: https://github.com/uym2/TreeShrink
- **Stars**: N/A
### Original Help Text
```text
usage: run_treeshrink.py [-h] [-i INDIR] [-t TREE] [-g G2SP] [-a ALIGNMENT]
                         [-c] [-k K] [-s KSCALING] [-q QUANTILES]
                         [-b MINIMPACT] [-m MODE] [-o OUTDIR] [-O OUTPREFIX]
                         [-f] [-p TEMPDIR] [-v] [-x EXCEPTIONS]

options:
  -h, --help            show this help message and exit
  -i, --indir INDIR     The parent input directory where the trees (and
                        alignments) can be found
  -t, --tree TREE       The name of the input tree/trees. If the input
                        directory is specified (see -i option), each
                        subdirectory under it must contain a tree with this
                        name. Otherwise, all the trees can be included in this
                        one file. Default: input.tree
  -g, --g2sp G2SP       The gene-name-to-species-name mapping file
  -a, --alignment ALIGNMENT
                        The name of the input alignment; can only be used when
                        the input directory is specified (see -i option). Each
                        subdirectory under it must contain an alignment with
                        this name. Default: input.fasta
  -c, --centroid        Do centroid reroot in preprocessing. Highly
                        recommended for large trees. Default: NO
  -k, --k K             The maximum number of leaves that can be removed.
                        Default: auto-select based on the data; see also -s
  -s, --kscaling KSCALING
                        If -k not given, we use k=min(n/a,b*sqrt(n)) by
                        default; using this option, you can set the a,b
                        constants; Default: '5,2'
  -q, --quantiles QUANTILES
                        The quantile(s) to set threshold. Default is 0.05
  -b, --minImpact MINIMPACT
                        Do not remove species on the per-species test if their
                        impact on diameter is less than x% where x is the
                        given value. Default: 5
  -m, --mode MODE       Filtering mode: 'per-species', 'per-gene', 'all-
                        genes','auto'. Default: auto
  -o, --outdir OUTDIR   Output directory. Default: If the input directory is
                        specified, outputs will be placed in that input
                        directory. Otherwise, a directory with the suffix
                        'treeshrink' will be created in the same place as the
                        input trees
  -O, --outprefix OUTPREFIX
                        Output name prefix. If the output directory contains
                        some files with the specified prefix, automatically
                        adjusts the prefix (e.g. output --> output1) to avoid
                        overriding. Use --force to force overriding. Default:
                        'output'
  -f, --force           Force overriding of existing output files.
  -p, --tempdir TEMPDIR
                        Directory to keep temporary files. If specified, the
                        temp files will be kept
  -v, --version         Show TreeShrink version.
  -x, --exceptions EXCEPTIONS
                        A list of special species that will not be removed in
                        any of the input trees.
```

