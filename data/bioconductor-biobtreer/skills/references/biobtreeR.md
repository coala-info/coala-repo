# The biobtreeR users guide

Tamer Gür

#### 29 October 2025

#### Package

biobtreeR 1.22.0

# 1 Introduction

The biobtreeR package provides an interface to [biobtree](https://github.com/tamerh/biobtree) tool which allows mapping the bioinformatics datasets via identifiers and special keywors with simple or advance chain query capability.

# 2 Getting started

```
library(biobtreeR)

# Create an folder and set as an output directory
# It is used for database and configuration files

# temporary directory is used for demonstration purpose
bbUseOutDir(tempdir())
```

```
## [1] 0
```

## 2.1 Build database

For mapping queries, biobtreeR use a database which stored in local storage. Database can be built 2 ways, first way is to retrieve pre built database. These database consist of commonly studied datasets and model organism and updated regularly following the major uniprot and ensembl data releases.

```
# Called once and saves the built in database to local disk

# Included datasets hgnc,hmdb,taxonomy,go,efo,eco,chebi,interpro
# Included uniprot proteins and ensembl genomes belongs to following organisms:
# homo_sapiens, danio_rerio(zebrafish), gallus_gallus(chicken), mus_musculus, Rattus norvegicus, saccharomyces_cerevisiae,
# arabidopsis_thaliana, drosophila_melanogaster, caenorhabditis_elegans, Escherichia coli, Escherichia coli str. K-12 substr. MG1655, Escherichia coli K-12

# Requires ~ 6 GB free storage
bbBuiltInDB()
```

For the genomes which are not included in the pre built database can be built in local computer. All the ensembl and ensembl genomes organisms are supported.
List of these genomes and their taxonomy identifiers can be seen from ensembl websites [1](https://www.ensembl.org/info/about/species.html),[2](http://bacteria.ensembl.org/species.html),[3](http://fungi.ensembl.org/species.html),[4](http://plants.ensembl.org/species.html),[5](http://protists.ensembl.org/index.html),[6](http://metazoa.ensembl.org/species.html),

```
# multiple species genomes supported with comma seperated taxonomy identifiers
bbBuildCustomDB(taxonomyIDs = "1408103,206403")
```

## 2.2 Start web server

Once database is retrieved or built to local disk queries are performed via lightweight local server. Local server provide web interface for data expoloration in addition to the R functions for performing queries for R pipelines. Local server runs as a background process so both web interface and R functions can be used at the same time once it is started. While web server running web interface can be accessed via address <http://localhost:8888/ui>

```
 bbStart()
```

```
## [1] "/tmp/RtmphOonYi"
## [1] "Starting biobtree..."
```

```
## [1] "biobtreeR started"
```

## 2.3 Search identifiers and keywords

Searching dataset identfiers and keywords such as gene name or accessions is performed with bbSearch function by passing comma seperated terms.

```
bbSearch("tpi1,vav_human,ENST00000297261")
```

```
##             input         identifier    dataset mapping_count
## 1            TPI1    ENSG00000111669    ensembl            64
## 2            TPI1 ENSGALG00010023392    ensembl            33
## 3            TPI1 ENSMUSG00000023456    ensembl            49
## 4            TPI1 ENSRNOG00000015290    ensembl            59
## 5            TPI1         HGNC:12009       hgnc             8
## 6       VAV_HUMAN             P15498    uniprot           281
## 7 ENST00000297261    ENST00000297261 transcript           301
```

If source parameter is passed search performed within the dataset.

```
bbSearch("tpi1,ENSG00000164690","ensembl")
```

```
##             input         identifier dataset mapping_count
## 1            TPI1    ENSG00000111669 ensembl            64
## 2            TPI1 ENSGALG00010023392 ensembl            33
## 3            TPI1 ENSMUSG00000023456 ensembl            49
## 4            TPI1 ENSRNOG00000015290 ensembl            59
## 5 ENSG00000164690    ENSG00000164690 ensembl           286
```

Search results url is retrieved with

```
bbSearch("tpi1,vav_human,ENST00000297261",showURL =TRUE)
```

```
##             input         identifier    dataset mapping_count
## 1            TPI1    ENSG00000111669    ensembl            64
## 2            TPI1 ENSGALG00010023392    ensembl            33
## 3            TPI1 ENSMUSG00000023456    ensembl            49
## 4            TPI1 ENSRNOG00000015290    ensembl            59
## 5            TPI1         HGNC:12009       hgnc             8
## 6       VAV_HUMAN             P15498    uniprot           281
## 7 ENST00000297261    ENST00000297261 transcript           301
##                                                                                   url
## 1         https://www.ensembl.org/homo_sapiens/Gene/Summary?db=core;g=ENSG00000111669
## 2     https://www.ensembl.org/gallus_gallus/Gene/Summary?db=core;g=ENSGALG00010023392
## 3      https://www.ensembl.org/mus_musculus/Gene/Summary?db=core;g=ENSMUSG00000023456
## 4 https://www.ensembl.org/rattus_norvegicus/Gene/Summary?db=core;g=ENSRNOG00000015290
## 5             https://www.genenames.org/data/gene-symbol-report/#!/hgnc_id/HGNC:12009
## 6                                                    //www.uniprot.org/uniprot/P15498
## 7                                                                                   #
```

## 2.4 Chain mapping and filtering

Mapping and filtering queries are performed via bibobtree’s mapping query syntax which allowed chain mapping and filtering capability from identifiers to target identifiers or attributes. Mapping query syntax consist of single or multiple mapping queries in the format `map(dataset_id).filter(Boolean query expression).map(...).filter(...)...` and allow performing chain mapping among datasets. For mapping queries bbMapping function is used, for instance in following example, maps protein to its go terms and in the second query mapping has been done with filter.

```
bbMapping("AT5G3_HUMAN",'map(go)',attrs = "type")
```

```
##   mapping_id               type
## 1 GO:0000276 cellular_component
## 2 GO:0005741 cellular_component
## 3 GO:0005743 cellular_component
## 4 GO:0005753 cellular_component
## 5 GO:0008289 molecular_function
## 6 GO:0015078 molecular_function
## 7 GO:0015986 biological_process
## 8 GO:0016021 cellular_component
## 9 GO:0045263 cellular_component
```

```
bbMapping("AT5G3_HUMAN",'map(go).filter(go.type=="biological_process")',attrs = "type")
```

```
##   mapping_id               type
## 1 GO:0015986 biological_process
```

In the example for the first parameter single protein accession has been used but similar with bbSearch functions multiple identifers or keywords can be used. In the last query type attribute was used to filter mapping only with biological process go terms. Dataset attributes are used in the filters starts with their dataset name as in the above example it starts with `go.`

In order use in filter expressions, each datasets attributes lists with `bbListAttrs`function via sample identifier. For instance following query shows gene ontology attributes.

```
bbListAttrs("go")
```

```
## [1] "type"       "name"       "[]synonyms"
```

```
bbListAttrs("uniprot")
```

```
## [1] "[]accessions"        "[]genes"             "[]names"
## [4] "[]alternative_names" "[]submitted_names"   "sequence.seq"
## [7] "sequence.mass"       "reviewed"
```

# 3 Example Use cases

In this section biobtreeR functionalities will be discussed in detail via gene and protein centric example use cases. For live demo of web interface including these use cases with additional chemistry centric use cases can be accessed via <https://www.ebi.ac.uk/~tgur/biobtree/>

## 3.1 Gene centric use cases

Ensembl, Ensembl Genomes and HGNC datasets are used for gene related data. One of the most common gene related dataset identfiers are `ensembl`,`hgnc`,`transcript`,`exon`. Let’s start with listing their attiributes,

```
bbListAttrs("hgnc")
```

```
## [1] "[]names"        "[]symbols"      "locus_group"    "[]aliases"
## [5] "locus_type"     "[]prev_names"   "[]prev_symbols" "status"
## [9] "[]gene_groups"
```

```
bbListAttrs("ensembl")
```

```
## [1] "name"        "description" "start"       "end"         "biotype"
## [6] "genome"      "strand"      "seq_region"  "branch"
```

```
bbListAttrs("transcript")
```

```
##  [1] "name"       "start"      "end"        "biotype"    "strand"
##  [6] "seq_region" "utr5Start"  "utr5End"    "utr3Start"  "utr3End"
## [11] "source"
```

```
bbListAttrs("exon")
```

```
## [1] "start"      "end"        "strand"     "seq_region"
```

```
bbListAttrs("cds")
```

```
## [1] "start"      "end"        "strand"     "seq_region" "frame"
```

Note that there are several other gene related datasets without attributes and can be used in mapping queries such as probesets, genebank and entrez etc. Full dataset list can be discovered with `bbListDatasets`. Now lets build example mapping queries,

**Map gene names to Ensembl transcript identifiers**

```
res<-bbMapping("ATP5MC3,TP53",'map(transcript)')
head(res)
```

```
##                        input input_dataset         mapping_id
## 1    ATP5MC3-ENSG00000154518       ensembl    ENST00000284727
## 2                          -             -    ENST00000392541
## 3                          -             -    ENST00000409194
## 4                          -             -    ENST00000472782
## 5                          -             -    ENST00000497075
## 6 ATP5MC3-ENSRNOG00000001596       ensembl ENSRNOT00000058234
```

**Map gene names to exon identifiers and retrieve the region**

```
res<-bbMapping("ATP5MC3,TP53",'map(transcript).map(exon)',attrs = "seq_region")
head(res)
```

```
##                     input input_dataset      mapping_id seq_region
## 1 ATP5MC3-ENSG00000154518       ensembl ENSE00001016410          2
## 2                       -             - ENSE00001016412          2
## 3                       -             - ENSE00001588911          2
## 4                       -             - ENSE00003574305          2
## 5                       -             - ENSE00003602002          2
## 6                       -             - ENSE00001512331          2
```

**Map human gene to its ortholog identifiers**

```
res<-bbMapping("shh",'filter(ensembl.genome=="homo_sapiens").map(ortholog)')
head(res)
```

```
##           mapping_id
## 1 ENSDARG00000038867
## 2 ENSDARG00000068567
## 3 ENSGALG00010025259
## 4 ENSMUSG00000002633
## 5 ENSRNOG00000006120
## 6     WBGENE00001690
```

**Map gene to its paralogs**

```
bbMapping("fry,mog",'map(paralog)',showInputColumn = TRUE)
```

```
##                     input input_dataset         mapping_id
## 1     FRY-ENSG00000073910       ensembl    ENSG00000075539
## 2  FRY-ENSGALG00010006835       ensembl ENSGALG00010016597
## 3  FRY-ENSMUSG00000056602       ensembl ENSMUSG00000070733
## 4  FRY-ENSRNOG00000000894       ensembl ENSRNOG00000002248
## 5     MOG-ENSG00000204655       ensembl    ENSG00000026950
## 6                       -             -    ENSG00000103855
## 7                       -             -    ENSG00000111801
## 8                       -             -    ENSG00000112763
## 9                       -             -    ENSG00000113303
## 10                      -             -    ENSG00000114455
## 11                      -             -    ENSG00000124508
## 12                      -             -    ENSG00000124557
## 13                      -             -    ENSG00000134258
## 14                      -             -    ENSG00000160223
## 15                      -             -    ENSG00000164010
## 16                      -             -    ENSG00000165810
## 17                      -             -    ENSG00000168903
## 18                      -             -    ENSG00000186470
## 19                      -             -    ENSG00000204290
## 20 MOG-ENSMUSG00000076439       ensembl ENSMUSG00000000706
## 21                      -             - ENSMUSG00000000732
## 22                      -             - ENSMUSG00000020490
## 23                      -             - ENSMUSG00000024340
## 24                      -             - ENSMUSG00000028644
## 25                      -             - ENSMUSG00000034359
## 26                      -             - ENSMUSG00000035914
## 27                      -             - ENSMUSG00000040283
## 28                      -             - ENSMUSG00000049214
## 29                      -             - ENSMUSG00000051076
## 30                      -             - ENSMUSG00000053216
## 31                      -             - ENSMUSG00000055960
## 32                      -             - ENSMUSG00000058435
## 33                      -             - ENSMUSG00000062638
## 34                      -             - ENSMUSG00000070868
## 35                      -             - ENSMUSG00000078598
## 36                      -             - ENSMUSG00000078599
## 37                      -             - ENSMUSG00000087194
## 38                      -             - ENSMUSG00000089773
## 39                      -             - ENSMUSG00000092618
## 40                      -             - ENSMUSG00000108763
## 41 MOG-ENSRNOG00000000775       ensembl ENSRNOG00000000335
## 42                      -             - ENSRNOG00000000446
## 43                      -             - ENSRNOG00000015279
## 44                      -             - ENSRNOG00000017514
## 45                      -             - ENSRNOG00000023109
## 46                      -             - ENSRNOG00000028541
## 47                      -             - ENSRNOG00000033608
## 48                      -             - ENSRNOG00000037680
## 49                      -             - ENSRNOG00000038877
## 50                      -             - ENSRNOG00000039396
## 51                      -             - ENSRNOG00000042047
## 52                      -             - ENSRNOG00000043019
## 53                      -             - ENSRNOG00000043194
## 54                      -             - ENSRNOG00000046377
## 55                      -             - ENSRNOG00000047304
## 56                      -             - ENSRNOG00000052710
## 57                      -             - ENSRNOG00000063827
## 58                      -             - ENSRNOG00000064738
## 59                      -             - ENSRNOG00000067562
## 60                      -             - ENSRNOG00000068088
## 61                      -             - ENSRNOG00000068592
## 62                      -             - ENSRNOG00000068993
```

**Map ensembl identifier or gene name to the entrez identifier**

```
bbMapping("ENSG00000073910,shh" ,'map(entrez)')
```

```
##                    input input_dataset mapping_id
## 1        ENSG00000073910       ensembl      10129
## 2    SHH-ENSG00000164690       ensembl       6469
## 3 SHH-ENSGALG00010025259       ensembl     395615
## 4 SHH-ENSMUSG00000002633       ensembl      20423
## 5 SHH-ENSRNOG00000006120       ensembl      29499
```

**Map refseq identifiers to hgnc identifiers**

```
bbMapping("NM_005359,NM_000546",'map(hgnc)',attrs = "symbols")
```

```
##       input input_dataset mapping_id symbols
## 1 NM_005359        refseq  HGNC:6770   SMAD4
## 2 NM_000546        refseq HGNC:11998    TP53
```

**Get all Ensembl human identifiers and gene names on chromosome Y with lncRNA type**

```
res<-bbMapping("homo_sapiens",'map(ensembl).filter(ensembl.seq_region=="Y" && ensembl.biotype=="lncRNA")',attrs = 'name')
head(res)
```

```
##        mapping_id   name
## 1 ENSG00000129816 TTTY1B
## 2 ENSG00000129845  TTTY1
## 3 ENSG00000131007 TTTY9B
## 4 ENSG00000131538  TTTY6
## 5 ENSG00000131548 TTTY6B
## 6 ENSG00000147753  TTTY7
```

**Get CDS from genes**

```
bbMapping("tpi1,shh",'map(transcript).map(cds)')
```

```
##                      input input_dataset         mapping_id
## 1     TPI1-ENSG00000111669       ensembl    ENSP00000229270
## 2                        -             -    ENSP00000379933
## 3                        -             -    ENSP00000475184
## 4                        -             -    ENSP00000475620
## 5                        -             -    ENSP00000475364
## 6                        -             -    ENSP00000475829
## 7                        -             -    ENSP00000443599
## 8                        -             -    ENSP00000484435
## 9  TPI1-ENSGALG00010023392       ensembl ENSGALP00010034676
## 10 TPI1-ENSMUSG00000023456       ensembl ENSMUSP00000125292
## 11                       -             - ENSMUSP00000130858
## 12                       -             - ENSMUSP00000159368
## 13 TPI1-ENSRNOG00000015290       ensembl ENSRNOP00000020647
## 14                       -             - ENSRNOP00000067409
## 15                       -             - ENSRNOP00000088185
## 16     SHH-ENSG00000164690       ensembl    ENSP00000297261
## 17                       -             -    ENSP00000396621
## 18                       -             -    ENSP00000413871
## 19                       -             -    ENSP00000410546
## 20  SHH-ENSGALG00010025259       ensembl ENSGALP00010038072
## 21                       -             - ENSGALP00010038078
## 22  SHH-ENSMUSG00000002633       ensembl ENSMUSP00000002708
## 23  SHH-ENSRNOG00000006120       ensembl ENSRNOP00000008497
```

**Get all Ensembl human identifiers and gene names within or overlapping range**

```
bbMapping("9606",'map(ensembl).filter((114129278>ensembl.start && 114129278<ensembl.end) || (114129328>ensembl.start && 114129328<ensembl.end))',attrs = "name")
```

```
##        mapping_id      name
## 1 ENSG00000080709     KCNN2
## 2 ENSG00000109906    ZBTB16
## 3 ENSG00000128573     FOXP2
## 4 ENSG00000134207      SYT6
## 5 ENSG00000151577      DRD3
## 6 ENSG00000165813   CCDC186
## 7 ENSG00000185989     RASA3
## 8 ENSG00000228624 HDAC2-AS2
## 9 ENSG00000249853    HS3ST5
```

In the above example as a first parameter taxonomy identifier is used instead of specifying as homo sapiens like in the previous example. Both of these usage are equivalent and produce same output as homo sapiens refer to taxonomy identifer 9606.

**Built in function for genomic range queries**

To simplfy previous use case query 3 builtin range query functions are provided. These functions are `overlaps`, `within` and `covers`. These functions can be used for `ensembl`, `transcript`, `exon` and `cds`
entries which have start and end genome coordinates. For instance previous query can be written following way with `overlaps` function which list all the overlapping genes in human with given range.

```
bbMapping("9606",'map(ensembl).filter(ensembl.overlaps(114129278,114129328))',attrs = "name")
```

```
##        mapping_id      name
## 1 ENSG00000080709     KCNN2
## 2 ENSG00000109906    ZBTB16
## 3 ENSG00000128573     FOXP2
## 4 ENSG00000134207      SYT6
## 5 ENSG00000151577      DRD3
## 6 ENSG00000165813   CCDC186
## 7 ENSG00000185989     RASA3
## 8 ENSG00000228624 HDAC2-AS2
## 9 ENSG00000249853    HS3ST5
```

**Map Affymetrix identifiers to Ensembl identifiers and gene names**

```
bbMapping("202763_at,213596_at,209310_s_at",source ="affy_hg_u133_plus_2" ,'map(transcript).map(ensembl)',attrs = "name")
```

```
##         input       input_dataset      mapping_id  name
## 1   202763_AT affy_hg_u133_plus_2 ENSG00000164305 CASP3
## 2   213596_AT affy_hg_u133_plus_2 ENSG00000196954 CASP4
## 3 209310_S_AT affy_hg_u133_plus_2 ENSG00000196954 CASP4
```

Note that all mappings can be done with opposite way, for instance from gene name to Affymetrix identifiers mapping is performed following way

```
bbMapping("CASP3,CASP4",'map(transcript).map(affy_hg_u133_plus_2)')
```

```
##                   input input_dataset  mapping_id
## 1 CASP3-ENSG00000164305       ensembl   202763_AT
## 2                     -             -   236729_AT
## 3 CASP4-ENSG00000196954       ensembl 209310_S_AT
## 4                     -             -   213596_AT
```

**Retrieve all the human gene names which contains TTY**

```
res<-bbMapping("homo sapiens",'map(ensembl).filter(ensembl.name.contains("TTY"))',attrs = "name")
head(res)
```

```
##        mapping_id   name
## 1 ENSG00000129816 TTTY1B
## 2 ENSG00000129845  TTTY1
## 3 ENSG00000131007 TTTY9B
## 4 ENSG00000131538  TTTY6
## 5 ENSG00000131548 TTTY6B
## 6 ENSG00000136295  TTYH3
```

## 3.2 Protein centric use cases

Uniprot is used for protein related dataset such as protein identifiers, accession, sequence, features, variants, and mapping information to other datasets. Let’s list some protein related datasets attributes and then execute example queries similary with gene centric examples,

```
bbListAttrs("uniprot")
```

```
## [1] "[]accessions"        "[]genes"             "[]names"
## [4] "[]alternative_names" "[]submitted_names"   "sequence.seq"
## [7] "sequence.mass"       "reviewed"
```

```
bbListAttrs("ufeature")
```

```
##  [1] "type"               "description"        "id"
##  [4] "original"           "variation"          "location.begin"
##  [7] "location.end"       "[]evidences.type"   "[]evidences.source"
## [10] "[]evidences.id"
```

```
bbListAttrs("pdb")
```

```
## [1] "method"     "chains"     "resolution"
```

```
bbListAttrs("interpro")
```

```
## [1] "[]names"       "short_name"    "type"          "protein_count"
```

**Map gene names to reviewed uniprot identifiers**

```
bbMapping("msh6,stk11,bmpr1a,smad4,brca2","map(uniprot)",source ="hgnc")
```

```
##              input input_dataset mapping_id
## 1   MSH6-HGNC:7329          hgnc     P52701
## 2 STK11-HGNC:11389          hgnc     Q15831
## 3 BMPR1A-HGNC:1076          hgnc     P36894
## 4  SMAD4-HGNC:6770          hgnc     Q13485
## 5  BRCA2-HGNC:1101          hgnc     P51587
```

**Filter proteins by sequence mass and retrieve protein sequences**

```
bbMapping("clock_human,shh_human,aicda_human,at5g3_human,p53_human","filter(uniprot.sequence.mass > 45000)" ,attrs = "sequence$mass,sequence$seq")
```

```
##                input input_dataset mapping_id sequence$mass
## 1 CLOCK_HUMAN-O15516       uniprot     O15516         95304
## 2   SHH_HUMAN-Q15465       uniprot     Q15465         49607
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     sequence$seq
## 1 MLFTVSCSKMSSIVDRDDSSIFDGLVEEDDKDKAKRVSRNKSEKKRRDQFNVLIKELGSMLPGNARKMDKSTVLQKSIDFLRKHKEITAQSDASEIRQDWKPTFLSNEEFTQLMLEALDGFFLAIMTDGSIIYVSESVTSLLEHLPSDLVDQSIFNFIPEGEHSEVYKILSTHLLESDSLTPEYLKSKNQLEFCCHMLRGTIDPKEPSTYEYVKFIGNFKSLNSVSSSAHNGFEGTIQRTHRPSYEDRVCFVATVRLATPQFIKEMCTVEEPNEEFTSRHSLEWKFLFLDHRAPPIIGYLPFEVLGTSGYDYYHVDDLENLAKCHEHLMQYGKGKSCYYRFLTKGQQWIWLQTHYYITYHQWNSRPEFIVCTHTVVSYAEVRAERRRELGIEESLPETAADKSQDSGSDNRINTVSLKEALERFDHSPTPSASSRSSRKSSHTAVSDPSSTPTKIPTDTSTPPRQHLPAHEKMVQRRSSFSSQSINSQSVGSSLTQPVMSQATNLPIPQGMSQFQFSAQLGAMQHLKDQLEQRTRMIEANIHRQQEELRKIQEQLQMVHGQGLQMFLQQSNPGLNFGSVQLSSGNSSNIQQLAPINMQGQVVPTNQIQSGMNTGHIGTTQHMIQQQTLQSTSTQSQQNVLSGHSQQTSLPSQTQSTLTAPLYNTMVISQPAAGSMVQIPSSMPQNSTQSAAVTTFTQDRQIRFSQGQQLVTKLVTAPVACGAVMVPSTMLMGQVVTAYPTFATQQQQSQTLSVTQQQQQQSSQEQQLTSVQQPSQAQLTQPPQQFLQTSRLLHGNPSTQLILSAAFPLQQSTFPQSHHQQHQSQQQQQLSRHRTDSLPDPSKVQPQ
## 2                                                                                                                                                                                                                                                                                                                                                                                                 MLLLARCLLLVLVSSLLVCSGLACGPGRGFGKRRHPKKLTPLAYKQFIPNVAEKTLGASGRYEGKISRNSERFKELTPNYNPDIIFKDEENTGADRLMTQRCKDKLNALAISVMNQWPGVKLRVTEGWDEDGHHSEESLHYEGRAVDITTSDRDRSKYGMLARLAVEAGFDWVYYESKAHIHCSVKAENSVAAKSGGCFPGSATVHLEQGGTKLVKDLSPGDRVLAADDQGRLLYSDFLTFLDRDDGAKKVFYVIETREPRERLLLTAAHLLFVAPHNDSATGEPEASSGSGPPSGGALGPRALFASRVRPGQRVYVVAERDGDRRLLPAAVHSVTLSEEAAGAYAPLTAQGTILINRVLASCYAVIEEHSWAHRAFAPFRLAHALLAALAPARTDRGGDSGGGDRGGGGGRVALTAPGAADAPGAGATAGIHWYSQLLYQIGTWLLDSEALHPLGMAVKSS
```

**Helix type feature locations of a protein**

```
bbMapping("shh_human",'map(ufeature).filter(ufeature.type=="helix")' ,attrs = "location$begin,location$end")
```

```
##    mapping_id location$begin location$end
## 1 Q15465_F123             71           74
## 2 Q15465_F126             94           96
## 3 Q15465_F127            100          116
## 4 Q15465_F129            139          141
## 5 Q15465_F131            155          157
## 6 Q15465_F132            158          167
## 7 Q15465_F135            188          190
```

**Get all variation identifiers from a gene with given condition**

```
bbMapping("tp53",'map(uniprot).map(ufeature).filter(ufeature.original=="I" && ufeature.variation=="S").map(variantid)',source = "hgnc")
```

```
##     mapping_id
## 1  RS730882027
## 2 RS1330865474
## 3  RS876659675
## 4  RS587780069
## 5  RS760043106
```

# 4 Stop web server

When working with biobtreeR completed, the biobtreeR web server should stop.

```
bbStop()
```

# 5 Session Info

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
## [1] biobtreeR_1.22.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] httr_1.4.7          cli_3.6.5           knitr_1.50
##  [4] rlang_1.1.6         xfun_0.53           stringi_1.8.7
##  [7] otel_0.2.0          promises_1.4.0      jsonlite_2.0.0
## [10] htmltools_0.5.8.1   httpuv_1.6.16       sass_0.4.10
## [13] rmarkdown_2.30      evaluate_1.0.5      jquerylib_0.1.4
## [16] fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
## [19] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
## [22] Rcpp_1.1.0          later_1.4.4         digest_0.6.37
## [25] R6_2.6.1            curl_7.0.0          magrittr_2.0.4
## [28] bslib_0.9.0         tools_4.5.1         cachem_1.1.0
```