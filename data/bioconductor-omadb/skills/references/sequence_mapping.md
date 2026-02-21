# Sequence Analysis with OmaDB

#### Klara Kaleb

#### 2025-10-30

Another useful function of the OmaDB package is its functionality to exactly and partially match sequences. We will explore this further in this vignette.

Let’s say we have a sequence of interest that we want to map, in this case:

```
 sequence = "MNDPSLLGYPNVGPQQQQQQQQQQHAGLLGKGTPNALQQQLHMNQLTGIPPPGLMNNSDVHTSSNNNSRQLLDQLANGNANMLNMNMDNNNNNNNNNNNNNNNGGGSGVMMNASTAAVNSIGMVPTVGTPVNINVNASNPLLHPHLDDPSLLNNPIWKLQLHLAAVSAQSLGQPNIYARQNAMKKYLATQQAQQAQQQAQQQAQQQVPGPFGPGPQAAPPALQPTDFQQSHIAEASKSLVDCTKQALMEMADTLTDSKTAKKQQPTGDSTPSGTATNSAVSTPLTPKIELFANGKDEANQALLQHKKLSQYSIDEDDDIENRMVMPKDSKYDDQLWHALDLSNLQIFNISANIFKYDFLTRLYLNGNSLTELPAEIKNLSNLRVLDLSHNRLTSLPAELGSCFQLKYFYFFDNMVTTLPWEFGNLCNLQFLGVEGNPLEKQFLKILTEKSVTGLIFYLRDNRPEIPLPHER"
```

We can pass it to the mapSequence() function which returns a list of targets. From this list we can then construct protein objects for which we can obtain further infromation - such as its oma group or its domains. The example response object, generated via mapSequence(sequence), is below.

```
library(OmaDB)

load('../data/sequence_map.rda')

getObjectAttributes(sequence_map)
```

```
## [1] "query : character"
## [1] "identified_by : character"
## [1] "targets : list"
```

```
targets = getAttribute(sequence_map,'targets')

length(targets)
```

```
## [1] 1
```

```
protein = targets[[1]][['entry_url']]
```

One can also directly obtain GO annotations for a given query sequence (protein$ogene\_ontology), which results in an object as below:

```
load('../data/sequence_annotation.rda')

sequence_annotation
```

```
##   Qualifier      GO_ID                                With Evidence     Date
## 1           GO:0003677 Approx:DICDI02796:239.3634208239752      IEA 20180102
## 2           GO:0005509 Approx:DICDI02796:239.3634208239752      IEA 20180102
## 3           GO:0005634 Approx:DICDI02796:239.3634208239752      IEA 20180102
## 4           GO:0006351 Approx:DICDI02796:239.3634208239752      IEA 20180102
## 5           GO:0006355 Approx:DICDI02796:239.3634208239752      IEA 20180102
## 6           GO:0007275 Approx:DICDI02796:239.3634208239752      IEA 20180102
##   DB_Object_Type DB_Object_Name Aspect Assigned_By
## 1        protein                     F OMA_FastMap
## 2        protein                     F OMA_FastMap
## 3        protein                     C OMA_FastMap
## 4        protein                     P OMA_FastMap
## 5        protein                     P OMA_FastMap
## 6        protein                     P OMA_FastMap
##                                      GO_name          DB DB.Reference Synonym
## 1                                DNA binding OMA_FastMap  OMA_Fun:002
## 2                        calcium ion binding OMA_FastMap  OMA_Fun:002
## 3                                    nucleus OMA_FastMap  OMA_Fun:002
## 4               transcription, DNA-templated OMA_FastMap  OMA_Fun:002
## 5 regulation of transcription, DNA-templated OMA_FastMap  OMA_Fun:002
## 6         multicellular organism development OMA_FastMap  OMA_Fun:002
```