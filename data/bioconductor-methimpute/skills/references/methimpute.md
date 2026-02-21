Methylation status calling with METHimpute

Aaron Taudt ∗
∗aaron.taudt@gmail.com

October 30, 2025

Contents

1

2

3

4

5

6

7

Introduction .

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

.

Methylation status calling on individual cytosines .

2.1

2.2

Separate-context model.

.

Interacting-context model .

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

Methylation status calling on binned data .

Description of columns in the output .

Plots and enrichment analysis .

Export results .

Session Info .

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

2

2

2

6

10

13

13

15

15

Methylation status calling with METHimpute

1

Introduction

Methimpute implements a powerful HMM-based binomial test for methylation status calling.
Besides improved accuracy over the classical binomial test, the HMM allows imputation of the
methylation status of all cytosines in the genome. It achieves this by borrowing information
from neighboring covered cytosines. The confidence in the methylation status call is reported
as well. The HMM can also be used to impute the methylation status for binned data instead
of individual cytosines. Furthermore, methimpute outputs context-specific conversion rates,
which might be used to optimize the experimental procedure.

For the exact workings of methimpute we refer the interested reader to our publication at
https://doi.org/10.1186/s12864-018-4641-x.

2

Methylation status calling on individual cytosines

The following examples explain the necessary steps for methylation status calling (and im-
putation). To keep the calculation time short, it uses only the first 200.000 bp of the
Arabidopsis genome. The example consists of three steps: 1) Data import, 2) estimating the
distance correlation and 3) methylation status calling. At the end of this example you will see
that positions without counts are assigned a methylation status, but the confidence (column
"posteriorMax") is generally quite low for those cytosines, whereas it is high for well-covered
cytosines (>=0.99).

2.1

Separate-context model
The separate-context model runs a separate HMM for each context. This assumes that only
within-context correlations are important, and between-context correlations do not need to
be considered.

library(methimpute)

# ===== Step 1: Importing the data ===== #

# We load an example file in BSSeeker format that comes with the package
file <- system.file("extdata","arabidopsis_bsseeker.txt.gz", package="methimpute")
bsseeker.data <- importBSSeeker(file)

print(bsseeker.data)

## GRanges object with 110927 ranges and 2 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand |

context

counts

<Rle> <IRanges>

<Rle> | <factor> <matrix>

[1]

[2]

[3]

[4]

[5]

...

[110923]

[110924]

[110925]

[110926]

[110927]

chr1

chr1

chr1

chr1

chr1

...

chr1

chr1

chr1

chr1

chr1

34

80

84

85

86

- |

- |

+ |

+ |

+ |

...

... .

533552

533554

533595

533601

533614

- |

- |

+ |

+ |

+ |

CHG

CHH

CHH

CHH

CHH

...

CG

CG

CHG

CHG

CG

0:4

2:9

1:1

1:1

1:1

...

2:2

2:2

0:1

0:2

0:2

2

Methylation status calling with METHimpute

##

##

-------

seqinfo: 1 sequence from an unspecified genome; no seqlengths

# Because most methylation extractor programs report only covered cytosines,

# we need to inflate the data to inlcude all cytosines (including non-covered sites)
fasta.file <- system.file("extdata","arabidopsis_sequence.fa.gz", package="methimpute")
cytosine.positions <- extractCytosinesFromFASTA(fasta.file,

contexts = c('CG','CHG','CHH'))

methylome <- inflateMethylome(bsseeker.data, cytosine.positions)

print(methylome)

## GRanges object with 199978 ranges and 2 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand |

context

counts

<Rle> <IRanges>

<Rle> | <factor> <matrix>

chr1

chr1

chr1

chr1

chr1

...

chr1

chr1

chr1

chr1

chr1

1

2

3

8

9

+ |

+ |

+ |

+ |

+ |

...

... .

533554

533557

533560

533561

533565

- |

+ |

+ |

- |

- |

CHH

CHH

CHH

CHH

CHH

...

CG

CHH

CG

CG

CHH

0:0

0:0

0:0

0:0

0:0

...

2:2

0:0

0:0

0:0

0:0

[1]

[2]

[3]

[4]

[5]

...

[199974]

[199975]

[199976]

[199977]

[199978]

-------

seqinfo: 1 sequence from an unspecified genome

# ===== Step 2: Obtain correlation parameters ===== #

