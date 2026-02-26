# magus-msa CWL Generation Report

## magus-msa_magus

### Tool Description
MAGUS is a tool for multiple sequence alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/magus-msa:0.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/vlasmirnov/MAGUS
- **Package**: https://anaconda.org/channels/bioconda/packages/magus-msa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/magus-msa/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vlasmirnov/MAGUS
- **Stars**: N/A
### Original Help Text
```text
usage: magus [-h] [-d DIRECTORY] [-i SEQUENCES]
             [-s SUBALIGNMENTS [SUBALIGNMENTS ...]]
             [-b BACKBONES [BACKBONES ...]] -o OUTPUT [-t GUIDETREE]
             [-np NUMPROCS] [--maxsubsetsize MAXSUBSETSIZE]
             [--maxnumsubsets MAXNUMSUBSETS] [--decompstrategy DECOMPSTRATEGY]
             [--decompskeletonsize DECOMPSKELETONSIZE] [--datatype DATATYPE]
             [--graphbuildmethod GRAPHBUILDMETHOD]
             [--graphbuildrestrict GRAPHBUILDRESTRICT]
             [--graphbuildhmmextend GRAPHBUILDHMMEXTEND]
             [--graphclustermethod GRAPHCLUSTERMETHOD]
             [--graphtracemethod GRAPHTRACEMETHOD]
             [--graphtraceoptimize GRAPHTRACEOPTIMIZE] [-r MAFFTRUNS]
             [-m MAFFTSIZE] [-f INFLATIONFACTOR] [-c CONSTRAIN]
             [--onlyguidetree ONLYGUIDETREE] [--recurse RECURSE]
             [--recurseguidetree RECURSEGUIDETREE]
             [--recursethreshold RECURSETHRESHOLD]
             [--alignsizelimit ALIGNSIZELIMIT] [--overwrite] [--version]

options:
  -h, --help            show this help message and exit
  -d DIRECTORY, --directory DIRECTORY
                        Path to working directory
  -i SEQUENCES, --sequences SEQUENCES
                        Path to input unaligned sequences
  -s SUBALIGNMENTS [SUBALIGNMENTS ...], --subalignments SUBALIGNMENTS [SUBALIGNMENTS ...]
                        Paths to input subalignment files
  -b BACKBONES [BACKBONES ...], --backbones BACKBONES [BACKBONES ...]
                        Paths to input backbone alignment files
  -o OUTPUT, --output OUTPUT
                        Output alignment path. Will be set to /dev/stdout if
                        '-' is passed.
  -t GUIDETREE, --guidetree GUIDETREE
                        Guide tree for subset decomposition. fasttree
                        (default), fasttree-noml, clustal, parttree, or path
                        to user guide tree
  -np NUMPROCS, --numprocs NUMPROCS
                        Number of processors to use (default: # cpus
                        available)
  --maxsubsetsize MAXSUBSETSIZE
                        Maximum subset size for divide-and-conquer
  --maxnumsubsets MAXNUMSUBSETS
                        Maximum number of subsets for divide-and-conquer
  --decompstrategy DECOMPSTRATEGY
                        Initial decomposition strategy (pastastyle or kmh)
  --decompskeletonsize DECOMPSKELETONSIZE
                        Number of skeleton sequences for the initial
                        decomposition strategy
  --datatype DATATYPE   Data type (dna, rna, or protein). Will be inferred if
                        not provided
  --graphbuildmethod GRAPHBUILDMETHOD
                        Method for building the alignment graph (mafft,
                        mafftmerge, or initial)
  --graphbuildrestrict GRAPHBUILDRESTRICT
                        Prevent the alignment graph from adding edges that
                        violate subalignments (true or false)
  --graphbuildhmmextend GRAPHBUILDHMMEXTEND
                        Extend the alignment graph MAFFT backbones with hmmer
                        (true or false)
  --graphclustermethod GRAPHCLUSTERMETHOD
                        Method for initial clustering of the alignment graph
                        (mcl or none)
  --graphtracemethod GRAPHTRACEMETHOD
                        Method for finding a trace from the alignment graph
                        (minclusters, fm, mwtgreedy, or mwtsearch)
  --graphtraceoptimize GRAPHTRACEOPTIMIZE
                        Run an optimization step on the graph trace (true or
                        false)
  -r MAFFTRUNS, --mafftruns MAFFTRUNS
                        Number of MAFFT runs
  -m MAFFTSIZE, --mafftsize MAFFTSIZE
                        Maximum size of MAFFT alignments
  -f INFLATIONFACTOR, --inflationfactor INFLATIONFACTOR
                        MCL inflation factor
  -c CONSTRAIN, --constrain CONSTRAIN
                        Constrain MAGUS to respect subalignments (true or
                        false)
  --onlyguidetree ONLYGUIDETREE
                        Only output the guide tree (true or false)
  --recurse RECURSE     Allow MAGUS to recurse on large subsets (true or
                        false)
  --recurseguidetree RECURSEGUIDETREE
                        If recursing, passes this argument as the guide tree
                        option to the lower levels. (Default fasttree)
  --recursethreshold RECURSETHRESHOLD
                        MAGUS will recursively align subsets above this
                        threshold size
  --alignsizelimit ALIGNSIZELIMIT
                        Size threshold for alignment compression (in GB)
  --overwrite           Force overwriting of output files, even if they
                        already exist. Default off.
  --version             show program's version number and exit
```

