# OrganismDbi: A meta framework for Annotation Packages

Marc Carlson and Aliyu Atiku Mustapha1

1Vignette translation from Sweave to Rmarkdown / HTML.

#### October 30, 2025

#### Package

OrganismDbi 1.52.0

# Contents

* [1 Getting started with OrganismDbi](#getting-started-with-organismdbi)
* [2 Making your own OrganismDbi packages](#making-your-own-organismdbi-packages)

*[OrganismDbi](https://bioconductor.org/packages/3.22/OrganismDbi)* is a software package that helps tie together
different annotation resources. It is expected that users may have previously
made or seen packages like *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* and
*[TxDb.Hsapiens.UCSC.hg19.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg19.knownGene)*. Packages like these two are
very different and contain very different kinds of information, but are still
about the same organism: Homo sapiens. The *[OrganismDbi](https://bioconductor.org/packages/3.22/OrganismDbi)* package
allows us to combine resources like these together into a single package
resource, which can represent ALL of these resources at the same time. An
example of this is the *[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)* package, which combines
access to the two resources above along with others.

This is made possible because the packages that are represented by
*[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)* are related to each other via foreign keys.

![Relationships between Annotation packages](data:image/png;base64...)

Figure 1: Relationships between Annotation packages

# 1 Getting started with OrganismDbi

Usage of a package like this has been deliberately kept very simple. The methods
supported are the same ones that work for all the packages based on
*AnnotationDb* objects. The methods that can be applied to these new packages
are `columns`, `keys`, `keytypes` and `select`.

So to learn which kinds of data can be retrieved from a package like this we
would simply load the package and then call the `columns` method.

```
library(Homo.sapiens)
columns(Homo.sapiens)
```

```
##  [1] "ACCNUM"       "ALIAS"        "CDSCHROM"     "CDSEND"       "CDSID"
##  [6] "CDSNAME"      "CDSPHASE"     "CDSSTART"     "CDSSTRAND"    "DEFINITION"
## [11] "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS" "ENTREZID"     "ENZYME"
## [16] "EVIDENCE"     "EVIDENCEALL"  "EXONCHROM"    "EXONEND"      "EXONID"
## [21] "EXONNAME"     "EXONRANK"     "EXONSTART"    "EXONSTRAND"   "GENEID"
## [26] "GENENAME"     "GENETYPE"     "GO"           "GOALL"        "GOID"
## [31] "IPI"          "MAP"          "OMIM"         "ONTOLOGY"     "ONTOLOGYALL"
## [36] "PATH"         "PFAM"         "PMID"         "PROSITE"      "REFSEQ"
## [41] "SYMBOL"       "TERM"         "TXCHROM"      "TXEND"        "TXID"
## [46] "TXNAME"       "TXSTART"      "TXSTRAND"     "TXTYPE"       "UCSCKG"
## [51] "UNIPROT"
```

To learn which of those kinds of data can be used as keys to extract data, we
use the `keytypes` method.

```
keytypes(Homo.sapiens)
```

```
##  [1] "ACCNUM"       "ALIAS"        "CDSID"        "CDSNAME"      "DEFINITION"
##  [6] "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS" "ENTREZID"     "ENZYME"
## [11] "EVIDENCE"     "EVIDENCEALL"  "EXONID"       "EXONNAME"     "GENEID"
## [16] "GENENAME"     "GENETYPE"     "GO"           "GOALL"        "GOID"
## [21] "IPI"          "MAP"          "OMIM"         "ONTOLOGY"     "ONTOLOGYALL"
## [26] "PATH"         "PFAM"         "PMID"         "PROSITE"      "REFSEQ"
## [31] "SYMBOL"       "TERM"         "TXID"         "TXNAME"       "UCSCKG"
## [36] "UNIPROT"
```

To extract specific keys, we need to use the `keys` method, and also provide it
a legitimate keytype:

```
head(keys(Homo.sapiens, keytype = "ENTREZID"))
```

```
## [1] "1"  "2"  "9"  "10" "11" "12"
```

And to extract data, we can use the `select` method. The select method depends
on the values from the previous three methods to specify what it will extract.
Here is an example that will extract, UCSC transcript names, and gene symbols
using Entrez Gene IDs as keys.

```
k <- head(keys(Homo.sapiens, keytype = "ENTREZID"), n = 3)
select(
  Homo.sapiens,
  keys = k,
  columns = c("TXNAME", "SYMBOL"),
  keytype = "ENTREZID"
)
```

```
##    ENTREZID SYMBOL               TXNAME
## 1         1   A1BG  ENST00000596924.1_3
## 2         1   A1BG  ENST00000263100.8_8
## 3         1   A1BG  ENST00000850949.1_1
## 4         1   A1BG  ENST00000850950.1_1
## 5         1   A1BG  ENST00000600123.5_4
## 6         1   A1BG  ENST00000595014.1_3
## 7         1   A1BG  ENST00000598345.2_4
## 8         1   A1BG  ENST00000599109.5_5
## 9         1   A1BG  ENST00000600966.1_7
## 10        1   A1BG  ENST00000596636.1_3
## 11        2    A2M  ENST00000543436.2_3
## 12        2    A2M ENST00000318602.12_7
## 13        2    A2M  ENST00000495442.1_3
## 14        2    A2M  ENST00000495709.1_3
## 15        2    A2M  ENST00000545828.1_3
## 16        2    A2M  ENST00000542567.1_3
## 17        2    A2M  ENST00000462568.1_3
## 18        2    A2M  ENST00000546069.1_4
## 19        2    A2M  ENST00000472360.1_3
## 20        2    A2M  ENST00000539638.5_4
## 21        2    A2M  ENST00000404455.2_7
## 22        2    A2M  ENST00000467091.1_3
## 23        2    A2M  ENST00000497324.1_3
## 24        9   NAT1  ENST00000517441.5_1
## 25        9   NAT1  ENST00000307719.9_4
## 26        9   NAT1  ENST00000518029.5_1
## 27        9   NAT1  ENST00000517574.5_1
## 28        9   NAT1  ENST00000519006.5_1
## 29        9   NAT1  ENST00000545197.3_2
## 30        9   NAT1  ENST00000517492.5_1
## 31        9   NAT1  ENST00000520546.1_1
```

In addition to `select`, some of the more popular range based methods have also
been updated to work with an *AnnotationDb* object. So for example you could
extract transcript information like this:

```
transcripts(Homo.sapiens, columns = c("TXNAME", "SYMBOL"))
```

```
## GRanges object with 381987 ranges and 2 metadata columns:
##            seqnames      ranges strand |              TXNAME          SYMBOL
##               <Rle>   <IRanges>  <Rle> |     <CharacterList> <CharacterList>
##        [1]     chr1 10370-10582      + | ENST00000833856.1_2            <NA>
##        [2]     chr1 11121-14413      + | ENST00000832824.1_1         DDX11L1
##        [3]     chr1 11125-14405      + | ENST00000832825.1_1         DDX11L1
##        [4]     chr1 11410-14413      + | ENST00000832826.1_1         DDX11L1
##        [5]     chr1 11411-14413      + | ENST00000832827.1_1         DDX11L1
##        ...      ...         ...    ... .                 ...             ...
##   [381983]    chrMT   5826-5891      - |   ENST00000387409.1            <NA>
##   [381984]    chrMT   7446-7514      - |   ENST00000387416.2            <NA>
##   [381985]    chrMT 14149-14673      - | ENST00000361681.2_5            <NA>
##   [381986]    chrMT 14674-14742      - |   ENST00000387459.1            <NA>
##   [381987]    chrMT 15956-16023      - |   ENST00000387461.2            <NA>
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
```

And the *GRanges* object that would be returned would have the information that
you specified in the columns argument. You could also have used the `exons` or
`cds` methods in this way.

The `transcriptsBy`,`exonsBy` and `cdsBy` methods are also supported. For
example:

```
transcriptsBy(Homo.sapiens,
              by = "gene",
              columns = c("TXNAME", "SYMBOL"))
```

```
## GRangesList object of length 28646:
## $`1`
## GRanges object with 10 ranges and 3 metadata columns:
##        seqnames            ranges strand |             tx_name
##           <Rle>         <IRanges>  <Rle> |         <character>
##    [1]    chr19 58856544-58859000      - | ENST00000596924.1_3
##    [2]    chr19 58856549-58864858      - | ENST00000263100.8_8
##    [3]    chr19 58856549-58864858      - | ENST00000850949.1_1
##    [4]    chr19 58856549-58864858      - | ENST00000850950.1_1
##    [5]    chr19 58858220-58867591      - | ENST00000600123.5_4
##    [6]    chr19 58858224-58864857      - | ENST00000595014.1_3
##    [7]    chr19 58858226-58859023      - | ENST00000598345.2_4
##    [8]    chr19 58859832-58874117      - | ENST00000599109.5_5
##    [9]    chr19 58861960-58864495      - | ENST00000600966.1_7
##   [10]    chr19 58864387-58867449      - | ENST00000596636.1_3
##                     TXNAME          SYMBOL
##            <CharacterList> <CharacterList>
##    [1] ENST00000596924.1_3            A1BG
##    [2] ENST00000263100.8_8            A1BG
##    [3] ENST00000850949.1_1            A1BG
##    [4] ENST00000850950.1_1            A1BG
##    [5] ENST00000600123.5_4            A1BG
##    [6] ENST00000595014.1_3            A1BG
##    [7] ENST00000598345.2_4            A1BG
##    [8] ENST00000599109.5_5            A1BG
##    [9] ENST00000600966.1_7            A1BG
##   [10] ENST00000596636.1_3            A1BG
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
##
## $`10`
## GRanges object with 2 ranges and 3 metadata columns:
##       seqnames            ranges strand |             tx_name
##          <Rle>         <IRanges>  <Rle> |         <character>
##   [1]     chr8 18248792-18258728      + | ENST00000286479.4_4
##   [2]     chr8 18248797-18258503      + | ENST00000520116.1_2
##                    TXNAME          SYMBOL
##           <CharacterList> <CharacterList>
##   [1] ENST00000286479.4_4            NAT2
##   [2] ENST00000520116.1_2            NAT2
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
##
## ...
## <28644 more elements>
```

# 2 Making your own OrganismDbi packages

So in the preceding section you can see that using an *[OrganismDbi](https://bioconductor.org/packages/3.22/OrganismDbi)*
package behaves very similarly to how you might use a `TxDb` or an `OrgDb`
package. The same methods are defined, and they behave similarly except that
they now have access to much more data than before. But before you make your own
*[OrganismDbi](https://bioconductor.org/packages/3.22/OrganismDbi)* package you need to understand that there are few
logical limitations for what can be included in this kind of package.

* The 1st limitation is that all the annotation resources in question must
  have implemented the four methods described in the preceding section (`columns`,
  `keys`, `keytypes` and `select`).
* The 2nd limitation is that you cannot have more than one example
  of each field that can be retrieved from each type of package that is included.
  So basically, all values returned by `columns` must be unique across ALL of the
  supporting packages.
* The 3rd limitation is that you cannot have more than one example of
  each object type represented. So you cannot have two org packages since that
  would introduce two `OrgDb` objects.
* And the 4th limitation is that you cannot have cycles in the graph.
  What this means is that there will be a graph that represents the relationships
  between the different object types in your package, and this graph must not
  present more than one pathway between any two nodes/objects. This limitation
  means that you can choose one foreign key relationship to connect any two
  packages in your graph.

With these limitations in mind, lets set up an example. Lets show how we could
make *[Homo.sapiens](https://bioconductor.org/packages/3.22/Homo.sapiens)*, such that it allowed access to
*[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)*,
*[TxDb.Hsapiens.UCSC.hg19.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg19.knownGene)* and
*[GO.db](https://bioconductor.org/packages/3.22/GO.db)*.

The 1st thing that we need to do is set up a list that expresses the way that
these different packages relate to each other. To do this, we make a list that
contains short two element long character vectors. Each character vector
represents one relationship between a pair of packages. The names of the vectors
are the package names and the values are the foreign keys. Please note that the
foreign key values in these vectors are the same strings that are returned by
the `columns` method for the individual packages. Here is an example that shows
how *[GO.db](https://bioconductor.org/packages/3.22/GO.db)*, *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* and
*[TxDb.Hsapiens.UCSC.hg19.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg19.knownGene)* all relate to each
other.

```
gd <- list(
  join1 = c(GO.db = "GOID", org.Hs.eg.db = "GO"),
  join2 = c(
    org.Hs.eg.db = "ENTREZID",
    TxDb.Hsapiens.UCSC.hg19.knownGene = "GENEID"
  )
)
```

So this `data.frame` indicates both which packages are connected to each other,
and also what these connections are using for foreign keys. Once this is
finished, we just have to call the `makeOrganismPackage` function
to finish the task.

```
destination <- tempfile()
dir.create(destination)
makeOrganismPackage(
  pkgname = "Homo.sapiens",
  graphData = gd,
  organism = "Homo sapiens",
  version = "1.0.0",
  maintainer = "Package Maintainer<maintainer@somewhere.org>",
  author = "Some Body",
  destDir = destination,
  license = "Artistic-2.0"
)
```

`makeOrganismPackage` will then generate a lightweight package
that you can install. This package will not contain all the data that it refers
to, but will instead depend on the packages that were referred to in the
`data.frame`. Because the end result will be a package that treats all the data
mapped together as a single source, the user is encouraged to take extra care to
ensure that the different packages used are from the same build etc.