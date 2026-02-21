# MSstatsSampleSize : A package for optimal design of high-dimensional MS-based proteomics experiment

#### Ting Huang (thuang0703@gmail.com), Meena Choi (mnchoi67@gmail.com), Olga Vitek(o.vitek@northeastern.edu)

#### 2020-03-04

```
library(MSstatsSampleSize)
```

This vignette introduces all the functionalities and summarizes their options in MSstatsSampleSize. MSstatsSampleSize requires protein abundances quantified in mass spectrometry runs as a matrix (columns for biological replicates (samples) and rows for proteins) and annotation including biological replicates (samples) and their condition (such as a disease and time points). MSstatsSampleSize includes the following functionalities:

1. `estimateVar`: estimates the variance across biological replicates and MS run for each protein.
2. `simulateDataset`: simulates data with the given number(s) of biological replicates based on the variance estimation.
3. `designSampleSizeClassification` : fit the classification model (five classifier are provided) on each simulation and reports the mean predictive accuracy of the classifier and mean protein importance over multiple iterations of the simulation. The sample size per condition, which generates the largest predictive accuracy, is estimated, while varying the number of biological replicates to simulate. Also, the proteins, which can classify the conditions best, are reported. The reported sample size per condition can be used to design future experiments.

In addition, MSstatsTMT includes the following visualization plots for sample size estimation:

1. `meanSDplot`: draw the plot for the mean protein abundance vs standard deviation in each condition for the input preliminary dataset. It can exhibit the quality of input data.
2. `designSampleSizePCAplot`: make PCA plots for the simulated data with certain sample size.
3. `designSampleSizeHypothesisTestingPlot`: visualize sample size calculation in hypothesis testing, which estimates the minimal required number of replicates under different expected fold changes.
4. `designSampleSizeClassificationPlots`: visualize sample size calculation in classification, including predictive accuracy plot and protein importance plot for different sample sizes.

## 1. Estimate mean protein abundance and variance per condition

### 1.1 estimateVar()

The function fits intensity-based linear model on the prelimiary data (Input, here is `data`). This function outputs variance components and mean abundance for each protein.

#### Arguments

* `data` : Data matrix with protein abundance. Rows are proteins and columns are Biological replicates or samples.
* `annotation` : annotation Group information for samples in data. `BioReplicate` for sample ID and `Condition` for group information are required. `BioReplicate` information should be the same with the column of `data`.

#### Example

