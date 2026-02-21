# Running OncoScore

Luca De Sano, Carlo Gambacorti Passerini, Rocco Piazza, Daniele Ramazzotti and Roberta Spinelli

#### October 30, 2025

#### Package

OncoScore 1.38.0

The OncoScore analysis consists of two parts. One can estimate a score to asses
the oncogenic potential of a set of genes, given the lecterature knowledge,
at the time of the analysis, or one can study the trend of such score over time.

We next present the two analysis and we conclude with showing the capabilities
of the tool to visualize the results.

First we load the library.

```
library("OncoScore")
```

The query that we show next retrieves from PubMed the citations, at the time of the
query, for a list of genes in cancer related and in all the documents.

```
query = perform.query(c("ASXL1","IDH1","IDH2","SETBP1","TET2"))
```

```
## ### Starting the queries for the selected genes.
##
## ### Performing queries for cancer literature
##  Number of papers found in PubMed for ASXL1 was: 1586
##  Number of papers found in PubMed for IDH1 was: 5696
##  Number of papers found in PubMed for IDH2 was: 2369
##  Number of papers found in PubMed for SETBP1 was: 303
##  Number of papers found in PubMed for TET2 was: 2731
##
## ### Performing queries for all the literature
##  Number of papers found in PubMed for ASXL1 was: 1767
##  Number of papers found in PubMed for IDH1 was: 6076
##  Number of papers found in PubMed for IDH2 was: 2707
##  Number of papers found in PubMed for SETBP1 was: 401
##  Number of papers found in PubMed for TET2 was: 3647
```

OncoScore provides a function to merge gene names if requested by the user.
This function is useful when there are aliases in the gene list.

```
combine.query.results(query, c('IDH1', 'IDH2'), 'new_gene')
```

```
##          CitationsGene CitationsGeneInCancer
## ASXL1             1767                  1586
## SETBP1             401                   303
## TET2              3647                  2731
## new_gene          8783                  8065
```

OncoScore also provides a function to retireve the names of the genes in a given
portion of a chromosome that can be exploited if we are dealing, e.g., with copy
number alterations hitting regions rather than specific genes.

```
chr13 = get.genes.from.biomart(chromosome=13,start=54700000,end=72800000)
```

Furthermore, one can also automatically perform the OncoScore analysis on
chromosomic regions as follows:

```
result = compute.oncoscore.from.region(10, 100000, 500000)
```

We now compute a score for each of the genes, to estimate their oncogenic
potential.

```
result = compute.oncoscore(query)
```

```
## ### Processing data
## ### Computing frequencies scores
## ### Estimating oncogenes
## ### Results:
##   ASXL1 -> 81.4359
##   IDH1 -> 86.28733
##   IDH2 -> 79.83887
##   SETBP1 -> 66.82314
##   TET2 -> 68.55484
```

The query that we show next retrieves from PubMed the citations, at specified time points,
for a list of genes in cancer related and in all the documents.

```
query.timepoints = perform.query.timeseries(c("ASXL1","IDH1","IDH2","SETBP1","TET2"),
    c("2012/03/01", "2013/03/01", "2014/03/01", "2015/03/01", "2016/03/01"))
```

```
## ### Starting the queries for the selected genes.
## ### Quering PubMed for timepoint 2012/03/01
##     ### Performing queries for cancer literature
##  Number of papers found in PubMed for ASXL1 was: 87
##  Number of papers found in PubMed for IDH1 was: 414
##  Number of papers found in PubMed for IDH2 was: 213
##  Number of papers found in PubMed for SETBP1 was: 6
##  Number of papers found in PubMed for TET2 was: 173
##     ### Performing queries for all the literature
##  Number of papers found in PubMed for ASXL1 was: 93
##  Number of papers found in PubMed for IDH1 was: 543
##  Number of papers found in PubMed for IDH2 was: 308
```

```
## Warning in file(file, "r"): cannot open URL
## 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=SETBP1[All+Fields](0001/01/01[PDAT]+:+2012/03/01[PDAT])&retmax=3000000&rettype=FASTA&tool=OncoScore':
## HTTP status was '429 Unknown Error'
```

