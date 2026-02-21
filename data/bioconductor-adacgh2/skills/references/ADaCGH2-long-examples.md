Analysis of data from aCGH experiments using parallel
computing and ﬀ objects: long list of examples

Ram´on D´ıaz-Uriarte1

3-October-2014

1. Department of Biochemistry, Universidad Autonoma de Madrid Instituto de
Investigaciones Biomedicas “Alberto Sols” (UAM-CSIC), Madrid (SPAIN).
rdiaz02@gmail.com

Contents

1 This vignette

2 Creating objects

3 The examples

3.1 RAM objects and forking . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 ﬀ objects and cluster
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.3 ﬀ objects and forking . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4 Comparing output . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

4 Exercising the code for the load balancing options

5 Clean up actions

1 This vignette

1

1

16
16
17
18
19

22

23

We provide here example calls of all segmentation methods, with diﬀerent options for meth-
ods, as well as diﬀerent options for type of input object and clustering. This is provided here
as both extended help and as a simple way of checking that all the functions can be run and
yield the same results regardless of type of input and clustering.

2 Creating objects

We must ensure that we can run this vignette as stand alone. Thus, we load the package
and create all necessary objects. This repeats work done in the main vignette.

We ﬁrst try to move to the “ /tmp” directory, if it exists. If it does not, the code will be

executed in your current directory.

> try(setwd("~/tmp"))

> library(ADaCGH2)
> ## loading in-RAM objects
> data(inputEx)
> summary(inputEx)

1

chromosome

Min.
:1.000
1st Qu.:1.000
Median :2.000
:2.284
Mean
3rd Qu.:3.000
:5.000
Max.

position

Min.
: 1180411
1st Qu.: 36030889
Median : 70805790
: 92600349
Mean
3rd Qu.:149843856
:243795357
Max.

L.1

Min.
:-1.07800
1st Qu.:-0.22583
Median :-0.01600
:-0.03548
Mean
3rd Qu.: 0.16000
: 0.88300
Max.
NA's
:5

m4

m5

Min.
:-0.1867
1st Qu.: 1.9790
Median : 2.2807
: 3.4504
Mean
3rd Qu.: 5.8235
: 6.6043
Max.

Min.
:-4.67275
1st Qu.:-0.02025
Median : 0.43725
: 1.60159
Mean
3rd Qu.: 3.04475
: 9.60425
Max.
NA's
:41

L3

Min.
:-13.273
1st Qu.: 3.631
Median : 3.925
: 1.981
Mean
3rd Qu.: 4.110
: 6.374
Max.
NA's
:9

ID

Hs.101850: 1
Hs.1019 : 1
Hs.105460: 1
Hs.105656: 1
Hs.105941: 1
Hs.106674: 1
(Other) :494
L.2

Min.
:-0.795000
1st Qu.:-0.139000
Median :-0.006000
: 0.007684
Mean
3rd Qu.: 0.134000
: 1.076000
Max.
NA's
:15

m6

Min.
:-0.7655
1st Qu.:-0.2260
Median :-0.0440
Mean
:-0.0351
3rd Qu.: 0.1620
: 0.7750
Max.
NA's
:203

> head(inputEx)

1*1180411*Hs.212680
Hs.212680
1*1188041.5*Hs.129780 Hs.129780
Hs.42806
1*1194444*Hs.42806
Hs.76239
1*1332537*Hs.76239
Hs.40500
1*2362211*Hs.40500
Hs.449936
1*2372287*Hs.449936

L.2

L.1

m4
ID chromosome position
NA 0.038 6.22625
1 1180411
NA 0.028 6.17425
1 1188042
NA 0.042 6.17425
1 1194444
NA 0.285 5.62425
1 1332537
1 2362211
NA 0.058 5.85125
1 2372287 0.294 -0.006 5.68525

m5

L3 m6
1*1180411*Hs.212680
3.22625 6.038 NA
1*1188041.5*Hs.129780 3.17425 6.028 NA
3.17425 6.042 NA
1*1194444*Hs.42806
NA NA
2.62425
1*1332537*Hs.76239
NA NA
2.85125
1*2362211*Hs.40500
NA NA
2.68525
1*2372287*Hs.449936

