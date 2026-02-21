# phylopypruner CWL Generation Report

## phylopypruner

### Tool Description
A tree-based orthology inference program with additional functionality for reducing contamination.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylopypruner:1.2.6--pyhdfd78af_0
- **Homepage**: https://github.com/fethalen/phylopypruner
- **Package**: https://anaconda.org/channels/bioconda/packages/phylopypruner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phylopypruner/overview
- **Total Downloads**: 280
- **Last updated**: 2025-05-29
- **GitHub**: https://github.com/fethalen/phylopypruner
- **Stars**: N/A
### Original Help Text
```text
usage: phylopypruner [-h] [-v] [--overwrite] [--wrap <number>]
                     [--threads <number>] [--output <directory>]
                     [--dir <directory>] [--exclude OTU [OTU ...]]
                     [--min-len <number>] [--trim-lb <factor>]
                     [--min-pdist <distance>] [--min-support <percentage>]
                     [--mask {longest,pdist}] [--trim-divergent <percentage>]
                     [--trim-freq-paralogs <factor>] [--include OTU [OTU ...]]
                     [--outgroup OTU [OTU ...]] [--root {midpoint}]
                     [--prune {LS,MI,MO,RT,1to1,OTO}]
                     [--force-inclusion OTU [OTU ...]] [--min-taxa <number>]
                     [--min-otu-occupancy <percentage>]
                     [--min-gene-occupancy <percentage>] [--subclades FILE]
                     [--jackknife] [--no-plot] [--no-supermatrix]

A tree-based orthology inference program with additional functionality for
reducing contamination. See gitlab.com/fethalen/phylopypruner for details.

options:
  -h, --help            show this help message and exit
  -v, -V, --version     display the version number and exit
  --overwrite           overwrite pre-existing output files without asking
  --wrap <number>       wrap output sequences at column <number>, instead of
                        writing each sequence to a single line
  --threads <number>    use <number> threads instead of up to 10 threads
  --output <directory>  save output files to <directory>, instead of the input
                        directory
  --no-plot             do not generate any plots (faster)
  --no-supermatrix      do not concatenate output into a supermatrix (faster)

input data:
  --dir <directory>     a <directory> containing 1+ alignment and tree files

prefilters:
  --exclude OTU [OTU ...]
                        exclude these OTUs
  --min-len <number>    remove sequences which are shorter than <number> bases
  --trim-lb <factor>    remove branches longer than <factor> standard
                        deviations of all branches
  --min-pdist <distance>
                        remove sequence pairs with less tip-to-tip distance
                        than <distance>
  --min-support <percentage>
                        collapse nodes with less support than <percentage>
                        into polytomies
  --mask {longest,pdist}
                        if 2+ sequences from a single OTU forms a clade,
                        choose which sequence to keep using this method
  --trim-divergent <percentage>
                        for each alignment: discard all sequences from an OTU
                        on a per-alignment-basis, if the ratio between the
                        largest pairwise distance of sequences from this OTU
                        and the average pairwise distance of sequences from
                        this OTU to other's exceed this <percentage>
  --trim-freq-paralogs <factor>
                        exclude OTUs with more paralogy frequency (PF) than
                        <factor> standard deviations of all PFs
  --include OTU [OTU ...]
                        include these OTUs, even if deemed problematic by '--
                        trim-freq-paralogs' or '--trim-divergent'

rooting:
  --outgroup OTU [OTU ...]
                        root trees using these OTUs if at least one OTU is
                        present and if all present OTUs are non-repetetive and
                        form a clade
  --root {midpoint}     root trees using this method when outgroup rooting was
                        not performed

paralogy pruning:
  --prune {LS,MI,MO,RT,1to1,OTO}
                        select the paralogy pruning method (default: LS)

postfilters:
  --force-inclusion OTU [OTU ...]
                        discard output alignments where these OTUs are missing
  --min-taxa <number>   discard output alignments with fewer OTUs than
                        <number> (4 by default)
  --min-otu-occupancy <percentage>
                        do not include OTUs with less occupancy than
                        <percentage>
  --min-gene-occupancy <percentage>
                        discard output alignments with less occupancy than
                        <percentage>

post-processing:
  --subclades FILE      specify a set of subclades within this file and
                        analyse their overall stability
  --jackknife           exclude each OTU one by one, rerun the whole analysis
                        and generate statistics for each subsample
```


## Metadata
- **Skill**: generated