```
# # read in protein abundance sheet
# # The CSV sheet has 173 columns from control and cancer groups.
# # Each row is protein and each column (except the first column) is biological replicate.
# # The first column 'Protein' contains the protein names.

# OV_SRM_train <- read.csv(file = "OV_SRM_train.csv")
# # assign the column 'Protein' as row names
# rownames(OV_SRM_train) <- OV_SRM_train$Protein
# # remove the column 'Protein
# OV_SRM_train <- OV_SRM_train[, colnames(OV_SRM_train)!="Protein"]
head(OV_SRM_train)
#>      111_data2 112_data2 114_data2 115_data2 117_data2 118_data2 119_data2
#> AFM  18.125305  18.64349 17.786586  18.62598 18.097136 18.535312 18.840662
#> AHSG 19.128721  19.11689 19.286422  19.55758 19.344060 19.639931 19.959407
#> AIAG 14.622719  14.67904 14.573159  14.63815 14.721183 14.680685 14.689130
#> AOC3  9.632189  10.11125  9.206763  10.16800  9.684437  9.231637  9.119823
#> APOH 17.426479  17.43132 17.075589  17.56990 17.487654 17.387798 16.742562
#> ATRN 15.686383  15.87728 15.363577  15.94339 15.797377 15.895453 15.656975
#>      120_data2 121_data2 122_data2 124_data2 125_data2 126_data2 127_data2
#> AFM   18.03126  18.30078 18.174929  17.96232 17.689686 18.901496 18.575908
#> AHSG  19.15174  19.60217 19.874469  19.04089 19.501971 19.731607 19.584103
#> AIAG  14.68560  14.66908 14.698554  14.65223 14.665577 14.780582 14.619267
#> AOC3   9.81001   9.76118  9.601232  10.43671  8.985737  9.875627  9.334184
#> APOH  17.51288  17.79438 17.232558  17.65325 17.224110 17.785863 17.659559
#> ATRN  15.36520  15.95020 15.625773  15.68939 15.753342 16.270773 15.831303
#>      128_data2 129_data2 130_data2 131_data2 132_data2 133_data2 134_data2
#> AFM  17.947816 18.147868  18.51270  18.65929  18.47320  17.88667 18.507657
#> AHSG 18.841300 19.523012  18.84247  19.63918  19.42743  19.57734 19.659681
#> AIAG 14.644087 14.667445  14.63945  14.64111  14.56605  14.61757 14.618578
#> AOC3  9.223909  9.437629  10.33851  10.09512  10.42163   9.98921  9.644337
#> APOH 16.273186 17.621464  17.51718  17.70859  17.60183  17.39107 17.716885
#> ATRN 15.373676 15.687543  15.80440  16.15178  16.03244  15.22396 15.908807
#>      135_data2 136_data2 137_data2 138_data2 139_data2 141_data2 142_data2
#> AFM  18.056045 18.217216 18.190407  17.93129 18.190767  18.71189 18.697504
#> AHSG 18.684113 19.778128 19.072510  19.64681 19.144389  19.09215 19.173120
#> AIAG 14.788843 14.700861 14.690739  14.70032 14.557284  14.49786 14.527640
#> AOC3  9.883479  9.956687  9.923819  10.19981  9.584612  10.08803  9.856426
#> APOH 17.486721 17.634729 17.326886  17.87975 17.269722  17.51544 17.439385
#> ATRN 15.550850 15.945612 15.683677  15.46693 15.755415  15.83076 15.837718
#>      143_data2 144_data2 145_data2 148_data2 150_data2 152_data2 153_data2
#> AFM  18.333930  18.74509 18.883271  18.42733 18.238043  18.95043 17.924042
#> AHSG 19.205627  19.23469 19.437665  19.37992 18.847405  19.59803 19.252497
#> AIAG 14.726276  14.52811 14.667486  14.62488 14.649104  13.97571 14.585755
#> AOC3  9.671116  10.25606  9.428427  10.15433  9.718192  10.50247  9.860558
#> APOH 17.458798  18.01638 17.547977  17.69565 17.230260  18.20250 17.184654
#> ATRN 15.393106  15.89522 15.496752  15.65677 15.526452  16.08452 15.257093
#>      156_data2 158_data2 160_data2 161_data2 164_data2 165_data2 168_data2
#> AFM  18.483946 18.010669 18.385003 17.879145 17.903197 17.888331 17.004817
#> AHSG 19.276230 18.915663 18.973446 19.072742 19.088324 18.880597 19.117856
#> AIAG 14.569342 14.682799 14.622459 14.584713 14.688668 14.512316 14.559322
#> AOC3  9.492098  9.735485  9.662316  9.864964  9.193436  9.925697  8.993866
#> APOH 17.462395 17.565055 17.530551 17.132638 17.077047 17.430339 17.456123
#> ATRN 15.715309 15.578068 15.692108 15.352683 15.710086 15.541809 15.683521
#>      169_data2 170_data2 171_data2 173_data2 174_data2 175_data2 176_data2
#> AFM  18.632285 18.085689 18.051762  17.85643 17.836256 18.041862  18.40570
#> AHSG 19.400598 19.363621 18.747689  18.73413 19.685220 19.087447  19.39215
#> AIAG 14.739893 14.531010 14.744388  14.59457 14.683617 14.640865  14.65400
#> AOC3  9.947192  9.186059  9.831393  10.00113  9.766951  9.274928  10.28776
#> APOH 16.529038 17.424281 17.542339  16.10105 17.178624 16.936601  17.52544
#> ATRN 15.769345 15.898010 15.856918  15.43720 15.340032 15.533356  15.53440
#>      178_data2 179_data2 180_data2 182_data2 183_data2 184_data2 186_data2
#> AFM   18.75573  18.27063  18.52774 18.297518 17.582758 17.930931 17.904111
#> AHSG  19.29950  18.94489  19.08033 19.113432 18.691674 18.662868 18.530972
#> AIAG  14.65713  14.64914  14.72467 14.850340 14.827924 14.689922 14.669593
#> AOC3  10.02276  10.47037   9.59893  9.795267  9.370154  9.981769  9.794802
#> APOH  17.86451  17.48350  17.30439 17.544530 17.155819 17.169970 16.660848
#> ATRN  15.77620  15.58480  15.60318 15.697109 14.605720 15.260143 15.403576
#>      187_data2 188_data2 190_data2 192_data2 194_data2 195_data2 196_data2
#> AFM  18.396673 17.894678 17.707195 17.809669  18.34009 18.179624 18.596355
#> AHSG 19.080693 19.278260 18.558606 18.662771  19.21291 18.730319 18.834565
#> AIAG 14.620739 14.787837 14.720343 14.652637  14.68076 14.634261 14.678035
#> AOC3  9.702123  9.681856  9.736804  9.401154   9.33778  9.897792  9.822549
#> APOH 17.321073 17.005514 17.087448 17.047272  17.03732 17.227674 15.927422
#> ATRN 15.621545 14.806060 14.983297 15.092230  15.42662 15.727192 15.855226
#>      197_data2 198_data2 199_data2 205_data2 206_data2 207_data2 208_data2
#> AFM   18.00268  18.27635 18.331772 18.077828 17.452173  18.05501 18.235103
#> AHSG  18.25441  18.71128 18.792804 18.912961 18.840506  18.62855 18.553961
#> AIAG  14.63728  14.52884 14.778585 14.633616 14.814071  14.76750 14.690582
#> AOC3  10.00159  10.02890  9.634046  9.938078  9.831058  10.20700  9.498681
#> APOH  17.04321  17.17218 17.459782 16.547486 16.958609  16.02782 16.905076
#> ATRN  15.34257  15.24551 14.835897 15.954050 14.513800  15.21354 16.874498
#>      209_data2 210_data2 211_data2 212_data2 213_data2 214_data2 215_data2
#> AFM  18.132287 18.375079 17.770032 17.724905 17.657647  18.38242 17.921772
#> AHSG 18.949066 18.702423 18.877115 18.269341 19.118199  18.71252 19.296103
#> AIAG 14.909930 14.706238 14.684011 14.823715 14.893650  14.75854 14.343939
#> AOC3  9.579414  9.678326  9.495482  9.469346  8.824347  10.35025  9.412162
#> APOH 17.464916 17.128459 17.186659 17.072809 16.864841  16.59375 17.417278
#> ATRN 16.064397 16.378393 14.989205 15.140738 14.477049  15.09208 15.186785
#>      216_data2 218_data2 219_data2 221_data2 223_data2 225_data2 226_data2
#> AFM  18.632524  18.51812 18.917493 17.185341  19.13733  17.39628 17.668124
#> AHSG 19.355160  19.53827 19.493397 19.298672  19.89682  18.29875 19.171998
#> AIAG 14.913842  14.73214 14.965833 14.728767  14.68477  14.77646 14.697848
#> AOC3  9.406908  10.27621  9.351153  9.455133  10.01626  10.04424  8.795441
#> APOH 17.499664  17.51376 16.706372 17.315701  16.56589  16.23679 17.200088
#> ATRN 16.374801  15.95412 16.348563 15.242930  15.61262  14.92587 14.939998
#>      227_data2 228_data2 229_data2 230_data2 232_data2 233_data2 234_data2
#> AFM  18.219490  18.34502 18.276027 17.932387 17.929591 18.429553 18.436277
#> AHSG 19.010487  19.86036 18.969241 19.183166 19.269394 19.837211 19.301828
#> AIAG 14.702392  14.60841 14.678561 14.739957 14.701693 14.549578 14.723665
#> AOC3  9.592725  10.32214  9.734937  9.855735  9.760736  9.830378  9.021658
#> APOH 17.853825  16.86624 17.276985 17.590303 17.704829 17.666456 17.173970
#> ATRN 15.955115  16.02096 15.670380 15.186790 15.693796 15.597309 15.563141
#>      238_data2 239_data2 240_data2 241_data2 243_data2 245_data2 247_data2
#> AFM   18.96869 17.293384 17.875729 18.330708 18.483318  18.51463 17.869515
#> AHSG  19.63254 18.752183 18.986113 19.199029 19.283156  19.47072 18.885268
#> AIAG  14.66505 14.841246 14.864199 14.744263 14.824436  14.81997 14.755289
#> AOC3  10.06522  9.142904  8.526826  9.954245  9.788555  10.44169  9.398166
#> APOH  17.94275 17.553791 16.451953 17.468578 17.693520  17.39168 16.492304
#> ATRN  16.13144 15.405926 14.980693 15.970609 15.744037  15.58433 15.330940
#>      249_data2 250_data2 251_data2 252_data2 253_data2 256_data2 260_data2
#> AFM  18.379942  17.75743 18.061166 18.032662 18.031620 18.014187 18.334035
#> AHSG 19.140557  18.71993 18.881908 19.174453 19.121928 19.489746 18.722563
#> AIAG 14.675358  14.70208 14.726250 14.740409 14.687525 14.767787 14.637014
#> AOC3  9.526241   9.00285  9.482894  8.653987  9.523596  9.218346  8.802496
#> APOH 17.227454  17.24986 16.242826 17.319249 17.762734 17.863327 17.505322
#> ATRN 15.175162  14.95746 15.369109 14.607609 14.955496 15.418160 14.746083
#>      261_data2 262_data2 263_data2 264_data2 266_data2 268_data2 269_data2
#> AFM  17.340848 17.434467  18.26882  18.39991 18.228878 16.763601  18.31052
#> AHSG 18.410148 18.410194  18.97058  19.61394 18.955525 17.848421  19.72981
#> AIAG 14.665203 14.704354  14.61000  14.32172 14.573768 14.771025  14.64845
#> AOC3  9.191827  9.278675  10.24927  10.25673  9.106905  8.641794   9.13996
#> APOH 17.600706 17.315108  17.25575  18.16690 17.536522 16.615284  17.70658
#> ATRN 15.157038 14.906791  15.53208  16.16453 15.332228 14.757124  15.56021
#>      272_data2 273_data2 274_data2 276_data2 277_data2 278_data2 280_data2
#> AFM  18.097901  18.24783 17.930339 17.747268 18.180041  18.28853  18.43702
#> AHSG 18.979989  19.01244 18.668717 19.460339 19.246000  19.66590  19.50469
#> AIAG 14.658132  14.57915 14.525636 14.669980 14.633661  14.70032  14.76518
#> AOC3  9.709677  10.23607  8.901961  9.353579  9.874482  10.54489  10.01856
#> APOH 17.302029  16.60388 17.510074 17.271007 17.522941  17.75978  18.01372
#> ATRN 15.579564  15.98848 15.273826 14.715780 15.864879  15.94246  15.46217
#>      281_data2 283_data2 285_data2 287_data2 289_data2 291_data2 292_data2
#> AFM  18.442966  18.39470 17.469177 17.593275 17.319943  18.27916 18.040612
#> AHSG 19.468956  19.52308 18.395481 19.223018 18.488503  19.30705 18.852932
#> AIAG 14.600466  14.78339 14.735214 14.759663 14.690441  14.69510 14.608408
#> AOC3  9.636045   9.93667  9.407982  9.441949  9.188727   9.96577  9.208321
#> APOH 17.441397  17.62818 17.624138 16.631229 17.037041  17.31336 17.497227
#> ATRN 15.990297  15.21573 14.818069 15.639320 14.802373  15.67334 15.660417
#>      293_data2 294_data2 296_data2 297_data2 298_data2 299_data2 300_data2
#> AFM   17.53997 18.106933 17.863355 18.291169 17.886804 18.009294 17.820316
#> AHSG  18.85753 18.996350 18.907338 18.986280 18.944631 19.651977 19.306948
#> AIAG  14.69265 14.654902 14.740586 14.597331 14.774619 14.647562 14.667379
#> AOC3  10.01976  9.674252  8.782559  9.194235  9.032765  9.806832  9.451533
#> APOH  17.22411 17.386070 16.016076 17.244806 16.078584 16.409889 17.134223
#> ATRN  15.39936 15.765481 14.876109 15.528891 14.970902 14.890409 15.277566
#>      304_data2 305_data2 306_data2 307_data2 309_data2 310_data2 312_data2
#> AFM  17.780377 18.088523 17.543665 18.684386 17.421003 17.215059 17.514548
#> AHSG 18.621389 18.451854 18.124493 18.938180 18.037526 18.754185 19.572883
#> AIAG 14.680430 14.606103 14.683937 14.659891 14.857323 14.936426 14.667030
#> AOC3  9.912006  9.107903  8.757357  9.851319  8.624146  9.627355  9.314186
#> APOH 17.013894 17.343102 16.489484 17.055566 16.948763 15.753452 17.233069
#> ATRN 15.677189 15.235679 14.577096 15.037739 14.522558 14.543692 14.308494
#>      313_data2 314_data2 316_data2 317_data2 318_data2 319_data2 320_data2
#> AFM  17.155426 17.928557 17.577918 18.170263 18.162079  17.34586 17.400453
#> AHSG 18.436080 19.262887 17.863462 19.205413 18.730273  18.74122 18.958450
#> AIAG 14.759980 14.658502 14.773180 14.863401 14.722524  14.83162 14.755337
#> AOC3  8.630082  9.672823  8.892625  9.862696  8.795811   9.22160  9.706257
#> APOH 15.700634 17.793827 16.037153 17.414298 17.243269  16.32879 16.123737
#> ATRN 14.112309 15.067181 14.852712 13.845938 14.927448  15.32303 14.881399
#>      321_data2 322_data2 324_data2 325_data2 326_data2 327_data2  17_data1
#> AFM  18.591053 18.308186 18.137755 18.347084 18.252126 17.802494 18.319153
#> AHSG 19.205644 18.744856 18.167016 18.446565 18.901464 18.673620 19.449831
#> AIAG 14.915479 14.970198 14.778891 14.626631 14.828018 14.593578 14.550948
#> AOC3  9.806904  9.859974  9.540925  9.186197  9.941376  9.406369  9.504025
#> APOH 16.170522 16.321222 16.819747 17.227516 17.375660 17.298652 17.518350
#> ATRN 15.581586 15.941980 15.420064 15.432483 15.548218 15.525004 15.905615
#>       18_data1  19_data1  20_data1  22_data1  23_data1  24_data1  25_data1
#> AFM  18.530057 18.096524 17.863494 17.772719 17.906108 18.153054 16.878912
#> AHSG 19.644695 19.666677 19.060631 19.082822 19.179822 19.356952 19.239355
#> AIAG 14.478457 14.574919 14.708477 14.693666 14.688290 14.610936 14.656453
#> AOC3  9.212143  9.140614  8.650803  9.381733  9.690872  9.293172  9.225986
#> APOH 18.010057 12.511891 17.572180 17.591682 17.723092 18.158306 18.011159
#> ATRN 16.165473 15.186984 15.277472 15.088876 15.522584 15.026051 15.112880
#>       27_data1  29_data1 30_data1  31_data1  32_data1  34_data1  35_data1
#> AFM  18.044725 17.916760 18.46724 17.476939 18.259068 17.626156 17.076560
#> AHSG 19.328346 18.329613 18.99762 18.669560 19.470021 18.946247 17.613020
#> AIAG 15.135554 14.642973 14.50106 14.587588 14.392651 14.878944 14.763767
#> AOC3  8.830496  9.607988 10.22964  8.666865  9.197119  8.429024  8.745846
#> APOH 17.688508 17.622580 18.09545 16.932939 18.020715 17.465965 16.136053
#> ATRN 15.356655 15.083532 15.44032 15.050747 15.764067 15.134377 14.673516
#>       38_data1  39_data1  43_data1  44_data1 45_data1
#> AFM  17.819313 17.303960 17.640026 17.274972 18.47362
#> AHSG 18.717438 19.077383 18.607056 18.795921 19.40802
#> AIAG 15.125151 14.911137 14.625692 14.318688 14.54279
#> AOC3  9.241095  9.321773  9.080731  8.895516 10.11394
#> APOH 17.522211 16.976758 16.843956 17.486311 18.01415
#> ATRN 15.402824 15.192443 15.204575 15.563628 15.63803

# Read in annotation including condition and biological replicates.
# Users should make this annotation file.
# OV_SRM_train_annotation <- read.csv(file="OV_SRM_train_annotation.csv", header=TRUE)
head(OV_SRM_train_annotation)
#>    BioReplicate Condition
#> 88    111_data2   control
#> 89    112_data2   control
#> 90    114_data2   control
#> 91    115_data2   control
#> 92    117_data2   control
#> 93    118_data2   control

# estimate the mean protein abunadnce and variance in each condition
variance_estimation <- estimateVar(data = OV_SRM_train,
annotation = OV_SRM_train_annotation)
#>  Preparing variance analysis...
#>  Variance analysis completed.

# the mean protein abundance in each condition
head(variance_estimation$mu)
#>        control ovarian cancer
#> AFM  18.213066      17.956584
#> AHSG 19.137513      19.004551
#> AIAG 14.665297      14.699719
#> AOC3  9.749418       9.434263
#> APOH 17.274931      17.161911
#> ATRN 15.604271      15.297676

# the standard deviation in each condition
head(variance_estimation$sigma)
#>        control ovarian cancer
#> AFM  0.4212154      0.4212154
#> AHSG 0.4295371      0.4295371
#> AIAG 0.1299203      0.1299203
#> AOC3 0.4432402      0.4432402
#> APOH 0.6306461      0.6306461
#> ATRN 0.4412322      0.4412322

# the mean protein abundance across all the conditions
head(variance_estimation$promean)
#>      AFM     AHSG     AIAG     AOC3     APOH     ATRN
#> 18.07519 19.06604 14.68380  9.58000 17.21417 15.43945
```

