Risa: Building R objects from local ISA-Tab ﬁles

Alejandra Gonzalez-Beltran and Steﬀen Neumann and Audrey Kauﬀmann
and Gabriella Rustici and Philippe Rocca-Serra and Eamonn Maguire
and Susanna-Asunta Sansone
isatools@googlegroups.com

April 24, 2017

1 Introduction

The Risa package is part of the ISA infrastructure software suite (http://isa-tools.org). It provides
funcitonality to read ISA-Tab datasets, described in the following section. The source code and
latest version can be found in the GitHub repository https://github.com/ISA-tools/Risa. Please,
submit all ’bugs’ and feature requests through https://github.com/ISA-tools/Risa/issues.

2 ISA-Tab format

The Investigation / Study / Assay (ISA) Tab-delimited (Tab) format is a general purpose frame-
work with which to collect and communicate complex metadata (i.e. sample characteristics, tech-
nologies used, type of measurements made) from experiments employing a combination of tech-
nologies (http://isa-tools.org). In particular, ISA-Tab has been developed for - but not limited
to - experiments using genomics, transcriptomics, proteomics or metabol/nomics techniques (the
’omics’).

ISA-Tab uses three types of ﬁle to capture the experimental metadata:

(cid:136) Investigation ﬁle

(cid:136) Study ﬁle

(cid:136) Assay ﬁle (with associated data ﬁles).

The Investigation ﬁle contains an overall description of an experiment while all experimental
steps are described in the Study and in the Assay ﬁle(s). For each Investigation ﬁle there may be
one or more Study ﬁles; for each Study ﬁle there may be one or more Assay ﬁles.

2.1 Investigation ﬁle

In this ﬁle, information is reported on a per-column basis and the ﬁelds are organized and divided
in sections. The Investigation ﬁle is intended to meet three needs:

(cid:136) to deﬁne key entities, such as factors, protocols, parameters, which may be referenced in the

other ﬁles;

(cid:136) to relate Assay ﬁles to Study ﬁles; and optionally,

(cid:136) to relate each Study ﬁle to an Investigation (when two or more Study ﬁles need to be
grouped). The declarative sections cover general information such as contacts, protocols
and equipment, and also - where applicable - the description of terminologies (controlled
vocabularies or ontologies) and other annotation resources that were used.

1

2.2 Study ﬁle

In this ﬁle, information is structured on a per-row basis with the ﬁrst row being used for column
headers. The Study ﬁle contains contextualizing information for one or more assays, for example;
the subjects studied; their source(s); the sampling methodology; their characteristics; and any
treatments or manipulations performed to prepare the specimens.

2.3 Assay ﬁle

In this ﬁle, as for the Study ﬁle, ﬁelds are organized on a per-row basis with the ﬁrst row being
used for column headers. The Assay ﬁle represents a portion of the experimental graph (i.e., one
part of the overall structure of the workﬂow); each Assay ﬁle must contain assays of the same
type, deﬁned by the type of measurement (i.e. gene expression) and the technology employed (i.e.
DNA microarray). Assay-related information includes protocols, additional information relating
to the execution of those protocols and references to data ﬁles (whether raw or processed).

For easy transfer, ISA-Tab ﬁles and associated data ﬁles can be packaged into an ISArchive,
using a standalone Java application named ISAcreator (http://isatab.sourceforge.net). In order
to facilitate identiﬁcation of ISA-Tab components in an ISArchive, speciﬁc extensions have been
created as follows:

(cid:136) i iname.txt for identifying the Investigation ﬁle

(cid:136) s sname.txt for identifying Study ﬁle (s)

(cid:136) a aname.txt for identifying Assay ﬁle (s)

where ’iname’, ’sname’, ’aname’ are the user-given names for the investigation, study/ies, assay(s),
respectively.

3 The Risa package

The Risa package is used to build R objects from an ISA archive or dataset. The output is a list
of objects containing, for example, the investigation, studies and assays ﬁlenames, the contents of
their ﬁles, the list of samples, among other things.

These objects can then be used by downstream Bioconductor packages for data analysis and
visualization (i.e, xcms). The package currently includes the function processAssayXcmsSet that,
for a speciﬁc mass spectrometry assay, builds an xcmsSet object.

3.1 Building an R object from a local ISA dataset

If you have your own ISA archive, you can use the function readISAtab to convert it into an R
object. The arguments for the function readISAtab are:

(cid:136) path the name of the directory containing ISAtab ﬁles. The default is the working directory.

(cid:136) verbose a boolean indicating to show messages for the diﬀerent steps, if TRUE, or not to

show them, if FALSE

As an example, we can use the faahKO dataset, whose version 1.2.11 contains an ISA dataset
describing the experiment. First, it is required to load the Risa package, and the faahKO package
must have been installed.

> library(Risa)
> require(faahKO)

Then, we read the ISA-Tab data set from the faahKO package:

2

> faahkoISA <- readISAtab(find.package("faahKO"))

The object faahkoISA belongs to the ISAtab class, and contains the following elements:

(cid:136) path - the path of the ISA-Tab dataset,

(cid:136) investigation.ﬁlename - the name of the Investigation ﬁle

(cid:136) investigation.ﬁle - a data frame with the contents of the Investigation ﬁle

(cid:136) study.identiﬁers - the list of study identiﬁers

(cid:136) study.ﬁlenames - the names of the study ﬁles

(cid:136) study.ﬁles - a list of data frames wiht the contents of the study ﬁles

(cid:136) assay.ﬁlenames - the names of the assay ﬁles

(cid:136) assay.ﬁlenames.per.study - the names of the assay ﬁles according to the study they belong

to

(cid:136) assay.ﬁles - a list of data frames with the contents of the assay ﬁles

(cid:136) assay.ﬁles.per.study - a list of data frames with the contents of the assay ﬁles divided per

study they belong to

(cid:136) assay.technology.types - a list with the technology types corresponding to each assay

(cid:136) assay.measurement.types - a list with the measurement types corresponding to each assay

(cid:136) data.ﬁlenames - a list with the names of the data ﬁles

(cid:136) samples - a list with the names of the samples

(cid:136) samples.per.assay.ﬁlename - the samples classiﬁed according to the assay ﬁlename they be-

long to

(cid:136) assay.ﬁlenames.per.sample - the names of the assay ﬁles classiﬁed per sample name

(cid:136) sample.to.rawdataﬁle - the association between samples and raw data ﬁles

(cid:136) sample.to.assayname - the association between samples and assay names

(cid:136) rawdataﬁle.to.sample - the association between raw data ﬁles and samples

(cid:136) assayname.to.sample - the association between assay names and samples

Additionally, the ISA dataset could be compressed in a .zip ﬁle. If that is the case, the function
readISAtab can be used, passing the zipfile as parameter. The only condition is that the ISA-Tab
ﬁles are contained directly into the zip ﬁle, i.e. not inside additional folders.

In this case, the parameters for the function readISAtab will be:

(cid:136) zipﬁle a zip archive containing ISAtab ﬁles.

(cid:136) path the name of the directory in which the ﬁles from the zip archive will be extracted. The

default is the working directory.

(cid:136) verbose a boolean indicating to show messages for the diﬀerent steps, if TRUE, or not to

show them, if FALSE

3

Building xcmsSets for mass spectrometry assays

The function processAssayXcmsSet allows to build an xcmsSet (object deﬁned in the xcms package)
from the information in an assay ﬁle.

The parameters for this function are:

(cid:136) isa: an ISA object, as retrieved by the function readISAtab

(cid:136) assay.ﬁlename the name of the assay ﬁle with information about the relevant assay

(cid:136) ... extra arguments that can be passed down to the xcmsSet function from the xcms package

Using the faahKO package as an example, we select the name of assay ﬁle, and use the pro-

cessAssayXcmsSet to build a object of type xcmsSet:

> assay.filename <- faahkoISA["assay.filenames"][1]
> faahkoXset <- processAssayXcmsSet(faahkoISA, assay.filename)

Augmenting the ISA-Tab dataset after analysis

The Risa package also provides the functionality to augment the original ISA-Tab dataset with
more information after analysis.

The function updateAssayMetadata allows to modify the metadata in a particular assay ﬁle.

The arguments are:

(cid:136) isa An isatab object, as retrieved by the readISAtab function.

(cid:136) assay.ﬁlename the ﬁlename of the assay ﬁle to be augmented/modiﬁed

(cid:136) col.name the name of the column of the assay ﬁle to be modiﬁed

(cid:136) values the values to be added to the column of the assay ﬁle: it could be a single value, and
in this case the value is repeated across the column, or it could be a list of values (whose
length must match the number of rows of the assay ﬁle)

To continue with our example using the faahKO data package, we will assume that the results
of analysis are stored in the ﬁle faahkoDSDF.txt. Then, we will update the ISA-Tab dataset adding
the result ﬁle into the ’Derived Spectral Data File’ column of the assay ﬁle.

> updateAssayMetadata(faahkoISA, assay.filename,"Derived Spectral Data File","faahkoDSDF.txt" )

An object of class "ISATab"
Slot "path":
[1] "/home/biocbuild/bbs-3.5-bioc/R/library/faahKO"

Slot "investigation.filename":
[1] "i_Investigation.txt"

Slot "investigation.file":

1
2
3
4
5
6
7

V1
ONTOLOGY SOURCE REFERENCE
Term Source Name
Term Source File
Term Source Version
Term Source Description
INVESTIGATION
Investigation Identifier

4

Investigation Title
8
Investigation Description
9
Investigation Submission Date
10
Investigation Public Release Date
11
Comment [Created with configuration]
12
Comment [Last Opened With Configuration]
13
INVESTIGATION PUBLICATIONS
14
Investigation PubMed ID
15
Investigation Publication DOI
16
Investigation Publication Author List
17
Investigation Publication Title
18
19
Investigation Publication Status
20 Investigation Publication Status Term Accession Number
Investigation Publication Status Term Source REF
21
INVESTIGATION CONTACTS
22
Investigation Person Last Name
23
Investigation Person First Name
24
Investigation Person Mid Initials
25
Investigation Person Email
26
Investigation Person Phone
27
28
Investigation Person Fax
Investigation Person Address
29
Investigation Person Affiliation
30
31
Investigation Person Roles
Investigation Person Roles Term Accession Number
32
Investigation Person Roles Term Source REF
33
STUDY
34
Study Identifier
35
36
Study Title
Study Description
37
Study Submission Date
38
Study Public Release Date
39
40
Study File Name
STUDY DESIGN DESCRIPTORS
41
42
Study Design Type
Study Design Type Term Accession Number
43
Study Design Type Term Source REF
44
STUDY PUBLICATIONS
45
46
Study PubMed ID
Study Publication DOI
47
Study Publication Author List
48
Study Publication Title
49
50
Study Publication Status
Study Publication Status Term Accession Number
51
Study Publication Status Term Source REF
52
53
STUDY FACTORS
Study Factor Name
54
Study Factor Type
55
Study Factor Type Term Accession Number
56
Study Factor Type Term Source REF
57
58
STUDY ASSAYS
Study Assay Measurement Type
59
60
Study Assay Measurement Type Term Source REF
Study Assay Measurement Type Term Accession Number
61

5

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

Study Assay Technology Type
Study Assay Technology Type Term Source REF
Study Assay Technology Type Term Accession Number
Study Assay Technology Platform
Study Assay File Name
STUDY PROTOCOLS
Study Protocol Name
Study Protocol Type
Study Protocol Type Term Accession Number
Study Protocol Type Term Source REF
Study Protocol Description
Study Protocol URI
Study Protocol Version
Study Protocol Parameters Name
Study Protocol Parameters Name Term Accession Number
Study Protocol Parameters Name Term Source REF
Study Protocol Components Name
Study Protocol Components Type
Study Protocol Components Type Term Accession Number
Study Protocol Components Type Term Source REF
STUDY CONTACTS
Study Person Last Name
Study Person First Name
Study Person Mid Initials
Study Person Email
Study Person Phone
Study Person Fax
Study Person Address
Study Person Affiliation
Study Person Roles
Study Person Roles Term Accession Number
Study Person Roles Term Source REF

6

V2

OBI

v 1.26

Ontology for Biomedical Investigations

isaconfig-default_v2011-02-18 copy

22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37 Enzymes regulate biological processes through the conversion of specific substrates to products. Therefore, of fundamental interest for every enzyme is the elucidation of its natural substrates. Here, we describe a general strategy for identifying endogenous substrates of enzymes by untargeted liquid chromatography-mass spectrometry (LC-MS) analysis of tissue metabolomes from wild-type and enzyme-inactivated organisms. We use this method to discover several brain lipids regulated by the mammalian enzyme fatty acid amide hydrolase (FAAH) in vivo, including known signaling molecules (e.g., the endogenous cannabinoid anandamide) and a novel family of nervous system-enriched natural products, the taurine-conjugated fatty acids.
38
39
40
41
42
43
44
45
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

Assignment of endogenous substrates to enzymes by global metabolite profiling

Saghatelian A, Trauger SA, Want EJ, Hawkins EG, Siuzdak G, Cravatt BF.

Global metabolite profiling of faah(-/-) mice

Global metabolite profiling of faah(-/-) mice

s_Proteomic profiling of yeast TFs.txt

Agilent 1100 LC-MSD SL

parallel group design

metabolite profiling

sample collection

10.1021/bi0480335

sample collection

mass spectrometry

a_metabolite.txt

16/11/2004

16/11/2004

published

15533037

Genotype

500006

1796

EFO

OBI

7

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
29
30
31
32
33
34
35

8

V3

MS

v 1.26

PSI Mass Spectrometry Ontology

36
37
38
39
40
41
42
43
44
45
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
72 A 2:1:1 CHCl3/MeOH/1% NaCl solution (8 mL per brain and 4 mL per spinal cord in 8 mL vials) was prepared for tissue extraction to isolate organic soluble metabolites (25, 26). For targeted LC-MS measurements, deuterated standards were included in the mixture as described previously (10). FAAH(+/+) and FAAH(-/-) mice (3-6 months of age) were sacrificed at the same time of day and tissues immediately isolated, weighed, placed into the CHCl3/MeOH/1% NaCl solution, and homogenized using dounce tissue grinders. Each sample was then centrifuged at 2500 rpm for 10 min at 4 degree C in a glass vial. After centrifugation, the organic (bottom) and aqueous layers (top) were clearly distinguishable with a layer of insoluble material between them. The organic layer was carefully removed and transferred to another vial. The aqueous layer was extracted with an additional 1 mL of CHCl3, 0.5 mL of MeOH, and 1 mL of a 1% NaCl/1% formic acid mixture. This solution was mixed vigorously for 30-60 s and then centrifuged at 2500 rpm for 10 min at 4 degree C. The organic layers from the first and second extractions were combined and concentrated under a stream of nitrogen. Samples were stored at -80 degree C (always for less than 1 day) and dissolved in 120 uL of CHCl3 prior to analysis by LC-MS.
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

extraction

extraction

9

90
91
92
93

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
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49

10

V4

MA

v 1.26

Mouse Adult Gross Anatomy

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
72 LC-MS analysis was performed using an Agilent 1100 LC-MSD SL instrument. For the LC analysis, a HAISIL 300 C18 column (5 um, 4.6 mm x 100 mm) from Higgins Analytical was used together with a precolumn (C18, 3.5 um, 2 mm x 20 mm). Mobile phase A consisted of a 95:5 water/methanol mixture, and mobile phase B was made up of 2-propanol, methanol, and water in a 50:45:5 ratio. Solvent modifiers such as 0.1% formic acid, for the positive ionization mode, and 0.1% ammonium hydroxide, for the negative ionization mode, were used to assist ion formation as well as improve the LC resolution. The flow rate for each run started at 0.1 mL/min for 5 min, to alleviate the backpressure associated with injecting CHCl3, followed by a flow rate of 0.4 mL/min for the duration of the gradient. The gradient started at 0% B and then linearly increased to 100% B over the course of 60 min followed by an isocratic gradient of 100% B for 30 min before equilibration for 10 min at 0% B. The total analysis time, including 5 min at 0.1 mL/min, was 105 min. MS analysis was performed with an electrospray ionization (ESI) source. The capillary voltage was set to 3.0 kV and the fragmentor voltage to 100 V. The drying gas temperature was 350 degree C, the drying gas flow rate was 10 L/min, and the nebulizer pressure was 35 psi. Data were collected using a mass range of 200-1200 Da, and each run was performed using 40 uL injections of tissue metabolite extract.
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

ion source;ionization mode;instrument;detector;;;;

mass spectrometry

mass spectrometry

;;;

;;;

1
2
3
4
5
6
7
8
9

11

V5

NEWT

v 1.26

NEWT UniProt Taxonomy Database

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
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
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
60
61
62
63

12

64
65
66
67
68
69
70
71
72 The analysis of the resulting total ion chromatogram was performed manually by generating extracted ion chromatograms (EICs) in 5 Da increments (e.g., 200-205, 205-210, ..., 1195-1200). EICs of FAAH(+/+) and FAAH(-/-) samples were compared in a pairwise manner to identify changes (i.e., new peaks or changes in the magnitude of peaks) between samples for a given mass range and retention time. After peaks that were not shared by all samples had been discarded, the remaining peaks were quantified using the area under the peaks. The measured areas were then normalized to the amount of tissue and averaged (N = 6) to afford the mean area for a given peak in the chromatogram. Finally, the peak ratios between FAAH(+/+) and FAAH(-/-) samples provide a quantitative measure of the relative metabolite levels. With signals that fell below the limit of detection in FAAH(+/+) samples, a lower cutoff ion intensity of 32 500 was used. In those cases where this lower limit was used, the average ion intensity values are reported to be greater than or equal to the calculated ion intensity and resulting FAAH(-/-)/FAAH(+/+) ratios are reported to be greater than or equal to the calculated ratio.
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

identification

identification

V6

V7

EFO

PATO

v 1.26

1
2
3
4
5 Phenotypic qualities (properties) ArrayExpress Experimental Factor Ontology
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

13

24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
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

labeling
labeling

14

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

V8
1 NA
2 NA
3 NA
4 NA
5 NA
6 NA
7 NA
8 NA
9 NA
10 NA
11 NA
12 NA
13 NA
14 NA
15 NA
16 NA
17 NA
18 NA
19 NA
20 NA
21 NA
22 NA
23 NA
24 NA
25 NA
26 NA
27 NA
28 NA
29 NA
30 NA
31 NA
32 NA
33 NA
34 NA
35 NA
36 NA
37 NA

15

38 NA
39 NA
40 NA
41 NA
42 NA
43 NA
44 NA
45 NA
46 NA
47 NA
48 NA
49 NA
50 NA
51 NA
52 NA
53 NA
54 NA
55 NA
56 NA
57 NA
58 NA
59 NA
60 NA
61 NA
62 NA
63 NA
64 NA
65 NA
66 NA
67 NA
68 NA
69 NA
70 NA
71 NA
72 NA
73 NA
74 NA
75 NA
76 NA
77 NA
78 NA
79 NA
80 NA
81 NA
82 NA
83 NA
84 NA
85 NA
86 NA
87 NA
88 NA
89 NA
90 NA
91 NA

16

92 NA
93 NA

Slot "investigation.identifier":
[1] ""

Slot "study.identifiers":
[1] "Global metabolite profiling of faah(-/-) mice"

Slot "study.titles":
[1] "Global metabolite profiling of faah(-/-) mice"

Slot "study.descriptions":
[1] "Enzymes regulate biological processes through the conversion of specific substrates to products. Therefore, of fundamental interest for every enzyme is the elucidation of its natural substrates. Here, we describe a general strategy for identifying endogenous substrates of enzymes by untargeted liquid chromatography-mass spectrometry (LC-MS) analysis of tissue metabolomes from wild-type and enzyme-inactivated organisms. We use this method to discover several brain lipids regulated by the mammalian enzyme fatty acid amide hydrolase (FAAH) in vivo, including known signaling molecules (e.g., the endogenous cannabinoid anandamide) and a novel family of nervous system-enriched natural products, the taurine-conjugated fatty acids."

Slot "study.contacts":
[1] " "

Slot "study.contacts.affiliations":
[1] ""

Slot "study.filenames":
Global metabolite profiling of faah(-/-) mice
"s_Proteomic profiling of yeast TFs.txt"

‘

Slot "study.files":
$

Global metabolite profiling of faah(-/-) mice

‘

Saghantelian_1
1
Saghantelian_2
2
Saghantelian_3
3
Saghantelian_4
4
Saghantelian_5
5
Saghantelian_6
6
Saghantelian_7
7
Saghantelian_8
8
9
Saghantelian_9
10 Saghantelian_10
11 Saghantelian_11
12 Saghantelian_12

Source Name Characteristics[NEWT:Organism LC] Term Source REF
NEWT
NEWT
NEWT
NEWT
NEWT
NEWT
NEWT
NEWT
NEWT
NEWT
NEWT
NEWT

Mus musculus (Mouse)
Mus musculus (Mouse)
Mus musculus (Mouse)
Mus musculus (Mouse)
Mus musculus (Mouse)
Mus musculus (Mouse)
Mus musculus (Mouse)
Mus musculus (Mouse)
Mus musculus (Mouse)
Mus musculus (Mouse)
Mus musculus (Mouse)
Mus musculus (Mouse)

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

Term Accession Number Characteristics[tissue] Term Source REF
MA
MA
MA
MA
MA
MA
MA
MA
MA
MA
MA
MA

10090
10090
10090
10090
10090
10090
10090
10090
10090
10090
10090
10090
Term Accession Number

spinal cord
spinal cord
spinal cord
spinal cord
spinal cord
spinal cord
spinal cord
spinal cord
spinal cord
spinal cord
spinal cord
spinal cord

Protocol REF Sample Name Factor Value[Genotype]

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
11
12

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

216 sample collection
216 sample collection
216 sample collection
216 sample collection
216 sample collection
216 sample collection
216 sample collection
216 sample collection
216 sample collection
216 sample collection
216 sample collection
216 sample collection

KO1
KO2
KO3
KO4
KO5
KO6
WT1
WT2
WT3
WT4
WT5
WT6

KO
KO
KO
KO
KO
KO
WT
WT
WT
WT
WT
WT

Term Source REF Term Accession Number
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Slot "assay.filenames":

V2
"a_metabolite.txt"

‘
‘

Slot "assay.filenames.per.study":
$
$
[1] "a_metabolite.txt"

Global metabolite profiling of faah(-/-) mice
Global metabolite profiling of faah(-/-) mice

‘
‘

[[1]]

Slot "assay.files":
$a_metabolite.txt

Sample Name Protocol REF Extract Name Protocol REF Labeled Extract Name
NA
KO1
NA
KO2
NA
KO3
NA
KO4
NA
KO5
NA
KO6
NA
WT1
NA
WT2
NA
WT3
NA
WT4
NA
WT5
NA
WT6

extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction

labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling

KO1
KO2
KO3
KO4
KO5
KO6
WT1
WT2
WT3
WT4
WT5
WT6

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

Label Term Source REF Term Accession Number

Protocol REF

18

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

1
2

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL

Parameter Value[instrument] Term Source REF Term Accession Number
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
Parameter Value[ion source] Term Source REF Term Accession Number
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073

electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization

MS
MS
MS
MS
MS
MS
MS
MS
MS
MS
MS
MS

Parameter Value[detector] Term Source REF Term Accession Number
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Parameter Value[ionization mode] Term Source REF Term Accession Number
NA
NA

positive mode
positive mode

NA
NA

19

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

positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

MS Assay Name Raw Spectral Data File Protocol REF Normalization Name
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

./cdf/KO/ko15.CDF
./cdf/KO/ko16.CDF
./cdf/KO/ko18.CDF
./cdf/KO/ko19.CDF
./cdf/KO/ko21.CDF
./cdf/KO/ko22.CDF
./cdf/WT/wt15.CDF
./cdf/WT/wt16.CDF
./cdf/WT/wt18.CDF
./cdf/WT/wt19.CDF
./cdf/WT/wt21.CDF
./cdf/WT/wt22.CDF

lc-ms-1
lc-ms-2
lc-ms-3
lc-ms-4
lc-ms-5
lc-ms-6
lc-ms-7
lc-ms-8
lc-ms-9
lc-ms-10
lc-ms-11
lc-ms-12

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Data Transformation Name Derived Spectral Data File Factor Value[Genotype]
KO
KO
KO
KO
KO
KO
WT
WT
WT
WT
WT
WT

faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Term Source REF Term Accession Number
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

‘
‘

Slot "assay.files.per.study":
$
$

Global metabolite profiling of faah(-/-) mice
Global metabolite profiling of faah(-/-) mice

‘
‘

[[1]]

20

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

1

Sample Name Protocol REF Extract Name Protocol REF Labeled Extract Name
NA
KO1
NA
KO2
NA
KO3
NA
KO4
NA
KO5
NA
KO6
NA
WT1
NA
WT2
NA
WT3
NA
WT4
NA
WT5
NA
WT6

extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction

labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling

KO1
KO2
KO3
KO4
KO5
KO6
WT1
WT2
WT3
WT4
WT5
WT6

Label Term Source REF Term Accession Number

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Protocol REF
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL

Parameter Value[instrument] Term Source REF Term Accession Number
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
Parameter Value[ion source] Term Source REF Term Accession Number
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073

electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization

MS
MS
MS
MS
MS
MS
MS
MS
MS
MS
MS
MS

Parameter Value[detector] Term Source REF Term Accession Number
NA

NA

NA

21

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

1
2
3

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Parameter Value[ionization mode] Term Source REF Term Accession Number
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

MS Assay Name Raw Spectral Data File Protocol REF Normalization Name
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

./cdf/KO/ko15.CDF
./cdf/KO/ko16.CDF
./cdf/KO/ko18.CDF
./cdf/KO/ko19.CDF
./cdf/KO/ko21.CDF
./cdf/KO/ko22.CDF
./cdf/WT/wt15.CDF
./cdf/WT/wt16.CDF
./cdf/WT/wt18.CDF
./cdf/WT/wt19.CDF
./cdf/WT/wt21.CDF
./cdf/WT/wt22.CDF

lc-ms-1
lc-ms-2
lc-ms-3
lc-ms-4
lc-ms-5
lc-ms-6
lc-ms-7
lc-ms-8
lc-ms-9
lc-ms-10
lc-ms-11
lc-ms-12

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Data Transformation Name Derived Spectral Data File Factor Value[Genotype]
KO
KO
KO
KO
KO
KO
WT
WT
WT
WT
WT
WT

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Term Source REF Term Accession Number
NA
NA
NA

NA
NA
NA

22

NA
NA
NA
NA
NA
NA
NA
NA
NA

4
5
6
7
8
9
10
11
12

NA
NA
NA
NA
NA
NA
NA
NA
NA

Slot "assay.names":
$a_metabolite.txt

MS Assay Name
lc-ms-1
lc-ms-2
lc-ms-3
lc-ms-4
lc-ms-5
lc-ms-6
lc-ms-7
lc-ms-8
lc-ms-9
lc-ms-10
lc-ms-11
lc-ms-12

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

Slot "assay.technology.types":
[1] "mass spectrometry"

Slot "assay.measurement.types":
[1] "metabolite profiling"

Slot "data.filenames":
$a_metabolite.txt

Raw Spectral Data File Derived Spectral Data File
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt
faahkoDSDF.txt

./cdf/KO/ko15.CDF
./cdf/KO/ko16.CDF
./cdf/KO/ko18.CDF
./cdf/KO/ko19.CDF
./cdf/KO/ko21.CDF
./cdf/KO/ko22.CDF
./cdf/WT/wt15.CDF
./cdf/WT/wt16.CDF
./cdf/WT/wt18.CDF
./cdf/WT/wt19.CDF
./cdf/WT/wt21.CDF
./cdf/WT/wt22.CDF

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

Slot "samples":

[1] "KO1" "KO2" "KO3" "KO4" "KO5" "KO6" "WT1" "WT2" "WT3" "WT4" "WT5" "WT6"

23

‘

Slot "samples.per.study":
$

Global metabolite profiling of faah(-/-) mice

‘

[1] "KO1" "KO2" "KO3" "KO4" "KO5" "KO6" "WT1" "WT2" "WT3" "WT4" "WT5" "WT6"

Slot "samples.per.assay.filename":
$a_metabolite.txt

[1] "KO1" "KO2" "KO3" "KO4" "KO5" "KO6" "WT1" "WT2" "WT3" "WT4" "WT5" "WT6"

Slot "assay.filenames.per.sample":
[[1]]
[[1]][[1]]
[1] "a_metabolite.txt"

[[2]]
[[2]][[1]]
[1] "a_metabolite.txt"

[[3]]
[[3]][[1]]
[1] "a_metabolite.txt"

[[4]]
[[4]][[1]]
[1] "a_metabolite.txt"

[[5]]
[[5]][[1]]
[1] "a_metabolite.txt"

[[6]]
[[6]][[1]]
[1] "a_metabolite.txt"

[[7]]
[[7]][[1]]
[1] "a_metabolite.txt"

[[8]]
[[8]][[1]]
[1] "a_metabolite.txt"

[[9]]
[[9]][[1]]

24

[1] "a_metabolite.txt"

[[10]]
[[10]][[1]]
[1] "a_metabolite.txt"

[[11]]
[[11]][[1]]
[1] "a_metabolite.txt"

[[12]]
[[12]][[1]]
[1] "a_metabolite.txt"

Slot "sample.to.rawdatafile":
[[1]]

Sample Name Raw Spectral Data File
./cdf/KO/ko15.CDF
./cdf/KO/ko16.CDF
./cdf/KO/ko18.CDF
./cdf/KO/ko19.CDF
./cdf/KO/ko21.CDF
./cdf/KO/ko22.CDF
./cdf/WT/wt15.CDF
./cdf/WT/wt16.CDF
./cdf/WT/wt18.CDF
./cdf/WT/wt19.CDF
./cdf/WT/wt21.CDF
./cdf/WT/wt22.CDF

KO1
KO2
KO3
KO4
KO5
KO6
WT1
WT2
WT3
WT4
WT5
WT6

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

Slot "sample.to.assayname":
[[1]]

Sample Name MS Assay Name
lc-ms-1
lc-ms-2
lc-ms-3
lc-ms-4
lc-ms-5
lc-ms-6
lc-ms-7
lc-ms-8
lc-ms-9
lc-ms-10
lc-ms-11
lc-ms-12

KO1
KO2
KO3
KO4
KO5
KO6
WT1
WT2
WT3
WT4
WT5
WT6

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

Slot "rawdatafile.to.sample":

25

[[1]]

Raw Spectral Data File Sample Name
KO1
KO2
KO3
KO4
KO5
KO6
WT1
WT2
WT3
WT4
WT5
WT6

./cdf/KO/ko15.CDF
./cdf/KO/ko16.CDF
./cdf/KO/ko18.CDF
./cdf/KO/ko19.CDF
./cdf/KO/ko21.CDF
./cdf/KO/ko22.CDF
./cdf/WT/wt15.CDF
./cdf/WT/wt16.CDF
./cdf/WT/wt18.CDF
./cdf/WT/wt19.CDF
./cdf/WT/wt21.CDF
./cdf/WT/wt22.CDF

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

Slot "assayname.to.sample":
[[1]]

MS Assay Name Sample Name
KO1
WT4
WT5
WT6
KO2
KO3
KO4
KO5
KO6
WT1
WT2
WT3

lc-ms-1
lc-ms-10
lc-ms-11
lc-ms-12
lc-ms-2
lc-ms-3
lc-ms-4
lc-ms-5
lc-ms-6
lc-ms-7
lc-ms-8
lc-ms-9

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

Slot "factors":
[[1]]
[[1]]$

‘

Factor Value[Genotype]

‘

[1] KO KO KO KO KO KO WT WT WT WT WT WT

Levels: KO WT

Factor Value[Genotype]

‘

Slot "treatments":
$
[1] KO WT
Levels: KO WT

‘

Slot "groups":
[[1]]
[[1]][[1]]
[1] "KO1" "KO2" "KO3" "KO4" "KO5" "KO6"

[[1]][[2]]
[1] "WT1" "WT2" "WT3" "WT4" "WT5" "WT6"

26

Slot "assay.tabs":
[[1]]
An object of class "MSAssayTab"
Slot "path":
[1] "/home/biocbuild/bbs-3.5-bioc/R/library/faahKO"

Slot "study.filename":
[1] "s_Proteomic profiling of yeast TFs.txt"

Slot "study.identifier":
[1] "Global metabolite profiling of faah(-/-) mice"

Slot "assay.filename":
[1] "a_metabolite.txt"

Slot "assay.file":

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

1
2
3
4
5
6
7
8

Sample Name Protocol REF Extract Name Protocol REF Labeled Extract Name
NA
KO1
NA
KO2
NA
KO3
NA
KO4
NA
KO5
NA
KO6
NA
WT1
NA
WT2
NA
WT3
NA
WT4
NA
WT5
NA
WT6

extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction
extraction

labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling
labeling

KO1
KO2
KO3
KO4
KO5
KO6
WT1
WT2
WT3
WT4
WT5
WT6

Label Term Source REF Term Accession Number

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Protocol REF
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry
NA mass spectrometry

Parameter Value[instrument] Term Source REF Term Accession Number
NA
NA
NA
NA
NA
NA
NA
NA

Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL

NA
NA
NA
NA
NA
NA
NA
NA

27

9
10
11
12

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

NA
NA
NA
NA

Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL
Agilent 1100 LC-MSD SL

NA
NA
NA
NA
Parameter Value[ion source] Term Source REF Term Accession Number
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073
1000073

electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization
electrospray ionization

MS
MS
MS
MS
MS
MS
MS
MS
MS
MS
MS
MS

Parameter Value[detector] Term Source REF Term Accession Number
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Parameter Value[ionization mode] Term Source REF Term Accession Number
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode
positive mode

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

MS Assay Name Raw Spectral Data File Protocol REF Normalization Name
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

./cdf/KO/ko15.CDF
./cdf/KO/ko16.CDF
./cdf/KO/ko18.CDF
./cdf/KO/ko19.CDF
./cdf/KO/ko21.CDF
./cdf/KO/ko22.CDF
./cdf/WT/wt15.CDF
./cdf/WT/wt16.CDF
./cdf/WT/wt18.CDF
./cdf/WT/wt19.CDF

lc-ms-1
lc-ms-2
lc-ms-3
lc-ms-4
lc-ms-5
lc-ms-6
lc-ms-7
lc-ms-8
lc-ms-9
lc-ms-10

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

28

11
12

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

lc-ms-11
lc-ms-12

./cdf/WT/wt21.CDF
./cdf/WT/wt22.CDF

NA
NA

NA
NA

Data Transformation Name Derived Spectral Data File Factor Value[Genotype]
KO
KO
KO
KO
KO
KO
WT
WT
WT
WT
WT
WT

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Term Source REF Term Accession Number
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

Slot "assay.technology.type":
[1] "mass spectrometry"

Slot "assay.measurement.type":
[1] "metabolite profiling"

Slot "assay.names":
MS Assay Name
lc-ms-1
lc-ms-2
lc-ms-3
lc-ms-4
lc-ms-5
lc-ms-6
lc-ms-7
lc-ms-8
lc-ms-9
lc-ms-10
lc-ms-11
lc-ms-12

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

Slot "data.filenames":

Raw Spectral Data File Derived Spectral Data File
NA
NA

./cdf/KO/ko15.CDF
./cdf/KO/ko16.CDF

1
2

29

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

./cdf/KO/ko18.CDF
./cdf/KO/ko19.CDF
./cdf/KO/ko21.CDF
./cdf/KO/ko22.CDF
./cdf/WT/wt15.CDF
./cdf/WT/wt16.CDF
./cdf/WT/wt18.CDF
./cdf/WT/wt19.CDF
./cdf/WT/wt21.CDF
./cdf/WT/wt22.CDF

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

For an example for a real use case, please refer to https://github.com/sneumann/mtbls2/.

Writing ISA-Tab datasets

The Risa package oﬀers functions to write the whole ISA-Tab dataset or part of it back to disk.
These functions are write.ISAtab, write.investigation.file, write.study.file, write.assay.file.
So, after updating the assay ﬁle as indicated above, we can save it back to disk, using the

following command:

> temp = tempdir()
> write.ISAtab(faahkoISA, temp)
> #write.assay.file(faahkoISA, assay.filename, temp)

Session Info

> toLatex(sessionInfo())

(cid:136) R version 3.4.0 (2017-04-21), x86_64-pc-linux-gnu
(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8, LC_COLLATE=C,

LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.2 LTS
(cid:136) Matrix products: default
(cid:136) BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
(cid:136) LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so
(cid:136) Base packages: base, datasets, grDevices, graphics, methods, parallel, stats, utils
(cid:136) Other packages: Biobase 2.36.0, BiocGenerics 0.22.0, BiocParallel 1.10.0, MSnbase 2.2.0,

ProtGenerics 1.8.0, Rcpp 0.12.10, Risa 1.18.0, aﬀy 1.54.0, biocViews 1.44.0, faahKO 1.15.0,
mzR 2.10.0, xcms 1.52.0

(cid:136) Loaded via a namespace (and not attached): BiocInstaller 1.26.0, IRanges 2.10.0,

MALDIquant 1.16.2, MASS 7.3-47, MassSpecWavelet 1.42.0, Matrix 1.2-9, RANN 2.5,
RBGL 1.52.0, RColorBrewer 1.1-2, RCurl 1.95-4.8, RUnit 0.4.31, S4Vectors 0.14.0,
XML 3.98-1.6, aﬀyio 1.46.0, bitops 1.0-6, codetools 0.2-15, colorspace 1.3-2, compiler 3.4.0,
digest 0.6.12, doParallel 1.0.10, foreach 1.4.3, ggplot2 2.2.1, graph 1.54.0, grid 3.4.0,
gtable 0.2.0, impute 1.50.0, iterators 1.0.8, lattice 0.20-35, lazyeval 0.2.0, limma 3.32.0,
multtest 2.32.0, munsell 0.4.3, mzID 1.14.0, pcaMethods 1.68.0, plyr 1.8.4,
preprocessCore 1.38.0, scales 0.4.1, splines 3.4.0, stats4 3.4.0, survival 2.41-3, tibble 1.3.0,
tools 3.4.0, vsn 3.44.0, zlibbioc 1.22.0

30

Further information

For further information about the ISA software infrastructure, please visit our website http://isa-
tools.org.

31