# The correlation of methylation levels between neighboring cytosines is an important

# parameter for the methylation status calling, so we need to get it first. Keep in mind

# that we only use the first 200.000 bp here, that's why the plot looks a bit meagre.

distcor <- distanceCorrelation(methylome, separate.contexts = TRUE)

## Warning:

‘aes_string()‘ was deprecated in ggplot2 3.0.0.

## i Please use tidy evaluation idioms with ‘aes()‘.

## i See also ‘vignette("ggplot2-in-packages")‘ for more information.

## i The deprecated feature was likely used in the methimpute package.

##

Please report the issue to the authors.

## This warning is displayed once every 8 hours.
## Call ‘lifecycle::last_lifecycle_warnings()‘ to see where this warning was
## generated.

fit <- estimateTransDist(distcor)

print(fit)

## $transDist

##

CG-CG

CHG-CHG

CHH-CHH

## 1.866779e+02 6.240462e+08 2.374003e+01

##

## $plot

## Warning:
## (‘geom_line()‘).

Removed 23 rows containing missing values or values outside the scale range

3

Methylation status calling with METHimpute

# ===== Step 3: Methylation status calling (and imputation) ===== #

model <- callMethylationSeparate(data = methylome, transDist = fit$transDist,

verbosity = 0)

# The confidence in the methylation status call is given in the column "posteriorMax".

# For further analysis one could split the results into high-confidence

# (posteriorMax >= 0.98) and low-confidence calls (posteriorMax < 0.98) for instance.

print(model)

## GRanges object with 199978 ranges and 9 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[1]

[2]

[3]

[4]

[5]

...

[199974]

[199975]

[199976]

[199977]

[199978]

[1]

[2]

[3]

[4]

[5]

seqnames

ranges strand |

context

counts distance

<Rle> <IRanges>

<Rle> | <factor> <matrix> <numeric>

chr1

chr1

chr1

chr1

chr1

...

chr1

chr1

chr1

chr1

chr1

1

2

3

8

9

+ |

+ |

+ |

+ |

+ |

...

... .

533554

533557

533560

533561

533565

- |

+ |

+ |

- |

- |

CHH

CHH

CHH

CHH

CHH

...

CG

CHH

CG

CG

CHH

0:0

0:0

0:0

0:0

0:0

...

2:2

0:0

0:0

0:0

0:0

Inf

0

0

4

0

...

0

8

5

0

7

transitionContext posteriorMax posteriorMeth posteriorUnmeth

<factor>

<numeric>

<numeric>

<numeric>

NA

CHH-CHH

CHH-CHH

CHH-CHH

CHH-CHH

0.500403

0.630124

0.726586

0.751637

0.816371

0.500403

0.369876

0.273414

0.248363

0.183629

0.499597

0.630124

0.726586

0.751637

0.816371

4

a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.4, D = 187a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.44, D = 624046222a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24a0 = 0.62, D = 24CGCHGCHHCGCHGCHH0102030405001020304050010203040500.000.250.500.751.000.000.250.500.751.000.000.250.500.751.00distance in [bp]correlationlogweight0.02.55.07.510.0Methylation status calling with METHimpute

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

...

[199974]

[199975]

[199976]

[199977]

[199978]

...

CG-CG

CHH-CHH

CG-CG

CG-CG

CHH-CHH

...

0.999975

0.774223

0.905791

0.830500

0.748042

...

0.999975

0.225777

0.905791

0.830500

0.251958

...

2.45112e-05

7.74223e-01

9.42088e-02

1.69500e-01

7.48042e-01

status rc.meth.lvl

<factor>

<numeric>

[1] Methylated

0.1421450

[2] Unmethylated

0.1050947

[3] Unmethylated

0.0777142

[4] Unmethylated

0.0706035

[5] Unmethylated

0.0522286

...

...

...

[199974] Methylated

0.8515143

[199975] Unmethylated

0.0641924

[199976] Methylated

[199977] Methylated

0.7722162

0.7088245

[199978] Unmethylated

0.0716239

-------

seqinfo: 1 sequence from an unspecified genome

# Bisulfite conversion rates can be obtained with

1 - model$params$emissionParams$Unmethylated

##

prob

## CG

0.9904123

## CHG 0.9907659

## CHH 0.9998944

You can also check several properties of the fitted Hidden Markov Model, such as convergence
or transition probabilities, and check how well the fitted distributions describe the data.

