# Vector used by frma for microarrays of type rat2302

Vincenzo Belcastro, Sylvain Gubian

#### *12 February 2019*

#### Package

rat2302frmavecs 0.99.11

# Contents

* [1 Description](#description)
* [2 Basic usage](#basic-usage)

# 1 Description

The rat2302frmavecs package was built from the set of 1023 microarray samples, distributed according to the table below. The maximum number of samples per dataset is 93, and was selected to have a uniform sample distribution across tissues (only 93 samples were available for the bone marrow tissue).

The table below reports the number of samples per dataset, for experiments conducted on rat4302 affymetrics platform. The 93 samples per dataset were selected as follow (steps applied for each dataset separately):

1. The official metadata file (e.g.: E-GEOD-XXXX.sdrf.txt) was loaded, and filtered to keep only those samples associated to the correct microarray platform;
2. A random uniform sampling (seed set to 4778) of 93 integer numbers (1 to number of samples of the dataset) were extracted
3. The 93 rows of the metadata file were selected along with the corresponding samples;
4. The 93 samples (.CEL files) were extracted from the RAW data zip archives from ArrayExpress repository;
5. Once all 1023 (93 for each of the 11 tissues) samples were extracted the makeVectorPackage function was called with the batch.id parameter set to a vector of length 1023 (93 repetitions of each dataset names), and with annotation parameter set to rat2302cdf.

Step number 5 generates a package containing the vectors needed to the FRMA tool, affy ID based in case the annotation parameter was set to rat2302cdf.

|  | Total | Dataset | Used |
| --- | --- | --- | --- |
| Adipose tissue | 101 | E-GEOD-13268 | 93 |
| Brain | 335 | E-GEOD-28435 | 93 |
| Eye | 120 | E-GEOD-5680 | 93 |
| Heart | 862 | E-GEOD-57800 | 93 |
| Kidney | 1410 | E-GEOD-57811 | 93 |
| Liver | 2218 | E-GEOD-57815 | 93 |
| Thigh muscle | 158 | E-GEOD-57816 | 93 |
| Bone marrow | 93 | E-GEOD-63902 | 93 |
| Mixed (testis/liver/brain/kidney) | 264 | E-MEXP-1568 | 93 |
| Bronchus | 164 | E-TABM-458 | 93 |
| Skeletal muscle | 126 | E-TABM-458 | 93 |
| **TOTAL** |  |  | **1023** |

# 2 Basic usage

```
library('affy')
library('frma')
library('rat2302frmavecs')

celfile = system.file("extdata", "sample.CEL", package = "rat2302frmavecs")
affybatch = ReadAffy(filenames = celfile, cdfname = 'rat2302cdf')
eset = frma(affybatch)
```