```
##  Number of papers found in PubMed for SETBP1 was: 12
##  Number of papers found in PubMed for TET2 was: 201
## ### Quering PubMed for timepoint 2013/03/01
##     ### Performing queries for cancer literature
##  Number of papers found in PubMed for ASXL1 was: 136
##  Number of papers found in PubMed for IDH1 was: 669
##  Number of papers found in PubMed for IDH2 was: 339
##  Number of papers found in PubMed for SETBP1 was: 12
##  Number of papers found in PubMed for TET2 was: 258
##     ### Performing queries for all the literature
##  Number of papers found in PubMed for ASXL1 was: 151
##  Number of papers found in PubMed for IDH1 was: 808
##  Number of papers found in PubMed for IDH2 was: 441
```

```
## Warning in file(file, "r"): cannot open URL
## 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=SETBP1[All+Fields](0001/01/01[PDAT]+:+2013/03/01[PDAT])&retmax=3000000&rettype=FASTA&tool=OncoScore':
## HTTP status was '429 Unknown Error'
```

```
##  Number of papers found in PubMed for SETBP1 was: 20
##  Number of papers found in PubMed for TET2 was: 307
## ### Quering PubMed for timepoint 2014/03/01
##     ### Performing queries for cancer literature
##  Number of papers found in PubMed for ASXL1 was: 190
##  Number of papers found in PubMed for IDH1 was: 913
##  Number of papers found in PubMed for IDH2 was: 455
##  Number of papers found in PubMed for SETBP1 was: 30
##  Number of papers found in PubMed for TET2 was: 349
##     ### Performing queries for all the literature
##  Number of papers found in PubMed for ASXL1 was: 211
##  Number of papers found in PubMed for IDH1 was: 1062
##  Number of papers found in PubMed for IDH2 was: 566
```

```
## Warning in file(file, "r"): cannot open URL
## 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=SETBP1[All+Fields](0001/01/01[PDAT]+:+2014/03/01[PDAT])&retmax=3000000&rettype=FASTA&tool=OncoScore':
## HTTP status was '429 Unknown Error'
```

```
##  Number of papers found in PubMed for SETBP1 was: 38
##  Number of papers found in PubMed for TET2 was: 436
## ### Quering PubMed for timepoint 2015/03/01
##     ### Performing queries for cancer literature
##  Number of papers found in PubMed for ASXL1 was: 259
```

```
## Warning in file(file, "r"): cannot open URL
## 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=IDH1[All+Fields]+AND+((lymphoma[MeSH+Terms]+OR+lymphoma[All+Fields])OR+(lymphoma[MeSH+Terms]+OR+lymphoma[All+Fields]+OR+lymphomas[All+Fields])OR+(neoplasms[MeSH+Terms]+OR+neoplasms[All+Fields]+OR+cancer[All+Fields])OR+(tumour[All+Fields]+OR+neoplasms[MeSH+Terms]+OR+neoplasms[All+Fields]OR+tumor[All+Fields])+OR+(neoplasms[MeSH+Terms]+OR+neoplasms[All+Fields]OR+neoplasm[All+Fields])+OR+(neoplasms[MeSH+Terms]+OR+neoplasms[All+Fields]OR+malignancy[All+Fields])+OR+(leukaemia[All+Fields]+OR+leukemia[MeSH+Terms]OR+leukemia[All+Fields])+OR+(neoplasms[MeSH+Terms]+OR+neoplasms[All+Fields]OR+cancers[All+Fields])+OR+(tumours[All+Fields]+OR+neoplasms[MeSH+Terms]OR+neoplasms[All+Fields]+OR+tumors[All+Fields])+OR+(neoplasms[MeSH+Terms]OR+neoplasms[All+Fields]+OR+malignancies[All+Fields])+OR+(leukaemias[All+Fields]OR+leukemia[MeSH+Terms]+OR+leukemia[All+Fields]+OR+leukemias[All+Fields]))+AND+(0001/01/01[PDAT]+:+
## [... truncated]
```

