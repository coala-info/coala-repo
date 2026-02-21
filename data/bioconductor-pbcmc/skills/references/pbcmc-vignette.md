pbcmc: Permutation-Based Conﬁdence for
Molecular Classiﬁcation

Crist´obal Fresno
CONICET
Universidad Cat´olica de C´ordoba

Germ´an A Gonz´alez
CONICET
Universidad Cat´olica de C´ordoba

Andrea S Llera
CONICET
Fundaci´on Instituto Leloir

Elmer A Fern´andez
CONICET
Universidad Cat´olica de C´ordoba

Abstract

The pbcmc package characterizes uncertainty assessment on gene expression classiﬁers,
a. k. a. molecular signatures, based on a permutation test.
In order to achieve this
goal, synthetic simulated subjects are obtained by permutations of gene labels. Then,
each synthetic subject is tested against the corresponding subtype classiﬁer to build the
null distribution. Thus, classiﬁcation conﬁdence measurement reports can be provided
for each subject, to assist physician therapy choice. At present, it is only available for
PAM50 implementation in genefu package but, it can easily be extend to other molecular
signatures.

Keywords: PAM50, single subject classiﬁer, clinical outcome, breast cancer subtype.

1. Introduction

Gene expression-based classiﬁers, known as molecular signatures (MS), are gaining increasing
attention in oncology and market. The MS can be deﬁned as a set of coordinately expressed
genes and an algorithm that use these data to predict disease subtypes, response to therapy,
disease risk and clinical outcome (Andre and Pusztai 2006). Particularly in breast cancer
market there exists many MS such as PAM50 (Perou et al. 2000, 2010), Prosignaﬁ (Nielsen
et al. 2014), Oncotype DXﬁ (Paik et al. 2004) and MammaPrintﬁ (van’t Veer et al. 2002).
In essence, most MS try to provide patient subtype classiﬁcation or risk prediction which has
been associated with distant metastasis free survival (DMFS) or relapse free survival (RFS).
Consequently, they are intended to be used to support therapy choice. However, several
authors have shown that data processing steps, technology, as well as population variability
have an eﬀect on measured gene expression and could bias subtype/risk subject assignment
(Ioannidis 2007; Lusa et al. 2007; Sørlie et al. 2001, 2010; Wu et al. 2012; Ebbert et al. 2011).
These eﬀects suggest that, from a statistical point of view, MS are not robust for subject
classiﬁcation.
In particular, there is no control over type I and II like classiﬁcation error
and subjects could potentially be assigned to a wrong subtype/risk class. Indeed, the lack of
certainty in class assignation could lead to a misleading therapy aﬀecting subject outcome.

2

pbcmc: Permutation-Based Conﬁdence for Molecular Classiﬁcation

Hence, the development of methods for signiﬁcance or certainty on MS class assignation is
crucial in order to assist physicians’ decision making (Wu et al. 2012; Ebbert et al. 2011).

1.1. PAM50 Molecular Signature

The well-known breast cancer (BC) MS, PAM50 (Perou et al. 2000, 2010), is based on the
comparison between the patient gene proﬁles (PGP) of 50 expressed genes, against ﬁve in-
trinsic genes proﬁles (IGP) representing: Basal, Her2-enriched, Luminal A, Luminal B and
Normal-like subtypes using Spearman’s ρ correlation. Then, the subject will be assigned to
the i − th subtype according to (1):

arg max
i∈IGP

ρ(P GP, IGPi)

(1)

Particularly, patients are assigned to the i − th subtype which maximize ρ(P GP, IGPi), even
if correlation is weak or there are similar/tight IGP correlations. The latter case has been
addressed by Cheang et al. (2009), where they have excluded subjects with a correlation
diﬀerence between Luminal A and B of less than 0.1, considering them ambiguous pattern,
as a way to control a kind of type II error. However, type I error control is still a debt.

1.2. genefu library

At present, the freely available PAM50 genefu algorithm implementation (Haibe-Kains et al.
2014), oﬀers a kind of subtype probability, P (IGPi), calculated as (2):

P (IGPi) =

ρ(P GP, IGPi)
i ρ(P GP, IGPi)

(cid:80)

∀ρ(P GP, IGPi) > 0

(2)

However, this probability does not take part in the classiﬁcation rule. Even worse, a very low
ρ (weak relationship) could reach a high subtype probability, for instance, if all the others ρ’s
are close to zero or are even negative.

1.3. Alternative proposal

