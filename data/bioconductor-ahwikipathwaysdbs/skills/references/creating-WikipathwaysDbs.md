# Provide WikipathwaysDb databases for AnnotationHub

Kozo Nishida

#### 11 May 2021

#### Package

AHWikipathwaysDbs 0.99.4

# 1 Fetch Wikipathways databases from `AnnotationHub`

The `AHWikipathwaysDbs` package provides the metadata for all Wikipathways
tibble databases in *[AnnotationHub](https://bioconductor.org/packages/3.13/AnnotationHub)*. First we load/update the
`AnnotationHub` resource.

```
library(AnnotationHub)
ah <- AnnotationHub()
```

Next we list all Wikipathways entries from `AnnotationHub`.

```
query(ah, "wikipathways")
```

```
## AnnotationHub with 25 records
## # snapshotDate(): 2021-05-06
## # $dataprovider: WikiPathways
## # $species: Zea mays, Sus scrofa, Solanum lycopersicum, Saccharomyces cerevi...
## # $rdataclass: Tibble
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH91793"]]'
##
##             title
##   AH91793 | wikipathways_Anopheles_gambiae_metabolites.rda
##   AH91794 | wikipathways_Arabidopsis_thaliana_metabolites.rda
##   AH91795 | wikipathways_Bacillus_subtilis_metabolites.rda
##   AH91796 | wikipathways_Bos_taurus_metabolites.rda
##   AH91797 | wikipathways_Caenorhabditis_elegans_metabolites.rda
##   ...       ...
##   AH91813 | wikipathways_Rattus_norvegicus_metabolites.rda
##   AH91814 | wikipathways_Saccharomyces_cerevisiae_metabolites.rda
##   AH91815 | wikipathways_Solanum_lycopersicum_metabolites.rda
##   AH91816 | wikipathways_Sus_scrofa_metabolites.rda
##   AH91817 | wikipathways_Zea_mays_metabolites.rda
```

We can confirm the metadata in AnnotationHub in Bioconductor S3 bucket
with `mcols()`.

```
mcols(query(ah, "wikipathways"))
```

```
## DataFrame with 25 rows and 15 columns
##                          title dataprovider                species taxonomyid
##                    <character>  <character>            <character>  <integer>
## AH91793 wikipathways_Anophel.. WikiPathways      Anopheles gambiae       7165
## AH91794 wikipathways_Arabido.. WikiPathways   Arabidopsis thaliana       3702
## AH91795 wikipathways_Bacillu.. WikiPathways      Bacillus subtilis       1423
## AH91796 wikipathways_Bos_tau.. WikiPathways             Bos taurus       9913
## AH91797 wikipathways_Caenorh.. WikiPathways Caenorhabditis elegans       6239
## ...                        ...          ...                    ...        ...
## AH91813 wikipathways_Rattus_.. WikiPathways      Rattus norvegicus      10116
## AH91814 wikipathways_Sacchar.. WikiPathways Saccharomyces cerevi..       4932
## AH91815 wikipathways_Solanum.. WikiPathways   Solanum lycopersicum       4081
## AH91816 wikipathways_Sus_scr.. WikiPathways             Sus scrofa       9823
## AH91817 wikipathways_Zea_may.. WikiPathways               Zea mays       4577
##              genome            description coordinate_1_based
##         <character>            <character>          <integer>
## AH91793          NA Metabolite names lin..                  1
## AH91794          NA Metabolite names lin..                  1
## AH91795          NA Metabolite names lin..                  1
## AH91796          NA Metabolite names lin..                  1
## AH91797          NA Metabolite names lin..                  1
## ...             ...                    ...                ...
## AH91813          NA Metabolite names lin..                  1
## AH91814          NA Metabolite names lin..                  1
## AH91815          NA Metabolite names lin..                  1
## AH91816          NA Metabolite names lin..                  1
## AH91817          NA Metabolite names lin..                  1
##                     maintainer rdatadateadded     preparerclass
##                    <character>    <character>       <character>
## AH91793 Kozo Nishida <kozo.n..     2021-05-04 AHWikipathwaysDbs
## AH91794 Kozo Nishida <kozo.n..     2021-05-04 AHWikipathwaysDbs
## AH91795 Kozo Nishida <kozo.n..     2021-05-04 AHWikipathwaysDbs
## AH91796 Kozo Nishida <kozo.n..     2021-05-04 AHWikipathwaysDbs
## AH91797 Kozo Nishida <kozo.n..     2021-05-04 AHWikipathwaysDbs
## ...                        ...            ...               ...
## AH91813 Kozo Nishida <kozo.n..     2021-05-04 AHWikipathwaysDbs
## AH91814 Kozo Nishida <kozo.n..     2021-05-04 AHWikipathwaysDbs
## AH91815 Kozo Nishida <kozo.n..     2021-05-04 AHWikipathwaysDbs
## AH91816 Kozo Nishida <kozo.n..     2021-05-04 AHWikipathwaysDbs
## AH91817 Kozo Nishida <kozo.n..     2021-05-04 AHWikipathwaysDbs
##                             tags  rdataclass              rdatapath
##                           <list> <character>            <character>
## AH91793 CAS,ChEBI,ChemSpider,...      Tibble AHWikipathwaysDbs/wi..
## AH91794 CAS,ChEBI,ChemSpider,...      Tibble AHWikipathwaysDbs/wi..
## AH91795 CAS,ChEBI,ChemSpider,...      Tibble AHWikipathwaysDbs/wi..
## AH91796 CAS,ChEBI,ChemSpider,...      Tibble AHWikipathwaysDbs/wi..
## AH91797 CAS,ChEBI,ChemSpider,...      Tibble AHWikipathwaysDbs/wi..
## ...                          ...         ...                    ...
## AH91813 CAS,ChEBI,ChemSpider,...      Tibble AHWikipathwaysDbs/wi..
## AH91814 CAS,ChEBI,ChemSpider,...      Tibble AHWikipathwaysDbs/wi..
## AH91815 CAS,ChEBI,ChemSpider,...      Tibble AHWikipathwaysDbs/wi..
## AH91816 CAS,ChEBI,ChemSpider,...      Tibble AHWikipathwaysDbs/wi..
## AH91817 CAS,ChEBI,ChemSpider,...      Tibble AHWikipathwaysDbs/wi..
##                      sourceurl  sourcetype
##                    <character> <character>
## AH91793 https://www.wikipath..         XML
## AH91794 https://www.wikipath..         XML
## AH91795 https://www.wikipath..         XML
## AH91796 https://www.wikipath..         XML
## AH91797 https://www.wikipath..         XML
## ...                        ...         ...
## AH91813 https://www.wikipath..         XML
## AH91814 https://www.wikipath..         XML
## AH91815 https://www.wikipath..         XML
## AH91816 https://www.wikipath..         XML
## AH91817 https://www.wikipath..         XML
```

We query only the Wikipathways tibble for species *Homo sapiens*.

```
qr <- query(ah, c("wikipathways", "Homo sapiens"))
qr
```

```
## AnnotationHub with 1 record
## # snapshotDate(): 2021-05-06
## # names(): AH91805
## # $dataprovider: WikiPathways
## # $species: Homo sapiens
## # $rdataclass: Tibble
## # $rdatadateadded: 2021-05-04
## # $title: wikipathways_Homo_sapiens_metabolites.rda
## # $description: Metabolite names linked to Wikipathways Homo sapiens pathway...
## # $taxonomyid: 9606
## # $genome: NA
## # $sourcetype: XML
## # $sourceurl: https://www.wikipathways.org/index.php/Download_Pathways
## # $sourcesize: NA
## # $tags: c("CAS", "ChEBI", "ChemSpider", "CustomDBSchema", "Drugbank",
## #   "FunctionalAnnotation", "HMDB", "KEGG", "metabolites", "Pathways")
## # retrieve record with 'object[["AH91805"]]'
```

There are a tibble in the result.
Let’s get a tibble of it here.

```
hsatbl <- qr[[1]]
```

```
## loading from cache
```

```
hsatbl
```

```
## # A tibble: 5,085 x 14
##    wpid  wpid_version pathway_name   metabolite_name   HMDB_ID  KEGG_ID ChEBI_ID
##    <chr> <chr>        <chr>          <chr>             <chr>    <chr>   <chr>
##  1 WP100 107114       Glutathione m… g-L-Glutamyl-L-c… "HMDB00… C00669  17515
##  2 WP100 107114       Glutathione m… L-Cysteine        "HMDB00… C00097  CHEBI:3…
##  3 WP100 107114       Glutathione m… Cysteinyl-glycine "HMDB00… C01419  4047
##  4 WP100 107114       Glutathione m… Glycine           "HMDB00… C00037  CHEBI:1…
##  5 WP100 107114       Glutathione m… 5-Oxoproline      "HMDB00… C01879  CHEBI:1…
##  6 WP100 107114       Glutathione m… L-Glutamate       "HMDB00… C00025  CHEBI:1…
##  7 WP100 107114       Glutathione m… NADPH             "HMDB00… C00005  CHEBI:1…
##  8 WP100 107114       Glutathione m… (5-L-Glutamyl)-L… "HMDB06… C03740  50619
##  9 WP100 107114       Glutathione m… R-S-Mercapturona… ""       C05727  CHEBI:4…
## 10 WP100 107114       Glutathione m… L-Amino acid      ""       C00151  CHEBI:1…
## # … with 5,075 more rows, and 7 more variables: DrugBank_ID <chr>,
## #   PubChem_CID <chr>, ChemSpider_ID <chr>, KNApSAcK_ID <chr>,
## #   Wikidata_ID <chr>, CAS <chr>, InChI_Key <chr>
```

Each row shows information for one metabolite.
This tibble indicates which pathway of Wikipathways has those metabolites.
Each metabolite has a the name, HMDB\_ID, KEGG\_ID, ChEBI\_ID, DrugBank\_ID,
PubChem\_CID, ChemSpider\_ID, KNApSAcK\_ID, Wikidata\_ID, CAS and InChI Key
as well as the pathway information to which it belongs.

To get the metabolites defined for *Amino Acid metabolism* we can call.

```
hsatbl[hsatbl$`pathway_name`=="Amino Acid metabolism", ]
```

```
## # A tibble: 108 x 14
##    wpid   wpid_version pathway_name    metabolite_name HMDB_ID  KEGG_ID ChEBI_ID
##    <chr>  <chr>        <chr>           <chr>           <chr>    <chr>   <chr>
##  1 WP3925 115752       Amino Acid met… Ethanol         HMDB000… C00469  16236
##  2 WP3925 115752       Amino Acid met… Methionine      HMDB000… C00073  16643
##  3 WP3925 115752       Amino Acid met… Indoleacetate   HMDB000… C00954  16411
##  4 WP3925 115752       Amino Acid met… Aconitate       HMDB000… C00417  32805
##  5 WP3925 115752       Amino Acid met… Oxaloacetate    HMDB000… C00036  30744
##  6 WP3925 115752       Amino Acid met… Aspartate       HMDB000… C00049  CHEBI:1…
##  7 WP3925 115752       Amino Acid met… Leucine         HMDB000… C00123  CHEBI:1…
##  8 WP3925 115752       Amino Acid met… Urea            HMDB000… C00086  CHEBI:1…
##  9 WP3925 115752       Amino Acid met… Fumarate        HMDB000… C00122  CHEBI:1…
## 10 WP3925 115752       Amino Acid met… isocitrate      HMDB000… C00311  30887
## # … with 98 more rows, and 7 more variables: DrugBank_ID <chr>,
## #   PubChem_CID <chr>, ChemSpider_ID <chr>, KNApSAcK_ID <chr>,
## #   Wikidata_ID <chr>, CAS <chr>, InChI_Key <chr>
```

# 2 Creating Wikipathways tibbles

This section describes the automated way to create Wikipathways
tibble databases using
[GPML XML files](https://wikipathways-data.wmcloud.org/20210410/gpml/).

## 2.1 Creating Wikipathways tibble databases

To create the databases we use the `createWikipathwaysMetabolitesDb` function.
This function downloads the zip archive of “Wikipathways GPML” XML files.
Then, those XMLs are integrated into a table for each species and tibbleed.

The function has no parameters.
In other words, it does not have the function of making tibble only for a
specific species, but makes tibble for all species in Wikipathways.

```
library(AHWikipathwaysDbs)
scr <- system.file("scripts/make-data.R", package = "AHWikipathwaysDbs")
source(scr)
createWikipathwaysMetabolitesDb()
```

The tibble is stored in the rda file and saved in the current working
directory.