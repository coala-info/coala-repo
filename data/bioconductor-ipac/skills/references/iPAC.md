iPAC: identifcation of Protein Amino acid
Mutations

Gregory Ryslik
Yale University
gregory.ryslik@yale.edu

Hongyu Zhao
Yale University
hongyu.zhao@yale.edu

October 30, 2017

Abstract

The iPAC package provides a novel tool to identify somatic mutation
clustering of amino acids while taking into account their three dimen-
sional structure. Currently, iPAC maps the protein’s amino acids into a
one dimensional space while preserving, as best as possible, the three di-
mensional local neighbor relationships. Mutation clusters are then found
by considering if pairwise mutations are closer together than expected by
chance alone via the the Nonrandom Mutation Clustering (NMC) algo-
rithm [Ye et al., 2010]. Finally, the clustering results are mapped back
onto the original protein and reported back to the user. A paper detail-
ing this methodology and results is currently in preparation. Additional
methodologies based on diﬀerent algorithms will be added in the future.

1

Introduction

Recently, there have been signiﬁcant pharmacological advances in treating on-
congenic driver mutations [Croce, 2008]. Several methods that rely on amino
acid mutational clusters have been developed in order to identify these muta-
tions. One of the most recent methods was presented by Ye et al. [2010]. Their
algorithm identiﬁes mutation clusters by calculating whether pairwise mutations
are closer on the the line than expected by chance alone when assuming that
each amino acid has an equal probability of mutation. As their algorithm re-
lies on considering the protein in linear form, it can potentially exclude clusters
that are close together in 3D space but far apart in 1D space. This package is
speciﬁcally designed to overcome this limitation.

Currently, this package has two methods that deal with the 3D structure of
the protein: 1) linear and 2) MDS [Borg and Groenen, 1997]. The user should
primarily use MDS as it is more statistically rigorous. We include the linear
method as an example that the general package is itself ﬂexible. Should the
user want to map the protein to 1D space using their own algorithm, they can
thus do so.

1

If users want to contribute to the code base, please contact the author.

2 The NMC Algorithm

The NMC algorithm, proposed by Ye et al. [2010], ﬁnds mutational clusters
when the protein is considered to be a straight line. While the full alogrithm is
presented in their paper, we provide a brief overview here for completeness.

Suppose that the protein was N amino acids long and that each amino acid
N probability of mutation. We can then construct order statistics over

had a 1
many samples as follows:

Figure 1: Three samples of the same protein. An asterisk above a number
indicates a non-synonomous mutation in that sample for that amino acid.

Letting Rk,i = X(k) − X(i), one can calculate if the P r(Rk,i ≤ r) ≤ α using
well known results about order statistics on the uniform distribution. While
discrete formulas exist for P r(Rk,i ≤ r), they are often too costly to calculate
when Rk,i > 1. In these cases, we scale the protein onto the interval (0,1) by
calculating P r( X(k)−X(i)
≤ r) which turns out to equal P r(Beta(k − i, i + n −
k + 1) ≤ r). Finally, since this calculation is done for every pair of mutations in
the protein, a multiple comparisons adjustment is performed.

N

The original NMC algorithm is included in this package via the nmc com-

mand. We provide an example of its use below.

First, we load iPAC and then the mutation matrix. The mutation matrix
is a matrix of 0’s and 1’s where each column represents an amino acid in the
protein and each row represents a sample (or a mutation). Thus, the entry for
row i column j, represents the ith sample (or mutation) and the jth amino acid.

Code Example 1: Running the NMC algorithm

> library(iPAC)
> #For more information on the mutations matrix,
> #type ?KRAS.Mutations after executing the line below.
> data(KRAS.Mutations)
> nmc(KRAS.Mutations, alpha = 0.05, multtest = "Bonferroni")

2

cluster_size start end number

V12
V12
V12
V12
V12
V13
V12
V12
V13
V13
V146

2
1
11
12
50
1
106
135
10
11
1

12 13
12 12
12 22
12 23
12 61
13 13
12 117
12 146
13 22
13 23
146 146

p_value
131 1.979447e-235
100 6.486735e-188
132 3.220145e-145
133 6.524053e-142
138 4.338908e-65
31 2.732914e-39
139 2.341227e-23
149 1.356584e-20
32 4.487362e-12
33 1.279256e-11
10 1.918440e-08

The results from Code Example 1 show all the statistically signiﬁcant clusters
found, including the size of the cluster, the start and end positions and the
number of mutations in that cluster.

3 Remapping Algorithm

3.1 Matching the Mutation and Position Information