### 1.2 meanSDplot()

This function draws the plot for the mean protein abundance (X-axis) vs standard deviation (Y-axis) in each condition. The `lowess` function is used to fit the LOWESS smoother between meann protein abundance and standard deviation (square root of variance). This function generates one pdf file with mean-SD plot.

#### Arguments

* `data` : A list with mean protein abundance matrix and standard deviation matrix. It should be the output of `estimateVar` function.
* `x.axis.size` : Size of x-axis labeling in Mean-SD Plot. Default is 10.
* `y.axis.size` : Size of y-axis labels. Default is 10.
* `smoother_size` : Size of lowess smoother. Default is 1.
* `width` : Width of the saved pdf file. Default is 4.
* `height` : Height of the saved pdf file. Default is 4.
* `xlimUp` : The upper limit of x-axis for mean-SD plot. Default is 30.
* `ylimUp` : The upper limit of y-axis for mean-SD plot. Default is 3.
* `address` : The name of folder that will store the results. Default folder is the current working directory. The other assigned folder has to be existed under the current working directory. An output pdf file is automatically created with the default name of `MeanSDPlot.pdf`. The command address can help to specify where to store the file as well as how to modify the beginning of the file name. If address=FALSE, plot will be not saved as pdf file but showed in window.

#### Example