In order to overcome these drawbacks, here a simple and reliable single subject classiﬁer
to control type I and II errors is proposed. Moreover, it provides a statistical signiﬁcance
on subtype assignation based on a gene label permutation test. Brieﬂy, it evaluates if the
observed ρ of each IGP can be achieved by chance, regarding subject observed MS expressed
gene values.
In addition, we propose a user-friendly subtype assignation panel to support
physicians’ decision making, enhancing PAM50 or commercial reports currently available in
the market. The method is presented for PAM50 but can easily be extended to other MS
algorithms.

2. Methods

The Permutation Based Conﬁdence for Molecular Classiﬁcation (pbcmc) package, estimates
the statistical signiﬁcance of ρ for each IGP. In other words, we want to see whether the
observed ρ can be obtained by chance. In order to perform this task, the ρ null distribution

Crist´obal Fresno, Germ´an A Gonz´alez, Andrea S Llera, Elmer A Fern´andez

3

for each IGP (ρH0IGP ) is obtained by evaluating β permutations of the SGP gene expression.
Then, the observed (un-permuted) IGP correlations (ρuIGP ) are compared against their own
ρH0IGP in order to evaluate whether H0 : ρuIGP ∈ ρH0IGP versus H1 : ρuIGP /∈ ρH0IGP
according to the p-values (pIGP ) calculated as in (3):

pIGP =

(cid:80)β

i I(ρi, ρu)
β

;

I(a, b) =

(cid:26) 1 if a > b
0 if a ≤ b

(3)

where IGP stands for Basal, Her2-Enriched, Luminal A, Luminal B and Normal-like. The
resulting ﬁve pIGP ’s are adjusted to control multiple comparisons using False Discovery Rate,
FDR (Benjamini and Hochberg 1995). Then, assuming an acceptable type I error, α, the
hypothesis test for all IGPs could result in:

i. No signiﬁcant ρu for any IGP, i. e., all adjusted pIGP > α.

ii. A unique signiﬁcant ρu.

iii. Multiple signiﬁcant ρu.

