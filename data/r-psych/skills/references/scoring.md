Using R to score personality scales*

William Revelle
Northwestern University

February 2, 2026

Abstract

The psych package (Revelle, 2025) was developed to perform most basic psychometric
functions using R (R Core Team, 2025) A common problem is the need to take a set of items
(e.g., a questionnaire) and score one or more scales on that questionnaire. Scores for sub-
sequent analysis, reliabilities and intercorrelations are easily done using the scoreItems
function.

Contents

1 Overview of this and related documents

2 Overview for the impatient

3 An example

3.1 Getting the data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.1.1 Reading from a local ﬁle . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Reading from a remote ﬁle . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2.1 Read from the clipboard . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . .
3.2.2 An example data set
. . . . . . . . . . . . . . . . . . . . .

3.3 Reading data from a Qualtrics data set

4 Scoring scales: an example

4.1 Long output . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Correcting for overlapping items across scales . . . . . . . . . . . . . . . . .
4.3 Get the actual scores for analysis. . . . . . . . . . . . . . . . . . . . . . . . .
4.4 The example, continued . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

5 Exploring a real data set

5.1 Conventional reliability and scoring . . . . . . . . . . . . . . . . . . . . . .
5.2 Show the correction for overlap . . . . . . . . . . . . . . . . . . . . . . . . .

2

2

3
3
3
4
4
5
6

7
9
11
12
12

13
15
17

*Part of a set of tutorials for the psych package.

1

6 Even more analysis: Factoring, clustering, and more tutorials

7 Session Information

18

19

1 Overview of this and related documents

To do basic and advanced personality and psychological research using R is not as complicated
as some think. This is one of a set of “How To” to do various things using R (R Core Team,
2025), particularly using the psych (Revelle, 2025) package.

The current list of How To’s includes:
1. An introduction (vignette) of the psych package
2. An overview (vignette) of the psych package
3. Installing R and some useful packages
4. Using R and the psych package to ﬁnd omegah and ωt .
5. Using R and the psych for factor analysis and principal components analysis.
6. Using the scoreItems function to ﬁnd scale scores and scale statistics (this docu-

ment).

7. Using mediate and lmCor to do mediation, moderation and regression analysis
By following these simple guides, you soon will be able to do such things as ﬁnd scale

scores by issuing just ﬁve lines of code:

