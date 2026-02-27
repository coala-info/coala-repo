QuartPAC: Identifying mutational clusters
while utilizing protein quaternary structural data

Gregory Ryslik
Genentech
gregory.ryslik@yale.edu

Yuwei Cheng
Yale University
yuwei.cheng@yale.edu

Hongyu Zhao
Yale University
hongyu.zhao@yale.edu

October 30, 2017

Abstract

The QuartPAC package is designed to identify mutated amino acid hotspots
while accounting for protein quaternary structure. It is meant to work in con-
junction with the iPAC [Ryslik and Zhao, 2012b], GraphPAC [Ryslik and
Zhao, 2012a] and SpacePAC [Ryslik and Zhao, 2013] packages already available
through Bioconductor. Sperciﬁcally, the package takes as input the quaternary
protein structure as well as the mutational data for each subunit of the assembly.
It then maps the mutational data onto the protein and performs the algorithms
described in iPAC, GraphPACand SpacePAC to report the statistically sig-
niﬁcanct clusters. By integrating the quartneray structure, QuartPAC may
identify additional clusters that only become apparent when the diﬀerent pro-
tein subunits are considered together.

1

Introduction

Recent advances in oncogenic pharmacology [Croce, 2008] have led to the cre-
ation of a variety of methods that attempt to identify mutational hotspots as
these hotspots are often indicative of driver mutations [Wagner, 2007, Zhou
et al., 2008, Ye et al., 2010]. Three recent methods, iPAC, GraphPAC and
SpacePAC provide approaches to identify such hotspots while accounting for
protein tertiary structure. While it has been shown that these mutations provide
an improvement over linear clustering methods, [Ryslik et al., 2013, 2014b,a],
they nevertheless consider only tertiary structure. QuartPAC, preprocesses
the entire assembly structure in order to be able to accurately run these ap-
proaches on the quaternary protein unit. This allows for the identiﬁcation of

1

additional mutational clusters that may otherwise be missed if only one protein
subunit is considered at a time.

In order to run QuartPAC, four sources of data are required:

(cid:136) The amino acid sequence of the protein which is obtained from the UniProt

database (uniprot.org in FASTA format).

(cid:136) The protein tertiary subunit information which is obtained from the .pdb

ﬁle from PDB.org

(cid:136) The quaternary structural information for the entire assembly which is

obtained from the .pdb1 ﬁle from PDB.org

(cid:136) The somatic mutation data which is obtained from the Catalogue of So-

matic Mutations in Cancer (http://cancer.sanger.ac.uk/cancergenome/
projects/cosmic/).

In order to map the mutations onto the protein quaternary structure, an
alignment must be performed. For each uniprot within the assembly, mutational
data must be provided. The data is in the format of m × n matrices for every
subunit. A “1” in the (i, j) element indicates that residue j for individual i
has a mutation while a “0” indiciates no mutation. To be compatible with this
software, please ensure that your mutation matrices have R column headings
of V 1, V 2, · · · , V n. Only missense mutations are currently supported, indels in
the amino acid sequence are not. Sample mutational data are included in this
package as textﬁles in the extdata folder.

It is worth nothing that there does not exist any one individual source to
obtain mutational data. One common resource is the COSMIC database http:
//cancer.sanger.ac.uk/cancergenome/projects/cosmic/. The easiest way
to obtain mutational data for many proteins is to load the the COSMIC database
on a local sql server and then query the database for the protein of interest.
It is important to restrict your query to whole gene screens or whole genome
studies to prevent speciﬁc mutations from being selectively chosen (and thus
violating the uniformity assumption that iPAC, GraphPAC, and SpacePAC
rely upon).

Should you ﬁnd a bug, or wish to contribute to the code base, please contact

the author.

2

Identifying Clusters and Viewing the Remap-
ping

The general principle of QuartPAC is that we preprocess the data into a format
that can be recognized by iPAC, GraphPAC and SpacePAC. Most of this
is automated and all that is needed is to point the algorithm to the mutational
and structural data. QuartPAC will then reorganize the data, execute the
cluster ﬁnding algorithms and report the results. The clusters are reported by