plotConvergence(model)

plotTransitionProbs(model)

5

CGCHGCHH5101551015510150.000.250.500.751.00iterationprobstatusUnmethylatedMethylatedBaum−Welch convergenceCG−CGCHG−CHGCHH−CHHMethylatedUnmethylatedMethylatedUnmethylatedMethylatedUnmethylatedMethylatedUnmethylatedtofromprob0.000.250.500.751.00Transition probabilitiesMethylation status calling with METHimpute

plotHistogram(model, total.counts = 10)

The dot-dot notation (‘..density..‘) was deprecated in ggplot2 3.4.0.

## Warning:
## i Please use ‘after_stat(density)‘ instead.
## i The deprecated feature was likely used in the methimpute package.

##

Please report the issue to the authors.

## This warning is displayed once every 8 hours.
## Call ‘lifecycle::last_lifecycle_warnings()‘ to see where this warning was
## generated.

2.2

Interacting-context model
The interacting-context model runs a single HMM for all contexts. This takes into account
the within-context and between-context correlations and should be more accurate than the
separate-context model if sufficient data is available. However, we have observed that in low
coverage settings too much information from well covered contexts is diffusing into the low
covered contexts (e.g. CHH and CHG will look like CG with very low coverage). In this case,
please use the separate-context model in section 2.1.

library(methimpute)

# ===== Step 1: Importing the data ===== #

# We load an example file in BSSeeker format that comes with the package
file <- system.file("extdata","arabidopsis_bsseeker.txt.gz", package="methimpute")
bsseeker.data <- importBSSeeker(file)

print(bsseeker.data)

## GRanges object with 110927 ranges and 2 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand |

context

counts

<Rle> <IRanges>

<Rle> | <factor> <matrix>

chr1

chr1

chr1

chr1

chr1

...

chr1

chr1

chr1

chr1

chr1

34

80

84

85

86

- |

- |

+ |

+ |

+ |

...

... .

533552

533554

533595

533601

533614

- |

- |

+ |

+ |

+ |

CHG

CHH

CHH

CHH

CHH

...

CG

CG

CHG

CHG

CG

0:4

2:9

1:1

1:1

1:1

...

2:2

2:2

0:1

0:2

0:2

[1]

[2]

[3]

[4]

[5]

...

[110923]

[110924]

[110925]

[110926]

[110927]

-------

seqinfo: 1 sequence from an unspecified genome; no seqlengths

6

CGCHGCHH0.02.55.07.510.00.02.55.07.510.00.02.55.07.510.00.000.250.500.75methylated countsat positions with total counts = 10densitycomponentsTotalUnmethylatedMethylatedFitted distributionsMethylation status calling with METHimpute

# Because most methylation extractor programs report only covered cytosines,

# we need to inflate the data to inlcude all cytosines (including non-covered sites)
fasta.file <- system.file("extdata","arabidopsis_sequence.fa.gz", package="methimpute")
cytosine.positions <- extractCytosinesFromFASTA(fasta.file,

contexts = c('CG','CHG','CHH'))

methylome <- inflateMethylome(bsseeker.data, cytosine.positions)

print(methylome)

## GRanges object with 199978 ranges and 2 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand |

context

counts

<Rle> <IRanges>

<Rle> | <factor> <matrix>

chr1

chr1

chr1

chr1

chr1

...

chr1

chr1

chr1

chr1

chr1

1

2

3

8

9

+ |

+ |

+ |

+ |

+ |

...

... .

533554

533557

533560

533561

533565

- |

+ |

+ |

- |

- |

CHH

CHH

CHH

CHH

CHH

...

CG

CHH

CG

CG

CHH

0:0

0:0

0:0

0:0

0:0

...

2:2

0:0

0:0

0:0

0:0

[1]

[2]

[3]

[4]

[5]

...

[199974]

[199975]

[199976]

[199977]

[199978]

-------

seqinfo: 1 sequence from an unspecified genome

# ===== Step 2: Obtain correlation parameters ===== #

# The correlation of methylation levels between neighboring cytosines is an important

# parameter for the methylation status calling, so we need to get it first. Keep in mind

# that we only use the first 200.000 bp here, that's why the plot looks a bit meagre.

distcor <- distanceCorrelation(methylome)

fit <- estimateTransDist(distcor)

