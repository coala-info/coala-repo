# bayescode CWL Generation Report

## bayescode_mutselomega

### Tool Description
A tool for analyzing codon models with multiple Omegas.

### Metadata
- **Docker Image**: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
- **Homepage**: https://github.com/ThibaultLatrille/bayescode
- **Package**: https://anaconda.org/channels/bioconda/packages/bayescode/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bayescode/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-30
- **GitHub**: https://github.com/ThibaultLatrille/bayescode
- **Stars**: N/A
### Original Help Text
```text
[[0m[2m2026-02-25 04:46:04.673[0m] [[0m[2m1[0m] [[0m[2mglobal[0m] [[0m[2minfo[0m] [[0m[2m/opt/conda/conda-bld/bayescode_1746044189037/work/src/lib/Random.cpp:35[0m] [0mRandom seed is 673799

USAGE: 

   mutselomega  [--omegaarray <string>] [--omegashift <double>]
                [--omegancat <int>] [--freeomega] [--flatfitness]
                [--profiles <string>] [--ncat <int>] -a <string> [-f] [-u
                <int>] [-e <int>] -t <string> [--] [--version] [-h]
                <string>


Where: 

   --omegaarray <string>
     File path to ω values (one ω per line), thus considered fixed.
     `freeomega` is overridden to false and `omegancat` equals to the
     number of ω in the file.

   --omegashift <double>
     Additive shift applied to all ω (0.0 for the general case).

   --omegancat <int>
     Number of components for ω (finite mixture).

   --freeomega
     ω is allowed to vary (default ω is 1.0). Combined with the option
     `flatfitness`, we obtain the classical, ω-based codon model (Muse &
     Gaut). Without the option `flatfitness`, we obtain the
     mutation-selection codon model with a multiplicative factor (ω⁎).

   --flatfitness
     Fitness profiles are flattened (and `ncat` equals to 1). This option
     is not compatible with the option `profiles`.

   --profiles <string>
     File path the fitness profiles (tsv or csv), thus considered fixed.
     Each line must contains the fitness of each of the 20 amino-acid, thus
     summing to one. If same number of profiles as the codon alignment,
     site allocations are considered fixed. If smaller than the alignment
     size, site allocations are computed and `ncat` is given by the number
     of profiles in the file.

   --ncat <int>
     Number of components for the amino-acid fitness profiles (truncation
     of the stick-breaking process).

   -a <string>,  --alignment <string>
     (required)  File path to alignment (PHYLIP format).

   -f,  --force
     Overwrite existing output files.

   -u <int>,  --until <int>
     Maximum number of (saved) iterations (-1 means unlimited).

   -e <int>,  --every <int>
     Number of MCMC iterations between two saved point in the trace.

   -t <string>,  --tree <string>
     (required)  File path to the tree (NHX format).

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.

   <string>
     (required)  Chain name (output file prefix)


   AAMutSelMultipleOmega
```


## bayescode_nodemutsel

### Tool Description
DatedMutSel

### Metadata
- **Docker Image**: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
- **Homepage**: https://github.com/ThibaultLatrille/bayescode
- **Package**: https://anaconda.org/channels/bioconda/packages/bayescode/overview
- **Validation**: PASS