> cgh.dat <- inputEx[, -c(1, 2, 3)]
> chrom.dat <- as.integer(inputEx[, 2])
> pos.dat <- inputEx[, 3]
> ## choosing working dir for cluster
> originalDir <- getwd()
> if(!file.exists("ADaCGH2_vignette_tmp_dir"))
+
dir.create("ADaCGH2_vignette_tmp_dir")
> setwd("ADaCGH2_vignette_tmp_dir")
> ## creating ff objects
> fnameRdata <- list.files(path = system.file("data", package = "ADaCGH2"),
+

full.names = TRUE, pattern = "inputEx.RData")

2

> inputToADaCGH(ff.or.RAM = "ff",
+

RDatafilename = fnameRdata)

... done reading; starting checks

... checking identical MidPos

... checking need to reorder inputData, data.frame version

... done with checks; starting writing

... done writing/saving probeNames

... done writing/saving chromData

... done writing/saving posData

... done writing/saving cghData

Calling gc at end

Ncells 1556933 83.2
Vcells 1548126 11.9

used (Mb) gc trigger (Mb) max used (Mb)
2403845 128.4 1835812 98.1
2481603 19.0 1922758 14.7

Files saved in current directory
/home/ramon/tmp/ADaCGH2_vignette_tmp_dir
with names :
chromData.RData, posData.RData, cghData.RData, probeNames.RData.

> ## setting random number generator for forking
> RNGkind("L'Ecuyer-CMRG")
> ## initializing cluster and setting up random number generator
> number.of.nodes <- detectCores()
> cl2 <- parallel::makeCluster(number.of.nodes,"PSOCK")
> parallel::clusterSetRNGStream(cl2)
> parallel::setDefaultCluster(cl2)
> parallel::clusterEvalQ(NULL, library("ADaCGH2"))

[[1]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[2]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[3]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[4]]

3

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[5]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[6]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[7]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[8]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[9]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[10]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[11]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[12]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[13]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[14]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[15]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[16]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[17]]

4

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[18]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[19]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[20]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[21]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[22]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[23]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[24]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[25]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[26]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[27]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[28]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[29]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[30]]

5

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[31]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[32]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[33]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[34]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[35]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[36]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[37]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[38]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[39]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[40]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[41]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[42]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[43]]

6

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[44]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[45]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[46]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[47]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[48]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[49]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[50]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[51]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[52]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[53]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[54]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[55]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[56]]

7

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[57]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[58]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[59]]

"ff"
[1] "ADaCGH2"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[60]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[61]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[62]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[63]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

[[64]]

[1] "ADaCGH2"
"ff"
[7] "graphics" "grDevices" "utils"

"bit"

"parallel" "methods"
"datasets" "base"

"stats"

> ## verify we are using the right version of ADaCGH2
> parallel::clusterEvalQ(NULL,
+

library(help = ADaCGH2)$info[[1]][[2]])

[[1]]
[1] "Version:

[[2]]
[1] "Version:

[[3]]
[1] "Version:

[[4]]
[1] "Version:

[[5]]

2.5.2"

2.5.2"

2.5.2"

2.5.2"

8

[1] "Version:

2.5.2"

[[6]]
[1] "Version:

[[7]]
[1] "Version:

[[8]]
[1] "Version:

[[9]]
[1] "Version:

[[10]]
[1] "Version:

[[11]]
[1] "Version:

[[12]]
[1] "Version:

[[13]]
[1] "Version:

[[14]]
[1] "Version:

[[15]]
[1] "Version:

[[16]]
[1] "Version:

[[17]]
[1] "Version:

[[18]]
[1] "Version:

[[19]]
[1] "Version:

[[20]]
[1] "Version:

[[21]]
[1] "Version:

[[22]]
[1] "Version:

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

9

[[23]]
[1] "Version:

[[24]]
[1] "Version:

[[25]]
[1] "Version:

[[26]]
[1] "Version:

[[27]]
[1] "Version:

[[28]]
[1] "Version:

[[29]]
[1] "Version:

[[30]]
[1] "Version:

[[31]]
[1] "Version:

[[32]]
[1] "Version:

[[33]]
[1] "Version:

[[34]]
[1] "Version:

[[35]]
[1] "Version:

[[36]]
[1] "Version:

[[37]]
[1] "Version:

[[38]]
[1] "Version:

[[39]]
[1] "Version:

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

10

[[40]]
[1] "Version:

[[41]]
[1] "Version:

[[42]]
[1] "Version:

[[43]]
[1] "Version:

[[44]]
[1] "Version:

[[45]]
[1] "Version:

[[46]]
[1] "Version:

[[47]]
[1] "Version:

[[48]]
[1] "Version:

[[49]]
[1] "Version:

[[50]]
[1] "Version:

[[51]]
[1] "Version:

[[52]]
[1] "Version:

[[53]]
[1] "Version:

[[54]]
[1] "Version:

[[55]]
[1] "Version:

[[56]]
[1] "Version:

[[57]]

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

11

[1] "Version:

2.5.2"

[[58]]
[1] "Version:

[[59]]
[1] "Version:

[[60]]
[1] "Version:

[[61]]
[1] "Version:

[[62]]
[1] "Version:

[[63]]
[1] "Version:

[[64]]
[1] "Version:

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

2.5.2"

> wdir <- getwd()
> parallel::clusterExport(NULL, "wdir")
> parallel::clusterEvalQ(NULL, setwd(wdir))

[[1]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[2]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[3]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[4]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[5]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[6]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[7]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[8]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[9]]

12

[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[10]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[11]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[12]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[13]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[14]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[15]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[16]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[17]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[18]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[19]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[20]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[21]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[22]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[23]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[24]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[25]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[26]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

13

[[27]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[28]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[29]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[30]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[31]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[32]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[33]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[34]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[35]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[36]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[37]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[38]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[39]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[40]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[41]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[42]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[43]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

14

[[44]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[45]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[46]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[47]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[48]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[49]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[50]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[51]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[52]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[53]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[54]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[55]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[56]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[57]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[58]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[59]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[60]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[61]]

15

[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[62]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[63]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

[[64]]
[1] "/home/ramon/tmp/ADaCGH2_vignette_tmp_dir"

>

3 The examples

3.1 RAM objects and forking

merging = "MAD")

merging = "none")

merging = "mergeLevels")

merging = "mergeLevels")

> cbs.mergel.RAM.fork <- pSegmentDNAcopy(cgh.dat, chrom.dat,
+
> cbs.mad.RAM.fork <- pSegmentDNAcopy(cgh.dat, chrom.dat,merging = "MAD")
> cbs.none.RAM.fork <- pSegmentDNAcopy(cgh.dat, chrom.dat, merging = "none")
> hmm.mergel.RAM.fork <- pSegmentHMM(cgh.dat, chrom.dat, merging = "mergeLevels")
> hmm.mad.RAM.fork <- pSegmentHMM(cgh.dat, chrom.dat, merging = "MAD")
> hs.mergel.RAM.fork <- pSegmentHaarSeg(cgh.dat, chrom.dat,
+
> hs.mad.RAM.fork <- pSegmentHaarSeg(cgh.dat, chrom.dat,
+
> hs.none.RAM.fork <- pSegmentHaarSeg(cgh.dat, chrom.dat,
+
> glad.RAM.fork <- pSegmentGLAD(cgh.dat, chrom.dat)
> biohmm.mergel.RAM.fork <- pSegmentBioHMM(cgh.dat,
+
+
+
> biohmm.mad.RAM.fork <- pSegmentBioHMM(cgh.dat,
+
+
+
> biohmm.mad.bic.RAM.fork <- pSegmentBioHMM(cgh.dat,
+
+
+
+
> cghseg.mergel.RAM.fork <- pSegmentCGHseg(cgh.dat,
+
+
> cghseg.mad.RAM.fork <- pSegmentCGHseg(cgh.dat,
+
+
> cghseg.none.RAM.fork <- pSegmentCGHseg(cgh.dat,
+
+

chrom.dat,
pos.dat,
merging = "MAD",
aic.or.bic = "BIC")

chrom.dat,
pos.dat,
merging = "mergeLevels")

chrom.dat,
pos.dat,
merging = "MAD")

chrom.dat,
merging = "mergeLevels")

chrom.dat,
merging = "none")

chrom.dat,
merging = "MAD")

16

> waves.mergel.RAM.fork <- pSegmentWavelets(cgh.dat,
+
> waves.mad.RAM.fork <- pSegmentWavelets(cgh.dat,
+
> waves.none.RAM.fork <- pSegmentWavelets(cgh.dat,
+
>

chrom.dat, merging = "mergeLevels")

chrom.dat, merging = "MAD")

chrom.dat, merging = "none")

3.2 ﬀ objects and cluster

Compared to the section 3.1, the main diﬀerences are that we explicitly set the typeParall
argument to "cluster" (the default is “fork”) and the change in the names of the input data
(which now refer to the names of the RData objects that contain the ﬀ objects).

merging = "mergeLevels",

merging = "none",
typeParall = "cluster")

merging = "MAD",
typeParall = "cluster")

merging = "MAD",
typeParall = "cluster")

merging = "mergeLevels",
typeParall = "cluster")