print(fit)

## $transDist

##

CG-CG

CG-CHG

CG-CHH

CHG-CHG

CHG-CHH

CHH-CHH

## 4.163161e+08 3.764952e+06 8.663764e+01 4.124081e+00 8.989007e+07 4.409969e+01

##

## $plot

## Warning:
## (‘geom_line()‘).

Removed 24 rows containing missing values or values outside the scale range

7

Methylation status calling with METHimpute

# ===== Step 3: Methylation status calling (and imputation) ===== #

model <- callMethylation(data = methylome, transDist = fit$transDist)

## Iteration

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

0

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

log(P)

-inf

-40631.538364

-26304.340570

-24210.680366

-23635.136829

-23374.140150

-23224.427402

-23134.096529

-23079.925890

-23047.280470

-23027.416339

-23015.215444

-23007.665702

-23002.970956

-23000.044292

-22998.218552

-22997.079038

-22996.365767

dlog(P)

Time in sec

-

inf

14327.197794

2093.660204

575.543537

260.996679

149.712749

90.330873

54.170638

32.645421

19.864131

12.200895

7.549743

4.694745

2.926664

1.825740

1.139514

0.713271

0

0

0

1

1

1

2

2

2

2

2

3

3

3

3

3

4

4

## HMM: Convergence reached!

# The confidence in the methylation status call is given in the column "posteriorMax".

# For further analysis one could split the results into high-confidence

# (posteriorMax >= 0.98) and low-confidence calls (posteriorMax < 0.98) for instance.

print(model)

## GRanges object with 199978 ranges and 9 metadata columns:

8

a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.65, D = 416316127a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.14, D = 3764952a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.63, D = 4a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.26, D = 87a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.59, D = 89890071a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44a0 = 0.64, D = 44CGCHGCHHCGCHGCHH0102030405001020304050010203040500.000.250.500.751.000.000.250.500.751.000.000.250.500.751.00distance in [bp]correlationlogweight0.02.55.07.510.0Methylation status calling with METHimpute

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand |

context

counts

distance

<Rle> <IRanges>

<Rle> | <factor> <matrix> <numeric>

chr1

chr1

chr1

chr1

chr1

...

chr1

chr1

chr1

chr1

chr1

1

2

3

8

9

+ |

+ |

+ |

+ |

+ |

...

... .

533554

533557

533560

533561

533565

- |

+ |

+ |

- |

- |

CHH

CHH

CHH

CHH

CHH

...

CG

CHH

CG

CG

CHH

0:0

0:0

0:0

0:0

0:0

...

2:2

0:0

0:0

0:0

0:0

Inf

0

0

4

0

...

0

2

2

0

3

transitionContext posteriorMax posteriorMeth posteriorUnmeth

<factor>

<numeric>

<numeric>

<numeric>

NA

CHH-CHH

CHH-CHH

CHH-CHH

CHH-CHH

...

CG-CG

CG-CHH

CHH-CG

CG-CG

CG-CHH

0.660645

0.706838

0.747154

0.762498

0.796352

...

0.999992

0.502982

0.529428

0.559539

0.768933

0.339355

0.293162

0.252846

0.237502

0.203648

...

0.999992

0.497018

0.470572

0.440461

0.231067

0.660645

0.706838

0.747154

0.762498

0.796352

...

7.66870e-06

5.02982e-01

5.29428e-01

5.59539e-01

7.68933e-01

[1]

[2]

[3]

[4]

[5]

...

[199974]

[199975]

[199976]

[199977]

[199978]

[1]

[2]

[3]

[4]

[5]

...

[199974]

[199975]

[199976]

[199977]

[199978]

status rc.meth.lvl

<factor>

<numeric>

[1] Unmethylated

0.1161821

[2] Unmethylated

0.1004775

[3] Unmethylated

0.0867709

[4] Unmethylated

0.0815543

[5] Unmethylated

0.0700448

...

...

...

[199974] Methylated

0.8238826

[199975] Unmethylated

0.1697838

[199976] Unmethylated

0.3906849

[199977] Unmethylated

0.3660465

[199978] Unmethylated

0.0793664

-------

seqinfo: 1 sequence from an unspecified genome

# Bisulfite conversion rates can be obtained with

1 - model$params$emissionParams$Unmethylated

##

prob

## CG

0.9943607

## CHG 0.9979215

