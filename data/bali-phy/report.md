# bali-phy CWL Generation Report

## bali-phy_help

### Tool Description
Bayesian Inference of Alignment and Phylogeny

### Metadata
- **Docker Image**: quay.io/biocontainers/bali-phy:4.1--py314hedd121d_0
- **Homepage**: http://www.bali-phy.org
- **Package**: https://anaconda.org/channels/bioconda/packages/bali-phy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bali-phy/overview
- **Total Downloads**: 9.2K
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/bredelings/BAli-Phy
- **Stars**: N/A
### Original Help Text
```text
Bayesian Inference of Alignment and Phylogeny
Usage: bali-phy <sequence-file1> [<sequence-file2> ...] [OPTIONS]
[1mBasic[0m options:

General options:
  -h [ --help ] [=arg(=basic)]   Print usage information.
  -v [ --version ]               Print version information.
  -t [ --test ]                  Analyze the initial values and exit.
  -c [ --config ] arg            Command file to read.

MCMC options:
  -i [ --iterations ] arg        The number of iterations to run.
  -n [ --name ] arg              Name for the output directory to create.

Parameter options:
  --align arg                    Sequence file & initial alignment.
  -T [ --tree ] arg              Tree prior: ~uniform_tree(taxa), 
                                 ~uniform_rooted_tree(taxa), ~yule(taxa), etc.

Model options:
  -A [ --alphabet ] arg          The alphabet.
  -S [ --smodel ] arg            Substitution model.
  -I [ --imodel ] arg            Insertion-deletion model.
  -R [ --scale ] arg             Prior on the scale.
  -F [ --fix ] arg               Fix topology,tree,alignment
  --variables arg                Variable definitions
  -L [ --link ] arg              Link partitions.
  --subst-rates arg (=constant)  Subst rates: *constant, relaxed, or an 
                                 expression.
  --indel-rates arg (=relaxed)   Indel rates: constant, *relaxed, or an 
                                 expression.

Showing [1mbasic[0m command line options.  Not all options are shown!
  * See `bali-phy help [1madvanced[0m` to see more options.

See `bali-phy help [4moption[24m` for help on [4moption[24m.  For example,
  * `bali-phy help [1malphabet[0m` shows help on the [1m--alphabet[0m command.
  * `bali-phy help [1mnormal[0m` shows help on the normal distribution.
  * `bali-phy help [1mtn93[0m` shows help on the TN93 model.
  * `bali-phy help [1mlog[0m` shows help on the log function.

To see help on one of the following topics, run `bali-phy help [4mtopic[24m`

   alphabets/    commands/   distributions/   functions/   models/
   parameters/
```

