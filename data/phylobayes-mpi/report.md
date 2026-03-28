# phylobayes-mpi CWL Generation Report

## phylobayes-mpi_pb_mpi

### Tool Description
creates a new chain, sampling from the posterior distribution, conditional on specified data

### Metadata
- **Docker Image**: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
- **Homepage**: https://github.com/bayesiancook/pbmpi
- **Package**: https://anaconda.org/channels/bioconda/packages/phylobayes-mpi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phylobayes-mpi/overview
- **Total Downloads**: 12.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bayesiancook/pbmpi
- **Stars**: N/A
### Original Help Text
```text
mpirun -np <np> pb_mpi -d <datafile> [options] <chainname>
	creates a new chain, sampling from the posterior distribution, conditional on specified data

mpirun -np <np> pb_mpi <chainname>
	starts an already existing chain

	mpirun -np <np>     : number of parallel processes (should be at least 2)

	-cat -dp            : infinite mixture (Dirichlet process) of equilibirium frequency profiles
	-ncat <ncat>        : finite mixture of equilibirium frequency profiles
	-catfix <pr>        : specifying a fixed pre-defined mixture of profiles

	-lg                 : Le and Gascuel 2008
	-wag                : Whelan and Goldman 2001
	-jtt                : Jones, Taylor, Thornton 1992
	-gtr                : general time reversible
	-poisson            : Poisson matrix, all relative exchangeabilities equal to 1 (Felsenstein 1981)

	-dgam <ncat>        : discrete gamma. ncat = number of categories (4 by default, 1 = uniform rates model)

	-dc                 : excludes constant columns
	-t <treefile>       : starts from specified tree
	-T <treefile>       : chain run under fixed, specified tree

	-x <every> <until>  : saving frequency, and chain length (until = -1 : forever)
	-f                  : forcing checks
	-s/-S               : -s : save all / -S : save only the trees


see manual for details
```


## phylobayes-mpi_tracecomp

### Tool Description
measure the effective sizes and overlap between 95% CI of several independent chains

### Metadata
- **Docker Image**: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
- **Homepage**: https://github.com/bayesiancook/pbmpi
- **Package**: https://anaconda.org/channels/bioconda/packages/phylobayes-mpi/overview
- **Validation**: PASS

### Original Help Text
```text
tracecomp [-ox] ChainName1 ChainName2 ... 
	-o <output> : detailed output into file
	-x <burnin> [<every> <until>]. default burnin = 20% of the chain

	 measure the effective sizes and overlap between 95% CI of several independent chains
```


## phylobayes-mpi_bpcomp

### Tool Description
compare bipartition frequencies between independent chains and build consensus based on merged lists of trees

### Metadata
- **Docker Image**: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
- **Homepage**: https://github.com/bayesiancook/pbmpi
- **Package**: https://anaconda.org/channels/bioconda/packages/phylobayes-mpi/overview
- **Validation**: PASS

### Original Help Text
```text
bpcomp [-cox] ChainName1 ChainName2 ... 
	-c <cutoff> : only partitions with max prob >  cutoff. (default 0.5)
	-o <output> : detailed output into file
	-ps         : postscript output (requires LateX)
	-x <burnin> [<every> <until>]. default burnin = 1/10 of the chain

	 compare bipartition frequencies between independent chains
	 and build consensus based on merged lists of trees
```


## Metadata
- **Skill**: generated