```
#  output a pdf file with mean-SD plot
meanSDplot(variance_estimation)
```

## 2. Simulates data with the given numbers of biological replicates and proteins based on the variance estimation

### 2.1 simulateDataset()

This function simulate datasets with the given numbers of biological replicates and proteins based on the preliminary dataset (input for this function). The function fits intensity-based linear model on the input data `data` in order to get variance and mean abundance, using `estimateVar` function. Then it uses variance components and mean abundance to simulate new training data with the given sample size and protein number. It outputs the number of simulated proteins, a vector with the number of simulated samples in each condition, the list of simulated training datasets, the input dataset and the (simulated) validation dataset.

#### Arguments

* `data` : Protein abundance data matrix. Rows are proteins and columns are biological replicates(samples).
* `annotation` : Group information for samples in data. `BioReplicate` for sample ID and `Condition` for group information are required. `BioReplicate` information should match with column names of `data`.
* `num_simulations` : Number of times to repeat simulation experiments (Number of simulated datasets). Default is 10.
* `expected_FC` : Expected fold change of proteins. The first option (Default) is “data”, indicating the fold changes are directly estimated from the input `data`. The second option is a vector with predefined fold changes of listed proteins. The vector names must match with the unique information of Condition in `annotation`. One group must be selected as a baseline and has fold change 1 in the vector. The user should provide list\_diff\_proteins, which users expect to have the fold changes greater than 1. Other proteins that are not available in `list_diff_proteins` will be expected to have fold change = 1.
* `list_diff_proteins` : Vector of proteins names which are set to have fold changes greater than 1 between conditions. If user selected `expected_FC= "data"`, this should be NULL.
* `select_simulated_proteins` : The standard to select the simulated proteins among data. It can be 1) “proportion” of total number of proteins in the input data or 2) “number” to specify the number of proteins. “proportion” indicates that user should provide the value for `protein_proportion` option. “number” indicates that user should provide the value for `protein_number` option.
* `protein_proportion` : Proportion of total number of proteins in the input data to simulate. For example, input data has 1,000 proteins and user selects `protein_proportion=0.1`. Proteins are ranked in decreasing order based on their mean abundance across all the samples. Then, 1,000 \* 0.1 = 100 proteins will be selected from the top list to simulate. Default is 1.0, which meaans that all the proteins will be used.
* `protein_number` : Number of proteins to simulate. For example, `protein_number=1000`. Proteins are ranked in decreasing order based on their mean abundance across all the samples and top `protein_number` proteins will be selected to simulate. Default is 1000.
* `samples_per_group` : Number of samples per group to simulate. Default is 50.
* `simulate_validation` : Default is FALSE. If TRUE, simulate the validation set; otherwise, the input `data` will be used as the validation set.
* `valid_samples_per_group` : Number of validation samples per group to simulate. This option works only when user selects `simulate_validation=TRUE`. Default is 50.