## CHH 0.9991911

9

Methylation status calling with METHimpute

3

Methylation status calling on binned data

The following examples explain the necessary steps for methylation status calling (and im-
putation) on binned data, such as commonly used 100bp bins. To keep the calculation time
short, it uses only the first 200.000 bp of the Arabidopsis genome. The example consists of
four steps: 1) Data import, 2) binning and 3) methylation status calling.

library(methimpute)

# ===== Step 1: Importing the data ===== #

# We load an example file in BSSeeker format that comes with the package
file <- system.file("extdata","arabidopsis_bsseeker.txt.gz", package="methimpute")
bsseeker.data <- importBSSeeker(file)

print(bsseeker.data)

## GRanges object with 110927 ranges and 2 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand |

context

counts

<Rle> <IRanges>

<Rle> | <factor> <matrix>

chr1

chr1

chr1

chr1

chr1

...

chr1

chr1

chr1

chr1

chr1

34

80

84

85

86

- |

- |

+ |

+ |

+ |

...

... .

533552

533554

533595

533601

533614

- |

- |

+ |

+ |

+ |

CHG

CHH

CHH

CHH

CHH

...

CG

CG

CHG

CHG

CG

0:4

2:9

1:1

1:1

1:1

...

2:2

2:2

0:1

0:2

0:2

[1]

[2]

[3]

[4]

[5]

...

[110923]

[110924]

[110925]

[110926]

[110927]

-------

seqinfo: 1 sequence from an unspecified genome; no seqlengths

# Because most methylation extractor programs report only covered cytosines,

# we need to inflate the data to inlcude all cytosines (including non-covered sites)
fasta.file <- system.file("extdata","arabidopsis_sequence.fa.gz", package="methimpute")
cytosine.positions <- extractCytosinesFromFASTA(fasta.file,

contexts = c('CG','CHG','CHH'))

methylome <- inflateMethylome(bsseeker.data, cytosine.positions)

print(methylome)

## GRanges object with 199978 ranges and 2 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[1]

[2]

[3]

[4]

[5]

...

[199974]

[199975]

[199976]

[199977]

[199978]

-------

seqnames

ranges strand |

context

counts

<Rle> <IRanges>

<Rle> | <factor> <matrix>

chr1

chr1

chr1

chr1

chr1

...

chr1

chr1

chr1

chr1

chr1

1

2

3

8

9

+ |

+ |

+ |

+ |

+ |

...

... .

533554

533557

533560

533561

533565

- |

+ |

+ |

- |

- |

CHH

CHH

CHH

CHH

CHH

...

CG

CHH

CG

CG

CHH

0:0

0:0

0:0

0:0

0:0

...

2:2

0:0

0:0

0:0

0:0

10

Methylation status calling with METHimpute

##

seqinfo: 1 sequence from an unspecified genome

# ===== Step 2: Binning into 100bp bins ===== #

binnedMethylome <- binMethylome(methylome, binsize = 100, contexts = c('total','CG'))

print(binnedMethylome$CG)

## GRanges object with 5335 ranges and 3 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand | cytosines

context

counts

<Rle>

<IRanges>

<Rle> | <integer> <factor> <matrix>

[1]

[2]

[3]

[4]

[5]

...

[5331]

[5332]

[5333]

[5334]

[5335]

-------

chr1

chr1

chr1

chr1

chr1

...

1-100

101-200

201-300

301-400

401-500

...

chr1 533001-533100

chr1 533101-533200

chr1 533201-533300

chr1 533301-533400

chr1 533401-533500

* |
* |
* |
* |
* |
... .
* |
* |
* |
* |
* |

0

6

0

2

1

CG

CG

CG

CG

CG

...

...

0

14

10

2

8

CG

CG

CG

CG

CG

7:19

41:62

3:58

4:43

0:19

...

0: 55

3:171

0: 16

0: 35

1: 44

seqinfo: 1 sequence from an unspecified genome

# ===== Step 3: Methylation status calling (and imputation) ===== #

binnedModel <- callMethylation(data = binnedMethylome$CG)

##

##

##

##

##

##

##

##

##

##

##

##

##

##

Iteration

0

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

log(P)

-inf

-27231.884280

-16567.652577

-14617.459829

-13264.059065

-12272.683299

-11836.442261

-11645.945339

-11556.833035

-11524.535678

-11514.865975

-11512.066277