For the ﬁrst case, the subject cannot reliably be assigned to any IGP (not assigned - NA).
In the second case, it is assigned (A) to the trustworthy current PAM50 subtype. In order
to overcome the ambiguity of case iii., a correlation diﬀerence threshold of 0.1 between the
> . . . > 0) was established, similarly as in Cheang et al. (2009) for
top ones (ρuIGP1
Luminal subtypes. Then, if (ρuIGP1
) > 0.1 the subject is assigned as in ii., otherwise
it is considered as an ambiguous (Amb) subject.

> ρuIGP2

− ρuIGP2

3. Implementation

The S4 class hierarchy of the pbcmc package is based on the implementation of an abstract
MolecularPermutationClassifier class, which can potentially be used for any MS as de-
picted in Figure 1. Basically, it has been developed as an organized data processing framework
for its heirs. The latters are supposed to implement the respective responsibilities. Once a
heir object is implemented the user can:

loadBCDataset: Load one of the example breast cancer dataset available at Bioconductor.
At present, it is possible to load breastCancerXXX where XXX can be “upp” (Schroeder
et al. 2011e), “nki” (Schroeder et al. 2011b), “vdx” (Schroeder et al. 2011f), “mainz”
(Schroeder et al. 2011a), “transbig” (Schroeder et al. 2011c) or “unt” (Schroeder et al.
2011d).

ﬁltrate: Remove, from the exprs matrix, subjects not required by the classiﬁcation algo-

rithm.

classify: Generate subject classiﬁcation according to the heir’s implementation (PAM50,

etc.).

permute: Obtains subject classiﬁcation based on the null ρH0 distribution by means of β

permutation simulations.

4

pbcmc: Permutation-Based Conﬁdence for Molecular Classiﬁcation

Figure 1: Package hierarchy. MolecularPermutationClassifier is the main S4 abstract
class and PAM50 implements it for the Molecular Signature (MS) of Perou et al. (2000, 2010).
The other classes represent user-deﬁned implementations of other MS. Note that complete
operation signature have been omitted for simplicity.

Molecular Signature 3MolecularPermutationClassiﬁer- parameters : undef- exprs : undef- annotation : data.frame- targets : data.frame- classiﬁcation : list- permutation : list+ validity()+ show()+ summary()+ loadBCDataset()+ ﬁltrate()+ classify()+ permutate()+ subtype()+ subjectReport()+ databaseReport()Molecular Signature nPAM50+ ﬁltrate()+ subtype()+ permutate()+ classify()+ subjectReport()+ databaseReport()Molecular Siganture 2Diagram: class diagram Page 1Crist´obal Fresno, Germ´an A Gonz´alez, Andrea S Llera, Elmer A Fern´andez

5

subtype: Obtain the new classiﬁcation using the permutation results.

subjectReport: Create a friendly report to assist physician treatment decision making.

databaseReport: Create a pdf with all subjectReports, if a database is available.

At present, the only available heir is PAM50 based on genefu library (Haibe-Kains et al.
2014). But, it can easily be extended to other MS such as Prosignaﬁ (Nielsen et al. 2014)
or others, just implementing filtrate, classify, permutate, subtype, subjectReport and
databaseReport functions.

3.1. Computational Requirements

The pbcmc uses permutation approach as described in section 2. In this context, a paralleliza-
tion approach by sample has been implemented using BiocParallel for the recommended pa-
rameters i.e., “nPerm=10000”, “pCutoff=0.01”, “where="fdr" and “corCutoff=0.1”. Hence,
it can work in any platform providing the appropriate “BPPARAM=bpparam()” option according
to the operating system e.g. SnowParam() for Windows or MulticoreParam() in Linux. It
worth to mention that this feature will not be used when working with a single sample.

Computational requirement for memory (Table 1) and time execution (Table 2 and Fig. 2)
tested in a Kubuntu 16.04.1 LTS xenial machine, with an Intel(R) Core(TM) i7-4790 CPU
3.60GHz (8 cores), 32 GB DDR3 1866 MHz using the complete breastCancerNKI example
for recommended parameters were:

Table 1: Memory requirements for pbcmc package using breastCancerNKI

Process performed
Raw data (24481 × 337)
Filtered data (57 × 337)
Classify with std="median" option
Permutate with keep=FALSE option
Permutate with keep=TRUE option
Temporary MulticoreParam(workers=7)

Total object memory size
72.9 Mb
263 Kb
324.3 Kb
416.3 Kb
129.2 Mb
2GB of free memory

It is worth to mention that extra memory requirements for BiocParallel will only be used
while computing the permutations and released afterwards. For “nki” dataset using Multi-
coreParam(workers=7) (Table 1) it requires of 2GB of RAM memory. If additional workers
are included, if available, it would require additional free memory.

The time execution (Table 2 and Fig. 2) shows that the algorithm takes advantage of the
sample parallel implementation where fore two and three cores almost achieves the theoretical
identity speed up line. Nevertheless, the extra memory requirement provides a time reduction
as depicted in both Table 2 and Fig. 2.

6

pbcmc: Permutation-Based Conﬁdence for Molecular Classiﬁcation

Table 2: Time execution requirements for pbcmc package using breastCancerNKI

Type

Single sample

NKI

Time(seconds)

User System Elapsed
2.515
0.072
2.440
2.515
0.072
2.440
253.011
0.132
0.576
276.524
0.152
0.624
285.937
0.388
0.780
303.965
0.276
0.348
313.045
0.204
0.416
449.414
0.144
0.488
848.911
17.924
830.980

Cores Speed up

1
7
7
6
5
4
3
2
1

1.00

3.35
3.07
2.97
2.79
2.71
1.89
1.00

Figure 2: Time execution speed up for breastCancerNKI dataset.

lllllll1.01.52.02.53.0246Number of coresSpeed UpCrist´obal Fresno, Germ´an A Gonz´alez, Andrea S Llera, Elmer A Fern´andez

7

4. Examples

4.1. Using Bioconductor’s breastCancerXXX dataset

In order to work with PAM50 MS, the user must load a Bioconductor’s breastCancerXXX
dataset where XXX stands for UPP, NKI, VDX, TRANSBIG, MAINZ or UNT. For example
we can load NKI database (Schroeder et al. 2011b), provided that the require library is
installed, using the following code:

R> library("pbcmc")
R> library("BiocParallel")
R> object<-loadBCDataset(Class=PAM50, libname="nki", verbose=TRUE)
R> object

A PAM50 molecular permutation classifier object
Dimensions:

exprs
annotation 24481
337
targets

nrow ncol
24481 337
10
21

The object is a PAM50 instance, which contains the exprs matrix with gene expression
values, associated annotation and clinical data in targets data.frame. On the other hand,
the user can use PAM50’s constructor to create an object with his/her own data or convert
a limma MAList object into PAM50 using as.PAM50(MAList_object) function. In the ﬁrst
case, the user will only need:

a) The M gene expression object, i. e., genes in rows and samples in columns.

b) The annotation data.frame which must include the compulsory ﬁelds: “probe”,

“NCBI.gene.symbol” and “EntrezGene.ID”.

