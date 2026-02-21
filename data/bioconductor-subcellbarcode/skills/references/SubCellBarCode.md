# Contents

* [1 Installation of the package](#installation-of-the-package)
* [2 Load the package](#load-the-package)
* [3 Data preparation and classification](#data-preparation-and-classification)
  + [3.1 Example Data](#example-data)
  + [3.2 Marker Proteins](#marker-proteins)
  + [3.3 Load and normalize data](#load-and-normalize-data)
  + [3.4 Calculate covered marker proteins](#calculate-covered-marker-proteins)
  + [3.5 Quality control of the marker proteins](#quality-control-of-the-marker-proteins)
  + [3.6 Visualization of marker proteins in t-SNE map](#visualization-of-marker-proteins-in-t-sne-map)
  + [3.7 Build model and classify proteins](#build-model-and-classify-proteins)
    - [3.7.1 Estimate classification thresholds for compartment level](#estimate-classification-thresholds-for-compartment-level)
    - [3.7.2 Apply threshold to compartment level classifications](#apply-threshold-to-compartment-level-classifications)
    - [3.7.3 Estimate classification thresholds for neighborhood level](#estimate-classification-thresholds-for-neighborhood-level)
    - [3.7.4 Apply threshold to neighborhood level classifications](#apply-threshold-to-neighborhood-level-classifications)
    - [3.7.5 Merge compartment and neighborhood classification](#merge-compartment-and-neighborhood-classification)
* [4 Visualization of the protein subcellular localization](#visualization-of-the-protein-subcellular-localization)
  + [4.1 SubCellBarCode plot](#subcellbarcode-plot)
  + [4.2 Co-localization plot](#co-localization-plot)
* [5 Differential localization analysis](#differential-localization-analysis)
  + [5.1 Plot differentially localizing proteins](#plot-differentially-localizing-proteins)
  + [5.2 Filter Candidates](#filter-candidates)
* [6 Peptide/Exon/Transcript centric or PTM regulated localization](#peptideexontranscript-centric-or-ptm-regulated-localization)
  + [6.1 Exon-centric classification](#exon-centric-classification)
  + [6.2 Comparison between gene and exon centric classification](#comparison-between-gene-and-exon-centric-classification)
* [7 References](#references)
* **Appendix**
* [A Session Information](#session-information)

# 1 Installation of the package

`SubCellBarCode` can be installed through `BiocManager` package as follows:

```
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("SubCellBarCode")
```

# 2 Load the package

```
library(SubCellBarCode)
```

```
## Warning: replacing previous import 'e1071::element' by 'ggplot2::element' when
## loading 'SubCellBarCode'
```

```
##
```

# 3 Data preparation and classification

## 3.1 Example Data

As example data we here provide the publicly available HCC827 (human lung
adenocarcinoma cell line) TMT10plex labelled proteomics dataset
(*Orre et al.* 2019, Molecular Cell). The `data.frame` consists of
10480 proteins as rows (rownames are gene -centric protein ids)
and 5 fractions with duplicates as columns
(replicates must be named “.A.” and “.B.”, repectively).

```
head(hcc827Ctrl)
```

```
##        FS1.A.HCC827 FS1.B.HCC827 FS2.A.HCC827 FS2.B.HCC827 FP1.A.HCC827
## A2M          6.6567       4.8238       0.8265       0.8279       0.4475
## A2ML1        1.2876       1.0878       0.6390       0.7828       0.8760
## A4GALT       0.4711       0.4106       0.2742       0.2689       0.8389
## AAAS         0.5108       0.4514       0.4470       0.4752       1.6576
## AACS         4.5593       4.4522       1.5694       1.6417       0.5294
## AAED1        0.8170       0.7031       0.5415       0.5902       0.9429
##        FP1.B.HCC827 FP2.A.HCC827 FP2.B.HCC827 FP3.A.HCC827 FP3.B.HCC827
## A2M          0.5803       0.6414       0.6014       0.6497       0.6216
## A2ML1        0.9138       2.6957       1.3606       0.7715       0.7859
## A4GALT       0.8043       1.9637       1.8340       1.6739       1.6848
## AAAS         1.7316       1.3773       1.4688       1.0071       1.0457
## AACS         0.5197       0.5109       0.5232       0.4197       0.4243
## AAED1        0.9505       1.9035       1.8475       1.1060       1.1636
```

## 3.2 Marker Proteins

The classification of protein localisation using the SubCellBarCode
method is dependent on 3365 marker proteins as defined in Orre et al.
The markerProteins `data.frame` contain protein names (gene symbol),
associated subcellular localization (compartment), color code for
the compartment and the median normalized fractionation
profile (log2) based on five different human cell lines
(NCI-H322, HCC827, MCF7, A431and U251) here called the
“5CL marker profile”.

```
head(markerProteins)
```

```
##          Proteins Compartments       Cyto        Nsol       NucI        Horg
## AAAS         AAAS           S4 -1.0033518 -1.15489468  0.9303367  0.48554266
## AACS         AACS           C4  2.1716569  0.13246046 -1.0394634 -1.13265585
## AAK1         AAK1           C3  1.8556445  0.10015281 -0.6605511 -0.36985132
## AARS         AARS           C4  2.1012831  0.05855811 -1.0439250 -1.08451971
## AASDHPPT AASDHPPT           C5  1.7065897  0.51507061 -0.7196594 -0.65267201
## AATF         AATF           N3 -0.8922053 -1.10101864  1.2202070  0.05316807
##                Lorg       Colour
## AAAS      0.1618329      tomato2
## AACS     -1.3217619 deepskyblue2
## AAK1     -0.6741959         cyan
## AARS     -1.2180979 deepskyblue2
## AASDHPPT -1.0059841   turquoise3
## AATF      0.1898676       grey50
```

## 3.3 Load and normalize data

Input `data.frame` is checked with *“NA”* values and for the correct
format. If there is any *“NA”* value, corresponding row is deleted.
Then, data frame is `log2` transformmed.

```
df <- loadData(protein.data = hcc827Ctrl)
```

```
cat(dim(df))
```

```
## 10480 10
```

```
head(df)
```

```
##        FS1.A.HCC827 FS1.B.HCC827 FS2.A.HCC827 FS2.B.HCC827 FP1.A.HCC827
## A2M       2.7348072    2.2701701   -0.2749133   -0.2724716  -1.16004041
## A2ML1     0.3646845    0.1214133   -0.6461122   -0.3532843  -0.19099723
## A4GALT   -1.0858948   -1.2841945   -1.8666995   -1.8948583  -0.25342925
## AAAS     -0.9691696   -1.1475217   -1.1616533   -1.0733933   0.72909591
## AACS      2.1888123    2.1545184    0.6502131    0.7151905  -0.91756990
## AAED1    -0.2915920   -0.5081982   -0.8849668   -0.7607242  -0.08482332
##        FP1.B.HCC827 FP2.A.HCC827 FP2.B.HCC827 FP3.A.HCC827 FP3.B.HCC827
## A2M     -0.78512917   -0.6407037   -0.7336032  -0.62215439  -0.68594159
## A2ML1   -0.13004965    1.4306600    0.4442430  -0.37426194  -0.34758234
## A4GALT  -0.31419437    0.9735745    0.8749936   0.74321334   0.75257734
## AAAS     0.79210571    0.4618428    0.5546380   0.01020694   0.06446902
## AACS    -0.94424904   -0.9688872   -0.9345656  -1.25256963  -1.23684342
## AAED1   -0.07324147    0.9286546    0.8855744   0.14535139   0.21859520
```

**Additional step:**
We use gene symbols for the protein identification. Therefore, we require
gene symbols for the identifiaction. However, if the input data has
other identifier e.g. UNIPROT, IPI, Entrez ID, you can convert it to gene
symbol by our defined function.
*Please be aware of possible (most likely few) id loss during the
conversion to one another.*

```
##Run if you have another identifier than gene symbols.
##Function will convert UNIPROT identifier to gene symbols.
##Deafult id is "UNIPROT", make sure you change it if you use another.

#df <- convert2symbol(df = df, id = "UNIPROT")
```

For the downstream analysis, we used the randomly selected subset data.

```
set.seed(2)
df <- df[sample(nrow(df), 6000),]
```

## 3.4 Calculate covered marker proteins

The overlap between *marker proteins (3365)* and
*input data.frame* is calculated and visualized for each
compartment by a bar plot.

*Note that we recommend at least 20% coverage of marker proteins
for each compartment. If certain compartments are underrrepresented
we recommend you to perform the cell fractionation again.
If all compartments are low in coverage we recommend increasing
the analytical depth of the MS-analysis.*

```
c.prots <- calculateCoveredProtein(proteinIDs = rownames(df),
                        markerproteins = markerProteins[,1])
```

![](data:image/png;base64...)

```
## Overall Coverage of marker proteins :  0.58
```

## 3.5 Quality control of the marker proteins

To avoid reduced classification accuracy, marker proteins with
noisy quantification and marker proteins that are not representative
of their associated compartment (e.g.due to cell type specific
localization) are filtered out by a two-step quality control.

1. Marker proteins with pearson correlations
   less than 0.8 between *A* and *B* duplicates for each cell line were
   filtered out (Figure A).
2. Pairwise correlations between 5CL marker profile and input data for
   each protein (A and B replicate experiments separately) were calculated
   using both Pearson and Spearman correlation. The lowest value for each
   method were then used for filtering with cut-offs set to 0.8 and 0.6
   respectively, to exclude non-representative marker proteins (Figure B).

```
r.markers <- markerQualityControl(coveredProteins = c.prots,protein.data = df)
```

```
## Number of removed replicate-wise proteins: 0
```

```
## Number of removed sample-wise proteins: 1
```

```
## Number of total removed marker proteins: 1
```

![](data:image/png;base64...)

```
r.markers[1:5]
```

```
## [1] "N4BP2L2" "FURIN"   "ATG9A"   "ZNF205"  "MAVS"
```

**Optional step:** After removing non-marker proteins, you can re-calculate
and visualize the final coverage of the marker proteins.

```
## uncomment the function when running
# f.prots <- calculateCoveredProtein(r.markers, markerProteins[,1])
```

## 3.6 Visualization of marker proteins in t-SNE map

The spatial distribution of the marker proteins is visualized in
t-SNE map. This plot will be informative for the quality control
of the generated data as it offers evaluation of the spatial
distribution and separation of marker proteins.

```
#Default parameters
#Run the broad-range parameters to optimize well !!!
#Output dimensionality
#dims = 3
#Speed/accuracy trade-off (increase for less accuracy)
#theta = c(0.1, 0.2, 0.3, 0.4, 0.5)
#Perplexity parameter
#perplexity = c(5, 10, 20, 30, 40, 50, 60)
```

Information about the different t-SNE parameters that can be
modified by the user is available by typing `?Rtsne` in the console.
Although the applications of t-SNE is widespread in the field
of machine learning, it can be misleading if it is not well
optimized. Therefore, we optimize t-SNE map by grid search,
a process that can take some time

```
set.seed(6)
tsne.map <- tsneVisualization(protein.data = df,
                    markerProteins = r.markers,
                    dims = 3,
                    theta = c(0.1),
                    perplexity = c(60))
```

```
## Optimization process started. This may take some time!
```

```
## Optimization was performed.
```

```
## Theta value:  0.1
## Perplexity value:  60
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

We recommend 3D vizualisation by setting `dims = 3`,
for optimal evaluation of marker protein cluster separation
and data modularity. You can also visualize the marker
proteins in 2 dimensional space by setting `dims = 2`, although
reducing the dimensionality results in loss of information and
underestimation of data resolution.

```
set.seed(9)
tsne.map2 <- tsneVisualization(protein.data = df,
                    markerProteins = r.markers,
                    dims = 2,
                    theta = c(0.5),
                    perplexity = c(60))
```

```
## Optimization process started. This may take some time!
```

```
## Optimization was performed.
```

```
## Theta value:  0.5
## Perplexity value:  60
```

![](data:image/png;base64...)

## 3.7 Build model and classify proteins

For replicate *A* and *B* separately, marker proteins are
used for training a Support Vector Machine (SVM) classifier
with a Gaussian radial basis function kernel algorithm.
After tuning the parameters, the SVM model predicts (classifies)
the subcellular localization for all proteins in the input
data with corresponding probabilities for *A* and *B* replicate
classification.

```
set.seed(4)
cls <- svmClassification(markerProteins = r.markers,
                                    protein.data = df,
                                    markerprot.df = markerProteins)
```

```
# testing data predictions for replicate A and B
test.A <- cls[[1]]$svm.test.prob.out
test.B <- cls[[2]]$svm.test.prob.out
head(test.A)
```

```
##         Observation svm.pred           S1          S2          S3          S4
## N4BP2L2          N2       N2 0.0034204982 0.002713603 0.003135572 0.002424749
## ZNF205           N1       N1 0.0539341925 0.005611837 0.009373929 0.003251983
## MAVS             M2       M2 0.0005904669 0.001188552 0.001075943 0.001988799
## NGLY1            C2       C2 0.0020717253 0.001835965 0.001706640 0.001777443
## RAB15            S2       S2 0.1005330801 0.850062711 0.017526771 0.022986723
## CHD4             N2       N2 0.0093310932 0.009050335 0.009640417 0.007007189
##                   N1           N2          N3           N4           C1
## N4BP2L2 0.0370000247 0.8956709656 0.026904787 0.0127955674 0.0026575959
## ZNF205  0.9047763896 0.0040535626 0.005468579 0.0024351136 0.0022360891
## MAVS    0.0009300487 0.0010955494 0.001556564 0.0010128144 0.0008742056
## NGLY1   0.0021911577 0.0017599204 0.001974421 0.0090865761 0.0608829293
## RAB15   0.0006195267 0.0006601397 0.000699539 0.0009793257 0.0009498403
## CHD4    0.0147735324 0.5904820545 0.016469668 0.3054409175 0.0060342981
##                   C2           C3           C4           C5           M1
## N4BP2L2 0.0020172675 0.0019633826 0.0022083395 0.0027406564 0.0026281681
## ZNF205  0.0014451171 0.0011720556 0.0013531775 0.0016422573 0.0016849212
## MAVS    0.0008075442 0.0006829592 0.0008801080 0.0010014552 0.0341655989
## NGLY1   0.8509162130 0.0393558124 0.0031946915 0.0198804447 0.0016605889
## RAB15   0.0008681537 0.0007352767 0.0007446856 0.0008892102 0.0009869426
## CHD4    0.0044846791 0.0035101058 0.0037620803 0.0055981694 0.0090452900
##                   M2
## N4BP2L2 0.0017188220
## ZNF205  0.0015607954
## MAVS    0.9521493909
## NGLY1   0.0017054720
## RAB15   0.0007580757
## CHD4    0.0053701723
```

```
# all predictions for replicate A and B
all.A <- cls[[1]]$all.prot.pred
all.B <- cls[[2]]$all.prot.pred
```

### 3.7.1 Estimate classification thresholds for compartment level

Classification probabilities close to 1 indicate high confidence
predictions, whereas probabilities close to 0 indicate low
confidence predictions. To increase the overal prediction accuracy
and to filter out poor predictions, one criterion and
two cut-offs are defined.

1. The criterion is the consensus of preliminary predictions
   between biological duplicates. Proteins are kept in the analysis,
   if there is an agreement between biological duplicates.
   Subsequently, prediction probabilities from the two
   duplicates are averaged for each protein.
2. Cut-off is (precision - based) set when precision reach 0.9
   in the test data.
3. Cut-off is (recall - based) set as the probability of the
   lowest true positive in the test data.

```
t.c.df <- computeThresholdCompartment(test.repA = test.A, test.repB = test.B)
```

```
head(t.c.df)
```

```
##   Compartment PrecisionBasedThreshold RecallBasedThreshold OptedThreshold
## 1          S1                    0.47                0.495          0.495
## 2          S2                   0.785                 0.51          0.785
## 3          S3                   0.535                0.375          0.535
## 4          S4                    0.68                0.445          0.680
## 5          N1                       0                 0.72          0.720
## 6          N2                       0                 0.53          0.530
```

### 3.7.2 Apply threshold to compartment level classifications

The determined thresholds for the compartment levels are applied
to all classifications.

```
c.cls.df <- applyThresholdCompartment(all.repA = all.A, all.repB = all.B,
                                    threshold.df = t.c.df)
```

```
head(c.cls.df)
```

```
##         Proteins svm.pred        S1          S2         S3           S4
## FURIN      FURIN       S1 0.8044625 0.118285221 0.06148853 0.0039862411
## ATG9A      ATG9A       S1 0.8482675 0.013538605 0.01131488 0.0042270023
## DISC1      DISC1       S1 0.6003724 0.034584719 0.13175231 0.0231587190
## HVCN1      HVCN1       S1 0.9382960 0.005664071 0.01047046 0.0019191809
## VTI1A      VTI1A       S1 0.9802552 0.002545447 0.01070461 0.0004074506
## SLC35F2  SLC35F2       S1 0.7683913 0.019822117 0.16210238 0.0081724862
##                  N1           N2           N3           N4           C1
## FURIN   0.001063479 0.0011090607 0.0008779197 0.0010555088 0.0009208802
## ATG9A   0.085590105 0.0032762068 0.0045218381 0.0053467703 0.0066286150
## DISC1   0.045068474 0.0075255478 0.0069405674 0.0109770978 0.0939001191
## HVCN1   0.032281961 0.0013498275 0.0013276950 0.0014380712 0.0015681802
## VTI1A   0.001194382 0.0005728802 0.0005238379 0.0005018539 0.0005017726
## SLC35F2 0.017392373 0.0046300609 0.0025411416 0.0030319662 0.0041498757
##                   C2           C3           C4           C5           M1
## FURIN   0.0008966154 0.0007727800 0.0007533706 0.0009464182 0.0019590025
## ATG9A   0.0034716395 0.0024226870 0.0020141834 0.0035120378 0.0027487307
## DISC1   0.0175978565 0.0071947713 0.0035340674 0.0065186738 0.0044177332
## HVCN1   0.0010475977 0.0008637610 0.0008279222 0.0010973763 0.0008732059
## VTI1A   0.0005178166 0.0004366861 0.0004628942 0.0005308447 0.0004443072
## SLC35F2 0.0019535196 0.0013716268 0.0012046753 0.0017430045 0.0016115742
##                   M2
## FURIN   0.0014224819
## ATG9A   0.0031192271
## DISC1   0.0064569012
## HVCN1   0.0009747184
## VTI1A   0.0004000427
## SLC35F2 0.0018819501
```

### 3.7.3 Estimate classification thresholds for neighborhood level

Compartment level classification probabilities are summed to
neighborhood probabilities and thresholds for neighborhood
analysis are estimated as described above for compartment
level analysis except precision based cut-off is set to 0.95.

```
t.n.df <- computeThresholdNeighborhood(test.repA = test.A, test.repB = test.B)
```

```
head(t.n.df)
```

```
##   Neighborhood PrecisionBasedThreshold RecallBasedThreshold OptedThreshold
## 1    Secretory                       0                 0.65          0.650
## 2      Nuclear                       0                 0.47          0.470
## 3      Cytosol                       0                 0.58          0.580
## 4 Mitochondria                       0                0.655          0.655
```

### 3.7.4 Apply threshold to neighborhood level classifications

The determined thresholds for the neighborhood levels are applied to all
classifications.

```
n.cls.df <- applyThresholdNeighborhood(all.repA = all.A, all.repB = all.B,
                                    threshold.df = t.n.df)
```

```
head(n.cls.df)
```

```
##       Proteins svm.pred.all Secretory     Nuclear     Cytosol Mitochondria
## FURIN    FURIN    Secretory 0.9882225 0.004105968 0.004290065  0.003381484
## ATG9A    ATG9A    Secretory 0.8773480 0.098734920 0.018049163  0.005867958
## DISC1    DISC1    Secretory 0.7898682 0.070511687 0.128745488  0.010874634
## HVCN1    HVCN1    Secretory 0.9563497 0.036397555 0.005404837  0.001847924
## VTI1A    VTI1A    Secretory 0.9939127 0.002792954 0.002450014  0.000844350
## CEP68    CEP68    Secretory 0.9815079 0.006802636 0.007935830  0.003753659
```

### 3.7.5 Merge compartment and neighborhood classification

Individual classifications (compartment and neighborhood) are merged
into one data frame.

```
cls.df <- mergeCls(compartmentCls = c.cls.df, neighborhoodCls = n.cls.df)
```

```
head(cls.df)
```

```
##        Protein NeighborhoodCls CompartmentCls   Secretory     Nuclear
## A2M        A2M         Cytosol   Unclassified 0.108974693 0.148019019
## A2ML1    A2ML1    Unclassified   Unclassified 0.289312766 0.106674311
## A4GALT  A4GALT       Secretory             S1 0.984063133 0.006326616
## AACS      AACS         Cytosol   Unclassified 0.007062643 0.009852283
## AAGAB    AAGAB         Cytosol   Unclassified 0.006046029 0.006551317
## AAK1      AAK1         Cytosol   Unclassified 0.005356143 0.006359080
##            Cytosol Mitochondria          S1          S2          S3          S4
## A2M    0.707476254  0.035530034 0.039866660 0.035645043 0.019382476 0.014080514
## A2ML1  0.313939713  0.290073210 0.068059420 0.052162470 0.104065175 0.065025702
## A4GALT 0.007018236  0.002592015 0.967094493 0.013246951 0.002326302 0.001395387
## AACS   0.979996757  0.003088316 0.002163661 0.001971189 0.001603501 0.001324293
## AAGAB  0.984621943  0.002780711 0.001702959 0.001659116 0.001446875 0.001237080
## AAK1   0.985783207  0.002501570 0.001509276 0.001434766 0.001288690 0.001123411
##                 N1          N2          N3          N4          C1          C2
## A2M    0.043316074 0.018332245 0.024952969 0.061417730 0.173374778 0.043123461
## A2ML1  0.028041362 0.013005800 0.017333591 0.048293558 0.107401033 0.127785177
## A4GALT 0.001279695 0.001378964 0.001444322 0.002223634 0.001873890 0.001430963
## AACS   0.002292800 0.001597228 0.001781031 0.004181224 0.004083417 0.002940375
## AAGAB  0.001966653 0.001460906 0.001589922 0.001533835 0.490438977 0.018607661
## AAK1   0.001677854 0.001288555 0.001389773 0.002002898 0.367893604 0.018527206
##                 C3          C4          C5          M1          M2
## A2M    0.120829788 0.209961620 0.160186606 0.013156336 0.022373699
## A2ML1  0.045365976 0.011057367 0.022330159 0.025059542 0.265013668
## A4GALT 0.001156778 0.001033019 0.001523587 0.001447960 0.001144055
## AACS   0.016174572 0.580101553 0.376696841 0.001440217 0.001648100
## AAGAB  0.444608775 0.009851353 0.021115177 0.001371630 0.001409080
## AAK1   0.557600944 0.011618468 0.030142985 0.001246429 0.001255142
```

# 4 Visualization of the protein subcellular localization

## 4.1 SubCellBarCode plot

You can query one protein at a time to plot barcode of the protein
of the interest.

`PSM` (Peptide-spectra-matching) count table is required for the plotting
SubCellBarCode. It is in `data.frame` format;

```
head(hcc827CtrlPSMCount)
```

```
##        Protein PSMs.for.quant
## A2M        A2M             11
## A2ML1    A2ML1              2
## A4GALT  A4GALT              1
## AAAS      AAAS             33
## AACS      AACS             60
## AAED1    AAED1              9
```

```
plotBarcode(sampleClassification = cls.df, protein = "NLRP4",
        s1PSM = hcc827CtrlPSMCount)
```

![](data:image/png;base64...)

## 4.2 Co-localization plot

To evaluate localization and of multiple proteins at
the same time, a vector of proteins (identified by gene symbols)
can be prepared and used to create a barplot showing the
distribution of classifications across compartments and
neighborhoods. This analysis could be helpful when
evaluating co-localization of proteins, protein complex
formation and compartmentalized protein level regulation.

```
# 26S proteasome complex (26s proteasome regulatory complex)
proteasome26s <- c("PSMA7", "PSMC3","PSMA4", "PSMB4",
                    "PSMB6", "PSMB5", "PSMC2","PSMC4",
                    "PSMB3", "PSMA6","PSMC5","PSMC6")

plotMultipleProtein(sampleClassification = cls.df, proteinList = proteasome26s)
```

```
## PSMB4,PSMC6 not exist in data
```

![](data:image/png;base64...)

# 5 Differential localization analysis

Regulation of protein localization is a the key
process in cellular signalling. The `SubCellBarCode`
method can be used for differential localization analysis
given two conditions such as control vs treatment, cancer
cell *vs* normal cell, cell state A *vs* cell state B, *etc*.
As example, we compared untreated and gefitinib (EGFR inhibitor)
treated HCC827 cells (for details, see Orre et al.).

## 5.1 Plot differentially localizing proteins

Neighborhood classifications for condition 1 (untreated) and
condition 2 (gefitinib) is first done separately, and
classifications for overlapping proteins are then vizualized by a
sankey plot.
*The HCC827 gefitinib cell lines classification was embedded
into the package for example analysis.*

```
head(hcc827GEFClass)
```

```
##        Protein NeighborhoodCls CompartmentCls
## A2M        A2M         Cytosol   Unclassified
## A2ML1    A2ML1    Unclassified   Unclassified
## A4GALT  A4GALT       Secretory             S1
## AAAS      AAAS       Secretory             S4
## AACS      AACS         Cytosol   Unclassified
## AAED1    AAED1       Secretory   Unclassified
```

```
sankeyPlot(sampleCls1 = cls.df, sampleCls2 = hcc827GEFClass)
```

```
##           Cond1        Cond2 value
## 1     Secretory    Secretory  1323
## 2     Secretory      Nuclear    19
## 3     Secretory      Cytosol    14
## 4     Secretory Mitochondria     9
## 5       Nuclear    Secretory    15
## 6       Nuclear      Nuclear  1263
## 7       Nuclear      Cytosol    23
## 8       Nuclear Mitochondria     0
## 9       Cytosol    Secretory    39
## 10      Cytosol      Nuclear    36
## 11      Cytosol      Cytosol  2019
## 12      Cytosol Mitochondria     1
## 13 Mitochondria    Secretory     5
## 14 Mitochondria      Nuclear     1
## 15 Mitochondria      Cytosol     1
## 16 Mitochondria Mitochondria   334
```

## 5.2 Filter Candidates

As the differential localization analysis is an outlier analysis,
it will include analytical noise. To filter out such noise,
`PSM` (Peptide-spectra-matching) counts and fractionation profile
correlation analysis (Pearson) was done to identify strong
candidates. The PSM count format for the input have to be the
same between the compared conditions;

```
head(hcc827CtrlPSMCount)
```

```
##        Protein PSMs.for.quant
## A2M        A2M             11
## A2ML1    A2ML1              2
## A4GALT  A4GALT              1
## AAAS      AAAS             33
## AACS      AACS             60
## AAED1    AAED1              9
```

For each protein, the minimum PSM count between the two conditions
is plotted against the fractionation profile (median) correlation
between the two conditions. For proteins with different localizations
between conditions, the fractionation profile differs and therefore
we are expecting a low fractionation profile correlation. As a standard
setting for filtering of analytical noise in the differential
localization analysis we suggest to demand a fractionation profile
correlation below 0.8, and a minimum PSM count of at least 3.
However, for the exploratory analysis, you can adjust
the `min.psm` and `pearson.cor` parameters.

```
##parameters
#sampleCls1 = sample 1 classification output
#s1PSM = sample 2 PSM count
#s1Quant = Sample 1 Quantification data
#sampleCls2 = sample 2 classification output
#s2PSM = sample 2 classification output
#sample2Quant = Sample 2 Quantification data
#min.psm = minumum psm count
#pearson.cor = perason correlation coefficient
```

```
candidate.df <- candidateRelocatedProteins(sampleCls1 = cls.df,
                                s1PSM = hcc827CtrlPSMCount,
                                s1Quant = hcc827Ctrl,
                                sampleCls2 = hcc827GEFClass,
                                s2PSM = hcc827GefPSMCount,
                                s2Quant = hcc827GEF,
                                min.psm = 2,
                                pearson.cor = 0.8)
```

```
## Warning: Use of `f.df$Min.PSMs` is discouraged.
## ℹ Use `Min.PSMs` instead.
```

![](data:image/png;base64...)

```
cat(dim(candidate.df))
```

```
## 35 5
```

```
head(candidate.df)
```

```
##        Protein       C.A       C.B Pearson.Corr Min.PSMs
## ACD        ACD   Cytosol   Nuclear    0.7274418        4
## AGAP2    AGAP2   Nuclear   Cytosol    0.4888424        3
## ANKEF1  ANKEF1   Cytosol Secretory    0.5230030        3
## BATF3    BATF3 Secretory   Cytosol   -0.6132878        5
## CGNL1    CGNL1   Cytosol   Nuclear    0.7850309       34
## CRY1      CRY1   Nuclear Secretory   -0.7397292        4
```

Candidate subset of differentially localizing proteins can
be annotated with names by setting `annotation = TRUE`, `min.psm`
and `pearson.cor`

```
candidate2.df <- candidateRelocatedProteins(sampleCls1 = cls.df,
                                s1PSM = hcc827CtrlPSMCount,
                                s1Quant = hcc827Ctrl,
                                sampleCls2 = hcc827GEFClass,
                                s2PSM = hcc827GefPSMCount,
                                s2Quant = hcc827GEF,
                                annotation = TRUE,
                                min.psm = 9,
                                pearson.cor = 0.05)
```

```
## Warning: Use of `annot.df$Min.PSMs` is discouraged.
## ℹ Use `Min.PSMs` instead.
```

```
## Warning: Use of `annot.df$Label` is discouraged.
## ℹ Use `Label` instead.
```

```
## Warning: Use of `annot.df$Min.PSMs` is discouraged.
## ℹ Use `Min.PSMs` instead.
```

```
## Warning: Use of `annot.df$Label` is discouraged.
## ℹ Use `Label` instead.
```

![](data:image/png;base64...)

# 6 Peptide/Exon/Transcript centric or PTM regulated localization

Our main analysis is based on gene-centric. However, based on the analytical
depth of the data, peptide/exon/transcript centric classifications can
be performed. Moreover, this approach is also applicable for
post translation modification (PTM) enriched data.
Fundamentally, we will use the same classifiers, compartment
and neighborhood levels thresholds and apply
them to peptide/exon/transcript data.

## 6.1 Exon-centric classification

Here, we have provided subset of the HCC827 exon-centric data.

```
head(hcc827exon)
```

```
##                 Gene_Symbol FS1.A.HCC827 FS1.B.HCC827 FS2.A.HCC827 FS2.B.HCC827
## ENSE00000331191       CDC45    3.0054124    3.1763997    1.5782291    1.6024560
## ENSE00000331854       COPB1    2.0449415    2.0610331    1.1743850    1.1716880
## ENSE00000331855       COPB1    1.8797670    1.5457263    1.0152127    1.0173337
## ENSE00000331859       COPB1    1.7921392    2.0895850    1.0261406    1.0273679
## ENSE00000331990       LPIN1    2.4724838    2.7718197    1.4581675    1.7319290
## ENSE00000332881       PTPRA    0.4461752    0.6117839    0.5241694    0.3844395
##                 FP1.A.HCC827 FP1.B.HCC827 FP2.A.HCC827 FP2.B.HCC827
## ENSE00000331191    0.9467013    0.9600072    0.5214538    0.6500854
## ENSE00000331854    0.6919514    0.7403220    1.0573085    1.0332836
## ENSE00000331855    0.8060150    0.8152469    1.2035301    1.1714791
## ENSE00000331859    0.7443903    0.8078896    1.2703089    1.1974385
## ENSE00000331990    0.6075537    0.7533756    0.8890101    0.9232132
## ENSE00000332881    1.3494955    1.2581107    1.7331063    1.6535322
##                 FP3.A.HCC827 FP3.B.HCC827 PeptideCount
## ENSE00000331191    0.6017849    0.6252090            1
## ENSE00000331854    1.1354910    1.1858233            5
## ENSE00000331855    1.2002348    1.1099946            1
## ENSE00000331859    1.1113409    1.0545062            1
## ENSE00000331990    0.7477472    0.8117479            1
## ENSE00000332881    1.0713874    1.2001535            3
```

For the classification, we will use the gene-centric model that we built in
section 3.7.

```
##recall the models
modelA <- cls[[1]]$model
modelB <- cls[[2]]$model
```

*`svmExternalData` function greps replicates A and B, repectively. So
the input data can include other features like, here, peptide counts.*

```
exon.cls <- svmExternalData(df = hcc827exon, modelA = modelA, modelB= modelB)
```

```
exon.A <- exon.cls[[1]]
exon.B <- exon.cls[[2]]
```

```
head(exon.A)
```

```
##                 Gene_Symbol svm.pred.all          S1          S2          S3
## ENSE00000331191       CDC45           C5 0.005209818 0.004428667 0.003555885
## ENSE00000331854       COPB1           C1 0.002094528 0.001549502 0.001638616
## ENSE00000331855       COPB1           C1 0.004767946 0.002673107 0.004305875
## ENSE00000331859       COPB1           C2 0.005863040 0.003269242 0.005165852
## ENSE00000331990       LPIN1           C1 0.001952427 0.001807642 0.001534898
## ENSE00000332881       PTPRA           S4 0.005234257 0.041896085 0.382199347
##                          S4          N1          N2          N3          N4
## ENSE00000331191 0.003242003 0.005011824 0.003435750 0.004037131 0.014660840
## ENSE00000331854 0.001500378 0.002987032 0.001428675 0.001654051 0.003863658
## ENSE00000331855 0.003354011 0.004539758 0.001967439 0.002153011 0.006044831
## ENSE00000331859 0.003993647 0.005077045 0.002213735 0.002507557 0.008619431
## ENSE00000331990 0.001507256 0.002226228 0.001618174 0.001889669 0.008721204
## ENSE00000332881 0.431742588 0.002736390 0.007376895 0.003353097 0.002177273
##                          C1         C2          C3          C4          C5
## ENSE00000331191 0.029431200 0.02739400 0.104285450 0.079949261 0.708536210
## ENSE00000331854 0.545978939 0.38805113 0.041528864 0.002229591 0.002992308
## ENSE00000331855 0.512303625 0.38701929 0.059858677 0.002931555 0.004412370
## ENSE00000331859 0.394845949 0.48590743 0.069114609 0.003397616 0.005398430
## ENSE00000331990 0.495706311 0.20133219 0.223907357 0.010549736 0.044135377
## ENSE00000332881 0.001670115 0.00159227 0.001496738 0.001614183 0.001821697
##                          M1          M2
## ENSE00000331191 0.002993919 0.003828040
## ENSE00000331854 0.001215528 0.001287200
## ENSE00000331855 0.001570441 0.002098061
## ENSE00000331859 0.001887038 0.002739378
## ENSE00000331990 0.001460832 0.001650700
## ENSE00000332881 0.071655946 0.043433117
```

Next steps are exactly same as what we did in section 3.7. We will
use same thresholdsthat we have estimated in 3.7.1 and 3.7.3.
Finally, we will merge two classifications same function used
in 3.7.5.

```
exon.comp.cls <- applyThresholdCompartment(all.repA = exon.A[,2:17],
                                    all.repB = exon.B[,2:17],
                                    threshold.df = t.c.df)

exon.neigh.cls <- applyThresholdNeighborhood(all.repA = exon.A[,2:17],
                                    all.repB = exon.B[,2:17],
                                    threshold.df = t.n.df)

exon.cls.df <- mergeCls(compartmentCls = exon.comp.cls,
                        neighborhoodCls = exon.neigh.cls)

#same order
exon.cls.df <- exon.cls.df[rownames(exon.A),]

# we will add gene symbols as well as peptide count
# (PSM count is also accepted) in case for comparing with
# gene-centric classifications

exon.cls.df$GeneSymbol <- exon.A$Gene_Symbol
exon.cls.df$PeptideCount <- hcc827exon$PeptideCount
```

```
head(exon.cls.df)
```

```
##                         Protein NeighborhoodCls CompartmentCls   Secretory
## ENSE00000331191 ENSE00000331191         Cytosol   Unclassified 0.014832469
## ENSE00000331854 ENSE00000331854         Cytosol   Unclassified 0.009278669
## ENSE00000331855 ENSE00000331855         Cytosol   Unclassified 0.020407456
## ENSE00000331859 ENSE00000331859         Cytosol   Unclassified 0.017173531
## ENSE00000331990 ENSE00000331990         Cytosol   Unclassified 0.012312932
## ENSE00000332881 ENSE00000332881       Secretory   Unclassified 0.916146239
##                    Nuclear     Cytosol Mitochondria          S1          S2
## ENSE00000331191 0.02279522 0.956085749  0.006286562 0.004519423 0.004117834
## ENSE00000331854 0.01318771 0.973521876  0.004011749 0.002772796 0.002635333
## ENSE00000331855 0.02129554 0.952790918  0.005506091 0.006079970 0.004366019
## ENSE00000331859 0.01947592 0.957615992  0.005734562 0.005211156 0.004031744
## ENSE00000331990 0.01937522 0.962862663  0.005449185 0.003536029 0.003621272
## ENSE00000332881 0.01224056 0.007886533  0.063726674 0.003485418 0.048403049
##                          S3          S4          N1          N2          N3
## ENSE00000331191 0.003371211 0.002824002 0.004648321 0.003236997 0.003644227
## ENSE00000331854 0.002135101 0.001735439 0.004252239 0.002268855 0.002583707
## ENSE00000331855 0.005846533 0.004114934 0.006833201 0.002990136 0.003239354
## ENSE00000331859 0.004496494 0.003434136 0.005684534 0.003019969 0.003403090
## ENSE00000331990 0.002855838 0.002299793 0.004253858 0.002914563 0.003272068
## ENSE00000332881 0.211302289 0.652955482 0.002453825 0.005093238 0.002598370
##                          N4          C1          C2          C3          C4
## ENSE00000331191 0.011265675 0.047842854 0.024531307 0.266857757 0.060419555
## ENSE00000331854 0.004082905 0.525834771 0.396835016 0.042711381 0.002802567
## ENSE00000331855 0.008232845 0.374392624 0.513289731 0.054718728 0.003373434
## ENSE00000331859 0.007368322 0.436126244 0.410295371 0.098762837 0.004447041
## ENSE00000331990 0.008934731 0.479872458 0.212323124 0.188181776 0.011141407
## ENSE00000332881 0.002095123 0.001659707 0.001598117 0.001446198 0.001439449
##                          C5          M1          M2 GeneSymbol PeptideCount
## ENSE00000331191 0.556434275 0.002860280 0.003426282      CDC45            1
## ENSE00000331854 0.005338141 0.002005498 0.002006251      COPB1            5
## ENSE00000331855 0.007016401 0.002588313 0.002917777      COPB1            1
## ENSE00000331859 0.007984499 0.002584865 0.003149697      COPB1            1
## ENSE00000331990 0.071343897 0.002559130 0.002890055      LPIN1            1
## ENSE00000332881 0.001743062 0.039156448 0.024570225      PTPRA            3
```

## 6.2 Comparison between gene and exon centric classification

The insteresting part of the exon classification is to detect deviated
classification between gene centric classification. However, we enrich
more noise than gene centric classification due to analtyical dept of the exon
centric data. Therefore, we, additioanlly, internally calculate correlation
between gene-centric data `hcc827Ctrl` and exon-centric data `hcc827exon`,
and report
number of peptides (PSM count works, too) that match to corresponding exon
as an indication of the confidence of the results.

```
comp.df <- compareCls(geneCls = cls.df, exonCls = exon.cls.df)
```

```
head(comp.df)
```

```
##           Exon_id GeneSymbol Gene_Neighborhood Exon_Neighborhood
## 1 ENSE00000400044      ABCF2           Nuclear           Nuclear
## 2 ENSE00000400045      ABCF2           Nuclear           Cytosol
## 3 ENSE00000400052      ABCF2           Nuclear           Cytosol
## 4 ENSE00000400054      ABCF2           Nuclear           Nuclear
## 5 ENSE00000653853      ACIN1           Nuclear           Nuclear
## 6 ENSE00000655866       ACO2      Mitochondria      Mitochondria
##   Gene_Compartment Exon_Compartment PeptideCount Pearson.Corr
## 1               N4               N4            2    0.9632687
## 2               N4               C2            6    0.8533751
## 3               N4               C2            1    0.2251107
## 4               N4               N4            2    0.9894984
## 5               N2               N2           21    0.9903756
## 6               M1               M1            2    0.9323598
```

You can easily vizualize/filter the results using correlations and number of peptides.

# 7 References

# Appendix

* Orre., et al. “SubCellBarCode: Proteome-wide Mapping of Protein
  Localization and Relocalization.” Molecular Cell (2019): 73(1):166-182.e7.

# A Session Information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] SubCellBarCode_1.26.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3            pROC_1.19.0.1        gridExtra_2.3
##   [4] rlang_1.1.6          magrittr_2.0.4       e1071_1.7-16
##   [7] compiler_4.5.1       RSQLite_2.4.3        png_0.1-8
##  [10] vctrs_0.6.5          reshape2_1.4.4       stringr_1.5.2
##  [13] pkgconfig_2.0.3      crayon_1.5.3         fastmap_1.2.0
##  [16] magick_2.9.0         XVector_0.50.0       labeling_0.4.3
##  [19] rmarkdown_2.30       prodlim_2025.04.28   tinytex_0.57
##  [22] purrr_1.1.0          bit_4.6.0            xfun_0.53
##  [25] cachem_1.1.0         jsonlite_2.0.0       recipes_1.3.1
##  [28] blob_1.2.4           data.tree_1.2.0      parallel_4.5.1
##  [31] R6_2.6.1             bslib_0.9.0          stringi_1.8.7
##  [34] RColorBrewer_1.1-3   parallelly_1.45.1    rpart_4.1.24
##  [37] lubridate_1.9.4      jquerylib_0.1.4      Rcpp_1.1.0
##  [40] Seqinfo_1.0.0        bookdown_0.45        iterators_1.0.14
##  [43] knitr_1.50           future.apply_1.20.0  IRanges_2.44.0
##  [46] igraph_2.2.1         Matrix_1.7-4         splines_4.5.1
##  [49] nnet_7.3-20          timechange_0.3.0     tidyselect_1.2.1
##  [52] dichromat_2.0-0.1    yaml_2.3.10          timeDate_4051.111
##  [55] codetools_0.2-20     listenv_0.9.1        lattice_0.22-7
##  [58] tibble_3.3.0         plyr_1.8.9           Biobase_2.70.0
##  [61] withr_3.0.2          KEGGREST_1.50.0      S7_0.2.0
##  [64] evaluate_1.0.5       Rtsne_0.17           future_1.67.0
##  [67] survival_3.8-3       proxy_0.4-27         Biostrings_2.78.0
##  [70] pillar_1.11.1        BiocManager_1.30.26  foreach_1.5.2
##  [73] stats4_4.5.1         generics_0.1.4       S4Vectors_0.48.0
##  [76] ggplot2_4.0.0        scales_1.4.0         globals_0.18.0
##  [79] class_7.3-23         glue_1.8.0           scatterplot3d_0.3-44
##  [82] tools_4.5.1          data.table_1.17.8    ModelMetrics_1.2.2.2
##  [85] gower_1.0.2          grid_4.5.1           ipred_0.9-15
##  [88] AnnotationDbi_1.72.0 networkD3_0.4.1      nlme_3.1-168
##  [91] cli_3.6.5            lava_1.8.1           dplyr_1.1.4
##  [94] gtable_0.3.6         sass_0.4.10          digest_0.6.37
##  [97] BiocGenerics_0.56.0  caret_7.0-1          ggrepel_0.9.6
## [100] org.Hs.eg.db_3.22.0  htmlwidgets_1.6.4    farver_2.1.2
## [103] memoise_2.0.1        htmltools_0.5.8.1    lifecycle_1.0.4
## [106] hardhat_1.4.2        httr_1.4.7           bit64_4.6.0-1
## [109] MASS_7.3-65
```