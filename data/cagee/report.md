# cagee CWL Generation Report

## cagee

### Tool Description
CAGEE is a software that provides a statistical foundation for evolutionary inferences about changes in gene expression. The program employs a Brownian motion process to model gene expression across a user-specified phylogenetic tree, thus accounting for the species phylogenetic history. The distribution of gene expression generated under this model can provide a basis for assessing the significance of the observed expression differences among taxa.

### Metadata
- **Docker Image**: quay.io/biocontainers/cagee:1.2--he96a11b_1
- **Homepage**: https://github.com/hahnlab/CAGEE
- **Package**: https://anaconda.org/channels/bioconda/packages/cagee/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cagee/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hahnlab/CAGEE
- **Stars**: N/A
### Original Help Text
```text
CAGEE 1.2

Usage: cagee [options]

CAGEE is a software that provides a statistical foundation for evolutionary inferences about changes in gene expression.
 The program employs a Brownian motion process to model gene expression across a user-specified phylogenetic tree,
 thus accounting for the species phylogenetic history. The distribution of gene expression generated under this model can
 provide a basis for assessing the significance of the observed expression differences among taxa.

Generic options:
  -h [ --help ]         produce help message
  -v [ --version ]      print version string
  -c [ --config ] arg   Configuration file containing additional options

Required options (May be specified on command line or in file):
  -i [ --infile ] arg   Path to tab delimited gene families file to be analyzed
                        - Required for estimation
  -t [ --tree ] arg     Path to file containing newick formatted tree - 
                        Required for estimation.

Configuration options (May be specified on command line or in file):
  -@ [ --cores ] arg                    Number of processing cores to use, 
                                        requires an integer argument. 
                                        Default=All available cores.
  -@ [ --n_gamma_cats ] arg             Number of gamma categories to use, 
                                        requires an integer argument. Default=1
                                        (No gamma modelling)
  -e [ --error ] [=arg(=true)] (=false) Run with no file name to estimate the 
                                        global error model file. This file can 
                                        be providedin subsequent runs by 
                                        providing the path to the Error model 
                                        file with no spaces(e.g. - 
                                        eBase_error_model.txt).
  -o [ --output_prefix ] arg             Output directory - Name of directory 
                                        automatically created for output. 
                                        Default=results.
  -m [ --fixed_multiple_sigmas ] arg    Multiple sigma values, comma separated.
  --rootdist arg                        Distribution of the root in Simulation 
                                        Mode (mutually exclusive with --prior 
                                        in Inference Mode). Can be 
                                        gamma:[k]:[theta], fixed:[count], or a 
                                        path/to/tab_sep_file.txt with two 
                                        columns: trascripts names and their 
                                        counts. Default=gamma:0.375:1600.0
  --prior arg                           Expected distribution of the root in 
                                        Inference Mode (mutually exclusive with
                                        --rootdist in Simulation Mode). Must be
                                        gamma:[k]:[theta].  Default=gamma:0.375
                                        :1600.0
  --verbose arg
  --replicate_map arg                   Filename of a file containing a list of
                                        specie replicates to be combined into a
                                        single species
  --sample_group arg                    Specifies sample groups (if any) for 
                                        which to infer sigma^2.  Each sample 
                                        and sigma^2 estimate requires a 
                                        --sample_group [your_sample_A] arg, or 
                                        combine them with comma: --sample_group
                                        [your_sample_A,your_sample_B,...].  
                                        Optional, no default.
  -y [ --sigma_tree ] arg               Path to sigma tree, for use with 
                                        multiple sigmas
  -s [ --simulate ] arg (=false)        Simulate families. Optionally provide 
                                        the number of simulations to generate
  -l [ --fixed_sigma ] arg              Value for a single user provided sigma 
                                        value, otherwise sigma is estimated.
  --fixed_alpha arg                     Value for a single user provided alpha 
                                        value, otherwise alpha is estimated.
  --count_all_changes [=arg(=1)]        Reconstruction will count all changes 
                                        rather than only credible changes
  --ratio [=arg(=1)]                    The input file contains ratios of gene 
                                        expression values rather than absolute 
                                        values

Less Common Options:
  -D [ --discretization_size ] arg (=200)
                                        Size (length) of the discretization 
                                        vector, Default=200. Can increase 
                                        resolution at the cost of computation 
                                        time.
  -z [ --zero_root ] [=arg(=1)]         Exclude gene families that don't exist 
                                        at the root, not recommended.
  -E [ --optimizer_expansion ] arg      Expansion parameter for Nelder-Mead 
                                        optimizer, Default=2.
  -R [ --optimizer_reflection ] arg     Reflection parameter for Nelder-Mead 
                                        optimizer, Default=1.
  -I [ --optimizer_iterations ] arg     Maximum number of iterations that will 
                                        be performed in sigma search.Default = 
                                        300 (increase this number if likelihood
                                        is still improving when limit is hit).
```