#### Example

```
# expected_FC = "data": fold change estimated from OV_SRM_train
# select_simulated_proteins = "proportion": select the simulated proteins based on the proportion of total proteins
# simulate_valid = FALSE: use input OV_SRM_train as validation set
simulated_datasets <- simulateDataset(data = OV_SRM_train,
annotation = OV_SRM_train_annotation,
num_simulations = 10, # simulate 10 times
expected_FC = "data",
list_diff_proteins =  NULL,
select_simulated_proteins = "proportion",
protein_proportion = 1.0,
protein_number = 1000,
samples_per_group = 50, # 50 samples per condition
simulate_validation = FALSE,
valid_samples_per_group = 50)
```

Explore the output from `simulateDataset` function

```
# the number of simulated proteins
simulated_datasets$num_proteins
#> [1] 67

# a vector with the number of simulated samples in each condition
simulated_datasets$num_samples
#>        control ovarian cancer
#>             50             50

# the list of simulated protein abundance matrices
# Each element of the list represents one simulation
head(simulated_datasets$simulation_train_Xs[[1]]) # first simulation
#>      IGHG2       HP      CFH     AHSG      AFM       CP    ITIH4 SERPINA3
#> 1 23.17820 20.62908 21.39711 19.02240 17.85197 18.77371 18.60122 17.63315
#> 2 23.10320 22.66448 20.38849 19.61748 18.36159 18.59025 18.20908 17.50159
#> 3 22.71754 21.96858 20.63283 18.86283 18.87213 18.16726 18.40890 17.92695
#> 4 21.70558 22.98380 20.51755 18.52515 17.35647 18.03844 19.02507 17.77186
#> 5 22.51930 22.11918 20.22962 18.32349 17.40849 18.35099 17.62718 18.38406
#> 6 22.09835 21.41395 20.79735 19.01184 18.10257 18.32270 17.81169 16.98814
#>       KNG1    ITIH2     APOH     PON1      CLU SERPINA6     LRG1      LUM
#> 1 17.69119 16.74390 17.80738 16.90696 16.06064 16.97239 15.74241 16.20897
#> 2 17.67673 17.94372 16.96511 16.51063 17.03416 17.29475 16.30190 16.52432
#> 3 17.33635 17.56692 18.12684 18.32158 17.42076 17.26257 16.10082 16.41153
#> 4 17.68232 17.17535 16.99377 17.14548 16.42683 16.17265 17.02200 15.11091
#> 5 17.18615 17.65899 16.56540 16.72649 16.84102 16.46278 16.23347 16.19560
#> 6 17.06068 17.34793 17.37609 17.36169 17.37208 16.67954 16.10428 17.12296
#>      FETUA    KLKB1     ATRN LGALS3BP     AIAG     ECM1       F5    HYOU1
#> 1 16.02324 15.85825 15.79356 15.82875 14.67820 13.89848 14.57855 14.44074
#> 2 16.13217 15.80812 16.14627 15.81710 14.48787 13.52192 14.30572 13.46407
#> 3 15.93032 15.92318 15.28329 16.03054 14.88971 14.47369 14.35019 14.28960
#> 4 16.24340 15.55533 15.17573 15.22705 14.76570 15.00271 13.57747 14.43879
#> 5 16.20448 15.71264 14.72040 14.44431 14.77789 14.72594 14.19575 14.30502
#> 6 16.25167 15.34033 15.97998 13.40339 14.64518 14.76011 14.22567 14.35883
#>     COL6A6 SERPINA10      BTD      VTN     PLTP     CD44      F11      CPE
#> 1 14.05754  13.86235 12.79398 13.89306 12.82462 13.19885 12.91787 13.35522
#> 2 13.54814  14.08662 13.88606 13.55902 13.29426 12.16868 12.17672 13.76597
#> 3 14.07808  13.89023 14.09961 13.31354 12.74010 13.44513 12.64694 12.69651
#> 4 14.12288  13.75922 13.81911 14.10916 13.27049 12.53663 12.51183 13.20585
#> 5 13.88380  13.60278 13.30361 12.65343 13.22442 12.48153 12.61053 12.14412
#> 6 14.06946  13.53475 14.00896 11.88796 12.47072 12.45929 13.72623 11.90070
#>       CTBS SERPINA7    ICAM1    NCAM1     LCN2     PRG4      FN1    CD163
#> 1 12.59007 12.31716 11.84635 11.92115 12.02109 11.48265 11.53076 11.68050
#> 2 13.25045 12.51779 12.40905 11.76767 11.88502 10.42314 12.59769 11.70049
#> 3 12.39963 12.73802 12.62758 12.26363 10.89789 11.73737 11.95219 12.51742
#> 4 13.42967 12.30499 11.78026 11.65144 12.12602 12.22002 11.06459 12.72922
#> 5 12.52920 13.22928 12.23447 12.61036 11.88407 12.77702 12.15559 11.86906
#> 6 12.60091 12.64603 11.16632 12.24681 11.56575 12.33532 12.00283 11.79649
#>       CDH5    CADM1  C20orf3     CTSD    PVRL1    CDH13   PCYOX1     DSG2
#> 1 11.39737 11.91754 12.15039 11.64116 10.87703 10.78764 10.68526 10.97060
#> 2 11.71171 11.50540 12.55052 11.54730 11.95021 11.06750 10.78776 11.22077
#> 3 11.76251 11.84616 10.97603 11.06182 10.96879 10.59295 11.22692 10.62372
#> 4 11.24053 11.05502 10.37125 11.65825 11.71688 11.03636 10.68406 11.01105
#> 5 11.44578 11.86329 10.44535 11.37094 11.15004 11.15856 10.24316 10.99912
#> 6 11.23317 11.50929 10.51842 10.48538 10.65531 11.57809 11.68188 10.65791
#>      TIMP1     MFAP4    IGFBP3   SLC3A2    ICAM2     GOLM1     LAMP1      CHL1
#> 1 10.45616 10.959775 10.764670 10.05180 10.14326  9.143764  9.590815 10.738148
#> 2 10.59018 10.787332 10.555203 10.88891  9.49811  7.953429 10.683341  9.581997
#> 3 10.68451 10.462692 11.026816 10.00575 10.61298 10.175295  9.359655 10.395408
#> 4 11.76989 10.658311  9.532799 10.02195 10.88050  9.516278 11.265387 10.295075
#> 5 10.94105  9.668583 10.942898 10.99083 10.61006 11.047789 10.236279  9.158005
#> 6 10.39069 10.854637 12.404241 10.99895 10.18708 11.202281 10.652372 10.325839
#>       L1CAM       TNC      MRC2     LAMC1    STAB1      DSC2     AOC3    SIRPA
#> 1 10.852875  9.629522  9.336757  9.571880 9.888791  9.662706 8.983727 9.919412
#> 2 10.705823 11.308698 10.161081  8.968227 9.712228  9.365136 9.675757 9.457435
#> 3  9.794511 10.710499  9.611829 10.281953 9.651851  9.123022 9.802686 9.767885
#> 4 10.164289 10.115093  9.757339 11.352781 9.478245  9.498029 8.823429 9.641632
#> 5 10.284479 10.643631 10.387996 10.489098 8.929548 10.055272 9.189051 9.771156
#> 6 11.029751  9.697854 10.220190 10.119032 9.659008  9.188583 9.678641 9.228749
#>        CFP     PGCP    THBS1
#> 1 8.943611 8.821786 5.950111
#> 2 9.208137 9.101102 8.562010
#> 3 8.820958 8.802370 5.554191
#> 4 7.939502 8.696927 5.365814
#> 5 9.208284 9.240462 6.811783
#> 6 9.075199 8.364004 8.539957

# the list of simulated condition vectors
# Each element of the list represents one simulation
head(simulated_datasets$simulation_train_Ys[[1]]) # first simulation
#> [1] ovarian cancer control        control        ovarian cancer ovarian cancer
#> [6] control
#> Levels: control ovarian cancer
```