c) The targets data.frame which is an optional slot. If it is provided, it should contain as
many rows as samples present in the M gene expression object. The idea is to include as
many columns as clinical or experimental data these samples have available. For “nki”
example, there are 21 columns.

4.2. Using any microarray R data package

The same example of section 4.1 can be built with pbcmc directly loading the package and
extracting the data into the M, annotation and targets (optional) slots required by PAM50
object. Just for simplicity we will work with the ﬁrst ﬁve samples but, it also works for a
single sample.

R> library("breastCancerNKI")
R> data("nki")

8

pbcmc: Permutation-Based Conﬁdence for Molecular Classiﬁcation

R> ##The expression
R> M<-exprs(nki)[, 1:5, drop=FALSE]
R> head(M)

NKI_4 NKI_6 NKI_7 NKI_8 NKI_9
Contig45645_RC -0.215 0.071 0.182 -0.343 -0.134
Contig44916_RC -0.207 0.055 0.077 0.302 0.051
-0.158 -0.010 0.059 0.169 -0.007
D25272
-0.819 -0.391 -0.624 -0.528 -0.811
J00129
Contig29982_RC -0.267 -0.310 -0.120 -0.447 -0.536
0.229 0.157 0.120 0.283 -0.112
Contig26811

R> ##The annotation
R> genes<-fData(nki)[, c("probe", "NCBI.gene.symbol", "EntrezGene.ID")]
R> head(genes)

Contig45645_RC Contig45645_RC
Contig44916_RC Contig44916_RC
D25272
D25272
J00129
J00129
Contig29982_RC Contig29982_RC
Contig26811
Contig26811

probe NCBI.gene.symbol EntrezGene.ID
64388
140883
NA
2244
286133
NA

GREM2
SUHW2
<NA>
FGB
SCARA5
<NA>

R> ##Additional information (optional)
R> targets<-pData(nki)[1:5, ,drop=FALSE]
R> head(targets)

NKI
NKI
NKI
NKI
NKI

NKI_4
NKI_6
NKI_7
NKI_8
NKI_9

NKI 4
NKI 6
NKI 7
NKI 8
NKI 9

NA 2.0 41 1
NA 1.3 49 1
NA 2.0 46 0
NA 2.8 48 0
NA 1.5 48 1

samplename dataset series id filename size age er grade pgr
3 NA
2 NA
1 NA
3 NA
3 NA
her2 brca.mutation e.dmfs t.dmfs node t.rfs e.rfs treatment
0
4747
0
4075
0
3703
0
3215
0
3760

0 4747
0 4075
0 3703
0 3215
0 3760

NA
NA
NA
NA
NA

0
0
0
0
0

0
0
0
0
0

0
0
0
0
0

tissue t.os e.os
0
1 4744
0
1 4072
0
1 3700
0
1 3213
0
1 3757

NKI_4
NKI_6
NKI_7
NKI_8
NKI_9

NKI_4
NKI_6
NKI_7
NKI_8
NKI_9

NKI_4
NKI_6
NKI_7
NKI_8
NKI_9

Crist´obal Fresno, Germ´an A Gonz´alez, Andrea S Llera, Elmer A Fern´andez

9

Now we are ready to follow the workﬂow of section 4.3, i. e.:

1. ﬁltrate the genes to keep only the required 50 genes by PAM50.

2. classify the sample/s using genefu implementation of PAM50 algorithm with the desired
gene normalization: none, scale, robust or median. For single samples use none but, we
recommend “median” for population approaches.

3. permutate the gene labels to build the null distribution and generate the uncertainty

estimation proposed in pbcmc.

and further explore the obtained results with summary, subjectReport and databaseReport.

4.3. Using PAM50 centroids as proof of concept

For example, we could use genefu’s PAM50 centroids to check if our implementation solves
the proof of concept, where we a prior know the true class of each subject:

R> M<-pam50$centroids
R> genes<-pam50$centroids.map
R> names(genes)<-c("probe", "NCBI.gene.symbol", "EntrezGene.ID")
R> object<-PAM50(exprs=M, annotation=genes)
R> object

A PAM50 molecular permutation classifier object
Dimensions:

exprs
annotation
targets

nrow ncol
5
3
0

50
50
0

Note that for the above output, the targets slot is empty, i. e., nrow=0 and ncol=0. In
addition, only the expression of the ﬁfty genes and ﬁve IGP is available, with its corresponding
annotation over the three compulsory ﬁelds. It is always a good idea to explore the slots
content, to see whether they have been correctly loaded:

R> head(exprs(object))

##The gene expression values for each subject

LumA

Her2

Basal