merging = "mergeLevels",
typeParall = "cluster")

> cbs.mergel.ff.cluster <- pSegmentDNAcopy("cghData.RData", "chromData.RData",
+
+
> cbs.mad.ff.cluster <- pSegmentDNAcopy("cghData.RData", "chromData.RData",
+
+
> cbs.none.ff.cluster <- pSegmentDNAcopy("cghData.RData", "chromData.RData",
+
+
> hmm.mergel.ff.cluster <- pSegmentHMM("cghData.RData", "chromData.RData",
+
+
> hmm.mad.ff.cluster <- pSegmentHMM("cghData.RData", "chromData.RData",
+
+
> hs.mergel.ff.cluster <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
+
> hs.mad.ff.cluster <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
> hs.none.ff.cluster <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
> glad.ff.cluster <- pSegmentGLAD("cghData.RData", "chromData.RData",
+
> biohmm.mergel.ff.cluster <- pSegmentBioHMM("cghData.RData",
+
+
+
+
> biohmm.mad.ff.cluster <- pSegmentBioHMM("cghData.RData",
+
+
+
+
> biohmm.mad.bic.ff.cluster <- pSegmentBioHMM("cghData.RData",
+
+
+

"chromData.RData",
"posData.RData",
merging = "MAD",
typeParall = "cluster")

"chromData.RData",
"posData.RData",
merging = "mergeLevels",

"chromData.RData",
"posData.RData",
merging = "MAD",

merging = "none", typeParall = "cluster")

merging = "MAD", typeParall = "cluster")

typeParall = "cluster")

typeParall = "cluster")

typeParall = "cluster")

17

aic.or.bic = "BIC",
typeParall = "cluster")

"chromData.RData",
merging = "mergeLevels",
typeParall = "cluster")

"chromData.RData",
merging = "MAD",
typeParall = "cluster")

+
+
> cghseg.mergel.ff.cluster <- pSegmentCGHseg("cghData.RData",
+
+
+
> cghseg.mad.ff.cluster <- pSegmentCGHseg("cghData.RData",
+
+
+
> cghseg.none.ff.cluster <- pSegmentCGHseg("cghData.RData",
+
+
+
> waves.mergel.ff.cluster <- pSegmentWavelets("cghData.RData",
+
+
+
> waves.mad.ff.cluster <- pSegmentWavelets("cghData.RData",
+
+
+
> waves.none.ff.cluster <- pSegmentWavelets("cghData.RData",
+
+
+
>

"chromData.RData",
merging = "none",
typeParall = "cluster")

"chromData.RData",
merging = "MAD",
typeParall = "cluster")

"chromData.RData",
merging = "none",
typeParall = "cluster")

"chromData.RData",
merging = "mergeLevels",
typeParall = "cluster")

3.3 ﬀ objects and forking

The main diﬀerence with section 3.2 is the argument typeParall; we did not need to pass
it explicitly (since the default is fork), but we will do for clarity.

merging = "MAD",

typeParall = "fork")

typeParall = "fork")