User can also specify the expected fold change of proteins they consider to be differentially abundant between conditions.

```
# expected_FC = expected_FC: user defined fold change
unique(OV_SRM_train_annotation$Condition)
#> [1] control        ovarian cancer
#> Levels: benign ovarian cancer control
expected_FC <- c(1, 1.5)
names(expected_FC) <- c("control", "ovarian cancer")
set.seed(1212)
# Here I randomly select some proteins as differential to show how the function works
# The user should prepare this list of differential proteins by themselves
diff_proteins <- sample(rownames(OV_SRM_train), 20)
simualted_datasets_predefined_FC <- simulateDataset(data = OV_SRM_train,
annotation = OV_SRM_train_annotation,
num_simulations = 10, # simulate 10 times
expected_FC = expected_FC,
list_diff_proteins =  diff_proteins,
select_simulated_proteins = "proportion",
protein_proportion = 1.0,
protein_number = 1000,
samples_per_group = 50, # 50 samples per condition
simulate_validation = FALSE,
valid_samples_per_group = 50)
```

## 3. Sample size estimation for classification

### 3.1. designSampleSizeClassification()

This function fits the classification model, in order to classify the subjects in the simulated training datasets (in the output of `simulatedDataset`). Then the fitted model is validated by the (simulated) validation set. Two performance are reported : (1) the mean predictive accuracy : The function trains classifier on each simulated training dataset and reports the predictive accuracy of the trained classifier on the validation data (output of `SimulateDataset` function). Then these predictive accuracies are averaged over all the simulation. (2) the mean protein importance : It represents the importance of a protein in separating different groups. It is estimated on each simulated training dataset using function `varImp` from package caret. Please refer to the help file of `varImp` about how each classifier calculates the protein importance. Then these importance values for each protein are averaged over all the simulation.