### Original Help Text
```text
[[0m[2m2026-02-25 04:46:28.473[0m] [[0m[2m1[0m] [[0m[2mglobal[0m] [[0m[2minfo[0m] [[0m[2m/opt/conda/conda-bld/bayescode_1746044189037/work/src/lib/Random.cpp:35[0m] [0mRandom seed is 472991

USAGE: 

   nodemutsel  [--uniq_kappa] [--df <int>] [--fossils <string>] [-d]
               [--precision <unsigned>] [-p] [--clamp_corr_matrix]
               [--clamp_nuc_matrix] [--clamp_pop_sizes]
               [--move_root_pop_size] [--profiles <string>] [--traitsfile
               <string>] [--ncat <int>] -a <string> [-f] [-u <int>] [-e
               <int>] -t <string> [--] [--version] [-h] <string>


Where: 

   --uniq_kappa
     Unique kappa for the invert Wishart matrix prior, otherwise 1 for each
     dimension (experimental).

   --df <int>
     Invert Wishart degree of freedom (experimental).

   --fossils <string>
     File path to the fossils calibration in tsv format with columns
     `NodeName`, `Age, `LowerBound` and `UpperBound`.

   -d,  --arithmetic
     Use arithmetic mean instead of geometric (experimental).

   --precision <unsigned>
     The precision of Poisson-Random-Field computations (experimental).

   -p,  --polymorphism_aware
     Use polymorphic data (experimental).

   --clamp_corr_matrix
     Clamp the correlation matrix (experimental).

   --clamp_nuc_matrix
     Clamp the nucleotide matrix (experimental).

   --clamp_pop_sizes
     Clamp the branch population size (experimental).

   --move_root_pop_size
     Move Ne at the root, for the equilibrium frequencies (experimental)

   --profiles <string>
     File path the fitness profiles (tsv or csv), thus considered fixed.
     Each line must contains the fitness of each of the 20 amino-acid, thus
     summing to one. If same number of profiles as the codon alignment,
     site allocations are considered fixed. If smaller than the alignment
     size, site allocations are computed and `ncat` is given by the number
     of profiles in the file.

   --traitsfile <string>
     File path to the life-history trait (in log-space) in tsv format. The
     First column is `TaxonName` (taxon matching the name in the alignment)
     and the next columns are traits.

   --ncat <int>
     Number of components for the amino-acid fitness profiles (truncation
     of the stick-breaking process).

   -a <string>,  --alignment <string>
     (required)  File path to alignment (PHYLIP format).

   -f,  --force
     Overwrite existing output files.

   -u <int>,  --until <int>
     Maximum number of (saved) iterations (-1 means unlimited).

   -e <int>,  --every <int>
     Number of MCMC iterations between two saved point in the trace.

   -t <string>,  --tree <string>
     (required)  File path to the tree (NHX format).

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.

   <string>
     (required)  Chain name (output file prefix)


   DatedMutSel