Before we can run the 3D clustering algorithm while, we ﬁrst need to come up
with an alignment between the mutational information provided by a source
such as COSMIC [Forbes et al., 2008] and the positional information provided
by a source such as the PDB [Berman et al., 2000]. Such an alignment is nec-
essary because mutational information is typically provided on the “canonical”
amino acid numbering which often diﬀers from the numbering used in the PDB
database. Thus amino acid #i from the PDB database might not be amino acid
#i from the mutational database.

To solve this problem, we consider the mutational database to contain the
“canonical” ordering of the protein. We then attempt to map the structural
information to the canonical ordering and create a new matrix of residues, their
canonical counts, and their positions in 3D space. If successful, we then have
a relational structure between the two databases allowing us to refer to amino
acid #i where i represents the same amino acid in both databases.

We have created two methods that allow one to construct such a matrix:

1)get.Positions and 2)get.AlignedPositions.

The ﬁrst method, get.Positions attemps to create the position matrix di-
rectly from the CIF ﬁle in the PDB database. It returns a list of several items,
the ﬁrst of which is $Positions, which must later be passed to the ClusterFind
method. Due to the complexity of CIF ﬁles, get.Positions currently works on
approximately 70% of the structures in the PDB database.

The second method, get.AlignedPositions performs a pairwise alignment
algorithm to align the canonical protein ordering with the XYZ positions in
the PDB. Since get.AlignedPositions runs an alignment algorithm, the ordering
might not be perfect and we recommend the user to verify the results. However,

3

from our testing, the alignment procedure works quite well. Furthermore, since
get.AlignedPositions does not have to consider as many aspects of the CIF ﬁle,
it is more robust and often works when get.Positions fails.

Let us ﬁrst consider the get.Positions function. We will consider three exam-
ples, one for KRAS protein and two for the PIK3CA protein. For each example,
we need to input the location of the CIF ﬁle (this holds the structural informa-
tion), the location of the FASTA ﬁle (this holds the canonical protein sequence)
and the sidechain that we want to use from the CIF ﬁle.

As the entire position sequence is too long to print, we ﬁrst save the result
and then print the ﬁrst 10 rows of the position matrix. The remaining elements
of the result are printed in full.

Code Example 2: Extracting positions using the get.Positions function

> library(iPAC)
> CIF<-"https://files.rcsb.org/view/3GFT.cif"
> Fasta<-"http://www.uniprot.org/uniprot/P01116-2.fasta"
> KRAS.Positions<-get.Positions(CIF, Fasta, "A")
> names(KRAS.Positions)

[1] "Positions"
[4] "Result"

"External.Mismatch" "PDB.Mismatch"

> KRAS.Positions$Positions[1:10,]

Residue Can.Count SideChain XCoord YCoord ZCoord
A 62.935 97.579 30.223
A 63.155 95.525 27.079
A 65.289 96.895 24.308
A 64.899 96.220 20.615
A 67.593 96.715 18.023
A 65.898 97.863 14.816
A 67.664 98.557 11.533
A 66.263 100.550 8.617
A 67.484 99.500 5.194
A 66.575 100.328 1.605

MET
THR
GLU
TYR
LYS
LEU
VAL
VAL
VAL
GLY

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

> KRAS.Positions$External.Mismatch

PDB.Residue Canonical.Residue Canonical.Num
61

H

Q

1

> KRAS.Positions$PDB.Mismatch

PDB.Residue Canonical.Residue Canonical.Num

Remark
61 SEE REMARK 999

19

H

> KRAS.Positions$Result

Q

4

[1] "OK"

Observe that the ﬁnal element in Code Example 2 is “OK”. That is because
the only mismatched residue (at position 61), was documented in the CIF ﬁle
as well. Thus it is considered a “reconciled” mismatch. It is up to the user to
decide if they want to include it in the position sequence that is passed on to
the ClusterFind method or to remove it.

Code Example 3: Final example of the get.Positions function

> CIF <- "https://files.rcsb.org/view/2RD0.cif"
> Fasta <- "http://www.uniprot.org/uniprot/P42336.fasta"
> PIK3CAV2.Positions <- get.Positions(CIF, Fasta, "A")
> names(PIK3CAV2.Positions)

[1] "Positions"
[4] "Result"

"External.Mismatch" "PDB.Mismatch"

> PIK3CAV2.Positions$Positions[1:10,]