R code
library(psych) #necessary whenever you want to run functions in the psych package
my.data <- read.clipboard()
my.keys <- make.keys(my.data,list(scale1 = c(1,4,5),scale2 = c(2,3,6))
my.scales <- scoreItems(my.keys,my.data)
my.scales

#etc

The resulting output will be both graphical and textual.
This guide helps the naive R user to issue those three lines. Be careful, for once you start

using R, you will want to do more.

Suppose you have given a questionnaire with some items (n) to some participants (N). You
would like to create scale scores for each person on k different scales. This may be done using
the psych package in R. The following assumes that you have installed R and downloaded the
psych package.

2 Overview for the impatient

Remember, before using psych and the psychTools packages you must make them active: Here
I just make psych active.

library(psych)

Then
1. Enter the data into a spreadsheet (Excel or Numbers) or a text ﬁle using a text editor
(Word, Pages, BBEdit). The ﬁrst line of the ﬁle should include names for the variables
(e.g., Q1, Q2, ... Qn).

2

2. Copy the data to the clipboard (using the normal copy command for your spreadsheet or

word processor) or save it as .txt or .csv ﬁle.

3. Read the data into R using the read.clipboard command. (Depending upon your data ﬁle,

this might need to be read.clipboard.csv (for comma separated data ﬁelds) or read.clipboard.tab
(for tab separated data ﬁelds).

4. Or, if you have a data ﬁle already that end in .sav, .text, .txt, .csv, .xpt, .rds, .Rds, .rda, or

.RDATA, then just read it in directly using read.file (from psychTools).

5. Construct a set of scoring keys for the scales you want to score using the make.keys
function. This is simply the item names or numbers that go into each scale. A negative
sign implies that the item will be reverse scored.
6. Use the scoreItems function to score the scales.
7. Use the output for scoreItems for further analysis.

3 An example

Suppose we have 12 items for 200 subjects. The items represent 4 different scales: Positive
Energetic Arousal (EAp), Negative Energetic Arousal (EAn), Tense Arousal (TAp) and nega-
tive Tense Arousal (TAn, also known as being relaxed). These four scales can also be thought
of a forming two higher order constructs, Energetic Arousal (EA) and Tense Arousal (TA). EA
is just EAp - EAn, and similarly TA is just TAp - TAn.

3.1 Getting the data

There are, of course, many ways to enter data into R.

3.1.1 Reading from a local ﬁle

Reading from a local ﬁle using read.table is perhaps the most common procedure. You
ﬁrst need to ﬁnd the ﬁle and then read it. This can be done with the file.choose and
read.table functions. file.choose opens a search window on your system just like
any open ﬁle command does. It doesn’t actually read the ﬁle, it just ﬁnds the ﬁle. The read
command is also necessary.

file.name <- file.choose()
my.data <- read.table(file.name)

R code

Even easier is to use the read.file function which combines the file.chooose and
read.table functions into one function. In addition, read.file will read normal text
(txt) ﬁles, comma separated ﬁles (csv), SPSS (sav) ﬁles as well as ﬁles saved by R(rds) ﬁles.
By default, it assumes that the ﬁrst line of the ﬁle has header information (variable names).
read.file is included in the psychTools package which needs to be installed (once) and
made active using the library function.

my.data <- read.file()

#locate the file to read using your normal system.

R code

3

3.2 Reading from a remote ﬁle

To read from a ﬁle saved on a remote server, you just need to specify the ﬁle name and then
read it. By using the read.file function (in the psychTools package), you can read a
variety of ﬁle types (e.g., text, txt, csv, sav, rds) from the remote server. e.g., to read the ﬁle
https://personality-project.org/r/psych/HowTo/scoring.tutorial/small.msq.txt
we specify the ﬁle name and then use read.file:

file.name <-

"https://personality-project.org/r/psych/HowTo/scoring.tutorial/small.msq.txt"

if(require(psychTools)) {my.data <- read.file(file.name)} else { my.data <- small.msq

## Loading required package:
## Data from the .txt file https://personality-project.org/r/psych/HowTo/scoring.tutorial/small.msq.txt
has been loaded.

psychTools

3.2.1 Read from the clipboard

Many users ﬁnd it more convenient to enter their data in a text editor or spreadsheet program
and then just copy and paste into R. The read.clipboard set of functions are perhaps
more user friendly. These functions are included in the psychTools package:
read.clipboard is the base function for reading data from the clipboard.
read.clipboard.csv for reading text that is comma delimited.
read.clipboard.tab for reading text that is tab delimited (e.g., copied directly from an Excel

ﬁle).

read.clipboard.lower for reading input of a lower triangular matrix with or without a diago-

nal. The resulting object is a square matrix.

read.clipboard.upper for reading input of an upper triangular matrix.
read.clipboard.fwf for reading in ﬁxed width ﬁelds (some very old data sets)

For example, given a data set copied to the clipboard from a spreadsheet, just enter the

command.

my.data <- read.clipboard()

R code
#note the parentheses

This will work if every data ﬁeld has a value and even missing data are given some values

(e.g., NA or -999).

However, iff the data were entered in a spreadsheet (e.g. Excel or Numbers) and the missing
values were just empty cells, then the data should be read in as a tab delimited or by using the
read.clipboard.tab function.

R code
#This is for data from a spreadsheet

my.tab.data <- read.clipboard.tab()

For the case of data in ﬁxed width ﬁelds (some very old data sets tend to have this format),
copy to the clipboard and then specify the width of each ﬁeld (in the example below, the
ﬁrst variable is 5 columns, the second is 2 columns, the next 5 are 1 column the last 4 are 3
columns).
my.data <- read.clipboard.fwf(widths=c(5,2,rep(1,5),rep(3,4))

R code

4

3.2.2 An example data set

Consider the data stored at a remote data location. (This is the same ﬁle that we read directly
above.) Open the ﬁle in your browser and then select all. Read them into the clipboard and
enter the read.clipboard command. (These data are selected variables from the ﬁrst 200
cases from the msqR data set in the psychTools package). Once you have read the data, it
useful to see how many cases and how many variables you have dim and to ﬁnd some basic
descriptive statistics.

R code

my.data <- read.clipboard()
headTail(my.data)
dim(my.data)
describe(my.data)

> headTail(my.data)

active alert aroused sleepy tired drowsy anxious jittery nervous calm relaxed at.ease
1
1
2
1
...
1
3
3
3

1
1
1
1
... ...
1
2
3
2

1
1
2
2
...
1
3
3
3

1
1
1
1
...
2
1
0
1

1
0
0
1
...
0
0
0
0

1
1
0
1
...
1
0
1
1

1
1
0
1
...
1
2
3
2

1
0
0
3
...
0
0
1
0

1
1
0
1
...
1
0
1
0

1
0
0
1
...
0
1
0
0

1
0
0
2

0
0
0
0

1
1
1
1
...
1
2
1
1

1
2
3
4
...
197
198
199
200
> dim(my.data)
[1] 200 12

fn <- "https://personality-project.org/r/psych/HowTo/scoring.tutorial/small.msq"
if(require(psychTools)) {my.data <- read.file(fn, filetype="txt")} else {my.data <-

## Data from the .txt file https://personality-project.org/r/psych/HowTo/scoring.tutorial/small.msq
has been loaded.

dim(my.data)

#same as before

## [1] 200

12

headTail(my.data) #same as before

##
## 1
## 2
## 3
## 4
## ...
## 197
## 198
## 199
## 200
##

active alert aroused sleepy tired drowsy anxious jittery nervous calm
1
1
1
1
...
1
2
3
2

1
0
0
2
...
0
0
0
0

1
1
1
1
...
1
2
1
1

1
1
0
1
...
1
2
3
2

1
0
0
1
...
0
0
0
0

1
1
0
1
...
1
0
1
1

1
1
1
1
...
2
1
0
1

1
0
0
3
...
0
0
1
0

1
1
0
1
...
1
0
1
0

1
0
0
1
...
0
1
0
0

relaxed at.ease

5

## 1
## 2
## 3
## 4
## ...
## 197
## 198
## 199
## 200

1
1
2
2
...
1
3
3
3

1
1
2
1
...
1
3
3
3

describe(my.data)

sd median trimmed
1
1
0
2
2
2
0
0
0
2
2
1

0.59 1.48
0.77 1.48
0.25 0.00
1.84 1.48
1.96 1.48
1.63 1.48
0.27 0.00
0.27 0.00
0.16 0.00
1.70 1.48
1.70 1.48
1.53 1.48

skew kurtosis
mad min max range
0.20
0.97
3
-0.41
0.51
3
1.68
3
1.55
-1.22
3 -0.21
-0.95
3 -0.43
-1.21
3 -0.07
3.36
1.87
3
2.74
1.66
3
5.79
3
2.39
-0.91
3 -0.01
-0.81
3 -0.05
-0.87
0.07
3

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

3
3
3
3
3
3
3
3
3
3
3
3

vars

n mean
##
1 199 0.70 0.82
## active
2 197 0.83 0.75
## alert
3 199 0.38 0.63
## aroused
4 199 1.77 1.04
## sleepy
5 198 1.87 1.00
## tired
6 198 1.61 1.05
## drowsy
7 101 0.42 0.71
## anxious
8 198 0.37 0.61
## jittery
9 199 0.30 0.63
## nervous
10 199 1.66 0.91
## calm
11 199 1.67 0.89
## relaxed
12 199 1.53 0.93
## at.ease
##
se
## active 0.06
## alert
0.05
## aroused 0.04
## sleepy 0.07
## tired
0.07
## drowsy 0.07
## anxious 0.07
## jittery 0.04
## nervous 0.04
## calm
0.06
## relaxed 0.06
## at.ease 0.07

3.3 Reading data from a Qualtrics data set

If you have used Qualtrics to collect your data, you can export the data as a csv data ﬁle.
Unfortunately, this ﬁle is poorly organized and has one too many header lines. You can open
the ﬁle using a spreadsheet program (e.g. Excel) and then change the line above the data to be
item labels (e.g., Q1, Q2, ....). Then select that line and all the lines of data that you want to
read, and use the read.clipboard.tab function (see above).

6

4 Scoring scales: an example

To score particular items on particular scales, we must create a set of scoring keys. These
simply tell us which items go on which scales. Note that we can have scales with overlapping
items. There are several ways of creating keys. Probably the most intuitive is just to make
up a list of keys. For example, make up keys to score Energetic Arousal, Activated Arousal,
Deactivated Arousal ... We can do this by specifying the names of the items or their location.
For demonstration purposes, we do this both ways.

my.keys <-

list(EA= c("active","alert","aroused", "-sleepy","-tired", "-drowsy"),
TA = c("anxious","jittery","nervous","-calm", "-relaxed", "-at.ease"),
EAp = c("active","alert","aroused"),
EAn = c("sleepy","tired", "drowsy"),
TAp = c("anxious","jittery","nervous"),
TAn = c("calm", "relaxed", "at.ease")

)

another.keys.list <- list(EA=c(1:3,-4,-5,-6),TA=c(7:9,-10,-11,-12),

EAp =1:3,EAn=4:6,TAp =7:9,TAn=10:12)

Earlier versions of scoreItems required a keys matrix created by make.keys. This is no longer necessary.
Two things to note. The number of variables is the total number of variables (columns) in the data ﬁle. You do not need to include all of these items in
the scoring keys, but you need to say how many there are. For the keys, items are scored either +1, -1 or 0 (not scored). Just specify the items to score and
their direction.

What is actually done internally in the scoreItem function is the keys.list are converted to a matrix of -1s, 0s, and 1s to represent the scoring keys

and this multiplied by the data.

Now, we use those keys to score the data using scoreItems:

These three commands allow you to score the scales, ﬁnd various descriptive statistics

(such as coefﬁcient α), the scale intercorrelations, and also to get the scale scores.

my.scales <- scoreItems(my.keys,my.data)
my.scales
#show the output

EA

EAn

TA EAp

## Call: scoreItems(keys = my.keys, items = my.data)
##
## (Unstandardized) Alpha:
##
TAp TAn
## alpha 0.84 0.74 0.72 0.91 0.66 0.8
##
## Standard errors of unstandardized Alpha:
##
## ASE
##
## Average item correlation:
##
TAn
## average.r 0.46 0.33 0.46 0.76 0.39 0.58
##
## Median item correlation:

TAn
0.035 0.044 0.071 0.052 0.077 0.063

TA EAp

EAp

EAn

TAp

EAn

TAp

EA

EA

TA

7

EA

EA

EA

TAp

EAp

TAp

EAn

EAn

TA EAp

TA EAp

0.72 -0.59

0.7819 -0.19

TA
0.8387 -0.30

EAn
TAp
1.00 -1.06 -0.0045

##
TAn
## 0.42 0.26 0.53 0.78 0.37 0.55
##
## Guttman 6* reliability:
##
TAn
## Lambda.6 0.88 0.79 0.71 0.88 0.61 0.77
##
## Signal/Noise based upon av.r :
##
EA TA EAp EAn TAp TAn
## Signal/Noise 5.2 2.9 2.6 9.7 1.9 4.1
##
## Scale intercorrelations corrected for attenuation
## raw correlations below the diagonal, alpha on the diagonal
## corrected correlations above the diagonal:
TAn
##
0.38
## EA
0.26 1.0011 -1.17
## TA -0.2357 0.74 -0.26
## EAp
0.2350 0.45
## EAn -0.9208 0.21 -0.48
0.91 0.1373 -0.26
## TAp -0.0033 0.70 0.16 0.11 0.6574 -0.45
## TAn
0.80
##
## Average adjusted correlations within and between scales (MIMS)
TAp
##
## EA
## TA -0.08 0.33
## EAp
0.46
0.26 -0.06
## EAn -0.52 0.10 -0.26
## TAp
## TAn
##
## Average adjusted item x scale correlations within and between scales (MIMT)
##
## EA
## TA -0.13 0.65
## EAp
0.80
0.62 -0.14
## EAn -0.85 0.20 -0.44
## TAp -0.01 0.54 0.12 0.08 0.77
## TAn
0.29 -0.19 -0.28
##
## In order to see the item by scale loadings and frequency counts of the data
## print with the short option = FALSE

0.00 0.12 0.04 0.05 0.39
0.16 -0.16 -0.12
0.16 -0.28

0.35 -0.22 -0.3272

0.3100 -0.90

0.26 -0.77

0.85

0.92

0.73

0.46

0.76

0.58

TAp

EAn

TAn

EAn

TAn

EAp

EAp

EA

EA

TA

TA

my.scores <- my.scales$scores

#the actual scores are saved in the scores object

Two things to notice about this output is a) the message about how to get more information

8

(item by scale correlations and frequency counts) and b) that the correlation matrix between
the six scales has the raw correlations below the diagonal, alpha reliabilities on the diagonal,
and correlations adjusted for reliability above the diagonal. Because EAp and EAn are both
part of EA, they correlate with the total more than would be expected given their reliability.
Hence the impossible values greater than |1.0|. The scoreOverlap function will report the
correlations corrected for item overlap.

4.1 Long output

To get the scale correlations corrected for item overlap and scale reliability, we print the object
that we found, but ask for long output.

print(my.scales,short=FALSE)

EA

EA

TA

EA

EA

TAp

EAp

EAn

TAp

EAn

EAn

TA EAp

TA EAp

TAn
0.035 0.044 0.071 0.052 0.077 0.063

## Call: scoreItems(keys = my.keys, items = my.data)
##
## (Unstandardized) Alpha:
##
TAp TAn
## alpha 0.84 0.74 0.72 0.91 0.66 0.8
##
## Standard errors of unstandardized Alpha:
##
## ASE
##
## Average item correlation:
##
TAn
## average.r 0.46 0.33 0.46 0.76 0.39 0.58
##
## Median item correlation:
##
TAn
TAp
TA EAp
## 0.42 0.26 0.53 0.78 0.37 0.55
##
## Guttman 6* reliability:
##
TAn
## Lambda.6 0.88 0.79 0.71 0.88 0.61 0.77
##
## Signal/Noise based upon av.r :
##
EA TA EAp EAn TAp TAn
## Signal/Noise 5.2 2.9 2.6 9.7 1.9 4.1
##
## Scale intercorrelations corrected for attenuation
## raw correlations below the diagonal, alpha on the diagonal
## corrected correlations above the diagonal:
TAn
##
0.38
## EA
0.26 1.0011 -1.17
## TA -0.2357 0.74 -0.26

EAn
TAp
1.00 -1.06 -0.0045

TA
0.8387 -0.30

TA EAp

EAp

TAp

EAn

EAn

EA

EA

9

EA

EA

TA

TA

TAn

TAn

EAn

EAn

TAp

EAp

EAp

0.46

0.73

0.76

0.92

0.58

0.26 -0.77

0.72 -0.59

0.7819 -0.19

0.3100 -0.90

0.35 -0.22 -0.3272

0.00 0.12 0.04 0.05 0.39
0.16 -0.16 -0.12
0.16 -0.28

0.2350 0.45
## EAp
## EAn -0.9208 0.21 -0.48
0.91 0.1373 -0.26
## TAp -0.0033 0.70 0.16 0.11 0.6574 -0.45
## TAn
0.80
##
## Average adjusted correlations within and between scales (MIMS)
TAp
##
## EA
## TA -0.08 0.33
## EAp
0.46
0.26 -0.06
## EAn -0.52 0.10 -0.26
## TAp
## TAn
##
## Average adjusted item x scale correlations within and between scales (MIMT)
##
## EA
## TA -0.13 0.65
## EAp
0.80
0.62 -0.14
## EAn -0.85 0.20 -0.44
## TAp -0.01 0.54 0.12 0.08 0.77
## TAn
0.29 -0.19 -0.28
##
## Item by scale correlations:
## corrected for item overlap and scale reliability
TAn
EAn
TA
##
EAp
0.10 0.39
0.78 -0.47
0.64 -0.25
## active
0.08 0.39
0.63 -0.47
0.58 -0.26
## alert
0.36 0.14
## aroused 0.44 0.04 0.62 -0.27
0.89 0.12 -0.23
0.22 -0.55
## sleepy -0.85
0.85 0.16 -0.30
0.29 -0.55
## tired
-0.82
0.84 0.09 -0.17
0.16 -0.46
## drowsy -0.78
## anxious -0.11
0.34 0.00 0.15 0.50 -0.19
## jittery 0.03 0.48 0.21 0.07 0.62 -0.31
## nervous 0.05 0.53 0.22 0.05 0.68 -0.35
0.68
## calm
0.11 -0.65
0.76
## relaxed 0.33 -0.71
## at.ease 0.39 -0.72
0.79
##
## Non missing response frequency for each item
3 miss
##
## active 0.49 0.35 0.13 0.04 0.01
## alert
0.37 0.46 0.16 0.02 0.02
## aroused 0.70 0.23 0.07 0.01 0.01
## sleepy 0.13 0.30 0.25 0.33 0.01

0.24 -0.02 -0.35
0.34 -0.28 -0.37
0.47 -0.29 -0.34

0.85

TAp

EA

1

0

2

10

## tired
0.12 0.23 0.33 0.33 0.01
## drowsy 0.17 0.30 0.27 0.25 0.01
## anxious 0.68 0.25 0.04 0.03 0.50
## jittery 0.69 0.26 0.04 0.01 0.01
## nervous 0.78 0.17 0.04 0.02 0.01
## calm
0.09 0.37 0.33 0.21 0.01
## relaxed 0.09 0.35 0.37 0.20 0.01
## at.ease 0.13 0.38 0.32 0.17 0.01

4.2 Correcting for overlapping items across scales

The scoreOverlap function will correct for item overlap. In the case of overlapping keys,
(items being scored on multiple scales), scoreOverlap will adjust for this overlap by replacing
the overlapping covariances (which are variances when overlapping) with the corresponding
best estimate of an item’s “true” variance using either the average correlation or the smc es-
timate for that item. This parallels the operation done when ﬁnding alpha reliability. This is
similar to ideas suggested by Cureton (1966) and Bashaw and Anderson Jr (1967) but uses the
smc or the average interitem correlation (default).

scales.ov <- scoreOverlap(my.keys,my.data)
scales.ov

R code

scales

Call: scoreOverlap(keys = my.keys, r = my.data)

(Standardized) Alpha:

EA

TA EAp EAn TAp TAn
0.83 0.76 0.72 0.91 0.73 0.81

(Standardized) G6*:

EA

TA EAp EAn TAp TAn
0.66 0.61 0.72 0.88 0.69 0.77

Average item correlation:

EA

TA EAp EAn TAp TAn
0.45 0.34 0.47 0.76 0.48 0.58

Number of items:

EA TA EAp EAn TAp TAn
3

3

3

3

6

6

Signal to Noise ratio based upon average r and n

EA TA EAp EAn TAp TAn
5.0 3.1 2.6 9.8 2.7 4.1

Scale intercorrelations corrected for item overlap and attenuation

adjusted for overlap correlations below the diagonal, alpha on the diagonal
corrected correlations above the diagonal:
TAn
EAp
TAp
0.073
0.39
0.831 -0.85
0.44
0.286

EA
TA -0.168
EAp 0.684 -0.086

EAn
0.88 -0.893
0.234
0.72 -0.579

TA
0.833 -0.211

0.758 -0.12

EA

11

0.194 -0.47
EAn -0.776
TAp 0.057
0.619
TAn 0.320 -0.661

0.907
0.21 0.091
0.34 -0.222 -0.320

0.111 -0.26
0.733 -0.42
0.81

In order to see the item by scale loadings and frequency counts of the data
print with the short option = FALSE

4.3 Get the actual scores for analysis.

Although we would probably not look at the raw scores, we can if we want by asking for the
scores object which is part of the my.scales output. For printing purposes, we round them to
two decimal places for compactness. We just look at ﬁrst 10 cases.

my.scores <- my.scales$scores
headTail(round(my.scores,2) )

1.5

EA
1.5
1.33

TA EAp
1
1 0.67

EAn
##
1
## 1
1
## 2
1.5 0.67 0.33 0.33
## 3
1
1.5 1.83
## 4
## ...
...
...
...
## 197 1.17
1 0.67 1.33
## 198
## 199 1.83 0.17 1.33 0.67 0.33
## 200 1.67 0.17

TAn
TAp
1
1
1
0
0 1.67
2 1.33
...
1
2 0.33 1.33 0.33 0.33 2.67
3
0 2.67

1
...

...
0

1 0.67

4.4 The example, continued

Once you have the results, you should probably want to describe them and also show a
graphic of the scatterplot using the pairs.panels function (Figure 1). (Note that for the
ﬁgure, we set the plot character to be ’.’ so that it makes a cleaner plot.)

describe(my.scores)

vars

sd median trimmed

mad min

max range

skew kurtosis

##
## EA
## TA
## EAp
## EAn
## TAp
## TAn

n mean
1 200 0.94 0.66
2 200 0.84 0.51
3 200 0.64 0.59
4 200 1.75 0.94
5 200 0.29 0.46
6 200 1.62 0.77

1.00
0.83
0.67
1.67
0.00
1.67

0.91 0.74
0.82 0.49
0.56 0.49
1.80 0.99
0.19 0.00
1.61 0.99

0 2.67 2.67 0.34
0 2.67 2.67 0.40
0 2.33 2.33 0.90
0 3.00 3.00 -0.20
0 2.67 2.67 2.26
0 3.00 3.00 0.12

se
-0.66 0.05
0.15 0.04
0.21 0.04
-1.13 0.07
6.08 0.03
-0.69 0.05

pairs.panels(my.scores,pch='.')

12

0.0

1.0

2.0

0.0 1.0 2.0 3.0

0.0 1.0 2.0 3.0

EA

−0.24

0.78

−0.92

0.00

0.31

TA

−0.19

0.21

0.70

−0.90

EAp

−0.48

0.16

0.35

EAn

0.11

−0.22

TAp

−0.33

TAn

0
.
2

0
.
1

0
.
0

0
.
2

0
.
1

0
.
0

0
2

.

0
1

.

0
0

.

0.0

1.0

2.0

0.0

1.0

2.0

0.0

1.0

2.0

0
.
2

0
.
1

0
.
0

0

.

3

0

.

2

0
1

.

0
0

.

0
3

.

0

.

2

0
1

.

0
0

.

## pdf
2
##

5 Exploring a real data set

The 12 mood items for 200 subjects were taken from the much larger data set, msq in the
psychTools package. That data set has 92 variables for 3896 subjects. We can repeat our
analysis of EA and TA on that data set. This is a data set collected over about 10 years at the
Personality, Motivation and Cognition laboratory at Northwestern and described by Revelle
and Anderson (1997) and Rafaeli and Revelle (2006).

13

Figure 1: A simple scatter plot matrix shows the histograms for the variables on the diagonal, the
correlations above the diagonal, and the scatter plots below the diagonal. The best ﬁtting loess
regression is shown as the red line.

14

5.1 Conventional reliability and scoring

First we get the data for the items that match our small example. Then we describe the data,
and ﬁnally, ﬁnd the 6 scales as we did before. Note that the colnames of our small sample are
the items we want to pick from the larger set. Another way to choose some items is to use the
selectFromKeys function.

Note, that the example runs on the complete data only if the psychTools package is avail-

able. Otherwise, it just runs on the 200 cases previously downloaded.

select <- colnames(my.data)
#or

select <- selectFromKeys(my.keys)
if(require(psychTools)) {small.msq <- psychTools::msq[select]} else {small.msq <- my.data
describe(small.msq) #note that if psychTools is not available this is just 200 cases

sd median trimmed
1
1
0
1
1
1
0
0
0
2
2
2

0.95 1.48
1.09 1.48
0.59 0.00
1.18 1.48
1.36 1.48
1.08 1.48
0.54 0.00
0.45 0.00
0.22 0.00
1.56 1.48
1.72 1.48
1.61 1.48

skew kurtosis
mad min max range
-0.76
0.47
3
-0.76
0.33
3
-0.04
0.95
3
-1.04
0.40
3
-1.10
0.22
3
-0.93
0.46
3
0.26
1.09
3
0.81
1.24
3
3.47
3
1.93
-0.83
3 -0.01
-0.68
3 -0.17
-0.83
3 -0.09

3
3
3
3
3
3
3
3
3
3
3
3

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

vars

n mean
##
1 3890 1.03 0.93
## active
2 3885 1.15 0.91
## alert
3 3890 0.71 0.85
## aroused
4 3880 1.25 1.05
## sleepy
5 3886 1.39 1.04
## tired
6 3884 1.16 1.03
## drowsy
7 2047 0.67 0.86
## anxious
8 3890 0.59 0.80
## jittery
9 3879 0.35 0.65
## nervous
10 3814 1.55 0.92
## calm
11 3889 1.68 0.88
## relaxed
12 3879 1.59 0.92
## at.ease
##
se
## active 0.01
## alert
0.01
## aroused 0.01
## sleepy 0.02
## tired
0.02
## drowsy 0.02
## anxious 0.02
## jittery 0.01
## nervous 0.01
## calm
0.01
## relaxed 0.01
## at.ease 0.01

15

msq.scales <- scoreItems(my.keys,small.msq)
#show the output
msq.scales

EA

EA

EA

EA

TAp

TAp

EAn

EAn

EAn

EAn

EAp

TA EAp

TA EAp

TA EAp EAn

TAn
0.0071 0.0099 0.014 0.011 0.018 0.014

## Call: scoreItems(keys = my.keys, items = small.msq)
##
## (Unstandardized) Alpha:
TAp TAn
##
## alpha 0.87 0.75 0.81 0.93 0.64 0.8
##
## Standard errors of unstandardized Alpha:
##
TA
## ASE
##
## Average item correlation:
##
TAn
## average.r 0.54 0.34 0.58 0.81 0.37 0.57
##
## Median item correlation:
##
TAn
TAp
TA EAp
## 0.53 0.28 0.60 0.80 0.36 0.58
##
## Guttman 6* reliability:
##
TAn
EA
## Lambda.6 0.9 0.77 0.76 0.9 0.59 0.74
##
## Signal/Noise based upon av.r :
##
## Signal/Noise 6.9
##
## Scale intercorrelations corrected for attenuation
## raw correlations below the diagonal, alpha on the diagonal
## corrected correlations above the diagonal:
TAn
##
0.168
## EA
1.096 -1.140
## TA -0.017 0.7515 -0.011 0.024
## EAp
0.246
0.842 -0.0084 0.806 -0.618 0.360
## EAn -0.906 0.0197 -0.534 0.927 -0.067 -0.076
0.163 0.7590 0.258 -0.052 0.638 -0.512
## TAp
## TAn
0.141 -0.8837 0.198 -0.065 -0.366 0.800
##
## Average adjusted correlations within and between scales (MIMS)
##
TAp
## EA
## TA -0.01 0.34
0.42 0.00 0.58
## EAp
## EAn -0.62 0.01 -0.39

TAp
0.874 -0.0207 1.004 -1.006 0.218

EA TA EAp EAn TAp TAn
4

13 1.8

3 4.1

0.54

0.81

TAn

EAn

EAp

EAp

TAp

EAn

EA

TA

EA

TA

16

EA

TA

EAn

EAp

0.57

0.37
0.11 -0.05 -0.15

0.07 0.16 0.11 -0.03
0.08 -0.29

## TAp
## TAn
##
## Average adjusted item x scale correlations within and between scales (MIMT)
##
## EA
## TA
## EAp
0.85
## EAn -0.85 0.02 -0.50
## TAp
## TAn
##
## In order to see the item by scale loadings and frequency counts of the data
## print with the short option = FALSE

0.93
0.12 0.58 0.19 -0.03
0.12 -0.75

0.76
0.17 -0.06 -0.31

0.78
0.00 0.66
0.71 -0.01

0.85

TAn

TAp

5.2 Show the correction for overlap

msq.scales.ov <- scoreOverlap(my.keys,small.msq)
msq.scales.ov
#show the output

EA

EA

EA

EAn

TAp

TAp

TA EAp

TA EAp

## Call: scoreOverlap(keys = my.keys, r = small.msq)
##
## (Standardized) Alpha:
##
TAn
## 0.87 0.78 0.81 0.93 0.73 0.80
##
## (Standardized) G6*:
##
TAn
EAn
## 0.69 0.63 0.76 0.90 0.67 0.75
##
## Average item correlation:
##
TAn
TA EAp
## 0.53 0.37 0.58 0.81 0.48 0.58
##
## Median item correlation:
TAn
TAp
TA EAp
##
## 0.53 0.28 0.60 0.81 0.47 0.58
##
## Number of items:
## EA TA EAp EAn TAp TAn
##
3
3
##
## Signal to Noise ratio based upon average r and n
TAp
EA
##
EAn
4.2 12.9 2.7
## 6.8

TA EAp

TAn
4.1

3.5

EAn

TAp

EAn

EA

6

6

3

3

17

EA

TA

EA

TAp

EAp

EAn

TA EAp

EAn
0.872 0.0264 0.895 -0.8999
0.022 0.7753 0.057
0.750 0.0450 0.806 -0.6153

##
## Scale intercorrelations corrected for item overlap and attenuation
## adjusted for overlap correlations below the diagonal, alpha on the diagonal
## corrected correlations above the diagonal:
TAn
TAp
##
0.176
0.240
## EA
0.0053 0.856 -0.866
## TA
## EAp
0.244
0.369
## EAn -0.810 0.0045 -0.532 0.9283 -0.077 -0.078
0.192 0.6447 0.283 -0.0632
## TAp
0.732 -0.490
0.147 -0.6837 0.197 -0.0675 -0.376 0.804
## TAn
##
## Percentage of keyed items with highest absolute correlation with scale
##
TAn
## 0.67 0.33 0.67 0.00 1.00 0.33
##
## Average adjusted correlations within and between scales (MIMS)
##
TAp
0.53
## EA
0.01 0.37
## TA
## EAp
0.50 0.03 0.58
## EAn -0.59 0.00 -0.42
## TAp
## TAn
##
## Average adjusted item x scale correlations within and between scales (MIMT)
##
## EA -0.09
0.17 -0.05
## TA
## EAp
0.75 0.05 0.74
## EAn -0.93 0.01 -0.57
## TAp
## TAn
##
## In order to see the item by scale loadings and frequency counts of the data
## print with the short option = FALSE

0.89
0.19 0.64 0.26 -0.05
0.15 -0.73

0.81
0.12 0.36 0.19 -0.05
0.10 -0.40

0.48
0.14 -0.05 -0.26

0.66
0.19 -0.06 -0.39

0.58

0.73

EAp

EAp

TAn

TAp

EAn

EAn

TAn

TA

TA

EA

EA

(scale

6 Even more analysis: Factoring, clustering, and more tuto-
rials

Far more analyses could be done with these data, but the basic scale scoring techniques is a
start. Download the vignette for using psych for even more guidance. On a Mac, this is also
available in the vignettes list in the help menu.

In addition, look at the examples in the help for scoreItems.

18

For examples and tutorials in how to do factor analysis or to ﬁnd coefﬁcient omega see the

factor analysis tutorial or the omega tutorial.

7 Session Information

sessionInfo()

/System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib

## R version 4.5.2 (2025-10-31)
## Platform: aarch64-apple-darwin20
## Running under: macOS Tahoe 26.2
##
## Matrix products: default
## BLAS:
## LAPACK: /Library/Frameworks/R.framework/Versions/4.5-arm64/Resources/lib/libRlapack.dylib;
##
## locale:
## [1] C/C.UTF-8/C.UTF-8/C/C.UTF-8/C.UTF-8
##
## time zone: America/Chicago
## tzcode source: internal
##
## attached base packages:
## [1] stats
##
## other attached packages:
## [1] psychTools_2.5.12 psych_2.6.1
##
## loaded via a namespace (and not attached):
## [1] compiler_4.5.2
## [5] R.methodsS3_1.8.2 highr_0.11
knitr_1.50
## [9] grid_4.5.2
lattice_0.22-7
## [13] R.oo_1.27.1

tools_4.5.2
nlme_3.1-168
xfun_0.52
evaluate_1.0.3

foreign_0.8-90
mnormt_2.1.1
rtf_0.4-14.1

grDevices utils

parallel_4.5.2

graphics

datasets

methods

base

19

References

Bashaw, W. and Anderson Jr, H. E. (1967). A correction for replicated error in correlation

coefﬁcients. Psychometrika, 32(4):435–441.

Cureton, E. (1966). Corrected item-test correlations. Psychometrika, 31(1):93–96.

R Core Team (2025). R: A Language and Environment for Statistical Computing. R Foundation

for Statistical Computing, Vienna, Austria.

Rafaeli, E. and Revelle, W. (2006). A premature consensus: Are happiness and sadness truly

opposite affects? Motivation and Emotion, 30(1):1–12.

Revelle, W. (2025). psych: Procedures for Personality and Psychological Research. North-
western University, Evanston, https://CRAN.r-project.org/package=psych. R package ver-
sion 2.5.3

Revelle, W. and Anderson, K. J. (1997). Personality, motivation and cognitive performance.
ﬁnal report to the Army Research Institute on contract MDA 903-93-K-0008. Technical
report, Northwestern University:.

20

https://personality-project.org/r/psych/HowTo/scoring.tutorial/small.msq.txt, 4

Index

describe, 12

ﬁle.chooose, 3
ﬁle.choose, 3

keys, 7

library, 3
lmCor, 2

make.keys, 3, 7
mediate, 2
msq, 13
msqR, 5

pairs.panels, 12
psych, 1, 2, 18
psychTools, 2–5, 13, 15

R function

pairs.panels, 12
read.clipboard, 4, 5
read.clipboard.tab, 4, 6
read.ﬁle, 3, 4
scoreItem, 7
scoreItems, 1–3, 7, 18
scoreOverlap, 9, 11
selectFromKeys, 15

read.clipboard, 4, 5
read.clipboard.tab, 4, 6
read.ﬁle, 3, 4
read.table, 3
scoreItem, 7
scoreItems, 1–3, 7, 18
scoreOverlap, 9, 11
selectFromKeys, 15

R package

psych, 1, 2, 18
psychTools, 2–5, 13, 15

read.clipboard, 4, 5
read.clipboard.tab, 4, 6
read.ﬁle, 3, 4
read.table, 3

scoreItem, 7
scoreItems, 1–3, 7, 18
scoreOverlap, 9, 11
selectFromKeys, 15

describe, 12
ﬁle.chooose, 3
ﬁle.choose, 3
https://personality-project.org/r/psych/HowTo/scoring.tutorial/small.msq.txt, 4
keys, 7
library, 3
lmCor, 2
make.keys, 3, 7
mediate, 2
msq, 13
msqR, 5
pairs.panels, 12
psych package
describe, 12
https://personality-project.org/r/psych/HowTo/scoring.tutorial/small.msq.txt, 4
keys, 7
library, 3
lmCor, 2
make.keys, 3, 7
mediate, 2
msq, 13
msqR, 5

21