LumB Normal
ACTR3B 0.7183 -0.4817 0.009981 -0.1906 0.4657
0.5374 0.2669 -0.579246 0.0988 -0.8369
ANLN
-0.5745 -0.4761 0.758221 -0.4055 0.3166
BAG1
-0.1188 -0.1579 0.287487 -0.4413 0.5340
BCL2
BIRC5
0.3005 0.4057 -0.881434 0.6039 -0.8766
BLVRA -0.6427 0.3353 0.042042 0.6912 -0.1634

10

pbcmc: Permutation-Based Conﬁdence for Molecular Classiﬁcation

R> head(annotation(object)) ##The compulsory annotation fields

ACTR3B ACTR3B
ANLN
ANLN
BAG1
BAG1
BCL2
BCL2
BIRC5
BIRC5
BLVRA
BLVRA

probe NCBI.gene.symbol EntrezGene.ID
57180
54443
573
596
332
644

ACTR3B
ANLN
BAG1
BCL2
BIRC5
BLVRA

R> head(targets(object))

##The clinical data, if available.

data frame with 0 columns and 0 rows

Just as we expected, the ﬁve centroids are loaded in exprs slot, with their corresponding
“probe”, “NCBI.gene.symbol” and “EntrezGene.ID” number in the annotation slot and no
available data for the targets. Now, the user is ready to work with the data following the
workﬂow suggested in section 3 (ﬁltrate, classify and permutate):

R> object<-filtrate(object, verbose=TRUE)
R> object<-classify(object, std="none", verbose=TRUE)
R> object<-permutate(object, nPerm=10000, pCutoff=0.01, where="fdr",
+
+

corCutoff=0.1, keep=TRUE, seed=1234567890, verbose=TRUE,
BPPARAM=bpparam())

|
|
|
|===============
|
|==============================
|
|=============================================
|
|============================================================| 100%

| 75%

| 50%

| 25%

0%

|

The intention of filtrate function is to keep only the genes that will take place in the
In this example, it will not produce any change on the original exprs slot,
classiﬁcation.
given the fact that only the required ﬁfty genes are present. But, if a complete microarray
would have been present, then, probes that do not code for IGP will be removed. In addition,
probes that code for the same gene (repeated or with similar annotation) will be treated as
described in standardization (std) parameter.
Once genes are filtrated, the user can classify them using the original PAM50 algorithm.
However, here we propose to obtain subtype assignment conﬁdence using at least β = 10.000
permutations over the SGP, using a type I error α = 0.01 on the adjusted p-values (“fdr”)
and a correlation diﬀerence threshold of corCutoff=0.1. As a matter of fact, this process is

Crist´obal Fresno, Germ´an A Gonz´alez, Andrea S Llera, Elmer A Fern´andez

11

computationally intensive, so we can take advantage of all the available computes cores using
BioParallel package (BPPARAM=bpparam()) as we just did (Morgan et al.). In addition, the
user can track the permutation progress bar by including verbose=TRUE option. If we now
take a look at the object:

R> object

A PAM50 molecular permutation classifier object
Dimensions:

nrow ncol
5
3
0

exprs
50
annotation
50
0
targets
Classification:

nrow ncol
5
5

5
5

probability
correlation
$subtype

Basal
1

Her2
1

LumA
1

LumB Normal
1

1

Permutations test ran with following parameters:

Permutations=10000, fdr<0.01, corCutoff>0.1, keep=TRUE

Permutation:
correlation available: TRUE

pvalues
fdr
subtype

nrow ncol
5
5
5

5
5
5

we can see that it has been updated. First, the classification slot contains two datasets:
one with the subtype probability, P (IGPi), as described in section 1.2 and the correlation of
each subject with the ﬁve IGPs. The $subtype item shows a frequency table of the possible
IGPs with the used subjects. In addition, the used permutation parameters are shown with
the dimension of pvalues, fdr and subtypes. Note that in this case keep=TRUE option was used
so, the simulated correlation null distribution data points (ρH0IGP s) are available.
In this example we have used genefu’s PAM50 centroids, thus, only one subject is present
(1) for each IGP cell in the object output. This result is also conﬁrmed by the ones in the
diagonal of summary(object) matrix between the original Subtype and the Classes found
by the pbcmc package. Moreover, this toy example only shows assigned subjects (A) to the
original PAM50 subtypes, whereas not assigned (NA) marginal row/column contains only
zeros (0). If ambiguous (AMB) subjects would have been found, Classes column will have
included additional rows with the classes in dispute (e. g., “LumA, Normal” or “Her2, LumB”,
etc.).

12

pbcmc: Permutation-Based Conﬁdence for Molecular Classiﬁcation

