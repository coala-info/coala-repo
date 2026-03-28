PROGRAM: phyloFit
DESCRIPTION:
Fits one or more tree models to a multiple alignment of DNA
sequences by maximum likelihood, using the specified tree topology
and substitution model. If categories of sites are defined via
--features and --catmap (see below), then a separate model will be
estimated for each category. A description of each model will
be written to a separate file, with the suffix ".mod". These
.mod files minimally include a substitution rate matrix, a tree with
branch lengths, and estimates of nucleotide equilibrium
frequencies. They may also include information about parameters
for modeling rate variation.
USAGE: phyloFit [OPTIONS]
 should be a multiple alignment in FASTA format or
one of several alternative formats (see --msa-format). For
backward compatibility, this argument may be preceded by '-m' or
'--msa'. Note that --tree is required in most cases. By default,
all output files will have the prefix "phyloFit" (see
--out-root).
EXAMPLES:
(If you're like me, you want some basic examples first, and a list
of all options later.)
1. Compute the distance between two aligned sequences (in FASTA file
pair.fa) under the REV model.
phyloFit pair.fa
(output is to phyloFit.mod; distance in substitutions per site
appears in the TREE line in the output file)
2. Fit a phylogenetic model to an alignment of human, chimp, mouse,
and rat sequences. Use the HKY85 substitution model. Write output
to files with prefix "myfile".
phyloFit --tree "((human,chimp),(mouse,rat))" --subst-mod HKY85
--out-root myfile primate-rodent.fa
3. As above, but use the discrete-gamma model for rate variation,
with 4 rate categories.
phyloFit --tree "((human,chimp),(mouse,rat))" --subst-mod HKY85
--out-root myfile --nrates 4 primate-rodent.fa
4. As above, but use genome-wide data, stored in the compact
"sufficient-statistics" format (can be produced with "msa\_view
-o SS").
phyloFit --tree "((human,chimp),(mouse,rat))" --subst-mod HKY85
--out-root myfile --nrates 4 --msa-format SS
primate-rodent.ss
5. Fit a context-dependent phylogenetic model (U2S) to an
alignment of human, mouse, and rat sequences. Use
an EM algorithm for parameter optimization and relax the
convergence criteria a bit (recommended with context-dependent
models). Write a log file for the optimization procedure.
Consider only non-overlapping pairs of sites.
phyloFit --tree "(human,(mouse,rat))" --subst-mod U2S --EM
--precision MED --non-overlapping --log u2s.log --out-root
hmr-u2s hmr.fa
6. As above, but allow overlapping pairs of sites, and compute
likelihoods by assuming Markov-dependence of columns (see Siepel &
Haussler, 2004). The EM algorithm can no longer be used
(optimization will be much slower).
phyloFit --tree "(human,(mouse,rat))" --subst-mod U2S
--precision MED --log u2s-markov.log --markov hmr.fa
7. Compute a likelihood using parameter estimates obtained in (5)
and an assumption of Markov dependence. This provides a lower
bound on the likelihood of the Markov-dependent model.
phyloFit --init-model hmr-u2s.mod --lnl --markov hmr.fa
8. Given an alignment of several mammalian sequences (mammals.fa), a
tree topology (tree.nh), and a set of gene annotations in GFF
(genes.gff), fit separate models to sites in 1st, 2nd, and 3rd
codon positions. Use the REV substitution model. Assume coding
regions have feature type 'CDS'.
phyloFit --tree tree.nh --features genes.gff --out-root mammals-rev
--catmap "NCATS = 3; CDS 1-3" --do-cats 1,2,3 mammals.fa
(output will be to mammals-rev.cds-1.mod, mammals-rev.cds-2.mod, and
mammals-rev.cds-3.mod)
OPTIONS:
--tree, -t |
(Required if more than three species, or more than two species
and a non-reversible substitution model, e.g., UNREST, U2, U3)
Name of file or literal string defining tree topology. Tree
must be in Newick format, with the label at each leaf equal to
the index or name of the corresponding sequence in the alignment
(indexing begins with 1). Examples: --tree "(1,(2,3))",
--tree "(human,(mouse,rat))". Currently, the topology must be
rooted. When a reversible substitution model is used, the root
is ignored during the optimization procedure.
--subst-mod, -s JC69|F81|HKY85|HKY85+Gap|REV|SSREV|UNREST|R2|R2S|U2|U2S|R3|R3S|U3|U3S
(default REV). Nucleotide substitution model. JC69, F81, HKY85
REV, and UNREST have the usual meanings (see, e.g., Yang,
Goldman, and Friday, 1994). SSREV is a strand-symmetric version
of REV. HKY85+Gap is an adaptation of HKY that treats gaps as a
fifth character (courtesy of James Taylor). The others, all
considered "context-dependent", are as defined in Siepel and
Haussler, 2004. The options --EM and --precision MED are
recommended with context-dependent models (see below).
--msa-format, -i FASTA|PHYLIP|MPM|MAF|SS
(default is to guess format from file contents) Alignment format.
FASTA is as usual. PHYLIP is compatible with the formats used in
the PHYLIP and PAML packages. MPM is the format used by the
MultiPipMaker aligner and some other of Webb Miller's older tools.
MAF ("Multiple Alignment Format") is used by MULTIZ/TBA and the
UCSC Genome Browser. SS is a simple format describing the
sufficient statistics for phylogenetic inference (distinct columns
or tuple of columns and their counts). Note that the program
"msa\_view" can be used for file conversion.
--out-root, -o
(default "phyloFit"). Use specified string as root filename
for all files created.
--min-informative, -I
Require at least  "informative" sites -- i.e.,
sites at which at least two non-gap and non-missing-data ('N'
or '\*') characters are present. Default is 50.
--gaps-as-bases, -G
Treat alignment gap characters ('-') like ordinary bases. By
default, they are treated as missing data.
--ignore-branches, -b
Ignore specified branches in likelihood computations and parameter
estimation, and treat the induced subtrees as independent. Can be
useful for likelihood ratio tests. The argument  should
be a comma-separated list of nodes in the tree, indicating the
branches above these nodes, e.g., human-chimp,cow-dog. (See
tree\_doctor --name-ancestors regarding names for ancestral nodes.)
This option does not currently work with --EM.
--quiet, -q
Proceed quietly.
--help, -h
Print this help message.
(Options for controlling and monitoring the optimization procedure)
--lnl, -L
(for use with --init-model) Simply evaluate the log likelihood of
the specified tree model, without performing any further
optimization. Can be used with --post-probs, --expected-subs, and
--expected-total-subs.
--EM, -E
Fit model(s) using EM rather than the BFGS quasi-Newton
algorithm (the default).
--precision, -p HIGH|MED|LOW
(default HIGH) Level of precision to use in estimating model
parameters. Affects convergence criteria for iterative
algorithms: higher precision means more iterations and longer
execution time.
--log, -l
Write log to  describing details of the optimization
procedure.
--init-model, -M
Initialize with specified tree model. By choosing good
starting values for parameters, it is possible to reduce
execution time dramatically. If this option is chosen, --tree
is not allowed. The substitution model used in the given
model will be used unless --subst-mod is also specified.
Note: currently only one mod\_fname may be specified; it will be
used for all categories.
--init-random, -r
Initialize parameters randomly. Can be used multiple times to test
whether the m.l.e. is real.
--seed, -D
Provide a random number seed for choosing initial parameter values
(usually with --init-random, though random values are used in some
other cases as well). Should be an integer >=1. If not provided,
seed is chosen based on current time.
--init-parsimony, -y
Initialize branch lengths using parsimony counts for given data.
Only currently implemented for models with single character state
(ie, not di- or tri-nucleotides). Other --init options such
as --init-random or --init-model can be used in conjunction to
initialize substitution matrix parameters.
--print-parsimony, -Y
Print parsimony score to given file, and quit. (Does not optimize
or report likelihoods).
--clock, -z
Assume a molecular clock in estimation. Causes the distances to all
descendant leaves to be equal for each ancestral node and cuts the
number of free branch-length parameters roughly in half.
--scale-only, -B
(for use with --init-model) Estimate only the scale of the tree,
rather than individual branch lengths (branch proportions fixed).
Equilibrium frequencies and rate-matrix parameters will still be
estimated unless --no-freqs and --no-rates are used.
--scale-subtree, -S
(for use with --scale-only) Estimate separate scale factors for
subtree beneath identified node and rest of tree. The branch
leading to the subtree is included with the subtree. If ":loss" or
":gain" is appended to , subtree scale is constrained to
be greater than or less than (respectively) scale for rest of tree.
--estimate-freqs, -F
Estimate equilibrium frequencies by maximum likelihood, rather
than approximating them by the relative frequencies in the data.
If using the SSREV model, this option implies --sym-freqs.
--sym-freqs, -W
Estimate equilibrium frequencies, assuming freq(A)=freq(T) and
freq(C)=freq(G). This only works for an alphabet ACGT (and possibly
gap). This option implies --estimate-freqs.
--no-freqs, -f
(for use with --init-model) Do not estimate equilibrium
frequencies; just use the ones from the given tree model.
--no-rates, -n
(for use with --init-model) Do not estimate rate-matrix
parameters; just use the ones from the given tree model.
--ancestor, -A
Treat specified sequence as the root of the tree. The tree
topology must define this sequence to be a child of the root
(in practice, the branch from the root to the specified
sequence will be retained, but will be constrained to have
length zero).
--error, -e
For each parameter, report estimate, variance, and 95%% confidence
interval, printed to given filename, one parameter per line.
--no-opt, -O
Hold parameters listed in comma-separated param\_list constant at
initial values. This applies only to the "main" model, and not to
any models defined with the --alt-mod option. Param list can
contain values such as "branches" to hold branch lengths constant,
"ratematrix", "backgd", or "ratevar" to hold entire rate matrix,
equilibrium frequencies, or rate variation parameters constant
(respectively). There are also substitution model-specific
parameters such as "kappa" (transition/transversion rate ratio).
Note: to hold certain branches constant, but optimize others,
put an exclamation point in the newick-formatted tree after the
branch lengths that should be held constant. This can be useful
for enforcing a star-phylogeny. However, note that the two branches
coming from root of tree are treated as one. So they should both
be held constant, or not held constant. This option does \*not\* work
with --scale-only or --clock.
--bound
Set boundaries for parameter. lower\_bound or upper\_bound may be
empty string to keep default. For example --bound gc\_param[1,] will
set the lower bound for gc\_param to 1 (keeping upper bound at infinity),
for a GC model. Only applies to parameters for model in the "main"
tree, but similar syntax can be used within the --alt-mod arguments.
Can be used multiple times to set boundaries for different parameters.
--selection
Use selection in the model (is also implied if --init-model is used
and contains selection parameter). Selection scales rate matrix
entries by selection\_param/(1-exp(-selection-param)); this is done
after rate matrix is scaled to set expected number of substitutions
per unit time to 1. If using codon models selection acts only on
nonysynonymous mutations.
(Options for modeling rate variation)
--nrates, -k
(default 1). Number of rate categories to use. Specifying a
value of greater than one causes the discrete gamma model for
rate variation to be used (Yang, 1994).
--alpha, -a
(for use with --nrates). Initial value for alpha, the shape
parameter of the gamma distribution. Default is 1.
--rate-constants, -K
Use a non-parameteric mixture model for rates, instead of
assuming a gamma distribution. The argument
must be a comma-delimited list explicitly defining the rate
constants to be used. The "weight" (mixing proportion)
associated with each rate constant will be estimated by EM
(this option implies --EM). If --alpha is used with
this option, then the mixing proportions will be initialized
to reflect a gamma distribution with the specified shape
parameter.
(Options for separate handling of sites in different annotation categories)
--features, -g
Annotations file (GFF or BED format) describing features on
one or more sequences in the alignment. Together with a
category map (see --catmap), will be taken to define site
categories, and a separate model will be estimated for each
category. If no category map is specified, a category will be
assumed for each type of feature, and they will be numbered in
the order of appearance of the features. Features are assumed
to use the coordinate frame of the first sequence in the
alignment and should be non-overlapping (see 'refeature
--unique').
--catmap, -c |
(optionally use with --features) Mapping of feature types to
category numbers. Can either give a filename or an "inline"
description of a simple category map, e.g., --catmap "NCATS =
3 ; CDS 1-3" or --catmap "NCATS = 1 ; UTR 1". Note that
category 0 is reserved for "background" (everything that is
not described by a defined feature type).
--do-cats, -C
(optionally use with --features) Estimate models for only the
specified categories (comma-delimited list categories, by name
or numbera). Default is to fit a model for every category.
--reverse-groups, -R
(optionally use with --features) Group features by  (e.g.,
"transcript\_id" or "exon\_id") and reverse complement
segments of the alignment corresponding to groups on the
reverse strand. Groups must be non-overlapping (see refeature
--unique). Useful with categories corresponding to
strand-specific phenomena (e.g., codon positions).
(Options for context-dependent substitution models)
--markov, -N
(for use with context-dependent substitutions models and not
available with --EM.) Assume Markov dependence of alignment
columns, and compute the conditional probability of each
column given its N-1 predecessors using the two-pass algorithm
described by Siepel and Haussler (2004). (Here, N is the
"order" of the model, as defined by --subst-mod; e.g., N=1
for REV, N=2 for U2S, N=3 for U3S.) The alternative (the
default) is simply to work with joint probabilities of tuples
of columns. (You can ensure that these tuples are
non-overlapping with the --non-overlapping option.) The use
of joint probabilities during parameter estimation allows the
use of the --EM option and can be much faster; in addition, it
appears to produce nearly equivalent estimates. If desired,
parameters can be estimated without --markov, and
then the likelihood can be evaluated using --lnl and
--markov together. This gives a lo