2

serial number. As each serial number is unique in the assembly, the user can
then map each serial number to the exact atom of interest in the structure.

Below we run the algorithm with no multiple comparison adjustment. We
do this to ensure that some clusters are found for each method. We also note
that for iPAC and GraphPAC, if a multiple comparison adjustment is used
and no clusters are found signiﬁcant, the methods will show a null value. For
SpacePAC, as there is no multiple comparison adjustment needed, the most
signiﬁcant clusters are always shown, regardless of the p-value. This behavior
follows the functionality of the previous three packages, so users familiar with
the tertiary algorithms will ﬁnd the results directly comparable.

For more information on the output, please see the iPAC,GraphPAC, and
SpacePAC packages as the output is similar. The main diﬀerence is that the
amino acid numbers now refer to the serial numbers within the *.pdb1 ﬁle.

Code Example 1: Running QuartPAC.

> library(QuartPAC)
> #read the mutational data
> mutation_files <- list(
+ system.file("extdata","HFE_Q30201_MutationOutput.txt", package = "QuartPAC"),
+ system.file("extdata","B2M_P61769_MutationOutput.txt", package = "QuartPAC")
+ )
> uniprots <- list("Q30201","P61769")
> mutation.data <- getMutations(mutation_files = mutation_files, uniprots = uniprots)
> #read the pdb file
> pdb.location <- "https://files.rcsb.org/view/1A6Z.pdb"
> assembly.location <- "https://files.rcsb.org/download/1A6Z.pdb1"
> structural.data <- makeAlignedSuperStructure(pdb.location, assembly.location)
> #Perform Analysis
> #We use a very high alpha level here with no multiple comparison adjustment
> #to make sure that each method provides shows a result.
> #Lower alpha cut offs are typically used.
> quart_results <- quartCluster(mutation.data, structural.data, perform.ipac = "Y",
+
+
+
+

perform.graphpac = "Y", perform.spacepac = "Y",
create.map = "Y",alpha = .3,MultComp = "None",
Graph.Title ="MDS Mapping to 1D Space",
radii.vector = c(1:3))

We observe that the MDS remapping plot provided by QuartPAC is done
automatically if the create.map parameter is set to “Y”. The plot is shown in
Figure 1 below.

For the GraphPAC approach, the linear “Jump Plot” (see the GraphPAC
package for more details and interpretation) has been implemented and is shown
in Figure 2 below. Feel free to contact the author if you want to assist in porting
other graphing functionality.

With regards to SpacePAC, as there is no remapping from 3D to 1D space,
a plotting option that shows the protein in its folded state is presented in Section
4.

3

Figure 1: Remapping performed by iPAC.

Code Example 2: Plotting the GraphPAC candidate path.

> Plot.Protein.Linear(quart_results$graphpac$candidate.path, colCount = 10,
+

title = "Protein Reordering to 1D Space via GraphPAC")

4

MDS Mapping to 1D Space−30−20−10  0 10 20 30 40 0102030405060708010203040506070x−axisy−axisz−axisllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllFigure 2: Remapping performed by GraphPAC.

5

Protein Reordering to 1D Space via GraphPAC21319293543536573849296101107116121129137141149155163174183188196200212219227235244252263270281293301311316322333344351360367378385392406411416421426431437443452460474479488496501510516524533537551559569577588595602610621635642650658667675685693703709718727733743750758767774782790794800809817826831839847853860869873885899908920924936944948957965975983992100310091016102410311039104710611072107710821091109811091114112811351142115111591168118211911202121212211229124012451256126512731284128913011309131813291337134313501355136413721381139013981406141514231427143214361443145114591468147714841491149815061513152215291536154615561563157015761582158915961603161116221628163916441652166016721684169117001708171617231731174017541762177117791788179718041812182018251834184318541863187018791887189419021909191719211929193319401952196119651979198719942002200720142021202820322041205020592070208220892095210421112120213021372141214921572166217321812189219622042220222822372248225522622271227922882295230723132324233423412346235523632367237623822390240124092417242324352442244824522463247324802486249425022511251825262534254225512559256325722583259126002605261226212631263726452653265926702676268526932707271327242736274427522764277627832792280328102817282428332838284628552867287228782889289629042914292129282936294229512958296729752982299130053013302430323 Using the Output