R> summary(object)

Subtype

Classes
Basal
Her2
LumA
LumB
Normal
Not Assigned

Basal Her2 LumA LumB Normal Not Assigned
0
0
0
0
0
0
0
1
0
0
0
0

0
0
0
0
1
0

1
0
0
0
0
0

0
0
1
0
0
0

0
1
0
0
0
0

Finally, we can inspect the report of a single subject to see how the MS classiﬁcation went
(Figure 3), in order to suggest an appropriate therapy for the physician:

R> subjectReport(object, subject=1)

The report of Figure 3 is a grid.arrange object which basically consists of three main parts:

tableGrob: A summary table which contains the following ﬁelds,

$Summary: Subject name and subtype obtained by PAM50.Subtype or the proposed

methodology (Permuted.Subtype).

$Fields: For the ﬁve PAM50 subtypes,

(cid:136) Correlation: The correlation of the i − th PAM50 centroid with the observed

subject exprs, ρ(P GP, IGPi).

(cid:136) p-value: Permutation p-value obtained using the simulation data, pIGP .
(cid:136) FDR: Adjusted p-value using False Discovery Rate (Benjamini and Hochberg

1995).

facet wrap: Two rows to display ggplot2 (Wickham 2009) scatter plots of subject exprs
versus PAM50 centroids (Perou et al. 2000, 2010) and a linear regression ﬁt (in blue).
If the subject has an unique subtype, then the graph is colored in red. In addition,
if simulated permutations were run with keep=TRUE option, then the null distribution
boxplots are plotted with the corresponding observed un-permuted correlations as big
round dots.

textGrob:The permutation parameter slot used in the simulation.

The pbcmc also includes the ability to get a pdf report for the complete database calling
databaseReport function. In this context, the ﬁrst page is a global summary of the database,
i.e., a summary contingency table of the permuted test classes against the original PAM50
subtypes results. The following pages are the respective subjectReport outputs as the one
shown in Figure 3.

Crist´obal Fresno, Germ´an A Gonz´alez, Andrea S Llera, Elmer A Fern´andez

13

Figure 3: PAM50 permutation subject report for genefu’s “Basal” intrinsic gene proﬁle (IGP).
The top table summarize the results for the i-th subject, i. e., the correlation, p-value and
false discovery rate (fdr) obtained for each IGP. In addition, scatter plots of the observed
subject gene proﬁles against the IGP with the linear regression line (in blue). Red color
indicates the assigned subtype. Finally, a boxplot for each IGP null permuted correlation
distribution and big dots to represent the un-permuted observed correlations.

SummaryBasalSubjectFieldBasalPAM50.SubtypeBasalBasalPermuted.SubtypeHer2CorrelationLumAp−valueLumBFDRNormal100−0.146 0.843 1.000−0.649 1.000 1.000−0.360 0.996 1.0000.1180.2060.515llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllLumBNormalBasalHer2LumA−3−2−10123−3−2−10123−3−2−10123−2−101−2−101PAM50 CentroidsSubject ExpressionPermutations:10000, pcutoff<0.01 & corCutoff>0.1lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll−0.50.00.51.0BasalHer2LumALumBNormalSubtypeRho14

pbcmc: Permutation-Based Conﬁdence for Molecular Classiﬁcation

5. Conclusion

The pbcmc package characterizes uncertainty assessment on gene expression classiﬁers, a.
k. a. molecular signatures, based on a permutation test.
In order to achieve this goal,
synthetic simulated subjects are obtained by permutations of gene labels. Then, each synthetic
subject is tested against the corresponding subtype classiﬁer to build the null distribution.
Thus, classiﬁcation conﬁdence measurement report can be provided for each subject, to assist
physician therapy choice. At present, it is only available for PAM50 implementation in genefu
package but, it can easily be extend to other molecular signatures.

Acknowledgements

Funding: This work was supported by Universidad Cat´olica de C´ordoba (PIP 800-201304-
00047-CC to E.A.F.), Argentina and National Council of Scientiﬁc and Technical Research
(CONICET), Argentina.

Session Info

R> sessionInfo()

R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] parallel stats
[7] methods

base

graphics grDevices utils

datasets

other attached packages:

[1] breastCancerNKI_1.15.0 BiocParallel_1.12.0
[3] pbcmc_1.6.0
[5] AIMS_1.10.0
[7] BiocGenerics_0.24.0

genefu_2.10.0
Biobase_2.38.0
e1071_1.6-8

Crist´obal Fresno, Germ´an A Gonz´alez, Andrea S Llera, Elmer A Fern´andez

