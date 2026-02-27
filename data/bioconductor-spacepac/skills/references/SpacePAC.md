SpacePAC: Identifying mutational clusters in
3D protein space using simulation.

Gregory Ryslik
Yale University
gregory.ryslik@yale.edu

Yuwei Cheng
Yale University
yuwei.cheng@yale.edu

Hongyu Zhao
Yale University
hongyu.zhao@yale.edu

October 30, 2017

Abstract

The SpacePAC package is designed to identify mutated amino acid hotspots
while taking into account tertiary protein structure. This package is meant
to complement the iPAC [Ryslik and Zhao, 2012b] and GraphPAC [Ryslik
and Zhao, 2012a] packages already available in Bioconductor. Speciﬁcally, this
method identiﬁes the 1,2, or 3 spheres that cover the most number of muta-
tions and by using simulation, provides a p-value if the spheres hold enough
mutations to be statistically signiﬁcant. The package also allows one to use a
Poisson distribution to ﬁnd the most signiﬁcant sphere. Both the simulation
and Poisson methods allow the user to consider spheres of multiple radii when
ﬁnding the mutational hotspots. By providing an approach that identiﬁes mu-
tational hotspots directly in 3D space, we provide an alternative to the iPAC
and GraphPAC methods which ultimately rely on remapping the protein to
one dimensional space.

1

Introduction

Recent pharmacological advances in treating oncogenic driver mutations [Croce,
2008] has led to the development of multiple methods to identify amino acid
mutational hotspots. Two recent methods, iPAC and GraphPAC provided
an extension to the NMC algorithm [Ye et al., 2010] by taking into account
protein tertiary structure. Both iPAC and GraphPAC remap the protein
to 1D space (iPAC via MDS and GraphPAC via a graph theoretic method)
in order to apply the NMC methodology which relies upon order statistics.

1

While the remapping increases the sensivity of the algorithm and leads to the
identiﬁcation of novel clusters, it nevertheless requires remapping the protein to
1D space which resulting in information loss. Here we present two methods that
consider the protein directly in 3D space to identify mutational hotspots. This
allows us to forgo the 1D requirement that was ultimately emposed by both
iPAC and GraphPAC.

As in iPAC and GraphPAC, in order to run the clustering methodology,

three types of data are required:

(cid:136) The amino acid sequence of the protein that we obtain from the Sanger

Institute or the Uniprot database in FASTA format.

(cid:136) The protein tertiary structure that we obtain from the Protein Data Bank.

(cid:136) The somatic mutation data that we obtain from the Catalogue of Somatic

Mutations in cancer.

An alignment (or some other alternative renconciliation) algorithm must be
used to reconcile the structural and mutational data. The mutational data must
be in the format of an m×n matrix for a protein that is n amino acids long. A “1”
in the (i, j) element indicates that residue j for individual i has a mutation while
a “0” indiciates no mutation. To be compatible with this software, please ensure
that your mutation matrix has the R column headings of V 1, V 2, · · · , V n. Only
missense mutations are currently supported, indels in the amino acid sequence
are not. Sample mutational data for KRAS and PIK3cα are included in this
package as data sets. For a full description on how to extract correct mutational
and positional data, please see the iPAC documentation as the procedure is
identical to what is documented there. For the remainder of this vignette, we
assume the user is familiar with get.AlignedPositions, get.Positions, and the
mutation data format.

Note, that there is no one source to obtain the mutational data and that this
often requires prior work on the part of the user. One free source of data is the
COSMIC database http://cancer.sanger.ac.uk/cancergenome/projects/
cosmic/. Should you choose to use COSMIC, a local SQL server is required to
load the mutational database and custom query must be made for the gene of
interest. Note, that the mutational data should come from whole gene screens
or whole genome studies. Mutational data can not be selectively chosen as this
will violate the uniformatiy assumption that the algorithm requires to run.

Should you ﬁnd a bug, or wish to contribute to the code base, please contact

the author.

2

Identifying Clusters Via Simulation

The general principle here is that we ﬁnd the 1, 2 or 3 non-overlapping spheres
that cover as many of the mutations as possible. We then simulate the muta-

2

tions uniformly over the protein and use this distribution to calculate p values.
Speciﬁcally, we proceed as follows:

(cid:136) Let s be the number of spheres. s ∈ {1, 2, 3}.