-11511.303950

## HMM: Convergence reached!

print(binnedModel)

dlog(P)

Time in sec

-

inf

10664.231703

1950.192748

1353.400764

991.375766

436.241038

190.496922

89.112304

32.297356

9.669703

2.799698

0.762327

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

## GRanges object with 5335 ranges and 10 metadata columns:

##

##

##

##

##

##

##

##

##

##

##

##

seqnames

ranges strand | cytosines

context

counts

distance

<Rle>

<IRanges>

<Rle> | <integer> <factor> <matrix> <numeric>

[1]

[2]

[3]

[4]

[5]

...

chr1

chr1

chr1

chr1

chr1

...

1-100

101-200

201-300

301-400

401-500

...

[5331]

[5332]

[5333]

[5334]

chr1 533001-533100

chr1 533101-533200

chr1 533201-533300

chr1 533301-533400

* |
* |
* |
* |
* |
... .
* |
* |
* |
* |

0

6

0

2

1

CG

CG

CG

CG

CG

...

...

0

14

10

2

CG

CG

CG

CG

7:19

41:62

3:58

4:43

0:19

...

0: 55

3:171

0: 16

0: 35

Inf

0

0

0

0

...

0

0

0

0

11

Methylation status calling with METHimpute

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

[5335]

[1]

[2]

[3]

[4]

[5]

...

[5331]

[5332]

[5333]

[5334]

[5335]

chr1 533401-533500

* |
transitionContext posteriorMax posteriorMeth posteriorUnmeth

1: 44

CG

8

0

<factor>

<numeric>

<numeric>

<numeric>

1.0000000

3.27851e-109

NA

CG-CG

CG-CG

CG-CG

CG-CG

...

CG-CG

CG-CG

CG-CG

CG-CG

CG-CG

1.000000

1.000000

0.642215

0.974230

0.964947

...

1.0000000

0.3577854

0.9742299

0.0350528

...

1.000000

4.02337e-08

1.000000

1.36231e-15

0.999018

9.82491e-04

0.999993

7.22182e-06

0.999908

9.15318e-05

6.63410e-70

6.42215e-01

2.57701e-02

9.64947e-01

...

1.000000

1.000000

0.999018

0.999993

0.999908

status rc.meth.lvl

<factor>

<numeric>

[1] Methylated

[2] Methylated

0.2314384

0.2314384

[3] Unmethylated

0.0854672

[4] Methylated

0.2255810

[5] Unmethylated

0.0121121

...

...

...

[5331] Unmethylated

0.00414488

[5332] Unmethylated

0.00414487

[5333] Unmethylated

0.00436818

[5334] Unmethylated

0.00414651

[5335] Unmethylated

0.00416567

-------

seqinfo: 1 sequence from an unspecified genome

You can also check several properties of the fitted Hidden Markov Model, such as convergence
or transition probabilities, and check how well the fitted distributions describe the data. This
last point is important because the binomial distributions that the HMM uses were originally
meant to describe individual cytosines and not bins. However, we have observed that they
still capture the bimodal distributions of methylation levels in binned data quite well. Note
that the histogram for our example looks quite sparse due to the very low number of bins
that were used.

plotConvergence(binnedModel)

plotTransitionProbs(binnedModel)

12

CG2.55.07.510.012.50.000.250.500.751.00iterationprobstatusUnmethylatedMethylatedBaum−Welch convergenceMethylation status calling with METHimpute

plotHistogram(binnedModel, total.counts = 150)

4

Description of columns in the output

• context The sequence context of the cytosine.

• counts Counts for methylated and total number of reads at each position.

• distance The distance in base-pairs from the previous to the current cytosine.

• transitionContext Transition context in the form "previous-current".

• posteriorMax Maximum posterior value of the methylation status call, can be inter-

preted as the confidence in the call.

• posteriorMeth Posterior value of the "methylated" component.

• posteriorUnmeth Posterior value of the "unmethylated" component.

• status Methylation status.

• rc.meth.lvl Recalibrated methylation level, calculated from the posteriors and the fitted

parameters (see ?methimputeBinomialHMM for details).

5

Plots and enrichment analysis

This package also offers plotting functions for a simple enrichment analysis. Let’s say we are
interested in the methylation level around genes and transposable elements. We would also
like to see how the imputation works on cytosines with missing data compared to covered
cytosines.