merging = "mergeLevels",

> cbs.mergel.ff.fork <- pSegmentDNAcopy("cghData.RData", "chromData.RData",
+
+
> cbs.mad.ff.fork <- pSegmentDNAcopy("cghData.RData", "chromData.RData",
+
+
> cbs.none.ff.fork <- pSegmentDNAcopy("cghData.RData", "chromData.RData",
+
> hmm.mergel.ff.fork <- pSegmentHMM("cghData.RData", "chromData.RData",
+
> hmm.mad.ff.fork <- pSegmentHMM("cghData.RData", "chromData.RData",
+
> hs.mergel.ff.fork <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
> hs.mad.ff.fork <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
> hs.none.ff.fork <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
> glad.ff.fork <- pSegmentGLAD("cghData.RData", "chromData.RData",

merging = "mergeLevels", typeParall = "fork")

merging = "none", typeParall = "fork")

merging = "MAD", typeParall = "fork")

merging = "MAD", typeParall = "fork")

merging = "mergeLevels", typeParall = "fork")

merging = "none", typeParall = "fork")

18

"chromData.RData",
"posData.RData",
merging = "MAD",
aic.or.bic = "BIC",

typeParall = "fork")

"chromData.RData",
merging = "mergeLevels",

"chromData.RData",
"posData.RData",
merging = "MAD",

typeParall = "fork")

"chromData.RData",
"posData.RData",
merging = "mergeLevels",

+
> biohmm.mergel.ff.fork <- pSegmentBioHMM("cghData.RData",
+
+
+
+
typeParall = "fork")
> biohmm.mad.ff.fork <- pSegmentBioHMM("cghData.RData",
+
+
+
+
typeParall = "fork")
> biohmm.mad.bic.ff.fork <- pSegmentBioHMM("cghData.RData",
+
+
+
+
+
> cghseg.mergel.ff.fork <- pSegmentCGHseg("cghData.RData",
+
+
+
> cghseg.mad.ff.fork <- pSegmentCGHseg("cghData.RData",
+
+
> cghseg.none.ff.fork <- pSegmentCGHseg("cghData.RData",
+
+
> waves.merge.ff.fork <- pSegmentWavelets("cghData.RData",
+
+
+
> waves.mad.ff.fork <- pSegmentWavelets("cghData.RData",
+
+
+
> waves.none.ff.fork <- pSegmentWavelets("cghData.RData",
+
+
+
>
>

merging = "MAD",
typeParall = "fork")

"chromData.RData",
merging = "none",
typeParall = "fork")

typeParall = "fork")

"chromData.RData",

"chromData.RData",
merging = "MAD", typeParall = "fork")

"chromData.RData",
merging = "none", typeParall = "fork")

"chromData.RData",
merging = "mergeLevels",
typeParall = "fork")

3.4 Comparing output

Here we verify that using diﬀerent input and clustering methods does not change the results.
Before carrying out the comparisons, however, we open the ﬀ objects gently.

First, we will open the objects created above (same objects as were also created in the
main vignette, in section ”Carrying out segmentation and calling”). Instead of inserting many
calls to each individual object, we open all available objects that match ff.cluster. To do
that quickly we store the names of the objects

> ff.cluster.obj <- ls(pattern = "*.ff.cluster")

19

pages with the string “TRUE”)

capture.output(

> tmpout <-
+
+
+

lapply(ff.cluster.obj, function(x) lapply(get(x), open))
)

We repeat that operation with the output from section 3.3:

capture.output(

> ff.fork.obj <- ls(pattern = "*.ff.fork")
> tmpout <-
+
+
+
>

lapply(ff.fork.obj, function(x) lapply(get(x), open))
)

And we create the list of results from the RAM and forking runs (no need for special

opening here, since these are not ﬀ objects)

> RAM.fork.obj <- ls(pattern = "*.RAM.fork")

