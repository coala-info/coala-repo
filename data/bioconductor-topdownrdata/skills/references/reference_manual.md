Package ‘topdownrdata’

February 26, 2026

Version 1.32.0

Title Example Files for the topdownr R Package

Description Example data for the topdownr package generated on a Thermo Orbitrap Fusion Lu-

mos MS device.

Depends topdownr

biocViews ExperimentData, MassSpectrometryData

License GPL (>= 3)

NeedsCompilation no

URL https://codeberg.org/sgibb/topdownrdata/

BugReports https://codeberg.org/sgibb/topdownrdata/issues/

RoxygenNote 7.3.2

Roxygen list(markdown=TRUE)

Encoding UTF-8

git_url https://git.bioconductor.org/packages/topdownrdata

git_branch RELEASE_3_22

git_last_commit 50139a6

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Author Sebastian Gibb [aut, cre],
Pavel Shliaha [aut],
Ole Nørregaard Jensen [aut]

Maintainer Sebastian Gibb <mail@sebastiangibb.de>

Contents

topdownrdata-package .
.
topDownDataPath .

.

.

Index

.
.

.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
4

6

1

2

topdownrdata-package

topdownrdata-package

Example Data for the topdownr package.

Description

This package contains example files accompanying the topdownr.

Details

It has just one function topDownDataPath() that returns the file path to the 5 example protein
datasets.

Each dataset has four different categories of files:

• One .fasta file containing the protein sequence.
• Multiple .experiments.csv, .txt, and .mzML files (the same number of files for each of the

three types):

– The .experiments.csv files contain the information about the used method and the

settings of the mass spectrometer (fragmentation conditions).

– The .txt scan header files contain (additional) information about the spectra (monoiso-

topic m/z, ion injection time, ...).

– The .mzML files contain the deconvoluted spectra.

In total this package has 341 files: a .fasta file for each protein (5) and 20 files of each of the
three method/spectra information files for every protein except for the bovine carbonic anhydrase
and C3a recombinant protein which have 26 of each.
The topdownr package needs all the four file types. The sequence information of the .fasta file is
used to calculate the fragmentation in-silico. The theoretical fragments are matched against the ex-
perimental seen fragments that are stored in the .mzML files. In the next step the fragmentation data
have to be combined with the general information about spectra and the fragmentation condition
from the .txt scan header and the .experiments.csv method files, respectively.

In combination these information could be used to investigate fragmentation conditions and to find
the one (or more) that maximise the overall fragment coverage. Please see a small example on the
end of this manual page and a full featured example analysis in the topdownr analysis vignette:
vignette("analysis", package="topdownr").

The .meth files were created with the following command:

library("topdownr")

writeMethodXmls(defaultMs1Settings(LastMass=1600),

defaultMs2Settings(),
## mass/z adapted to protein of interest (see table)
## z is currently not supported by the Thermo software,
## setting to 1.
mz=cbind(mass=c(745.2, 908.0, 1162.0), z=c(1, 1, 1)),
groupBy=c("replication", "ETDReactionTime"),
replications=2,
pattern="method_CA3_\\%s.xml")

topdownrdata-package

General Information:

3

protein name
horse myoglobin
bovine carbonic anhydrase
histone H3.3
histone H4
C3a recombinant protein

uniprot accession
P68082
P00921
P84243
P62805
P01024 part (672-748)

product number
sigma M1882
sigma C2522
NEB M2507S
NEB M2504S
recombinantly expressed

modifications
Met-loss
Met-loss + Acetyl
Met-loss
Met-loss
carbamidomethyl

monoisotopic mass observed monoisotopic mass predicted

16940.99

29006.76

15187.49

11229.33

9814.9.0

16940.96

29006.83

15187.46

11229.34

9814.88

All 5 proteins were infused into a Thermo Orbitrap Fusion Lumos at 600 nl/minute in 50 \ FS360-
20-10-5-6.35CT emitter.

M/Z used:

protein name
horse myoglobin
bovine carbonic anhydrase
histone H3.3
histone H4
C3a recombinant protein

m/z 1
707.3/24
745.2/39
563.8/27
562.7/20
745.2/17

m/z 2
893.1/19
908.0/32
691.8/22
703.2/16
908.0/14

m/z 3
1211.7/14
1162.0/25
894.9/17
937.3/12
1162.0/11

Author(s)

Pavel Shliaha <pavels@bmb.sdu.dk>, Sebastian Gibb <mail@sebastiangibb.de>

References

https://codeberg.org/sgibb/topdownrdata/

See Also

topDownDataPath(), topdownr-package,
Vignettes for the generation vignette("data-generation", package="topdownr") and analy-
sis of these data vignette("analysis", package="topdownr").

Examples

# List file categories
list.files(topdownrdata::topDownDataPath("myoglobin"))

# List all needed files
list.files(topdownrdata::topDownDataPath("myoglobin"), recursive=TRUE)

# Read files, predict fragments and combine spectra information
tds <- readTopDownFiles(

path=topDownDataPath("myoglobin"),
## Use an artifical pattern to load just the fasta
## file and files from m/z == 1211, ETD reagent
## target 1e6 and first replicate to keep runtime
## of the example short
pattern=".*fasta.gz$|1211_.*1e6_1"

)

4

topDownDataPath

# Show TopDownSet object
tds

# Filter all intensities that don't have at least 10 % of the highest
# intensity per fragment.
tds <- filterIntensity(tds, threshold=0.1)

# Filter all conditions with a CV above 30 % (across technical replicates)
tds <- filterCv(tds, threshold=30)

# Filter all conditions with a large deviation in injection time
tds <- filterInjectionTime(tds, maxDeviation=log2(3), keepTopN=2)

# Filter all conditions where fragments don't replicate
tds <- filterNonReplicatedFragments(tds)

# Normalise by TIC
tds <- normalize(tds)

# Aggregate technical replicates
tds <- aggregate(tds)

# Coerce to NCBSet (N-/C-terminal/Bidirectional) and plot fragment coverage
fragmentationMap(as(tds, "NCBSet"))

topDownDataPath

TopDown Proteomic Datasets

Description

This function returns the path to the example files accompanying the topdownr.

Usage

topDownDataPath(protein = c("myoglobin", "ca", "h3_3", "h4", "c3a"))

Arguments

protein

character, name of the dataset.

Details

See topdownrdata-package for a description of the datasets.

Value

character, path to the directory containing the example files.

Author(s)

Sebastian Gibb <mail@sebastiangibb.de>

topDownDataPath

Examples

topDownDataPath("myoglobin")

5

Index

∗ package

topdownrdata-package, 2

topDownDataPath, 4
topDownDataPath(), 2, 3
topdownr-package, 3
topdownrdata (topdownrdata-package), 2
topdownrdata-package, 2, 4

6

