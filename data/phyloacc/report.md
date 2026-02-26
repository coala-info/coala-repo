# phyloacc CWL Generation Report

## phyloacc

### Tool Description
Bayesian rate analysis of conserved non-coding genomic elements

### Metadata
- **Docker Image**: quay.io/biocontainers/phyloacc:2.4.5--py313h4c9e609_1
- **Homepage**: https://github.com/phyloacc/PhyloAcc
- **Package**: https://anaconda.org/channels/bioconda/packages/phyloacc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phyloacc/overview
- **Total Downloads**: 36.6K
- **Last updated**: 2026-02-26
- **GitHub**: https://github.com/phyloacc/PhyloAcc
- **Stars**: N/A
### Original Help Text
```text
usage: phyloacc [-h] [--config CONFIG_FILE] [-a ALN_FILE] [-b BED_FILE]
                [-i ID_FILE] [-d ALN_DIR] [--softmask] [-m MOD_FILE]
                [-o OUT_DIR] [--filter] [-t TARGETS] [-c CONSERVED]
                [-g OUTGROUP] [-burnin BURNIN] [-mcmc MCMC] [-thin THIN]
                [-chain CHAIN] [-phyloacc PHYLOACC_OPTS]
                [-st-path PHYLOACC_ST_PATH] [-gt-path PHYLOACC_GT_PATH]
                [-iqtree-path IQTREE_PATH] [-coal-path COAL_CMD]
                [-scf SCF_BRANCH_CUTOFF] [-s SCF_PROP] [-l COAL_TREE]
                [-r RUN_MODE] [-n NUM_PROCS] [-p PROCS_PER_BATCH]
                [-j NUM_JOBS] [-batch BATCH_SIZE] [-part CLUSTER_PART]
                [-nodes CLUSTER_NODES] [-mem CLUSTER_MEM] [-time CLUSTER_TIME]
                [--local] [--dollo] [--theta] [--labeltree] [--overwrite]
                [--appendlog] [--testcmd] [--summarize] [--options] [--info]
                [--depcheck] [--version] [--quiet]

PhyloAcc: Bayesian rate analysis of conserved non-coding genomic elements

options:
  -h, --help            show this help message and exit
  --config CONFIG_FILE  A YAML formatted file with the arguments for the
                        program to be used in lieu of command line arguments.
  -a ALN_FILE           An alignment file in FASTA format with all loci
                        concatenated. -b must also be specified. Expected as
                        FASTA format for now. One of -a/-b or -d is REQUIRED.
  -b BED_FILE           A bed file with coordinates for the loci in the
                        concatenated alignment file. -a must also be
                        specified. One of -a/-b or -d is REQUIRED.
  -i ID_FILE            A text file with locus names, one per line,
                        corresponding to regions in the input bed file. -a and
                        -b must also be specified.
  -d ALN_DIR            A directory containing individual alignment files for
                        each locus in FASTA format. One of -a/-b or -d is
                        REQUIRED.
  --softmask            Treat lowercase bases in alignments as masked
                        (converted to N) before processing.
  -m MOD_FILE           A file with a background transition rate matrix and
                        phylogenetic tree with branch lengths as output from
                        phyloFit. REQUIRED.
  -o OUT_DIR            Desired output directory. This will be created for you
                        if it doesn't exist. Default: phyloacc-[date]-[time]
  --filter              Set this flag to filter out loci with no informative
                        sites before running PhyloAcc.
  -t TARGETS            Tip labels in the input tree to be used as target
                        species. Enter multiple labels separated by semi-
                        colons (;). REQUIRED.
  -c CONSERVED          Tip labels in the input tree to be set as non-target
                        species. Enter multiple labels separated by semi-
                        colons (;). Any species not specified in -t or -g will
                        be placed in this category.
  -g OUTGROUP           Tip labels in the input tree to be used as outgroup
                        species. Enter multiple labels separated by semi-
                        colons (;).
  -burnin BURNIN        The number of steps to be discarded in the Markov
                        chain as burnin. Default: 500
  -mcmc MCMC            The total number of steps in the Markov chain.
                        Default: 1000
  -thin THIN            For the gene tree model, the number of MCMC steps
                        between gene tree sampling. The total number of MCMC
                        steps specified with -mcmc will be scaled by this as
                        mcmc*thin Default: 1
  -chain CHAIN          The number of chains. Default: 1
  -phyloacc PHYLOACC_OPTS
                        A catch-all option for other PhyloAcc parameters.
                        Enter as a semi-colon delimited list of options: 'OPT1
                        value;OPT2 value'
  -st-path PHYLOACC_ST_PATH
                        The path to the PhyloAcc-ST binary. Default: PhyloAcc-
                        ST
  -gt-path PHYLOACC_GT_PATH
                        The path to the PhyloAcc-GT binary. Default: PhyloAcc-
                        GT
  -iqtree-path IQTREE_PATH
                        The path to the IQ-Tree executable for making gene
                        trees with --theta. Default: iqtree
  -coal-path COAL_CMD   The path to the program to estimate branch lengths in
                        coalescent units with --theta (Supported programs:
                        ASTRAL). Default: java -jar astral.jar
  -scf SCF_BRANCH_CUTOFF
                        The value of sCF to consider as 'low' for any given
                        branch in a locus. Default: 0.5
  -s SCF_PROP           The proportion of branches to consider a locus for the
                        gene tree model. Default: 0.3333, meaning if one-third
                        of all branches for a given locus have low sCF, this
                        locus will be run with the gene tree model.
  -l COAL_TREE          A file containing a rooted, Newick formatted tree with
                        the same topology as the species tree in the mod file
                        (-m), but with branch lengths in coalescent units.
                        When the gene tree model is used, one of -l or --theta
                        must be set.
  -r RUN_MODE           Determines which version of PhyloAcc will be used. gt:
                        use the gene tree model for all loci, st: use the
                        species tree model for all loci, adaptive: use the
                        gene tree model on loci with many branches with low
                        sCF and species tree model on all other loci. Default:
                        st
  -n NUM_PROCS          The number of processes that this script should use.
                        Default: 1.
  -p PROCS_PER_BATCH    The number of processes to use for each batch of
                        PhyloAcc. Default: 1.
  -j NUM_JOBS           The number of jobs (batches) to run in parallel. Must
                        be less than or equal to the total processes for
                        PhyloAcc (-p). Default: 1.
  -batch BATCH_SIZE     The number of loci to run per batch. Default: 50
  -part CLUSTER_PART    The partition or list of partitions (separated by
                        commas) on which to run PhyloAcc jobs.
  -nodes CLUSTER_NODES  The number of nodes on the specified partition to
                        submit jobs to. Default: 1.
  -mem CLUSTER_MEM      The max memory for each job in MB. Default: 4.
  -time CLUSTER_TIME    The time in minutes to give each job. Default: 1.
  --local               Set to generate a local snakemake command to run the
                        pipeline instead of the cluster profile and command.
                        ONLY recommended for testing purposes.
  --dollo               Set this to use the Dollo assumption in the original
                        model (lineages descendant from an accelerated branch
                        cannot change state).
  --theta               Set this to add gene tree estimation with IQ-tree and
                        species estimation with ASTRAL for estimation of the
                        theta prior. Note that a species tree with branch
                        lengths in units of substitutions per site is still
                        required with -m. Also note that this may add
                        substantial runtime to the pipeline.
  --labeltree           Reads the tree from the input mod file (-m), labels
                        the internal nodes, and exits.
  --overwrite           Set this to overwrite existing files.
  --appendlog           Set this to keep the old log file even if --overwrite
                        is specified. New log information will instead be
                        appended to the previous log file.
  --testcmd             At the end of the program, print out an example
                        command to run a PhyloAcc batch directly.
  --summarize           Only generate the input summary plots and page. Do not
                        write or overwrite batch job files.
  --options             Print the full list of PhyloAcc options that can be
                        specified with -phyloacc and exit.
  --info                Print some meta information about the program and
                        exit. No other options required.
  --depcheck            Run this to check that all dependencies are installed
                        at the provided path. No other options necessary.
  --version, -version, --v, -v
                        Simply print the version and exit. Can also be called
                        as '-version', '-v', or '--v'.
  --quiet               Set this flag to prevent PhyloAcc from reporting
                        detailed information about each step.
```