Now that we have the results, suppose that we wanted to visualize what the
clusters are. For example, we see that the ﬁrst cluster under the SpacePAC
method for the optimal combination has two spheres. One sphere is centered at
the atom with serial number 1265 and one sphere is centered at the atom with
serial number 367.

To see where this matches we can query the structural.data list.

Code Example 3: Finding the residue of interest using the SpacePAC method.

> #look at the results for the optimal sphere combinations under the SpacePAC approach
> #For clarity we only look at columns 3 - 8 which show the sphere centers.
> quart_results$spacepac$optimal.sphere[,3:8]

Center1 Center2 Start1 End1 Start2 End2
367 367
367 367
367 367
1265 1265
367 367
1265 1265
367 367
1265 1265
2166 2166
367 367
1265 1265
2166 2166
367 367
1265 1265
2166 2166
2295 2295
1265 1265
2166 2166
2295 2295
2166 2166
2295 2295
2401 2401
2295 2295
2401 2401
2401 2401
2583 2583
2583 2583
2659 2659

1265 1265
2166 2166
2295 2295
2166 2166
2401 2401
2295 2295
2583 2583
2401 2401
2295 2295
2659 2659
2583 2583
2401 2401
2846 2846
2659 2659
2583 2583
2401 2401
2846 2846
2659 2659
2583 2583
2846 2846
2659 2659
2583 2583
2846 2846
2659 2659
2846 2846
2659 2659
2846 2846
2846 2846

1265
2166
2295
2166
2401
2295
2583
2401
2295
2659
2583
2401
2846
2659
2583
2401
2846
2659
2583
2846
2659
2583
2846
2659
2846
2659
2846
2846

367
367
367
1265
367
1265
367
1265
2166
367
1265
2166
367
1265
2166
2295
1265
2166
2295
2166
2295
2401
2295
2401
2401
2583
2583
2659

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28

> #Find the atom with serial number 1265
> required.row <- which(structural.data$aligned_structure$serial == 1265)
> #show the information for that atom
> structural.data$aligned_structure[required.row,]

recordName serial atom altLoc resName chainID resSeq iCode xCoord yCoord
5.743 52.485
ASN

ATOM

1265

157

CA

A

1:

6

zCoord occupancy tempFactor element charge

1: 13.919

1

42.28

C

canonical_pos
179

1:

>

UNP dbref protomer absPos
154

1

1

Q30201

Similarly, suppose you wanted to look at the iPAC results. The ﬁrst cluster
goes from serial 2583 and ends at 2846. To get all the residue information for
that block, we can do the following:

Code Example 4: Finding the residue of interest using the iPAC method.

> #look at the results for the first cluster shown by the ipac method
> quart_results$ipac

AA_in_Cluster serial_start serial_end number

V254
V172
V274
V254
V274
V254
V172
V274
V180
V172
V172
V278
V303
V180

32
22
55
52
14
37
62
29
304
283
47
68
83
222

2583
2659
2401
2166
2295
2295
2166
2166
367
367
2295
2295
2166
367

2846
2846
2846
2583
2401
2583
2659
2401
2846
2659
2659
2846
2846
2166

p_value
3 0.03093808
2 0.04285346
4 0.05244236
4 0.07721776
2 0.08306777
3 0.09028823
5 0.10970551
3 0.12480796
8 0.12630378
7 0.16003397
4 0.16898693
5 0.19414336
6 0.24825087
3 0.25497859

> #Find the atoms with serial numbers within the range of 2583 to 2846
> required.rows <- which(structural.data$aligned_structure$serial %in% (2583:2846))
> #show the information for those atoms
> structural.data$aligned_structure[required.rows,]