15

[9] iC10_1.1.3

[11] pamr_1.55
[13] biomaRt_2.34.0
[15] mclust_5.3
[17] prodlim_1.6.1
[19] ggplot2_2.2.1

iC10TrainingData_1.0.1
cluster_2.0.6
limma_3.34.0
survcomp_1.28.0
survival_2.41-3

loaded via a namespace (and not attached):

[1] progress_1.1.2
[4] lattice_0.20-35
[7] stats4_3.4.2

[10] rlang_0.1.2
[13] plyr_1.8.4
[16] munsell_0.4.3
[19] memoise_1.1.0
[22] class_7.3-14
[25] KernSmooth_2.23-15
[28] S4Vectors_0.16.0
[31] gridExtra_2.3
[34] SuppDists_1.1-9.4
[37] tools_3.4.2
[40] lazyeval_0.2.1
[43] RSQLite_2.0
[46] assertthat_0.2.0

splines_3.4.2
colorspace_1.3-2
XML_3.98-1.9
bit64_0.9-7
stringr_1.2.0
gtable_0.2.0
IRanges_2.12.0

reshape2_1.4.2
amap_0.8-14
blob_1.1.0
DBI_0.7
lava_1.5.1
survivalROC_1.0.3
labeling_0.3
AnnotationDbi_1.40.0 Rcpp_0.12.13
scales_0.5.0
bootstrap_2017.2
digest_0.6.12
cowplot_0.8.0
bitops_1.0-6
RCurl_1.95-4.8
Matrix_1.2-11
R6_2.2.2

rmeta_2.16
bit_1.1-12
stringi_1.1.5
grid_3.4.2
magrittr_1.5
tibble_1.3.4
prettyunits_1.0.2
compiler_3.4.2

References

Andre F, Pusztai L (2006). “Molecular classiﬁcation of breast cancer: implications for selection

of adjuvant chemotherapy.” Nature clinical practice Oncology, 3(11), 621–632.

Benjamini Y, Hochberg Y (1995). “Controlling the false discovery rate: a practical and
powerful approach to multiple testing.” Journal of the Royal Statistical Society. Series B
(Methodological), pp. 289–300.

Cheang MC, Chia SK, Voduc D, Gao D, Leung S, Snider J, Watson M, Davies S, Bernard
PS, Parker JS, et al. (2009). “Ki67 index, HER2 status, and prognosis of patients with
luminal B breast cancer.” Journal of the National Cancer Institute, 101(10), 736–750.

Ebbert MT, Bastien RR, Boucher KM, Mart´ın M, Carrasco E, Caballero R, Stijleman IJ,
Bernard PS, Facelli JC (2011). “Characterization of uncertainty in the classiﬁcation of
multivariate assays: application to PAM50 centroid-based genomic predictors for breast
cancer treatment plans.” Journal of clinical bioinformatics, 1(1), 1–9.

Haibe-Kains B, Schroeder M, Bontempi G, Sotiriou C, Quackenbush J (2014). geenfu: Rel-
evant Functions for Gene Expression Analysis, Especially in Breast Cancer. genefu pack-
age version 1.16.0, URL http://www.bioconductor.org/packages/release/bioc/html/
genefu.html.

16

pbcmc: Permutation-Based Conﬁdence for Molecular Classiﬁcation

Ioannidis JP (2007). “Is molecular proﬁling ready for use in clinical decision making?” The

oncologist, 12(3), 301–311.

Lusa L, McShane LM, Reid JF, De Cecco L, Ambrogi F, Biganzoli E, Gariboldi M, Pierotti
MA (2007). “Challenges in projecting clustering results across gene expression–proﬁling
datasets.” Journal of the National Cancer Institute, 99(22), 1715–1723.

Morgan M, Lang M, Thompson R (????). BiocParallel: Bioconductor facilities for parallel

evaluation. R package version 1.2.1.

Nielsen T, Wallden B, Schaper C, Ferree S, Liu S, Gao D, Barry G, Dowidar N, Maysuria
M, Storhoﬀ J (2014). “Analytical validation of the PAM50-based Prosigna Breast Can-
cer Prognostic Gene Signature Assay and nCounter Analysis System using formalin-ﬁxed
paraﬃn-embedded breast tumor specimens.” BMC cancer, 14(1), 177.

Paik S, Shak S, Tang G, Kim C, Baker J, Cronin M, Baehner FL, Walker MG, Watson
D, Park T, et al. (2004). “A multigene assay to predict recurrence of tamoxifen-treated,
node-negative breast cancer.” New England Journal of Medicine, 351(27), 2817–2826.

