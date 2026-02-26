# clonalorigin CWL Generation Report

## clonalorigin

### Tool Description
Perform inference of recombination in bacteria using the ClonalOrigin model.

### Metadata
- **Docker Image**: biocontainers/clonalorigin:v1.0-3-deb_cv1
- **Homepage**: https://github.com/xavierdidelot/ClonalOrigin
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clonalorigin/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/xavierdidelot/ClonalOrigin
- **Stars**: N/A
### Original Help Text
```text
Got seed 15530805562825629121 from /dev/random
Wrong number of arguments.
    Usage: weakarg [OPTIONS] treefile datafile outputfile
    
    Options:
    -w NUM      	Sets the number of pre burn-in iterations (default is 100000)
    -x NUM      	Sets the number of burn-in iterations (default is 100000)
    -y NUM      	Sets the number of iterations after burn-in (default is 100000)
    -z NUM      	Sets the number of iterations between samples (default is 100)
    -T NUM      	Sets the value of theta. Use sNUM instead of NUM for per-site
    -R NUM      	Sets the value of rho. Use sNUM instead of NUM for per-site
    -D NUM      	Sets the value of delta
    -s NUM      	Use given seed to initiate random number generator
    -S NUM,SEED 	Run on a subset of NUM regions determined by seed SEED
       NUM/NUM/../NUM 	Run on a specified region(s) given by each NUM.
    -r NUM		Perform r tempered steps between topological updates (default:0)
    -t NUM		Tempered at "temperature" t for topological updates (default:1.0)
    -U			Start from UPGMA tree, rather than the default random tree.
    -G NUM		Greedily compute the "best fit" tree, given the recombination
			observed on the current tree.  If NUM is negative and a previous
			run is provided, the tree is calculated from all observed values.
			If NUM is positive, a "greedy move" is performed with weight
			NUM (see -a).  Note that this is NOT an MCMC move and causes bias.
    -a NUM,...,NUM	Set the ELEVEN (real valued) move weightings to the given vector,
    with weightings separated by commas (NOT SPACES).  
    The weightings need not sum to 1, but must be in the following order:
    	MoveRho   (ignored if not needed)
    	MoveDelta (ignored if not needed)
    	MoveTheta (ignored if not needed)
    	MoveRemEdge
    	MoveAddEdge
    	MoveSiteChange
    	MoveTimeChange
    	MoveEdgeChange
    	MoveAgeClonal
    	MoveScaleTree
    	MoveRegraftClonal
    -i NUM,...,NUM	Set the SIX parameters for creating random Recombination Trees
			under the inference model.  The parameters are:
    	N	(integer)	The number of sequences in the sample (default 10)
    	n_B	(integer)	The number of block boundaries in the sample (default 8)
    	l_B	(integer)	The length of each block: L=n_B * l_B (default 500)
    	delta	(real)		The average length of imports (default 500.0)
    	theta	(real)		The mutation rate NOT per site (default 100.0)
    	rho	(real)		The recombination rate NOT per site (default 50.0)
    -f			Forbid topology changes, (allowing updates of coalescence times).
    -v          	Verbose mode
    -h          	This help message
    -V          	Print Version info
```


## Metadata
- **Skill**: not generated
