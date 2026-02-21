Package ‘golubEsets’

February 12, 2026

Version 1.52.0

Title exprSets for golub leukemia data

Author Todd Golub <golub@wi.mit.edu>

Maintainer Vince Carey <stvjc@channing.harvard.edu>

Description representation of public golub data with some covariate
data of provenance unknown to the maintainer at present; now
employs ExpressionSet format

biocViews ExperimentData, Genome, CancerData, LeukemiaCancerData

LazyLoad true

Depends R (>= 2.14.0), Biobase (>= 2.5.5)

License LGPL

ZipData No

git_url https://git.bioconductor.org/packages/golubEsets

git_branch RELEASE_3_22

git_last_commit d64fb88

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

golubMerge .
.
golubTest
.
.
golubTrain .

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

. .
. .
. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
3
4

5

Index

1

2

golubMerge

golubMerge

Combined Test and Training Sets from the Golub Paper

Description

golubMerge is deprecated. use Golub\_Merge instead.

The data are from Golub et al. These are the combined training samples and test samples. There are
47 patients with acute lymphoblastic leukemia (ALL) and 25 patients with acute myeloid leukemia
(AML). The samples were assayed using Affymetrix Hgu6800 chips and data on the expression
of 7129 genes (Affymetrix probes) are available. The data were obtained from the Web site listed
below and transformed slightly. They were installed in an exprSet.

Usage

data(golubMerge)
data(Golub_Merge)

Format

There are 11 covariates listed.

• Samples: The original sample numbers.
• ALL.AML: Whether the patient had AML or ALL.
• BM.PB: Whether the sample was taken from bone marrow or from peripheral blood.
• T.B.cell: ALL arises from two different types of lymphocytes (T-cell and B-cell). This

specifies which for the ALL patients; it is NA for the AML samples.

• FAB: FAB classification.
• Date: The date the sample was obtained.
• Gender: The gender of the patient the sample was obtained from.
• pctBlasts: An estimate of the percentage of blasts.
• Treatment: For the AML patient and indicator of whether the treatment was a success.
• PS: Prediction Strength.
• Source: The institution that provided the samples.

Source

http://www-genome.wi.mit.edu/mpr/data_set_ALL_AML.html, after some anonymous Biocon-
ductor massaging

References

Molecular Classification of Cancer: Class Discovery and Class Prediction by Gene Expression
Monitoring, Science, 531-537, 1999, T. R. Golub and D. K. Slonim and P. Tamayo and C. Huard
and M. Gaasenbeek and J. P. Mesirov and H. Coller and M.L. Loh and J. R. Downing and M. A.
Caligiuri and C. D. Bloomfield and E. S. Lander

Examples

data(Golub_Merge)
Golub_Merge

golubTest

3

golubTest

Test Set Data from the Golub Paper

Description

golubTest is deprecated. Use Golub\_Test instead.

The data are from Golub et al. These are the training samples, 20 patients with acute lymphoblastic
leukemia (ALL) and 14 patients with acute myeloid leukemia (AML). The samples were assayed
using Affymetrix Hgu6800 chips and data on the expression of 7129 genes (Affymetrix probes) are
available. The data were obtained from the Web site listed below and transformed slightly. They
were installed in an exprSet.

Usage

data(golubTest)
data(Golub_Test)

Format

There are 11 covariates listed.

• Samples: The original sample numbers.
• ALL.AML: Whether the patient had AML or ALL.
• BM.PB: Whether the sample was taken from bone marrow or from peripheral blood.
• T.B.cell: ALL arises from two different types of lymphocytes (T-cell and B-cell). This

specifies which for the ALL patients; it is NA for the AML samples.

• FAB: FAB classification.
• Date: The date the sample was obtained.
• Gender: The gender of the patient the sample was obtained from.
• pctBlasts: An estimate of the percentage of blasts.
• Treatment: For the AML patient and indicator of whether the treatment was a success.
• PS: Prediction Strength.
• Source: The institution that provided the samples.

Source

http://www-genome.wi.mit.edu/mpr/data_set_ALL_AML.html, after some anonymous Biocon-
ductor massaging

References

Molecular Classification of Cancer: Class Discovery and Class Prediction by Gene Expression
Monitoring, Science, 531-537, 1999, T. R. Golub and D. K. Slonim and P. Tamayo and C. Huard
and M. Gaasenbeek and J. P. Mesirov and H. Coller and M.L. Loh and J. R. Downing and M. A.
Caligiuri and C. D. Bloomfield and E. S. Lander

Examples

data(Golub_Test)
Golub_Test

4

golubTrain

golubTrain

Training Set from the Golub Paper

Description

golubTrain is deprecated. use Golub\_Train instead.

The data are from Golub et al. These are the training samples, 27 patients with acute lymphoblastic
leukemia (ALL) and 11 patients with acute myeloid leukemia (AML). The samples were assayed
using Affymetrix Hgu6800 chips and data on the expression of 7129 genes (Affymetrix probes) are
available. The data were obtained from the Web site listed below and transformed slightly. They
were installed in an exprSet.

Usage

data(golubTrain)
data(Golub_Train)

Format

There are 11 covariates listed.

• Samples: The original sample numbers.
• ALL.AML: Whether the patient had AML or ALL.
• BM.PB: Whether the sample was taken from bone marrow or from peripheral blood.
• T.B.cell: ALL arises from two different types of lymphocytes (T-cell and B-cell). This

specifies which for the ALL patients; it is NA for the AML samples.

• FAB: FAB classification.
• Date: The date the sample was obtained.
• Gender: The gender of the patient the sample was obtained from.
• pctBlasts: An estimate of the percentage of blasts.
• Treatment: For the AML patient and indicator of whether the treatment was a success.
• PS: Prediction Strength.
• Source: The institution that provided the samples.

Source

http://www-genome.wi.mit.edu/mpr/data_set_ALL_AML.html, after some anonymous Biocon-
ductor massaging

References

Molecular Classification of Cancer: Class Discovery and Class Prediction by Gene Expression
Monitoring, Science, 531-537, 1999, T. R. Golub and D. K. Slonim and P. Tamayo and C. Huard
and M. Gaasenbeek and J. P. Mesirov and H. Coller and M.L. Loh and J. R. Downing and M. A.
Caligiuri and C. D. Bloomfield and E. S. Lander

Examples

data(Golub_Train)
Golub_Train

Index

∗ datasets

golubMerge, 2
golubTest, 3
golubTrain, 4

Golub_Merge (golubMerge), 2
Golub_Test (golubTest), 3
Golub_Train (golubTrain), 4
golubMerge, 2
golubTest, 3
golubTrain, 4

5

