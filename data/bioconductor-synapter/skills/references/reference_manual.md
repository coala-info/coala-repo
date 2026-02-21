Package ‘synapter’

April 12, 2018

Type Package

Title Label-free data analysis pipeline for optimal identiﬁcation and

quantitation

Version 2.2.0

Author Laurent Gatto, Nick J. Bond, Pavel V. Shliaha and

Sebastian Gibb.

Maintainer Laurent Gatto <lg390@cam.ac.uk> and

Sebastian Gibb <mail@sebastiangibb.de>

Depends R (>= 3.1.0), methods, MSnbase (>= 2.1.2)

Imports RColorBrewer, lattice, qvalue, multtest, utils, tools,

Biobase, knitr, Biostrings, cleaver (>= 1.3.3), readr (>= 0.2),
rmarkdown (>= 1.0)

Suggests synapterdata (>= 1.13.2), xtable, testthat (>= 0.8), BRAIN,

BiocStyle

Description The synapter package provides functionality to reanalyse
label-free proteomics data acquired on a Synapt G2 mass
spectrometer. One or several runs, possibly processed with
additional ion mobility separation to increase identiﬁcation
accuracy can be combined to other quantitation ﬁles to
maximise identiﬁcation and quantitation accuracy.

License GPL-2

URL https://lgatto.github.io/synapter/
VignetteBuilder knitr

biocViews MassSpectrometry, Proteomics, QualityControl

RoxygenNote 6.0.1

NeedsCompilation no

R topics documented:

.

.

.

.

synapter-package .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
createUniquePeptideDbRds . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
estimateMasterFdr
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
inspectPeptideScores .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
makeMaster .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
MasterFdrResults-class .

.
.
.
.

.
.
.
.

.

.

.

.

.

2
3
4
5
5
8

1

2

synapter-package

.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
.
MasterPeptides-class .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
plotFragmentMatching .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
requantify,MSnSet-method .
rescaleForTop3,MSnSet,MSnSet-method . . . . . . . . . . . . . . . . . . . . . . . . . 12
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
Synapter .
.
synapterGuide .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
synapterPlgsAgreement,MSnSet-method . . . . . . . . . . . . . . . . . . . . . . . . . . 25
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
synapterTinyData .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
synergise
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
.
synergise2 .

.
.
.

.
.
.

.
.
.

.
.
.

.
.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.
.

.

.

Index

34

synapter-package

Combine label-free data for optimal identiﬁcation and quantitation

Description

The synapter package provides functionality to reanalyse label-free proteomics data acquired on
a Synapt G2 mass spectrometer. One or several runs, possibly processed with additional ion mo-
bility separation to increase identiﬁcation accuracy can be combined to other quantitation ﬁles to
maximise identiﬁcation and quantitation accuracy.

Details

Two pipelines of variying ﬂexibility are proposed the preform data analysis: (1) the synergise1
and synergise2 function are single entry functions for a complete analysis and (2) low level, step-
by-step data processing can be achieved as described in ?Synapter.

A high-level overview of the package and how to operate it can be found in the vignette, access-
inble with synapterGuide(). Detailed information about the data processing can be found in the
respective function and class manual pages appropriately referenced in the vignette.

For questions, use the Biocondcutor mailing list or contact the author. The vignette has a section
with details on where/how to get help.

Author(s)

Laurent Gatto, Pavel V. Shliaha, Nick J. Bond and Sebastian Gibb

Maintainer: Laurent Gatto <lg390@cam.ac.uk> and Sebastian Gibb <mail@sebastiangibb.de>

References

Improving qualitative and quantitative performance for MSE-based label free proteomics, N.J.
Bond, P.V. Shliaha, K.S. Lilley and L. Gatto, J Proteome Res. 2013 Jun 7;12(6):2340-53. doi:
10.1021/pr300776t. PubMed PMID: 23510225.

The Effects of Travelling Wave Ion Mobility Separation on Data Independent Acquisition in Pro-
teomics Studies, P.V. Shliaha, N.J. Bond, L. Gatto and K.S. Lilley, J Proteome Res. 2013 Jun
7;12(6):2323-39. doi: 10.1021/pr300775k. PMID: 23514362.

createUniquePeptideDbRds

3

createUniquePeptideDbRds

Create an RDS ﬁle for the ’Unique Peptides Database’

Description

This function creates an RDS ﬁle to store the “Unique Peptides Database” for future runs of
synergise or Synapter.

Usage

createUniquePeptideDbRds(fastaFile, outputFile = paste0(fastaFile, ".rds"),

missedCleavages = 0, IisL = FALSE, verbose = interactive())

Arguments

fastaFile

outputFile

missedCleavages

ﬁle path of the input fasta ﬁle

ﬁle path of the target RDS ﬁle; must have the ﬁle extension ".rds"

Number of maximal allowed missed cleavages. Default is 0.

IisL

If TRUE Isoleucin and Leucin are treated as identical. In this case sequences like
"ABCI", "ABCL" are removed because they are not unqiue. If FALSE (default)
"ABCI" and "ABCL" are reported as unique.

verbose

If TRUE a verbose output is provied.

Author(s)

Sebastian Gibb <mail@sebastiangibb.de>

See Also

Synapter for details about the cleavage procedure.

Examples

## Not run:
createUniquePeptideDbRds("uniprot.fasta", "uniprot.fasta.rds")

## End(Not run)

4

estimateMasterFdr

estimateMasterFdr

Computes FDR for all possible ﬁnal peptide combinations

Description

This function takes all possible combination of pepfiles of length greater or equal than 2 and
computes the number of estimated incorrect peptides, the number of unique peptides, the number
of unique protetypic peptides and the false discovery rate after merging for each combination. The
best combination has an fdr lower than masterFdr and the highest number of unique (proteotypic)
peptides.

Usage

estimateMasterFdr(pepfiles, fastafile, masterFdr = 0.025, fdr = 0.01,

proteotypic = TRUE, missedCleavages = 0, IisL = FALSE,
maxFileComb = length(pepfiles), verbose = interactive())

Arguments

pepfiles

fastafile

masterFdr

fdr

proteotypic

missedCleavages

IisL

maxFileComb

A list of vector of ﬁnal peptide ﬁlenames.
A character with the fasta ﬁlename.
A numeric indicating the maximum merged false discovery to be allowed.

Peptide FDR level for individual peptide ﬁles ﬁltering.

Logical. Should number proteotypic peptides be used to choose best combina-
tion and plot results or total number of unique peptides.

Number of maximal missed cleavage sites. Default is 0.
If TRUE Isoleucin and Leucin are treated as identical. In this case sequences like
"ABCI", "ABCL" are removed because they are not unqiue. If FALSE (default)
"ABCI" and "ABCL" are reported as unique.
A numeric to limit the accepted ﬁle combinations to reduce computation time.
Default is length(pepfiles) meaning no limit set.

verbose

Should progress messages be printed?

Details

The false discovery rate for the master (merged) ﬁle is calcualted by summing the number of esti-
mated false discoveries for each individual ﬁnal peptide ﬁle (number of unique peptides in that ﬁle
multiplied by fdr) divided by the total number of unique peptides for that speciﬁc combination.
The function returns an instance of the class "MasterFdrResults".

Value

An instance of class "MasterFdrResults". See details above.

Author(s)

Laurent Gatto

inspectPeptideScores

References

5

Bond N. J., Shliaha P.V., Lilley K.S. and Gatto L., (2013) J. Prot. Research.

See Also

The makeMaster function to combine the peptide data as suggested by estimateMasterFdr into
one single master peptide ﬁle.
The vignette, accessible with synapterGuide() illustrates a complete pipeline using estimateMasterFdr
and makeMaster.

inspectPeptideScores

Inspect peptide scores.

Description

This function takes a ﬁnal peptide ﬁle and returns information about the unique peptide scores
and their number in each peptide matchType (PepFrag1 and PepFrag2) by protein dataBaseType
(Random and Regular) category. The function is a lightweight verion of getPepNumbers and
plotPepScores (to be used with Synapter instances) for individual ﬁles.

Usage

inspectPeptideScores(filename)

Arguments

filename

Value

The name of a ﬁnal peptide ﬁle.

A table of peptide counts in each peptide matchType * protein dataBasteType category. Also plots
the distribution of respective peptide scores.

Author(s)

Laurent Gatto

makeMaster

Merges ﬁnal peptide ﬁles

Description

This function combines a list of peptide ﬁnal peptide ﬁles into one single master ﬁle that is obtained
by merging the unique peptides from the ﬁltered original peptide ﬁles.
Additionally it can combine multiple ﬁnal fragment ﬁles into a fragment library.

6

Usage

makeMaster

makeMaster(pepfiles, fragmentfiles, fdr = 0.01, method = c("BH",

"Bonferroni", "qval"), span.rt = 0.05, span.int = 0.05,
maxDeltaRt = Inf, removeNeutralLoss = TRUE, removePrecursor = TRUE,
tolerance = 2.5e-05, verbose = interactive())

Arguments

fdr

method

pepfiles
A character vector of ﬁnal peptide ﬁle names to be merged.
fragmentfiles A character vector of ﬁnal fragment ﬁle names to be combined into an frag-
ment library. These ﬁles should be from the same runs as the ﬁnal peptide ﬁles
used in pepfiles.
A numeric indicating the peptide false discovery rate limit.
A character indicating the p-value adjustment to be used. One of BH (default),
Bonferroni or qval.
A numeric with the loess span parameter value to be used for retention time
modelling.
A numeric with the loess span parameter value to be used for intensity mod-
elling.
A double value that sets a maximum limit for the retention time deviaton be-
tween master and slave run to be included

maxDeltaRt

span.int

span.rt

removeNeutralLoss

A logical, if TRUE peptides with neutral loss are removed from the fragment
library.

A logical, if TRUE precursor ions are removed from the fragment spectra.
A double value that determines the tolerance used to look for the precursor ions.
A logical indicating if information should be printed out.

removePrecursor

tolerance

verbose

Details

The merging process is as follows:

1. Each individual peptide ﬁnal peptide ﬁle is ﬁltered to retain (i) non-duplicated unique tryptic
peptides, (ii) peptides with a false discovery rate <= fdr and (iii) proteins with a false positive
rate <= fpr.

2. The ﬁltered peptide ﬁles are ordered (1) according to their total number of peptides (for ex-
ample [P1, P2, P3]) and (2) as before with the ﬁrst item is positioned last ([P2, P3, P1] in the
previous example). The peptide data are then combined in pairs in these respective orders.
The ﬁrst one is called the master ﬁle.

3. For each (master, slave) pair, the slave peptide ﬁle retention times are modelled according to
the (original) master’s retention times and slave peptides, not yet present in the master ﬁle are
added to the master ﬁle.

4. The ﬁnal master datasets, containing their own peptides and the respective slave speciﬁc re-

tention time adjusted peptides are returned as a MasterPeptides instance.

The resulting MasterPeptides instance can be further used for a complete master vs. peptides/Pep3D
analysis, as described in Synapter, synergise or using the GUI (synapterGUI). To do so, it must
be serialised (using the saveRDS function) with a .rds ﬁle extension, to be recognised (and loaded)
as a R object.

makeMaster

7

