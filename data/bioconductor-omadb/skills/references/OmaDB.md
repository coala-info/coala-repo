# Get started with OmaDB

#### Klara Kaleb

#### 2025-10-30

This little vignette shows you how to get started with the `OmaDB` package. OmaDB is a wrapper for the REST API for the Orthologous MAtrix project (OMA) which is a database for the inference of orthologs among complete genomes.

For more details on the OMA project, see <https://omabrowser.org/oma/home/>.

Note that each function in the package has its own individual documentation, which can be accessed by putting a question mark (?) in front of the function name e.g. ?getProtein() .

## Some useful functions

The package contains a range of functions that are used to query the database in an R friendly way. This vignette highlights some of them, whereas some others are described in more detail in other vignettes:

[Exploring Hierarchical orthologous groups with roma](exploring_hogs.html)

[Exploring Taxonomic trees with roma](tree_visualisation.html)

[Sequence Analysis with roma](sequence_mapping.html)

Note that all of the vignettes focus on exploring the example responses generated previously, allowing them to build with or without an internet connection. For each example response, the query that generated it is given.

### searchProtein

This function searches the OMA database for entries containing the pattern defined and returns the results in a dataframe. Hence, it is usually a good starting place. Example response, generated via searchProtein(‘MAL’), is below.

```
library(OmaDB)

xref = load('../data/xref.rda')

head(xref)
```

```
## [1] "xref"
```

### getGenomePairs

This function serves to obtain the orthologs for 2 whole genomes. The result is a dataframe containing information on each member in the pair and their relationship. Below is the representation of the example response, generated using getGenomePairs(‘YEAST’,‘ASHGO’).

```
load('../data/pairs.rda')

head(pairs)
```

```
##   entry_1.entry_nr                           entry_1.entry_url entry_1.omaid
## 1          6618226 https://omabrowser.org/api/protein/6618226/    ASHGO00001
## 2          6618227 https://omabrowser.org/api/protein/6618227/    ASHGO00002
## 3          6618228 https://omabrowser.org/api/protein/6618228/    ASHGO00003
## 4          6618229 https://omabrowser.org/api/protein/6618229/    ASHGO00004
## 5          6618230 https://omabrowser.org/api/protein/6618230/    ASHGO00005
## 6          6618231 https://omabrowser.org/api/protein/6618231/    ASHGO00006
##   entry_1.canonicalid             entry_1.sequence_md5 entry_1.oma_group
## 1              Q75FB7 a9b1a6dc9afb2b02afe8fdf8029b5f22                 0
## 2              Q75FB6 5d186037c4dd0a89b34d70d596fac86d            203915
## 3              Q75FB5 3a83b276f0c9034f7cf66277e7d6c983            214367
## 4              Q75FB4 a8611c3f24ac6599e6a36a2710f6d24a            768456
## 5              Q75FB3 07277f0ca66fcb49d175667272f1547f            530479
## 6              Q75FB2 2b666569856af5f068e532ade89c1140            563083
##   entry_1.oma_hog_id entry_1.chromosome entry_1.locus.start entry_1.locus.end
## 1     HOG:0393392.4c                  I                8108              9067
## 2        HOG:0200818                  I                9537             12593
## 3        HOG:0200433                  I               12906             13244
## 4  HOG:0387657.2d.3a                  I               13713             14846
## 5     HOG:0397172.3b                  I               16155             19850
## 6     HOG:0201049.3a                  I               20056             23721
##   entry_1.locus.strand entry_1.is_main_isoform entry_2.entry_nr
## 1                    1                    TRUE          6637770
## 2                    1                    TRUE          6637359
## 3                    1                    TRUE          6637360
## 4                    1                    TRUE          6637767
## 5                    1                    TRUE          6636211
## 6                   -1                    TRUE          6636209
##                             entry_2.entry_url entry_2.omaid entry_2.canonicalid
## 1 https://omabrowser.org/api/protein/6637770/    YEAST04806          RCE1_YEAST
## 2 https://omabrowser.org/api/protein/6637359/    YEAST04395          ZDS2_YEAST
## 3 https://omabrowser.org/api/protein/6637360/    YEAST04396          YMK8_YEAST
## 4 https://omabrowser.org/api/protein/6637767/    YEAST04803          SCS7_YEAST
## 5 https://omabrowser.org/api/protein/6636211/    YEAST03247          SMC3_YEAST
## 6 https://omabrowser.org/api/protein/6636209/    YEAST03245          NET1_YEAST
##               entry_2.sequence_md5 entry_2.oma_group entry_2.oma_hog_id
## 1 605098a0697ad8fc7af2101e758033cb            494558     HOG:0393392.4c
## 2 8cc75f16fbfd321833abc48fd1173154            203915     HOG:0200818.1a
## 3 783fea3b573632292d89a5a5218b6e90            214367        HOG:0200433
## 4 9307c7a6e80ed39d8b6529329fee1819            768456  HOG:0387657.2d.3a
## 5 4e8f1295434b44ae8f749cad976b966e            530479     HOG:0397172.3b
## 6 f2ba71aea520ea66f015ba357eb6e8c6            563083     HOG:0201049.2a
##   entry_2.chromosome entry_2.locus.start entry_2.locus.end entry_2.locus.strand
## 1               XIII              814364            815311                   -1
## 2               XIII               51640             54468                    1
## 3               XIII               54793             55110                    1
## 4               XIII              809623            810777                   -1
## 5                  X              299157            302849                   -1
## 6                  X              295245            298814                    1
##   entry_2.is_main_isoform rel_type distance   score
## 1                    TRUE      1:1 122.0000  636.04
## 2                    TRUE      1:1  95.0000 1424.24
## 3                    TRUE      1:1  50.0000  557.51
## 4                    TRUE      1:1  37.7442 2682.46
## 5                    TRUE      1:1  58.0000 5548.40
## 6                    TRUE      1:1  90.0000 1844.35
```

### getProtein

This function serves to obtain the information for either a single protein entry or multiple protein entries in a database. For more info, see ?getProtein(). There are similar functions to obtain information on genomes, OMA groups and HOGs i.e. getGenome(), getOMAGroup() and getHOG() respectively.

### getObjectAttributes

Single entries in the database are represented as S3 objects, with their attributes corresponding to the information requested. These attributes vary greatly from object to object, and the helper function getObjectAttributes() allows the user to list all the object attributes and their corresponding data types.

### getAttribute

The specific attributes of the created object can be accessed via $ or via the getAttribute() function. Below is an example of object containing information about an OMA group.

Below is the exploration of the example OMA group entry response, obtained via getOMAGroup(‘737636’).

```
load('../data/group.rda')

object_attributes = getObjectAttributes(group)
```

```
## [1] "group_nr : integer"
## [1] "fingerprint : character"
## [1] "related_groups : URL"
## [1] "members : data.frame"
```

```
group$fingerprint
```

```
## [1] "FPNDKFP"
```

```
getAttribute(group, 'fingerprint')
```

```
## [1] "FPNDKFP"
```

### lazy loading

In most cases there is great quantity of information available for a given entry and this impacts the data retrival time. Due to this, the information available for such entries is split into a number of endpoints and these are included appropriatelly as redirects in URL form. These are automatically loaded upon $ or getAttribute() accession.

For further information on the OMA REST API please visit [OMA REST API DOCUMENTATION](http://omadev.cs.ucl.ac.uk/api/docs).