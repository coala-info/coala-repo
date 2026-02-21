Description of affyILM package

K. Myriam Kroll, Fabrice Berger, Gerard Barkema, Enrico Carlon

October 29, 2025

Contents

1 Introduction

2 Getting started
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.1 Preliminaries
2.2 First Steps . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 More Examples with options

1

Introduction

1

1
1
2

3

affyILM is a preprocessing tool which estimates gene expression levels for Affymetrix
Gene Expression Chips. affyILM computes gene expression levels using the Langmuir
model. In contrast to other measures, this method outputs the gene expression level as
concentrations measured in pM (picoMolar).

affyILM allows the user to simultaneously read-in several CEL-files;
require raw data (CEL-files) to be specifically formatted like e.g. as AffyBatch.

it does not

2 Getting started

2.1 Preliminaries

To install the package:

R CMD INSTALL affyILM_x.y.z.tar.gz
affyILM imports several functions from other packages. Make sure to have the following
installed:
affxparser , affy Biobase and gcrma. Chip-specific probe packages which are not yet in-
stalled on your system will be automatically downloaded from the bioconductor webpage
if needed.

1

2.2 First Steps

For demonstration purposes we use a test CEL-file supplied by AffymetrixDataTestFiles.

> require(AffymetrixDataTestFiles)

Load the library

> library(affyILM)

and locate the test CEL-file

> path <- system.file("rawData", "FusionSDK_HG-Focus", "HG-Focus", "2.Calvin",
+
> file1 <- file.path(path,"HG-Focus-1-121502.CEL")

package="AffymetrixDataTestFiles")

Calculation of the hybridization free energies for each probe, and estimation of con-

centrations using the Langmuir isotherm:

> result <- ilm(file1);

x

Chip dimension 448
[1] "Checking to see if your internet connection works..."
Probepackage hgfocusprobe loaded
Reading intensities...[1] ...done

448

Now let’s have a look at the output printed on the screen:

• Chip dimension

• probe package downloaded if missing

Take a look at the experimental PM’s

> getIntens(result,"AFFX-r2-Ec-bioD-5_at")

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id

Plot the result:

HG-Focus-1-121502.CEL HG-Focus-1-121502.CEL
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

644.5
694.3
602.5
1384.0
1329.8
1410.8
1404.0
3265.8
2616.3
1045.5
628.3

2

> plotIntens(result,"AFFX-r2-Ec-bioD-5_at","HG-Focus-1-121502.CEL")

Figure 1: Probes intensities

3 More Examples with options

Analyze two or more CEL-files

> file2 <- file.path(path,"HG-Focus-2-121502.CEL")
> result2files <- ilm(c(file1,file2),satLim=12000)

Chip dimension 448
Probepackage hgfocusprobe loaded
Reading intensities...[1] ...done

448

x

where the saturation limit of the Langmuir isotherm is increased to 12000 (default:
10000)

Get intensity values:

> getIntens(result2files,"AFFX-r2-Ec-bioD-5_at")

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id

HG-Focus-1-121502.CEL HG-Focus-2-121502.CEL
692.3
809.5
687.3

644.5
694.3
602.5

3

246810050010001500200025003000AFFX−r2−Ec−bioD−5_atHG−Focus−1−121502.CELIndexIntensityIPMps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id

1384.0
1329.8
1410.8
1404.0
3265.8
2616.3
1045.5
628.3

1708.5
1513.5
1643.8
1838.0
3985.3
3331.0
1102.0
746.0
HG-Focus-1-121502.CEL HG-Focus-2-121502.CEL
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
0
0
0
0
0
0
0

• 1st column: Probeset name

• 2nd and 3rd column: Measured PM intensities IPM of each file.

• 4th and 5th column: I0 intensities of each file (default value is 0 in current release,

no background estimation).

To obtain the probe concentrations (or expression levels), use

> getProbeConcs(result2files,"AFFX-r2-Ec-bioD-5_at")

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id

HG-Focus-1-121502.CEL HG-Focus-2-121502.CEL
286.9227
265.5849
675.5887
650.8028
295.7714
178.2833
181.1978
594.9351
181.9098
373.3020
113.1372

265.98771
225.46838
587.82734
511.07926
255.39839
149.64574
132.74302
447.36533
131.99693
352.33599
94.30074

4

