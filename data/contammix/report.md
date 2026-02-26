# contammix CWL Generation Report

## contammix

### Tool Description
Estimate the proportion of authentic sequences in a sample, accounting for potential contamination and aDNA damage.

### Metadata
- **Docker Image**: quay.io/biocontainers/contammix:1.0.11--r45h28c4f14_5
- **Homepage**: https://github.com/plfjohnson/contamMix
- **Package**: https://anaconda.org/channels/bioconda/packages/contammix/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/contammix/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/plfjohnson/contamMix
- **Stars**: N/A
### Original Help Text
```text
Usage: ./estimate.R --samFn <data.sam>  --malnFn <alignment.fa> [--nIter <50000>] [--nChains <3>] [--alpha <0.1>] [--figure <outputfigure.pdf>] [--baseq <30>] [--transverOnly] [--trimBases <0>] [--saveMN] [--tabOutput] ...

 Required parameter:
 	--samFn    --> SAM/BAM data file aligned to consensus
 	--malnFn   --> FASTA-format multiple alignment of consensus and potential contaminants
 Optional parameters:
 	--consId --> consensus id in multiple alignment (if not supplied, assumes this is identical to the reference id in the SAM/BAM)
 	--nIter --> number of iterations in Markov chain (default 50000)
 	--nChains --> number of MCMC chains to run from different random starting parameters, which are used for Gelman-Rubin convergence testing (default 3; uses multiple processors if available)
 	--alpha --> hyperparameter to Dirichlet prior distribution; may need to be tweaked if MCMC is mixing poorly (default 0.1)
 	--figure --> if supplied, generates a PDF figure with 3 panels: convergence of gelman diagnostic (if --nChains>1),  Pr(authentic) as a function of MC iteration, estimated posterior density for Pr(authentic)
 	--baseq --> base quality threshold below which to discard data (default 30; 0 signals NO threshold)
 	--transverOnly --> only use sites with transversions (avoids potential for bias from aDNA damage, but has significantly less power)
 	--trimBases --> trim this # of bases from ends of sequence (reducing effect of aDNA damage)
 	--saveData --> save chain data to specified file (in .Rdata format) for manual diagnostics
 	--saveMN --> save MN intermediate file for manual debugging (will use filename '<samFn>.mn')
 	--nrThreads --> The number of threads to use. Defaults to 1. If a number higher than the available threads is used, the maximum available number of threads will be used instead.
 	--tabOutput --> output a single line of text with the following tab-separated values: <inferred-error-rate> <MAP-authentic> <2.5% authentic> <97.5% authentic> <gelman diagnostic> <gelman diag upper bound>

NOTE: Not converged if Gelman diagnostic >1.1.  Initial runs on any new data should request a --figure to visually check that the Markov chain is well-behaved.
```

