# pplacer CWL Generation Report

## pplacer

### Tool Description
pplacer [options] [alignment]

### Metadata
- **Docker Image**: quay.io/biocontainers/pplacer:1.1.alpha17--0
- **Homepage**: http://matsen.fredhutch.org/pplacer/
- **Package**: https://anaconda.org/channels/bioconda/packages/pplacer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pplacer/overview
- **Total Downloads**: 102.2K
- **Last updated**: 2026-01-30
- **GitHub**: https://github.com/matsen/pplacer
- **Stars**: N/A
### Original Help Text
```text
pplacer [options] [alignment]
  -c                           Specify the path to the reference package.
  -t                           Specify the reference tree filename.
  -r                           Specify the reference alignment filename.
  -s                           Supply a phyml stats.txt or a RAxML info file giving the model parameters.
  -d                           Specify the directory containing the reference information.
  -p                           Calculate posterior probabilities.
  -m                           Substitution model. Protein: LG, WAG, or JTT. Nucleotides: GTR.
  --model-freqs                Use model frequencies instead of reference alignment frequencies.
  --gamma-cats                 Number of categories for discrete gamma model.
  --gamma-alpha                Specify the shape parameter for a discrete gamma model.
  --ml-tolerance               1st stage branch len optimization tolerance (2nd stage to 1e-5). Default: 0.01.
  --pp-rel-err                 Relative error for the posterior probability calculation. Default is 0.01.
  --unif-prior                 Use a uniform prior rather than exponential.
  --inform-prior               Use an informative exponential prior based on rooted distance to leaves.
  --prior-lower                Lower bound for the informative prior mean. Default is 0.
  --start-pend                 Starting pendant branch length. Default is 0.1.
  --max-pend                   Set the maximum ML pendant branch length. Default is 2.
  --fig-cutoff                 The cutoff for determining figs. Default is 0; specify 0 to disable.
  --fig-eval-all               Evaluate all likelihoods to ensure that the best location was selected.
  --fig-eval-discrepancy-tree  Write out a tree showing the discrepancies between the best complete and observed locations.
  --fig-tree                   Write out a tree showing the figs on the tree.
  --max-strikes                Maximum number of strikes for baseball. 0 -> no ball playing. Default is 6.
  --strike-box                 Set the size of the strike box in log likelihood units. Default is 3.
  --max-pitches                Set the maximum number of pitches for baseball. Default is 40.
  --fantasy                    Desired likelihood cutoff for fantasy baseball mode. 0 -> no fantasy.
  --fantasy-frac               Fraction of fragments to use when running fantasy baseball. Default is 0.1.
  --write-masked               Write alignment masked to the region without gaps in the query.
  --verbosity                  Set verbosity level. 0 is silent, and 2 is quite a lot. Default is 1.
  --out-dir                    Specify the directory to write place files to.
  -o                           Specify the output file name
  --pretend                    Only check out the files then report. Do not run the analysis.
  --check-like                 Write out the likelihood of the reference tree, calculated two ways.
  -j                           The number of child processes to spawn when doing placements. Default is 2.
  --timing                     Display timing information after the pplacer run finishes.
  --no-pre-mask                Don't pre-mask sequences before placement.
  --write-pre-masked           Write out the pre-masked sequences to the specified fasta file before placement.
  --map-mrca                   Specify a file to write out MAP sequences for MRCAs and corresponding placements.
  --map-mrca-min               Specify cutoff for inclusion in MAP sequence file. Default is 0.8.
  --map-identity               Add the percent identity of the query sequence to the nearest MAP sequence to each placement.
  --keep-at-most               The maximum number of placements we keep. Default is 7.
  --keep-factor                Throw away anything that has ml_ratio below keep_factor times (best ml_ratio). Default is 0.01.
  --mrca-class                 Classify with MRCAs instead of a painted tree.
  --groups                     Split query alignment into the specified number of groups.
  --always-refine              Always refine the model before placing.
  --mmap-file                  Instead of doing large allocations, mmap the given file. It will be created if it doesn't exist.
  --discard-nonoverlapped      When pre-masking, silently discard sequences which don't overlap the mask.
  --version                    Write out the version number and exit.
  -help                        Display this list of options
  --help                       Display this list of options
```