The list of classification models trained on each simulated dataset, the predictive accuracy on the validation set predicted by the corresponding classification model and the importance value for all the proteins estimated by the corresponding classification model are also reported.

### Arguments

* `simulations` : A list of simulated datasets It should be the name of the output of `SimulateDataset` function.
* `classifier` : A string specifying which classfier to use. This function uses function `train` from package caret. The options are 1) rf (random forest calssifier, default option). 2) nnet (neural network), 3) svmLinear (support vector machines with linear kernel), 4) logreg(logistic regression), and 5) naive\_bayes (naive\_bayes).
* `parallel` : Default is FALSE. If TRUE, parallel computation is performed.

### Example

```
classification_results <- designSampleSizeClassification(
simulations = simulated_datasets,
parallel = FALSE)
```

Explore the output of `designSampleSizeClassification`

```
# the number of simulated proteins
classification_results$num_proteins
#> [1] 67
# a vector with the number of simulated samples in each condition
classification_results$num_samples
#>        control ovarian cancer
#>             50             50
# the mean predictive accuracy over all the simulated datasets,
# which have same 'num_proteins' and 'num_samples'
classification_results$mean_predictive_accuracy
#> [1] 0.7242775
# the mean protein importance vector over all the simulated datasets,
# the length of which is 'num_proteins'.
head(classification_results$mean_feature_importance)
#> SERPINA3    GOLM1 LGALS3BP    TIMP1    IGHG2     LRG1
#>       10        9        7        7        6        6
```

In order to speed up the running time, the package also provides parallel computation for `designSampleSizeClassification` function.

```
## try parallel computation to speed up
## The parallel computation may cause error while allocating the core resource
## Then the users can try the abova function without parallel computation
classification_results_parallel <- designSampleSizeClassification(
simulations = simulated_datasets,
parallel = TRUE)
```

### 3.2 designSampleSizeClassificationPlots()

This function visualizes for sample size calculation in classification. Mean predictive accuracy and mean protein importance under each sample size is from the input `data`, which is the output from function `designSampleSizeClassification`. To illustrate the mean predictive accuracy and protein importance under different sample sizes, it generates two types of plots in pdf files as output :

1. The predictive accuracy plot shows the mean predictive accuracy under different sample sizes. The X-axis represents different sample sizes and y-axis represents the mean predictive accuracy.
2. The protein importance plot includes multiple subplots. The number of subplots is equal to `list_samples_per_group`. Each subplot shows the top `num_important_proteins_show` most important proteins under each sample size. The Y-axis of each subplot is the protein name and X-axis is the mean protein importance under the sample size.

While varying the number of biological replicates to simulate, the sample size per condition which generates the largest predictive accuracy can be found from the predictive accuracy plot, The optimal sample size per condition can be used to design future experiments. Also, the proteins, which can classify the conditions best, are reported by the protein importance plot.

#### Arguments

* `data` : A list of outputs from function `designSampleSizeClassification`. Each element represents the results under a specific sample size. The input should include at least two simulation results with different sample sizes.
* `list_samples_per_group` : A vector includes the different sample sizes simulated. This is required. The number of simulation in the input `data` should be equal to the length of list\_samples\_per\_group
* `num_important_proteins_show` : The number of proteins to show in protein importance plot.
* `protein_importance_plot` : TRUE(default) draws protein importance plot.
* `predictive_accuracy_plot` : TRUE(default) draws predictive accuracy plot.
* `x.axis.size` : Size of x-axis labeling in predictive accuracy plot and protein importance plot. Default is 10.
* `y.axis.size` : Size of y-axis labels in predictive accuracy plot and protein importance plot. Default is 10.
* `predictive_accuracy_plot_width` : Width of the saved pdf file for predictive accuracy plot. Default is 4.
* `predictive_accuracy_plot_height` : Height of the saved pdf file for predictive accuracy plot. Default is 4.
* `protein_importance_plot_width` : Width of the saved pdf file for protein importance plot. Default is 3.
* `protein_importance_plot_height` : Height of the saved pdf file for protein importance plot. Default is 3.
* `ylimUp_predictive_accuracy` : The upper limit of y-axis for predictive accuracy plot. Default is 1. The range should be 0 to 1.
* `ylimDown_predictive_accuracy` : The lower limit of y-axis for predictive accuracy plot. Default is 0.0. The range should be 0 to 1.
* `address` : The name of folder that will store the results. Default folder is the current working directory. The other assigned folder has to be existed under the current working directory. An output pdf file is automatically created with the default name of `PredictiveAccuracyPlot.pdf` and `ProteinImportancePlot.pdf`. The command address can help to specify where to store the file as well as how to modify the beginning of the file name. If address=FALSE, plot will be not saved as pdf file but showed in window.

#### Example

```
#### sample size classification ####
# simulate different sample sizes
# 1) 10 biological replicats per group
# 1) 25 biological replicats per group
# 2) 50 biological replicats per group
# 3) 100 biological replicats per group
# 4) 200 biological replicats per group
list_samples_per_group <- c(10, 25, 50, 100, 200)

# save the simulation results under each sample size
multiple_sample_sizes <- list()

for(i in seq_along(list_samples_per_group)){
# run simulation for each sample size
simulated_datasets <- simulateDataset(data = OV_SRM_train,
annotation = OV_SRM_train_annotation,
num_simulations = 10, # simulate 10 times
expected_FC = "data",
list_diff_proteins =  NULL,
select_simulated_proteins = "proportion",
protein_proportion = 1.0,
protein_number = 1000,
samples_per_group = list_samples_per_group[i],
simulate_valid = FALSE,
valid_samples_per_group = 50)

# run classification performance estimation for each sample size
res <- designSampleSizeClassification(simulations = simualted_datasets,
parallel = TRUE)

# save results
multiple_sample_sizes[[i]] <- res
}

## make the plots
designSampleSizeClassificationPlots(multiple_sample_sizes,
list_samples_per_group,
ylimUp_predictive_accuracy = 0.8,
ylimDown_predictive_accuracy = 0.6)
```

