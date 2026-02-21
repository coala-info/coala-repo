# Building a simple annotation database

Panagiotis Moulos

#### 30 October 2025

# 1 Simple, flexible and reusable tab-delimited genome annotations

Next Generation Sequencing has introduced a massive need for working with
integer interval data which correspond to actual chromosomal regions, depicted
in linear representations. As a result, previously under-developed algorithms
for working with such data have tremendously evolved. Maybe the most common
application where genomic intervals are used is overlapping a set of query
intervals with a set of reference intervals. One typical example is counting
the reads produced e.g. from an RNA-Seq experiment and assigning them to genes
of interest through overlapping their mapped coordinates with those of the genes
over a reference genome. As a result, collections of such reference genomic
regions for several reference organisms are essential for the quick
interrogation of the latter.

The generation of genomic coordinate systems are nowadays mainstream. Typical
ways of reference genomic region representations are:

* [BED](https://genome.ucsc.edu/FAQ/FAQformat.html#format1) files, which are
  simple tab-delimited files with at least 3 columns including the main reference
  sequence name (e.g. a chromosome), its start and its end.
* More complex structured files such as
  [GTF](https://genome.ucsc.edu/FAQ/FAQformat.html#format4) and
  [GFF](https://genome.ucsc.edu/FAQ/FAQformat.html#format3) which also contain
  structures such as exons, different transcripts anf untranslated regions.

Bioconductor offers great infrastructures for fast genomic interval calculations
which are now very mature, high-level and cover most needs. It also offers
many comprehensive and centrally maintained genomic interval annotation packages
as well as tools to quickly create custom annotation packages, such as
[AnnotationForge](https://bioconductor.org/packages/release/bioc/html/AnnotationForge.html).
These packages, are primarily designed to capture genomic structures (genes,
transcripts, exons etc.) accurately and place them in a genomic interval content
suitable for fast calculations. While this is more than sufficient for many
users and work out-of-the-box, especially for less experienced R users, they may
miss certain characteristics which may be useful also for many users. Such
additional elements are often required by tools that report e.g. transcript
biotypes (such as those in Ensembl) and do not gather mappings between elements
of the same annotation (e.g. gene, transcript, exon ids) in one place in a more
straightforward manner. More specifically, some elements which are not
directly achievable with standard Bioconductor annotation packages include:

* Simple tab-delimited (or in GRanges objects) genomic interval annotations
  capturing several characteristics of these annotations (biotype, GC content).
* Centralization of simple tab-delimited annotations for many organisms and
  several genomic interval types in one package.
* Versioning of these annotations under the same database instead of many,
  dispersed packages which may be difficult to track and upgrade, especially when
  transitioning between Bioconductor versions.
* Gene and transcript versioning (when available, e.g. in NCBI annotations)
  which is essential for applications related to precision medicine and diagnostic
  procedures.
* A unified interface to several genomic interval annotation sources.

SiTaDelA (**Si**mple **Ta**b **Del**imited **A**nnotations), through efficient
and extensive usage of Bioconductor facilites offers these additional
functionalities along with certain levels of automation. More specifically, the
`sitadela` package offers:

* Simple tab-delimited (easily output also as GRanges objects) genomic interval
  annotations for several transcription unit types with additional characteristics
  (gene GC content, biotypes).
* A centralized annotation building and retrieval system, supporting several
  organisms, versions and annotation resources as well as custom user annotations
  coming in GTF/GFF format.
* Versioning of the annotation builds to improve reproducibility and tracking.
* A unified interface to several genomic interval annotation sources which
  automates database build but also fetches annotations on-the-fly if not already
  present in the build.
* Centralized gene and transcript versioning where available (e.g. NCBI),
  especially useful for genomics precision medicine appplications and the
  respective diagnostic processes.
* Additional portability from Bioconductor to other applications through the
  simple database schema adopted.
* Additional attributes such as corrected feature lengths (i.e. corrected
  gene lengths based on sum of lengths of coding regions, to be used e.g. for
  RNA abundance estimation and normalization).

The `sitadela` annotation database building is extremely simple. The user
defines a list of desired annotations (organisms, sources, versions) and
supplies them to the `addAnnotation` function which in turn creates a new or
updates a current database. A custom, non-directly supported organism annotation
can be imported through the `addCustomAnnotation` function and annotations not
needed anymore can be removed with the `removeAnnotation` function. Finally, as
the building can require some time, especially if many organisms and sources are
required for a local database, we maintain pre-built databases which are built
periodically (e.g. upon a new Ensembl release).

# 2 Supported organisms

The following organisms (essentially genome versions) are supported for
automatic database builds:

* Human (*Homo sapiens*) genome version **hg38** (or **GRCh38**)
* Human (*Homo sapiens*) genome version **hg19** (or **GRCh37**)
* Human (*Homo sapiens*) genome version **hg18**
* Mouse (*Mus musculus*) genome version **mm10** (or **GRCm37**)
* Mouse (*Mus musculus*) genome version **mm9**
* Rat (*Rattus norvegicus*) genome version **rn6**
* Rat (*Rattus norvegicus*) genome version **rn5**
* Fruitfly (*Drosophila melanogaster*) genome version **dm6**
* Fruitfly (*Drosophila melanogaster*) genome version **dm3**
* Zebrafish (*Danio rerio*) genome version **danRer7**
* Zebrafish (*Danio rerio*) genome version **danRer10**
* Zebrafish (*Danio rerio*) genome version **danRer11**
* Chimpanzee (*Pan troglodytes*) genome version **panTro4**
* Chimpanzee (*Pan troglodytes*) genome version **panTro5**
* Pig (*Sus scrofa*) genome version **susScr3**
* Pig (*Sus scrofa*) genome version **susScr11**
* Horse (*Equus cabalus*) genome version **equCab2**
* Arabidopsis (*Arabidobsis thaliana*) genome version **TAIR10**

Please note that if genomic annotations from UCSC, RefSeq or NCBI are required,
the following `BSgenome` packages are required (depending on the organisms to
be installed) in order to calculate GC content for gene annotations. Also note
that there is no `BSgenome` package for some of the `sitadela` supported
organisms and therefore GC contents will not be available anyway.

* BSgenome.Hsapiens.UCSC.hg18
* BSgenome.Hsapiens.UCSC.hg19
* BSgenome.Hsapiens.UCSC.hg38
* BSgenome.Mmusculus.UCSC.mm9
* BSgenome.Mmusculus.UCSC.mm10
* BSgenome.Rnorvegicus.UCSC.rn5
* BSgenome.Rnorvegicus.UCSC.rn6
* BSgenome.Dmelanogaster.UCSC.dm3
* BSgenome.Dmelanogaster.UCSC.dm6
* BSgenome.Drerio.UCSC.danRer7
* BSgenome.Drerio.UCSC.danRer10

Is is therefore advised to install these `BSgenome` packages in advance.

# 3 Using the local database

## 3.1 Installation of sitadela

To install the sitadela package, one should start R and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("sitadela")
```

## 3.2 Setup the database

By default, the database file will be written in the
`system.file(package="sitadela")` directory. You can specify another prefered
destination for it using the `db` argument in the function call, but if you do
that, you will have to supply an argument pointing to the SQLite database file
you created to every sitadela package function call you perform, or any other
function that uses sitadela annotations, otherwise, the annotation will be
downloaded and formatted on-the-fly instead of using the local database. Upon
loading `sitadela`, an option is added to the R environment pointing to the
default `sitadela` annotation database. If you wish to change that location and
do not wish to supply the database to other function calls, you can change the
default location of the annotation to your preferred location with the
`setDbPath` function in the beginning of your script/function that uses the
annotation database.

In this vignette, we will build a minimal database comprising only the mouse
*mm10* genome version from Ensembl. The database will be built in a temporary
directory inside session `tempdir()`.

**Important note**: As the annotation build function makes use of
[Kent](http://hgdownload.soe.ucsc.edu/admin/exe/) utilities for creating 3’UTR
annotations from RefSeq and UCSC, the latter cannot be built in Windows.
Therefore it is advised to either build the annotation database in a Linux
system or use our pre-built databases.

```
library(sitadela)

buildDir <- file.path(tempdir(),"test_anndb")
dir.create(buildDir)

# The location of the custom database
myDb <- file.path(buildDir,"testann.sqlite")

# Since we are using Ensembl, we can also ask for a version
organisms <- list(mm10=100)
sources <- ifelse(.Platform$OS.type=="unix",c("ensembl","refseq"),"ensembl")

# If the example is not running in a multicore system, rc is ignored
addAnnotation(organisms,sources,forceDownload=FALSE,db=myDb,rc=0.5)
```

```
##
## ********************************************************
```

```
## This is sitadela 1.18.0 genomic region annotation builder
```

```
## ********************************************************
```

```
## sitadela database found at /tmp/Rtmpt2eKFY/test_anndb directory
```

```
##
## ========================================================
```

```
## 2025-10-30 02:34:37 - Try 1
```

```
## ========================================================
```

```
## Opening sitadela SQLite database /tmp/Rtmpt2eKFY/test_anndb/testann.sqlite
```

```
## Retrieving genome information for mm10 from ensembl
```

```
## Retrieving gene annotation for mm10 from ensembl version 100
```

```
## Using Ensembl host https://apr2020.archive.ensembl.org
```

```
## Retrieving transcript annotation for mm10 from ensembl version 100
```

```
## Using Ensembl host https://apr2020.archive.ensembl.org
```

```
## Merging transcripts for mm10 from ensembl version 100
```

```
## Retrieving 3' UTR annotation for mm10 from ensembl version 100
```

```
## Using Ensembl host https://apr2020.archive.ensembl.org
```

```
## Merging gene 3' UTRs for mm10 from ensembl version 100
```

```
## Merging transcript 3' UTRs for mm10 from ensembl version 100
```

```
## Retrieving exon annotation for mm10 from ensembl version 100
```

```
## Using Ensembl host https://apr2020.archive.ensembl.org
```

```
## Retrieving extended exon annotation for mm10 from ensembl version 100
```

```
## Using Ensembl host https://apr2020.archive.ensembl.org
```

```
## Merging exons for mm10 from ensembl version 100
## Merging exons for mm10 from ensembl version 100
```

```
##
## -------------------------------------------------------
```

```
## Building process complete!
```

```
## -------------------------------------------------------
```

```
## Alternatively
# setDbPath(myDb)
# addAnnotation(organisms,sources,forceDownload=FALSE,rc=0.5)
```

## 3.3 Use the database

Now, that a small database is in place, let’s retrieve some data. Remember that
since the built database is not in the default location, we need to pass the
database file in each data retrieval function. The annotation is retrieved as
a `GRanges` object by default.

```
# Load standard annotation based on gene body coordinates
genes <- loadAnnotation(genome="mm10",refdb="ensembl",type="gene",db=myDb)
genes
```

```
## GRanges object with 55364 ranges and 4 metadata columns:
##                      seqnames            ranges strand |            gene_id
##                         <Rle>         <IRanges>  <Rle> |        <character>
##   ENSMUSG00000102693     chr1   3073253-3074322      + | ENSMUSG00000102693
##   ENSMUSG00000064842     chr1   3102016-3102125      + | ENSMUSG00000064842
##   ENSMUSG00000051951     chr1   3205901-3671498      - | ENSMUSG00000051951
##   ENSMUSG00000102851     chr1   3252757-3253236      + | ENSMUSG00000102851
##   ENSMUSG00000103377     chr1   3365731-3368549      - | ENSMUSG00000103377
##                  ...      ...               ...    ... .                ...
##   ENSMUSG00000095366     chrY 90752427-90755467      - | ENSMUSG00000095366
##   ENSMUSG00000095134     chrY 90753057-90763485      + | ENSMUSG00000095134
##   ENSMUSG00000096768     chrY 90784738-90816465      + | ENSMUSG00000096768
##   ENSMUSG00000099871     chrY 90837413-90844040      + | ENSMUSG00000099871
##   ENSMUSG00000096850     chrY 90838869-90839177      - | ENSMUSG00000096850
##                      gc_content     gene_name                biotype
##                       <numeric>   <character>            <character>
##   ENSMUSG00000102693      34.21 4933401J01Rik                    TEC
##   ENSMUSG00000064842      36.36       Gm26206                  snRNA
##   ENSMUSG00000051951      38.51          Xkr4         protein_coding
##   ENSMUSG00000102851      39.79       Gm18956   processed_pseudogene
##   ENSMUSG00000103377      40.79       Gm37180                    TEC
##                  ...        ...           ...                    ...
##   ENSMUSG00000095366      41.37       Gm21860                lincRNA
##   ENSMUSG00000095134      46.85      Mid1-ps1 unprocessed_pseudogene
##   ENSMUSG00000096768      46.16       Gm47283                lincRNA
##   ENSMUSG00000099871      43.39       Gm21742 unprocessed_pseudogene
##   ENSMUSG00000096850      48.87       Gm21748         protein_coding
##   -------
##   seqinfo: 21 sequences from mm10 genome
```

```
# Load standard annotation based on 3' UTR coordinates
utrs <- loadAnnotation(genome="mm10",refdb="ensembl",type="utr",db=myDb)
utrs
```

```
## GRanges object with 228087 ranges and 4 metadata columns:
##                      seqnames            ranges strand |      transcript_id
##                         <Rle>         <IRanges>  <Rle> |        <character>
##   ENSMUST00000193812     chr1   3074323-3074571      + | ENSMUST00000193812
##   ENSMUST00000082908     chr1   3102126-3102374      + | ENSMUST00000082908
##   ENSMUST00000162897     chr1   3205652-3205900      - | ENSMUST00000162897
##   ENSMUST00000159265     chr1   3206274-3206522      - | ENSMUST00000159265
##   ENSMUST00000070533     chr1   3214233-3214481      - | ENSMUST00000070533
##                  ...      ...               ...    ... .                ...
##   ENSMUST00000177591     chrY 90816465-90816713      + | ENSMUST00000177591
##   ENSMUST00000179077     chrY 90816465-90816713      + | ENSMUST00000179077
##   ENSMUST00000238471     chrY 90816466-90816714      + | ENSMUST00000238471
##   ENSMUST00000179623     chrY 90838620-90838868      - | ENSMUST00000179623
##   ENSMUST00000189352     chrY 90844041-90844289      + | ENSMUST00000189352
##                                 gene_id     gene_name                biotype
##                             <character>   <character>            <character>
##   ENSMUST00000193812 ENSMUSG00000102693 4933401J01Rik                    TEC
##   ENSMUST00000082908 ENSMUSG00000064842       Gm26206                  snRNA
##   ENSMUST00000162897 ENSMUSG00000051951          Xkr4         protein_coding
##   ENSMUST00000159265 ENSMUSG00000051951          Xkr4         protein_coding
##   ENSMUST00000070533 ENSMUSG00000051951          Xkr4         protein_coding
##                  ...                ...           ...                    ...
##   ENSMUST00000177591 ENSMUSG00000096768       Gm47283                lincRNA
##   ENSMUST00000179077 ENSMUSG00000096768       Gm47283                lincRNA
##   ENSMUST00000238471 ENSMUSG00000096768       Gm47283                lincRNA
##   ENSMUST00000179623 ENSMUSG00000096850       Gm21748         protein_coding
##   ENSMUST00000189352 ENSMUSG00000099871       Gm21742 unprocessed_pseudogene
##   -------
##   seqinfo: 21 sequences from mm10 genome
```

```
# Load summarized exon annotation based used with RNA-Seq analysis
sumEx <- loadAnnotation(genome="mm10",refdb="ensembl",type="exon",
    summarized=TRUE,db=myDb)
sumEx
```

```
## GRanges object with 291497 ranges and 4 metadata columns:
##                            seqnames            ranges strand |
##                               <Rle>         <IRanges>  <Rle> |
##   ENSMUSG00000102693_MEX_1     chr1   3073253-3074322      + |
##   ENSMUSG00000064842_MEX_1     chr1   3102016-3102125      + |
##   ENSMUSG00000051951_MEX_4     chr1   3205901-3207317      - |
##   ENSMUSG00000051951_MEX_3     chr1   3213439-3216968      - |
##   ENSMUSG00000102851_MEX_1     chr1   3252757-3253236      + |
##                        ...      ...               ...    ... .
##   ENSMUSG00000099871_MEX_1     chrY 90837413-90837520      + |
##   ENSMUSG00000096850_MEX_1     chrY 90838869-90839177      - |
##   ENSMUSG00000099871_MEX_2     chrY 90841657-90841805      + |
##   ENSMUSG00000099871_MEX_3     chrY 90842898-90843025      + |
##   ENSMUSG00000099871_MEX_4     chrY 90843878-90844040      + |
##                                           exon_id            gene_id
##                                       <character>        <character>
##   ENSMUSG00000102693_MEX_1 ENSMUSG00000102693_M.. ENSMUSG00000102693
##   ENSMUSG00000064842_MEX_1 ENSMUSG00000064842_M.. ENSMUSG00000064842
##   ENSMUSG00000051951_MEX_4 ENSMUSG00000051951_M.. ENSMUSG00000051951
##   ENSMUSG00000051951_MEX_3 ENSMUSG00000051951_M.. ENSMUSG00000051951
##   ENSMUSG00000102851_MEX_1 ENSMUSG00000102851_M.. ENSMUSG00000102851
##                        ...                    ...                ...
##   ENSMUSG00000099871_MEX_1 ENSMUSG00000099871_M.. ENSMUSG00000099871
##   ENSMUSG00000096850_MEX_1 ENSMUSG00000096850_M.. ENSMUSG00000096850
##   ENSMUSG00000099871_MEX_2 ENSMUSG00000099871_M.. ENSMUSG00000099871
##   ENSMUSG00000099871_MEX_3 ENSMUSG00000099871_M.. ENSMUSG00000099871
##   ENSMUSG00000099871_MEX_4 ENSMUSG00000099871_M.. ENSMUSG00000099871
##                                gene_name                biotype
##                              <character>            <character>
##   ENSMUSG00000102693_MEX_1 4933401J01Rik                    TEC
##   ENSMUSG00000064842_MEX_1       Gm26206                  snRNA
##   ENSMUSG00000051951_MEX_4          Xkr4         protein_coding
##   ENSMUSG00000051951_MEX_3          Xkr4         protein_coding
##   ENSMUSG00000102851_MEX_1       Gm18956   processed_pseudogene
##                        ...           ...                    ...
##   ENSMUSG00000099871_MEX_1       Gm21742 unprocessed_pseudogene
##   ENSMUSG00000096850_MEX_1       Gm21748         protein_coding
##   ENSMUSG00000099871_MEX_2       Gm21742 unprocessed_pseudogene
##   ENSMUSG00000099871_MEX_3       Gm21742 unprocessed_pseudogene
##   ENSMUSG00000099871_MEX_4       Gm21742 unprocessed_pseudogene
##   -------
##   seqinfo: 21 sequences from mm10 genome
```

```
## Load standard annotation based on gene body coordinates from RefSeq
#if (.Platform$OS.type=="unix") {
#    refGenes <- loadAnnotation(genome="mm10",refdb="refseq",type="gene",
#        db=myDb)
#    refGenes
#}
```

Or as a data frame if you prefer using `asdf=TRUE`. The data frame however does
not contain metadata like `Seqinfo` to be used for any susequent validations:

```
# Load standard annotation based on gene body coordinates
genes <- loadAnnotation(genome="mm10",refdb="ensembl",type="gene",db=myDb,
    asdf=TRUE)
head(genes)
```

```
##   chromosome   start     end            gene_id gc_content strand     gene_name
## 1       chr1 3073253 3074322 ENSMUSG00000102693      34.21      + 4933401J01Rik
## 2       chr1 3102016 3102125 ENSMUSG00000064842      36.36      +       Gm26206
## 3       chr1 3205901 3671498 ENSMUSG00000051951      38.51      -          Xkr4
## 4       chr1 3252757 3253236 ENSMUSG00000102851      39.79      +       Gm18956
## 5       chr1 3365731 3368549 ENSMUSG00000103377      40.79      -       Gm37180
## 6       chr1 3375556 3377788 ENSMUSG00000104017      36.99      -       Gm37363
##                biotype
## 1                  TEC
## 2                snRNA
## 3       protein_coding
## 4 processed_pseudogene
## 5                  TEC
## 6                  TEC
```

## 3.4 Add a custom annotation

Apart from the supported organisms and databases, you can add a custom
annotation. Such an annotation can be:

* A non-supported organism (e.g. an insect or another mammal e.g. dog)
* A modification or further curation you have done to existing/supported
  annotations
* A supported organism but from a different source
* Any other case where the provided annotations are not adequate

This can be achieved through the usage of
[GTF/GFF](https://www.ensembl.org/info/website/upload/gff.html) files, along
with some simple metadata that you have to provide for proper import to the
annotation database. This can be achieved through the usage of the
`addCustomAnnotation` function. Details on required metadata can be found
in the function’s help page.

**Important note:** Please note that importing a custom genome annotation
directly from UCSC (UCSC SQL database dumps) is not supported in Windows as the
process involves using the `genePredToGtf` which is not available for Windows.

Let’s try a couple of examples. The first one uses example GTF files shipped
with the package. These are sample chromosomes from:

* Atlantic cod (*Gadus morhua*), sequence HE567025
* Armadillo (*Dasypus novemcinctus*), sequence JH569334
* European bass (*Dicentrarchus labrax*), chromosome LG3

Below, we test custom building with reference sequence HE567025 of Atlantic cod:

```
gtf <- system.file(package="sitadela","extdata",
    "gadMor1_HE567025.gtf.gz")
chrom <- system.file(package="sitadela","extdata",
    "gadMor1_HE567025.txt.gz")
chromInfo <- read.delim(chrom,header=FALSE,row.names=1)
names(chromInfo) <- "length"
metadata <- list(
    organism="gadMor1_HE567025",
    source="sitadela_package",
    chromInfo=chromInfo
)
tmpdb <- tempfile()

addCustomAnnotation(gtfFile=gtf,metadata=metadata,db=tmpdb)
```

```
## Opening sitadela SQLite database /tmp/Rtmpt2eKFY/file333ff65b708834
```

```
##   Importing GTF /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/gadMor1_HE567025.gtf.gz as GTF to make id map
```

```
##   Making id map
```

```
##   Importing GTF /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/gadMor1_HE567025.gtf.gz as TxDb
```

```
## Import genomic features from the file as a GRanges object ... OK
## Prepare the 'metadata' data frame ... OK
## Make the TxDb object ... OK
## Retrieving gene annotation for gadmor1_he567025 from sitadela_package version 20251030 from /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/gadMor1_HE567025.gtf.gz
## Retrieving transcript annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving summarized transcript annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving 3' UTR annotation for gadmor1_he567025 from sitadela_package version 20251030
## 3' UTR annotation for gadmor1_he567025 from sitadela_package version 20251030 is not available in the provided GTF file.
## Retrieving summarized 3' UTR annotation per gene for gadmor1_he567025 from sitadela_package version 20251030
## 3' UTR annotation for gadmor1_he567025 from sitadela_package version 20251030 is not available in the provided GTF file.
## Retrieving summarized 3' UTR annotation per transcript for gadmor1_he567025 from sitadela_package version 20251030
## 3' UTR annotation for gadmor1_he567025 from sitadela_package version 20251030 is not available in the provided GTF file.
## Retrieving exon annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving summarized exon annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving extended exon annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving summarized transcript exon annotation for gadmor1_he567025 from sitadela_package version 20251030
```

```
# Try to retrieve some data
g <- loadAnnotation(genome="gadMor1_HE567025",refdb="sitadela_package",
    type="gene",db=tmpdb)
g
```

```
## GRanges object with 48 ranges and 4 metadata columns:
##         seqnames          ranges strand |     gene_id gc_content   gene_name
##            <Rle>       <IRanges>  <Rle> | <character>  <numeric> <character>
##   g8912 HE567025         66-6023      + |       g8912         50       g8912
##   g8913 HE567025     17576-54518      - |       g8913         50       g8913
##   g8914 HE567025     74456-75028      - |       g8914         50       g8914
##   g8915 HE567025    98451-108568      - |       g8915         50       g8915
##   g8916 HE567025   129805-168324      + |       g8916         50       g8916
##     ...      ...             ...    ... .         ...        ...         ...
##   g8955 HE567025   960225-962523      + |       g8955         50       g8955
##   g8956 HE567025   969370-988129      - |       g8956         50       g8956
##   g8957 HE567025  989587-1008879      - |       g8957         50       g8957
##   g8958 HE567025 1018881-1041482      - |       g8958         50       g8958
##   g8959 HE567025 1044660-1068026      + |       g8959         50       g8959
##             biotype
##         <character>
##   g8912        gene
##   g8913        gene
##   g8914        gene
##   g8915        gene
##   g8916        gene
##     ...         ...
##   g8955        gene
##   g8956        gene
##   g8957        gene
##   g8958        gene
##   g8959        gene
##   -------
##   seqinfo: 1 sequence from gadmor1_he567025 genome
```

```
# Delete the temporary database
unlink(tmpdb)
```

The next one is part of a custom annotation for the Ebola virus from UCSC:

```
gtf <- system.file(package="sitadela","extdata",
    "eboVir3_KM034562v1.gtf.gz")
chrom <- system.file(package="sitadela","extdata",
    "eboVir3_KM034562v1.txt.gz")
chromInfo <- read.delim(chrom,header=FALSE,row.names=1)
names(chromInfo) <- "length"
metadata <- list(
    organism="gadMor1_HE567025",
    source="sitadela_package",
    chromInfo=chromInfo
)
tmpdb <- tempfile()

addCustomAnnotation(gtfFile=gtf,metadata=metadata,db=tmpdb)
```

```
## Opening sitadela SQLite database /tmp/Rtmpt2eKFY/file333ff623376b5a
```

```
##   Importing GTF /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/eboVir3_KM034562v1.gtf.gz as GTF to make id map
```

```
##   Making id map
```

```
##   Importing GTF /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/eboVir3_KM034562v1.gtf.gz as TxDb
```

```
## Import genomic features from the file as a GRanges object ... OK
## Prepare the 'metadata' data frame ... OK
## Make the TxDb object ... OK
## Retrieving gene annotation for gadmor1_he567025 from sitadela_package version 20251030 from /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/eboVir3_KM034562v1.gtf.gz
## Retrieving transcript annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving summarized transcript annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving 3' UTR annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving summarized 3' UTR annotation per gene for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving summarized 3' UTR annotation per transcript for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving exon annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving summarized exon annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving extended exon annotation for gadmor1_he567025 from sitadela_package version 20251030
## Retrieving summarized transcript exon annotation for gadmor1_he567025 from sitadela_package version 20251030
```

```
# Try to retrieve some data
g <- loadAnnotation(genome="gadMor1_HE567025",refdb="sitadela_package",
    type="gene",db=tmpdb)
g
```

```
## GRanges object with 9 ranges and 4 metadata columns:
##          seqnames      ranges strand |     gene_id gc_content   gene_name
##             <Rle>   <IRanges>  <Rle> | <character>  <numeric> <character>
##     NP KM034562v1     56-3026      + |          NP         50          NP
##   VP35 KM034562v1   3032-4407      + |        VP35         50        VP35
##   VP40 KM034562v1   4390-5894      + |        VP40         50        VP40
##     GP KM034562v1   5900-8305      + |          GP         50          GP
##    sGP KM034562v1   5900-8305      + |         sGP         50         sGP
##   ssGP KM034562v1   5900-8305      + |        ssGP         50        ssGP
##   VP30 KM034562v1   8288-9740      + |        VP30         50        VP30
##   VP24 KM034562v1  9885-11518      + |        VP24         50        VP24
##      L KM034562v1 11501-18282      + |           L         50           L
##            biotype
##        <character>
##     NP        gene
##   VP35        gene
##   VP40        gene
##     GP        gene
##    sGP        gene
##   ssGP        gene
##   VP30        gene
##   VP24        gene
##      L        gene
##   -------
##   seqinfo: 1 sequence from gadmor1_he567025 genome
```

```
# Delete the temporary database
unlink(tmpdb)
```

Please note that complete annotations from UCSC require the `genePredToGtf`
tool from the UCSC tools base and runs only on Linux. The tool is required
only for building 3’ UTR annotations from UCSC, RefSeq and NCBI, all of which
are being retrieved from the UCSC databases. The next example (full EBOLA virus
annotation, not evaluated) demonstrates how this is done in a Unix based
machine:

```
# Setup a temporary directory to download files etc.
customDir <- file.path(tempdir(),"test_custom")
dir.create(customDir)

# Convert from GenePred to GTF - Unix/Linux only!
if (.Platform$OS.type == "unix" && !grepl("^darwin",R.version$os)) {
    # Download data from UCSC
    goldenPath="http://hgdownload.cse.ucsc.edu/goldenPath/"
    # Gene annotation dump
    download.file(paste0(goldenPath,"eboVir3/database/ncbiGene.txt.gz"),
        file.path(customDir,"eboVir3_ncbiGene.txt.gz"))
    # Chromosome information
    download.file(paste0(goldenPath,"eboVir3/database/chromInfo.txt.gz"),
        file.path(customDir,"eboVir3_chromInfo.txt.gz"))

    # Prepare the build
    chromInfo <- read.delim(file.path(customDir,"eboVir3_chromInfo.txt.gz"),
        header=FALSE)
    chromInfo <- chromInfo[,1:2]
    rownames(chromInfo) <- as.character(chromInfo[,1])
    chromInfo <- chromInfo[,2,drop=FALSE]

    # Coversion from genePred to GTF
    genePredToGtf <- file.path(customDir,"genePredToGtf")
    if (!file.exists(genePredToGtf)) {
        download.file(
        "http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/genePredToGtf",
            genePredToGtf
        )
        system(paste("chmod 775",genePredToGtf))
    }
    gtfFile <- file.path(customDir,"eboVir3.gtf")
    tmpName <- file.path(customDir,paste(format(Sys.time(),"%Y%m%d%H%M%S"),
        "tgtf",sep="."))
    command <- paste0(
        "zcat ",file.path(customDir,"eboVir3_ncbiGene.txt.gz"),
        " | ","cut -f2- | ",genePredToGtf," file stdin ",tmpName,
        " -source=eboVir3"," -utr && grep -vP '\t\\.\t\\.\t' ",tmpName," > ",
        gtfFile
    )
    system(command)

    # Build with the metadata list filled (you can also provide a version)
    addCustomAnnotation(
        gtfFile=gtfFile,
        metadata=list(
            organism="eboVir3_test",
            source="ucsc_test",
            chromInfo=chromInfo
        ),
        db=myDb
    )

    # Try to retrieve some data
    eboGenes <- loadAnnotation(genome="eboVir3_test",refdb="ucsc_test",
        type="gene",db=myDb)
    eboGenes
}
```

Another example, a sample of the Atlantic cod genome annotation from UCSC.

```
gtfFile <- system.file(package="sitadela","extdata",
    "gadMor1_HE567025.gtf.gz")
chromInfo <- read.delim(system.file(package="sitadela","extdata",
    "gadMor1_HE567025.txt.gz"),header=FALSE)

# Build with the metadata list filled (you can also provide a version)
addCustomAnnotation(
    gtfFile=gtfFile,
    metadata=list(
        organism="gadMor1_test",
        source="ucsc_test",
        chromInfo=chromInfo
    ),
    db=myDb
)
```

```
## Opening sitadela SQLite database /tmp/Rtmpt2eKFY/test_anndb/testann.sqlite
```

```
##   Importing GTF /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/gadMor1_HE567025.gtf.gz as GTF to make id map
```

```
##   Making id map
```

```
##   Importing GTF /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/gadMor1_HE567025.gtf.gz as TxDb
```

```
## Import genomic features from the file as a GRanges object ... OK
## Prepare the 'metadata' data frame ... OK
## Make the TxDb object ... OK
## Retrieving gene annotation for gadmor1_test from ucsc_test version 20251030 from /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/gadMor1_HE567025.gtf.gz
## Retrieving transcript annotation for gadmor1_test from ucsc_test version 20251030
## Retrieving summarized transcript annotation for gadmor1_test from ucsc_test version 20251030
## Retrieving 3' UTR annotation for gadmor1_test from ucsc_test version 20251030
## 3' UTR annotation for gadmor1_test from ucsc_test version 20251030 is not available in the provided GTF file.
## Retrieving summarized 3' UTR annotation per gene for gadmor1_test from ucsc_test version 20251030
## 3' UTR annotation for gadmor1_test from ucsc_test version 20251030 is not available in the provided GTF file.
## Retrieving summarized 3' UTR annotation per transcript for gadmor1_test from ucsc_test version 20251030
## 3' UTR annotation for gadmor1_test from ucsc_test version 20251030 is not available in the provided GTF file.
## Retrieving exon annotation for gadmor1_test from ucsc_test version 20251030
## Retrieving summarized exon annotation for gadmor1_test from ucsc_test version 20251030
## Retrieving extended exon annotation for gadmor1_test from ucsc_test version 20251030
## Retrieving summarized transcript exon annotation for gadmor1_test from ucsc_test version 20251030
```

```
# Try to retrieve some data
gadGenes <- loadAnnotation(genome="gadMor1_test",refdb="ucsc_test",
    type="gene",db=myDb)
gadGenes
```

```
## GRanges object with 48 ranges and 4 metadata columns:
##         seqnames          ranges strand |     gene_id gc_content   gene_name
##            <Rle>       <IRanges>  <Rle> | <character>  <numeric> <character>
##   g8912        1         66-6023      + |       g8912         50       g8912
##   g8913        1     17576-54518      - |       g8913         50       g8913
##   g8914        1     74456-75028      - |       g8914         50       g8914
##   g8915        1    98451-108568      - |       g8915         50       g8915
##   g8916        1   129805-168324      + |       g8916         50       g8916
##     ...      ...             ...    ... .         ...        ...         ...
##   g8955        1   960225-962523      + |       g8955         50       g8955
##   g8956        1   969370-988129      - |       g8956         50       g8956
##   g8957        1  989587-1008879      - |       g8957         50       g8957
##   g8958        1 1018881-1041482      - |       g8958         50       g8958
##   g8959        1 1044660-1068026      + |       g8959         50       g8959
##             biotype
##         <character>
##   g8912        gene
##   g8913        gene
##   g8914        gene
##   g8915        gene
##   g8916        gene
##     ...         ...
##   g8955        gene
##   g8956        gene
##   g8957        gene
##   g8958        gene
##   g8959        gene
##   -------
##   seqinfo: 1 sequence from gadmor1_test genome; no seqlengths
```

Another example, Armadillo from Ensembl. This should work irrespectively of
operating system. We are downloading chromosomal information from UCSC. Again,
a small dataset included in the package is included in this vignette. See the
commented code below for the full annotation case.

```
gtfFile <- system.file(package="sitadela","extdata",
    "dasNov3_JH569334.gtf.gz")
chromInfo <- read.delim(system.file(package="sitadela",
    "extdata","dasNov3_JH569334.txt.gz"),header=FALSE)

# Build with the metadata list filled (you can also provide a version)
addCustomAnnotation(
    gtfFile=gtfFile,
    metadata=list(
        organism="dasNov3_test",
        source="ensembl_test",
        chromInfo=chromInfo
    ),
    db=myDb
)
```

```
## Opening sitadela SQLite database /tmp/Rtmpt2eKFY/test_anndb/testann.sqlite
```

```
##   Importing GTF /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/dasNov3_JH569334.gtf.gz as GTF to make id map
```

```
##   Making id map
```

```
##   Importing GTF /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/dasNov3_JH569334.gtf.gz as TxDb
```

```
## Import genomic features from the file as a GRanges object ... OK
## Prepare the 'metadata' data frame ... OK
## Make the TxDb object ... OK
## Retrieving gene annotation for dasnov3_test from ensembl_test version 20251030 from /tmp/Rtmp8FID9Y/Rinst3339b2452006c7/sitadela/extdata/dasNov3_JH569334.gtf.gz
## Retrieving transcript annotation for dasnov3_test from ensembl_test version 20251030
## Retrieving summarized transcript annotation for dasnov3_test from ensembl_test version 20251030
## Retrieving 3' UTR annotation for dasnov3_test from ensembl_test version 20251030
## Retrieving summarized 3' UTR annotation per gene for dasnov3_test from ensembl_test version 20251030
## Retrieving summarized 3' UTR annotation per transcript for dasnov3_test from ensembl_test version 20251030
## Retrieving exon annotation for dasnov3_test from ensembl_test version 20251030
## Retrieving summarized exon annotation for dasnov3_test from ensembl_test version 20251030
## Retrieving extended exon annotation for dasnov3_test from ensembl_test version 20251030
## Retrieving summarized transcript exon annotation for dasnov3_test from ensembl_test version 20251030
```

```
# Try to retrieve some data
dasGenes <- loadAnnotation(genome="dasNov3_test",refdb="ensembl_test",
    type="gene",db=myDb)
dasGenes
```

```
## GRanges object with 49 ranges and 4 metadata columns:
##                      seqnames          ranges strand |            gene_id
##                         <Rle>       <IRanges>  <Rle> |        <character>
##   ENSDNOG00000040310        1     39921-57597      + | ENSDNOG00000040310
##   ENSDNOG00000026053        1     75778-75866      - | ENSDNOG00000026053
##   ENSDNOG00000047749        1   107506-107609      - | ENSDNOG00000047749
##   ENSDNOG00000049646        1   118767-167082      - | ENSDNOG00000049646
##   ENSDNOG00000019696        1   234318-380483      + | ENSDNOG00000019696
##                  ...      ...             ...    ... .                ...
##   ENSDNOG00000031698        1 4891267-5067477      + | ENSDNOG00000031698
##   ENSDNOG00000040409        1 4967800-4968430      + | ENSDNOG00000040409
##   ENSDNOG00000036092        1 5130036-5232074      - | ENSDNOG00000036092
##   ENSDNOG00000050381        1 5345174-5346286      - | ENSDNOG00000050381
##   ENSDNOG00000050589        1 5370552-5414125      + | ENSDNOG00000050589
##                      gc_content          gene_name        biotype
##                       <numeric>        <character>    <character>
##   ENSDNOG00000040310         50             SNRPD1 protein_coding
##   ENSDNOG00000026053         50            SNORA63         snoRNA
##   ENSDNOG00000047749         50 ENSDNOG00000047749         snoRNA
##   ENSDNOG00000049646         50              ABHD3 protein_coding
##   ENSDNOG00000019696         50               MIB1 protein_coding
##                  ...        ...                ...            ...
##   ENSDNOG00000031698         50              TAF4B protein_coding
##   ENSDNOG00000040409         50 ENSDNOG00000040409 protein_coding
##   ENSDNOG00000036092         50 ENSDNOG00000036092 protein_coding
##   ENSDNOG00000050381         50 ENSDNOG00000050381        lincRNA
##   ENSDNOG00000050589         50 ENSDNOG00000050589        lincRNA
##   -------
##   seqinfo: 1 sequence from dasnov3_test genome; no seqlengths
```

## 3.5 A complete build

A quite complete build (with latest versions of Ensembl annotations) would look
like (supposing the default annotation database location):

```
organisms <- list(
    hg18=54,
    hg19=75,
    hg38=110:111,
    mm9=54,
    mm10=110:111,
    rn5=77,
    rn6=110:111,
    dm3=77,
    dm6=110:111,
    danrer7=77,
    danrer10=80,
    danrer11=110:111,
    pantro4=80,
    pantro5=110:111,
    susscr3=80,
    susscr11=110:111,
    equcab2=110:111
)

sources <- c("ensembl","ucsc","refseq","ncbi")

addAnnotation(organisms,sources,forceDownload=FALSE,rc=0.5)
```

The aforementioned complete built can be found
[here](https://drive.google.com/drive/folders/14vIQBL2iNlVtHkhhbjSMwt04-ZuDAuuR?usp=sharing)
Complete builts will become available from time to time (e.g. with every new
Ensembl relrase) for users who do not wish to create annotation databases on
their own. Root access may be required (depending on the sitadela library
location) to place it in the default location where it can be found
automatically.

# 4 Annotations on-the-fly

If for some reason you do not want to build and use an annotation database but
you wish to benefit from the sitadela simple formats nonetheless, or even to
work with an organism that does not yet exist in the database, the
`loadAnnotation` function will perform all required actions (download and create
a `GRanges` object) on-the-fly as long as there is an internet connection.
However, the aforementioned function does not handle custom annotations in GTF
files. In that case, you should use the `importCustomAnnotation` function with
a list describing the GTF file, that is:

```
metadata <- list(
    organism="ORGANISM_NAME",
    source="SOURCE_NAME",
    chromInfo="CHROM_INFO"
)
```

The above argument can be passed to the `importCustomAnnotation` call in the
respective position.

For further details about custom annotations on the fly, please check
`addCustomAnnotation` and `importCustomAnnotation` functions.

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
## [1] sitadela_1.18.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] blob_1.2.4                  filelock_1.0.3
##  [5] Biostrings_2.78.0           bitops_1.0-9
##  [7] fastmap_1.2.0               RCurl_1.98-1.17
##  [9] BiocFileCache_3.0.0         GenomicAlignments_1.46.0
## [11] XML_3.99-0.19               digest_0.6.37
## [13] lifecycle_1.0.4             KEGGREST_1.50.0
## [15] RSQLite_2.4.3               magrittr_2.0.4
## [17] compiler_4.5.1              rlang_1.1.6
## [19] sass_0.4.10                 progress_1.2.3
## [21] tools_4.5.1                 yaml_2.3.10
## [23] rtracklayer_1.70.0          knitr_1.50
## [25] prettyunits_1.2.0           S4Arrays_1.10.0
## [27] bit_4.6.0                   curl_7.0.0
## [29] DelayedArray_0.36.0         xml2_1.4.1
## [31] abind_1.4-8                 BiocParallel_1.44.0
## [33] withr_3.0.2                 purrr_1.1.0
## [35] txdbmaker_1.6.0             BiocGenerics_0.56.0
## [37] grid_4.5.1                  stats4_4.5.1
## [39] biomaRt_2.66.0              SummarizedExperiment_1.40.0
## [41] cli_3.6.5                   rmarkdown_2.30
## [43] crayon_1.5.3                generics_0.1.4
## [45] httr_1.4.7                  rjson_0.2.23
## [47] DBI_1.2.3                   cachem_1.1.0
## [49] stringr_1.5.2               parallel_4.5.1
## [51] AnnotationDbi_1.72.0        BiocManager_1.30.26
## [53] XVector_0.50.0              restfulr_0.0.16
## [55] matrixStats_1.5.0           vctrs_0.6.5
## [57] Matrix_1.7-4                jsonlite_2.0.0
## [59] bookdown_0.45               IRanges_2.44.0
## [61] hms_1.1.4                   S4Vectors_0.48.0
## [63] bit64_4.6.0-1               GenomicFeatures_1.62.0
## [65] jquerylib_0.1.4             glue_1.8.0
## [67] codetools_0.2-20            stringi_1.8.7
## [69] GenomeInfoDb_1.46.0         GenomicRanges_1.62.0
## [71] BiocIO_1.20.0               UCSC.utils_1.6.0
## [73] tibble_3.3.0                pillar_1.11.1
## [75] rappdirs_0.3.3              htmltools_0.5.8.1
## [77] Seqinfo_1.0.0               R6_2.6.1
## [79] dbplyr_2.5.1                httr2_1.2.1
## [81] evaluate_1.0.5              Biobase_2.70.0
## [83] lattice_0.22-7              cigarillo_1.0.0
## [85] png_0.1-8                   Rsamtools_2.26.0
## [87] memoise_2.0.1               bslib_0.9.0
## [89] SparseArray_1.10.0          xfun_0.53
## [91] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```