recordName serial atom altLoc resName chainID resSeq iCode xCoord yCoord
12.885 19.924
ILE
12.538 18.636
GLU
9.370 18.878
LYS
9.120 22.638
VAL
7.189 24.889
GLU
7.867 28.493
HIS
5.976 31.273
SER
7.479 32.937
ASP
10.283 35.432
LEU
8.837 38.923
SER
9.783 42.469
PHE
8.257 45.640
SER
8.243 49.331
LYS
11.745 49.858
ASP

ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM

2583
2591
2600
2605
2612
2621
2631
2637
2645
2653
2659
2670
2676
2685

46
47
48
49
50
51
52
53
54
55
56
57
58
59

CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA

B
B
B
B
B
B
B
B
B
B
B
B
B
B

1:
2:
3:
4:
5:
6:
7:
8:
9:
10:
11:
12:
13:
14:

7

15:
16:
17:
18:
19:
20:
21:
22:
23:
24:
25:
26:
27:
28:
29:
30:
31:
32:

2693
2707
2713
2724
2736
2744
2752
2764
2776
2783
2792
2803
2810
2817
2824
2833
2838
2846

ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM
ATOM

13.026 47.034
TRP
13.661 44.800
SER
12.750 41.139
PHE
10.369 38.996
TYR
9.841 35.241
LEU
7.561 33.020
LEU
8.522 29.543
TYR
5.960 27.185
TYR
5.265 23.560
THR
2.275 21.616
GLU
3.018 20.246
PHE
1.565 19.125
THR
3.166 20.559
PRO
3.655 18.871
THR
5.166 19.946
GLU
8.589 18.374
LYS
8.895 19.872
ASP
10.881 23.063
GLU
recordName serial atom altLoc resName chainID resSeq iCode xCoord yCoord
zCoord occupancy tempFactor element charge

CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA
CA

60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77

B
B
B
B
B
B
B
B
B
B
B
B
B
B
B
B
B
B

1: 45.964
2: 42.427
3: 40.348
4: 40.986
5: 38.587
6: 37.552
7: 35.791
8: 32.724
9: 33.143
10: 32.873
11: 33.932
12: 35.371
13: 34.385
14: 35.795
15: 33.576
16: 36.581
17: 36.218
18: 38.234
19: 38.323
20: 40.370
21: 41.587
22: 43.115
23: 44.155
24: 45.397
25: 48.852
26: 52.163
27: 55.294
28: 58.669
29: 61.984
30: 61.405

1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

59.61
75.66
82.60
72.00
65.40
59.43
54.96
54.99
43.17
43.06
36.56
40.60
42.56
41.40
34.49
35.68
33.38
42.58
36.62
38.86
49.21
54.28
59.26
66.25
59.77
67.36
68.86
73.63
84.25
87.62

C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C
C

8

UNP dbref protomer absPos
318
319
320
321
322
323
324
325
326
327
328
329
330
331
332
333
334
335
336
337
338
339
340
341
342
343
344
345
346
347

P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769
P61769

2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2

1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1
1

P61769
P61769

348
349
UNP dbref protomer absPos

1
1

2
2

31: 57.911
32: 57.189

1
1

77.81
68.89

C
C

zCoord occupancy tempFactor element charge
canonical_pos
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
canonical_pos

1:
2:
3:
4:
5:
6:
7:
8:
9:
10:
11:
12:
13:
14:
15:
16:
17:
18:
19:
20:
21:
22:
23:
24:
25:
26:
27:
28:
29:
30:
31:
32:

As the GraphPAC results are in the same format as the iPAC results, the
approach for identifying clusters in those atoms is identical as in the example
above.

4 Visualizing the Results

Once you have the serial numbers of interest, you can then view the results
in any pdb visualization application of your choice. One common option is to
use the PyMOL software package [Schr¨odinger, LLC, 2010]. While it is not
the purpose of this vignette to teach the reader PyMOL syntax, we present the
following simplistic example and the resulting ﬁgure for reference. It will color

