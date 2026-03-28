PHAST

PHAST:Downloads

Toggle navigation

* [#### Home](http://compgen.cshl.edu/phast/)
* [#### Downloads](http://compgen.cshl.edu/phast/downloads.php)
* [#### Getting Started](http://compgen.cshl.edu/phast/gettingstarted.php)
* [#### Resources](http://compgen.cshl.edu/phast/resources.php)* [#### Extras](http://compgen.cshl.edu/phast/references.php)

# PHAST ![](http://compgen.cshl.edu/phast/phast3d.png)

#### **Phylogenetic Analysis with Space/Time Models**

PHAST

#### PHAST Help Pages

#### **Tutorials**

[phastCons Tutorial](http://compgen.cshl.edu/phast/phastCons-tutorial.php)

[phyloP Tutorial](http://compgen.cshl.edu/phast/phyloP-tutorial.php)

[phyloFit Tutorial](http://compgen.cshl.edu/phast/phyloFit-tutorial.php)

[Old phastCons HowTo](http://compgen.cshl.edu/phast/phastCons-HOWTO.html)

[Help pages for all PHAST tools](http://compgen.cshl.edu/phast/phasthelppages.php)

#### **Getting Help**

   See the current [Github Issues](https://github.com/CshlSiepelLab/phast/issues) page for posting questions or searching queries from other users.

   You can also email us at phasthelp@cshl.edu

[PHAST Mantis Bug Track](http://compgen.cshl.edu/phastmantisbt/login_page.php)

#### **FAQs**

**Where does the name "PHAST" come from?**

The name "PHAST" arose because several programs in the package (including phastCons, exoniphy, and dless) make use of phylogenetic hidden Markov models (phylo-HMMs). Phylo-HMMs have been called "space/time models" because they describe DNA sequences by two Markov processes — one that operates in the dimension of time (along the branches of an evolutionary tree) and one that operates in space (along the sequences themselves) (see [Yang, 1995](https://www.genetics.org/content/139/2/993.abstract)).

**How does PHAST compare with PAML and other programs for phylogenetic modeling?**

In the realm of phylogenetic modeling, it is most similar to [PAML](http://abacus.gene.ucl.ac.uk/software/paml.html). Like PAML, PHAST supports several different nucleotide substitution models and is optimized for fitting models to (potentially large) data sets conditional on a given tree topology, rather than for topology estimation (as are [MrBayes](http://mrbayes.csit.fsu.edu/), [PhyML](http://atgc.lirmm.fr/phyml/), [RAxML](http://icwww.epfl.ch/~stamatak/index-Dateien/Page443.htm), [PHYLIP](http://evolution.genetics.washington.edu/phylip.html), and many other packages). However, PAML has very broad functionality for phylogenetic modeling, and several of its models and applications are not supported in PHAST. For example, PHAST does not support Goldman-Yang codon models, Yang-Nielsen likelihood ratio tests for positive selection, or amino acid models such as JTT or WAG, nor does it not support some of PAML's less commonly used nucleotide substitution models (e.g., F84, T92, and TN93). Nevertheless, PHAST has some features not found in PAML, such as support for general dinucleotide and trinucleotide substitution models (in phyloFit), parameter estimation by expectation maximization (also in phyloFit; this can improve performance with richly parameterized models), and phylogenetic p-value computation (in phyloP). In addition, PHAST is designed to "play well" with large-scale comparative genomic data sets (such as MAF files from UCSC). It also has a more standard command-line interface than PAML, which some users find convenient.

**How does PHAST compare with GERP and other programs for conservation scoring?**

With regard to conservation scoring and the identification of conserved elements, PHAST is probably most similar to [GERP](http://mendel.stanford.edu/SidowLab/downloads/gerp/index.html). (Related programs include [binCons](http://genome.cshlp.org/cgi/content/abstract/13/12/2507?maxtoshow=&HITS=10&hits=10&RESULTFORMAT=1&author1=margulies&andorexacttitle=and&andorexacttitleabs=and&andorexactfulltext=and&searchid=1&FIRSTINDEX=0&sortspec=relevance&resourcetype=HWCIT) and [SCONE](http://genetics.bwh.harvard.edu/scone/).) GERP is primarily a column-by-column conservation scoring method, and is therefore more similar to phyloP (with --wig-scores or --base-by-base) than to phastCons, which attempts to model multibase elements. In simulation experiments, phyloP and GERP seem to have very similar power to distinguish neutral and conserved bases, but phyloP does have some additional features that may be of interest. For example, it supports the detection of lineage-specific conservation or acceleration, it can use several different substitution models, and it can be used to score features of length >1 base. PhastCons and DLESS take an alternative approach to the detection of (potentially lineage-specific) conservation — instead of scoring individual bases, they allow information to be pooled across sites and attempt to identify conserved elements using hidden Markov models. These methods may be of interest when the focus is on elements, rather than individual bases, or when the species set is small or branch lengths are short, so that there is relatively little information at individual sites.

**How do I do X with program Y?**

Most of the programs in the package have fairly detailed help pages, with examples. The help pages are available from these web pages (follow links in left panel) or by running each program with the --help (-h) option. If they do not contain the information you need, please send email to the phast help mailing list.

**Is PHAST freely available? Am I allowed to reuse and/or redistribute the source code?**

Yes. PHAST has always been freely available to academics, but it is now officially [open source](http://www.opensource.org/docs/osd) and available under the terms of a [BSD-style license](http://compgen.cshl.edu/phast/LICENSE.txt).

**Which program in PHAST should I use for conservation scoring?**

Both phastCons and phyloP (with --wig-scores or --base-by-base) can be used to produce conservation scores, and which one is best depends on the application. The most important difference between these two programs is that the scores produced by phyloP reflect individual alignment columns, and do not take into account conservation at neighboring sites. This is why the phyloP conservation plot in the UCSC Browser has a less smooth appearance, with more "texture" at individual bases, than the phastCons plot. This property also makes phyloP more appropriate than phastCons for evaluating signatures of selection at particular bases or classes of bases in the genome (e.g., all third codon positions). In addition, phyloP requires fewer assumptions than phastCons, by depending only on a model of neutral evolution, rather than on models of both neutral evolution and negative selection (conservation). On the other hand, because it directly models multibase elements, phastCons may be preferred as a conserved element detector. Its ability to pool information across sites can also be valuable in cases of few species or short branch lengths, where there may be insufficient data to detect selection separately at each site.

**What exactly is {SS, \*.mod} format?**

SS is a format used by PHAST to describe a multiple alignment in terms of its "sufficient statistics" for phylogenetic analysis — i.e., its distinct alignment columns and their counts, and optionally, the order in which the columns appear (which is typically needed for functional element identification but not for phylogenetic analysis). A \*.mod file defines the parameters of a probalistic phylogenetic model, including a tree and branch lengths, a substitution rate matrix, and a background distribution over bases. Detailed specifications of these file formats will be made available as the PHAST documentation is improved. In the meantime, examples of SS and \*.mod files can be obtained by converting or generating files with msa\_view or phyloFit, respectively. Example \*.cm files are included in the phast/data/exoniphy directory.

#### **PHAST is funded by NIH Grant R35 GM127070-01**

![](http://siepellab.labsites.cshl.edu/wp-content/uploads/sites/40/SiepelLab1.png)

 **Last modified:** February 25 2025