# Define categories to distinguish missing from covered cytosines

model$data$category <- factor('covered', levels=c('missing', 'covered'))

model$data$category[model$data$counts[,'total']>=1] <- 'covered'

model$data$category[model$data$counts[,'total']==0] <- 'missing'

# Note that the plots look a bit ugly because our toy data has only 200.000 datapoints.

13

CG−CGMethylatedUnmethylatedMethylatedUnmethylatedtofromprob0.000.250.500.751.00Transition probabilitiesCG0501001500.00.20.40.6methylated countsat positions with total counts = 150densitycomponentsTotalUnmethylatedMethylatedFitted distributionsMethylation status calling with METHimpute

data(arabidopsis_genes)
seqlengths(model$data) <- seqlengths(arabidopsis_genes)[seqlevels(model$data)] # this

plotEnrichment(model$data, annotation=arabidopsis_genes, range = 2000,

# line should only be necessary for our toy example

category.column = 'category')

## $meth.lvl

## Warning:
## (‘geom_line()‘).

Removed 180 rows containing missing values or values outside the scale range

##

## $rc.meth.lvl

data(arabidopsis_TEs)
plotEnrichment(model$data, annotation=arabidopsis_TEs, range = 2000,

category.column = 'category')

## $meth.lvl

## Warning:
## (‘geom_line()‘).

Removed 180 rows containing missing values or values outside the scale range

14

missingcovered−2000−10000%50%100%10002000−2000−10000%50%100%100020000.000.250.500.751.00Distance from annotationMean methylationlevelcontextCGCHGCHHmissingcovered−2000−10000%50%100%10002000−2000−10000%50%100%100020000.000.250.500.751.00Distance from annotationMean recalibratedmethylation levelcontextCGCHGCHHmissingcovered−2000−10000%50%100%10002000−2000−10000%50%100%100020000.000.250.500.751.00Distance from annotationMean methylationlevelcontextCGCHGCHHMethylation status calling with METHimpute

##

## $rc.meth.lvl

6

Export results

You can export the results as TSV file with the following columns:

• chromosome, position, strand, context, counts.methylated, counts.total, posteriorMax,

posteriorMeth, posteriorUnmeth, status, rc.meth.lvl

exportMethylome(model, filename = tempfile())

Please see section 4 for a description of the columns.

7

Session Info

toLatex(sessionInfo())

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C, LC_MONETARY=en_US.UTF-8,

LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, stats4, utils

• Other packages: BiocGenerics 0.56.0, GenomicRanges 1.62.0, IRanges 2.44.0, S4Vectors 0.48.0, Seqinfo 1.0.0,

generics 0.1.4, ggplot2 4.0.0, methimpute 1.32.0

• Loaded via a namespace (and not attached): BiocManager 1.30.26, BiocStyle 2.38.0, Biostrings 2.78.0,

GenomeInfoDb 1.46.0, R.methodsS3 1.8.2, R.oo 1.27.1, R.utils 2.13.0, R6 2.6.1, RColorBrewer 1.1-3, Rcpp 1.1.0,
S7 0.2.0, UCSC.utils 1.6.0, XVector 0.50.0, cli 3.6.5, compiler 4.5.1, crayon 1.5.3, data.table 1.17.8,
dichromat 2.0-0.1, digest 0.6.37, dplyr 1.1.4, evaluate 1.0.5, farver 2.1.2, fastmap 1.2.0, glue 1.8.0, grid 4.5.1,
gtable 0.3.6, highr 0.11, htmltools 0.5.8.1, httr 1.4.7, jsonlite 2.0.0, knitr 1.50, labeling 0.4.3, lifecycle 1.0.4,
magrittr 2.0.4, minpack.lm 1.2-4, pillar 1.11.1, pkgconfig 2.0.3, plyr 1.8.9, reshape2 1.4.4, rlang 1.1.6,
rmarkdown 2.30, scales 1.4.0, stringi 1.8.7, stringr 1.5.2, tibble 3.3.0, tidyselect 1.2.1, tinytex 0.57, tools 4.5.1,
vctrs 0.6.5, withr 3.0.2, xfun 0.53, yaml 2.3.10

15

missingcovered−2000−10000%50%100%10002000−2000−10000%50%100%100020000.000.250.500.751.00Distance from annotationMean recalibratedmethylation levelcontextCGCHGCHH