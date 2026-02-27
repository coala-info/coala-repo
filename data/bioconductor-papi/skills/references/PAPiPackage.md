Applying the Pathway Activity Proﬁling - PAPi

Raphael Aggio

April 24, 2017

Introduction

This document describes how to use the Pathway Activity Proﬁling - PAPi . PAPi is an R
package for predicting the activity of metabolic pathways based solely on metabolomics
data. It relates metabolites’ abundances with the activity of metabolic pathways. See
Aggio, R.B.M; Ruggiero, K. and Villas-Boas, S.G. (2010) - Pathway Activity Proﬁling
(PAPi): from metabolite proﬁle to metabolic pathway activity. Bioinformatics.

1 Step 1 - Building a local KEGG database: build-

Database

PAPi makes use of the information available at the Kyoto Encyclopedia of Genes and
Genomes - KEGG database (http://www.genome.jp/kegg/). PAPi can be applied in
two ways: online and oﬄine. When applying PAPi online, an internet connection is
required to collect online biochemical data from KEGG database. On the other hand,
when applied oﬄine, PAPi makes use of a local database and no internet connection is
required. As KEGG database is constantly updated, PAPi may produce diﬀerent results
when applied online on diﬀerent days. Oﬄine, PAPi produces always the same results
when using the same local database. PAPi is signiﬁcantly faster when applied oﬄine.
As default, PAPi brings a local database and the function buildDatabase can be used
to build new local databases. buildDatabase uses the internet connection to create and
install new databases inside of the folder R.home(”library/PAPi/data/databases/”). If
save = TRUE, the new database is also installed in a folder deﬁned by the user. The
local database consists on two CSV ﬁles containing the required data about metabolites
and metabolic pathways. buildDatabase may take up to ten hours depending on the
speed of the internet connection. We highly recommend to build a local database once
and do all the required analysis using the same database. Doing so, the results obtained
from PAPi can be reproduced at anytime and the time required for each analysis is
enormously faster.

1

2 Step 2 - Adding KEGG codes to metabolomics

data: addKeggCodes

We consider a typical metabolomics data set: a data frame containing the name of
identiﬁed metabolites in the ﬁrst column and their abundances in the diﬀerent samples
in the following columns. Bellow you have an example of a metabolomics data set.

> library(PAPi)
> library(svDialogs)
> data(metabolomicsData)
> print(metabolomicsData)

Replicates
1
Glucose
2
3
Fructose 6-phosphate
4 Glyceraldehyde 3-phosphate
Glycerone phosphate
5
3-Phospho-D-glycerate
6

Names Sample1 Sample2 Sample3 Sample4 Sample5 Sample6
cond2
cond1
1.5
0.7
0.7
0.4
<NA>
1.2
0.2
1.3
0.9
0.5

cond2
1.1
0.7
<NA>
0.3
1

cond2
1.2
0.6
<NA>
0.2
1.1

cond1
0.6
0.2
1.5
1.5
0.3

cond1
0.8
0.3
1.1
1.2
0.2

For applying PAPi , the name of compounds in the metabolomics data set must be
substituted by their respective KEGG codes. This process can be performed manually,
however, it may be considerable time consuming according to the size of the input data.
The function addKeggCodes automates this process using a KEGG codes list, which is a
data frame containing all potentially identiﬁable compound and their respective KEGG
codes. See bellow:

> data(keggLibrary)
> print(keggLibrary)

Name
kegg
Glucose
1 C00031
2 C05345
Fructose 6-phosphate
3 C00118 Glyceraldehyde 3-phosphate
Glycerone phosphate
4 C00111
3-Phospho-D-glycerate
5 C00197
Citrate
6 absent

The KEGG codes list can be built as a CSV ﬁle containing a list of KEGG codes in
the ﬁrst column and their respective compound names in the second column, following
the same format as showed above. Alternatively, the data frame data(keggLibrary)
can be used.
Ideally, the KEGG codes list should contain every compound poten-
tially identiﬁable by the protocol you use to analyze and identify metabolites. For
example, I have in my KEGG codes list the name of every compound present in my
GC-MS library. The KEGG code of a compound can be searched at KEGG website:
http://www.genome.jp/kegg/, however, if the argument addCodes = TRUE, the func-
tion addKeggCodes will automatically recognize if you have missing compounds - com-
pounds in your input data that are not present in your KEGG codes list. Then, it will

2

ask if you would like to add those compounds to the KEGG codes list in use. If you
click on ”yes”, addKeggCodes will automatically search the KEGG database (using the
INTERNET connection) for missing compounds. For each missing compound, addKeg-
gCodes will present to you a list with all the potential matches from KEGG database.
If the right compound is in the list, you just have to click on the compound and click
on "Ok". The KEGG code and the name of this respective compound will be automat-
ically aded to the bottom of your KEGG codes list. On the other hand, if the desired
compound is not in the list presented to you, you have two options: go to the end of the
list and click on "SKIP"; or go to the end of the list and click on "OTHER", which will
open a new dialog box allowing you to manually add the respective KEGG code. If the
compounds’ names in the input data are similar to the names used by KEGG database,
addKeggCodes will ﬁnd the KEGG code of most compounds. After looking for KEGG
codes, addKeggCodes gives you the option to save the new KEGG codes list as CSV ﬁle
and generates a data frame as the input data, however, now with KEGG codes instead
of compounds’ names. Here is an example of how to used addKeggCodes and the result
it generates:

> print(metabolomicsData)

Replicates
1
Glucose
2
3
Fructose 6-phosphate
4 Glyceraldehyde 3-phosphate
Glycerone phosphate
5
3-Phospho-D-glycerate
6

Names Sample1 Sample2 Sample3 Sample4 Sample5 Sample6
cond2
cond1
1.5
0.7
0.7
0.4
<NA>
1.2
0.2
1.3
0.9
0.5

cond2
1.2
0.6
<NA>
0.2
1.1

cond1
0.8
0.3
1.1
1.2
0.2

cond2
1.1
0.7
<NA>
0.3
1

cond1
0.6
0.2
1.5
1.5
0.3

> print(keggLibrary)

Name
kegg
Glucose
1 C00031
2 C05345
Fructose 6-phosphate
3 C00118 Glyceraldehyde 3-phosphate
Glycerone phosphate
4 C00111
3-Phospho-D-glycerate
5 C00197
Citrate
6 absent

> AddedKegg <- addKeggCodes(
+
+
+
+
+ )

metabolomicsData,
keggLibrary,
save = FALSE,
addCodes = TRUE

[1] "Data frame loaded..."
[1] "keggCodes - Data frame loaded..."
[1] "Every compound in the inputData was found in the keggCodes library."
[1] "The final data frame was not saved because the argument save was set as FALSE"

> print(AddedKegg)

3

1 Replicates
C00197
2
C05345
3
C00031
4
C00118
5
C00111
6

Name Sample1 Sample2 Sample3 Sample4 Sample5 Sample6
cond2
cond1
0.9
0.5
0.7
0.4
1.5
0.7
<NA>
1.2
0.2
1.3

cond2
1.1
0.6
1.2
<NA>
0.2

cond1
0.2
0.3
0.8
1.1
1.2

cond1
0.3
0.2
0.6
1.5
1.5

cond2
1
0.7
1.1
<NA>
0.3

3 Step 3 - Applying PAPi: papi

Once the names of metabolites were substituted by their respective KEGG codes, the
input data is ready to be analyzed by the function papi. Here is an example of how to
use papi and the results it generates:

> data(papiData)
> print(papiData)

1 Replicates
C00197
2
C05345
3
C00031
4
C00118
5
C00111
6

Name Sample1 Sample2 Sample3 Sample4 Sample5 Sample6
cond2
cond1
0.9
0.5
0.7
0.4
1.5
0.7
<NA>
1.2
0.2
1.3

cond2
1.1
0.6
1.2
<NA>
0.2

cond1
0.3
0.2
0.6
1.5
1.5

cond1
0.2
0.3
0.8
1.1
1.2

cond2
1
0.7
1.1
<NA>
0.3

> #papiResults <- papi(papiData, save = FALSE, offline = TRUE, localDatabase = "default")
> data(papiResults)
> head(papiResults)

Replicates
1
Bile secretion
22
Methane metabolism
10
20
ABC transporters
13 Pentose and glucuronate interconversions
Nicotinate and nicotinamide metabolism
12

pathwayname Sample1 Sample2 Sample3 Sample4
cond2
210
16
118.8
11
9.4

cond1
122.5
100
69.3
68.75
61.1

cond1
105
120
59.4
82.5
70.5

cond1
140
92
79.2
63.25
56.4

Sample5 Sample6
cond2
262.5
16
148.5
11
9.4

cond2
192.5
24
108.9
16.5
14.1

1
22
10
20
13
12

When oﬄine = TRUE, PAPi is performed using a local database. When local-
Database = ”choose”, a list of all installed local databases is presented to the user to
choose which one to be used.

4

4 Step 4 - Applying t-test or ANOVA: papiHtest

papiHtest performs a t-test or ANOVA on the input data, which is a data frame pro-
duced by the function papi. For identifying to which experimental condition each sample
belongs, the ﬁrst row of the input data may receive the value ”Replicates” in the ﬁrst
cell of the ﬁrst column and a character string indicating to which experimental condition
each sample belongs in the following columns, such as described bellow:

> data(papiResults)
> head(papiResults)

Replicates
1
Bile secretion
22
Methane metabolism
10
ABC transporters
20
13 Pentose and glucuronate interconversions
Nicotinate and nicotinamide metabolism
12

pathwayname Sample1 Sample2 Sample3 Sample4
cond2
210
16
118.8
11
9.4

cond1
140
92
79.2
63.25
56.4

cond1
122.5
100
69.3
68.75
61.1

cond1
105
120
59.4
82.5
70.5

Sample5 Sample6
cond2
262.5
16
148.5
11
9.4

cond2
192.5
24
108.9
16.5
14.1

1
22
10
20
13
12

Alternatively, papiHtest will ask the user to indicate the samples belonging to each
experimental condition. It is all interactive. The argument StatTest of papiHtest is
used to determine if a t-test or an ANOVA should be performed. If StatTest = ”T-
TEST”, ”T-test”, ”t-test”, ”t-TEST”, ”t” or ”T”, a t-test is performed. If StatTest =
”ANOVA”, ”Anova”, ”anova”, ”A” or ”a”, a ANOVA is performed. If StatTest is missing,
t-test will be performed for input data sets showing two experimental conditions and
ANOVA will be performed for input data sets showing more than two experimental
conditions. papiHtest can be applied as follows:

> head(papiResults)

Replicates
1
Bile secretion
22
Methane metabolism
10
20
ABC transporters
13 Pentose and glucuronate interconversions
Nicotinate and nicotinamide metabolism
12

pathwayname Sample1 Sample2 Sample3 Sample4
cond2
210
16
118.8
11
9.4

cond1
105
120
59.4
82.5
70.5

cond1
122.5
100
69.3
68.75
61.1

cond1
140
92
79.2
63.25
56.4

Sample5 Sample6
cond2
262.5
16
148.5
11
9.4

cond2
192.5
24
108.9
16.5
14.1

1
22
10
20
13
12

5

> ApplyingHtest <- papiHtest(
+
+
+
+ )
> head(ApplyingHtest)

papiResults,
save = FALSE,
StatTest = "T"

1
Replicates
12 Carbon fixation in photosynthetic organisms
Clavulanic acid biosynthesis
7
Fructose and mannose metabolism
23
Inositol phosphate metabolism
33
Methane metabolism
13

pathwayname Sample1 Sample2 Sample3 Sample4
cond2
4.6
<NA>
19.2
8.4
16

cond1
34.5
15
51.2
63
120

cond1
28.75
12
46.4
52.5
100

cond1
26.45
11
41.6
48.3
92

Sample5 Sample6
cond2

1
12
7
23
33
13

cond2
6.9
<NA>
24
12.6
24

pvalues
bonferroni
4.6 0.0391647314284331
<NA>
0
21.6 0.0335649923259184
8.4 0.0391647314284331
16 0.0391647314284331

5 Step 5 - Generating PAPi graph: papiLine

The results produced by PAPi can be automatically plotted in a line graph using the
function papiLine. The input data is a data frame such as produced by papi and
papiHtest. papiLine was developed to automatically detect graphical parameters,
however, some particular data sets may end up in graphs with the legend in the wrong
position or axis labels too small. For this reason, papiLine has 20 arguments that allow
the user to customize most of the graphical parameters. If save = TRUE, a png ﬁle will
be saved in a folder deﬁned by the user. If save = FALSE, a new window will pop up
with the graph and the user can use the R options for saving the graph to a PDF ﬁle.
Here is an example of how to use papiLine:

> head(papiResults)

Replicates
1
Bile secretion
22
Methane metabolism
10
20
ABC transporters
13 Pentose and glucuronate interconversions
Nicotinate and nicotinamide metabolism
12

pathwayname Sample1 Sample2 Sample3 Sample4
cond2
210
16
118.8
11
9.4

cond1
122.5
100
69.3
68.75
61.1

cond1
105
120
59.4
82.5
70.5

cond1
140
92
79.2
63.25
56.4

Sample5 Sample6
cond2
262.5
16
148.5

cond2
192.5
24
108.9

1
22
10
20

6

13
12

16.5
14.1

11
9.4

> papiLine(
+
+
+
+
+
+ )

papiResults,
relative = TRUE,
setRef.cond = TRUE,
Ref.cond = "cond1",
save = FALSE

[1] "Data frame loaded..."

7

