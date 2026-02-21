# HSDSArray – DelayedArray backend for Remote HDF5

Samuela Pollack and others

#### October 30, 2025

# Contents

* [1 Using the DelayedArray infrastructure](#using-the-delayedarray-infrastructure)
  + [1.1 Interface to HSDS (HDF Object Store)](#interface-to-hsds-hdf-object-store)

# 1 Using the DelayedArray infrastructure

A remote dataset is accessed by giving the URL of the server, the
type of the server (At present the only valid value is `hsds`.), the file domain (path
to the HDF5 file) and the full path to the dataset inside the HDF5 file.

## 1.1 Interface to HSDS (HDF Object Store)

```
if (check_hsds()) {
 da <- HSDSArray(URL_hsds(), 'hsds',
      '/shared/bioconductor/patelGBMSC.h5', '/assay001')
 da
}
```

```
## <65218 x 864> HSDSMatrix object of type "double":
##                [,1]       [,2]       [,3] ...    [,863]    [,864]
##     [1,]  35.650170  41.287100 357.417120   . 123.94820 171.27235
##     [2,]  13.278500   8.313680  21.655700   .  12.10447  12.32039
##     [3,] 162.852500   7.178148  74.442600   .  58.79981 112.98180
##     [4,]  57.402100  26.245630  77.536000   . 122.45777 136.59439
##     [5,]  23.437520 374.456800  36.411020   .  39.67649 217.15135
##      ...          .          .          .   .         .         .
## [65214,]    7.14753    6.25654    5.77305   .  14.51280   8.78161
## [65215,]    0.00000    1.22547    4.00000   .   8.67364   6.26960
## [65216,]    0.00000    6.77233    9.72984   .  13.68860   8.16911
## [65217,]   23.61430    4.41583    7.26575   .   4.55394   9.04190
## [65218,]    0.00000    0.00000    3.28224   .   2.05464   3.00000
```

Again we have DelayedArray capabilities.

```
if (check_hsds()) {
 apply(da[,1:4],2,sum)
}
```

```
## [1] 1965028 1267166 1627512 1338411
```