When several quantitation (or identiﬁcation) ﬁles are combined as a master set to be mapped back
against the inidividual ﬁnal peptide ﬁles, the second master [P2, P3, P1] is used when analysing the
peptide data that was ﬁrst selected in the master generation (P1 above). This is to avoid aligning
two identical sets of peptides (those of P1) and thus not being able to generate a valid retention time
model. This is detected automatically for the user.

The two master peptides dataframes can be exported to disk as two csv ﬁles with writeMasterPeptides.
The MasterPeptides object returned by makeMaster can be saved to disk (with save or saveRDS)
and later reloaded (with load or readRDS) for further analysis.

The fragment library generation works as follows:

1. Each individual ﬁnal fragment ﬁle is imported and only peptides present in the master dataset

are used.

2. The fragments are combined based on their precursor ions.

3. The intensities of identical fragments (seen in different runs) is summed and divided by the

summed precursor intensity (of the same peptide in different runs).

4. Afterwards the intensities are normalized to the average precursor intensity of the different

runs.

5. Finally a MSnExp object is created.

The fragment library dataframe can be exported to disk as csv ﬁle with writeFragmentLibrary.

Value

An instance of class "MasterPeptides".

Author(s)

Laurent Gatto, Sebastian Gibb

References

Shliaha P.V., Bond N. J., Lilley K.S. and Gatto L., in prep.

See Also

See the Synapter class manual page for detailed information on ﬁltering and modelling and the
general algorithm implemented in the synapter package.

The estimateMasterFdr function allows to control false dicovery rate when combining several
peptide ﬁles while maximising the number of identiﬁcations and suggest which combination of
peptide ﬁles to use.

The vignette, accessible with synapterGuide() illustrates a complete pipeline using estimateMasterFdr
and makeMaster.

8

MasterFdrResults-class

MasterFdrResults-class

Class "MasterFdrResults"

Description

This class stored the results of the

Objects from the Class

Objects are created with the estimateMasterFdr function.

Slots

all: Object of class "data.frame" with results of all possible combinations.
files: Object of class "character" with ﬁle names used in combinations.
best: Object of class "data.frame" with results of the best combination.
masterFdr: Object of class "numeric" storing the best combination.

Methods

bestComb signature(object = "MasterFdrResults"): ...
allComb signature(object = "MasterFdrResults"): ...
ﬁleNames signature(object = "MasterFdrResults"): ...
masterFdr signature(object = "MasterFdrResults"): ...
plot signature(x = "MasterFdrResults", y = "missing"): ...
show signature(object = "MasterFdrResults"): ...

Author(s)

Laurent Gatto <lg390@cam.ac.uk>

References

Improving qualitative and quantitative performance for MSE-based label free proteomics, N.J.
Bond, P.V. Shliaha, K.S. Lilley and L. Gatto, Journal of Proteome Research, 2013, in press.

The Effects of Travelling Wave Ion Mobility Separation on Data Independent Acquisition in Pro-
teomics Studies, P.V. Shliaha, N.J. Bond, L. Gatto and K.S. Lilley, Journal of Proteome Research,
2013, in press.

Examples

## Not run:
library(synapterdata)
loadMaster()
class(master)
master

## End(Not run)

MasterPeptides-class

9

MasterPeptides-class

Class "MasterPeptides"

Description

A class to store the results of makeMaster. This class stored the 2 versions (orders) of the master
ﬁnal peptide data.

Objects from the Class

Objects can be created by calls of the form makeMaster.

Slots

masters: Object of class "list" storing the 2 master data.frame objects.

pepfiles: Object of class "character" with the list of ﬁnal peptide input ﬁles.

fdr: Object of class "numeric" with the peptide false discovery applied when creating the ﬁlter.

method: Object of class "character" with the peptide p-value adjustment method. One of BH

(default), qval or Bonferroni.

orders: Object of class "list" with the numeric vectors specifying the order of pepfiles used

to generate the respective masters data.frames.

fragmentfiles: Object of class "character" with the list of ﬁnal fragment input ﬁles.

fragments: Object of class data.frame storing the combined ﬁnal fragment data.

fragmentlibrary: Object of class "MSnExp" storing the fragment library.

Methods

show signature(object = "MasterPeptides"): to print a textual representation of the instance.

Author(s)

Laurent Gatto

References

Improving qualitative and quantitative performance for MSE-based label free proteomics, N.J.
Bond, P.V. Shliaha, K.S. Lilley and L. Gatto, Journal of Proteome Research, 2013, in press.

The Effects of Travelling Wave Ion Mobility Separation on Data Independent Acquisition in Pro-
teomics Studies, P.V. Shliaha, N.J. Bond, L. Gatto and K.S. Lilley, Journal of Proteome Research,
2013, in press.

10

requantify,MSnSet-method

plotFragmentMatching

Plot fragment matching results.

Description

This method plots the results of the fragment matching procedure (fragmentMatching). A single
plot contains two panels. The upper panel shows the identiﬁcation fragments and the lower one the
MS2 spectrum of the quantitation run. Common peaks are drawn in a slightly darker colour and
with a point on the top.

Arguments

object

key

column

...

Methods

Object of class "Synapter" .
character, value to look for.
character, name of the column in which plotFragmentMatching looks for
key.
Further arguments passed to internal functions.

signature(object = "Synapter", key = "character", column = "character", verbose = "logical", ...)

Plots identiﬁcation fragments against quantitation spectra. The ... arguments are passed to
the internal functions. Currently legend.cex, fragment.cex, and most of the plot.default
arguments (like xlim, ylim, main, xlab, ylab, . . . ) are supported. legend.cex and fragment.cex
control the size of the legend and fragments labels (default: 0.5). Please see par for details
about cex. If verbose = TRUE a progress bar is shown.

Author(s)

Sebastian Gibb <mail@sebastiangibb.de>

See Also

fragmentMatching

requantify,MSnSet-method

Intensity requantiﬁcation

Description

This method tries to remove saturation effects from the intensity counts.

Usage

## S4 method for signature 'MSnSet'
requantify(object, saturationThreshold,
method=c("sum", "reference", "th.mean", "th.median",
"th.weighted.mean"), ...)

requantify,MSnSet-method

Arguments

object
saturationThreshold

An MSnSet object.

11

double, intensity of an ion (isotope of a given charge state) at which saturation
is starting to occur.
character, requantiﬁcation method, please see details section.
further arguments passed to internal functions. Currently onlyCommonIsotopes
for method="sum" and requantifyAll for method=c("th.mean", "th.median", "th.weighted.mean")
are supported.

method

...

Details

Currently requantify supports 3 (5) different requantiﬁcation methods.

"sum" is the simplest requantiﬁcation method. All ions of a peptide below the saturation thresh-
old are summed to get the new intensity. This method accept an additional argument, namely
onlyCommonIsotopes If onlyCommonIsotopes=TRUE (default) all ions that are not seen in all runs
are removed and only the common seen ions are summed. In contrast onlyCommonIsotopes=FALSE
sums all ions regardless they are present in all runs.

In "reference" the run that has the most unsaturated ions in common with all the other runs. If
there are more than one run, the most intense is used as reference. The other runs are corrected as
follows:

• Find common ions between current and the reference run.

• Divide the intensities of the common ions and calculate the mean of these quotients as a run

speciﬁc scaling factor.

• Multiply the unsaturated ions of the current run by the scaling factor and replace the saturated
ones by the product of the scaling factor and the intensities of their corresponding ions in the
reference run.

• Sum the rescaled ion intensities.

The "th.*" methods are nearly identical. All of them calculate the theoretical isotopic distribution
for the given sequence of the peptide. Subsequently the unsaturated ions are divided by their theo-
retical proportion and the mean/median/weighted.mean (proportions are used as weights) of these
intensities are calculated per charge state. The sum of the charge state values is used as requantiﬁed
intensity for this peptide.
If requantifyAll=FALSE (default) just peptides with at least one saturated ion are requantiﬁed (un-
saturated peptides are unaffected). If requantify=TRUE all peptides even these where all ions are
below saturationThreshold are requantiﬁed by their theoretical distribution.

Value

MSnSet where the assayData are requantiﬁed.

Author(s)

Sebastian Gibb <mail@sebastiangibb.de> and Pavel Shliaha

References

See discussion on github: https://github.com/lgatto/synapter/issues/39

rescaleForTop3,MSnSet,MSnSet-method

12

See Also

MSnSet documentation: MSnSet

rescaleForTop3,MSnSet,MSnSet-method

Rescale for TOP3

Description

This method rescales the intensity values of an MSnSet object to be suiteable for TOP3 quantiﬁca-
tion.

Usage

## S4 method for signature 'MSnSet,MSnSet'
rescaleForTop3(before, after, saturationThreshold,
onlyForSaturatedRuns=TRUE, ...)

Arguments

before

after
saturationThreshold

An MSnSet object before requantiﬁcation.
The same MSnSet object as before but after requantiﬁcation.

double, intensity of an ion (isotope of a given charge state) at which saturation
is starting to occur.

onlyForSaturatedRuns

logical, rescale just runs where at least one isotope is affected by saturation.
further arguments passed to internal functions. Currently ignored.

...

Details