9

the ﬁrst cluster outputted by the iPAC method, residues with serial numbers
2583-2846 in blue. The chain and resSeq information provided in Example 4 is
used as below.

Code Example 5: PyMOL sample code
-----------------------------------
hide all
show cartoon,
show spheres, ///b/46/ca
show spheres, ///b/77/ca
color blue, ///b/46-77

label c. B and n. CA and i. 46, "(%s, %s)" % (resn, resi)
label c. B and n. CA and i. 77, "(%s, %s)" % (resn, resi)
set label_position, (3,2,10)

10

References

Carlo M Croce. Oncogenes and cancer. The New England Journal of Medicine,
358(5):502–511, January 2008. ISSN 1533-4406. doi: 10.1056/NEJMra072367.
URL http://www.ncbi.nlm.nih.gov/pubmed/18234754. PMID: 18234754.

Gregory Ryslik and Hongyu Zhao. GraphPAC: Identiﬁcation of Mutational
Clusters in Proteins via a Graph Theoretical Approach., 2012a. R package
version 1.6.0.

Gregory Ryslik and Hongyu Zhao. iPAC: Identiﬁcation of Protein Amino acid

Clustering, 2012b. R package version 1.8.0.

Gregory Ryslik and Hongyu Zhao. SpacePAC: Identiﬁcation of Mutational Clus-
ters in 3D Protein Space via Simulation., 2013. R package version 1.2.0.

Gregory A Ryslik, Yuwei Cheng, Kei-Hoi Cheung, Yorgo Modis, and Hongyu
Zhao. Utilizing protein structure to identify non-random somatic muta-
tions. BMC Bioinformatics, 14(1):190, 2013. ISSN 1471-2105. doi: 10.1186/
1471-2105-14-190. URL http://www.biomedcentral.com/1471-2105/14/
190.

Gregory A Ryslik, Yuwei Cheng, Kei-Hoi Cheung, Robert D Bjornson, Daniel
Zelterman, Yorgo Modis, and Hongyu Zhao. A spatial simulation ap-
proach to account for protein structure when identifying non-random so-
matic mutations. BMC Bioinformatics, 15(1):231, 2014a.
ISSN 1471-
2105. doi: 10.1186/1471-2105-15-231. URL http://www.biomedcentral.
com/1471-2105/15/231.

Gregory A Ryslik, Yuwei Cheng, Kei-Hoi Cheung, Yorgo Modis, and Hongyu
Zhao. A graph theoretic approach to utilizing protein structure to iden-
tify non-random somatic mutations. BMC Bioinformatics, 15(1):86, 2014b.
ISSN 1471-2105.
URL http://www.
biomedcentral.com/1471-2105/15/86.

10.1186/1471-2105-15-86.

doi:

Schr¨odinger, LLC. The PyMOL molecular graphics system, version 1.3r1. Py-
MOL, The PyMOL Molecular Graphics System, Version 1.3, Schr¨odinger,
LLC., August 2010.

A. Wagner. Rapid detection of positive selection in genes and genomes through
ISSN 0016-
variation clusters. Genetics, 176(4):2451–2463, August 2007.
6731. doi: 10.1534/genetics.107.074732. URL http://www.genetics.org/
cgi/doi/10.1534/genetics.107.074732.

Jingjing Ye, Adam Pavlicek, Elizabeth A Lunney, Paul A Rejto, and Chi-Hse
Teng. Statistical method on nonrandom clustering with application to so-
matic mutations in cancer. BMC Bioinformatics, 11(1):11, 2010. ISSN 1471-
2105. doi: 10.1186/1471-2105-11-11. URL http://www.biomedcentral.
com/1471-2105/11/11.

11

Tong Zhou, Peter J. Enyeart, and Claus O. Wilke. Detecting clusters of
mutations. PLoS ONE, 3(11):e3765, November 2008.
ISSN 1932-6203.
doi: 10.1371/journal.pone.0003765. URL http://dx.plos.org/10.1371/
journal.pone.0003765.

12