```


## bayescode_nodeomega

### Tool Description
DatedNodeOmega

### Metadata
- **Docker Image**: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
- **Homepage**: https://github.com/ThibaultLatrille/bayescode
- **Package**: https://anaconda.org/channels/bioconda/packages/bayescode/overview
- **Validation**: PASS

### Original Help Text
```text
[[0m[2m2026-02-25 04:46:44.850[0m] [[0m[2m1[0m] [[0m[2mglobal[0m] [[0m[2minfo[0m] [[0m[2m/opt/conda/conda-bld/bayescode_1746044189037/work/src/lib/Random.cpp:35[0m] [0mRandom seed is 850659

USAGE: 

   nodeomega  [--uniq_kappa] [--df <int>] [--fossils <string>]
              [--traitsfile <string>] -a <string> [-f] [-u <int>] [-e
              <int>] -t <string> [--] [--version] [-h] <string>


Where: 

   --uniq_kappa
     Unique kappa for the invert Wishart matrix prior (otherwise 1 for each
     dimension)

   --df <int>
     Invert Wishart degree of freedom

   --fossils <string>
     Fossils data (to clamp the node ages)

   --traitsfile <string>
     Traits file for taxon at the leaves

   -a <string>,  --alignment <string>
     (required)  File path to alignment (PHYLIP format).

   -f,  --force
     Overwrite existing output files.

   -u <int>,  --until <int>
     Maximum number of (saved) iterations (-1 means unlimited).

   -e <int>,  --every <int>
     Number of MCMC iterations between two saved point in the trace.

   -t <string>,  --tree <string>
     (required)  File path to the tree (NHX format).

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.

   <string>
     (required)  Chain name (output file prefix)


   DatedNodeOmega
```


## bayescode_nodetraits

### Tool Description
Processes traits for nodes in a phylogenetic tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
- **Homepage**: https://github.com/ThibaultLatrille/bayescode
- **Package**: https://anaconda.org/channels/bioconda/packages/bayescode/overview
- **Validation**: PASS

### Original Help Text
```text
[[0m[2m2026-02-25 04:47:03.459[0m] [[0m[2m1[0m] [[0m[2mglobal[0m] [[0m[2minfo[0m] [[0m[2m/opt/conda/conda-bld/bayescode_1746044189037/work/src/lib/Random.cpp:35[0m] [0mRandom seed is 459126

USAGE: 

   nodetraits  [--uniq_kappa] [--df <int>] --traitsfile <string> [-f] [-u
               <int>] [-e <int>] -t <string> [--] [--version] [-h]
               <string>


Where: 

   --uniq_kappa
     Unique kappa for the invert Wishart matrix prior (otherwise 1 for each
     dimension)

   --df <int>
     Invert Wishart degree of freedom

   --traitsfile <string>
     (required)  Traits file for taxon at the leaves

   -f,  --force
     Overwrite existing output files.

   -u <int>,  --until <int>
     Maximum number of (saved) iterations (-1 means unlimited).

   -e <int>,  --every <int>
     Number of MCMC iterations between two saved point in the trace.

   -t <string>,  --tree <string>
     (required)  File path to the tree (NHX format).

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.

   <string>
     (required)  Chain name (output file prefix)


   DatedNodeOmega
```


## bayescode_readmutselomega

### Tool Description
Computes posterior probabilities of ω and ω₀, and related statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
- **Homepage**: https://github.com/ThibaultLatrille/bayescode
- **Package**: https://anaconda.org/channels/bioconda/packages/bayescode/overview
- **Validation**: PASS

### Original Help Text
```text
[[0m[2m2026-02-25 04:47:24.309[0m] [[0m[2m1[0m] [[0m[2mglobal[0m] [[0m[2minfo[0m] [[0m[2m/opt/conda/conda-bld/bayescode_1746044189037/work/src/lib/Random.cpp:35[0m] [0mRandom seed is 309552

USAGE: 

   readmutselomega  [--omega_threshold <string>] [-s] [-c <string>]
                    [--omega_0] [--omega] [--chain_omega <string>] [-n] [-o
                    <string>] [--trace] [-p] [-b <int>] [-u <int>] [-e
                    <int>] [--] [--version] [-h] <string>


Where: 

   --omega_threshold <string>
     Threshold to compute the mean posterior probability that ω⁎ (or ω
     if option `flatfitness` is used in `mutselomega`) is greater than a
     given value (1.0 to test for adaptation). Results are written in
     {chain_name}.omegappgt{omega_pp}.tsv by default (optionally use the
     --output argument to specify a different output path).

   -s,  --ss
     Computes the mean posterior site-specific amino-acid equilibrium
     frequencies(amino-acid fitness profiles). Results are written in
     {chain_name}.siteprofiles by default (optionally use the --output
     argument  to specify a different output path).

   -c <string>,  --confidence_interval <string>
     Boundary for posterior credible interval of ω and ω₀ (per site and
     at the gene level). Default value is 0.025 at each side, meaning
     computing the 1-2*0.025=95% CI.

   --omega_0
     Compute posterior credible interval for ω₀ predicted at the
     mutation-selection equilibrium from the fitness profiles, for each
     site and at the gene level. Can be combined with the option
     `confidence_interval` to change the default value (0.025 at each side
     of the distribution). Results are written in
     {chain_name}.ci{confidence_interval}.tsv by default (optionally use
     the --output argument to specify a different output path).

   --omega
     Compute posterior credible interval for ω for each site and at the
     gene level. Can be combined with the option `confidence_interval` to
     change the default value (0.025 at each side of the distribution).
     Results are written in {chain_name}.ci{confidence_interval}.tsv by
     default (optionally use the --output argument to specify a different
     output path).

   --chain_omega <string>
     A second chain ran with the option --freeomega and --flatfitness to
     obtain the classical ω-based codon model (Muse & Gaut). These two
     chains allow to compute posterior of ω, ω₀, ωᴬ=ω-ω₀ and
     p(ωᴬ>0) for each site and at the gene level. Results are written in
     {chain_name}.omegaA.tsv by default (optionally use the --output
     argument  to specify a different output path).

   -n,  --nuc
     Mean posterior 4x4 nucleotide matrix.Results are written in
     {chain_name}.nucmatrix.tsv by default (optionally use the --output
     argument  to specify a different output path).

   -o <string>,  --output <string>
     Output file path (optional)

   --trace
     Recompute the trace.Trace is written in {chain_name}.trace.tsv by
     default (optionally use the --output argument to specify a different
     output path).

   -p,  --ppred
     For each point of the chain (after burn-in), produces a data replicate
     simulated from the posterior predictive distribution

   -b <int>,  --burnin <int>
     Number of MCMC iterations for the burn-in.

   -u <int>,  --until <int>
     Maximum number of (saved) iterations (-1 means unlimited).

   -e <int>,  --every <int>
     Number of MCMC iterations between two saved point in the trace.

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.

   <string>
     (required)  Chain name (output file prefix).


   AAMutSelMultipleOmega
```


## Metadata
- **Skill**: generated