Residue Can.Count SideChain XCoord YCoord ZCoord
A 88.344 61.306 112.918
A 90.119 58.543 111.029
A 92.954 56.400 109.709
A 93.105 53.251 107.542
A 91.616 50.221 109.372
A 90.825 52.285 112.474
A 87.540 54.192 112.953
A 88.806 56.633 115.544
A 92.435 57.520 116.178
A 93.481 57.378 119.852

GLY
GLU
LEU
TRP
GLY
ILE
HIS
LEU
MET
PRO

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

> PIK3CAV2.Positions$External.Mismatch

NULL

> PIK3CAV2.Positions$PDB.Mismatch

NULL

> PIK3CAV2.Positions$Result

[1] "OK"

Observe that the ﬁnal result in Code Example 3 is “OK”. Here we use
a diﬀerent ﬁle location for the canonical sequence – the UNIPROT database.
Here, the canonical sequence is slightly diﬀerent and matches up exactly to the
extracted positions. As there is only 1 isoform listed on UNIPROT for PIK3CA
we suggest using the same source for both the mutational and canonical position

5

information. For example, if your mutation data was obtained from COSMIC,
you should use COSMIC to get the canonical protein sequence.

Let us now consider the get.AlignedPositions function. This function auto-

matically drops positions that do not match up.

Code Example 4: Extracting positions using the get.AlignedPositions function

> CIF<- "https://files.rcsb.org/view/2RD0.cif"
> Fasta <- "http://www.uniprot.org/uniprot/P42336.fasta"
> PIK3CAV3.Positions<-get.AlignedPositions(CIF,Fasta , "A")
> names(PIK3CAV3.Positions)

[1] "Positions"
[5] "Result"

"Diff.Count"

"Diff.Positions"

"Alignment.Result"

> PIK3CAV3.Positions$Positions[1:10,]

Residue Can.Count SideChain XCoord YCoord ZCoord
A 88.344 61.306 112.918
A 90.119 58.543 111.029
A 92.954 56.400 109.709
A 93.105 53.251 107.542
A 91.616 50.221 109.372
A 90.825 52.285 112.474
A 87.540 54.192 112.953
A 88.806 56.633 115.544
A 92.435 57.520 116.178
A 93.481 57.378 119.852

GLY
GLU
LEU
TRP
GLY
ILE
HIS
LEU
MET
PRO

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

> PIK3CAV3.Positions$External.Mismatch

NULL

> PIK3CAV3.Positions$PDB.Mismatch

NULL

> PIK3CAV3.Positions$Result

[1] "OK"

Both get.AlignedPositions and get.Positions are still in beta and are provided
to the user for convenience only. Changes by the PDB or COSMIC to their ﬁle
structure might result in errors and it is up to the user to ensure the correct
data is supplied to the ClusterFind function.

6

3.2 Finding Clusters in 3D Space

Now that we have the positional data, we can ﬁnd the mutational clusters while
taking into account the 3D protein structure. We begin by slecting a method
to map the protein down to a 1D space.

The ﬁrst method, “linear”, ﬁxes a speciﬁed point (x0, y0, z0) and then calcu-
lates the distance from each amino acid to that point. The amino acids are then
rearranged in order from the shortest distance to the longest distance. The sec-
ond method, “MDS”, uses Multidimensional Scaling [Borg and Groenen, 1997]
to map the protein to a 1D space. We strongly encourage the user to employ the
MDS method as it is more statistically rigorous. The linear method is provided
as an example to show how other mapping paradigms might be implemented.

A diagram of either the MDS or linear mapping can be displayed when
the ClusterFind method is run. As the mapping algorithms are diﬀerent, the
mapping images created are diﬀerent as well. The linear method will generate
an image of the distances from (x0, y0, z0) to each amino acid. These distance
will be drawn as dotted green lines from each amino acid to the ﬁxed point.
Conversely, the MDS methodology will create lines from each amino acid to the
x-axis which will mark where on the line the amino acid is positioned.

We begin by ﬁrst running the algorithm on KRAS using the MDS method
followed by the linear method. For a full list of all the possible parameters,
simply type ‘?ClusterFind’ after loading the iPAC library.

Code Example 5: Running the ClusterFind method with a MDS mapping

> #Extract the data from a CIF file and match it up with the canonical protein sequence.
> #Here we use the 3GFT structure from the PDB, which corresponds to the KRAS protein.
> CIF<-"https://files.rcsb.org/view/3GFT.cif"
> Fasta<-"http://www.uniprot.org/uniprot/P01116-2.fasta"
> KRAS.Positions<-get.Positions(CIF,Fasta, "A")
> #Load the mutational data for KRAS. Here the mutational data was obtained from the
> #COSMIC database (version 58).
> data(KRAS.Mutations)
> #Identify and report the clusters.
> ClusterFind(mutation.data=KRAS.Mutations,
+
+
+
+

position.data=KRAS.Positions$Positions,
create.map = "Y", Show.Graph = "Y",
Graph.Title = "MDS Mapping",
method = "MDS")

