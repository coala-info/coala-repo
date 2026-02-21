# TFHAZ

### Transcription Factor High Accumulation Zones

Alberto Marchesi  and Marco Masseroli

#### 30 October 2025

#### Package

TFHAZ 1.32.0

# 1 Introduction

Transcription factors (TFs) are proteins that bind the DNA in specific regions
and regulate gene expression. The regolation of the gene expression is often
controlled by many TFs interacting with each other. Recent high throughput
methods like chromatin immunoprecipitation followed by sequencing (ChIP-seq)[1](#ref-park2009chip) provide a large number of data regarding TF binding regions,
which are available in public repositories such as ENCODE[2](#ref-encode2004encode)
or Roadmap Epigenomics.[3](#ref-bernstein2010nih)
Starting from a dataset containing the genomic positions of TF binding regions,
the *TFHAZ* package allows finding trascription factor high accumulation DNA
zones, i.e., regions along the genome where there is a high presence of
different transcription factors. In addition, some functions are provided in
order to analyze and compare results obtained with different input parameters.

# 2 Dataset

Transcription factor dense DNA zones are found from a GRanges object that
contains genomic regions of transcription factors at the ranges side and the
name of the transcription factors at the metadata side. As in every object of
GRanges class, the genomic coordinates are located on the left-hand side. The
first column of the ranges side contains the chromosome of each region; the
second column contains the genomic coordinates of each region (starting and
ending position of the transcription factor binding region, considering a
1-based inclusive coordinate system); the third column contains the strand of
each region (“+”, “-”, or “\*” if unknown).
The dataset we consider (called *Ishikawa*) is obtained from computation of
ENCODE ChIP-Seq data of the localization of transcription factor binding regions
for the Ishikawa cell line. The data have been processed and extracted with GMQL
(GenoMetric Query Language <http://www.bioinformatics.deib.polimi.it/GMQL/>)[4](#ref-masseroli2015genometric)[5](#ref-ceri2016data)[6](#ref-masseroli2016modeling).
The *Ishikawa* dataset contains 283,009 ranges of 16 different transcription
factors.

```
# load and visualize the dataset:
data("Ishikawa")
dim(as.data.frame(Ishikawa))
```

```
## [1] 283009      6
```

```
head(Ishikawa)
```

```
## GRanges object with 6 ranges and 1 metadata column:
##       seqnames        ranges strand |         TF
##          <Rle>     <IRanges>  <Rle> |   <factor>
##   [1]     chr1 840014-840266      * | NFIC-human
##   [2]     chr1 841252-841697      * | NFIC-human
##   [3]     chr1 856253-856932      * | NFIC-human
##   [4]     chr1 858967-859537      * | NFIC-human
##   [5]     chr1 859558-860319      * | NFIC-human
##   [6]     chr1 867077-867783      * | NFIC-human
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

# 3 Transcription factor accumulation

The first step in finding transcription factor dense DNA zones is to count the
accumulation of TFs for each chromosome base. The function *accumulation* in the
*TFHAZ* package creates a vector in which, for each chromosome base, the
accumulation of the TFs present in the input dataset is calculated. We
considered three types of accumulation: TF accumulation, region accumulation
and base accumulation.

*TF accumulation*: for each base, it is the number of different TFs present in
the neighborhood of the considered base. The neighborhood is defined by a window
with half-width w centered on the considered base.

*Region accumulation*: for each base, it is the number of regions containing TFs
in the neighborhood of the considered base. If in the neighborhood of a base
there are two input binding regions of the same TF, the accumulation value in
that base is equal to 2 (differently from the TF accumulation, whose value in
the same case is equal to 1).

*Base accumulation*: for each base, it is the total number of bases belonging to
input regions containing TFs in the neighborhood of the considered base.

With w = 0, a single base approach is applied (no base neighborhood is
considered). In this case, if in the input dataset overlapping regions for the
same TF and chromosome do not exist, the results of *TF*, *region* and *base*
accumulation are equal.

The function *accumulation* takes in input:

* a GRanges object containing coordinates of TF binding regions and their TF
  name;
* a string with the name of the accumulation type: “TF”, “region”, “base”;
* a string with the name of the chromosome (e.g., “chr1”) With chr = “all”, all
  the chromosomes in the input GRanges object are considered;
* an integer, half-width of the window that defines the neighborhood of each
  base.

The result of the *accumulation* function is a list containing:

* accvector: a Rle (or SimpleRleList if chr = “all”) object containing the
  accumulation for each base of the selected chromosome;
* acctype: a string with the accumulation type used;
* chr: a string with the chromosome name associated with the accumulation
  vector;
* w: an integer with the half-width of the window used to calculate the
  accumulation vector.

The accumulation vector obtained can be plotted using the function
*plot\_accumulation*.
This function takes in input the output of the *accumulation* function and saves
the plot in a *.png* file. If the accumulation input is found with chr = “all”,
the chromosomes (one or more) to be considered can be chosen by the “chr”
argument.

```
# calculate TF accumulation for the chromosome 21 for w=0
TF_acc_21_w_0 <- accumulation(Ishikawa, "TF", "chr21", 0)
```

```
# plot the accumulation vector
plot_accumulation(TF_acc_21_w_0)
```

![*Plot of the TF accumulation vector for the chromosome 21, obtained for w=0.*](data:image/png;base64...)

Figure 1: *Plot of the TF accumulation vector for the chromosome 21, obtained for w=0.*

As we can see in Figure 1, in this example considering no base neighborhood
(w=0), the maximum value of accumulation found is 14. It means that in the bases
with that accumulation value there are overlapping binding regions of 14 out of the 16 transcription factors present in the dataset.

# 4 Transcription factor dense DNA zones

Once the accumulation for each chromosome base is calculated, we can find
transcription factor dense zones with the *dense\_zones* function. For each
accumulation threshold value defined, the function finds transcription factor
dense DNA zones (regions). Starting from the accumulation vector calculated with
the *accumulation* function, each dense zone is formed by contiguous bases with
accumulation equal or higher than the threshold. Threshold values are selected
by setting the *threshold\_step* parameter.

The function *dense\_zones* takes in input:

* a list of four elements containing: a Rle (or SimpleRleList) with accumulation
  values (e.g., obtained with the *accumulation* function), the accumulation type,
  a chromosome name, and the half-width of the window used for the accumulation
  count;
* an integer, the step used to calculate the threshold values. These values vary
  from 1 to the maximum accumulation value in the considered accumulation
  vector (e.g., found with the *accumulation* function);
* a string with a cromosome name (chr, optional argument). It is needed to apply
  the function only to a single cromosome present in the accumulation input found.
  If chr = “all” (default value) the function operates on all
  the chromosomes present in the input;
* a logical argument, writeBed. When set to TRUE, for each threshold value
  (and for each chromosome) a “.bed” file with the chromosome and genomic
  coordinates of the dense zones found is created.

The result of the *dense\_zones* function is a list containing:

* zones: a list with “GRanges” objects with the dense zones found for each
  chromosome and threshold value considered.
* zones\_count: a list with a data frame for each chromosome considered,
  containing the considered threshold values and the number of dense zones
  obtained with each of the threshold values;
* bases\_count: a list with a data frame for each chromosome considered,
  containing the considered threshold values and the total number of bases
  belonging to the dense zones obtained with each of the threshold values;
* lengths: a list with a data frame for each chromosome considered,
  containing the considered threshold values and min, max, mean, median and
  standard deviation of the dense zone lengths obtained with each of the
  considered threshold values;
* distances: a list with a data frame for each chromosome considered,
  containing the considered threshold values and min, max, mean, median and
  standard deviation of the distances between adjacent dense zones obtained with
  each of the threshold values;
* acctype: a string with the accumulation type used;
* chr: a string with the chromosome name associated with the output zones;
* w: an integer with half-width of the window used to calculate the accumulation
  vector.

```
# find dense DNA zones, with threshold step equal to 1
TF_dense_21_w_0 <- dense_zones(TF_acc_w_0, 1, chr = "chr21")
TF_dense_21_w_0
```

```
## $zones
## $zones$chr21
## $zones$chr21$th_1
## GRanges object with 1265 ranges and 0 metadata columns:
##          seqnames            ranges strand
##             <Rle>         <IRanges>  <Rle>
##      [1]    chr21   9647703-9648184      *
##      [2]    chr21   9696048-9696229      *
##      [3]    chr21   9878315-9878892      *
##      [4]    chr21   9881528-9882531      *
##      [5]    chr21   9908929-9910245      *
##      ...      ...               ...    ...
##   [1261]    chr21 48017979-48018220      *
##   [1262]    chr21 48023037-48023509      *
##   [1263]    chr21 48024867-48025287      *
##   [1264]    chr21 48054801-48056406      *
##   [1265]    chr21 48086981-48088470      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_2
## GRanges object with 558 ranges and 0 metadata columns:
##         seqnames            ranges strand
##            <Rle>         <IRanges>  <Rle>
##     [1]    chr21   9878496-9878825      *
##     [2]    chr21   9881537-9882417      *
##     [3]    chr21   9909101-9910088      *
##     [4]    chr21 10597536-10597745      *
##     [5]    chr21 11098303-11099464      *
##     ...      ...               ...    ...
##   [554]    chr21 47877766-47879257      *
##   [555]    chr21 47974706-47975150      *
##   [556]    chr21 47982985-47983832      *
##   [557]    chr21 48054865-48056329      *
##   [558]    chr21 48087039-48088442      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_3
## GRanges object with 424 ranges and 0 metadata columns:
##         seqnames            ranges strand
##            <Rle>         <IRanges>  <Rle>
##     [1]    chr21   9881552-9882414      *
##     [2]    chr21   9909189-9910019      *
##     [3]    chr21 11098310-11099444      *
##     [4]    chr21 11144304-11144918      *
##     [5]    chr21 15645943-15646549      *
##     ...      ...               ...    ...
##   [420]    chr21 47877787-47879256      *
##   [421]    chr21 47974750-47975126      *
##   [422]    chr21 47983035-47983824      *
##   [423]    chr21 48054865-48056292      *
##   [424]    chr21 48087094-48088369      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_4
## GRanges object with 343 ranges and 0 metadata columns:
##         seqnames            ranges strand
##            <Rle>         <IRanges>  <Rle>
##     [1]    chr21   9881686-9882348      *
##     [2]    chr21   9909399-9909966      *
##     [3]    chr21 11098350-11099365      *
##     [4]    chr21 15645945-15646537      *
##     [5]    chr21 15755207-15755932      *
##     ...      ...               ...    ...
##   [339]    chr21 47744464-47744564      *
##   [340]    chr21 47877938-47879206      *
##   [341]    chr21 47983079-47983639      *
##   [342]    chr21 48054878-48056209      *
##   [343]    chr21 48087549-48088359      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_5
## GRanges object with 283 ranges and 0 metadata columns:
##         seqnames            ranges strand
##            <Rle>         <IRanges>  <Rle>
##     [1]    chr21   9881864-9882344      *
##     [2]    chr21 11098361-11099296      *
##     [3]    chr21 15646005-15646499      *
##     [4]    chr21 15755224-15755898      *
##     [5]    chr21 16247979-16248666      *
##     ...      ...               ...    ...
##   [279]    chr21 47877954-47879170      *
##   [280]    chr21 47983164-47983617      *
##   [281]    chr21 48054915-48055327      *
##   [282]    chr21 48055643-48056179      *
##   [283]    chr21 48087643-48088251      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_6
## GRanges object with 196 ranges and 0 metadata columns:
##         seqnames            ranges strand
##            <Rle>         <IRanges>  <Rle>
##     [1]    chr21   9881972-9882267      *
##     [2]    chr21 11098374-11099096      *
##     [3]    chr21 15646071-15646480      *
##     [4]    chr21 15755231-15755829      *
##     [5]    chr21 16248048-16248630      *
##     ...      ...               ...    ...
##   [192]    chr21 47705611-47706730      *
##   [193]    chr21 47743778-47744198      *
##   [194]    chr21 47744412-47744444      *
##   [195]    chr21 47877966-47879071      *
##   [196]    chr21 48087776-48088105      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_7
## GRanges object with 134 ranges and 0 metadata columns:
##         seqnames            ranges strand
##            <Rle>         <IRanges>  <Rle>
##     [1]    chr21 11098474-11099081      *
##     [2]    chr21 15646181-15646398      *
##     [3]    chr21 15755291-15755618      *
##     [4]    chr21 16437133-16437148      *
##     [5]    chr21 16437156-16437702      *
##     ...      ...               ...    ...
##   [130]    chr21 46823750-46824553      *
##   [131]    chr21 46847273-46848145      *
##   [132]    chr21 46961476-46961952      *
##   [133]    chr21 47705641-47706648      *
##   [134]    chr21 47878255-47878872      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_8
## GRanges object with 93 ranges and 0 metadata columns:
##        seqnames            ranges strand
##           <Rle>         <IRanges>  <Rle>
##    [1]    chr21 16437167-16437660      *
##    [2]    chr21 16976653-16977176      *
##    [3]    chr21 17079029-17079434      *
##    [4]    chr21 17094988-17095357      *
##    [5]    chr21 17102094-17102125      *
##    ...      ...               ...    ...
##   [89]    chr21 46847506-46848135      *
##   [90]    chr21 46961496-46961941      *
##   [91]    chr21 47705885-47706620      *
##   [92]    chr21 47878395-47878750      *
##   [93]    chr21 47878815-47878836      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_9
## GRanges object with 56 ranges and 0 metadata columns:
##        seqnames            ranges strand
##           <Rle>         <IRanges>  <Rle>
##    [1]    chr21 16437178-16437644      *
##    [2]    chr21 16976710-16977097      *
##    [3]    chr21 17079059-17079381      *
##    [4]    chr21 17792433-17792742      *
##    [5]    chr21 17906640-17907222      *
##    ...      ...               ...    ...
##   [52]    chr21 46749546-46750481      *
##   [53]    chr21 46783762-46784481      *
##   [54]    chr21 46847519-46848135      *
##   [55]    chr21 46961503-46961928      *
##   [56]    chr21 47705894-47706507      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_10
## GRanges object with 32 ranges and 0 metadata columns:
##        seqnames            ranges strand
##           <Rle>         <IRanges>  <Rle>
##    [1]    chr21 16437246-16437603      *
##    [2]    chr21 17906738-17907135      *
##    [3]    chr21 17936017-17936530      *
##    [4]    chr21 18884908-18885519      *
##    [5]    chr21 26979590-26980079      *
##    ...      ...               ...    ...
##   [28]    chr21 46359623-46360089      *
##   [29]    chr21 46749631-46750470      *
##   [30]    chr21 46783769-46784454      *
##   [31]    chr21 46847582-46847985      *
##   [32]    chr21 47705905-47706333      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_11
## GRanges object with 15 ranges and 0 metadata columns:
##        seqnames            ranges strand
##           <Rle>         <IRanges>  <Rle>
##    [1]    chr21 17936079-17936490      *
##    [2]    chr21 18885005-18885518      *
##    [3]    chr21 26979675-26980039      *
##    [4]    chr21 29765568-29766071      *
##    [5]    chr21 33984736-33985219      *
##    ...      ...               ...    ...
##   [11]    chr21 45209153-45209668      *
##   [12]    chr21 46359626-46360076      *
##   [13]    chr21 46749679-46750446      *
##   [14]    chr21 46783821-46784394      *
##   [15]    chr21 47705958-47706318      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_12
## GRanges object with 7 ranges and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]    chr21 17936082-17936489      *
##   [2]    chr21 18885028-18885512      *
##   [3]    chr21 40284873-40285700      *
##   [4]    chr21 40685540-40686019      *
##   [5]    chr21 43054505-43054878      *
##   [6]    chr21 45209176-45209657      *
##   [7]    chr21 46359647-46360047      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_13
## GRanges object with 2 ranges and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]    chr21 18885132-18885398      *
##   [2]    chr21 40685550-40685969      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
## $zones$chr21$th_14
## GRanges object with 1 range and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]    chr21 40685632-40685961      *
##   -------
##   seqinfo: 24 sequences from an unspecified genome
##
##
##
## $zones_count
## $zones_count$chr21
##    threshold n_zones
## 1          1    1265
## 2          2     558
## 3          3     424
## 4          4     343
## 5          5     283
## 6          6     196
## 7          7     134
## 8          8      93
## 9          9      56
## 10        10      32
## 11        11      15
## 12        12       7
## 13        13       2
## 14        14       1
##
##
## $bases_count
## $bases_count$chr21
##    threshold n_bases
## 1          1  884594
## 2          2  429675
## 3          3  315332
## 4          4  235669
## 5          5  173254
## 6          6  111781
## 7          7   72784
## 8          8   45232
## 9          9   27580
## 10        10   16873
## 11        11    7802
## 12        12    3458
## 13        13     687
## 14        14     330
##
##
## $lengths
## $lengths$chr21
##    threshold n_zones length_zone_min length_zone_max length_zone_mean
## 1          1    1265             168            4164         699.2838
## 2          2     558               2            3179         770.0269
## 3          3     424               2            2244         743.7075
## 4          4     343               2            2039         687.0816
## 5          5     283               3            1545         612.2049
## 6          6     196              12            1225         570.3112
## 7          7     134               1            1212         543.1642
## 8          8      93               9            1077         486.3656
## 9          9      56               7             971         492.5000
## 10        10      32             264             960         527.2812
## 11        11      15             328             920         520.1333
## 12        12       7             374             828         494.0000
## 13        13       2             267             420         343.5000
## 14        14       1             330             330         330.0000
##    length_zone_median length_zone_sd
## 1               566.0       415.2782
## 2               706.0       383.8741
## 3               687.0       344.1256
## 4               660.0       306.2085
## 5               609.0       287.4903
## 6               576.0       268.5662
## 7               532.0       257.2716
## 8               459.0       252.1179
## 9               519.0       228.1558
## 10              478.5       162.7088
## 11              504.0       161.1095
## 12              480.0       154.0682
## 13              343.5       108.1873
## 14              330.0             NA
##
##
## $distances
## $distances$chr21
##    threshold n_zones dist_zone_min dist_zone_max dist_zone_mean
## 1          1    1265             4       3967595       29713.16
## 2          2     558             6       4500973       67829.14
## 3          3     424             2       4501025       89578.98
## 4          4     343             6       4546580      111027.33
## 5          5     283             2       4546709      134870.27
## 6          6     196             8       6065108      195356.66
## 7          7     134             3       6065276      275998.11
## 8          8      93             4       7787560      341266.63
## 9          9      56            25       7787773      568032.82
## 10        10      32          6669       8094071     1008136.97
## 11        11      15         33375       8094157     2125889.43
## 12        12       7        399840      21399361     4736752.33
## 13        13       2      21800152      21800152    21800152.00
## 14        14       1            NA            NA             NA
##    dist_zone_median dist_zone_sd
## 1             11388     122569.1
## 2             18144     260613.7
## 3             23311     320704.8
## 4             31221     358342.4
## 5             33190     439562.7
## 6             50995     608044.2
## 7             87341     727219.5
## 8            113364     904014.4
## 9            114684    1209207.0
## 10           389542    1662356.6
## 11          1652100    2175152.0
## 12          1652144    8196883.8
## 13         21800152           NA
## 14               NA           NA
##
##
## $chr
## [1] "chr21"
##
## $w
## [1] 0
##
## $acctype
## [1] "TF"
```

![*Content of the 'bed' file with the coordinates of the seven dense DNA zones found  for the chromosome 21 with transcription factor accumulation threshold value equal to 12.*](data:image/png;base64...)

Figure 2: *Content of the ‘bed’ file with the coordinates of the seven dense DNA zones found for the chromosome 21 with transcription factor accumulation threshold value equal to 12.*

We can plot the results present in the *zones\_count* data frame with the
function *plot\_n\_zones* (Figure 3) and we can see how the number of dense DNA
zones decreases as the accumulation threshold value increases. The function also
plots the point of the graph with maximum slope change, corresponding to the
maximum second derivative of the curve, circulating it with a red full line.

```
plot_n_zones(TF_dense_w_0, chr = "chr21")
```

![*Plot of the number of dense DNA zones found varying the TF accumulation threshold value for the chromosome 21; the point with maximum slope change is plotted circulated with a red full line.*](data:image/png;base64...)

Figure 3: *Plot of the number of dense DNA zones found varying the TF accumulation threshold value for the chromosome 21; the point with maximum slope change is plotted circulated with a red full line.*

# 5 Transcription factor dense DNA zones analysis

After finding transcription factor dense DNA zones, we can use two functions of
the *TFHAZ* package to compare the results obtained with different values of *w*
half-width of the base neighborhood window and different accumulation types.

With the function *w\_analysis* we can plot the number of dense zones and the
total number of bases belonging to these dense zones present in a set of inputs,
obtained (all with accumulation threshold=1) using the *dense\_zones* function,
for the same accumulation type, same chromosome, and different values of *w*
half-width of the window defining the neighborhood of each base. The function
takes in input a list of multiple outputs of the *dense\_zones* function and
returns a plot (with x axis logarithmic-scale).

```
# l is a list with four objects obtained with the dense_zones function with
# w = 10, 100, 1000, 10000.
l <- list(TF_dense_w_10, TF_dense_w_100, TF_dense_w_1000, TF_dense_w_10000)
# plot
w_analysis(l, chr = "chr21")
```

![*Plot of the number of dense DNA zones (red full line) and of the total number of bases belonging to dense DNA zones (blue dashed line) obtained with different values of neighborhood window half-width w for the chromosome 21.*](data:image/png;base64...)

Figure 4: *Plot of the number of dense DNA zones (red full line) and of the total number of bases belonging to dense DNA zones (blue dashed line) obtained with different values of neighborhood window half-width w for the chromosome 21.*

If we consider the four different values of *w* half-width of the base
neighborhood window in the example, we can notice in Figure 4 that the two
measures (i.e., the number of dense zones and the total number of bases
belonging to these dense zones) are inversely correlated; the number of bases
increases with the size of the neighborhood, while the number of dense zones
decreases. Furthermore, observing the plot, we can notice that the highest
increase or decrease of the two measures occurs when the half-width of the
neighborhood assumes values higher than 1000 bases. So, w=1000 can be considered
a good value in finding dense zones when using an accumulation approach with
neighborhood (w different from 0). It is worth noting that the calculation time
of the accumulation vector increases considerably with higher values of w.

In order to understand how to integrate the results obtained with the three
different accumulation types, using the function *n\_zones\_PCA* we can perform
the Principal Component Analysis (PCA)[7](#ref-johnson2014applied)[8](#ref-bro2014principal)
of the number of dense zones obtained by varying the threshold on accumulation
values obtained with the three methods of accumulation (TF, region, base).

The Principal Component Analysis produces a low dimensional representation of a
dataset, finding a linear sequence of linear combinations of the variables that
have maximal variance.
With PCA we want to find if there is a possible way to combine the three
measures (TF, region, base accumulation), or if the information obtained is the
same, and we can use only one of these measures for our study. For this purpose
it is useful to observe the variance associated with the first principal
component and the loadings, the coefficients of the linear combination of each
principal component, that explain the proportion of each variable along each
principal component.

This function takes in input:

* a list with the results of the *dense\_zones* function using the TF
  accumulation method and varying the thresholds on the considered accumulation
  values;
* a list with the results of the *dense\_zones* function using the region
  accumulation method and varying the thresholds on the considered accumulation
  values;
* a list with the results of the *dense\_zones* function using the base
  accumulation method and varying the thresholds on the considered accumulation
  values.
* an optional argument, chr, needed if the input was found with chr = “all”;
  a string or a vector containing strings with the name of the chromosome
  (e.g., “chr1”)

The outputs of the function are:

* a list with a summary containing the standard deviation on each principal
  component, the proportion of variance explained by each principal component, the
  cumulative proportion of variance described by each principal component, and the
  loadings of each principal component;
* a plot with the variances of the principal components;
* a plot with the cumulate variances of the principal components;
* a plot with the loadings of the three principal components.

Note that the function *n\_zones\_PCA* works only if the number of different
threshold
values used to find the dense zones with the *dense\_zones* function is the same
for all the three accumulation types, while the threshold values can be
different.

```
# TF_dense_21_w_10 is the output of dense_zones function applied to the
# accumulation vector found with w=10, chr="chr21", acctype="TF".
# reg_dense_21_w_10 is the output of dense_zones function applied to the
# accumulation vector found with w=10, chr="chr21", acctype="reg".
# base_dense_21_w_10 is the output of dense_zones function (with
# threshold_step=21 in order to have 14 threshold values as in the other two
# inputs) applied to the accumulation vector found with w=10, chr="chr21",
# acctype="base".
# PCA
n_zones_PCA(TF_dense_w_10, reg_dense_w_10, base_dense_w_10, chr = "chr21")
```

```
## $summary
## Importance of components:
##                          PC1      PC2      PC3
## Standard deviation     1.732 0.006086 0.001916
## Proportion of Variance 1.000 0.000010 0.000000
## Cumulative Proportion  1.000 1.000000 1.000000
##
## $loadings
##                     PC1        PC2        PC3
## TF_zones     -0.5773531 -0.1901966  0.7940331
## region_zones -0.5773501 -0.5925539 -0.5617355
## base_zones   -0.5773476  0.7827549 -0.2323028
```

![*Plot of the variances of the principal components.*](data:image/png;base64...)

Figure 5: *Plot of the variances of the principal components.*

![*Plot of the cumulate variances of the principal components.*](data:image/png;base64...)

Figure 6: *Plot of the cumulate variances of the principal components.*

![*Plot of the loadings of the three principle components.*](data:image/png;base64...)

Figure 7: *Plot of the loadings of the three principle components.*

From this example we can see how the first principal component explains most of
the variation (Figure 5 and Figure 6), so it accounts for maximum information.
Furthermore, we can see how the values of loadings of the first principal
component are very similar (Figure 7). Therefore, we can say that the
information obtained with the three methods of accumulation is the same and for
our study regarding transcription factor dense DNA zones we can use only one
method of the three; we suggest using the *TF* or *region accumulation* because
the running time of the *accumulation* function with *acctype*=*base* is higher,
especially in chromosomes with an elevated number of input regions.

# 6 Transcription factor high accumulation DNA zones

In the previous part we found transcription factor dense DNA zones with
different thresholds of transcription factor accumulation, and we compared the
results using different input parameters in order to identify the best way to
find regions of the genome where there is a high presence of different
trascription factors. Now, with the function *high\_accumulation\_zones*, setting
only one threshold value, we can find these regions; we call them transcription
factor high accumulation DNA zones (TFHAZ). Starting from the accumulation
vector calculated with the *accumulation* function, two different methods
for the search of TF high accumulation DNA zones are available. The *binding
regions* method is based on the identification of DNA regions with presence of
TF binding (at least one TF) from which those with a high number of different
TFs (above the threshold) are selected. This method works only if the
accumulation vector is found with *w=0*. The *overlaps* method is the method
used also in *dense\_zones* function. It uses a single base local approach,
identifying DNA bases, that form the dense zones, in which there is high overlap
of TFs. For the *binding regions* method the high accumulation zones are the
accumulation regions with values higher or equal to the threshold, while in the
*overlaps* these zones are defined as sets of contiguous bases with accumulation
value higher or equal to the considered threshold. The threshold value is found
considering two methods. The *std* method considers all and only the bases of
the accumulation vector (*accvector*) with values higher than zero, and the
threshold is found with the following formula: *TH = mean(accvector) + 2 std(accvector)*.
The *top\_perc* method considers the accumulation regions and selects those in
the top *x* percentage, with *x* chosen by the user through the *perc* argument.
The function finds also the number of high accumulation zones, the number of
total bases belonging to these zones, the minimum, maximum, mean, median and standard
deviation of these zone lengths and of the distances between adjacent high
accumulation zones. In the case of *binding regions* method, it is needed to
include the *data* input argument, that is the GRanges object used in the
*accumulation* function.
Furhermore, in the case of single chromosome accumulation vector, the function
can plot, for
each chromosome base (x axis), the value of accumulation (y axis) calculated
with the *accumulation* function. On this graph there are also shown the
threshold (with a red line) and, on the x axis, the bases belonging to the high
accumulation zones (with red boxes). The plot can be saved in a “.png” file.
The function also can generate a “.bed” file with the chromosome and genomic
coordinates of the high accumulation zones found.

The function *high\_accumulation\_zones* takes in input:

* a list of four elements containing: a sparse vector with accumulation values
  (e.g., obtained with the function), the accumulation type, a
  chromosome name, and the half-width of the window used for the accumulation
  count;
* a string with the name of the method used to find high accumulation zones:
  “binding\_regions” or “overlaps”;
* a GRanges object containing coordinates of TF binding regions and their TF name.
  It is needed in the case of *binding regions* method;
* a string with the name of the method used to find the threshold value:
  “std” or “top\_perc”;
* an integer k (by defeault equals to 2) with the percentage (with the
  *top\_perc* method) or the number of std deviations (with the *std* method) to
  be used in order to find the threshold.
* a logical argument, writeBed. When set to TRUE, for each threshold value a
  “.bed” file with the chromosome and genomic coordinates of the dense zones found
  is created.
* a logical argument, plotZones. When set to TRUE, and the *accumulation* in
  input is calculated for a single chromosome, a “.png” file with the plot of the
  high accumulation zones on the accumulation vector is created.

The result of the *high\_accumulation\_zones* function is a list containing:

* zones: a GRanges object containing the coordinates of the high
  accumulation zones.
* n\_zones: an integer containing the number of high accumulation zones obtained;
* n\_bases: an integer containing the total number of bases belonging to the high
  accumulation zones obtained;
* lengths: a vector containing the considered threshold value and min, max,
  mean, median and standard deviation of the high accumulation zone lengths
  obtained;
* distances: a vector containing the considered threshold value and min, max,
  mean, median and standard deviation of the distances between adjacent high
  accumulation zones obtained;
* TH: a number with the threshold value found;
* acctype: a string with the accumulation type used;
* chr: a string with the chromosome name associated with the accumulation vector
  used;
* w: an integer with half-width of the window used to calculate the accumulation
  vector.

```
# find high accumulation DNA zones
TF_acc_21_w_0 <- accumulation(Ishikawa, "TF", "chr21", 0)
TFHAZ_21_w_0 <- high_accumulation_zones(TF_acc_21_w_0, method = "overlaps",
threshold = "std")
TFHAZ_21_w_0
```

```
## $zones
## GRanges object with 93 ranges and 1 metadata column:
##        seqnames            ranges strand |          revmap
##           <Rle>         <IRanges>  <Rle> |   <IntegerList>
##    [1]    chr21 16437167-16437660      * |       1,2,3,...
##    [2]    chr21 16976653-16977176      * |           6,7,8
##    [3]    chr21 17079029-17079434      * |         9,10,11
##    [4]    chr21 17094988-17095357      * |              12
##    [5]    chr21 17102094-17102125      * |              13
##    ...      ...               ...    ... .             ...
##   [89]    chr21 46847506-46848135      * | 301,302,303,...
##   [90]    chr21 46961496-46961941      * |     305,306,307
##   [91]    chr21 47705885-47706620      * | 308,309,310,...
##   [92]    chr21 47878395-47878750      * |             315
##   [93]    chr21 47878815-47878836      * |             316
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $n_zones
## [1] 93
##
## $n_bases
## [1] 45232
##
## $lengths
##                 TH            n_zones    length_zone_min    length_zone_max
##             8.0000            93.0000             9.0000          1077.0000
##   length_zone_mean length_zone_median     length_zone_sd
##           486.3656           459.0000           252.1179
##
## $distances
##               TH          n_zones    dist_zone_min    dist_zone_max
##              8.0             93.0              4.0        7787560.0
##   dist_zone_mean dist_zone_median     dist_zone_sd
##         341266.6         113364.0         904014.4
##
## $TH
## [1] 8
##
## $chr
## [1] "chr21"
##
## $w
## [1] 0
##
## $max_accumulation_index
## [1] 14
##
## $acctype
## [1] "TF"
```

From the results of this example we can see that for the *overlaps* method with
a threshold equal to 7.3 (obtained with the *std* method) we find 93 high
accumulation zones. We can see the distribution of these zones along the
chromosome (in this case the chromosome 21) in Figure 8, while in
Figure 9 it is shown a part (31 out of 93 zones) of the “.bed” file with the
coordinates of the zones.

![*Plot of the TF accumulation vector (for the chromosome 21, obtained for w=0) and of the high accumulation DNA zones (red boxes on the x axis) found; the threshold used to find these zones (7,268413) is shown with a red horizontal line.*](data:image/png;base64...)

Figure 8: *Plot of the TF accumulation vector (for the chromosome 21, obtained for w=0) and of the high accumulation DNA zones (red boxes on the x axis) found; the threshold used to find these zones (7,268413) is shown with a red horizontal line.*

![*Content of the 'bed' file with the coordinates of 31 out of the 93 high accumulation DNA zones found.*](data:image/png;base64...)

Figure 9: *Content of the ‘bed’ file with the coordinates of 31 out of the 93 high accumulation DNA zones found.*

# 7 Acknowledgement

We really appreciate the generous support and suggestions by Stefano Campaner
and Stefano Perna.

# References

1. Park PJ. ChIP–seq: Advantages and challenges of a maturing technology. *Nature Reviews Genetics*. 2009;10(10):669-680.

2. ENCODE Project Consortium. The ENCODE (ENCyclopedia Of DNA Elements) project. *Science*. 2004;306(5696):636-640.

3. Bernstein BE, Stamatoyannopoulos JA, Costello JF, Ren B, Milosavljevic A, Meissner A, Kellis M, Marra MA, Beaudet AL, Ecker JR, Farnham PJ, Hirst M, Lander ES, Mikkelsen TS, Thomson JA. The NIH Roadmap Epigenomics mapping consortium. *Nature Biotechnology*. 2010;28(10):1045-1048.

4. Masseroli M, Pinoli P, Venco F, Kaitoua A, Jalili V, Palluzzi F, Muller H, Ceri S. GenoMetric Query Language: A novel approach to large-scale genomic data management. *Bioinformatics*. 2015;31(12):1881-1888.

5. Ceri S, Kaitoua A, Masseroli M, Pinoli P, Venco F. Data management for heterogeneous genomic datasets. *IEEE/ACM Transactions on Computational Biology and Bioinformatics*.

6. Masseroli M, Kaitoua A, Pinoli P, Ceri S. Modeling and interoperability of heterogeneous genomic big data for integrative processing and querying. *Methods*. 2016;111:3-11.

7. Johnson RA, Wichern DW. *Applied Multivariate Statistical Analysis*. Vol 4. Prentice-Hall New Jersey; 2014.

8. Bro R, Smilde AK. Principal Component Analysis. *Analytical Methods*. 2014;6(9):2812-2831.