Perou CM, Parker JS, Prat A, Ellis MJ, Bernard PS (2010). “Clinical implementation of the

intrinsic subtypes of breast cancer.” The lancet oncology, 11(8), 718–719.

Perou CM, Sørlie T, Eisen MB, van de Rijn M, Jeﬀrey SS, Rees CA, Pollack JR, Ross DT,
Johnsen H, Akslen LA, et al. (2000). “Molecular portraits of human breast tumours.”
Nature, 406(6797), 747–752.

Schroeder M, Haibe-Kains B, Culhane A, Sotiriou C, Bontempi G, Quackenbush J (2011a).
breastCancerMAINZ: Gene expression dataset published by Schmidt et al. [2008] (MAINZ).
R package version 1.3.1, URL http://compbio.dfci.harvard.edu/.

Schroeder M, Haibe-Kains B, Culhane A, Sotiriou C, Bontempi G, Quackenbush J (2011b).
breastCancerNKI: Genexpression dataset published by van’t Veer et al. [2002] and van de
Vijver et al. [2002] (NKI). R package version 1.3.1, URL http://compbio.dfci.harvard.
edu/.

Schroeder M, Haibe-Kains B, Culhane A, Sotiriou C, Bontempi G, Quackenbush J (2011c).
breastCancerTRANSBIG: Gene expression dataset published by Desmedt et al. [2007]
(TRANSBIG). R package version 1.3.1, URL http://compbio.dfci.harvard.edu/.

Schroeder M, Haibe-Kains B, Culhane A, Sotiriou C, Bontempi G, Quackenbush J (2011d).
breastCancerUNT: Gene expression dataset published by Sotiriou et al. [2007] (UNT). R
package version 1.3.1, URL http://compbio.dfci.harvard.edu/.

Schroeder M, Haibe-Kains B, Culhane A, Sotiriou C, Bontempi G, Quackenbush J (2011e).
breastCancerUPP: Gene expression dataset published by Miller et al. [2005] (UPP). R
package version 1.3.1, URL http://compbio.dfci.harvard.edu/.

Schroeder M, Haibe-Kains B, Culhane A, Sotiriou C, Bontempi G, Quackenbush J (2011f).
breastCancerVDX: Gene expression datasets published by Wang et al. [2005] and Minn et
al. [2007] (VDX). R package version 1.3.1, URL http://compbio.dfci.harvard.edu/.

Crist´obal Fresno, Germ´an A Gonz´alez, Andrea S Llera, Elmer A Fern´andez

17

Sørlie T, Borgan E, Myhre S, Vollan HK, Russnes H, Zhao X, Nilsen G, Lingjærde OC,
Børresen-Dale AL, Rødland E (2010). “The importance of gene-centring microarray data.”
The lancet oncology, 11(8), 719–720.

Sørlie T, Perou CM, Tibshirani R, Aas T, Geisler S, Johnsen H, Hastie T, Eisen MB, van de
Rijn M, Jeﬀrey SS, et al. (2001). “Gene expression patterns of breast carcinomas distin-
guish tumor subclasses with clinical implications.” Proceedings of the National Academy of
Sciences, 98(19), 10869–10874.

van’t Veer LJ, Dai H, Van De Vijver MJ, He YD, Hart AA, Mao M, Peterse HL, van der Kooy
K, Marton MJ, Witteveen AT, et al. (2002). “Gene expression proﬁling predicts clinical
outcome of breast cancer.” nature, 415(6871), 530–536.

Wickham H (2009). ggplot2: elegant graphics for data analysis. Springer New York. ISBN

978-0-387-98140-6. URL http://had.co.nz/ggplot2/book.

Wu D, Rice CM, Wang X (2012). “Cancer bioinformatics: A new approach to systems clinical

medicine.” BMC bioinformatics, 13(1), 71.

Aﬃliation:

Crist´obal Fresno, Germ´an A Gonz´alez & Elmer A Fern´andez
Bioscience Data Mining Group
Facultad de Ingenier´ıa
Universidad Cat´olica de C´ordoba - CONICET
X5016DHK C´ordoba, Argentina
E-mail: cfresno@bdmg.com.ar, ggonzalez@bdmg.com.ar,
efernandez@bdmg.com.ar
URL: http://www.bdmg.com.ar/

Andrea S Llera
Laboratorio de Terapia Molecular y Celular
Fundaci´on Instituto Leloir - CONICET
C1405BWE Ciudad Aut´onoma de Buenos Aires, Argentina
E-mail: allera@leloir.org.ar
URL: http://www.leloir.org.ar/podhajcer/