We can now compare the output. We want to compare the output from three diﬀerent
methods, so we need to run three comparisons (this is what we did explicitly in the help for
pSegment). Since this is a very repetitive operation, we deﬁne a small utility function that
will return TRUE if both components (outSmoothed and outState) of all three objects are
identical. (Since the function will take as input not an actual object, but a name, we use
get inside the function.)

We use all.equal to compare the output from the smoothing, to allow for possible
numerical fuzz (that could result from diﬀerences in storage). When comparing the assigned
state, however, we check for exact identity.

comp1 <- all.equal(get(x)$outSmoothed[ , ], get(y)$outSmoothed[ , ])
comp2 <- all.equal(get(y)$outSmoothed[ , ], get(z)$outSmoothed[ , ])
comp3 <- identical(get(x)$outState[ , ], get(y)$outState[ , ])
comp4 <- identical(get(y)$outState[ , ], get(z)$outState[ , ])
if (!all(isTRUE(comp1), isTRUE(comp2), comp3, comp4)) {

cat(paste("Comparing ", x, y, z, "\n",

"not equal: some info from comparisons.\n",

"\n comp1 = ", paste(comp1, sep = " ", collapse = "\n
"\n comp2 = ", paste(comp2, sep = " ", collapse = "\n
"\n comp3 = ", paste(comp3, sep = " ", collapse = "\n
"\n comp4 = ", paste(comp4, sep = " ", collapse = "\n
"\n\n"))

"),
"),
"),
"),

> identical3 <- function(x, y, z) {
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+ }

} else {
TRUE

return(FALSE)

}

You should expect most (though not necessarily all) the comparisons to yield a TRUE. In
some cases, however, diﬀerent runs of the same method might not yield the same results (e.g.,
CBS, HMM, etc). If you get non-identical results, you can try running those methods a few

20

times, to check for diﬀerences. You can also disable load balancing, and try using reproducible
streams for the random number generators (see the vignette of package parallel).

Let’s check those results then:

> mapply(identical3, RAM.fork.obj,
+

ff.fork.obj, ff.cluster.obj)

Comparing cbs.mad.RAM.fork cbs.mad.ff.fork cbs.mad.ff.cluster

not equal: some info from comparisons.

comp1 = TRUE
comp2 = Component "m4": Mean relative difference: 0.07284734
comp3 = TRUE
comp4 = TRUE

Comparing glad.RAM.fork glad.ff.fork glad.ff.cluster

not equal: some info from comparisons.

comp1 = Component "m5": Mean relative difference: 0.1130491

Component "L3": Mean relative difference: 0.6999325

comp2 = Component "m5": Mean relative difference: 0.1051295

Component "L3": Mean relative difference: 1.194193

comp3 = FALSE
comp4 = FALSE

Comparing hmm.mad.RAM.fork hmm.mad.ff.fork hmm.mad.ff.cluster

not equal: some info from comparisons.

comp1 = TRUE
comp2 = Component "m5": Mean relative difference: 0.6976968
comp3 = TRUE
comp4 = TRUE

biohmm.mad.bic.RAM.fork
TRUE
cbs.mad.RAM.fork
FALSE

TRUE
cbs.mergel.RAM.fork
TRUE
cghseg.mad.RAM.fork cghseg.mergel.RAM.fork
TRUE
hmm.mad.RAM.fork
FALSE
hs.mergel.RAM.fork
TRUE
waves.mergel.RAM.fork
TRUE

biohmm.mad.RAM.fork biohmm.mergel.RAM.fork
TRUE
cbs.none.RAM.fork
TRUE
cghseg.none.RAM.fork
TRUE
hmm.mergel.RAM.fork
TRUE
hs.none.RAM.fork
TRUE
waves.none.RAM.fork
TRUE

TRUE
glad.RAM.fork
FALSE
hs.mad.RAM.fork
TRUE
waves.mad.RAM.fork
TRUE

>

(Of course, we depend on the lists of names of objects having the output from the same

method and option in the same position, which is the case in these examples).

21

4 Exercising the code for the load balancing options

This section simply exercises the load balancing options. We use Haar as it is the fastest
method, and one unlikely to be aﬀected by the order in which diﬀerent columns are run
(Note:
(in contrast to, say, HMM), so we need not worry about random numbers here.
sometimes, and only in some machines, the code that uses the cluster, not the forking, fails
with a serialization error. I do not know the reason.)

> hs.none.RAM.fork <- pSegmentHaarSeg(cgh.dat, chrom.dat,
+
> hs.none.RAM.fork.lb <- pSegmentHaarSeg(cgh.dat, chrom.dat,
+
> hs.none.RAM.fork.nlb <- pSegmentHaarSeg(cgh.dat, chrom.dat,
+
> identical3("hs.none.RAM.fork", "hs.none.RAM.fork.lb", "hs.none.RAM.fork.nlb")

merging = "none", loadBalance = FALSE)

merging = "none", loadBalance = TRUE)

merging = "none")

[1] TRUE

capture.output(

merging = "none", typeParall = "cluster")

merging = "none", typeParall = "cluster",
loadBalance = FALSE)

merging = "none", typeParall = "cluster",
loadBalance = TRUE)

> hs.none.ff.cluster <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
> hs.none.ff.cluster.lb <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
+
> hs.none.ff.cluster.nlb <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
+
> ## do not show all the opening ... messages
> tmpout <-
+
+
+
> tmpout <-
+
+
+
> tmpout <-
+
+
+
> identical3("hs.none.ff.cluster", "hs.none.ff.cluster.lb",
+

lapply("hs.none.ff.cluster.nlb", function(x) lapply(get(x), open))
)

lapply("hs.none.ff.cluster.lb", function(x) lapply(get(x), open))
)

lapply("hs.none.ff.cluster", function(x) lapply(get(x), open))
)