[1] "Running Remapped"
[1] "Running Full"
[1] "Running Culled"
$Remapped

cluster_size start end number

p_value

7

V136
V136
V121
V124
V136
V121
V124
V124
V121
V93
V93
V73
V73
V93
V142
V73
V142
V124
V121

1
2
49
134
106
57
30
135
50
10
96
11
95
11
1
12
105
1
86

12 12
12 13
13 61
13 146
12 117
61 117
117 146
12 146
12 61
13 22
22 117
13 23
23 117
12 22
13 13
12 23
13 117
146 146
61 146

100 8.932390e-183
131 3.908116e-165
38 3.097954e-124
49 1.017093e-122
139 1.362730e-119
6 3.016259e-106
11 1.666182e-102
149 3.813215e-90
138 2.682445e-87
32 3.434148e-73
8 1.140497e-65
33 1.429105e-53
7 4.204875e-48
132 3.398568e-39
31 8.571798e-38
133 1.963564e-23
39 4.563510e-12
10 3.897757e-08
16 6.115605e-07

$OriginalCulled

cluster_size start end number

V12
V12
V12
V12
V12
V13
V12
V12
V13
V13
V146

$Original

2
1
11
12
50
1
106
135
10
11
1

12 13
12 12
12 22
12 23
12 61
13 13
12 117
12 146
13 22
13 23
146 146

V12
V12
V12
V12
V12
V13
V12
V12
V13
V13

2
1
11
12
50
1
106
135
10
11

12 13
12 12
12 22
12 23
12 61
13 13
12 117
12 146
13 22
13 23

cluster_size start end number

p_value
131 9.453887e-229
100 7.630495e-183
132 1.554973e-138
133 3.526333e-135
138 2.824800e-58
31 8.857871e-38
139 4.538089e-17
149 3.853241e-13
32 8.603544e-11
33 2.553752e-10
10 5.331155e-08

p_value
131 1.979447e-235
100 6.486735e-188
132 3.220145e-145
133 6.524053e-142
138 4.338908e-65
31 2.732914e-39
139 2.341227e-23
149 1.356584e-20
32 4.487362e-12
33 1.279256e-11

8

V146

1

146 146

10 1.918440e-08

$MissingPositions
LHS RHS
[1,] 168 188

Code Example 6: Running the ClusterFind method with a Linear mapping

> #Extract the data from a CIF file and match it up with the canonical protein sequence.
> #Here we use the 3GFT structure from the PDB, which corresponds to the KRAS protein.
> CIF<-"https://files.rcsb.org/view/3GFT.cif"
> Fasta<-"http://www.uniprot.org/uniprot/P01116-2.fasta"
> KRAS.Positions<-get.Positions(CIF,Fasta, "A")
> #Load the mutational data for KRAS. Here the mutational data was obtained from the
> #COSMIC database (version 58).
> data(KRAS.Mutations)
> #Identify and report the clusters.
> ClusterFind(mutation.data=KRAS.Mutations,
+
+
+
+

position.data=KRAS.Positions$Positions,
create.map = "Y", Show.Graph = "Y",
Graph.Title = "Linear Mapping",
method = "Linear")

9

MDS Mapping455055606570758085−10  0 10 20 30 40 80 90100110120x−axisy−axisz−axiscluster_size start end number

[1] "Running Remapped"
[1] "Running Full"
[1] "Running Culled"
$Remapped

V90
V90
V90
V90
V90
V66
V90
V66
V66
V66
V66
V66
V95
V95
V95
V100
V100
V95
V95

1
2
135
50
11
57
12
30
105
96
95
106
1
134
49
1
86
11
10

12 12
12 13
12 146
12 61
12 22
61 117
12 23
117 146
13 117
22 117
23 117
12 117
13 13
13 146
13 61
146 146
61 146
13 23
13 22

$OriginalCulled

V12
V12
V12
V12
V12
V13
V12
V12
V13
V13
V146

$Original

2
1
11
12
50
1
106
135
10
11
1

12 13
12 12
12 22
12 23
12 61
13 13
12 117
12 146
13 22
13 23
146 146

V12
V12
V12
V12
V12

2
1
11
12
50

12 13
12 12
12 22
12 23
12 61

cluster_size start end number

cluster_size start end number

