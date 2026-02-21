# Provide PathbankDb databases for AnnotationHub

Kozo Nishida

#### 19 April 2021

#### Package

AHPathbankDbs 0.99.5

# 1 Fetch PathBank databases from `AnnotationHub`

The `AHPathbankDbs` package provides the metadata for all PathBank tibble
databases in *[AnnotationHub](https://bioconductor.org/packages/3.13/AnnotationHub)*. First we load/update the
`AnnotationHub` resource.

```
library(AnnotationHub)
ah <- AnnotationHub()
```

Next we list all PathBank entries from `AnnotationHub`.

```
query(ah, "pathbank")
```

```
## AnnotationHub with 20 records
## # snapshotDate(): 2021-04-15
## # $dataprovider: PathBank
## # $species: Saccharomyces cerevisiae, Rattus norvegicus, Pseudomonas aerugin...
## # $rdataclass: Tibble
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH87067"]]'
##
##             title
##   AH87067 | pathbank_Homo_sapiens_metabolites.rda
##   AH87068 | pathbank_Escherichia_coli_metabolites.rda
##   AH87069 | pathbank_Mus_musculus_metabolites.rda
##   AH87070 | pathbank_Arabidopsis_thaliana_metabolites.rda
##   AH87071 | pathbank_Saccharomyces_cerevisiae_metabolites.rda
##   ...       ...
##   AH87082 | pathbank_Bos_taurus_proteins.rda
##   AH87083 | pathbank_Caenorhabditis_elegans_proteins.rda
##   AH87084 | pathbank_Rattus_norvegicus_proteins.rda
##   AH87085 | pathbank_Drosophila_melanogaster_proteins.rda
##   AH87086 | pathbank_Pseudomonas_aeruginosa_proteins.rda
```

We can confirm the metadata in AnnotationHub in Bioconductor S3 bucket
with `mcols()`.

```
mcols(query(ah, "pathbank"))
```

```
## DataFrame with 20 rows and 15 columns
##                          title dataprovider                species taxonomyid
##                    <character>  <character>            <character>  <integer>
## AH87067 pathbank_Homo_sapien..     PathBank           Homo sapiens       9606
## AH87068 pathbank_Escherichia..     PathBank       Escherichia coli        562
## AH87069 pathbank_Mus_musculu..     PathBank           Mus musculus      10090
## AH87070 pathbank_Arabidopsis..     PathBank   Arabidopsis thaliana       3702
## AH87071 pathbank_Saccharomyc..     PathBank Saccharomyces cerevi..       4932
## ...                        ...          ...                    ...        ...
## AH87082 pathbank_Bos_taurus_..     PathBank             Bos taurus       9913
## AH87083 pathbank_Caenorhabdi..     PathBank Caenorhabditis elegans       6239
## AH87084 pathbank_Rattus_norv..     PathBank      Rattus norvegicus      10116
## AH87085 pathbank_Drosophila_..     PathBank Drosophila melanogas..       7227
## AH87086 pathbank_Pseudomonas..     PathBank Pseudomonas aeruginosa        287
##              genome            description coordinate_1_based
##         <character>            <character>          <integer>
## AH87067          NA Metabolite names lin..                  1
## AH87068          NA Metabolite names lin..                  1
## AH87069          NA Metabolite names lin..                  1
## AH87070          NA Metabolite names lin..                  1
## AH87071          NA Metabolite names lin..                  1
## ...             ...                    ...                ...
## AH87082          NA Protein names linked..                  1
## AH87083          NA Protein names linked..                  1
## AH87084          NA Protein names linked..                  1
## AH87085          NA Protein names linked..                  1
## AH87086          NA Protein names linked..                  1
##                     maintainer rdatadateadded preparerclass
##                    <character>    <character>   <character>
## AH87067 Kozo Nishida <kozo.n..     2020-12-16 AHPathbankDbs
## AH87068 Kozo Nishida <kozo.n..     2020-12-16 AHPathbankDbs
## AH87069 Kozo Nishida <kozo.n..     2020-12-16 AHPathbankDbs
## AH87070 Kozo Nishida <kozo.n..     2020-12-16 AHPathbankDbs
## AH87071 Kozo Nishida <kozo.n..     2020-12-16 AHPathbankDbs
## ...                        ...            ...           ...
## AH87082 Kozo Nishida <kozo.n..     2020-12-16 AHPathbankDbs
## AH87083 Kozo Nishida <kozo.n..     2020-12-16 AHPathbankDbs
## AH87084 Kozo Nishida <kozo.n..     2020-12-16 AHPathbankDbs
## AH87085 Kozo Nishida <kozo.n..     2020-12-16 AHPathbankDbs
## AH87086 Kozo Nishida <kozo.n..     2020-12-16 AHPathbankDbs
##                                tags  rdataclass              rdatapath
##                              <list> <character>            <character>
## AH87067 AHPathbankDbs,CAS,ChEBI,...      Tibble AHPathbankDbs/pathba..
## AH87068 AHPathbankDbs,CAS,ChEBI,...      Tibble AHPathbankDbs/pathba..
## AH87069 AHPathbankDbs,CAS,ChEBI,...      Tibble AHPathbankDbs/pathba..
## AH87070 AHPathbankDbs,CAS,ChEBI,...      Tibble AHPathbankDbs/pathba..
## AH87071 AHPathbankDbs,CAS,ChEBI,...      Tibble AHPathbankDbs/pathba..
## ...                             ...         ...                    ...
## AH87082 AHPathbankDbs,CAS,ChEBI,...      Tibble AHPathbankDbs/pathba..
## AH87083 AHPathbankDbs,CAS,ChEBI,...      Tibble AHPathbankDbs/pathba..
## AH87084 AHPathbankDbs,CAS,ChEBI,...      Tibble AHPathbankDbs/pathba..
## AH87085 AHPathbankDbs,CAS,ChEBI,...      Tibble AHPathbankDbs/pathba..
## AH87086 AHPathbankDbs,CAS,ChEBI,...      Tibble AHPathbankDbs/pathba..
##                      sourceurl  sourcetype
##                    <character> <character>
## AH87067 https://pathbank.org..         CSV
## AH87068 https://pathbank.org..         CSV
## AH87069 https://pathbank.org..         CSV
## AH87070 https://pathbank.org..         CSV
## AH87071 https://pathbank.org..         CSV
## ...                        ...         ...
## AH87082 https://pathbank.org..         CSV
## AH87083 https://pathbank.org..         CSV
## AH87084 https://pathbank.org..         CSV
## AH87085 https://pathbank.org..         CSV
## AH87086 https://pathbank.org..         CSV
```

We query only the PathBank tibble for species *Escherichia coli*.

```
qr <- query(ah, c("pathbank", "Escherichia coli"))
qr
```

```
## AnnotationHub with 2 records
## # snapshotDate(): 2021-04-15
## # $dataprovider: PathBank
## # $species: Escherichia coli
## # $rdataclass: Tibble
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH87068"]]'
##
##             title
##   AH87068 | pathbank_Escherichia_coli_metabolites.rda
##   AH87078 | pathbank_Escherichia_coli_proteins.rda
```

There are two types of tibble in the result, metabolites and proteins.
Let’s get a tibble of metabolites here.

```
ecolitbl <- qr[[1]]
```

```
## loading from cache
```

```
ecolitbl
```

```
## # A tibble: 26,765 x 16
##    `PathBank ID` `Pathway Name`       `Pathway Subjec… Species   `Metabolite ID`
##    <chr>         <chr>                <chr>            <chr>     <chr>
##  1 SMP0000774    2,3-Dihydroxybenzoa… Metabolic        Escheric… PW_C007748
##  2 SMP0000774    2,3-Dihydroxybenzoa… Metabolic        Escheric… PW_C040741
##  3 SMP0000774    2,3-Dihydroxybenzoa… Metabolic        Escheric… PW_C040770
##  4 SMP0000774    2,3-Dihydroxybenzoa… Metabolic        Escheric… PW_C000296
##  5 SMP0000774    2,3-Dihydroxybenzoa… Metabolic        Escheric… PW_C001051
##  6 SMP0000774    2,3-Dihydroxybenzoa… Metabolic        Escheric… PW_C001065
##  7 SMP0000774    2,3-Dihydroxybenzoa… Metabolic        Escheric… PW_C040034
##  8 SMP0000774    2,3-Dihydroxybenzoa… Metabolic        Escheric… PW_C041249
##  9 SMP0000774    2,3-Dihydroxybenzoa… Metabolic        Escheric… PW_C000721
## 10 SMP0000774    2,3-Dihydroxybenzoa… Metabolic        Escheric… PW_C001144
## # … with 26,755 more rows, and 11 more variables: Metabolite Name <chr>,
## #   HMDB ID <chr>, KEGG ID <chr>, ChEBI ID <chr>, DrugBank ID <chr>, CAS <chr>,
## #   Formula <chr>, IUPAC <chr>, SMILES <chr>, InChI <chr>, InChI Key <chr>
```

Each row shows information for one metabolite.
This tibble indicates which pathway of PathBank has those metabolites.
Each metabolite has a the name, HMDB ID, KEGG ID, ChEBI ID, DrugBank ID, CAS,
Formula, IUPAC, SMILES, InChi, and InChI Key as well as the pathway information
to which it belongs.

To get the metabolites defined for *TCA Cycle* we can call.

```
ecolitbl[ecolitbl$`Pathway Name`=="TCA Cycle", ]
```

```
## # A tibble: 30 x 16
##    `PathBank ID` `Pathway Name` `Pathway Subject` Species        `Metabolite ID`
##    <chr>         <chr>          <chr>             <chr>          <chr>
##  1 SMP0000802    TCA Cycle      Metabolic         Escherichia c… PW_C001420
##  2 SMP0000802    TCA Cycle      Metabolic         Escherichia c… PW_C000940
##  3 SMP0000802    TCA Cycle      Metabolic         Escherichia c… PW_C000063
##  4 SMP0000802    TCA Cycle      Metabolic         Escherichia c… PW_C001099
##  5 SMP0000802    TCA Cycle      Metabolic         Escherichia c… PW_C040034
##  6 SMP0000802    TCA Cycle      Metabolic         Escherichia c… PW_C000051
##  7 SMP0000802    TCA Cycle      Metabolic         Escherichia c… PW_C001246
##  8 SMP0000802    TCA Cycle      Metabolic         Escherichia c… PW_C000143
##  9 SMP0000802    TCA Cycle      Metabolic         Escherichia c… PW_C001316
## 10 SMP0000802    TCA Cycle      Metabolic         Escherichia c… PW_C000146
## # … with 20 more rows, and 11 more variables: Metabolite Name <chr>,
## #   HMDB ID <chr>, KEGG ID <chr>, ChEBI ID <chr>, DrugBank ID <chr>, CAS <chr>,
## #   Formula <chr>, IUPAC <chr>, SMILES <chr>, InChI <chr>, InChI Key <chr>
```

# 2 Creating PathBank tibbles

This section describes the automated way to create PathBank tibble databases
using [PathBank pathways CSV](https://pathbank.org/downloads).

## 2.1 Creating PathBank tibble databases

To create the databases we use the `createPathbankMetabolitesDb` and
`createPathbankProteinsDb` functions. These function downloads the “Metabolite
names linked to PathBank pathways CSV” and “Protein names linked to PathBank
pathways CSV”. Then, those CSVs are divided into tables for each species
and tibbleed.

These functions have no parameters.
In other words, it does not have the function of making tibble only for a
specific species, but makes tibble for all species in PathBank CSV.

```
library(AHPathbankDbs)
scr <- system.file("scripts/make-data.R", package = "AHPathBankDbs")
source(scr)
createPathbankMetabolitesDb()
createPathbankProteinsDb()
```

The each tibble is stored in the rda file and saved in the current working
directory.