```
##  Number of papers found in PubMed for IDH1 was: 1217
##  Number of papers found in PubMed for IDH2 was: 583
##  Number of papers found in PubMed for SETBP1 was: 52
##  Number of papers found in PubMed for TET2 was: 465
##     ### Performing queries for all the literature
##  Number of papers found in PubMed for ASXL1 was: 288
##  Number of papers found in PubMed for IDH1 was: 1372
##  Number of papers found in PubMed for IDH2 was: 702
##  Number of papers found in PubMed for SETBP1 was: 68
##  Number of papers found in PubMed for TET2 was: 588
## ### Quering PubMed for timepoint 2016/03/01
##     ### Performing queries for cancer literature
##  Number of papers found in PubMed for ASXL1 was: 325
##  Number of papers found in PubMed for IDH1 was: 1536
##  Number of papers found in PubMed for IDH2 was: 720
##  Number of papers found in PubMed for SETBP1 was: 69
##  Number of papers found in PubMed for TET2 was: 592
##     ### Performing queries for all the literature
##  Number of papers found in PubMed for ASXL1 was: 361
##  Number of papers found in PubMed for IDH1 was: 1705
##  Number of papers found in PubMed for IDH2 was: 847
```

```
## Warning in file(file, "r"): cannot open URL
## 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=SETBP1[All+Fields](0001/01/01[PDAT]+:+2016/03/01[PDAT])&retmax=3000000&rettype=FASTA&tool=OncoScore':
## HTTP status was '429 Unknown Error'
```

```
##  Number of papers found in PubMed for SETBP1 was: 91
##  Number of papers found in PubMed for TET2 was: 751
```

We now compute a score for each of the genes, to estimate their oncogenic
potential at specified time points.

```
result.timeseries = compute.oncoscore.timeseries(query.timepoints)
```

```
## ### Computing oncoscore for timepoint 2012/03/01
## ### Processing data
## ### Computing frequencies scores
## ### Estimating oncogenes
## ### Results:
##   ASXL1 -> 79.24251
##   IDH1 -> 67.85072
##   IDH2 -> 60.79034
##   SETBP1 -> 36.05285
##   TET2 -> 74.82026
## ### Computing oncoscore for timepoint 2013/03/01
## ### Processing data
## ### Computing frequencies scores
## ### Estimating oncogenes
## ### Results:
##   ASXL1 -> 77.6234
##   IDH1 -> 74.22432
##   IDH2 -> 68.12016
##   SETBP1 -> 46.11731
##   TET2 -> 73.86744
## ### Computing oncoscore for timepoint 2014/03/01
## ### Processing data
## ### Computing frequencies scores
## ### Estimating oncogenes
## ### Results:
##   ASXL1 -> 78.38488
##   IDH1 -> 77.41784
##   IDH2 -> 71.59791
##   SETBP1 -> 63.90384
##   TET2 -> 70.91674
## ### Computing oncoscore for timepoint 2015/03/01
## ### Processing data
## ### Computing frequencies scores
## ### Estimating oncogenes
## ### Results:
##   ASXL1 -> 78.92304
##   IDH1 -> 80.19158
##   IDH2 -> 74.26519
##   SETBP1 -> 63.90861
##   TET2 -> 70.4855
## ### Computing oncoscore for timepoint 2016/03/01
## ### Processing data
## ### Computing frequencies scores
## ### Estimating oncogenes
## ### Results:
##   ASXL1 -> 79.43104
##   IDH1 -> 81.69642
##   IDH2 -> 76.26603
##   SETBP1 -> 64.17289
##   TET2 -> 70.57627
```

We next plot the scores measuring the oncogenetic potential of the considered genes as
a barplot.

```
plot.oncoscore(result, col = 'darkblue')
```

![Oncogenetic potential of the considered genes.](data:image/png;base64...)

Figure 1: Oncogenetic potential of the considered genes

We finally plot the trend of the scores over the considered times as
absolute and values and as variations.

```
plot.oncoscore.timeseries(result.timeseries)
```

![Absolute values of the oncogenetic potential of the considered genes over times.](data:image/png;base64...)

Figure 2: Absolute values of the oncogenetic potential of the considered genes over times

```
plot.oncoscore.timeseries(result.timeseries, incremental = TRUE, ylab='absolute variation')
```

![Variations of the oncogenetic potential of the considered genes over times.](data:image/png;base64...)

Figure 3: Variations of the oncogenetic potential of the considered genes over times

```
plot.oncoscore.timeseries(result.timeseries, incremental = TRUE, relative = TRUE, ylab='relative variation')
```

![Variations as relative values of the oncogenetic potential of the considered genes over times.](data:image/png;base64...)

Figure 4: Variations as relative values of the oncogenetic potential of the considered genes over times