(cid:136) Let r be the radius currently being considered. Typically, r ∈ {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

and, if the data is obtained from the PDB, is measured in angstroms. For
instance, when r = 5 all residues within 5 angstroms of the center of the
sphere are included within the sphere.

(cid:136) Simulate N ≥ 1000 distributions of the mutations over the protein struc-

ture.

Next, let X0,s,r respresent the number of mutations captured within the
spheres centered at residues p1, p2, p3 for the observed data. The centers p1, p2, p3
are chosen in a way such that the spheres capture as many mutations as possible
(See Section 2.1). Further, s represents the maximum number of spheres con-
sidered (s ∈ {1, 2, 3}). Let Xi,s,r represent the same but for simulation i. For
{Xi,s,r}. For
a given {s, r}, calculate µs,r = mean
1≤i≤N

{Xi,s,r} and σs,r = std. dev.

1≤i≤N

each simulation, then calculate Zi = maxi{(Xi,s,r − µs,r)/σs,r}. The p-value is
is then found as: ((cid:80) 1Z0>Zi)/N .

This process is best seen through Figure 1 below:

Figure 1: Here we consider radii of 3 and 9 angstroms and want consider up to
3 spheres when identifying mutational hotspots (hence the number of spheres
goes from 1 to 3). First, µ and σ are calculated over each column. Next, we
normalize each entry in the column by calculating Zi,s,r = Xi,s,r−µs,r
. We then
take the maximum over each row to get Z0, ..., Z1000. The percentage of times
Z0 ≥ Zi where i ∈ {1, ..., 1000}, is the p-value of our observed statistic Z0 (Z0
is referred to as the Z.Score in the man pages and output.

σs,r

An example of the code and ouput is shown in Example 1 below. The sam-
ple code below allows up to 3 spheres (3 hotspots) but it can be set to only
consider up to 1 or 2 spheres. We also consider 4 radii in the code below but
you can consider as many sizes as you want. Note that the larger the radii, the
more diﬃcult it is to ﬁnd non-overlapping spheres which increases the running
time. Also, if the sphere sizes are too large, it might be impossible to ﬁnd non-
overlapping spheres. See Section 2.1 for the algorithm we use to identify the

3

Radius:Num Spheres:123123obsi=1i=2i=3…………………….i=1000r=3r=9(cid:1)(cid:2),(cid:4),(cid:5)(cid:1)(cid:2),(cid:6),(cid:5)(cid:1)(cid:2),(cid:5),(cid:5)(cid:1)(cid:2),(cid:4),(cid:7)(cid:1)(cid:2),(cid:6),(cid:7)(cid:1)(cid:2),(cid:5),(cid:7)(cid:1)(cid:4),(cid:4),(cid:5)(cid:1)(cid:4),(cid:6),(cid:5)(cid:1)(cid:4),(cid:5),(cid:5)(cid:1)(cid:4),(cid:4),(cid:7)(cid:1)(cid:4),(cid:6),(cid:7)(cid:1)(cid:4),(cid:5),(cid:7)(cid:1)(cid:6),(cid:4),(cid:5)(cid:1)(cid:6),(cid:6),(cid:5)(cid:1)(cid:6),(cid:5),(cid:5)(cid:1)(cid:6),(cid:4),(cid:7)(cid:1)(cid:6),(cid:6),(cid:7)(cid:1)(cid:6),(cid:5),(cid:7)(cid:1)(cid:5),(cid:4),(cid:5)(cid:1)(cid:5),(cid:6),(cid:5)(cid:1)(cid:5),(cid:5),(cid:5)(cid:1)(cid:5),(cid:4),(cid:7)(cid:1)(cid:5),(cid:6),(cid:7)(cid:1)(cid:5),(cid:5),(cid:7)(cid:1)(cid:4)(cid:2)(cid:2)(cid:2),(cid:4),(cid:5)(cid:1)(cid:4)(cid:2)(cid:2)(cid:2),(cid:6),(cid:5)(cid:1)(cid:4)(cid:2)(cid:2)(cid:2),(cid:5),(cid:5)(cid:1)(cid:4)(cid:2)(cid:2)(cid:2),(cid:4),(cid:7)(cid:1)(cid:4)(cid:2)(cid:2)(cid:2),(cid:6),(cid:7)(cid:1)(cid:4)(cid:2)(cid:2)(cid:2),(cid:5),(cid:7)Z(cid:9)(cid:10)	max((cid:1)(cid:16),(cid:17),(cid:18)−(cid:20)(cid:17),(cid:18)(cid:21)(cid:22),(cid:23)	)(cid:25)(cid:2)(cid:25)(cid:4)(cid:25)(cid:6)(cid:25)(cid:5)(cid:25)(cid:4)(cid:2)(cid:2)(cid:2)sphere positions.

Code Example 1: Running Spaceclust with 3 spheres with radii 1,2,3,4.

> library(SpacePAC)
> ##Extract the data from a CIF file and match it up with the canonical protein sequence.
> #Here we use the 2ENQ structure from the PDB, which corresponds to the PIK3CA protein.
> CIF <- "http://www.pdb.org/pdb/files/2ENQ.cif"
> Fasta <- "http://www.uniprot.org/uniprot/P42336.fasta"
> PIK3CA.Positions <- get.AlignedPositions(CIF, Fasta, "A")
> ##Load the mutational data for PIK3CA. Here the mutational data was obtained from the
> ##COSMIC database (version 58).
> data(PIK3CA.Mutations)
> ##Identify and report the clusters.
> my.clusters <- SpaceClust(PIK3CA.Mutations, PIK3CA.Positions$Positions, numsims =1000,
+

simMaxSpheres = 3, radii.vector = c(1,2,3,4), method = "SimMax")

Processing radius # 1 : radius length = 1.00 : Percentage complete 0.00
Processing radius # 2 : radius length = 2.00 : Percentage complete 0.25
Processing radius # 3 : radius length = 3.00 : Percentage complete 0.50
Processing radius # 4 : radius length = 4.00 : Percentage complete 0.75

> my.clusters

$p.value
[1] 0.037

$optimal.num.spheres
[1] 3

$optimal.radius
[1] 1

$optimal.sphere

Line.Length1 Line.Length2 Line.Length3 Center1 Center2 Center3 Start1 End1
453 453
1

420

453

345

1

1

Start2 End2 Start3 End3 Positions1 Positions2 Positions3 MutsCount1
1

420 420

345 345

453

420

345

MutsCount2 MutsCount3 MutsCountTotal Z.Score Within.Range1 Within.Range2
420

4 5.099118

453

1

2

Within.Range3 Intersection

345

1

1

1

1

$best.1.sphere

Line.Length Center Start End Positions MutsCount Z.Score Within.Range
345

2 4.896794

345 345

345

345

1

21

$best.2.sphere

4

Line.Length1 Line.Length2 Center1 Center2 Start1 End1 Start2 End2 Positions1
420
453

420 420
453 453

345 345
345 345

420
453

345
345

1
1

1
1

Positions2 MutsCount1 MutsCount2 MutsCountTotal Z.Score Within.Range1
420
453

3 4.896529
3 4.896529

345
345

1
1

2
2

Within.Range2 Intersection

345
345

1
2

1
2

1
2

$best.3.sphere

Line.Length1 Line.Length2 Line.Length3 Center1 Center2 Center3 Start1 End1
453 453
1

420

453

345

1

1

Start2 End2 Start3 End3 Positions1 Positions2 Positions3 MutsCount1
1

420 420

345 345

453

420

345

MutsCount2 MutsCount3 MutsCountTotal Z.Score Within.Range1 Within.Range2
420

4 5.099118

453

2

1

Within.Range3 Intersection

345

1

1

1

1

$best.1.sphere.radius
[1] 1

$best.2.sphere.radius
[1] 2

$best.3.sphere.radius
[1] 1

$bad.2.sphere.message
NULL

$bad.3.sphere.message
NULL

$bad.2.sphere.radii
NULL

$bad.3.sphere.radii
NULL

Using PyMOL [Schr¨odinger, LLC, 2010] (see Section 4), we can now visualize
these spheres in Figure 2 below. If you would like to render one sphere at a time see
make.3D.Sphere for a built in R function.

5

Figure 2: Plotting the 2ENQ structure with the 3 most signiﬁcant spheres as
shown in Code Example 1.

2.1 Quickly Identifying Mutational Positions

In the approach described in Section 2, we ﬁnd the 1, 2 or 3 spheres that cover
the most mutations. If you consider 1 sphere, the number of possible spheres is
linear in the length of the protein (namely, a sphere centered at each residue.) If
we consider 2 spheres, there are (cid:0)n
(cid:1) possible sphere combinations if the protein is
n residues long (and ignoring sphere overlap). If we consider 3 spheres, there are
(cid:1) such combinations. For a medium-sized protein like PIK3Cα which is 1,068
(cid:0)n
3
residues long, considering 3 spheres provides 202,461,116 possible positions. To
quickly ﬁnd the best sphere orientation, we execute Algorithm 1 shown below.
Algorithm 1 is shown for 2 spheres but is trivially extendable to 3 or more as
well.

2

To illustrate how this algorithm works, suppose you have a protein with
5 mutated amino acids. Further, suppose that residue 1 has 50 mutations,
residue 2 has 40 mutations, residue 3 - 30 mutations, residue 4 - 20 mutations
and residue 5 - 10 mutations. For clarity, we proceed with unique mutation
counts on each residue, but the algorithm is unaﬀected if there are identical
counts on some positions. We ﬁrst construct the table shown in Figure 3, with
the inside calculated to be the sum of the number of mutations in amino acid
i and amino acid j. Observing, that the table is symmetric, we only need to
evaluate the residues below the diagonal as the entries on the diagonal come
from residues that overlap one another perfectly.

6

Algorithm 1 Here we are interested in ﬁnding the two non-overlapping spheres
that contain the most mutations.
Require: Sorted vector of counts v with length >= 2

starti = 2;
startj = 1;
k = length(v);
cand = [(starti, startj,v[starti] + v[startj])]
while (!is.empty(cand)) do

index = max(cand) {Comment: max upon the last element in the 3-tuple.}
i,j,s = cand[index]
cand = cand[-index] {Comment: Removes the current max}
if (No overlap between sphere i and j) then

Return (i, j, v[i]+v[j]) {Comment: Successful combination found.}

end if
if (j ==1) and (i < k) then

cand.append((i+1, j,v[i+1] + v[j]))

end if
if (j < i) and (i!= j+1) then

cand.append((i, j+1,v[i] + v[j+1]))

end if
end while
Return NULL {Comment: No succesful combination found.}

Figure 3:
In our example, the protein has 5 residues with mutations. The
residues are sorted from largest to smallest (so mutation 1 has the largest number
of mutations and so forth), and the inside of the table is calculated as the sum
of the mutations on both residues. In the actual code, only the lower half of the
table is considered and then only sequentially to decrease running time, but we
present the whole table here for clarity. Further, in the code, there is no need to
set up a matrix, only the vector of mutation counts and the current location in
that vector need be considered. We present the algorithm here in matrix form
for ease of exposition.

The algorithm then proceeds by appending to the potential “candidate” stack
the element below and the element to the right starting from the (2,1) position.

7

12345Counts5040302010150100908070602409080706050330807060504042070605040305106050403020After every two potential appends (can be 0, 1 or 2) to the stack (assuming
you’re not on an edge and an append is possible), the maximum value over
all the 3-tuple’s third positions is found (thus the max mutation count in both
spheres). The 3-tuple with this maximum value is then evaluated to see if the
spheres overlap. If the spheres do not overlap, then the succesful case has been
found and the algorithm terminates and returns the result. If the spheres do
overlap, the next set of elements are appended to the stack and the process
continues. By proceeding in this way, (pseudocode shown in Algorithm 1),
at each iteration, the pair of spheres being considered contain the maximum
number of mutations possible from the remaining set. Further, we do not need
to consider all the positions as once the ﬁrst pair of non-overlapping spheres
is found, we know that this is the combination of spheres that is both non-
overlapping and captures the most mutations. To see this process, see Figure
4.

Figure 4: Beginning in position (2,1,90), we remove (2,1,90) from the list and ap-
pend [(3,1,80),(2,2,80)]. We then test and remove [(2,2,80)], leaving just (3,1,80)
in the list. After each append to the list, we ﬁnd the max element in the list by
mutation count and pick the element with the maximum number of mutations
between both spheres.

3

Identifying Clusters Via The Poisson Distri-
bution

This function uses a Poisson distribution to ﬁnd signﬁcant spheres. Assuming
there are m total mutations on n amino acids, we ﬁrst calculate an average
mutation rate per amino acid, ¯λ = m/n. We then consider n spheres, where
sphere i ≤ n is centered at amino acid i. For sphere i, we calculate λi,r = ¯λai,r
where ai,r is the number of amino acids within sphere i (with radius r. Finally,
for each sphere we calculate P r(X ≥ x) where x is the observed number of
mutations in the sphere and X follows a Poisson distribution with paramater
λi,r. Given that this calculation occurs n times (once for each sphere), a multiple

8

comparison adjustment (speciﬁed in the “multcomp” parameter) is applied to
account for the multiple spheres. The p-values that are below the signiﬁcance
level α are returned to the user. Finally, if more than one radii is considerd,
each p value is multiplied by the length of the radii vector to account for the
multiple comparisons introduced by considering multiple radii.

Due to the numerous multiple comparison adjustments required, we recom-
mend using the Simulation approach described in Section 2. We have left the
Poisson method in this package in the case that you are only considering one
radius for shorter proteins.

Code Example 2: Running Spaceclust using the Poisson distribution.

> ##Extract the data from a CIF file and match it up with the canonical protein sequence.
> #Here we use the 2ENQ structure from the PDB, which corresponds to the PIK3CA protein.
> CIF <- "http://www.pdb.org/pdb/files/3GFT.cif"
> Fasta <- "http://www.uniprot.org/uniprot/P01116-2.fasta"
> KRAS.Positions <- get.Positions(CIF, Fasta, "A")
> data(KRAS.Mutations)
> ##Identify and report the clusters.
> my.clusters <- SpaceClust(KRAS.Mutations, KRAS.Positions$Positions, radii.vector = c(1,2,3,4),
+

alpha = .05, method = "Poisson")

Processing radius # 1 : radius length = 1.00 : Percentage complete 0.00
Processing radius # 2 : radius length = 2.00 : Percentage complete 0.25
Processing radius # 3 : radius length = 3.00 : Percentage complete 0.50
Processing radius # 4 : radius length = 4.00 : Percentage complete 0.75

> my.clusters

$result.poisson

Line.Length Center Start End Positions MutsCount

P.Value
131 5.723774e-165
131 5.497664e-149
100 2.904602e-114
105 1.867889e-109
31 1.097621e-19

13
12
11
60
14

3
50
3
50
3

13
12
11
60
14

12 14
11 60
10 12
12 61
13 15

12, 13
12, 13
12
12, 61
13

Within.Range
12, 13, 14
13
12 11, 12, 13, 60
11
10, 11, 12
60 12, 59, 60, 61
13, 14, 15
14

$best.radii
[1] 4

4 Plotting

SpacePAC provides simpliﬁed plotting functionality. The function takes in
the position matrix, the amino acid number at which the sphere should be

9

centered as well as the radius of the sphere. The alpha level speciﬁes how
dark or light the shading of the sphere should be. Only 1 sphere is able to be
plotted at this time. For more advanced rendering options, we recommend the
user to consider using the software package PyMOL at http://www.pymol.org
[Schr¨odinger, LLC, 2010].

The code renders the protein and sphere using the rgl package. Please run
?make.3D.Sphere for the syntax options. A ﬁgure of the KRAS protein with a
sphere around residue 12 with a radius equal to 3 is shown below.

Code Example 3: Making a Plot.

>
>
>
>
>
>

##To avoid RGL errors, this code is not run. However it has been tested and verified.
#library(rgl)
#CIF <- "http://www.pdb.org/pdb/files/3GFT.cif"
#Fasta <- "http://www.uniprot.org/uniprot/P01116-2.fasta"
#KRAS.Positions <- get.Positions(CIF, Fasta, "A")
#make.3D.Sphere(KRAS.Positions$Positions, 12, 3)

10

Figure 5: Screenshot of RGL graphics of KRAS structure with sphere of radius
3 at residue 12. The RGL window that will open is interactive and allows the
protein to be rotated.

References

Carlo M Croce. Oncogenes and cancer. The New England Journal of Medicine,
358(5):502–511, January 2008. ISSN 1533-4406. doi: 10.1056/NEJMra072367.
URL http://www.ncbi.nlm.nih.gov/pubmed/18234754. PMID: 18234754.

Gregory Ryslik and Hongyu Zhao. GraphPAC: Identiﬁcation of Mutational
Clusters in Proteins via a Graph Theoretical Approach, 2012a. R package
version 1.0.0.

Gregory Ryslik and Hongyu Zhao. iPAC: Identiﬁcation of Protein Amino acid

Clustering, 2012b. R package version 1.2.0.

11

Schr¨odinger, LLC. The PyMOL molecular graphics system, version 1.3r1. Py-
MOL, The PyMOL Molecular Graphics System, Version 1.3, Schr¨odinger,
LLC., August 2010.

Jingjing Ye, Adam Pavlicek, Elizabeth A Lunney, Paul A Rejto, and Chi-Hse
Teng. Statistical method on nonrandom clustering with application to so-
matic mutations in cancer. BMC Bioinformatics, 11(1):11, 2010. ISSN 1471-
2105. doi: 10.1186/1471-2105-11-11. URL http://www.biomedcentral.
com/1471-2105/11/11.

12

