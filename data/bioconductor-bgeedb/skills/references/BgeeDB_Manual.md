# BgeeDB, an R package for retrieval of curated expression datasets and for gene list enrichment tests

#### Andrea Komljenovic, Julien Roux, Marc Robinson-Rechavi, Frederic Bastian

#### 2025-10-29

`BgeeDB` is a collection of functions to import data from the Bgee database (<https://bgee.org/>) directly into R, and to facilitate downstream analyses, such as gene set enrichment test based on expression of genes in anatomical structures. Bgee provides annotated and processed expression data and expression calls from curated wild-type healthy samples, from human and many other animal species.

The package retrieves the annotation of RNA-seq, single cell full length RNA-seq and Affymetrix experiments integrated into the Bgee database, and downloads into R the quantitative data and expression calls produced by the Bgee pipeline. The package also allows to run GO-like enrichment analyses based on anatomical terms, where genes are mapped to anatomical terms by expression patterns, based on the `topGO` package. This is the same as the TopAnat web-service available at (<https://www.bgee.org/analysis/top-anat/>), but with more flexibility in the choice of parameters and developmental stages.

In summary, the BgeeDB package allows to: \* 1. List annotation of bulk RNA-seq, single cell RNA-seq and microarray data available the Bgee database \* 2. Download the processed gene expression data available in the Bgee database \* 3. Download the gene expression calls and use them to perform TopAnat analyses

The pipeline used to generate Bgee expression data is documented and publicly available at (<https://github.com/BgeeDB/bgee_pipeline>)

If you find a bug or have any issues to use `BgeeDB` please write a bug report in our own GitHub issues manager available at (<https://github.com/BgeeDB/BgeeDB_R/issues>)

## Installation

In R:

```
#if (!requireNamespace("BiocManager", quietly=TRUE))
    #install.packages("BiocManager")
#BiocManager::install("BgeeDB")
```

In case BgeeDB is run on Windows please be sure your OS has curl installed. It is installed by default on Windows 10, version 1803 or later. If Git for Windows is installed on the OS then curl is already installed. If not installed please install it before running BgeeDB in order to avoid potential timeout errors when downloading files.

## How to use BgeeDB package

### Load the package

```
library(BgeeDB)
```

### Running example: downloading and formatting processed RNA-seq data

#### List available species in Bgee

The `listBgeeSpecies()` function allows to retrieve available species in the Bgee database, and which data types are available for each species.

```
listBgeeSpecies()
```

```
##
## Querying Bgee to get release information...
##
## Building URL to query species in Bgee release 15_2...
##
## downloading Bgee species info... (https://www.bgee.org/ftp/bgee_v15_2/rPackageSpeciesInfo.tsv)
##
## Download of species information successful!
```

```
##        ID           GENUS     SPECIES_NAME               COMMON_NAME AFFYMETRIX
## 1    6239  Caenorhabditis          elegans                  nematode       TRUE
## 2    7227      Drosophila     melanogaster                 fruit fly       TRUE
## 3    7237      Drosophila    pseudoobscura                                FALSE
## 4    7240      Drosophila         simulans                                FALSE
## 5    7740   Branchiostoma      lanceolatum           Common lancelet      FALSE
## 6    7897       Latimeria        chalumnae                Coelacanth      FALSE
## 7    7918     Lepisosteus         oculatus               Spotted gar      FALSE
## 8    7936        Anguilla         anguilla   European freshwater eel      FALSE
## 9    7955           Danio            rerio                 zebrafish       TRUE
## 10   7994        Astyanax        mexicanus           Blind cave fish      FALSE
## 11   8010            Esox           lucius             Northern pike      FALSE
## 12   8030           Salmo            salar           Atlantic salmon      FALSE
## 13   8049           Gadus           morhua              Atlantic cod      FALSE
## 14   8081        Poecilia       reticulata                     Guppy      FALSE
## 15   8090         Oryzias          latipes        Japanese rice fish      FALSE
## 16   8154   Astatotilapia       calliptera             Eastern happy      FALSE
## 17   8355         Xenopus           laevis       African clawed frog      FALSE
## 18   8364         Xenopus       tropicalis       western clawed frog      FALSE
## 19   9031          Gallus           gallus                   chicken      FALSE
## 20   9103       Meleagris        gallopavo               Wild turkey      FALSE
## 21   9258 Ornithorhynchus         anatinus                  platypus      FALSE
## 22   9483      Callithrix          jacchus White-tufted-ear marmoset      FALSE
## 23   9531      Cercocebus             atys            Sooty mangabey      FALSE
## 24   9541          Macaca     fascicularis       Crab-eating macaque      FALSE
## 25   9544          Macaca          mulatta                   macaque       TRUE
## 26   9545          Macaca       nemestrina        Pig-tailed macaque      FALSE
## 27   9555           Papio           anubis              Olive baboon      FALSE
## 28   9593         Gorilla          gorilla                   gorilla      FALSE
## 29   9597             Pan         paniscus                    bonobo      FALSE
## 30   9598             Pan      troglodytes                chimpanzee      FALSE
## 31   9606            Homo          sapiens                     human       TRUE
## 32   9615           Canis lupus familiaris                       dog      FALSE
## 33   9685           Felis            catus                       cat      FALSE
## 34   9796           Equus         caballus                     horse      FALSE
## 35   9823             Sus           scrofa                       pig      FALSE
## 36   9913             Bos           taurus                    cattle      FALSE
## 37   9925           Capra           hircus                      Goat      FALSE
## 38   9940            Ovis            aries                     Sheep      FALSE
## 39   9974           Manis         javanica          Malayan pangolin      FALSE
## 40   9986     Oryctolagus        cuniculus                    rabbit      FALSE
## 41  10090             Mus         musculus                     mouse       TRUE
## 42  10116          Rattus       norvegicus                       rat       TRUE
## 43  10141           Cavia        porcellus                guinea pig      FALSE
## 44  10181  Heterocephalus           glaber            Naked mole rat      FALSE
## 45  13616     Monodelphis        domestica                   opossum      FALSE
## 46  28377          Anolis     carolinensis               green anole      FALSE
## 47  30608      Microcebus          murinus          Gray mouse lemur      FALSE
## 48  32507  Neolamprologus        brichardi             Fairy cichlid      FALSE
## 49  52904    Scophthalmus          maximus                    Turbot      FALSE
## 50  60711     Chlorocebus          sabaeus              Green monkey      FALSE
## 51  69293    Gasterosteus        aculeatus  Three-spined stickleback      FALSE
## 52 105023  Nothobranchius          furzeri       Turquoise killifish      FALSE
##      EST IN_SITU RNA_SEQ SC_FULL_LENGTH SC_DROPLET_BASED
## 1  FALSE    TRUE    TRUE          FALSE            FALSE
## 2   TRUE    TRUE    TRUE          FALSE             TRUE
## 3  FALSE   FALSE    TRUE          FALSE            FALSE
## 4  FALSE   FALSE    TRUE          FALSE            FALSE
## 5  FALSE   FALSE    TRUE          FALSE            FALSE
## 6  FALSE   FALSE    TRUE          FALSE            FALSE
## 7  FALSE   FALSE    TRUE          FALSE            FALSE
## 8  FALSE   FALSE    TRUE          FALSE            FALSE
## 9   TRUE    TRUE    TRUE          FALSE            FALSE
## 10 FALSE   FALSE    TRUE          FALSE            FALSE
## 11 FALSE   FALSE    TRUE          FALSE            FALSE
## 12 FALSE   FALSE    TRUE          FALSE            FALSE
## 13 FALSE   FALSE    TRUE          FALSE            FALSE
## 14 FALSE   FALSE    TRUE          FALSE            FALSE
## 15 FALSE   FALSE    TRUE          FALSE            FALSE
## 16 FALSE   FALSE    TRUE          FALSE            FALSE
## 17 FALSE   FALSE    TRUE          FALSE            FALSE
## 18  TRUE    TRUE    TRUE          FALSE            FALSE
## 19 FALSE   FALSE    TRUE          FALSE             TRUE
## 20 FALSE   FALSE    TRUE          FALSE            FALSE
## 21 FALSE   FALSE    TRUE          FALSE             TRUE
## 22 FALSE   FALSE    TRUE          FALSE             TRUE
## 23 FALSE   FALSE    TRUE          FALSE            FALSE
## 24 FALSE   FALSE    TRUE          FALSE            FALSE
## 25 FALSE   FALSE    TRUE          FALSE             TRUE
## 26 FALSE   FALSE    TRUE          FALSE            FALSE
## 27 FALSE   FALSE    TRUE          FALSE            FALSE
## 28 FALSE   FALSE    TRUE          FALSE             TRUE
## 29 FALSE   FALSE    TRUE          FALSE            FALSE
## 30 FALSE   FALSE    TRUE          FALSE             TRUE
## 31  TRUE   FALSE    TRUE           TRUE             TRUE
## 32 FALSE   FALSE    TRUE          FALSE            FALSE
## 33 FALSE   FALSE    TRUE          FALSE            FALSE
## 34 FALSE   FALSE    TRUE          FALSE            FALSE
## 35 FALSE   FALSE    TRUE          FALSE             TRUE
## 36 FALSE   FALSE    TRUE          FALSE            FALSE
## 37 FALSE   FALSE    TRUE          FALSE            FALSE
## 38 FALSE   FALSE    TRUE          FALSE            FALSE
## 39 FALSE   FALSE    TRUE          FALSE            FALSE
## 40 FALSE   FALSE    TRUE          FALSE             TRUE
## 41  TRUE    TRUE    TRUE           TRUE             TRUE
## 42 FALSE   FALSE    TRUE          FALSE            FALSE
## 43 FALSE   FALSE    TRUE          FALSE            FALSE
## 44 FALSE   FALSE    TRUE          FALSE             TRUE
## 45 FALSE   FALSE    TRUE          FALSE             TRUE
## 46 FALSE   FALSE    TRUE          FALSE            FALSE
## 47 FALSE   FALSE    TRUE          FALSE            FALSE
## 48 FALSE   FALSE    TRUE          FALSE            FALSE
## 49 FALSE   FALSE    TRUE          FALSE            FALSE
## 50 FALSE   FALSE    TRUE          FALSE            FALSE
## 51 FALSE   FALSE    TRUE          FALSE            FALSE
## 52 FALSE   FALSE    TRUE          FALSE            FALSE
```

It is possible to list all species from a specific release of Bgee with the `release` argument (see `listBgeeRelease()` function), and order the species according to a specific columns with the `ordering` argument. For example:

```
listBgeeSpecies(release = "13.2", order = 2)
```

```
##
## Querying Bgee to get release information...
##
## Building URL to query species in Bgee release 13_2...
##
## downloading Bgee species info... (https://archives.bgee.org/13-2/?page=species&display_type=tsv&source=BgeeDB_R_package&source_version=2.36.0)
##
## Download of species information successful!
```

```
##       ID           GENUS SPECIES_NAME COMMON_NAME AFFYMETRIX   EST IN_SITU
## 17 28377          Anolis carolinensis      anolis      FALSE FALSE   FALSE
## 13  9913             Bos       taurus         cow      FALSE FALSE   FALSE
## 1   6239  Caenorhabditis      elegans   c.elegans       TRUE FALSE    TRUE
## 3   7955           Danio        rerio   zebrafish       TRUE  TRUE    TRUE
## 2   7227      Drosophila melanogaster    fruitfly       TRUE  TRUE    TRUE
## 5   9031          Gallus       gallus     chicken      FALSE FALSE   FALSE
## 8   9593         Gorilla      gorilla     gorilla      FALSE FALSE   FALSE
## 11  9606            Homo      sapiens       human       TRUE  TRUE   FALSE
## 7   9544          Macaca      mulatta     macaque      FALSE FALSE   FALSE
## 16 13616     Monodelphis    domestica     opossum      FALSE FALSE   FALSE
## 14 10090             Mus     musculus       mouse       TRUE  TRUE    TRUE
## 6   9258 Ornithorhynchus     anatinus    platypus      FALSE FALSE   FALSE
## 9   9597             Pan     paniscus      bonobo      FALSE FALSE   FALSE
## 10  9598             Pan  troglodytes  chimpanzee      FALSE FALSE   FALSE
## 15 10116          Rattus   norvegicus         rat      FALSE FALSE   FALSE
## 12  9823             Sus       scrofa         pig      FALSE FALSE   FALSE
## 4   8364         Xenopus   tropicalis     xenopus      FALSE  TRUE    TRUE
##    RNA_SEQ
## 17    TRUE
## 13    TRUE
## 1     TRUE
## 3    FALSE
## 2    FALSE
## 5     TRUE
## 8     TRUE
## 11    TRUE
## 7     TRUE
## 16    TRUE
## 14    TRUE
## 6     TRUE
## 9     TRUE
## 10    TRUE
## 15    TRUE
## 12    TRUE
## 4     TRUE
```

#### Create a new Bgee object

In the following example we will choose to focus on zebrafish (“Danio\_rerio”) RNA-seq. Species can be specified using their name or their NCBI taxonomic IDs. To specify that RNA-seq data want to be downloaded, the `dataType` argument is set to “rna\_seq”. To download Affymetrix microarray data, set this argument to “affymetrix”. To download single cell full length RNA-seq data, set this argument to “sc\_full\_length”. To download droplet based single cell RNA-seq data, set this argument to “sc\_droplet\_based”.

```
bgee <- Bgee$new(species = "Danio_rerio", dataType = "rna_seq")
```

```
##
## Querying Bgee to get release information...
##
## Building URL to query species in Bgee release 15_2...
##
## downloading Bgee species info... (https://www.bgee.org/ftp/bgee_v15_2/rPackageSpeciesInfo.tsv)
##
## Download of species information successful!
##
## API key built: c0328c1991fb3d9ed7f90edb9ae6a13d7021109ef29df40329286b1c2245e946a3ab88e3bbadea8df7446055b18f814afdba9215dedc72b1e4b2fa6b3b25b708
```

*Note 1*: It is possible to work with data from a specific release of Bgee by specifying the `release` argument, see `listBgeeRelease()` function for available releases.

*Note 2*: The functions of the package will store the downloaded files in a versioned folder created by default in the working directory. These cache files allow faster re-access to the data. The directory where data are stored can be changed with the `pathToData` argument.

#### Retrieve the annotation of zebrafish RNA-seq datasets

The `getAnnotation()` function will output the list of bulk RNA-seq experiments and libraries available in Bgee for zebrafish.

```
annotation_bgee_zebrafish <- getAnnotation(bgee)
```

```
##
## Saved annotation files in /tmp/RtmpIhbgZz/Rbuild3478a47f3475b0/BgeeDB/vignettes/Danio_rerio_Bgee_15_2 folder.
```

```
# list the first experiments and libraries
lapply(annotation_bgee_zebrafish, head)
```

```
## $sample.annotation
##   Experiment.ID Library.ID Anatomical.entity.ID Anatomical.entity.name
## 1     SRP055573  SRX893428       UBERON:0000014           zone of skin
## 2     SRP055573  SRX893429       UBERON:0000014           zone of skin
## 3     SRP055573  SRX893430       UBERON:0000014           zone of skin
## 4     SRP055573  SRX893431       UBERON:0000014           zone of skin
## 5     SRP055573  SRX893432       UBERON:0000014           zone of skin
## 6     SRP055573  SRX893433       UBERON:0000014           zone of skin
##   Anatomical.entity.author.annotation       Stage.ID    Stage.name
## 1                                skin UBERON:0000113 post-juvenile
## 2                                skin UBERON:0000113 post-juvenile
## 3                                skin UBERON:0000113 post-juvenile
## 4                                skin UBERON:0000113 post-juvenile
## 5                                skin UBERON:0000113 post-juvenile
## 6                                skin UBERON:0000113 post-juvenile
##   Stage.author.annotation  Sex Strain Expression.mapped.anatomical.entity.ID
## 1               12 months male     NA                         UBERON:0000014
## 2               12 months male     NA                         UBERON:0000014
## 3               12 months male     NA                         UBERON:0000014
## 4               12 months male     NA                         UBERON:0000014
## 5               12 months male     NA                         UBERON:0000014
## 6               12 months male     NA                         UBERON:0000014
##   Expression.mapped.anatomical.entity.name Expression.mapped.stage.ID
## 1                             zone of skin             UBERON:0000113
## 2                             zone of skin             UBERON:0000113
## 3                             zone of skin             UBERON:0000113
## 4                             zone of skin             UBERON:0000113
## 5                             zone of skin             UBERON:0000113
## 6                             zone of skin             UBERON:0000113
##   Expression.mapped.stage.name Expression.mapped.sex Expression.mapped.strain
## 1                post-juvenile                  male                wild-type
## 2                post-juvenile                  male                wild-type
## 3                post-juvenile                  male                wild-type
## 4                post-juvenile                  male                wild-type
## 5                post-juvenile                  male                wild-type
## 6                post-juvenile                  male                wild-type
##           Platform.ID Protocol Library.type Library.orientation
## 1 Illumina HiSeq 2000    polyA       single                  NA
## 2 Illumina HiSeq 2000    polyA       single                  NA
## 3 Illumina HiSeq 2000    polyA       single                  NA
## 4 Illumina HiSeq 2000    polyA       single                  NA
## 5 Illumina HiSeq 2000    polyA       single                  NA
## 6 Illumina HiSeq 2000    polyA       single                  NA
##   TMM.normalization.factor Expression.threshold Expression.unit
## 1                 1.151250             0.851205             tpm
## 2                 1.476505             0.975114             tpm
## 3                 1.209218             0.898562             tpm
## 4                 1.137837             0.912914             tpm
## 5                 1.205815             0.947171             tpm
## 6                 1.268032             0.897872             tpm
##   Cell.compartment Sequenced.transcript.part Genotype Read.count
## 1             cell               full length       NA   37106422
## 2             cell               full length       NA   36371186
## 3             cell               full length       NA   37757076
## 4             cell               full length       NA   39481452
## 5             cell               full length       NA   40239380
## 6             cell               full length       NA   37777312
##   Mapped.read.count Min.read.length Max.read.length All.genes.percent.present
## 1          29074870              50              50                     57.20
## 2          28397674              50              50                     62.95
## 3          28889562              50              50                     54.99
## 4          30247166              50              50                     55.31
## 5          30876407              50              50                     55.22
## 6          29147850              50              50                     56.64
##   Protein.coding.genes.percent.present Intergenic.regions.percent.present
## 1                                68.74                               4.36
## 2                                74.69                               4.46
## 3                                66.02                               4.40
## 4                                66.46                               4.39
## 5                                66.37                               4.53
## 6                                67.94                               4.26
##   Distinct.rank.count Max.rank.in.the.expression.mapped.condition    Run.IDs
## 1               24170                                          NA SRR1821827
## 2               25495                                          NA SRR1821828
## 3               23830                                          NA SRR1821829
## 4               23987                                          NA SRR1821830
## 5               23943                                          NA SRR1821831
## 6               24320                                          NA SRR1821832
##   Data.source
## 1         SRA
## 2         SRA
## 3         SRA
## 4         SRA
## 5         SRA
## 6         SRA
##                                                                              Data.source.URL
## 1 https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?cmd=viewer&m=data&s=viewer&run=SRX893428
## 2 https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?cmd=viewer&m=data&s=viewer&run=SRX893429
## 3 https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?cmd=viewer&m=data&s=viewer&run=SRX893430
## 4 https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?cmd=viewer&m=data&s=viewer&run=SRX893431
## 5 https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?cmd=viewer&m=data&s=viewer&run=SRX893432
## 6 https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?cmd=viewer&m=data&s=viewer&run=SRX893433
##                                                                                                                      Bgee.normalized.data.URL
## 1 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_SRP055573.tsv.gz
## 2 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_SRP055573.tsv.gz
## 3 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_SRP055573.tsv.gz
## 4 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_SRP055573.tsv.gz
## 5 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_SRP055573.tsv.gz
## 6 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_SRP055573.tsv.gz
##                                                 Raw.file.URL
## 1 https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRX893428
## 2 https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRX893429
## 3 https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRX893430
## 4 https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRX893431
## 5 https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRX893432
## 6 https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRX893433
##
## $experiment.annotation
##   Experiment.ID
## 1     SRP055573
## 2     DRP003810
## 3     SRP022612
## 4     SRP470937
## 5     SRP009426
## 6      GSE39703
##                                                                                           Experiment.name
## 1       RNA-seq of zebrafish brain, liver and skin during perturbation with rotenone at young and old age
## 2                                                                                         EXPANDE project
## 3                             RNA-seq of Danio rerio and Mus musculus skin for three different age groups
## 4                                                                          Danio rerio Raw sequence reads
## 5 Comprehensive identification of long non-coding RNAs expressed during zebrafish embryogenesis [RNA_seq]
## 6                                 Transcriptomic analysis of zebrafish during development and homeostasis
##   Library.count Condition.count Organ.stage.count Organ.count Celltype.Count
## 1            36               3                 3           3              0
## 2            35              16                16           5              0
## 3            20               1                 1           1              0
## 4            18               2                 2           2              0
## 5            17               8                 8           5              0
## 6            16               5                 5           4              0
##   Stage.count Sex.count Strain.count Data.source
## 1           1         1            1         SRA
## 2          16         1            1         SRA
## 3           1         1            1         GEO
## 4           1         2            1         SRA
## 5           8         1            1         SRA
## 6           4         1            1         GEO
##                                                Data.source.URL
## 1                   https://www.ncbi.nlm.nih.gov/sra/SRP055573
## 2                   https://www.ncbi.nlm.nih.gov/sra/DRP003810
## 3 https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=SRP022612
## 4                   https://www.ncbi.nlm.nih.gov/sra/SRP470937
## 5                   https://www.ncbi.nlm.nih.gov/sra/SRP009426
## 6  https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE39703
##                                                                                                                      Bgee.normalized.data.URL
## 1 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_SRP055573.tsv.gz
## 2 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_DRP003810.tsv.gz
## 3 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_SRP022612.tsv.gz
## 4 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_SRP470937.tsv.gz
## 5 https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_SRP009426.tsv.gz
## 6  https://www.bgee.org/ftp/bgee_v15_2/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_GSE39703.tsv.gz
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Experiment.description
## 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Zebrafish of two different age groups (12 and 36 months) were treated with low amounts of rotenone (mild stress) and compared to untreated zebrafish. Two different durations were used (3 and 8 weeks). Illumina sequencing (HiSeq2000) was applied to generate 50bp single-end reads. Jena Centre for Systems Biology of Ageing - JenAge (www.jenage.de) Overall design: 68 sample: 3 tissues (brain, liver, skin); 2 age groups (12 and 36 months); controls and rotenone treated samples; 2-6 biological replicates for each group
## 2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           EXPression AloNg Development and Evolution (EXPANDE) project aims to identify gene expression profiles expanded during embryogenesis and evolution. In brief, taking advantages of Illumina sequencing, RNAseq profiles of early to late embryos of 8 chordate species were identified with biological replicates (two or more biological replicates).
## 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       Comparison of temporal gene expression profiles (www.jenage.de) The RNA-seq data comprises 3 age groups: 2, 15 and 30 months for mouse skin; 5, 24 and 42 months for zebrafish skin. Illumina 50bp single-stranded single-read RNA sequencing Overall design: 15 samples for mouse: 5 biological replicates for 2 months, 6 biological replicates for 15 months and 4 biological replicates for 30 months; 20 samples for zebrafish: 9 biological replicates for 5 months, 6 biological replicates for 24 months and 5 biological replicates for 42 months
## 4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       normal RNAseq of zebrafish
## 5 Long non-coding RNAs (lncRNAs) comprise a diverse class of transcripts that structurally resemble mRNAs but do not encode proteins. Recent genome-wide studies in human and mouse have annotated lncRNAs expressed in cell lines and adult tissues, but a systematic analysis of lncRNAs expressed during vertebrate embryogenesis has been elusive. To identify lncRNAs with potential functions in vertebrate embryogenesis, we performed a time series of RNA-Seq experiments at eight stages during early zebrafish development. We reconstructed 56,535 high-confidence transcripts in 28,912 loci, recovering the vast majority of expressed RefSeq transcripts, while identifying thousands of novel isoforms and expressed loci. We defined a stringent set of 1,133 non-coding multi-exonic transcripts expressed during embryogenesis. These include long intergenic ncRNAs (lincRNAs), intronic overlapping lncRNAs, exonic antisense overlapping lncRNAs, and precursors for small RNAs (sRNAs). Zebrafish lncRNAs share many of the characteristics of their mammalian counterparts: relatively short length, low exon number, low expression, and conservation levels comparable to introns. Subsets of lncRNAs carry chromatin signatures characteristic of genes with developmental functions. The temporal expression profile of lncRNAs revealed two novel properties: lncRNAs are expressed in narrower time windows than protein-coding genes and are specifically enriched in early-stage embryos. In addition, several lncRNAs show tissue-specific expression and distinct subcellular localization patterns. Integrative computational analyses associated individual lncRNAs with specific pathways and functions, ranging from cell cycle regulation to morphogenesis. Our study provides the first comprehensive identification of lncRNAs in a vertebrate embryo and forms the foundation for future genetic, genomic and evolutionary studies. Overall design: RNA-Seq for 8 zebrafish developmental stages, 2 lanes for each stage (3 for shield).
## 6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Sequencing libraries were generated from total RNA samples following the mRNAseq protocol for the generation of single end (16-36 hpf, 5 day larvae, adult head and adult tail) or paired end (24 hpf) libraries (Illumina). Single end reads of 36 nucleotides and paired end reads (2 x 76 nucleotides) were obtained with a GAIIx (Illumina). Gene expression at the different stages/tissu was assessed by cufflinks and HTseq.
```

#### Download the processed zebrafish bulk RNA-seq data

The `getSampleProcessedData()` function will download processed bulk RNA-seq data from all zebrafish experiments in Bgee as a data frame.

```
# download all RNA-seq experiments from zebrafish
data_bgee_zebrafish <- getSampleProcessedData(bgee)
```

```
## downloading data from Bgee FTP...
```

```
## You tried to download more than 15 experiments, because of that all the Bgee data for this species will be downloaded.
```

```
## Downloading all expression data for species Danio_rerio
```

```
## Saved expression data file in /tmp/RtmpIhbgZz/Rbuild3478a47f3475b0/BgeeDB/vignettes/Danio_rerio_Bgee_15_2 folder. Now untar file...
```

```
## Finished uncompress tar files
```

```
## Save data in local sqlite database
```

```
## Load queried data. The query is : SELECT * from rna_seq
```

```
# number of experiments downloaded
length(data_bgee_zebrafish)
```

```
## [1] 16
```

```
# check the downloaded data
lapply(data_bgee_zebrafish, head)
```

```
## $Experiment.ID
## [1] "ERP000447" "ERP000447" "ERP000447" "ERP000447" "ERP000447" "ERP000447"
##
## $Library.ID
## [1] "ERX009445" "ERX009445" "ERX009445" "ERX009445" "ERX009445" "ERX009445"
##
## $Library.type
## [1] "paired" "paired" "paired" "paired" "paired" "paired"
##
## $Gene.ID
## [1] "ENSDARG00000000001" "ENSDARG00000000002" "ENSDARG00000000018"
## [4] "ENSDARG00000000019" "ENSDARG00000000068" "ENSDARG00000000069"
##
## $Anatomical.entity.ID
## [1] "UBERON:0000948" "UBERON:0000948" "UBERON:0000948" "UBERON:0000948"
## [5] "UBERON:0000948" "UBERON:0000948"
##
## $Anatomical.entity.name
## [1] "\"heart\"" "\"heart\"" "\"heart\"" "\"heart\"" "\"heart\"" "\"heart\""
##
## $Stage.ID
## [1] "UBERON:0000113" "UBERON:0000113" "UBERON:0000113" "UBERON:0000113"
## [5] "UBERON:0000113" "UBERON:0000113"
##
## $Stage.name
## [1] "\"post-juvenile\"" "\"post-juvenile\"" "\"post-juvenile\""
## [4] "\"post-juvenile\"" "\"post-juvenile\"" "\"post-juvenile\""
##
## $Sex
## [1] "mixed" "mixed" "mixed" "mixed" "mixed" "mixed"
##
## $Strain
## [1] "\"Singapore\"" "\"Singapore\"" "\"Singapore\"" "\"Singapore\""
## [5] "\"Singapore\"" "\"Singapore\""
##
## $Read.count
## [1]  14.0000  15.0000 104.0000 101.0000  12.0000  98.9097
##
## $TPM
## [1]  3.205255  2.980668 19.807954 19.893809  3.304039 30.809485
##
## $Rank
## [1] 7324 7536 2599 2594 7225 1835
##
## $Detection.flag
## [1] "present" "absent"  "present" "present" "present" "present"
##
## $pValue
## [1] 0.0471476817 0.0538957373 0.0004800936 0.0004735145 0.0445365056
## [6] 0.0001090867
##
## $State.in.Bgee
## [1] "Part of a call" "Part of a call" "Part of a call" "Part of a call"
## [5] "Part of a call" "Part of a call"
```

```
# isolate the first experiment
data_bgee_experiment1 <- data_bgee_zebrafish[[1]]
```

The result of the `getSampleProcessedData()` function is a data frame. Each row is a gene and the expression levels are displayed as raw read counts, RPKMs (up to Bgee 13.2), TPMs (from Bgee 14.0), or FPKMs (from Bgee 14.0 to Bgee 14.2). A detection flag indicates if the gene is significantly expressed above background level of expression. From Bgee 15.0 a pValue allows to have a precise metric indicating how much the gene is significantly expressed above background level of expression (the detection flag is still available and a gene is considered as present if pValue < 0.05).

*Note*: If microarray data are downloaded, rows corresponding to probesets and log2 of expression intensities are available instead of read counts/RPKMs/TPMs/FPKMs.

Alternatively, you can choose to download data from one RNA-seq experiment from Bgee with the `experimentId` parameter:

```
# download data for GSE68666
data_bgee_zebrafish_gse68666 <- getSampleProcessedData(bgee, experimentId = "GSE68666")
```

```
## Load queried data. The query is : SELECT * from rna_seq WHERE [Experiment.ID] = "GSE68666"
```

It is possible to download data by combining filters : \* experimentId : one or more experimentId, \* sampleId : one or more sampleId (i.e libraryId for RNA-Seq and ChipId for Affymetrix), \* anatEntityId : one or more anatomical entity ID from the UBERON ontology (<https://uberon.github.io/>), \* withDescendantAnatEntities : filter on the selected anatEntityId and all its descendants (from Bgee 15.0), \* stageId : one or more developmental stage ID from the developmental stage ontologies (<https://github.com/obophenotype/developmental-stage-ontologies>), \* withDescendantStages : filter on the selected stageId and all its descendants (from Bgee 15.0) \* cellTypeId : one or more cell type, only for single cell datatype (from Bgee 15.0), \* withDescendantCellTypes : filter on the selected cellTypeId and all its descendants (from Bgee 15.0) \* sex : one or more sex (from Bgee 15.0), \* strain : one or more strain (from Bgee 15.0),

```
# Examples of data downloading using different filtering combination
# retrieve zebrafish RNA-Seq data for heart (UBERON:0000955) or brain (UBERON:0000948)
data_bgee_zebrafish_filters <- getSampleProcessedData(bgee, anatEntityId = c("UBERON:0000955","UBERON:0000948"))
# retrieve zebrafish RNA-Seq data for embryo (UBERON:0000922) part of the experiment GSE68666
data_bgee_zebrafish_filters <- getSampleProcessedData(bgee, experimentId = "GSE68666", anatEntityId = "UBERON:0000922")
# retrieve zebrafish RNA-Seq data for head kidney (UBERON:0007132) or swim bladder (UBERON:0006860) from post-juvenile adult stage (UBERON:0000113)
data_bgee_zebrafish_filters <- getSampleProcessedData(bgee, stageId = "UBERON:0000113", anatEntityId = c("UBERON:0007132","UBERON:0006860"))
# retrieve zebrafish RNA-Seq data for brain (UBERON:0000948) and all substructures of brain from post-juvenile adult stage (UBERON:0000113)
data_bgee_zebrafish_filters <- getSampleProcessedData(bgee, stageId = "UBERON:0000113", anatEntityId = "UBERON:0000948", withDescendantAnatEntities = TRUE)
```

#### Format the sample level bulk RNA-seq data

It is sometimes easier to work with data organized as a matrix, where rows represent genes or probesets and columns represent different samples. The `formatData()` function reformats the data into an ExpressionSet object including: \* An expression data matrix, with genes or probesets as rows, and samples as columns (`assayData` slot). The `stats` argument allows to choose if the matrix should be filled with read counts, RPKMs (up to Bgee 13.2), FPKMs (from Bgee 14.0 to Bgee 14.2), or TPMs (from Bgee 14.0) for RNA-seq data. For microarray data the matrix is filled with log2 expression intensities. \* A data frame listing the samples and their anatomical structure and developmental stage annotation (`phenoData` slot) \* For microarray data, the mapping from probesets to Ensembl genes (`featureData` slot)

The `callType` argument allows to retain only actively expressed genes or probesets, if set to “present” or “present high quality”. Genes or probesets that are absent in a given sample are given `NA` values.

```
# use only present calls and fill expression matrix with TPM values
gene.expression.zebrafish.tpm <- formatData(bgee, data_bgee_zebrafish_gse68666, callType = "present", stats = "tpm")
```

```
##
## Extracting expression data matrix...
##   Keeping only present genes.
```

```
## Warning: `spread_()` was deprecated in tidyr 1.2.0.
## ℹ Please use `spread()` instead.
## ℹ The deprecated feature was likely used in the BgeeDB package.
##   Please report the issue at <https://github.com/BgeeDB/BgeeDB_R/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
##
## Extracting features information...
##
## Extracting samples information...
```

```
gene.expression.zebrafish.tpm
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 27806 features, 3 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: SRX1021683 SRX1021684 SRX1021685
##   varLabels: Library.ID Anatomical.entity.ID ... Stage.name (5 total)
##   varMetadata: labelDescription
## featureData
##   featureNames: ENSDARG00000000001 ENSDARG00000000002 ...
##     ENSDARG00000117824 (27806 total)
##   fvarLabels: Gene.ID
##   fvarMetadata: labelDescription
## experimentData: use 'experimentData(object)'
## Annotation:
```

#### Download cell level single-cell RNA-seq data

The `getCellProcessedData()` function will download processed single-cell RNA-seq data at the cell level. In the following example we will focus on downloading UMI counts at cell level for the Gallus gallus experiment ERP132576. The data are stored as h5ad files and can be opened using either the package "zellkonverter" (default) or the package "anndata" with the attribute `package = "anndata`. Both "zellkonverter" and "anndata" packages require a configuration step when used the first time.

```
#create a bgee object to download droplet based data from Gallus gallus
bgee <- Bgee$new(species = "Gallus_gallus", dataType = "sc_droplet_based")
# download cell data for one RNA-seq experiment
cell_data_bgee_gallus_gallus <- getCellProcessedData(bgee, experimentId = "ERP132576")
```

The result of the `getCellProcessedData()` depends on the package used to load the data. With "zellkonverter" it is an object of the class SingleCellExperiment. With "anndata" it is an object of the class AnnData. The expression levels are displayed as raw UMI counts.

### Running example: TopAnat gene expression enrichment analysis

For some documentation on the TopAnat analysis, please refer to our publications, or to the web-tool page (<https://www.bgee.org/analysis/top-anat/>).

#### Create a new Bgee object

Similarly to the quantitative data download example above, the first step of a topAnat analysis is to built an object from the Bgee class. For this example, we will focus on zebrafish:

```
# Creating new Bgee class object
bgee <- Bgee$new(species = "Danio_rerio", release = "15.2")
```

```
##
## NOTE: You did not specify any data type. The argument dataType will be set to c("rna_seq","affymetrix","est","in_situ","sc_full_length", "sc_droplet_based") for the next steps.
##
## Querying Bgee to get release information...
##
## NOTE: the file describing Bgee species information for release 15_2 was found in the download directory /tmp/RtmpIhbgZz/Rbuild3478a47f3475b0/BgeeDB/vignettes. Data will not be redownloaded.
##
## API key built: c0328c1991fb3d9ed7f90edb9ae6a13d7021109ef29df40329286b1c2245e946a3ab88e3bbadea8df7446055b18f814afdba9215dedc72b1e4b2fa6b3b25b708
```

*Note* : We are free to specify any data type of interest using the `dataType` argument among `rna_seq`, `sc_full_length`, `sc_droplet_based`, `affymetrix`, `est` or `in_situ`, or even a combination of data types. If nothing is specified, as in the above example, all data types available for the targeted species are used. This equivalent to specifying `dataType=c("rna_seq","sc_full_length","sc_droplet_based","affymetrix","est","in_situ")`.

#### Download the data allowing to perform TopAnat analysis

The `loadTopAnatData()` function loads a mapping from genes to anatomical structures based on calls of expression in anatomical structures. It also loads the structure of the anatomical ontology and the names of anatomical structures.

```
# Loading calls of expression
myTopAnatData <- loadTopAnatData(bgee)
```

```
##
## Building URLs to retrieve organ relationships from Bgee.........
##    URL successfully built (https://www.bgee.org/bgee15_2/api/?page=r_package&action=get_anat_entity_relations&display_type=tsv&species_list=7955&attr_list=SOURCE_ID&attr_list=TARGET_ID&api_key=c0328c1991fb3d9ed7f90edb9ae6a13d7021109ef29df40329286b1c2245e946a3ab88e3bbadea8df7446055b18f814afdba9215dedc72b1e4b2fa6b3b25b708&source=BgeeDB_R_package&source_version=2.36.0)
##    Submitting URL to Bgee webservice (can be long)
##    Got results from Bgee webservice. Files are written in "/tmp/RtmpIhbgZz/Rbuild3478a47f3475b0/BgeeDB/vignettes/Danio_rerio_Bgee_15_2"
##
## Building URLs to retrieve organ names from Bgee.................
##    URL successfully built (https://www.bgee.org/bgee15_2/api/?page=r_package&action=get_anat_entities&display_type=tsv&species_list=7955&attr_list=ID&attr_list=NAME&api_key=c0328c1991fb3d9ed7f90edb9ae6a13d7021109ef29df40329286b1c2245e946a3ab88e3bbadea8df7446055b18f814afdba9215dedc72b1e4b2fa6b3b25b708&source=BgeeDB_R_package&source_version=2.36.0)
##    Submitting URL to Bgee webservice (can be long)
##    Got results from Bgee webservice. Files are written in "/tmp/RtmpIhbgZz/Rbuild3478a47f3475b0/BgeeDB/vignettes/Danio_rerio_Bgee_15_2"
##
## Building URLs to retrieve mapping of gene to organs from Bgee...
##    URL successfully built (https://www.bgee.org/bgee15_2/api/?page=r_package&action=get_expression_calls&display_type=tsv&species_list=7955&attr_list=GENE_ID&attr_list=ANAT_ENTITY_ID&api_key=c0328c1991fb3d9ed7f90edb9ae6a13d7021109ef29df40329286b1c2245e946a3ab88e3bbadea8df7446055b18f814afdba9215dedc72b1e4b2fa6b3b25b708&source=BgeeDB_R_package&source_version=2.36.0&data_qual=SILVER)
##    Submitting URL to Bgee webservice (can be long)
##    Got results from Bgee webservice. Files are written in "/tmp/RtmpIhbgZz/Rbuild3478a47f3475b0/BgeeDB/vignettes/Danio_rerio_Bgee_15_2"
##
## Parsing the results.............................................
##
## Adding BGEE:0 as unique root of all terms of the ontology.......
##
## Done.
```

```
# Look at the data
## str(myTopAnatData)
```

The stringency on the quality of expression calls can be changed with the `confidence` argument. Finally, if you are interested in expression data coming from a particular developmental stage or a group of stages, please specify the a Uberon stage Id in the `stage` argument.

```
## Loading silver and gold expression calls from affymetrix data made on embryonic samples only
## This is just given as an example, but is not run in this vignette because only few data are returned
bgee <- Bgee$new(species = "Danio_rerio", dataType="affymetrix", release = "15.2")
myTopAnatData <- loadTopAnatData(bgee, stage="UBERON:0000068", confidence="silver")
```

*Note 1*: As mentioned above, the downloaded data files are stored in a versioned folder that can be set with the `pathToData` argument when creating the Bgee class object (default is the working directory). If you query again Bgee with the exact same parameters, these cached files will be read instead of querying the web-service again. **It is thus important, if you plan to reuse the same data for multiple parallel topAnat analyses, to plan to make use of these cached files instead of redownloading them for each analysis.** The cached files also give the possibility to repeat analyses offline.

*Note 2*: In releases up to Bgee 13.2 allowed ``` confidence`` values were `low_quality` or or `high_quality`. Starting from Bgee 14.0 ```confidence```values are`gold`or`silver`.

#### Prepare a topAnatData object allowing to perform TopAnat analysis with topGO

First we need to prepare a list of genes in the foreground and in the background. The input format is the same as the gene list required to build a `topGOdata` object in the `topGO` package: a vector with background genes as names, and 0 or 1 values depending if a gene is in the foreground or not. In this example we will look at genes with an annotated phenotype related to “pectoral fin” . We use the `biomaRt` package to retrieve this list of genes. We expect them to be enriched for expression in male tissues, notably the testes. The background list of genes is set to all genes annotated to at least one Gene Ontology term, allowing to account for biases in which types of genes are more likely to receive Gene Ontology annotation.

```
# if (!requireNamespace("BiocManager", quietly=TRUE))
    # install.packages("BiocManager")
# BiocManager::install("biomaRt")
library(biomaRt)
ensembl <- useMart("ENSEMBL_MART_ENSEMBL", dataset="drerio_gene_ensembl", host="mar2016.archive.ensembl.org")

# get the mapping of Ensembl genes to phenotypes. It will corresponds to the background genes
universe <- getBM(filters=c("phenotype_source"), value=c("ZFIN"), attributes=c("ensembl_gene_id","phenotype_description"), mart=ensembl)

# select phenotypes related to pectoral fin
phenotypes <- grep("pectoral fin", unique(universe$phenotype_description), value=T)

# Foreground genes are those with an annotated phenotype related to "pectoral fin"
myGenes <- unique(universe$ensembl_gene_id[universe$phenotype_description %in% phenotypes])

# Prepare the gene list vector
geneList <- factor(as.integer(unique(universe$ensembl_gene_id) %in% myGenes))
names(geneList) <- unique(universe$ensembl_gene_id)
summary(geneList)

# Prepare the topGO object
myTopAnatObject <-  topAnat(myTopAnatData, geneList)
```

The above code using the `biomaRt` package is not executed in this vignette to prevent building issues of our package in case of biomaRt downtime. Instead we use a `geneList` object saved in the `data/` folder that we built using pre-downloaded data.

```
data(geneList)
myTopAnatObject <-  topAnat(myTopAnatData, geneList)
```

```
##
## Checking topAnatData object.............
##
## Checking gene list......................
##
## WARNING: Some genes in your gene list have no expression data in Bgee, and will not be included in the analysis. 2959 genes in background will be kept.
##
## Building most specific Ontology terms...  (  1316  Ontology terms found. )
##
## Building DAG topology...................  (  2262  Ontology terms and  4630  relations. )
##
## Annotating nodes (Can be long)..........  (  2959  genes annotated to the Ontology terms. )
```

*Warning*: This can be long, especially if the gene list is large, since the Uberon anatomical ontology is large and expression calls will be propagated through the whole ontology (e.g., expression in the forebrain will also be counted as expression in parent structures such as the brain, nervous system, etc). Consider running a script in batch mode if you have multiple analyses to do.

#### Launch the enrichment test

For this step, see the vignette of the `topGO` package for more details, as you have to directly use the tests implemented in the `topGO` package, as shown in this example:

```
results <- runTest(myTopAnatObject, algorithm = 'weight', statistic = 'fisher')
```

```
##
##           -- Weight Algorithm --
##
##       The algorithm is scoring 1019 nontrivial nodes
##       parameters:
##           test statistic: fisher : ratio
```

```
##
##   Level 29:  1 nodes to be scored.
```

```
##
##   Level 28:  1 nodes to be scored.
```

```
##
##   Level 27:  1 nodes to be scored.
```

```
##
##   Level 26:  3 nodes to be scored.
```

```
##
##   Level 25:  5 nodes to be scored.
```

```
##
##   Level 24:  6 nodes to be scored.
```

```
##
##   Level 23:  8 nodes to be scored.
```

```
##
##   Level 22:  22 nodes to be scored.
```

```
##
##   Level 21:  22 nodes to be scored.
```

```
##
##   Level 20:  29 nodes to be scored.
```

```
##
##   Level 19:  40 nodes to be scored.
```

```
##
##   Level 18:  71 nodes to be scored.
```

```
##
##   Level 17:  69 nodes to be scored.
```

```
##
##   Level 16:  88 nodes to be scored.
```

```
##
##   Level 15:  103 nodes to be scored.
```

```
##
##   Level 14:  115 nodes to be scored.
```

```
##
##   Level 13:  106 nodes to be scored.
```

```
##
##   Level 12:  91 nodes to be scored.
```

```
##
##   Level 11:  76 nodes to be scored.
```

```
##
##   Level 10:  55 nodes to be scored.
```

```
##
##   Level 9:   31 nodes to be scored.
```

```
##
##   Level 8:   26 nodes to be scored.
```

```
##
##   Level 7:   20 nodes to be scored.
```

```
##
##   Level 6:   17 nodes to be scored.
```

```
##
##   Level 5:   6 nodes to be scored.
```

```
##
##   Level 4:   3 nodes to be scored.
```

```
##
##   Level 3:   2 nodes to be scored.
```

```
##
##   Level 2:   1 nodes to be scored.
```

```
##
##   Level 1:   1 nodes to be scored.
```

*Warning*: This can be long because of the size of the ontology. Consider running scripts in batch mode if you have multiple analyses to do.

#### Format the table of results after an enrichment test for anatomical terms

The `makeTable` function allows to filter and format the test results, and calculate FDR values.

```
# Display results sigificant at a 1% FDR threshold
tableOver <- makeTable(myTopAnatData, myTopAnatObject, results, cutoff = 0.01)
```

```
##
## Building the results table for the 9 significant terms at FDR threshold of 0.01...
## Ordering results by pValue column in increasing order...
## Done
```

```
head(tableOver)
```

```
##                       organId                organName annotated significant
## UBERON:0000151 UBERON:0000151             pectoral fin       410          60
## UBERON:0005419 UBERON:0005419   pectoral appendage bud       133          31
## UBERON:2000040 UBERON:2000040          median fin fold        53          15
## UBERON:0005729 UBERON:0005729 pectoral appendage field        14           8
## UBERON:0006598 UBERON:0006598    presumptive structure      1803         122
## UBERON:0004376 UBERON:0004376                 fin bone        27           9
##                expected foldEnrichment       pValue          FDR
## UBERON:0000151    20.23       2.965892 3.105066e-15 3.533565e-12
## UBERON:0005419     6.56       4.725610 3.953367e-14 2.249466e-11
## UBERON:2000040     2.62       5.725191 1.517744e-08 5.757308e-06
## UBERON:0005729     0.69      11.594203 6.792283e-08 1.932405e-05
## UBERON:0006598    88.96       1.371403 1.928360e-06 4.388947e-04
## UBERON:0004376     1.33       6.766917 2.968197e-06 5.629680e-04
```

At the time of building this vignette (Sept. 2024), there was 9 significant anatomical structures. The first term is “pectoral fin”, and the second “pectoral appendage bud”. Other terms in the list, especially those with high enrichment folds, are clearly related to pectoral fins or substructures of fins. This analysis shows that genes with phenotypic effects on pectoral fins are specifically expressed in or next to these structures

By default results are sorted by p-value, but this can be changed with the `ordering` parameter by specifying which column should be used to order the results (preceded by a “-” sign to indicate that ordering should be made in decreasing order). For example, it is often convenient to sort significant structures by decreasing enrichment fold, using `ordering = -6`. The full table of results can be obtained using `cutoff = 1`.

Of note, it is possible to retrieve for a particular tissue the significant genes that were mapped to it.

```
# In order to retrieve significant genes mapped to the term " paired limb/fin bud"
term <- "UBERON:0004357"
termStat(myTopAnatObject, term)
```

```
##                Annotated Significant Expected
## UBERON:0004357       172          37     8.49
```

```
# 172 genes mapped to this term for Bgee 15.2
genesInTerm(myTopAnatObject, term)
```

```
## $`UBERON:0004357`
##   [1] "ENSDARG00000001057" "ENSDARG00000001785" "ENSDARG00000002445"
##   [4] "ENSDARG00000002487" "ENSDARG00000002795" "ENSDARG00000002952"
##   [7] "ENSDARG00000003293" "ENSDARG00000003399" "ENSDARG00000004954"
##  [10] "ENSDARG00000005479" "ENSDARG00000005645" "ENSDARG00000005762"
##  [13] "ENSDARG00000006921" "ENSDARG00000007407" "ENSDARG00000007438"
##  [16] "ENSDARG00000007918" "ENSDARG00000008305" "ENSDARG00000008886"
##  [19] "ENSDARG00000009438" "ENSDARG00000009534" "ENSDARG00000010192"
##  [22] "ENSDARG00000011027" "ENSDARG00000011247" "ENSDARG00000011407"
##  [25] "ENSDARG00000011618" "ENSDARG00000012078" "ENSDARG00000012422"
##  [28] "ENSDARG00000012824" "ENSDARG00000013144" "ENSDARG00000013409"
##  [31] "ENSDARG00000013881" "ENSDARG00000014091" "ENSDARG00000014626"
##  [34] "ENSDARG00000014796" "ENSDARG00000015554" "ENSDARG00000015674"
##  [37] "ENSDARG00000016022" "ENSDARG00000016454" "ENSDARG00000016858"
##  [40] "ENSDARG00000017219" "ENSDARG00000017369" "ENSDARG00000018426"
##  [43] "ENSDARG00000018460" "ENSDARG00000018492" "ENSDARG00000018902"
##  [46] "ENSDARG00000019260" "ENSDARG00000019353" "ENSDARG00000019579"
##  [49] "ENSDARG00000019995" "ENSDARG00000020143" "ENSDARG00000021442"
##  [52] "ENSDARG00000021938" "ENSDARG00000022280" "ENSDARG00000024561"
##  [55] "ENSDARG00000024894" "ENSDARG00000025081" "ENSDARG00000025641"
##  [58] "ENSDARG00000025891" "ENSDARG00000028071" "ENSDARG00000029764"
##  [61] "ENSDARG00000030110" "ENSDARG00000030756" "ENSDARG00000031222"
##  [64] "ENSDARG00000031894" "ENSDARG00000031952" "ENSDARG00000033327"
##  [67] "ENSDARG00000034375" "ENSDARG00000035648" "ENSDARG00000036254"
##  [70] "ENSDARG00000036558" "ENSDARG00000037109" "ENSDARG00000037675"
##  [73] "ENSDARG00000037677" "ENSDARG00000038006" "ENSDARG00000038428"
##  [76] "ENSDARG00000038672" "ENSDARG00000038879" "ENSDARG00000040764"
##  [79] "ENSDARG00000041609" "ENSDARG00000041706" "ENSDARG00000041799"
##  [82] "ENSDARG00000042296" "ENSDARG00000043130" "ENSDARG00000043559"
##  [85] "ENSDARG00000043923" "ENSDARG00000044574" "ENSDARG00000052131"
##  [88] "ENSDARG00000052139" "ENSDARG00000052344" "ENSDARG00000052652"
##  [91] "ENSDARG00000053479" "ENSDARG00000054026" "ENSDARG00000055026"
##  [94] "ENSDARG00000055027" "ENSDARG00000055381" "ENSDARG00000055398"
##  [97] "ENSDARG00000056427" "ENSDARG00000056995" "ENSDARG00000058115"
## [100] "ENSDARG00000058543" "ENSDARG00000058822" "ENSDARG00000058996"
## [103] "ENSDARG00000059233" "ENSDARG00000059276" "ENSDARG00000059279"
## [106] "ENSDARG00000060808" "ENSDARG00000061328" "ENSDARG00000061345"
## [109] "ENSDARG00000061600" "ENSDARG00000068365" "ENSDARG00000068732"
## [112] "ENSDARG00000069105" "ENSDARG00000069473" "ENSDARG00000070069"
## [115] "ENSDARG00000070670" "ENSDARG00000070903" "ENSDARG00000071336"
## [118] "ENSDARG00000071560" "ENSDARG00000071699" "ENSDARG00000073814"
## [121] "ENSDARG00000074378" "ENSDARG00000075559" "ENSDARG00000075713"
## [124] "ENSDARG00000076010" "ENSDARG00000076554" "ENSDARG00000076566"
## [127] "ENSDARG00000076856" "ENSDARG00000077121" "ENSDARG00000077353"
## [130] "ENSDARG00000077473" "ENSDARG00000078696" "ENSDARG00000078784"
## [133] "ENSDARG00000079027" "ENSDARG00000079201" "ENSDARG00000079922"
## [136] "ENSDARG00000079964" "ENSDARG00000089805" "ENSDARG00000090820"
## [139] "ENSDARG00000091161" "ENSDARG00000092136" "ENSDARG00000092809"
## [142] "ENSDARG00000095743" "ENSDARG00000096546" "ENSDARG00000098359"
## [145] "ENSDARG00000099088" "ENSDARG00000099458" "ENSDARG00000099996"
## [148] "ENSDARG00000100236" "ENSDARG00000100252" "ENSDARG00000100312"
## [151] "ENSDARG00000100558" "ENSDARG00000100725" "ENSDARG00000101076"
## [154] "ENSDARG00000101199" "ENSDARG00000101209" "ENSDARG00000101244"
## [157] "ENSDARG00000101701" "ENSDARG00000101766" "ENSDARG00000101831"
## [160] "ENSDARG00000102153" "ENSDARG00000102470" "ENSDARG00000102750"
## [163] "ENSDARG00000102824" "ENSDARG00000102995" "ENSDARG00000103432"
## [166] "ENSDARG00000103515" "ENSDARG00000103754" "ENSDARG00000103799"
## [169] "ENSDARG00000104353" "ENSDARG00000104808" "ENSDARG00000104815"
## [172] "ENSDARG00000105230"
```

```
# 37 significant genes mapped to this term for Bgee 15.2
annotated <- genesInTerm(myTopAnatObject, term)[["UBERON:0004357"]]
annotated[annotated %in% sigGenes(myTopAnatObject)]
```

```
##  [1] "ENSDARG00000002445" "ENSDARG00000002952" "ENSDARG00000003293"
##  [4] "ENSDARG00000008305" "ENSDARG00000011407" "ENSDARG00000012824"
##  [7] "ENSDARG00000013881" "ENSDARG00000014091" "ENSDARG00000018426"
## [10] "ENSDARG00000018902" "ENSDARG00000019260" "ENSDARG00000019353"
## [13] "ENSDARG00000024894" "ENSDARG00000028071" "ENSDARG00000031894"
## [16] "ENSDARG00000036254" "ENSDARG00000037677" "ENSDARG00000038006"
## [19] "ENSDARG00000038672" "ENSDARG00000041799" "ENSDARG00000042296"
## [22] "ENSDARG00000043559" "ENSDARG00000043923" "ENSDARG00000056427"
## [25] "ENSDARG00000058543" "ENSDARG00000069473" "ENSDARG00000070903"
## [28] "ENSDARG00000071336" "ENSDARG00000073814" "ENSDARG00000076856"
## [31] "ENSDARG00000077121" "ENSDARG00000077353" "ENSDARG00000079027"
## [34] "ENSDARG00000099088" "ENSDARG00000100252" "ENSDARG00000100312"
## [37] "ENSDARG00000101831"
```

*Warning*: it is debated whether FDR correction is appropriate on enrichment test results, since tests on different terms of the ontologies are not independent. A nice discussion can be found in the vignette of the `topGO` package.

#### Store expression data localy

Since version 2.14.0 (Bioconductor 3.11) BgeeDB store downloaded expression data in a local RSQLite database. The advantages of this approach compared to the one used in the previous BgeeDB versions are: \* do not anymore need a server with lot of memory to access to subset of huge dataset (e.g GTeX dataset) \* more granular filtering using arguments in the getSampleProcessedData() function \* do not download twice the same data \* fast access to data once integrated in the local database

This approach comes with some drawbacks : \* the SQLite local database use more disk space than the previously conpressed .rds approach \* first access to a dataset takes more time (integration to SQLite local database is time consuming)

It is possible to remove .rds files generated in previous versions of BgeeDB and not used anymore since version 2.14.0. The function below delete all .rds files for the selected species and for all datatype.

```
bgee <- Bgee$new(species="Mus_musculus", release = "14.1")
# delete all old .rds files of species Mus musculus
deleteOldData(bgee)
```

As the new SQLite approach use more disk space it is now possible to delete all local data of one species from one release of Bgee.

```
bgee <- Bgee$new(species="Mus_musculus", release = "14.1")
# delete local SQLite database of species Mus musculus from Bgee 14.1
deleteLocalData(bgee)
```