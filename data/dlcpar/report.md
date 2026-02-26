# dlcpar CWL Generation Report

## dlcpar

### Tool Description
dlcpar is a phylogenetic program for finding the most parsimonious gene tree-species tree reconciliation by inferring speciation, duplication, loss, and deep coalescence events. See http://compbio.mit.edu/dlcpar for details.

### Metadata
- **Docker Image**: quay.io/biocontainers/dlcpar:1.0--py27_0
- **Homepage**: https://github.com/wutron/dlcpar
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dlcpar/overview
- **Total Downloads**: 9.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wutron/dlcpar
- **Stars**: N/A
### Original Help Text
```text
Usage: dlcpar [options] <gene tree> ...

dlcpar is a phylogenetic program for finding the most parsimonious gene tree-
species tree reconciliation by inferring speciation, duplication, loss, and
deep coalescence events. See http://compbio.mit.edu/dlcpar for details.

Options:
  Input/Output:
    -s <species tree>, --stree=<species tree>
                        species tree file in newick format
    -S <species map>, --smap=<species map>
                        gene to species map
    --lmap=<locus map>  gene to locus map (species-specific)
    -n <number of reconciliations>, --nsamples=<number of reconciliations>
                        number of uniform samples (default: 1)

  File Extensions:
    -I <input file extension>, --inputext=<input file extension>
                        input file extension (default: "")
    -O <output file extension>, --outputext=<output file extension>
                        output file extension (default: ".dlcpar")

  Costs:
    -D <dup cost>, --dupcost=<dup cost>
                        duplication cost (default: 1.0)
    -L <loss cost>, --losscost=<loss cost>
                        loss cost (default: 1.0)
    -C <coal cost>, --coalcost=<coal cost>
                        deep coalescence cost (default: 0.5)

  Heuristics:
    --no_prescreen      set to disable prescreen of locus maps
    --prescreen_min=<prescreen min>
                        prescreen locus maps if min (forward) cost exceeds
                        this value (default: 50)
    --prescreen_factor=<prescreen factor>
                        prescreen locus maps if (forward) cost exceeds this
                        factor * min (forward) cost (default: 10)
    --max_loci=<max # of loci>
                        maximum # of co-existing loci (in each ancestral
                        species), set to -1 for no limit (default: -1)
    --max_dups=<max # of dups>
                        maximum # of duplications (in each ancestral species),
                        set to -1 for no limit (default: 4)
    --max_losses=<max # of losses>
                        maximum # of losses (in each ancestral species), set
                        to -1 for no limit (default: 4)
    --allow_both        set to allow duplications on both children

  Miscellaneous:
    -x <random seed>, --seed=<random seed>
                        random number seed
    --output_format=[dlcpar|dlcoal]
                        specify output format (default: dlcpar)

  Information:
    --version           show program's version number and exit
    -h, --help          show this help message and exit
    -l, --log           if given, output debugging log

Written by Yi-Chieh Wu (yjw@mit.edu), Massachusetts Institute of Technology.
(c) 2012. Released under the terms of the GNU General Public License.
```