"hs.none.ff.cluster.nlb")

capture.output(

capture.output(

[1] TRUE

merging = "none", typeParall = "fork")

> hs.none.ff.fork <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
> hs.none.ff.fork.lb <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
merging = "none", typeParall = "fork",
+
+
loadBalance = TRUE)
> hs.none.ff.fork.nlb <- pSegmentHaarSeg("cghData.RData", "chromData.RData",
+
+
> tmpout <-

merging = "none", typeParall = "fork",
loadBalance = FALSE)

22

capture.output(

capture.output(

lapply("hs.none.ff.fork", function(x) lapply(get(x), open))
)

+
+
+
> tmpout <-
+
+
+
> tmpout <-
+
+
+
> identical3("hs.none.ff.fork", "hs.none.ff.fork.lb", "hs.none.ff.fork.nlb")

lapply("hs.none.ff.fork.nlb", function(x) lapply(get(x), open))
)

lapply("hs.none.ff.fork.lb", function(x) lapply(get(x), open))
)

capture.output(

[1] TRUE

>

(There is no need to compare between ﬀ.fork, ﬀ.cluster, RAM.fork, as those were already

shown to be identical.)

5 Clean up actions

These are not strictly necessary, but we will explicitly stop the cluster. In this vignette, we
will not execute the code below to remove the directory we created or the objects, in case
you want to check them out or play around with them, but the code is below.

To make sure there are no ﬁle permission problems, we add code below to explicitly delete
some of the ”ﬀ” ﬁles and objects (and we wait a few seconds to allow pending I/O operations
to happen before we delete the directory).

> parallel::stopCluster(cl2)

> ## This is the code to remove all the files we created
> ## and the temporary directory.
> ## We are not executing it!
>
> load("chromData.RData")
> load("posData.RData")
> load("cghData.RData")
> delete(cghData); rm(cghData)
> delete(posData); rm(posData)
> delete(chromData); rm(chromData)
> tmpout <-
+
+
+
> rm(list = ff.fork.obj)
> tmpout <-
+
+
+
> rm(list = ff.cluster.obj)
> setwd(originalDir)

lapply(ff.cluster.obj, function(x) {

lapply(ff.fork.obj, function(x) {

lapply(get(x), delete)}))

lapply(get(x), delete)}))

capture.output(

capture.output(

23

> print(getwd())
> Sys.sleep(3)
> unlink("ADaCGH2_vignette_tmp_dir", recursive = TRUE)
> Sys.sleep(3)

24