Use [ to subset the results on one or more probesets

> res_1 <- result["AFFX-r2-Ec-bioD-5_at"]
> res_1

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
[1] 10000

HG-Focus-1-121502.CEL
644.5
694.3
602.5
1384.0
1329.8
1410.8
1404.0
3265.8
2616.3
1045.5
628.3
HG-Focus-1-121502.CEL
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

> res_2 <- result[c("AFFX-r2-Ec-bioD-5_at","207218_at")]
> res_2

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id

HG-Focus-1-121502.CEL
644.5
694.3
602.5
1384.0
1329.8
1410.8
1404.0
3265.8

5

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
[1] 10000

and/or on one or more files:

2616.3
1045.5
628.3
63.8
62.5
83.5
97.0
83.8
191.5
60.8
73.5
133.0
58.8
82.5
HG-Focus-1-121502.CEL
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
0
0
0
0
0
0
0

> res2_1 <- result2files["AFFX-r2-Ec-bioD-5_at"]
> res2_1

6

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
[1] 12000

644.5
694.3
602.5
1384.0
1329.8
1410.8
1404.0
3265.8
2616.3
1045.5
628.3

HG-Focus-1-121502.CEL HG-Focus-2-121502.CEL
692.3
809.5
687.3
1708.5
1513.5
1643.8
1838.0
3985.3
3331.0
1102.0
746.0
HG-Focus-1-121502.CEL HG-Focus-2-121502.CEL
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
0
0
0
0
0
0
0

> res2_2 <- result2files[c("AFFX-r2-Ec-bioD-5_at","207218_at")]
> res2_2

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.207218_at.id
ps.207218_at.id

HG-Focus-1-121502.CEL HG-Focus-2-121502.CEL
692.3
809.5
687.3
1708.5
1513.5
1643.8
1838.0
3985.3
3331.0
1102.0
746.0
66.3
66.0

644.5
694.3
602.5
1384.0
1329.8
1410.8
1404.0
3265.8
2616.3
1045.5
628.3
63.8
62.5

7

ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id

ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.AFFX-r2-Ec-bioD-5_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
ps.207218_at.id
[1] 12000

83.5
97.0
83.8
191.5
60.8
73.5
133.0
58.8
82.5

105.3
109.5
98.5
240.3
77.5
102.5
147.8
63.0
85.3
HG-Focus-1-121502.CEL HG-Focus-2-121502.CEL
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

The output objects are of class ILM.

8

Plot the Langmuir Isotherm :

> pILM<-plotILM(result2files,"AFFX-r2-Ec-bioD-5_at","HG-Focus-1-121502.CEL")

Median =
M.a.d. =

255
181.85

Figure 2: Illustration of the Langmuir Isotherm

9

20253035405010020050010002000500010000AFFX−r2−Ec−bioD−5_at − HG−Focus−1−121502.CELdeltaG + RT*log(alpha)Intensities1234567891011*Ipm : Raw PM Intensitiesc =  255 pMThis function also provides a list with computed values:

> print(str(pILM))

List of 8

$ Ipm

: Named num [1:11] 644 694 602 1384 1330 ...

..- attr(*, "names")= chr [1:11] "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" ...

$ I0pm

: Named num [1:11] 0 0 0 0 0 0 0 0 0 0 ...

..- attr(*, "names")= chr [1:11] "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" ...

$ ImI0

: Named num [1:11] 644 694 602 1384 1330 ...

..- attr(*, "names")= chr [1:11] "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" ...

$ deltaG

: Named num [1:11] 39.1 37 34.1 33.7 32.8 ...

..- attr(*, "names")= chr [1:11] "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" ...

$ deltaGp

: Named num [1:11] 60.7 58.1 56.6 54.6 52.7 ...

..- attr(*, "names")= chr [1:11] "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" ...

$ alpha

: Named num [1:11] 5.98e-05 3.60e-04 9.62e-04 3.80e-03 1.41e-02 ...

..- attr(*, "names")= chr [1:11] "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" ...

$ deltaGpRTlogA: Named num [1:11] 25.9 26.2 24.7 26.2 27 ...

..- attr(*, "names")= chr [1:11] "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" ...

$ Concs

: Named num [1:11] 266 225 588 511 255 ...

..- attr(*, "names")= chr [1:11] "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" "ps.AFFX-r2-Ec-bioD-5_at.id" ...

NULL

10

References

K. M. Kroll, G. T. Barkema, and E. Carlon. Modeling background intensity in DNA

microarrays. Phys. Rev. E, 77:061915, 2008.

K. M. Kroll, G. T. Barkema, and E. Carlon. Linear model for fast background subtrac-
tion in oligonucleotide microarrays. Algorithms for Molecular Biology, 4:15, 2009.

G. Mulders, G.T. Barkema, and E. Carlon. Inverse langmuir method for oligonucleotide

microarray analysis. BMC Bioinformatics, 10:64, 2009.

N. Sugimoto, S. Nakano, M. Katoh, A. Matsumura, H. Nakamuta, T. Ohmichi,
M. Yoneyama, and M. Sasaki. Thermodynamic parameters to predict stability of
RNA/DNA hybrid duplexes. Biochemistry, 34:11211, 1995.

11