If an MSnSet object was requantiﬁed using the method="sum" requantiﬁcation method (see requantify,MSnSet-method)
TOP3 is not valid anymore because the most abundant proteins are penalised by removing high in-
tensity isotopes.
To overcome this rescaleForTop3 takes the proportion isotope/sum(isotopes for each requan-
tiﬁed peptide and calculates a correction factor by comparing these proportions against the unsatu-
rated isotopes before requantiﬁcation. The new rescale intensity values of the isotopes are the mean
correction factor multiplied with the corrected intensity values (see https://github.com/lgatto/
synapter/issues/39#issuecomment-207987278 for the complete explanation/discussion).

Value

MSnSet where the assayData are requantiﬁed.

Author(s)

Sebastian Gibb <mail@sebastiangibb.de> and Pavel Shliaha

References

See discussion on github: https://github.com/lgatto/synapter/issues/39

Synapter

See Also

13

MSnSet documentation: MSnSet https://github.com/lgatto/synapter/issues/39#issuecomment-207987278

Synapter

Class "Synapter"

Description

A reference class to store, manage and process Synapt G2 data to combine identiﬁcation and quan-
titation results.

The data, intermediate and ﬁnal results are stored together in such a ad-how container called a
class. In the frame of the analysis of a set of 3 or 5 data ﬁles, namely as identiﬁcation peptide, a
quantitation peptide and a quantitation Pep3D, and identiﬁcation fragments and quantitation spectra,
such a container is created and populated, updated according to the user’s instructions and used to
display and export results.
The functionality of the synapter package implemented in the Synapter class in described in
the Details section below. Documentation for the individual methods is provided in the Methods
section. Finally, a complete example of an analysis is provided in the Examples section, at the end
of this document.

See also papers by Shliaha et al.
describing the synapter methodology.

for details about ion mobility separation and the manuscript

Usage

Synapter(filenames, master) ## creates an instance of class 'Synapter'

Arguments

filenames

master

Details

A named list of ﬁle names to be load. The names must be ’identpeptide’,
’quantpeptide’, ’quantpep3d’ and ’fasta’ (could be an RDS ﬁle created by link{createUniquePeptideDbRds})
and (optional ’identfragments’ and ’quantspectra’). identpeptide can be a
csv ﬁnal peptide ﬁle (from PLGS) or a saved "MasterPeptides" data object
as created by makeMaster if working with master peptide data. To serialise
the "MasterPeptides" instance, use the saveRDS function, and ﬁle extenstion
rds. This master ﬁle could contain a fragment library as well. In this case the
’identfragments’ argument would be ignored.
A logical that deﬁnes if the identiﬁcation ﬁle is a master ﬁle. See makeMaster
for details about this strategy.

A Synapter object logs every operation that is applied to it. When displayed with show or when
the name of the instance is typed at the R console, the original input ﬁle names, all operations and
resulting the size of the respective data are displayed. This allows the user to trace the effect of
respective operations.

Loading the data: The construction of the data and analysis container, technically deﬁned as
an instance or object of class Synapter, is created with the Synapter constructor. This func-
tion requires 4 or 6 ﬁles as input, namely, the identiﬁcation ﬁnal peptide csv ﬁle, the quanti-
tation ﬁnal peptide csv ﬁle, the quantitation Pep3D csv ﬁle (as exported from the PLGS soft-
ware), the fasta ﬁle use for peptide identiﬁcation, and optional the identiﬁcation fragments csv

14

Synapter

ﬁle and the quantitation spectra xml ﬁle. The fasta ﬁle (’fasta’) could be an RDS ﬁle gen-
erated by link{createUniquePeptideDbRds}, too. The ﬁle names need to be speciﬁed as
a named list with names ’identpeptide’, ’quantpeptide’, ’quantpep3d’, ’fasta’, ’identfragments’
and ’quantspectra’ respectively. These ﬁles are read and the data is stored in the newly created
Synapter instance.
The ﬁnal peptide ﬁles are ﬁltered to retain peptides with matchType corresponding to PepFrag1
and PepFrag2, corresponding to unmodiﬁed round 1 and 2 peptide identiﬁcation. Other types,
like NeutralLoss_NH3, NeutralLoss_H20, InSource, MissedCleavage or VarMod are not con-
sidered in the rest of the analysis. The quantitation Pep3D data is ﬁltered to retain Function equal
to 1 and unique quantitation spectrum ids, i.e. unique entries for multiple charge states or isotopes
of an EMRT (exact mass-retention time features).
Then, p-values for Regular peptides are computed based on the Regular and Random database
types score distributions, as described in Käll et al., 2008a. Only unique peptide sequences are
taken into account: in case of duplicated peptides, only one entry is kept. Empirical p-values
are adjusted using Bonferroni and Benjamini and Hochberg, 1995 (multtest package) and q-
values are computed using the qvalue package (Storey JD and Tibshirani R., 2003 and Käll et al.,
2008b ). Only Regular entries are stored in the resulting data for subsequent analysis.
The data tables can be exported as csv spreadsheets with the writeIdentPeptides and writeQuantPeptides
methods.

Filtering identiﬁcation and quantitation peptide: The ﬁrst step of the analysis aims to match
reliable peptide. The ﬁnal peptide datasets are ﬁltered based on the FDR (BH is default) us-
ing the filterQuantPepScore and filterIdentPepScore methods. Several plots are provided
to illustrate peptide score densities (from which p-values are estimated, plotPepScores; use
getPepNumbers to see how many peptides were available) and q-values (plotFdr).
Peptides matching to multiple proteins in the fasta ﬁle (non-unique tryptic identiﬁcation and quan-
titation peptides) can be discarded with the filterUniqueDbPeptides method. One can also
ﬁlter on the peptide length using filterPeptideLength.
Another ﬁltering criterion is mass accuracy. Error tolerance quantiles (in ppm, parts per million)
can be visualised with the plotPpmError method. The values can be retrieved with getPpmErrorQs.
Filtering is then done separately for identiﬁcation and quantitation peptide data using filterIdentPpmError
and filterQuantPpmError respectively. The previous plotting functions can be used again to vi-
sualise the resulting distribution.
Filtering can also be performed at the level of protein false positive rate, as computed by the
PLGS application (protein.falsePositiveRate column), which counts the percentage of de-
coy proteins that have been identiﬁed prior to the regular protein of interest. This can be done
with the filterIdentProtFpr and filterQuantProtFpr methods. Note that this ﬁeld is erro-
neously called a false positive rate in the PLGS software and the associated manuscript; it is a
false discovery rate.

Merging identiﬁcation and quantitation peptides: Common and reliable identiﬁcation and
quantitation peptides are then matched based on their sequences and merged using the mergePeptides
method.

Retention time modelling: Systematic differences between identiﬁcation features and quanti-
tation features retention times are modelled by ﬁtting a local regression (see the loess function
for details), using the modelRt method. The smoothing parameter, or number of neighbour data
points used the for local ﬁt, is controlled by the span parameter that can be set in the above
method.
The effect of this parameter can be observed with the plotRt method, specifying what = "data"
as parameters. The resulting model can then be visualised with the above method specifying
what = "model", specifying up to 3 number of standard deviations to plot. A histogram of
retention time differences can be produced with the plotRtDiffs method.

Synapter

15

To visualise the feature space plotFeatures could be used. It generates one or two (if ion mo-
bility is available) plots of retention time vs mass and mass vs ion mobility for each data source,
namely, Identiﬁcation data, Quantitation data and Quantitation Pep3D data.

Intensity modelling: Systematic differences between intensities of identiﬁcation features and
quantitation features depending on retention times are modelled by ﬁtting a local regression (see
the loess function for details), using the modelIntensity method. The smoothing parameter, or
number of neighbour data points used the for local ﬁt, is controlled by the span parameter that
can be set in the above method.
The effect of this parameter can be observed with the plotIntensity method, specifying what = "data"
as parameters. The resulting model can then be visualised with the above method specifying
what = "model", specifying up to 3 number of standard deviations to plot.

Grid search to optimise matching tolerances: Matching of identiﬁcation peptides and quantita-
tion EMRTs is done within a mass tolerance in parts per million (ppm) and the modelled retention
time +/- a certain number of standard deviations. To help in the choice of these two parameters,
a grid search over a set of possible values is performed and performance metrics are recorded, to
guide in the selection of a ’best’ pair of parameters.
The following metrics are computed: (1) the percentage of identiﬁcation peptides that matched
a single quantitation EMRT (called prcntTotal), (2) the percentage of identiﬁcation peptides
used in the retention time model that matched the quantitation EMRT corresponding to the cor-
rect quantitation peptide in ident/quant pair of the model (called prcntModel) and (3) the detailed
about the matching of the features used for modelling (accessible with getGridDetails) and
the corresponding details grid that reports the percentage of correct unique assignments. The
detailed grid results specify the number of non matched identiﬁcation peptides (0), the number
of correctly (1) or wrongly (-1) uniquely matched identiﬁcation peptides, the number of iden-
tiﬁcation peptides that matched 2 or more peptides including (2+) or excluding (2-) the correct
quantitation equivalent are also available.
See the next section for additional details about how matching. The search is performed with the
searchGrid method, possibly on a subset of the data (see Methods and Examples sections for
further details).
The parameters used for matching can be set manually with setPpmError, setRtNsd, setImDiff
respectively, or using setBestGridParams to apply best parameters as deﬁned using the grid
search. See example and method documentation for details.

Identiﬁcation transfer: matching identiﬁcation peptides and quantitation EMRTs: The
identiﬁcation peptide - quantitation EMRT matching, termed identiﬁcation transfer, is performed
using the best parameters, as deﬁned above with a grid search, or using user-deﬁned parameters.
Matching is considered successful when one and only one EMRT is found in the mass toler-
ance/retention time/ion mobility window deﬁned by the error ppm, number of retention time stan-
dard deviations, and ion mobility difference parameters. The values of uniquely matched EMRTs
are reported in the ﬁnal matched dataframe that can be exported (see below). If however, none or
more than one EMRTs are matched, 0 or the number of matches are reported.
As identiﬁcation peptides are serially individually matched to ’close’ EMRTs, it is possible for
peptides to be matched the same EMRT independently. Such cases are reported as -1 in the results
dataframes.
The results can be assess using the plotEMRTtable (or getEMRTtable to retrieve the values) and
performace methods. The former shows the number of identiﬁcation peptides assigned to none
(0), exactly 1 (1) or more (> 2) EMRTs. The latter method reports matched identiﬁcation peptides,
the number of (q-value and protein FPR ﬁltered) identiﬁcation and quantitation peptides. Matched
EMRT and quantitation peptide numbers are then compared calculating the synapter enrichment
(100 * ( synapter - quant ) / quant) and Venn counts.

16

Synapter

Remove Less Intense Peaks: As an additional step it is possible to remove less intense peaks
from the spectra and fragment data. Use plotCumulativeNumberOfFragments to plot the num-
ber of fragments vs the intensity and to ﬁnd a good threshold. The filterFragments method
could remove peaks if the intensity is below a speciﬁed threshold via the minIntensity argu-
ment. Set the maxNumber argument to keep only the maxNumber highest peaks/fragments. The
what argument controls the data on which the ﬁlter is applied. Use what = "fragments.ident"
for the identiﬁcation fragments and what = "spectra.quant" for the quantiation spectra data.

Fragment Matching: After importing fragment and spectra data it is possible to match peaks
between the identiﬁcation fragments and the quantitation spectra using the fragmentMatching
method. Use setFragmentMatchingPpmTolerance to set the maximal allowed tolerance for
considering a peak as identical. There are two different methods to visualise the results of the frag-
ment matching procedure. plotFragmentMatching plots the fragments and spectra for each con-
sidered pair. plotFragmentMatchingPerformance draws two plots. On the left panel you could
see the performance of different thresholds for the number of common peaks for unique matches.
The right panel visualizes the performance of different differences (delta) of common peaks be-
tween the best match (highest number of common peaks) and the second best match in each non
unique match group. plotFragmentMatchingPerformance returns the corresponding values in-
visible or use fragmentMatchingPerformance to access these data. Use filterUniqueMatches
and filterNonUniqueMatches to remove unique or non unique matches below the threshold of
common peaks respective the difference in common peaks from the MatchedEMRTs data.frame.

Exporting and saving data: The merged identiﬁcation and quantitation peptides can be exported
to csv using the writeMergedPeptides method. Similarly, the matched identiﬁcation peptides
and quantitation EMRTs are exported with writeMatchedEMRTs.
Complete Synapter instances can be serialised with save, as any R object, and reloaded with
load for further analysis.
It is possible to get the fragment and spectra data from the identiﬁcation and quantitation run using
getIdentificationFragments respectively getQuantitationSpectra.

Methods

Analysis methods:
mergePeptides signature(object = "Synapter"): Merges quantitation and identiﬁcation

ﬁnal peptide data, used to perform retention time modelling (see modelRt below).

modelRt signature(object = "Synapter",

span = "numeric"): Performs local polyno-
mial regression ﬁtting (see loess) retention time alignment using span parameter value to
control the degree of smoothing.

modelIntensity signature(object = "Synapter",

span = "numeric"): Performs local
polynomial regression ﬁtting (see loess) intensity values using span parameter value to
control the degree of smoothing.

ﬁndEMRTs signature(object = "Synapter", ppm =

"numeric", nsd = "numeric", imdiff = "numeric"):

Finds EMRTs matching identiﬁcation peptides using ppm mass tolerance, nsd number of re-
tention time standard deviations and imdiff difference in ion mobility. The last three pa-
rameters are optional if previously set with setPpmError, setRtNsd, setImDiff, or, better,
setBestGridParams (see below).

rescueEMRTs signature(object = "Synapter",

method = c("rescue", "copy")):
The method parameter deﬁned the behaviour for those high conﬁdence features that where
identiﬁed in both identiﬁcation and quantitation acquisitions and used for the retention time
model (see mergePeptides). Prior to version 1.1.1, these features were transferred from
the quantitation pep3d ﬁle if unique matches were found, as any feature ("transfer"). As a
result, those matching 0 or > 1 EMRTs were quantiﬁed as NA. The default is now to "rescue"

Synapter

17

the quantitation values of these by directly retrieving the data from the quantiﬁcation peptide
data. Alternatively, the quantitation values for these features can be directly taken from the
quantitation peptide data using "copy", thus effectively bypassing identiﬁcation transfer.

searchGrid signature(object="Synapter", ppms="numeric", nsds="numeric", imdiffs = "numeric",

Performs a grid search. The grid is deﬁned by the ppm, nsd and imdiffs numerical vectors,
representing the sequence of values to be tested. Default are seq(5, 20, 2), seq(0.5, 5, 0.5),
seq(0.2, 2, 0.2) respectively. To ignore ion mobility set imdiffs = Inf. subset and n
allow to use a randomly chosen subset of the data for the grid search to reduce search time.
subset is a numeric, between 0 and 1, describing the percentage of data to be used; n spec-
iﬁes the absolute number of feature to use. The default is to use all data. verbose controls
whether textual output should be printed to the console. (Note, the mergedEMRTs value used
in internal calls to findEMRTs is "transfer" - see findEMRTs for details).

subset="numeric", n = "numeric", verbose="logical"):

fragmentMatching signature(object="Synapter",

ppm = "numeric", verbose = "logical":

Performs a fragment matching between spectra and fragment data. The ppm argument con-
trols the tolerance that is used to consider two peaks (MZ values) as identical. If verbose is
TRUE (default) a progress bar is shown.

Methods to display, access and set data:
show signature(object = "Synapter"): Display object by printing a summary to the

console.

dim signature(x="Synapter"): Returns a list of dimensions for the identiﬁcation peptide,

quantitation peptide, merged peptides and matched features data sets.

inputFiles signature(object="Synapter"): Returns a character of length 6 with the names

of the input ﬁles used as identpeptide, quantpeptide, quantpep3d, fasta, identfragments
and quantspectra.

getLog signature(object="Synapter"): Returns a character of variable length with a

summary of processing undergone by object.
getGrid signature(object="Synapter", digits =

"numeric"): Returns a named list
of length 3 with the precent of total (prcntTotal), percent of model (prcntModel) and
detailed (details) grid search results. The details grid search reports the proportion of
correctly assigned features (+1) to all unique assignments (+1 and -1). Values are rounded
to 3 digits by default.

getGridDetails signature(object="Synapter"): Returns a list of number of ..., -2, -1, 0,

+1, +2, ... results found for each of the ppm/nsd pairs tested during the grid search.

getBestGridValue signature(object="Synapter"): Returns a named numeric of length 3
with best grid values for the 3 searches. Names are prcntTotal, prcntModel and details.
getBestGridParams signature(object="Synapter"): Returns a named list of matrices
(prcntTotal, prcntModel and details). Each matrix gives the ppm and nsd pairs that
yielded the best grid values (see getBestGridValue above).

setBestGridParams signature(object="Synapter", what="character"): This methods
set the best parameter pair, as determined by what. Possible values are auto (default),
model, total and details. The 3 last ones use the (ﬁrst) best parameter values as reported
by getBestGridParams. auto uses the best model parameters and, if several best pairs
exists, the one that maximises details is selected.
setPepScoreFdr signature(object="Synapter", fdr =

"numeric"): Sets the peptide
score false discovery rate (default is 0.01) threshold used by filterQuantPepScore and
filterIdentPepScore.

getPepScoreFdr signature(object="Synapter"): Returns the peptide false discrovery rate

threshold.

setIdentPpmError signature(object="Synapter", ppm =

ﬁcation mass tolerance to ppm (default 10).

"numeric"): Set the identi-

18

Synapter

getIdentPpmError signature(object="Synapter"): Returns the identiﬁcation mass toler-

ance.

setQuantPpmError signature(object="Synapter", ppm =

titation mass tolerance to ppm (default 10).

"numeric"): Set the quan-

getQuantPpmError signature(object="Synapter"): Returns the quantitation mass toler-

ance.

setPpmError signature(object="Synapter", ppm =

tion and quantitation mass tolerance ppm (default is 10).
setLowessSpan signature(object="Synapter", span =

span parameter; default is 0.05.

"numeric"): Sets the identiﬁca-

"numeric"): Sets the loess

getLowessSpan signature(object="Synapter"): Returns the span parameter value.
setRtNsd signature(object="Synapter", nsd =

"numeric"): Sets the retention time

tolerance nsd, default is 2.

getRtNsd signature(object="Synapter"): Returns the value of the retention time tolerance

nsd.

setImDiff signature(object="Synapter", imdiff =

tolerance imdiff, default is 0.5.

"numeric"): Sets the ion mobility

getImDiff signature(object="Synapter"): Returns the value of the ion mobility tolerance

imdiff.

getPpmErrorQs signature(object="Synapter", qs =

"numeric", digits = "numeric"):
Returns the mass tolerance qs quantiles (default is c(0.25, 0.5, 0.75, seq(0.9, 1, 0.01))
for the identiﬁcation and quantitation peptides. Default is 3 digits.

getRtQs signature(object="Synapter", qs =

"numeric", digits = "numeric"):

Returns the retention time tolerance qs quantiles (default is c(0.25, 0.5, 0.75, seq(0.9, 1, 0.01))
for the identiﬁcation and quantitation peptides. Default is 3 digits.

getPepNumbers signature(object="Synapter"): Returns the number of regular and ran-
dom quantitation and identiﬁcation peptide considered for p-value calculation and used to
plot the score densities (see plotPepScores). Especially the difference between random
and regular entries are informative in respect with the conﬁdence of the random scores dis-
tribution.

setFragmentMatchingPpmTolerance signature(object="Synapter",

Sets the fragment matching mass tolerance ppm (default is 25).

ppm = "numeric"):

getFragmentMatchingPpmTolerance signature(object="Synapter"): Returns the frag-

ment matching mass tolerance in ppm.

showFdrStats signature(object="Synapter", k =

"numeric"): Returns a named list
of length 2 with the proportion of identiﬁcation and quantitation peptides that are considered
signiﬁcant with a threshold of k (default is c(0.001, 0.01, 0.5, 0.1)) using raw and
adjusted p-values/q-values.

getEMRTtable signature(object="Synapter"): Returns a table with the number of 0, 1,

2, ... assigned EMRTs.

performance signatute(object="Synapter", verbose =
if verbose) the performance of the synapter analysis.
performance2 signatute(object="Synapter", verbose =

TRUE): Returns (and dis-
plays, if verbose) information about number of missing values and identiﬁcation source of
transfered EMRTs.

TRUE): Returns (and displays,

fragmentMatchingPerformance signature(object="Synapter",

what = c("unique", "non-unique"):

Returns the performance of the fragment matching for unqiue or non-unique matches.
The return valus is a matrix with seven columns. The ﬁrst column ncommon/deltacommon
contains the thresholds. Column 2 to 5 are the true positives tp, false positives fp, true
negatives tn, false negatives fn for the merged peptide data. The sixth column all shows

Synapter

19

the corresponding number of peptides for all peptides (not just the merged ones) and the
last column shows the FDR fdr for the current threshold (in that row) for the merged data.
Please note that the FDR is overﬁtted/underestimated because the merged peptides are the
peptides from the highest quality spectra were PLGS could easily identify the peptides. The
peptides that are not present in the merged data are often of lower quality hence the FDR
would be higher by trend.
See plotFragmentMatchingPerformance for a graphical representation.

Filters:
ﬁlterUniqueDbPeptides signature(object="Synapter",

missedCleavages = 0, IisL = TRUE, verbose = TRUE):

This method ﬁrst digests the fasta database ﬁle and keeps unique tryptic peptides. (NOTE:
since version 1.5.3, the tryptic digestion uses the cleaver package, replacing the more sim-
plistic inbuild function. The effect of this change is documented in https://github.com/lgatto/synapter/pull/47).
The number of maximal missed cleavages can be set as missedCleavages (default is 0).
If IisL = TRUE Isoleucin and Leucin are treated as the same aminoacid.
In this case
sequences like "ABCI", "ABCL" are removed because they are not unqiue anymore. If
IisL = FALSE (default) "ABCI" and "ABCL" are reported as unique. The peptide se-
quences are then used as a ﬁlter against the identiﬁcation and quantitation peptides, where
only unique proteotyptic instances (no miscleavage allowed by default) are eventually kept
in the object instance. This method also removes any additional duplicated peptides, that
would not match any peptides identiﬁed in the fasta database.
ﬁlterUniqueQuantDbPeptides signature(object="Synapter",
As filterUniqueDbPeptides for quantitation peptides only.
ﬁlterUniqueIdentDbPeptides signature(object="Synapter",
As filterUniqueDbPeptides for identiﬁcation peptides only.

missedCleavages = 0, IisL = TRUE, verbose = TRUE):

missedCleavages = 0, IisL = TRUE, verbose = TRUE):

ﬁlterQuantPepScore signature(object="Synapter", fdr

= "numeric", method = "character"):

Filters the quantitation peptides using fdr false discovery rate. fdr is missing by default
and is retrieved with getPepScoreFdr automatically. If not set, default value of 0.01 is
used. method deﬁnes how to performe p-value adjustment; one of BH, Bonferrone or qval.
See details section for more information.

ﬁlterIdentPepScore signature(object="Synapter", fdr
As filterQuantPepScore, but for identiﬁcation peptides.
ﬁlterQuantProtFpr signature(object="Synapter", fpr

= "numeric"): Filters quan-
titation peptides using the protein false positive rate (erroneously deﬁned as a FPR, should
be FDR), as reported by PLGS, using threshold set by fpr (missing by default) or retrieved
by getProtFpr.

= "numeric", method = "charactet"):

ﬁlterIdentProtFpr signature(object="Synapter", fpr =

"numeric"): as filterQuantProtFpr,

but for identiﬁcation peptides.

ﬁlterQuantPpmError signature(object="Synapter", ppm

= "numeric"): Filters
the quantitation peptides based on the mass tolerance ppm (default missing) provided or
retrieved automatically using getPpmError.

ﬁlterIdentPpmError signature(object="Synapter"): as filterQuantPpmError, but for

identiﬁcation peptides.

ﬁlterFragments signature(object = "Synapter",

what = c("fragments.ident", "spectra.quant"),

Filters the spectra/fragment data using a minimal intensity threshold (minIntensity) or a
maximal number of peaks/fragments threshold (maxNumber). Please note that the maximal
number is transfered to an intensity threshold and the result could contain less peaks than
speciﬁed by maxNumber. If both arguments are given, the more aggressive one is chosen.
Use the what argument to specify the data that should be ﬁltered. Set what = "fragments.ident"
for the identiﬁcation fragment data or what = "spectra.quant" for the quantiation spec-
tra. If verbose is TRUE (default) a progress bar is shown.

minIntensity = "numeric", maxNumber = "numeric", verbose = "logical"):

20

Synapter

ﬁlterUniqueMatches signature(object="Synapter", minNumber =

"numeric"):
Removes all unique matches that have less than minNumber of peaks/fragments in common.
Use fragmentMatchingPerformance(..., what="unique")/ plotFragmentMatchingPerformance
(left panel) to ﬁnd an ideal threshold.

ﬁlterNonUniqueMatches signature(object="Synapter", minDelta =

"numeric"):

Removes all non unique matches that have a difference between the best match (highest
number of common peaks/fragments, treated as true match) and the second best match
(second highest number of common peaks/fragments) less than minDelta. For the matches
above the threshold only the one with the highest number of common peaks/fragments in
each match group is kept. Use fragmentMatchingPerformance(..., what="non-unique")/
plotFragmentMatchingPerformance (right panel) to ﬁnd an ideal threshold.

ﬁlterNonUniqueIdentMatches signature(object="Synapter"): Removes all non unique

identiﬁcation matches. In rare circumstances (if the grid search parameters are to wide/relaxed
or a fragment library is used) it could happen that the searchGrid methods matches a sin-
gle quantiﬁcation EMRT to multiple identiﬁcation EMRTs. This methods removes all these
non unique matches.

Plotting:
plotPpmError signature(object="Synapter", what =

"character"): Plots the pro-
portion of data against the mass error tolerance in ppms. Depending on what, the data for
identiﬁcation (what = "Ident"), quantitation (what = "Quant") or "both" is plotted.
plotRtDiffs signature(object="Synapter", ...): Plots a histogram of retention time dif-

ferences after alignments. ... is passed to hist.

plotRt signature(object="Synapter", what =

"character", f = "numeric", nsd = "numeric"):

Plots the Identiﬁcation - Quantitation retention time difference as a function of the Identi-
ﬁcation retention time. If what is "data", two plots are generated: one ranging the full
range of retention time differences and one focusing on the highest data point density and
showing models with various span parameter values, as deﬁned by f (default is 2/3, 1/2,
1/4, 1/10, 1/16, 1/25, 1/50, passed as a numed numeric). If what is "model", a focused plot
with the applied span parameter is plotted and areas of nsd (default is x(1, 3, 5) number
of standard deviations are shaded around the model.
plotIntensity signature(object="Synapter", what =

"character", f = "numeric", nsd = "numeric"):

Plots the (log2) ratio of Identiﬁcation and Quantitation intensities as a function of the Iden-
tiﬁcation retention time. If what is "data", two plots are generated: one ranging the full
range of ratios and one focusing on the highest data point density and showing models with
various span parameter values, as deﬁned by f (default is 2/3, 1/2, 1/4, 1/10, 1/16, 1/25,
1/50, passed as a numed numeric). If what is "model", a focused plot with the applied span
parameter is plotted and areas of nsd (default is x(1, 3, 5) number of standard deviations
are shaded around the model.

plotPepScores signature(object="Synapter"): Plots the distribution of random and reg-
ular peptide scores for identiﬁcation and quantitation features. This reﬂects how peptide
p-values are computed. See also getPepNumbers.

plotFdr signature(object="Synapter", method = "character"): Displays 2 plots per
identiﬁcation and quantitation peptides, showing the number of signiﬁcant peptides as a
function of the FDR cut-off and the expected false number of false positive as a number of
signiﬁcant tests. PepFrag 1 and 2 peptides are illustrated on the same ﬁgures. These ﬁgures
are adapted from plot.qvalue. method, one of "BH", "Bonferroni" or "qval", deﬁnes
what identiﬁcation statistics to use.

plotEMRTtable signature(object="Synapter"): Plots the barchart of number or 0, 1, 2, ...

assigned EMRTs (see getEMRTtable) .

plotGrid signature(object="Synapter", what = "character"), maindim = "character":
Plots a heatmap of the respective grid search results. This grid to be plotted is controlled

Synapter

21

by what: "total", "model" or "details" are available. If ion mobility was used in the
grid search you can use maindim to decided which dimensions should be shown. maindim
could be one of "im" (default), "rt" and "mz". If maindim = "im" a heatmap for each ion
mobility threshold is drawn. For maindim = "rt" and maindim you get a heatmap for each
retention time respective mass threshold.

plotFeatures signature(object="Synapter", what = "character", xlim = "numeric", ylim = "numeric", ionmobiltiy = "logical"):

Plots the retention time against precursor mass space. If what is "all", three (six if ion mo-
bility is available and ionmobility = TRUE (default is FALSE); three additional plots with
precursor mass against ion mobility) such plots are created side by side: for the identiﬁca-
tion peptides, the quantitation peptides and the quantitation Pep3D data. If what is "some",
a subset of the rt/mass space can be deﬁned with xlim (default is c(40, 60)) and ylim
(default is c(1160, 1165)) and identiﬁcation peptide, quantitation peptides and EMRTs
are presented on the same graph as grey dots, blue dots and red crosses respectively. In
addition, rectangles based on the ppm and nsd deﬁned tolerances (see setPpmError and
setNsdError) are drawn and centered at the expected modelled retention time. This last
ﬁgure allows to visualise the EMRT matching.

plotFragmentMatching signature(object = "Synapter",

key = "character", column = "character",

Plots two spectra and fragments against each other. Please see plotFragmentMatching for
details.

plotFragmentMatchingPerformance signature(object = "Synapter",

showAllPeptides = FALSE):

Creates two plots. The left panel shows the performance of ﬁltering the unique matches of
the merged peptides using a different number of common peaks. The right panel shows
the performance of ﬁltering the non unique matches of the merged peptides using differ-
ent differences (delta) in common peaks/fragments. These differences (delta) are calcu-
lated between the match with the highest number of common peaks/fragments and the sec-
ond highest one. Use filterUniqueMatches and filterNonUniqueMatches to ﬁlter the
MatchedEMRT data.frame using one of these thresholds. This function returns a list with
two named elements (unqiue and nonunqiue invisibly. These are the same data as return
by fragmentMatchingPerformance.
Use showAllPeptides=TRUE to add a line for all peptides (not just the merged onces) to
both plots.

plotCumulativeNumberOfFragments signature(object = "Synapter",

what = c("fragments.ident", "spectra.quant")):

Plots the cumulative number of the fragments/peaks vs their intensity (log10 scaled). Use
the what argument to create this plot for the identiﬁcation fragments (what = "fragments.quant")
or the the quantitation spectra (what = "spectra.quant").

verbose = "logical", ...):

Exporters:
writeMergedPeptides signature(object="Synapter", file

= "character", what = "character", ...):

Exports the merged peptide data to a comma-separated file (default name is "Res-MergedPeptides.csv").

writeMatchedEMRTs signature(object="Synapter", file =

"character", ...):

As above, saving the matched EMRT table.

writeIdentPeptides signature(object="Synapter", file

= "character", ...): As

above, exporting the identiﬁcation peptide data.

writeQuantPeptides signature(object="Synapter", file

= "character", ...): A

above, exporting the quantitation peptide data.

getIdentiﬁcationFragments signature(object="Synapter"): returns the identiﬁcation frag-

ments as MSnExp.

getQuantitationSpectra signature(object="Synapter"): returns the quantitation spectra

as MSnExp.

Other:
as(, "MSnSet") signature(x = "Synapter"): Coerce object from Synapter to MSnSet

class.

22

Synapter

validObject signature(object = "Synapter"): Test whether a given Synapter object is

valid.

updateObject signature(object = "Synapter"): Updates an old Synapter object.

Author(s)

Laurent Gatto <lg390@cam.ac.uk>

References

Käll L, Storey JD, MacCoss MJ, Noble WS Posterior error probabilities and false discovery rates:
two sides of the same coin. J Proteome Res. 2008a Jan; 7:(1)40-4

Bonferroni single-step adjusted p-values for strong control of the FWER.

Benjamini Y. and Hochberg Y. Controlling the false discovery rate: a practical and powerful ap-
proach to multiple testing. J. R. Statist. Soc. B., 1995, Vol. 57: 289-300.

Storey JD and Tibshirani R. Statistical signiﬁcance for genome-wide experiments. Proceedings of
the National Academy of Sciences, 2003, 100: 9440-9445.

Käll, Storey JD, MacCoss MJ, Noble WS Assigning signiﬁcance to peptides identiﬁed by tandem
mass spectrometry using decoy databases. J Proteome Res. 2008b Jan; 7:(1)29-34

Improving qualitative and quantitative performance for MSE-based label free proteomics, N.J.
Bond, P.V. Shliaha, K.S. Lilley and L. Gatto, Journal of Proteome Research, 2013, in press.

The Effects of Travelling Wave Ion Mobility Separation on Data Independent Acquisition in Pro-
teomics Studies, P.V. Shliaha, N.J. Bond, L. Gatto and K.S. Lilley, Journal of Proteome Research,
2013, in press.

Trypsin cleavage:

Glatter, Timo, et al. Large-scale quantitative assessment of different in-solution protein digestion
protocols reveals superior cleavage efﬁciency of tandem Lys-C/trypsin proteolysis over trypsin di-
gestion. Journal of proteome research 11.11 (2012): 5145-5156. http://dx.doi.org/10.1021/
pr300273g

Rodriguez, Jesse, et al. Does trypsin cut before proline?. Journal of proteome research 7.01 (2007):
300-305. http://dx.doi.org/10.1021/pr0705035

Brownridge, Philip, and Robert J. Beynon. The importance of the digest: proteolysis and absolute
quantiﬁcation in proteomics. Methods 54.4 (2011): 351-360. http://dx.doi.org/10.1016/j.
ymeth.2011.05.005

cleaver’s rules are taken from: http://web.expasy.org/peptide_cutter/peptidecutter_enzymes.
html#Tryps

Examples

library(synapter) ## always needed

## Not run:
## (1) Construction - to create your own data objects
synapterTiny <- Synapter()

## End(Not run)

## let's use synapterTiny, shipped with the package
synapterTinyData() ## loads/prepares the data
synapterTiny ## show object

Synapter

23

## (2) Filtering
## (2.1) Peptide scores and FDR

## visualise/explore peptide id scores
plotPepScores(synapterTiny)
getPepNumbers(synapterTiny)

## filter data
filterUniqueDbPeptides(synapterTiny) ## keeps unique proteotypic peptides
filterPeptideLength(synapterTiny, l = 7) ## default length is 7

## visualise before FDR filtering
plotFdr(synapterTiny)

setPepScoreFdr(synapterTiny, fdr = 0.01) ## optional
filterQuantPepScore(synapterTiny, fdr = 0.01) ## specifying FDR
filterIdentPepScore(synapterTiny) ## FDR not specified, using previously set value

## (2.2) Mass tolerance
getPpmErrorQs(synapterTiny)
plotPpmError(synapterTiny, what="Ident")
plotPpmError(synapterTiny, what="Quant")

setIdentPpmError(synapterTiny, ppm = 20) ## optional
filterQuantPpmError(synapterTiny, ppm = 20)
## setQuantPpmError(synapterTiny, ppm = 20) ## set quant ppm threshold below
filterIdentPpmError(synapterTiny, ppm=20)

filterIdentProtFpr(synapterTiny, fpr = 0.01)
filterQuantProtFpr(synapterTiny, fpr = 0.01)

getPpmErrorQs(synapterTiny) ## to be compared with previous output

## (3) Merge peptide sequences
mergePeptides(synapterTiny)

## (4) Retention time modelling
plotRt(synapterTiny, what="data")
setLowessSpan(synapterTiny, 0.05)
modelRt(synapterTiny) ## the actual modelling
getRtQs(synapterTiny)
plotRtDiffs(synapterTiny)
## plotRtDiffs(synapterTiny, xlim=c(-1, 1), breaks=500) ## pass parameters to hist()
plotRt(synapterTiny, what="model") ## using default nsd 1, 3, 5
plotRt(synapterTiny, what="model", nsd=0.5) ## better focus on model

plotFeatures(synapterTiny, what="all")
setRtNsd(synapterTiny, 3)
setPpmError(synapterTiny, 10) ## if not set manually, default values are set automatically
plotFeatures(synapterTiny, what="some", xlim=c(36,44), ylim=c(1161.4, 1161.7))
## best plotting to svg for zooming

## RtNsd and PpmError are used for detailed plot

set.seed(1) ## only for reproducibility of this example

## (5) Grid search to optimise EMRT matching parameters
searchGrid(synapterTiny,

24

synapterGuide

ppms = 7:10, ## default values are 5, 7, ..., 20
nsds = 1:3,
subset = 0.2) ## default is 1

## default values are 0.5, 1,

..., 5

## alternatively, use 'n = 1000' to use exactly
## 1000 randomly selected features for the grid search
getGrid(synapterTiny) ## print the grid
getGridDetails(synapterTiny) ## grid details
plotGrid(synapterTiny, what = "total")
plotGrid(synapterTiny, what = "model")
plotGrid(synapterTiny, what = "details") ## plot the detail grid
getBestGridValue(synapterTiny) ## return best grid values
getBestGridParams(synapterTiny) ## return parameters corresponding to best values
setBestGridParams(synapterTiny, what = "auto") ## sets RtNsd and PpmError according the grid results
## 'what' could also be "model", "total" or "details"
## setPpmError(synapterTiny, 12) ## to manually set values
## setRtNsd(synapterTiny, 2.5)

## plot the grid for total matching
## plot the grid for matched modelled feature

## (6) Matching ident peptides and quant EMRTs
findEMRTs(synapterTiny)
plotEMRTtable(synapterTiny)
getEMRTtable(synapterTiny)
performance(synapterTiny)
performance2(synapterTiny)

## (7) Exporting data to csv spreadsheets
writeMergedPeptides(synapterTiny)
writeMergedPeptides(synapterTiny, file = "myresults.csv")
writeMatchedEMRTs(synapterTiny)
writeMatchedEMRTs(synapterTiny, file = "myresults2.csv")
## These will export the filter peptide data
writeIdentPeptides(synapterTiny, file = "myIdentPeptides.csv")
writeQuantPeptides(synapterTiny, file = "myQuantPeptides.csv")
## If used right after loading, the non-filted data will be exported

synapterGuide

Opens the ’synapter’ vignette

Description

Opens the relevant vignette; a shortcut to using vignette. synapterGuide() gives access to the
main overview vignette.

Usage

synapterGuide()

Author(s)

Laurent Gatto

synapterPlgsAgreement,MSnSet-method

25

synapterPlgsAgreement,MSnSet-method

Synapter/PLGS Agreement

Description

This method checks the agreement between synapter analysis and PLGS results.

Usage

## S4 method for signature 'MSnSet'
synapterPlgsAgreement(object, ...)

Arguments

object

...

Details

An MSnSet object.

further arguments, not used yet.

Each synapter object has synapterPlgsAgreement column in its MatchedEMRTs data.frame (see
writeMatchedEMRTs). After converting the synapter object into an MSnSet instance via as(synapterobject, "MSnSet"
this column could be ﬁnd in the feature data (fData(msnset)$synapterPlgsAgreement).
In the synapterPlgsAgreement each peptide is classiﬁed as:

• "agree": EMRT identiﬁed in identiﬁcation and quantitation run by PLGS and same EMRT

matched in synapter’s grid search.

• "disagree": EMRT identiﬁed in identiﬁcation and quantitation run by PLGS and a different

EMRT was matched in synapter’s grid search.

• "no_plgs_id": EMRT was not identiﬁed in the quantitation run by PLGS but matched in

synapter’s grid search.

• "no_synapter_transfer": EMRT was identiﬁed in the identiﬁcation and quantitation run

by PLGS but not matched in synapter’s grid search.

• "no_id_or_transfer": EMRT was not identiﬁed in the quantitation run by PLGS and not

matched in synapter’s grid search.

• "multiple_ident_matches": a single quantitation EMRT was matched by synapter to mul-
tiple identiﬁcation EMRTs found by PLGS (could happen if the grid search parameters are too
relaxed).

After combining multiple MSnSet the method synapterPlgsAgreement adds additional columns
to the feature data:

• nIdentified: how often a peptide was identiﬁed across multiple runs?
• nAgree: how often a peptide was identiﬁed by PLGS and synapter across multiple runs (counts

"agree" entries)?

• nDisagree: how often a peptide was differently identiﬁed by PLGS and synapter across mul-

tiple runs (counts "disagree" entries)?

• synapterPlgsAgreementRatio: nAgree/(nAgree +

nDisagree).

26

Value

synapterTinyData

MSnSet where the columns nIdentified, nAgree, nDisagree and synapterPlgsAgreementRatio
were added to the feature data.

Author(s)

Sebastian Gibb <mail@sebastiangibb.de>

References

See discussion on github: https://github.com/lgatto/synapter/issues/73

See Also

MSnSet documentation: MSnSet

synapterTinyData

Loads a small test data for the ’synapter’ package

Description

Instead of using data to load the synapterTiny data set, synapterTinyData will load it and
initialise it for proper downstream analysis, during which the 04_test_database.fasta ﬁle, pro-
vided with the package and references inside the object needs, to be accessed. However, as the exact
location can not be known in advance, the reference is updated with the ﬁle’s correct local path.
This data set has been generated with the Synapter constructor. Note that the input data ﬁle sizes
have been reduced by depleting many rows (peptides and EMRTs) from the original csv ﬁles.

In addition, several columns that where not necessary for processing were also removed. As such,
the data stored in synapterTiny does not relect the data obtained when following the section
’Preparing the input data’ in the section, without however affecting the processing and ﬁnal results.

Usage

synapterTinyData()

Value

A character vector with the data set name, "synapterTiny". Used for its side effect of loading
synapterTiny, an instance of class Synapter, in .GlovalEnv.

Author(s)

Laurent Gatto

Source

Improving qualitative and quantitative performance for MSE-based label free proteomics, N.J.
Bond, P.V. Shliaha, K.S. Lilley and L. Gatto, Journal of Proteome Research, 2013, in press.

The Effects of Travelling Wave Ion Mobility Separation on Data Independent Acquisition in Pro-
teomics Studies, P.V. Shliaha, N.J. Bond, L. Gatto and K.S. Lilley, Journal of Proteome Research,
2013, in press.

synergise

Examples

synapterTinyData()
synapterTiny

27

synergise

Synergise identiﬁcation and quantitation results

Description

Performs a complete default analysis on the ﬁles deﬁned in filenames, creates a complete html
report and saves/exports all results as csv and rds ﬁles. See details for a description of the pipeline
and Synapter for manual execution of individual steps.

Usage

synergise(filenames, master = FALSE, object, outputdir,

outputfile = paste0("synapter_report_", strftime(Sys.time(),
"%Y%m%d-%H%M%S"), ".html"), fdr = 0.01, fdrMethod = c("BH",
"Bonferroni", "qval"), fpr = 0.01, peplen = 7, missedCleavages = 0,
IisL = FALSE, identppm = 20, quantppm = 20, uniquepep = TRUE,
span = 0.05, grid.ppm.from = 2, grid.ppm.to = 20, grid.ppm.by = 2,
grid.nsd.from = 0.5, grid.nsd.to = 5, grid.nsd.by = 0.5,
grid.subset = 1, grid.n = 0, grid.param.sel = c("auto", "model",
"total", "details"), mergedEMRTs = c("rescue", "copy", "transfer"),
template = system.file("reports", "synergise1.Rmd", package = "synapter"),
verbose = interactive())

Arguments

filenames

master

object

outputdir

outputfile

fdr

fdrMethod

A named list of ﬁle names to be load. The names must be identpeptide,
quantpeptide, quantpep3d and fasta (could be an RDS ﬁle created by link{createUniquePeptideDbRds}).
identpeptide can be a csv ﬁnal peptide ﬁle (from PLGS) or a saved "MasterPeptides"
data object as created by makeMaster if working with master peptide data. To
serialise the "MasterPeptides" instance, use the saveRDS function, and ﬁle
extenstion rds.
A logical indicating if the identiﬁcation ﬁnal peptide ﬁles are master (see
makeMaster) or regular ﬁles. Default is FALSE.
An instance of class Synapter that will be copied, processed and returned.
If filenames are also provided, the latter and object’s inputFiles will be
checked for equality.
A character with the full path to an existing directory.
A character with the ﬁle name for the report.

Peptide false discovery rate. Default is 0.01.
P-value adjustment method. One of "BH" (default) for Benjamini and HochBerg
(1995), "Bonferroni" for Bonferroni’s single-step adjusted p-values for strong
control of the FWER and "qval" from the qvalue package. See Synapter for
references.

fpr

Protein false positive rate. Default is 0.01.

28

synergise

peplen
missedCleavages

Minimum peptide length. Default is 7.

IisL

identppm

quantppm

uniquepep

Number of allowed missed cleavages. Default is 0.
If TRUE Isoleucin and Leucin are treated as equal. In this case sequences like
"ABCI", "ABCL" are removed because they are not unqiue. If FALSE (default)
"ABCI" and "ABCL" are reported as unique.

Identiﬁcation mass tolerance (in ppm). Default is 20.

Quantitation mass tolerance (in ppm). Default is 20.
A logical is length 1 indicating if only unique peptides in the identiﬁcation
and quantitation peptides as well as unique tryptic peptides as deﬁned in the
fasta ﬁle. Default is TRUE.
The loess span parameter. Default is 0.05.

span
grid.ppm.from Mass tolerance (ppm) grid starting value. Default is 2.
grid.ppm.to
Mass tolerance (ppm) grid ending value. Default is 20.

Mass tolerance (ppm) grid step value. Default is 2.

grid.ppm.by
grid.nsd.from Number of retention time stdev grid starting value. Default is 0.5.
grid.nsd.to

Number of retention time stdev grid ending value. Default is 5.

grid.nsd.by

grid.subset

grid.n

Number of retention time stdev grid step value. Default is 0.5.

Percentage of features to be used for the grid search. Default is 1.

Absolute number of features to be used for the grid search. Default is 0, i.e
ignored.

mergedEMRTs

grid.param.sel Grid parameter selection method. One of auto (default), details, model or
total. See Synapter for details on these selection methods.
One of "rescue" (default), "copy" or "transfer". See the documentation for
the findEMRTs function in Synapter for details.
A character full path to Rmd template.
A logical indicating if progress output should be printed to the console. De-
fault is TRUE.

template

verbose

Details

Data can be input as a Synapter object if available or as a list of ﬁles (see filenames) that will be
used to read the data in. The html report and result ﬁles will be created in the outputdir folder.
All other input parameters have default values.

The data processing and analysis pipeline is as follows:

1. If uniquepep is set to TRUE (default), only unique proteotypic identiﬁcation and quantitation

peptides are retained.

2. Peptides are ﬁltered for a FDR <= fdr (default is 0.01) using the "BH" method (see fdr and

fdrMethod parameters for details).

3. Peptide with a mass tolerance > 20 ppms (see quantppm and identppm) are ﬁltered out.
4. Peptides with a protein false positive rate (as reported by the PLGS software) > fpr are ﬁltered

out.

5. Common identiﬁcation and quantitation peptides are merged and a retention time model is
created using the Local Polynomial Regression Fitting (loess function for the stats package)
using a default span value of 0.05.

synergise2

29

6. A grid search to optimise the width in retention time and mass tolerance for EMRTs matching
is performed. The default grid search space is from 0.5 to 5 by 0.5 retention time model stan-
dard deviations (see grid.nsd.from, grid.nsd.to and grid.nsd.by parameters) and from
2 to 20 by 2 parts per million (ppm) for mass tolerance (see grid.ppm.from, grid.ppm.to
and grid.ppm.by parameters). The data can be subset using using an absolute number of
features (see grid.n) or a ﬁxed percentage (see grid.subset). The pair of optimal nsd and
ppm is chosen (see grid.param.sel parameter).

7. The quantitation EMRTs are matched using the optimised parameters.

If a master identiﬁcation ﬁle is used (master is set to TRUE, default is FALSE), the relevant actions
that have already been executed when the ﬁle was created with makeMaster are not repeated here.

Value

Invisibly returns an object of class Synapter. Used for its side effect of creating an html report of
the run in outputdir.

Author(s)

Laurent Gatto, Sebastian Gibb

References

Bond N. J., Shliaha P.V., Lilley K.S. and Gatto L. (2013) J. Prot. Research.

Examples

output <- tempdir() ## a temporary directory
synapterTinyData()
synergise(object = synapterTiny, outputdir = output, outputfile = "synapter.html",

grid.subset = 0.2)

htmlReport <- paste0("file:///", file.path(output, "synapter.html")) ## the result report
## Not run:
browseURL(htmlReport) ## open the report with default browser

## End(Not run)

synergise2

Synergise identiﬁcation and quantitation results

Description

Performs a complete default analysis on the ﬁles deﬁned in filenames, creates a complete html
report and saves/exports all results as csv and rds ﬁles. See details for a description of the pipeline
and Synapter for manual execution of individual steps.

30

Usage

synergise2

synergise2(filenames, master = FALSE, object, outputdir,

outputfile = paste0("synapter_report_", strftime(Sys.time(),
"%Y%m%d-%H%M%S"), ".html"), fdr = 0.01, fdrMethod = c("BH",
"Bonferroni", "qval"), fpr = 0.01, peplen = 7, missedCleavages = 2,
IisL = FALSE, identppm = 20, quantppm = 20, uniquepep = TRUE,
span.rt = 0.05, span.int = 0.05, grid.ppm.from = 2, grid.ppm.to = 20,
grid.ppm.by = 2, grid.nsd.from = 0.5, grid.nsd.to = 5,
grid.nsd.by = 0.5, grid.imdiffs.from = 0.6, grid.imdiffs.to = 1.6,
grid.imdiffs.by = 0.2, grid.subset = 1, grid.n = 0,
grid.param.sel = c("auto", "model", "total", "details"), fm.ppm = 25,
fm.ident.minIntensity = 70, fm.quant.minIntensity = 70,
fm.minCommon = 1, fm.minDelta = 1, fm.fdr.unique = 0.05,
fm.fdr.nonunique = 0.05, mergedEMRTs = c("rescue", "copy", "transfer"),
template = system.file("reports", "synergise2.Rmd", package = "synapter"),
verbose = interactive())

Arguments

filenames

master

object

outputdir

outputfile

fdr

fdrMethod

A named list of ﬁle names to be load. The names must be identpeptide,
quantpeptide, quantpep3d and fasta (could be an RDS ﬁle created by link{createUniquePeptideDbRds}).
If fragmentmatching should be used identfragments (could be skipped if a
master RDS ﬁles is used for identpeptide) and quantspectra have to be
given as well. identpeptide can be a csv ﬁnal peptide ﬁle (from PLGS) or
a saved "MasterPeptides" data object as created by makeMaster if working
with master peptide data. To serialise the "MasterPeptides" instance, use the
saveRDS function, and ﬁle extenstion rds.
A logical indicating if the identiﬁcation ﬁnal peptide ﬁles are master (see
makeMaster) or regular ﬁles. Default is FALSE.
An instance of class Synapter that will be copied, processed and returned.
If filenames are also provided, the latter and object’s inputFiles will be
checked for equality.
A character with the full path to an existing directory.
A character with the ﬁle name for the report.

Peptide false discovery rate. Default is 0.01.
P-value adjustment method. One of "BH" (default) for Benjamini and HochBerg
(1995), "Bonferroni" for Bonferroni’s single-step adjusted p-values for strong
control of the FWER and "qval" from the qvalue package. See Synapter for
references.

fpr

peplen
missedCleavages

Protein false positive rate. Default is 0.01.

Minimum peptide length. Default is 7.

IisL

identppm

quantppm

Number of allowed missed cleavages. Default is 2.
If TRUE Isoleucin and Leucin are treated as equal. In this case sequences like
"ABCI", "ABCL" are removed because they are not unqiue. If FALSE (default)
"ABCI" and "ABCL" are reported as unique.

Identiﬁcation mass tolerance (in ppm). Default is 20.

Quantitation mass tolerance (in ppm). Default is 20.

synergise2

uniquepep

A logical is length 1 indicating if only unique peptides in the identiﬁcation
and quantitation peptides as well as unique tryptic peptides as deﬁned in the
fasta ﬁle. Default is TRUE.

31

span.rt

span.int

The loess span parameter for retention time correction. Default is 0.05.

The loess span parameter for intensity correction. Default is 0.05.

grid.ppm.from Mass tolerance (ppm) grid starting value. Default is 2.
grid.ppm.to

Mass tolerance (ppm) grid ending value. Default is 20.

grid.ppm.by

Mass tolerance (ppm) grid step value. Default is 2.

grid.nsd.from Number of retention time stdev grid starting value. Default is 0.5.
grid.nsd.to

Number of retention time stdev grid ending value. Default is 5.

grid.nsd.by
grid.imdiffs.from

Number of retention time stdev grid step value. Default is 0.5.

Ion mobility difference grid starting value. value. Default is 0.6.

grid.imdiffs.to

grid.imdiffs.by

grid.subset

grid.n

Ion mobility difference grid ending value. Default is 1.6.

Ion mobility difference grid step value. Default is 0.2.

Percentage of features to be used for the grid search. Default is 1.

Absolute number of features to be used for the grid search. Default is 0, i.e
ignored.

grid.param.sel Grid parameter selection method. One of auto (default), details, model or
total. See Synapter for details on these selection methods.
Fragment Matching tolerance: Peaks in a range of fm.ppm are considered as
identical. Default is 25.

fm.ppm

fm.ident.minIntensity

Minimal intensity of a Identiﬁcation fragment to be not ﬁltered prior to Fragment
Matching.

fm.quant.minIntensity

Minimal intensity of a peaks in a Quantitation spectra to be not ﬁltered prior to
Fragment Matching.

fm.minCommon Minimal number of peaks that unique matches need to have in common. Default

1.

fm.minDelta

Minimal difference in number of peaks that non-unique matches need to have to
be considered as true match. Default 1.

fm.fdr.unique Minimal FDR to select fm.minCommon automatically (if both values are given

the more restrictive one (that ﬁlters more fragments) is used). Default 0.05.

fm.fdr.nonunique

mergedEMRTs

template

verbose

Minimal FDR to select fm.minDelta automatically (if both values are given the
more restrictive one (that ﬁlters more fragments) is used). Default 0.05.
One of "rescue" (default), "copy" or "transfer". See the documentation for
the findEMRTs function in Synapter for details.
A character full path to Rmd template.
A logical indicating if progress output should be printed to the console. De-
fault is TRUE.

32

Details

synergise2

In contrast to synergise1 synergise2 extends the default analysis and offers the follwing unique
features:

• Performing 3D grid search (M/Z, Retention Time, Ion Mobility) for HDMSE data.

• Applying intensity correction.

• Filtering results by fragment matching.

Data can be input as a Synapter object if available or as a list of ﬁles (see filenames) that will be
used to read the data in. The html report and result ﬁles will be created in the outputdir folder.
All other input parameters have default values.

The data processing and analysis pipeline is as follows:

1. If uniquepep is set to TRUE (default), only unique proteotypic identiﬁcation and quantitation

peptides are retained.

2. Peptides are ﬁltered for a FDR <= fdr (default is 0.01) using the "BH" method (see fdr and

fdrMethod parameters for details).

3. Peptide with a mass tolerance > 20 ppms (see quantppm and identppm) are ﬁltered out.
4. Peptides with a protein false positive rate (as reported by the PLGS software) > fpr are ﬁltered

out.

5. Common identiﬁcation and quantitation peptides are merged and a retention time model is
created using the Local Polynomial Regression Fitting (loess function for the stats package)
using a default span.rt value of 0.05.

6. A grid search to optimise the width in retention time and mass tolerance (and ion mobil-
ity for HDMSE) for EMRTs matching is performed. The default grid search space is from
0.5 to 5 by 0.5 retention time model standard deviations (see grid.nsd.from, grid.nsd.to
and grid.nsd.by parameters) and from 2 to 20 by 2 parts per million (ppm) for mass tol-
erance (see grid.ppm.from, grid.ppm.to and grid.ppm.by parameters). If HDMSE data
are used the search space is extended from ion mobility difference 0.6 to 1.6 by 0.2 (see
grid.imdiffs.from, grid.imdiffs.to and grid.imdiffs.by). The data can be subset us-
ing using an absolute number of features (see grid.n) or a ﬁxed percentage (see grid.subset).
The pair of optimal nsd and ppm is chosen (see grid.param.sel parameter).

7. Fragment Matching is used to ﬁlter false-positive matches from the grid search using a default
of 1 common peak for unique matches and at least a difference of 1 common peaks to choose
the correct match out of non-unique matches (see fm.minCommon and fm.minDelta).

8. The intensity is corrected by a Local Polynomial Regression Fitting (loess function for the

stats package) using a default span.int value of 0.05.

9. The quantitation EMRTs are matched using the optimised parameters.

If a master identiﬁcation ﬁle is used (master is set to TRUE, default is FALSE), the relevant actions
that have already been executed when the ﬁle was created with makeMaster are not repeated here.

Value

Invisibly returns an object of class Synapter. Used for its side effect of creating an html report of
the run in outputdir.

Author(s)

Laurent Gatto, Sebastian Gibb

synergise2

References

33

Bond N. J., Shliaha P.V., Lilley K.S. and Gatto L. (2013) J. Prot. Research.

Examples

## Not run:
library(synapterdata)
data(synobj2)
output <- tempdir() ## a temporary directory
synergise2(object = synobj2, outputdir = output, outputfile = "synapter.html")
htmlReport <- paste0("file:///", file.path(output, "synapter.html")) ## the result report
browseURL(htmlReport) ## open the report with default browser

## End(Not run)

Index

∗Topic classes

MasterFdrResults-class, 8
MasterPeptides-class, 9
Synapter, 13
∗Topic datasets

synapterTinyData, 26

∗Topic methods

plotFragmentMatching, 10

∗Topic package

synapter-package, 2

allComb (MasterFdrResults-class), 8
allComb,MasterFdrResults-method

(MasterFdrResults-class), 8

as.MSnSet.Synapter (Synapter), 13

bestComb (MasterFdrResults-class), 8
bestComb,MasterFdrResults-method

(MasterFdrResults-class), 8

class:MasterFdrResults

(MasterFdrResults-class), 8

class:MasterPeptides

(MasterPeptides-class), 9

class:Synapter (Synapter), 13
createUniquePeptideDbRds, 3

dim,Synapter-method (Synapter), 13

estimateMasterFdr, 4, 7, 8

fileNames,MasterFdrResults-method
(MasterFdrResults-class), 8

filterFragments (Synapter), 13
filterFragments,Synapter-method

(Synapter), 13

filterIdentPepScore (Synapter), 13
filterIdentPepScore,Synapter-method

(Synapter), 13

filterIdentPpmError (Synapter), 13
filterIdentPpmError,Synapter-method

(Synapter), 13

filterIdentProtFpr (Synapter), 13
filterIdentProtFpr,Synapter-method

(Synapter), 13

filterNonUniqueIdentMatches (Synapter),

13

filterNonUniqueIdentMatches,Synapter-method

(Synapter), 13

filterNonUniqueMatches (Synapter), 13
filterNonUniqueMatches,Synapter-method

(Synapter), 13

filterPeptideLength (Synapter), 13
filterPeptideLength,Synapter-method

(Synapter), 13

filterQuantPepScore (Synapter), 13
filterQuantPepScore,Synapter-method

(Synapter), 13

filterQuantPpmError (Synapter), 13
filterQuantPpmError,Synapter-method

(Synapter), 13

filterQuantProtFpr (Synapter), 13
filterQuantProtFpr,Synapter-method

(Synapter), 13

filterUniqueDbPeptides (Synapter), 13
filterUniqueDbPeptides,Synapter-method

(Synapter), 13

filterUniqueIdentDbPeptides (Synapter),

13

filterUniqueIdentDbPeptides,Synapter-method

(Synapter), 13

filterUniqueMatches (Synapter), 13
filterUniqueMatches,Synapter-method

(Synapter), 13

filterUniqueQuantDbPeptides (Synapter),

13

filterUniqueQuantDbPeptides,Synapter-method

(Synapter), 13

findEMRTs (Synapter), 13
findEMRTs,Synapter-method (Synapter), 13
fragmentMatching, 10
fragmentMatching (Synapter), 13
fragmentMatching,Synapter-method

(Synapter), 13

fragmentMatchingPerformance (Synapter),

13

fragmentMatchingPerformance,Synapter-method

(Synapter), 13

34

INDEX

35

getBestGridParams (Synapter), 13
getBestGridParams,Synapter-method

(Synapter), 13
getBestGridValue (Synapter), 13
getBestGridValue,Synapter-method

(Synapter), 13

getEMRTtable (Synapter), 13
getEMRTtable,Synapter-method
(Synapter), 13

getFragmentMatchingPpmTolerance

(Synapter), 13

getRtNsd,Synapter-method (Synapter), 13
getRtQs (Synapter), 13
getRtQs,Synapter-method (Synapter), 13

inputFiles (Synapter), 13
inputFiles,Synapter-method (Synapter),

13

inspectPeptideScores, 5
isCurrent,Synapter-method (Synapter), 13

loess, 14–16, 28, 32

getFragmentMatchingPpmTolerance,Synapter-method

(Synapter), 13
getGrid (Synapter), 13
getGrid,Synapter-method (Synapter), 13
getGridDetails (Synapter), 13
getGridDetails,Synapter-method
(Synapter), 13

getIdentificationFragments (Synapter),

13

getIdentificationFragments,Synapter-method

(Synapter), 13
getIdentPpmError (Synapter), 13
getIdentPpmError,Synapter-method

(Synapter), 13

getImDiff (Synapter), 13
getImDiff,Synapter-method (Synapter), 13
getLog (Synapter), 13
getLog,Synapter-method (Synapter), 13
getLowessSpan (Synapter), 13
getLowessSpan,Synapter-method
(Synapter), 13

getPepNumbers, 5
getPepNumbers (Synapter), 13
getPepNumbers,Synapter-method
(Synapter), 13
getPepScoreFdr (Synapter), 13
getPepScoreFdr,Synapter-method
(Synapter), 13

getPpmErrorQs (Synapter), 13
getPpmErrorQs,Synapter-method
(Synapter), 13

getProtFpr (Synapter), 13
getProtFpr,Synapter-method (Synapter),

13

getQuantitationSpectra (Synapter), 13
getQuantitationSpectra,Synapter-method

(Synapter), 13
getQuantPpmError (Synapter), 13
getQuantPpmError,Synapter-method

(Synapter), 13
getRtNsd (Synapter), 13

makeMaster, 5, 5, 9, 13, 27, 29, 30, 32
masterFdr (MasterFdrResults-class), 8
masterFdr,MasterFdrResults-method
(MasterFdrResults-class), 8

MasterFdrResults, 4
MasterFdrResults

(MasterFdrResults-class), 8

MasterFdrResults-class, 8
MasterPeptides, 7, 13, 27, 30
MasterPeptides-class, 9
mergePeptides (Synapter), 13
mergePeptides,Synapter-method
(Synapter), 13
modelIntensity (Synapter), 13
modelIntensity,Synapter-method
(Synapter), 13
modelRt (Synapter), 13
modelRt,Synapter-method (Synapter), 13
MSnExp, 7, 21
MSnSet, 11–13, 25, 26

par, 10
performance (Synapter), 13
performance,Synapter-method (Synapter),

13

performance2 (Synapter), 13
performance2,Synapter-method
(Synapter), 13

plot,MasterFdrResults,missing-method

(MasterFdrResults-class), 8

plot.default, 10
plot.qvalue, 20
plotCumulativeNumberOfFragments

(Synapter), 13

plotCumulativeNumberOfFragments,Synapter-method

(Synapter), 13

plotEMRTtable (Synapter), 13
plotEMRTtable,Synapter-method
(Synapter), 13
plotFdr (Synapter), 13
plotFdr,Synapter-method (Synapter), 13

36

INDEX

plotFragmentMatchingPerformance,Synapter-method

plotFeatures (Synapter), 13
plotFeatures,Synapter-method
(Synapter), 13
plotFragmentMatching, 10, 21
plotFragmentMatching,Synapter-method

(plotFragmentMatching), 10

plotFragmentMatchingPerformance

(Synapter), 13

(Synapter), 13
plotGrid (Synapter), 13
plotGrid,Synapter-method (Synapter), 13
plotIntensity (Synapter), 13
plotIntensity,Synapter-method
(Synapter), 13

plotPepScores, 5
plotPepScores (Synapter), 13
plotPepScores,Synapter-method
(Synapter), 13

plotPpmError (Synapter), 13
plotPpmError,Synapter-method
(Synapter), 13

plotRt (Synapter), 13
plotRt,Synapter-method (Synapter), 13
plotRtDiffs (Synapter), 13
plotRtDiffs,Synapter-method (Synapter),

13

requantify (requantify,MSnSet-method),

10

requantify,MSnSet-method, 10
rescaleForTop3

rescaleForTop3,MSnSet,MSnSet-method,

12

rescueEMRTs (Synapter), 13
rescueEMRTs,Synapter-method (Synapter),

13

searchGrid (Synapter), 13
searchGrid,Synapter-method (Synapter),

13

setBestGridParams (Synapter), 13
setBestGridParams,Synapter-method

(Synapter), 13

setFragmentMatchingPpmTolerance

(Synapter), 13

(Synapter), 13
setIdentPpmError (Synapter), 13
setIdentPpmError,Synapter-method

(Synapter), 13

setImDiff (Synapter), 13
setImDiff,Synapter-method (Synapter), 13
setLowessSpan (Synapter), 13
setLowessSpan,Synapter-method
(Synapter), 13
setPepScoreFdr (Synapter), 13
setPepScoreFdr,Synapter-method
(Synapter), 13

setPpmError (Synapter), 13
setPpmError,Synapter-method (Synapter),

13

setProtFpr (Synapter), 13
setProtFpr,Synapter-method (Synapter),

13

setQuantPpmError (Synapter), 13
setQuantPpmError,Synapter-method

(Synapter), 13
setRtNsd (Synapter), 13
setRtNsd,Synapter-method (Synapter), 13
show,MasterFdrResults-method

(MasterFdrResults-class), 8

show,MasterPeptides-method

(MasterPeptides-class), 9

show,Synapter-method (Synapter), 13
showFdrStats (Synapter), 13
showFdrStats,Synapter-method
(Synapter), 13
Synapter, 3, 6, 7, 10, 13, 26–32
synapter (synapter-package), 2
synapter-package, 2
synapterGUI, 6
synapterGuide, 24
synapterPlgsAgreement

synapterPlgsAgreement,MSnSet-method,

25

synapterTiny (synapterTinyData), 26
synapterTinyData, 26
synergise, 3, 6, 27
synergise1, 32
synergise1 (synergise), 27
synergise2, 29
synergize (synergise), 27
synergize1 (synergise), 27
synergize2 (synergise2), 29

validObject,Synapter-method (Synapter),

13

setFragmentMatchingPpmTolerance,Synapter-method

updateObject,Synapter-method
(Synapter), 13

(rescaleForTop3,MSnSet,MSnSet-method),
12

(synapterPlgsAgreement,MSnSet-method),
25

INDEX

37

writeFragmentLibrary (makeMaster), 5
writeFragmentLibrary,MasterPeptides,character-method

(makeMaster), 5
writeIdentPeptides (Synapter), 13
writeIdentPeptides,Synapter-method

(Synapter), 13

writeMasterPeptides (makeMaster), 5
writeMasterPeptides,MasterPeptides,character-method

(makeMaster), 5

writeMatchedEMRTs, 25
writeMatchedEMRTs (Synapter), 13
writeMatchedEMRTs,Synapter-method

(Synapter), 13

writeMergedPeptides (Synapter), 13
writeMergedPeptides,Synapter-method

(Synapter), 13

writeQuantPeptides (Synapter), 13
writeQuantPeptides,Synapter-method

(Synapter), 13