## 4. Sample size estimation for hypothesis testing

### 4.1. designSampleSizeHypothesisTestingPlot()

The function fits intensity-based linear model on the input `data`. Then it uses the fitted models and the fold changes estimated from the models to calculate sample size for hypothesis testing through `designSampleSize` function from MSstats package. It outputs a table with the minimal number of biological replciates per condition to acquire the expected FDR and power under different fold changes, and a PDF file with the sample size plot.

#### Arguments

* `data` : Protein abundance data matrix. Rows are proteins and columns are biological replicates (samples).
* `annotation` : Group information for samples in data. `BioReplicate` for sample ID and `Condition` for group information are required. `BioReplicate` information should match with column names of `data`.
* `desired_FC` : the range of a desired fold change. The first option (Default) is “data”, indicating the range of the desired fold change is directly estimated from the input `data`, which are the minimal fold change and the maximal fold change in the input `data’. The second option is a vector which includes the lower and upper values of the desired fold change (For example, c(1.25,1.75)).
* `select_testing_proteins` : the standard to select the proteins for hypothesis testing and sample size calculation. The variance (and the range of desired fold change if desiredFC = “data”) for sample size calculation will be estimated from the selected proteins. It can be 1) “proportion” of total number of proteins in the input data or

2. “number” to specify the number of proteins. “proportion” indicates that user should provide the value for `protein_proportion` option. “number” indicates that user should provide the value for `protein_number` option.

* `protein_proportion` : Proportion of total number of proteins in the input data to test. For example, input data has 1,000 proteins and user selects `protein_proportion=0.1`. Proteins are ranked in decreasing order based on their mean abundance across all the samples. Then, 1,000 \* 0.1 = 100 proteins will be selected from the top list to test. Default is 1.0, which meaans that all the proteins will be used.
* `protein_number` : Number of proteins to test. For example, `protein_number=1000`. Proteins are ranked in decreasing order based on their mean abundance across all the samples and top `protein_number` proteins will be selected to test. Default is 1000.
* `FDR` : a pre-specified false discovery ratio (FDR) to control the overall false positive. Default is 0.05.
* `power` : a pre-specified statistical power which defined as the probability of detecting a true fold change. You should input the average of power you expect. Default is 0.9.
* `width` : Width of the saved pdf file. Default is 5.
* `height` : Height of the saved pdf file. Default is 5.
* `address` : The name of folder that will store the results. Default folder is the current working directory. The other assigned folder has to be existed under the current working directory. An output pdf file is automatically created with the default name of `HypothesisTestingSampleSizePlot.pdf`. The command address can help to specify where to store the file as well as how to modify the beginning of the file name. If address=FALSE, plot will be not saved as pdf file but showed in window.

#### Example

```
#  output a pdf file with sample size calculation plot for hypothesis testing
#  also return a table which summaries the plot
HT_res <- designSampleSizeHypothesisTestingPlot(data = OV_SRM_train,
annotation= OV_SRM_train_annotation,
desired_FC = "data",
select_testing_proteins = "proportion",
protein_proportion = 1.0,
protein_number = 1000,
FDR=0.05,
power=0.9)
#>  Preparing variance analysis...
#>  Variance analysis completed.
#>  Number of proteins to test: 67
#>  The 1st quantile of fold changes from input data is 1.0074, which is too small. The minimal fold change for sample size estimation is set to 1.1
#>  Drew the sample size plot for hypothesis testing!

# data frame with columns desiredFC, numSample, FDR, power and CV
head(HT_res)
#>   desiredFC numSample  FDR power    CV
#> 1     1.100       510 0.05   0.9 0.001
#> 2     1.125       334 0.05   0.9 0.001
#> 3     1.150       237 0.05   0.9 0.002
#> 4     1.175       178 0.05   0.9 0.002
#> 5     1.200       139 0.05   0.9 0.003
#> 6     1.225       112 0.05   0.9 0.003
```

## 5. Visualization for simulated datasets

### 5.1 designSampleSizePCAplot()

This function draws PCA plots for the preliminary dataset and each simulated dataset in `simulations` (input for this function). It outputs a pdf file where the number of page is equal to the number of simulations plus 1. The first page represents a PCA plot for the input `data` (`OV_SRM_train`). Each of the following pages presents a PCA plot under one simulation. X-axis of PCA plot is the first component and y-axis is the second component. This function can be used to validate whether the simulated dataset looks consistent with the input preliminary dataset.

#### Arguments

* `simulations` : A list of simulated datasets. It should be the output of `simulateDataset` function.
* `which.PCA` : Select one PCA plot to show. It can be “all”, “allonly”, or “simulationX”. X should be index of simulation, such as “simulation1” or “simulation5”. Default is “all”, which generates all the plots. “allonly” generates the PCA plot for the whole input dataset. “simulationX” generates the PCA plot for a specific simulated dataset (given by index).
* `x.axis.size` : Size of x-axis labeling in PCA Plot. Default is 10.
* `y.axis.size` : Size of y-axis labels. Default is 10.
* `dot.size` : Size of dots in PCA plot. Default is 3.
* `legend.size` : Size of legend above Profile plot. Default is 7.
* `width` : Width of the saved pdf file. Default is 6.
* `height` : Height of the saved pdf file. Default is 5.
* `address` : The name of folder that will store the results. Default folder is the current working directory. The other assigned folder has to be existed under the current working directory. An output pdf file is automatically created with the default name of `PCAPlot.pdf`. The command address can help to specify where to store the file as well as how to modify the beginning of the file name. If address=FALSE, plot will be not saved as pdf file but showed in window.

#### Example

```
#  output a pdf file with 11 PCA plots
designSampleSizePCAplot(simulated_datasets)
```