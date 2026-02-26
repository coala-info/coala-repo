# mapgl CWL Generation Report

## mapgl_mapGL.py

### Tool Description
Label input regions as orthologous, gained in the query species, or lost in the target species. Chain alignment files are used to map features from query to target and one or more outgroup species. Features that map directly from query to target are labeled as orthologs, and ortholgous coordinates in the target species are given in the output. Non-mapping features are assigned as gains or losses based on a maximum-parsimony algorithm predicting presence/absence in the most-recent common ancestor. Based on bnMapper.py, by Ogert Denas (James Taylor lab) (https://github.com/bxlab/bx-python/blob/master/scripts/bnMapper.py)

### Metadata
- **Docker Image**: quay.io/biocontainers/mapgl:1.3.1--pyh5ca1d4c_0
- **Homepage**: https://github.com/adadiehl/mapGL
- **Package**: https://anaconda.org/channels/bioconda/packages/mapgl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mapgl/overview
- **Total Downloads**: 17.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/adadiehl/mapGL
- **Stars**: N/A
### Original Help Text
```text
usage: mapGL.py [-h] [-o FILE] [-t FLOAT] [-g GAP] [-v {info,debug,silent}]
                [-d] [-i {BED,narrowPeak}] [-f] [-n] [-p {gain,loss}]
                input tree qname tname alignments [alignments ...]

Label input regions as orthologous, gained in the query species, or lost in
the target species. Chain alignment files are used to map features from query
to target and one or more outgroup species. Features that map directly from
query to target are labeled as orthologs, and ortholgous coordinates in the
target species are given in the output. Non-mapping features are assigned as
gains or losses based on a maximum-parsimony algorithm predicting
presence/absence in the most-recent common ancestor. Based on bnMapper.py, by
Ogert Denas (James Taylor lab) (https://github.com/bxlab/bx-
python/blob/master/scripts/bnMapper.py)

positional arguments:
  input                 Input regions to process. Should be in standard bed
                        format. Only the first four bed fields will be used.
  tree                  Tree, in standard Newick format, with or without
                        branch lengths, describing relationships of query and
                        target species to outgroups. May be given as a string
                        or file.
  qname                 Name of the query species. Regions from this species
                        will be mapped to target species coordinates.
  tname                 Name of the target species. Regions from the query
                        species will be mapped to coordinates from this
                        species.
  alignments            Alignment files (.chain or .pkl): One for the target
                        species and one per outgroup species. Files should be
                        named according to the convention:
                        qname.tname[...].chain.gz, where qname is the query
                        species name and tname is the name of the
                        target/outgroup species. Names used for qname and
                        tname must match names used in the newick tree.

optional arguments:
  -h, --help            show this help message and exit
  -o FILE, --output FILE
                        Output file. Default stdout. (default: stdout)
  -t FLOAT, --threshold FLOAT
                        Mapping threshold i.e., |elem| * threshold <=
                        |mapped_elem|. Default = 0.0 -- equivalent to
                        accepting a single-base overlap. On the other end of
                        the spectrum, setting this value to 1 is equivalent to
                        only accepting full-length overlaps. (default: 0.0)
  -g GAP, --gap GAP     Ignore elements with an insertion/deletion of this or
                        bigger size. Using the default value (-1) will allow
                        gaps of any size. (default: -1)
  -v {info,debug,silent}, --verbose {info,debug,silent}
                        Verbosity level (default: info)
  -d, --drop_split      If elements span multiple chains, report them as non-
                        mapping. These will then be reported as gains or
                        losses, according to the maximum-parsimony
                        predictions. This is the default mapping behavior for
                        bnMapper. By default, mapGL.pys will follow the
                        mapping convention used by liftOver, whereas the
                        longest mapped alignment is reported for split
                        elements. (default: False)
  -i {BED,narrowPeak}, --in_format {BED,narrowPeak}
                        Input file format. (Default: BED) (default: BED)
  -f, --full_labels     Attempt to predict gain/loss events on all branches of
                        the tree, not just query/target branches. Output will
                        include a comma-delimited list of gain/loss events
                        from any/all affected branches. (default: False)
  -n, --no_prune        Do not attempt to disambiguate the root state to
                        resolve ambiguous gain/loss predictions. Instead,
                        label affected features as 'ambiguous'. (default:
                        False)
  -p {gain,loss}, --priority {gain,loss}
                        When resolving ambiguous trees, prioritize sequence
                        gain or sequence loss. This can be thought of as
                        assigning a lower cost to sequence insertions relative
                        to deletions, or vice-versa. When priority='gain',
                        ambiguity is resolved by assigning 0 state to the root
                        node, such that sequence presence on a descendant
                        branch will be interpreted as a gain. When
                        priority='loss', ambiguity is resolved by asssigning
                        state 1 to the root node, such that sequence absence
                        in a descendant node is interpreted as a sequence
                        loss. Default=gain (default: gain)

Adam Diehl (Boyle Lab)
```