p_value
100 8.862875e-183
131 2.234056e-175
149 2.965106e-158
138 1.092881e-149
132 9.127863e-90
6 3.393497e-89
133 3.393497e-89
11 2.804316e-86
39 5.838579e-79
8 8.125462e-61
7 2.427091e-60
139 2.047918e-48
31 8.857871e-38
49 1.438417e-26
38 9.252899e-22
10 3.897757e-08
16 1.607373e-05
33 8.412719e-04
32 8.663956e-04

p_value
131 9.453887e-229
100 7.630495e-183
132 1.554973e-138
133 3.526333e-135
138 2.824800e-58
31 8.857871e-38
139 4.538089e-17
149 3.853241e-13
32 8.603544e-11
33 2.553752e-10
10 5.331155e-08

p_value
131 1.979447e-235
100 6.486735e-188
132 3.220145e-145
133 6.524053e-142
138 4.338908e-65

10

V13
V12
V12
V13
V13
V146

1
106
135
10
11
1

13 13
12 117
12 146
13 22
13 23
146 146

31 2.732914e-39
139 2.341227e-23
149 1.356584e-20
32 4.487362e-12
33 1.279256e-11
10 1.918440e-08

$MissingPositions
LHS RHS
[1,] 168 188

As can be seen from Code Examples 5 and 6 above, the ClusterFind method
returns a list of four elements. The ﬁrst element, $Remapped, displays all the
clusters found while taking into account the 3D structure of the protein by utiliz-
ing either the linear or MDS methodology. The next element, $OriginalCulled,
displays all the clusters found using the original NMC algorithm after removing
all the amino acids for which we do not have (x, y, z) positions. The $Origi-
nal element displays all the clusters found using the NMC algorithm without
removing the amino acids for which we do not have 3D positional information.
If the user wants to compare the results generated when taking protein struc-
ture into account versus those when protein structure is ignored, it is recom-
mended that the user compare the matrices in $Remapped versus $Original-
Culled. In this way, the user is considering the diﬀerences that arise strictly

11

Linear Mapping455055606570758085−10  0 10 20 30 40 80 90100110120x−axisy−axisz−axisfrom the protein structure as the amino acids with missing 3D positions have
been removed prior to the analysis.

Finally, the $MissingPositions element displays a matrix of all the amino
acids for which we had mutational data but for which we did not have positional
data. For instance, in Code Example 5, the mutation data matrix had 188
columns while we were able to extract positional information only for amino
acids 1-167. Furthermore, amino acid 61 was excluded from the ﬁnal position
matrix when the get.AlignedPositions function was run as the amino acid listed
in the CIF ﬁle did not match the canonical sequence in the FASTA ﬁle. As such,
the $MissingPositions element has a matrix of 2 rows as follows:

$MissingPositions
LHS RHS
[1,] 61 61
[2,] 168 188

References

H. M. Berman, J. Westbrook, Z. Feng, G. Gilliland, T.N. Bhat, H. Weissig, I.N.
Shindyalov, and P.E. Bourne. The protein data bank. Nucleic Acids Research,
ISSN 13624962. doi: 10.1093/nar/28.1.235.
28(1):235–242, January 2000.
URL www.pdb.org.

Ingwer Borg and Patrick J. F Groenen. Modern multidimensional scaling
ISBN 0387948457

theory and applications. Springer, New York, 1997.

:
9780387948454.

Carlo M Croce. Oncogenes and cancer. The New England Journal of Medicine,
358(5):502–511, January 2008. ISSN 1533-4406. doi: 10.1056/NEJMra072367.
URL http://www.ncbi.nlm.nih.gov/pubmed/18234754. PMID: 18234754.

S A Forbes, G Bhamra, S Bamford, E Dawson, C Kok, J Clements, A Men-
zies, J W Teague, P A Futreal, and M R Stratton. The catalogue of so-
matic mutations in cancer (COSMIC). Current Protocols in Human Genetics
/ Editorial Board, Jonathan L. Haines ... [et Al.], Chapter 10:Unit 10.11,
April 2008.
ISSN 1934-8258. doi: 10.1002/0471142905.hg1011s57. URL
http://www.ncbi.nlm.nih.gov/pubmed/18428421. PMID: 18428421.

Jingjing Ye, Adam Pavlicek, Elizabeth A Lunney, Paul A Rejto, and Chi-Hse
Teng. Statistical method on nonrandom clustering with application to somatic
mutations in cancer. 11(1):11, 2010. ISSN 1471-2105. doi: 10.1186/1471-2105-
11-11. URL http://www.biomedcentral.com/1471-2105/11/11.

12

