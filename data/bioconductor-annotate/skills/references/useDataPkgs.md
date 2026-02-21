# Using Bioconductor’s Annotation Libraries

Marc Carlson, Jianhua Zhang and Manvi Yaduvanshi1

1Vignette translation from Sweave to R Markdown / HTML

#### 29 October, 2025

# Contents

* [1 Overview](#overview)
* [2 Contents](#contents)
* [3 Usage](#usage)
  + [Package installation](#package-installation)
  + [Documentations](#documentations)
  + [Accessing annotation data within a library](#accessing-annotation-data-within-a-library)
  + [Accessing annotation data across libraries](#accessing-annotation-data-across-libraries)
* [4 Session Information](#session-information)

# 1 Overview

The Bioconductor project maintains a rich body of annotation data
assembled into R libraries. The purpose of this vignette is to discuss
the structure, contents, and usage of these annotation data libraries.
Executable code is provided as examples.

# 2 Contents

Bioconductor’s annotation data libraries are constructed by assembling
data collected from various public data repositories using
Bioconductor’s *[AnnotationDbi](https://bioconductor.org/packages/3.22/AnnotationDbi)* package and distributed as regular R
libraries that can be installed and loaded in the same way an R library
is installed/loaded. Each annotation library is an independent unit that
can be used alone or in conjunction with other annotation libraries.
Platform specific libraries are a group annotation libraries assembled
specifically for given platforms (e. g. Affymetrix HG\_U95Av2).
`org.XX.eg.db` are libraries containing data assembled at genome level
for specific organisms such as human, mouse, fly, or rat.
KEGG.db111 Deprecated in Bioconductor 3.13 and *[GO.db](https://bioconductor.org/packages/3.22/GO.db)* are source
specific libraries containing generic data for various genomes.

Each annotation library, when installed, contains a sqlite database
contained within the `extdata` along with a `man` subdirectory filled
with documentation about the data. The data can be accessed using the
standard methods that would work for the classic environment objects
(hash table with key-value pairs) and act as if they were simple
associations of annotation values to a set of keys. For each of these
emulated environment objects (which we will refer to as mappings), there
is a corresponding help file in the `man` directory with detail
descriptions of the data file and usage. In addition to the traditional
access to these data, these databases can also be accessed directly by
using DBI interfaces which allow for powerful new combinations of these
data.

Each platform specific library creates a series of these mapping objects
named by following the convention of package name plus mapping name. The
package name is in lower case letters and the mapping names are in
capital letters. When a given mapping maps platform specific keys to
annotation data, only the name of the annotation data is used for the
name of the mapping. Otherwise, the mapping names have a pattern of key
name and value name joined by a “2” in between. For example,
`hgu95av2ENTREZID` maps probe ids on an Affymetrix human genome U95Av2
chip to EntrezGene IDs while `hgu95av2GO2PROBE` maps Gene Ontology IDs
to probe IDs. Names of the mappings available in a platform specific
data package are not listed here to save space but are easily accessible
as shown later in the section for usage.

Genome level annotation libraries are named in the form of org.Xx.yy.db
where Xx represents an abbreviation of the genus and species. Each of
the organism wide genome annotation packages is based upon some type of
widely used gene based identifier (such as an Entrez Gene id) that is
mapped onto all the other features in the package. The yy part of the
name corresponds to this designation, where eg means a package is an
entrez gene package and sgd is a package based on the sgd database etc.
In many cases the org packages will contain more different kinds of
information that the platform based ones, since not all types of
information are as widely sought after.

The KEGG.db library contains mappings between ids such as Entrez Gene
IDs and *GO* to *KEGG* pathway ids and thus also to pathway names. The
*[GO.db](https://bioconductor.org/packages/3.22/GO.db)* library maintain the directed acyclic graph structure of the
original data from Gene Ontology Consortium by providing mappings of GO
ids to their direct parents or children for each of the three categories
(molecular function, cellular component, and biological process).
Mappings between Entrez Gene and *GO* ids are also available to
complement the *[GO.db](https://bioconductor.org/packages/3.22/GO.db)* package. These mappings are found within the
organism wide packages mentioned above. These mappings are provided with
evidence code that specifies the type of evidence that supports the
annotation of a gene to a particular *GO* term.

# 3 Usage

All the annotation libraries can be obtained from <https://www.bioconductor.org>.
To illustrate their usages, we use the library for Affymetrix HG\_U95Av2 chip
*[hgu95av2.db](https://bioconductor.org/packages/3.22/hgu95av2.db)* as an example for platform specific data packages
and the *[GO.db](https://bioconductor.org/packages/3.22/GO.db)* library for non-platform specific data packages. We
assume that [R](www.r-project.org) and Bioconductor’s *[Biobase](https://bioconductor.org/packages/3.22/Biobase)* and
*[annotation](https://bioconductor.org/packages/3.22/annotation)*.

## Package installation

Download libraries *[hgu95av2.db](https://bioconductor.org/packages/3.22/hgu95av2.db)* and *[GO.db](https://bioconductor.org/packages/3.22/GO.db)* with
`BiocManager::install()`.

Typing `library(library name)` in an R session will load the library into
R. For example,

```
library("annotate")
library("hgu95av2.db")
library("GO.db")
```

## Documentations

Each library contains documentation for the library in general and each
of the individual mapping objects contained by the library. Two
documents at the library level can be accessed by typing a library
basename proceeded by a question mark (e. g. `?hgu95av2`) and the library
basename followed by a pair of brackets (e. g. `hgu95av2()`),
respectively. The former explains what the package is and details how a
user can get more information, while the latter lists all the mappings
contained by a library and provides information on the total number of
keys within each of the maps contained by the library and how many of
these keys are annotated. In addition, the latter will indicate the
sources for the information provided by the package as well as the date
that these sources claim to have last been updated.

The documentation for a given mapping object can be accessed by typing
the name of a mapping object proceeded by a question mark (e. g.
`hgu95av2GO`). The resulting documentation provides detail explanations
to the mapping object, data source used to build the object, and example
code for accessing annotation data.

## Accessing annotation data within a library

Annotation data of a given library are stored as mapping objects in the
form of key (items to be annotated) and value (annotation for an key
item) pairs. Each mapping object provides annotation for keys for a
particular subject reflected by the name of the object. For example,
`hgu95av2GO` annotates probes on the HGU95Av2 chip with ids
of the Gene Ontology terms the probes correspond to.

The name of an mapping object consists of package basename
(*[hgu95av2.db](https://bioconductor.org/packages/3.22/hgu95av2.db)*) and mapping name *GO* to avoid confusion when multiple
libraries are loaded to the system at the same time. Data contained by
an mapping can be accessed easily using Bioconductor’s existing
functions. For example, the following code stores all the keys contained
by the `hgu95av2GO` mapping object to variable `temp` and displays the
first five keys on the screen:

```
as.list(hgu95av2GO[5])
```

```
## $`1004_at`
## $`1004_at`$`GO:0006935`
## $`1004_at`$`GO:0006935`$GOID
## [1] "GO:0006935"
##
## $`1004_at`$`GO:0006935`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0006935`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0006955`
## $`1004_at`$`GO:0006955`$GOID
## [1] "GO:0006955"
##
## $`1004_at`$`GO:0006955`$Evidence
## [1] "IBA"
##
## $`1004_at`$`GO:0006955`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0006955`
## $`1004_at`$`GO:0006955`$GOID
## [1] "GO:0006955"
##
## $`1004_at`$`GO:0006955`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0006955`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0007165`
## $`1004_at`$`GO:0007165`$GOID
## [1] "GO:0007165"
##
## $`1004_at`$`GO:0007165`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0007165`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0007186`
## $`1004_at`$`GO:0007186`$GOID
## [1] "GO:0007186"
##
## $`1004_at`$`GO:0007186`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0007186`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0007186`
## $`1004_at`$`GO:0007186`$GOID
## [1] "GO:0007186"
##
## $`1004_at`$`GO:0007186`$Evidence
## [1] "TAS"
##
## $`1004_at`$`GO:0007186`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0007204`
## $`1004_at`$`GO:0007204`$GOID
## [1] "GO:0007204"
##
## $`1004_at`$`GO:0007204`$Evidence
## [1] "IBA"
##
## $`1004_at`$`GO:0007204`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0019722`
## $`1004_at`$`GO:0019722`$GOID
## [1] "GO:0019722"
##
## $`1004_at`$`GO:0019722`$Evidence
## [1] "IBA"
##
## $`1004_at`$`GO:0019722`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0030595`
## $`1004_at`$`GO:0030595`$GOID
## [1] "GO:0030595"
##
## $`1004_at`$`GO:0030595`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0030595`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0032467`
## $`1004_at`$`GO:0032467`$GOID
## [1] "GO:0032467"
##
## $`1004_at`$`GO:0032467`$Evidence
## [1] "IMP"
##
## $`1004_at`$`GO:0032467`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0042113`
## $`1004_at`$`GO:0042113`$GOID
## [1] "GO:0042113"
##
## $`1004_at`$`GO:0042113`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0042113`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0048535`
## $`1004_at`$`GO:0048535`$GOID
## [1] "GO:0048535"
##
## $`1004_at`$`GO:0048535`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0048535`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0060326`
## $`1004_at`$`GO:0060326`$GOID
## [1] "GO:0060326"
##
## $`1004_at`$`GO:0060326`$Evidence
## [1] "IBA"
##
## $`1004_at`$`GO:0060326`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0070098`
## $`1004_at`$`GO:0070098`$GOID
## [1] "GO:0070098"
##
## $`1004_at`$`GO:0070098`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0070098`$Ontology
## [1] "BP"
##
##
## $`1004_at`$`GO:0005886`
## $`1004_at`$`GO:0005886`$GOID
## [1] "GO:0005886"
##
## $`1004_at`$`GO:0005886`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0005886`$Ontology
## [1] "CC"
##
##
## $`1004_at`$`GO:0005886`
## $`1004_at`$`GO:0005886`$GOID
## [1] "GO:0005886"
##
## $`1004_at`$`GO:0005886`$Evidence
## [1] "TAS"
##
## $`1004_at`$`GO:0005886`$Ontology
## [1] "CC"
##
##
## $`1004_at`$`GO:0009897`
## $`1004_at`$`GO:0009897`$GOID
## [1] "GO:0009897"
##
## $`1004_at`$`GO:0009897`$Evidence
## [1] "IBA"
##
## $`1004_at`$`GO:0009897`$Ontology
## [1] "CC"
##
##
## $`1004_at`$`GO:0009897`
## $`1004_at`$`GO:0009897`$GOID
## [1] "GO:0009897"
##
## $`1004_at`$`GO:0009897`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0009897`$Ontology
## [1] "CC"
##
##
## $`1004_at`$`GO:0016020`
## $`1004_at`$`GO:0016020`$GOID
## [1] "GO:0016020"
##
## $`1004_at`$`GO:0016020`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0016020`$Ontology
## [1] "CC"
##
##
## $`1004_at`$`GO:0004930`
## $`1004_at`$`GO:0004930`$GOID
## [1] "GO:0004930"
##
## $`1004_at`$`GO:0004930`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0004930`$Ontology
## [1] "MF"
##
##
## $`1004_at`$`GO:0004930`
## $`1004_at`$`GO:0004930`$GOID
## [1] "GO:0004930"
##
## $`1004_at`$`GO:0004930`$Evidence
## [1] "TAS"
##
## $`1004_at`$`GO:0004930`$Ontology
## [1] "MF"
##
##
## $`1004_at`$`GO:0005515`
## $`1004_at`$`GO:0005515`$GOID
## [1] "GO:0005515"
##
## $`1004_at`$`GO:0005515`$Evidence
## [1] "IPI"
##
## $`1004_at`$`GO:0005515`$Ontology
## [1] "MF"
##
##
## $`1004_at`$`GO:0016493`
## $`1004_at`$`GO:0016493`$GOID
## [1] "GO:0016493"
##
## $`1004_at`$`GO:0016493`$Evidence
## [1] "IBA"
##
## $`1004_at`$`GO:0016493`$Ontology
## [1] "MF"
##
##
## $`1004_at`$`GO:0016494`
## $`1004_at`$`GO:0016494`$GOID
## [1] "GO:0016494"
##
## $`1004_at`$`GO:0016494`$Evidence
## [1] "IEA"
##
## $`1004_at`$`GO:0016494`$Ontology
## [1] "MF"
##
##
## $`1004_at`$`GO:0019957`
## $`1004_at`$`GO:0019957`$GOID
## [1] "GO:0019957"
##
## $`1004_at`$`GO:0019957`$Evidence
## [1] "IBA"
##
## $`1004_at`$`GO:0019957`$Ontology
## [1] "MF"
```

To obtain annotation for a given set of keys, one may use the `mget`
function. Suppose we have run an experiment using the HG\_U95Av2 chip and
found three genes represented by Affymetrix probe ids *738\_at*,
*40840\_at*, and *41668\_r\_at* interesting. To get the names of genes the
three probe ids corresponding to, we do:

```
mget(c("738_at", "40840_at", "41668_r_at"), hgu95av2GENENAME)
```

```
## $`738_at`
## [1] "5'-nucleotidase, cytosolic II"
##
## $`40840_at`
## [1] "peptidylprolyl isomerase F"
##
## $`41668_r_at`
## [1] "TDP-glucose 4,6-dehydratase"
```

Similarly, identifiers of Gene Ontology terms corrsponding to the three
probes can be obtained as shown below:

```
temp <- mget(c("41561_s_at", "40840_at", "41668_r_at"), hgu95av2GO)
```

In this case, the function `mget` returns a list of pre-defined S4
objects containing data for the ids, ontology, and evidence code of Gene
Ontology terms corresponding to the three keys. The following code shows
how to access the GO id, evidence code and ontology of the Gene Ontology
term corresponding to probe id *40840\_at*:

```
temp <- get("738_at", hgu95av2GO)
names(temp)
```

```
##  [1] "GO:0000255" "GO:0000255" "GO:0006202" "GO:0006204" "GO:0009117"
##  [6] "GO:0043605" "GO:0046037" "GO:0046037" "GO:0046038" "GO:0046040"
## [11] "GO:0046040" "GO:0046054" "GO:0046054" "GO:0046055" "GO:0046085"
## [16] "GO:0050689" "GO:0070936" "GO:0140374" "GO:0005737" "GO:0005737"
## [21] "GO:0005829" "GO:0005829" "GO:0005829" "GO:0000166" "GO:0003824"
## [26] "GO:0005515" "GO:0005524" "GO:0005524" "GO:0008253" "GO:0008253"
## [31] "GO:0008253" "GO:0008253" "GO:0008253" "GO:0016740" "GO:0016787"
## [36] "GO:0042802" "GO:0046872" "GO:0050146" "GO:0050146" "GO:0061630"
```

```
temp[["GO:0008253"]][["Evidence"]]
```

```
## [1] "IBA"
```

```
temp[["GO:0008253"]][["Ontology"]]
```

```
## [1] "MF"
```

As shown above, probe *40840\_at* can be annotated by three Gene Ontology
terms identified by *GO:0005829*, *GO:0008253*, and *GO:0016787*. The
evidence code for *GO:0008253* is *TAS* (traceable author statement) and
it belongs to ontology *MF* (molecular function).

## Accessing annotation data across libraries

Often, data available in a given data package alone may not be
sufficient and need to be sought across packages. Bioconductor’s
annotation data packages are linked by common public data identifiers to
allow traverse between packages. Using the example above, we
know that probe id *738\_at* are annotated by three Gene Ontology ids
*GO:0005829*, *GO:0008253*, and *GO:0016787*. The Gene Ontology terms
for various Gene Ontology ids, however, are stored in another package
named *[GO.db](https://bioconductor.org/packages/3.22/GO.db)*. As package *[hgu95av2.db](https://bioconductor.org/packages/3.22/hgu95av2.db)* and
*[GO.db](https://bioconductor.org/packages/3.22/GO.db)* are linked by *GO* ids, one can annotate probe id *738\_at*
with Gene Ontology terms by linking data in the two packages using *GO* id as
shown below:

```
mget(names(get("738_at", hgu95av2GO)), GOTERM)
```

```
## $`GO:0000255`
## GOID: GO:0000255
## Term: allantoin metabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways involving allantoin,
##     (2,5-dioxo-4-imidazolidinyl)urea, an intermediate or end product of
##     purine catabolism.
## Synonym: allantoin metabolism
##
## $`GO:0000255`
## GOID: GO:0000255
## Term: allantoin metabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways involving allantoin,
##     (2,5-dioxo-4-imidazolidinyl)urea, an intermediate or end product of
##     purine catabolism.
## Synonym: allantoin metabolism
##
## $`GO:0006202`
## GOID: GO:0006202
## Term: GMP catabolic process to guanine
## Ontology: BP
## Definition: The chemical reactions and pathways resulting in the
##     breakdown of guanosine monophosphate into other compounds,
##     including guanine.
## Synonym: GMP breakdown to guanine
## Synonym: GMP degradation to guanine
##
## $`GO:0006204`
## GOID: GO:0006204
## Term: IMP catabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways resulting in the
##     breakdown of IMP, inosine monophosphate.
## Synonym: IMP breakdown
## Synonym: IMP catabolism
## Synonym: IMP degradation
##
## $`GO:0009117`
## GOID: GO:0009117
## Term: nucleotide metabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways involving a nucleotide,
##     a nucleoside that is esterified with (ortho)phosphate or an
##     oligophosphate at any hydroxyl group on the glycose moiety; may be
##     mono-, di- or triphosphate; this definition includes cyclic
##     nucleotides (nucleoside cyclic phosphates).
## Synonym: nucleotide metabolism
##
## $`GO:0043605`
## GOID: GO:0043605
## Term: amide catabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways resulting in the
##     breakdown of an amide, any derivative of an oxoacid in which an
##     acidic hydroxy group has been replaced by an amino or substituted
##     amino group.
## Synonym: cellular amide catabolic process
##
## $`GO:0046037`
## GOID: GO:0046037
## Term: GMP metabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways involving GMP,
##     guanosine monophosphate.
## Synonym: GMP metabolism
##
## $`GO:0046037`
## GOID: GO:0046037
## Term: GMP metabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways involving GMP,
##     guanosine monophosphate.
## Synonym: GMP metabolism
##
## $`GO:0046038`
## GOID: GO:0046038
## Term: GMP catabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways resulting in the
##     breakdown of GMP, guanosine monophosphate.
## Synonym: GMP breakdown
## Synonym: GMP catabolism
## Synonym: GMP degradation
##
## $`GO:0046040`
## GOID: GO:0046040
## Term: IMP metabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways involving IMP, inosine
##     monophosphate.
## Synonym: IMP metabolism
##
## $`GO:0046040`
## GOID: GO:0046040
## Term: IMP metabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways involving IMP, inosine
##     monophosphate.
## Synonym: IMP metabolism
##
## $`GO:0046054`
## GOID: GO:0046054
## Term: dGMP metabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways involving dGMP,
##     deoxyguanosine monophosphate (2'-deoxyguanosine 5'-phosphate).
## Synonym: dGMP metabolism
##
## $`GO:0046054`
## GOID: GO:0046054
## Term: dGMP metabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways involving dGMP,
##     deoxyguanosine monophosphate (2'-deoxyguanosine 5'-phosphate).
## Synonym: dGMP metabolism
##
## $`GO:0046055`
## GOID: GO:0046055
## Term: dGMP catabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways resulting in the
##     breakdown of dGMP, deoxyguanosine monophosphate (2'-deoxyguanosine
##     5'-phosphate).
## Synonym: dGMP breakdown
## Synonym: dGMP catabolism
## Synonym: dGMP degradation
##
## $`GO:0046085`
## GOID: GO:0046085
## Term: adenosine metabolic process
## Ontology: BP
## Definition: The chemical reactions and pathways involving adenosine,
##     adenine riboside, a ribonucleoside found widely distributed in
##     cells of every type as the free nucleoside and in combination in
##     nucleic acids and various nucleoside coenzymes.
## Synonym: adenosine metabolism
##
## $`GO:0050689`
## GOID: GO:0050689
## Term: negative regulation of defense response to virus by host
## Ontology: BP
## Definition: Any host process that results in the inhibition of
##     antiviral immune response mechanisms, thereby facilitating viral
##     replication. The host is defined as the larger of the organisms
##     involved in a symbiotic interaction.
## Synonym: down regulation of antiviral response by host
## Synonym: down-regulation of antiviral response by host
## Synonym: downregulation of antiviral response by host
## Synonym: negative regulation by host of antiviral response
## Synonym: negative regulation of antiviral response by host
## Synonym: inhibition of antiviral response by host
##
## $`GO:0070936`
## GOID: GO:0070936
## Term: protein K48-linked ubiquitination
## Ontology: BP
## Definition: A protein ubiquitination process in which a polymer of
##     ubiquitin, formed by linkages between lysine residues at position
##     48 of the ubiquitin monomers, is added to a protein. K48-linked
##     ubiquitination targets the substrate protein for degradation.
## Synonym: protein K48-linked polyubiquitination
##
## $`GO:0140374`
## GOID: GO:0140374
## Term: antiviral innate immune response
## Ontology: BP
## Definition: NA
##
## $`GO:0005737`
## GOID: GO:0005737
## Term: cytoplasm
## Ontology: CC
## Definition: The contents of a cell excluding the plasma membrane and
##     nucleus, but including other subcellular structures.
##
## $`GO:0005737`
## GOID: GO:0005737
## Term: cytoplasm
## Ontology: CC
## Definition: The contents of a cell excluding the plasma membrane and
##     nucleus, but including other subcellular structures.
##
## $`GO:0005829`
## GOID: GO:0005829
## Term: cytosol
## Ontology: CC
## Definition: The part of the cytoplasm that does not contain organelles
##     but which does contain other particulate matter, such as protein
##     complexes.
##
## $`GO:0005829`
## GOID: GO:0005829
## Term: cytosol
## Ontology: CC
## Definition: The part of the cytoplasm that does not contain organelles
##     but which does contain other particulate matter, such as protein
##     complexes.
##
## $`GO:0005829`
## GOID: GO:0005829
## Term: cytosol
## Ontology: CC
## Definition: The part of the cytoplasm that does not contain organelles
##     but which does contain other particulate matter, such as protein
##     complexes.
##
## $`GO:0000166`
## GOID: GO:0000166
## Term: nucleotide binding
## Ontology: MF
## Definition: Binding to a nucleotide, any compound consisting of a
##     nucleoside that is esterified with (ortho)phosphate or an
##     oligophosphate at any hydroxyl group on the ribose or deoxyribose.
##
## $`GO:0003824`
## GOID: GO:0003824
## Term: catalytic activity
## Ontology: MF
## Definition: Catalysis of a biochemical reaction at physiological
##     temperatures. In biologically catalyzed reactions, the reactants
##     are known as substrates, and the catalysts are naturally occurring
##     macromolecular substances known as enzymes. Enzymes possess
##     specific binding sites for substrates, and are usually composed
##     wholly or largely of protein, but RNA that has catalytic activity
##     (ribozyme) is often also regarded as enzymatic.
## Synonym: enzyme activity
##
## $`GO:0005515`
## GOID: GO:0005515
## Term: protein binding
## Ontology: MF
## Definition: Binding to a protein.
## Synonym: GO:0001948
## Synonym: GO:0045308
## Synonym: protein amino acid binding
## Synonym: glycoprotein binding
## Secondary: GO:0001948
## Secondary: GO:0045308
##
## $`GO:0005524`
## GOID: GO:0005524
## Term: ATP binding
## Ontology: MF
## Definition: Binding to ATP, adenosine 5'-triphosphate, a universally
##     important coenzyme and enzyme regulator.
## Synonym: Mg-ATP binding
## Synonym: MgATP binding
##
## $`GO:0005524`
## GOID: GO:0005524
## Term: ATP binding
## Ontology: MF
## Definition: Binding to ATP, adenosine 5'-triphosphate, a universally
##     important coenzyme and enzyme regulator.
## Synonym: Mg-ATP binding
## Synonym: MgATP binding
##
## $`GO:0008253`
## GOID: GO:0008253
## Term: 5'-nucleotidase activity
## Ontology: MF
## Definition: Catalysis of the reaction: a 5'-ribonucleotide + H2O = a
##     ribonucleoside + phosphate.
## Synonym: 5' nucleotidase activity
## Synonym: 5'-mononucleotidase activity
## Synonym: 5'-ribonucleotide phosphohydrolase activity
## Synonym: 5'-adenylic phosphatase
## Synonym: 5'-AMP nucleotidase
## Synonym: 5'-AMPase
## Synonym: adenosine 5'-phosphatase
## Synonym: adenosine monophosphatase
## Synonym: AMP phosphatase
## Synonym: AMP phosphohydrolase
## Synonym: AMPase
## Synonym: snake venom 5'-nucleotidase
## Synonym: thimidine monophosphate nucleotidase
## Synonym: UMPase
## Synonym: uridine 5'-nucleotidase
##
## $`GO:0008253`
## GOID: GO:0008253
## Term: 5'-nucleotidase activity
## Ontology: MF
## Definition: Catalysis of the reaction: a 5'-ribonucleotide + H2O = a
##     ribonucleoside + phosphate.
## Synonym: 5' nucleotidase activity
## Synonym: 5'-mononucleotidase activity
## Synonym: 5'-ribonucleotide phosphohydrolase activity
## Synonym: 5'-adenylic phosphatase
## Synonym: 5'-AMP nucleotidase
## Synonym: 5'-AMPase
## Synonym: adenosine 5'-phosphatase
## Synonym: adenosine monophosphatase
## Synonym: AMP phosphatase
## Synonym: AMP phosphohydrolase
## Synonym: AMPase
## Synonym: snake venom 5'-nucleotidase
## Synonym: thimidine monophosphate nucleotidase
## Synonym: UMPase
## Synonym: uridine 5'-nucleotidase
##
## $`GO:0008253`
## GOID: GO:0008253
## Term: 5'-nucleotidase activity
## Ontology: MF
## Definition: Catalysis of the reaction: a 5'-ribonucleotide + H2O = a
##     ribonucleoside + phosphate.
## Synonym: 5' nucleotidase activity
## Synonym: 5'-mononucleotidase activity
## Synonym: 5'-ribonucleotide phosphohydrolase activity
## Synonym: 5'-adenylic phosphatase
## Synonym: 5'-AMP nucleotidase
## Synonym: 5'-AMPase
## Synonym: adenosine 5'-phosphatase
## Synonym: adenosine monophosphatase
## Synonym: AMP phosphatase
## Synonym: AMP phosphohydrolase
## Synonym: AMPase
## Synonym: snake venom 5'-nucleotidase
## Synonym: thimidine monophosphate nucleotidase
## Synonym: UMPase
## Synonym: uridine 5'-nucleotidase
##
## $`GO:0008253`
## GOID: GO:0008253
## Term: 5'-nucleotidase activity
## Ontology: MF
## Definition: Catalysis of the reaction: a 5'-ribonucleotide + H2O = a
##     ribonucleoside + phosphate.
## Synonym: 5' nucleotidase activity
## Synonym: 5'-mononucleotidase activity
## Synonym: 5'-ribonucleotide phosphohydrolase activity
## Synonym: 5'-adenylic phosphatase
## Synonym: 5'-AMP nucleotidase
## Synonym: 5'-AMPase
## Synonym: adenosine 5'-phosphatase
## Synonym: adenosine monophosphatase
## Synonym: AMP phosphatase
## Synonym: AMP phosphohydrolase
## Synonym: AMPase
## Synonym: snake venom 5'-nucleotidase
## Synonym: thimidine monophosphate nucleotidase
## Synonym: UMPase
## Synonym: uridine 5'-nucleotidase
##
## $`GO:0008253`
## GOID: GO:0008253
## Term: 5'-nucleotidase activity
## Ontology: MF
## Definition: Catalysis of the reaction: a 5'-ribonucleotide + H2O = a
##     ribonucleoside + phosphate.
## Synonym: 5' nucleotidase activity
## Synonym: 5'-mononucleotidase activity
## Synonym: 5'-ribonucleotide phosphohydrolase activity
## Synonym: 5'-adenylic phosphatase
## Synonym: 5'-AMP nucleotidase
## Synonym: 5'-AMPase
## Synonym: adenosine 5'-phosphatase
## Synonym: adenosine monophosphatase
## Synonym: AMP phosphatase
## Synonym: AMP phosphohydrolase
## Synonym: AMPase
## Synonym: snake venom 5'-nucleotidase
## Synonym: thimidine monophosphate nucleotidase
## Synonym: UMPase
## Synonym: uridine 5'-nucleotidase
##
## $`GO:0016740`
## GOID: GO:0016740
## Term: transferase activity
## Ontology: MF
## Definition: Catalysis of the transfer of a group, e.g. a methyl group,
##     glycosyl group, acyl group, phosphorus-containing, or other groups,
##     from one compound (generally regarded as the donor) to another
##     compound (generally regarded as the acceptor). Transferase is the
##     systematic name for any enzyme of EC class 2.
##
## $`GO:0016787`
## GOID: GO:0016787
## Term: hydrolase activity
## Ontology: MF
## Definition: Catalysis of the hydrolysis of various bonds, e.g. C-O,
##     C-N, C-C, phosphoric anhydride bonds, etc.
##
## $`GO:0042802`
## GOID: GO:0042802
## Term: identical protein binding
## Ontology: MF
## Definition: Binding to an identical protein or proteins.
## Synonym: isoform-specific homophilic binding
## Synonym: protein homopolymerization
##
## $`GO:0046872`
## GOID: GO:0046872
## Term: metal ion binding
## Ontology: MF
## Definition: Binding to a metal ion.
## Synonym: metal binding
## Synonym: heavy metal binding
##
## $`GO:0050146`
## GOID: GO:0050146
## Term: nucleoside phosphotransferase activity
## Ontology: MF
## Definition: Catalysis of the reaction: a nucleotide + a
##     2'-deoxynucleoside = a nucleoside + a 2'-deoxynucleoside
##     5'-monophosphate.
## Synonym: nonspecific nucleoside phosphotransferase activity
## Synonym: nucleotide:2'-nucleoside 5'-phosphotransferase activity
## Synonym: nucleotide:3'-deoxynucleoside 5'-phosphotransferase activity
## Synonym: nucleotide:nucleoside 5'-phosphotransferase activity
##
## $`GO:0050146`
## GOID: GO:0050146
## Term: nucleoside phosphotransferase activity
## Ontology: MF
## Definition: Catalysis of the reaction: a nucleotide + a
##     2'-deoxynucleoside = a nucleoside + a 2'-deoxynucleoside
##     5'-monophosphate.
## Synonym: nonspecific nucleoside phosphotransferase activity
## Synonym: nucleotide:2'-nucleoside 5'-phosphotransferase activity
## Synonym: nucleotide:3'-deoxynucleoside 5'-phosphotransferase activity
## Synonym: nucleotide:nucleoside 5'-phosphotransferase activity
##
## $`GO:0061630`
## GOID: GO:0061630
## Term: ubiquitin protein ligase activity
## Ontology: MF
## Definition: Catalysis of the transfer of ubiquitin to a substrate
##     protein via the reaction X-ubiquitin + S = X + S-ubiquitin, where X
##     is either an E2 or E3 enzyme, the X-ubiquitin linkage is a
##     thioester bond, and the S-ubiquitin linkage is an amide bond: an
##     isopeptide bond between the C-terminal glycine of ubiquitin and the
##     epsilon-amino group of lysine residues in the substrate or, in the
##     linear extension of ubiquitin chains, a peptide bond the between
##     the C-terminal glycine and N-terminal methionine of ubiquitin
##     residues.
## Synonym: GO:0090302
## Synonym: GO:0090622
## Synonym: GO:1904264
## Synonym: GO:1904822
## Synonym: protein ubiquitination activity
## Synonym: ubiquitin ligase activity
## Synonym: ER-associated E3 ligase
## Synonym: E3
## Secondary: GO:0090302
## Secondary: GO:0090622
## Secondary: GO:1904264
## Secondary: GO:1904822
```

It turns out that probe id *738\_at* (corresponding to *GO:0008253*, and
*GO:0016787*) has molecular function (MF) *5’-nucleotidase activity* and
*hydrolase activity*.

# 4 Session Information

The version number of R and packages loaded for generating the vignette
were:

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] GO.db_3.22.0         hgu95av2.db_3.13.0   org.Hs.eg.db_3.22.0
##  [4] annotate_1.88.0      XML_3.99-0.19        AnnotationDbi_1.72.0
##  [7] IRanges_2.44.0       S4Vectors_0.48.0     Biobase_2.70.0
## [10] BiocGenerics_0.56.0  generics_0.1.4       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] bit_4.6.0           jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 crayon_1.5.3        blob_1.2.4
##  [7] Biostrings_2.78.0   jquerylib_0.1.4     Seqinfo_1.0.0
## [10] png_0.1-8           yaml_2.3.10         fastmap_1.2.0
## [13] R6_2.6.1            XVector_0.50.0      knitr_1.50
## [16] bookdown_0.45       DBI_1.2.3           bslib_0.9.0
## [19] rlang_1.1.6         KEGGREST_1.50.0     cachem_1.1.0
## [22] xfun_0.53           sass_0.4.10         bit64_4.6.0-1
## [25] RSQLite_2.4.3       memoise_2.0.1       cli_3.6.5
## [28] digest_0.6.37       xtable_1.8-4        lifecycle_1.0.4
## [31] vctrs_0.6.5         evaluate_1.0.5      rmarkdown_2.30
## [34] httr_1.4.7          pkgconfig_2.0.3     tools_4.5.1
## [37] htmltools_0.5.8.1
```