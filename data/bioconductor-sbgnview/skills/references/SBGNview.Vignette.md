# SBGNview: Data Analysis, Integration and Visualization on Massive SBGN Pathway Collections

#### Xiaoxi Dong

#### Kovidh Vegesna, kvegesna (AT) uncc.edu

#### Weijun Luo, luo\_weijun (AT) yahoo.com

#### 30 October, 2025

# 1 Overview

SBGNview is a tool set for pathway based data visalization, integration and analysis. SBGNview is similar and complementary to the widely used [Pathview](https://www.bioconductor.org/packages/pathview)(Luo and Brouwer 2013), with the following key features:

* Pathway definition by the widely adopted [Systems Biology Graphical Notation (SBGN)](https://sbgn.github.io/);
* Supports multiple major pathway databases beyond KEGG ([Reactome](https://reactome.org/), [MetaCyc](https://metacyc.org/), [SMPDB](https://smpdb.ca/), [PANTHER](http://www.pantherdb.org/pathway/), [METACROP](https://metacrop.ipk-gatersleben.de/) etc) and user defined pathways;
* Covers 5,200 reference pathways and over 3,000 species by default;
* Extensive graphics controls, including glyph and edge attributes, graph layout and sub-pathway highlight;
* SBGN pathway data manipulation, processing, extraction and analysis.

# 2 Citation

Please cite the following papers when using this open-source package. This will help the project and our team:

Luo W, Brouwer C. Pathview: an R/Biocondutor package for pathway-based data integration and visualization. Bioinformatics, 2013, 29(14):1830-1831, [doi: 10.1093/bioinformatics/btt285](https://doi.org/10.1093/bioinformatics/btt285)

# 3 Installation and quick start

Please see the [Quick Start tutorial](https://bioconductor.org/packages/devel/bioc/vignettes/SBGNview/inst/doc/SBGNview.quick.start.html) for installation instructions and quick start examples.

# 4 Getting started

*SBGNview* is the main function of the package. It takes two major types of inputs: user data (gene and/or compound data) and SBGN pathway data (pathway IDs or SBGN-ML files). *SBGNview* parses the SBGN pathway data, extracts glyph (node) and arc (edge) data from SBGN-ML file, maps and integrates the user data to the glyphs and renders the SBGN graph in SVG formatwith mapped data as pseudo-colors. Currently it maps gene/protein omics data to “macromolecule” glyphs and maps compound omics data to “simple chemical” glyphs. The *SBGNview* function returns a [*SBGNview* object](#sbgnviewObj), which contains data to recreate the rendered SBGN graph or further modified it. Please see the documentation of function *SBGNview* for more details.

## 4.1 Load the SBGNview package, together with pathview and other dependencies

```
library(SBGNview)
```

## 4.2 Accessing help and documentation

Use `ls("package:SBGNview")` to list all available functions in SBGNview. To learn more about how to use the functions and access their manuals, use `help()` or `?`. For example, `?”SBGNview”` or `help("+.SBGNview")`.

```
ls("package:SBGNview")
```

```
##  [1] "SBGNview"         "changeDataId"     "changeIds"        "downloadSbgnFile"
##  [5] "findPathways"     "highlightArcs"    "highlightNodes"   "highlightPath"
##  [9] "loadMappingTable" "outputFile"       "outputFile<-"     "renderSbgn"
## [13] "sbgn.gsets"       "sbgnNodes"
```

## 4.3 SBGN pathway file (SBGN-ML)

SBGN pathways are defined in a special XML format (SBGN-ML file). SBGN-ML files describe the pathway elements (molecules and their reactions) and the graph layout (positions and appearances of the pathway elements). There are two major data types ement in SBGN-ML files:
1. node data (in tag “glyph”), such as node location, width, hight and node class (macromolecule, simple chemical etc.).
2. edge data (in tag “arc”), such as arc class, start node and end node.
For more details, see:
<https://github.com/sbgn/sbgn/wiki/SBGN_ML>

### 4.3.1 Two tiers of support and two scenarios with SBGN based pathways

SBGNview provides two tiers of support for SBGN based pathway data, which corresponds to the two common *SBGNview* scenarios:

* Scenarios 1 or Tier 1{#ourCollection}, direct and deep support to a core collection of pathway data from 5 major pathway databases including Reactome, SMPDB, PANTHER, MetaCyc and MetaCrop, or using SBGNview’s pathway collection. Each of these databases covers up to thousands of reference pathways and species (Table 1). SBGNview provides diagram optimization and ID mapping on these pathway databases. In other words, ve prepared a full collection of high quality sbgn pathways from these databases, which can be directly used in data analysis. The pathway data in SBGN-ML format are stored in data **sbgn.xmls** (included in package *SBGNview.data*), which are effectively indexed/accessed by SBGNview pathway IDs. We’ve also generated ID mapping between SBGN-ML glyph IDs and common molecule IDs, so that user data can be easily mapped to these pathways.
* Scenarios 2 or Tier 2, indirect support to raw SBGN pathway data from pathway databases, collections and users’ custom pathway data. Many major pathway databases provide SBGN-ML files, including Pathway Commons, Reactome and MetaCrop. Their data can be downloaded and directly used by *SBGNview*. Other databases (e.g. PANTHER and BioCyc) use SBML or BioPAX formats, which can be converted to SBGN-ML format using third party tools. Note Pathway Commons collect pathways from Reactome, PANTHER, SMPDB and other primary databases. These data can be used in SBGNview, except diagrams may not be optimized for data visualization, and users need to provided ID mapping or make sure the glyph IDs are commonly use molecule IDs.

Note the core collection of pathway databases with tier 1 support includes thousands of pathways and species, which should cover most of the users needs in pathway analysis and data visualization. We are taking the first the default route, i.e. to use the SBGNview’s core collection.

#### 4.3.1.1 Load SBGNview’s SBGN-ML pathway data collection

Because a large amount of pathway data is loaded into R, this step can take up to several second.

```
data("sbgn.xmls")
```

#### 4.3.1.2 Information about the SBGN-ML pathway data collection

We can check the information of collected pathways using `pathways.info` and number of pathways collected using `pathways.stats`.

```
data("pathways.info", "pathways.stats")
head(pathways.info)
```

```
##                                            file.name       database
## 1 http___identifiers.org_panther.pathway_P00001.sbgn pathwayCommons
## 2 http___identifiers.org_panther.pathway_P00002.sbgn pathwayCommons
## 3 http___identifiers.org_panther.pathway_P00003.sbgn pathwayCommons
## 4 http___identifiers.org_panther.pathway_P00004.sbgn pathwayCommons
## 5 http___identifiers.org_panther.pathway_P00005.sbgn pathwayCommons
## 6 http___identifiers.org_panther.pathway_P00006.sbgn pathwayCommons
##                                             uri    sub.database pathway.id
## 1 http://identifiers.org/panther.pathway/P00001 panther.pathway     P00001
## 2 http://identifiers.org/panther.pathway/P00002 panther.pathway     P00002
## 3 http://identifiers.org/panther.pathway/P00003 panther.pathway     P00003
## 4 http://identifiers.org/panther.pathway/P00004 panther.pathway     P00004
## 5 http://identifiers.org/panther.pathway/P00005 panther.pathway     P00005
## 6 http://identifiers.org/panther.pathway/P00006 panther.pathway     P00006
##                                  pathway.name macromolecule.ID.type
## 1   Adrenaline and noradrenaline biosynthesis        pathwayCommons
## 2 Alpha adrenergic receptor signaling pathway        pathwayCommons
## 3 Alzheimer disease-amyloid secretase pathway        pathwayCommons
## 4        Alzheimer disease-presenilin pathway        pathwayCommons
## 5                                Angiogenesis        pathwayCommons
## 6                 Apoptosis signaling pathway        pathwayCommons
##   simple.chemical.ID.type
## 1          pathwayCommons
## 2          pathwayCommons
## 3          pathwayCommons
## 4          pathwayCommons
## 5          pathwayCommons
## 6          pathwayCommons
```

```
pathways.stats
```

```
##          database    sub.database Freq
## 1        MetaCrop        MetaCrop   62
## 5         MetaCyc         MetaCyc 2518
## 9  pathwayCommons panther.pathway  149
## 12 pathwayCommons        reactome 1746
## 15 pathwayCommons           smpdb  725
```

#### 4.3.1.3 Search for pathways by keywords

SBGNview can search for pathways by keyword and automatically download SBGN-ML files.

```
pathways <- findPathways(c("bile acid","bile salt"))
head(pathways)
pathways.local.file <- downloadSbgnFile(pathways$pathway.id[1:3])
pathways.local.file
```

By default *findPathways* searches for keywords in pathway names. It can also search by different ID types

```
pathways <- findPathways(c("tp53","Trp53"),keyword.type = "SYMBOL")
head(pathways)
pathways <- findPathways(c("K04451","K10136"),keyword.type = "KO")
head(pathways)
```

#### 4.3.1.4 Different layout for the same pathway

Researchers may have different tastes for a “good looking” layout. We have created different layouts for each pathway. User can download them from [pre-generated SBGN-ML files](https://github.com/datapplab/SBGNhub/tree/master/data/SBGN.with.stamp) and [try](#tryDifferentLayout).

### 4.3.2 Custom SBGN-ML files

USers can also define their own pathways and create custom SBGN-ML files from scratch. Several tools like [Newt editor](http://newteditor.org/) can let the user draw a pathway diagram and save it as SBGN-ML file. The tools may also able to generate a primitive pathway layout. But these layouts are usually not desirable for data visualization with too many node-node overlaps and edge-node crossings. Therefore, we recommend the users to stick to [SBGNview core collection](#ourCollection).

# 5 Basic visualization

SBGNview can visualize a range of omics data, including both gene (or transcript, protein, enzyme) data and compound (or metabolite, chemical, small molecules) data.

## 5.1 Visualize gene data

Gene/protein related data will be mapped to “macromolecule” nodes or glyphs on SBGN maps. Most of online databases or resources have their unique glyph ID types and it is likely different from the ID type in the gene data. We often need to map the omics IDs to the node IDs in the SBGN-ML file.
In the [quick start example](https://bioconductor.org/packages/devel/bioc/vignettes/SBGNview/inst/doc/SBGNview.quick.start.html#quickexample) (“Adrenaline and noradrenaline biosynthesis” pathway), the SBGN-ML file uses pathwayCommons IDs for gene/protein nodes, whereas the omics dataset uses Entrez gene IDs.
The function *SBGNview* can automatically map common ID types such as ENTREZ, UniProt etc. to nodes in our [pre-generated SBGN-ML files](https://github.com/datapplab/SBGNhub/tree/master/data/SBGN.with.stamp) as shown in the [quick start example](https://bioconductor.org/packages/devel/bioc/vignettes/SBGNview/inst/doc/SBGNview.quick.start.html#quickexample). We can also do it manually using function *changeDataId*, which is called by *SBGNview* internally to do ID mapping. Supported ID type pairs can be found in *data(mapped.ids)*. *changeDataId* uses [pre-generated mapping tables](https://github.com/datapplab/SBGN-ML.files/tree/master/data/id.mapping) or **pathview** to do the mapping.
If the input-output ID type pair is not in *data(mapped.ids)* or can’t be mapped by **SBGNview** automatically, user needs to provide the mapping table explicitly using the “id.mapping.table” argument.

Firt, load the preprocessed demo gene data.

```
data("gse16873.d")
head(gse16873.d)
```

Let’s change the IDs in the gene data manually as an demo.

```
# select a subset of data for later use
gse16873 <- gse16873.d[,1:3]
# gene data to demonstrate ID convertion
gene.data <- gse16873
head(gene.data[,1:2])
```

```
##                DCIS_1      DCIS_2
## 10000     -0.30764480 -0.14722769
## 10001      0.41586805 -0.33477259
## 10002      0.19854925  0.03789588
## 10003     -0.23155297 -0.09659311
## 100048912 -0.04490724 -0.05203146
## 10004     -0.08756237 -0.05027725
```

```
gene.data <- changeDataId(data.input.id = gene.data,
                          input.type = "entrez",
                          output.type = "pathwayCommons",
                          mol.type = "gene",
                          sum.method = "sum")
```

When multiple genes are mapped to the same glyph ID, we use the sum of their values (sum.method = “sum”).

```
head(gene.data[,1:2])
```

```
##                              DCIS_1     DCIS_2
## Protein100049:@:PWY-5188 0.02357413 0.35777714
## Protein100090:@:PWY-5188 0.02357413 0.35777714
## Protein100099:@:PWY-5188 0.02357413 0.35777714
## Protein100143:@:PWY-5424 0.23976217 0.03226769
## Protein100158:@:PWY-5188 0.02357413 0.35777714
## Protein100294:@:PWY-5188 0.23614703 0.52414811
```

Now we run *SBGNview*, the main function to map and render gene data on SBGN map.

```
SBGNview.obj <- SBGNview(gene.data = gene.data,
                         input.sbgn = "P00001",
                         output.file = "test_output",
                         gene.id.type = "pathwayCommons",
                         output.formats =  c("png", "pdf", "ps"))
SBGNview.obj
```

*SBGNview* will always generate a .svg file. Other formats can be added also. In this example, three additional files (pdf, ps, png) will be created in the same folder.

![\label{fig:figGeneData}Visualization of gene expression data.](data:image/svg+xml;base64...)

Figure 5.1: Visualization of gene expression data.

## 5.2 Visualize compound data

Chemical compound data will be mapped to “simple chemical” nodes on a SBGN map.

Here we simulate a compound dataset.

```
cpd.data <- sim.mol.data(mol.type = "cpd",
                         id.type = "KEGG COMPOUND accession",
                         nmol = 50000,
                         nexp = 2)
head(cpd.data)
```

Here for demo purpose, we change the KEGG compound IDs to pathwayCommons compound IDs. Although *SBGNview* can do this automatically, see Visualize both gene data and compound data.

```
cpd.data1 <- changeDataId(data.input.id = cpd.data,
                         input.type = "kegg",
                         output.type = "pathwayCommons",
                         mol.type = "cpd",
                         sum.method = "sum")
head(cpd.data1)
```

Now we run *SBGNview*, the main function to map and render compound data on SBGN map.

```
SBGNview.obj <- SBGNview(cpd.data = cpd.data1,
                         input.sbgn = "P00001",
                         output.file = "test_output.cpd",
                         cpd.id.type = "pathwayCommons",
                         output.formats =  c("png", "pdf", "ps"))
SBGNview.obj
```

![\label{fig:figCpdData}Visualization of compound abundance data.](data:image/svg+xml;base64...)

Figure 5.2: Visualization of compound abundance data.

## 5.3 Visualize both gene data and compound data

Now we can visualize both gene and compound data. In this example, we use the original gene expression data with “ENTREZ” IDs to show SBGNview’s automatic ID mapping ability.

```
SBGNview.obj <- SBGNview(gene.data = gse16873,
                         cpd.data = cpd.data,
                         input.sbgn = "P00001",
                         output.file = "test_output.gene.compound",
                         gene.id.type = "entrez",
                         cpd.id.type = "kegg",
                         output.formats =  c("svg"))
SBGNview.obj
```

![\label{fig:figGeneAndCpdData}Visualization of both gene expression and compound abundance data.](data:image/svg+xml;base64...)

Figure 5.3: Visualization of both gene expression and compound abundance data.

# 6 Work with *SBGNview* object

**SBGNview** operates in a way similar to **ggplot2**:
The main function *SBGNview* returns a S3 class *SBGNview* object (similar to the *ggplot* object “p” returned by function *ggplot* in **ggplot2**), which contains information needed to render SBGN graph, and output file name. Make sure the input SBGN-ML files are available in the folder. The `input.sbgn` parameters takes in names of local SBGN files or pathway IDs and `sbgn.dir` specifies the path to local files. Printing this object will render the graph and write output image files. *SBGNview* object can be further modified by several functions to highlight nodes/edges/paths (e.g. *SBGNview.obj* + *highlightNodes()*, similar to *p* + *geom\_boxplot()* in **ggplot2**).

* These operations will generate image files
  + The following command `SBGNview(...) + highlightNodes(...)` or `SBGNview.obj + highlightNodes(...)` will return a *SBGNview* object to R console. The returned object is executed as a top-level R expression, thus will be implicitly printed using the `print.SBGNview` function in SBGNview package. For more details, please see the documentation for `print.SBGNview` function.
  + Running `SBGNview.obj` in the R console will implicitly print the object while `print(SBGNview.obj)` will explicitly print the object using `print.SBGNview` function.
* These commands will NOT generate plot files:
  + `SBGNview.obj = SBGNview(...) + highlightNodes(...)`. The assign operation “=” will make the returned object invisible therefore it will not be printed.

## 6.1 Structure of *SBGNview* object

The *SBGNview* object is a S3 object defined as a list structure containing ‘data’ and ‘output.file’ and ‘output.formats’ elements. The object is created by the SBGNview S3 class defined within the package. The ‘data’ element of the object is a list containing information for all input SBGN pathways. Each element in ‘data’ is a list holding information of a single SBGN pathway. The information includes parsed glyphs, parsed arcs and other parameters to control graph features passed into *SBGNview* function. The ‘output.file’ element of the object is a string specified for the ‘output.file’ parameter in *SBGNview* function. The output file name can be modified using *outputFile*. The output formats can be updated by assigning a character vector of supported file formats by *SBGNview* function. The code chucks below demonstrate how you can access glyphs and arcs information of a *SBGNview* object as well as changing output file name and output formats.

## 6.2 Extract glyphs and arcs infromation from *SBGNview* object

```
pathway.1.data <- SBGNview.obj$data[[1]]
names(pathway.1.data)
glyphs <- pathway.1.data$glyphs.list
arcs <- pathway.1.data$arcs.list
str(glyphs[[1]])
str(arcs[[1]])
global.pars <- pathway.1.data$global.parameters.list
names(global.pars)
```

## 6.3 Modify *SBGNview* object directly

For each pathway in *SBGNview* object, the ‘global.parameters.list’ element seen above contains the default graphical parameters controlling the plotting of allelements (glyphs and arcs) of the pathway. We can modify these default parameters manually when needed.
Most graphical parameters or features of individual glyphs or arcs can be controlled manually by directly modifying the *SBGNview* object too. For instance, we can modify different slots of *glyphs[[1]]* or *arcs[[1]]* in the code chunk above.
Please make sure to read the documentation of *SBGNview* S3 class in the Value section fo *SBGNview* function.

## 6.4 Change output file name and format of *SBGNview* objects

We can change the name of the output file using built-in function *outputFile*:

```
outputFile(SBGNview.obj)
outputFile(SBGNview.obj) <- "test.change.output.file"
outputFile(SBGNview.obj)
SBGNview.obj
outputFile(SBGNview.obj) <- "test.print"
outputFile(SBGNview.obj)
print(SBGNview.obj)
```

We can update or change the output file formats of a *SBGNview* object. Supported output file formats are any combination of “png”, “pdf”, and “ps”. If an empty vector of output file formats are provided, only the SVG file format will be written to current working directory.

```
print(SBGNview.obj$output.formats)
SBGNview.obj$output.formats <- c("png", "pdf")
```

# 7 Updating & modifying graphs

It is useful to highlight interesting nodes, edges or paths in a pathway map. One way is to modify the *SBGNview* object directly as we’ve seen above. The more systematic way is to use the build-in highlight functions. In other words, the *SBGNview* object can be further modified by concatenating it with modification or highlight functions using binary operator *+* (see [quick start](https://bioconductor.org/packages/devel/bioc/vignettes/SBGNview/inst/doc/SBGNview.quick.start.html#quickexample) for example).

## 7.1 Hightlight nodes

### 7.1.1 Highlight all nodes

```
# Here we set argument "node.set" to select all nodes to be highlighted
highlight.all.nodes.sbgn.obj <-  SBGNview.obj + highlightNodes(node.set = "all",
                                                               stroke.width = 4,
                                                               stroke.color = "green")
outputFile(highlight.all.nodes.sbgn.obj) <- "highlight.all.nodes"
print(highlight.all.nodes.sbgn.obj)
```

![\label{fig:highlightAllNodes}Highlight all nodes.](data:image/svg+xml;base64...)

Figure 7.1: Highlight all nodes.

### 7.1.2 Highlight nodes by class

```
# Here we set argument "select.glyph.class" to select and highlight macromolecule nodes
highlight.macromolecule.sbgn.obj <-  SBGNview.obj +
                                        highlightNodes(select.glyph.class = "macromolecule",
                                                       stroke.width = 4,
                                                       stroke.color = "green")
outputFile(highlight.macromolecule.sbgn.obj) <- "highlight.macromolecule"
print(highlight.macromolecule.sbgn.obj)
```

![\label{fig:highlightMacromolecule}Highlight macromolecule nodes.](data:image/svg+xml;base64...)

Figure 7.2: Highlight macromolecule nodes.

### 7.1.3 Show node IDs instead of node labels

```
# Here we set argument "show.glyph.id" to display node ID instead of the original label
highlight.all.nodes.sbgn.obj <-  SBGNview.obj + highlightNodes(node.set = "(+-)-epinephrine",
                                                               stroke.width = 4,
                                                               stroke.color = "green",
                                                               show.glyph.id = TRUE,
                                                               label.font.size = 10)
outputFile(highlight.all.nodes.sbgn.obj) = "highlight.all.id.nodes"
print(highlight.all.nodes.sbgn.obj)
```

![\label{fig:highlightNodes}Highlight nodes using node IDs.](data:image/svg+xml;base64...)

Figure 7.3: Highlight nodes using node IDs.

## 7.2 Adjust node labels.

### 7.2.1 Label position, font size, color, change labels

The function *highlightNodes* also can be used to adjust labels. In this example, we move the label horizontally and vertically, change their color and font size.

```
# Node labels can be customized by a named vector. The names of the vector are the IDs assigned to argument "node.set". Values of the vector are the new labels for display.
my.labels <- c("Tyr","epinephrine")
names(my.labels) <- c("tyrosine", "(+-)-epinephrine")
SBGNview.obj.adjust.label <-  SBGNview.obj +
                                  highlightNodes(node.set = c("tyrosine", "(+-)-epinephrine"),
                                                 stroke.width = 4,
                                                 stroke.color = "green",
                                                 label.x.shift = 0,
                                                 # Labels are moved up a little bit
                                                 label.y.shift = -20,
                                                 label.color = "red",
                                                 label.font.size = 30,
                                                 label.spliting.string = "",
                                                 labels = my.labels)
outputFile(SBGNview.obj.adjust.label) <- "adjust.label"
print(SBGNview.obj.adjust.label)
```

![\label{fig:changeLabel}Modify node labels.](data:image/svg+xml;base64...)

Figure 7.4: Modify node labels.

### 7.2.2 Label text wrapping into multiple lines

Some nodes may have long labels thus overlap with surrounding graph elements. In this case we can set the parameter *label.spliting.string* to “any” so the label will be wrapped in multiple lines that fit the width of the node.

```
SBGNview.obj.change.label.wrapping <-  SBGNview.obj +
                                        highlightNodes(node.set = c("tyrosine", "(+-)-epinephrine"),
                                                       stroke.width = 4,
                                                       stroke.color = "green",
                                                       show.glyph.id = TRUE,
                                                       label.x.shift = 10,
                                                       label.y.shift = 20,
                                                       label.color = "red",
                                                       label.font.size = 10,
                                                       label.spliting.string = "any")
outputFile(SBGNview.obj.change.label.wrapping) = "change.label.wrapping"
print(SBGNview.obj.change.label.wrapping)
```

![\label{fig:changeWrapping}Change how labels are wrapped.](data:image/svg+xml;base64...)

Figure 7.5: Change how labels are wrapped.

## 7.3 When one input ID maps to multiple nodes

In the example above, we saw that one input ID (e.g. “(+-)-epinephrine”) can be mapped to multiple nodes in the graph. If we just want to focus on several particular ones, we can use function *highlightNodes* to find the node IDs, which is unique to each node:

```
# When "label.spliting.string" is set to a string that is not in the label (including an empty string ""), the label will not be wrapped into multiple lines.
test.show.glyph.id <- SBGNview.obj + highlightNodes(node.set = c("tyrosine", "(+-)-epinephrine"),
                                                    stroke.width = 4,
                                                    stroke.color = "green",
                                                    show.glyph.id = TRUE,
                                                    label.x.shift = 10,
                                                    label.y.shift = 20,
                                                    label.color = "red",
                                                    label.font.size = 10,
                                                    label.spliting.string = "")
outputFile(test.show.glyph.id) <- "test.show.glyph.id"
print(test.show.glyph.id)
```

![\label{fig:displayNodeIds}Show node IDs of mapped nodes.](data:image/svg+xml;base64...)

Figure 7.6: Show node IDs of mapped nodes.

We can find the mapping between input IDs and node IDs:

```
input.pathways <- findPathways("Adrenaline and noradrenaline biosynthesis")
input.pathway.ids <- input.pathways$pathway.id
mapping <- changeIds(input.ids = c("tyrosine", "(+-)-epinephrine"),
                     input.type = "compound.name",
                     output.type = "pathwayCommons",
                     mol.type = "cpd",
                     limit.to.pathways = input.pathway.ids[1])
```

```
mapping
```

```
## $tyrosine
## [1] "SmallMolecule_96737c854fd379b17cb3b7715570b733"
##
## $`(+-)-epinephrine`
## [1] "SmallMolecule_db0211694be3283c6b1fb217c8f331ac"
## [2] "SmallMolecule_7753c3822ee83d806156d21648c931e6"
## [3] "SmallMolecule_a25ed355cc2a6a0800babeb708e2cba4"
```

## 7.4 Highlight arcs and paths

In addition to nodes and their attributes, we may also highlight arcs and paths and modify their attributes. The Quick Start vignette has [one example on highlighting nodes, arcs and paths together](https://bioconductor.org/packages/devel/bioc/vignettes/SBGNview/inst/doc/SBGNview.quick.start.html#quickhighlight).

Here, we can pick two nodes to highlight and find a shortest path between them.

```
outputFile(SBGNview.obj) <- "highlight.by.node.id"
```

```
SBGNview.obj + highlightNodes(node.set = c("tyrosine", "(+-)-epinephrine"),
                              stroke.width = 4,
                              stroke.color = "red") +
               highlightPath(from.node = "SmallMolecule_96737c854fd379b17cb3b7715570b733",
                             to.node = "SmallMolecule_7753c3822ee83d806156d21648c931e6",
                             node.set.id.type = "pathwayCommons",
                             from.node.color = "green",
                             to.node.color = "blue",
                             shortest.paths.cols = c("purple"),
                             input.node.stroke.width = 6,
                             path.node.stroke.width = 3,
                             path.node.color = "purple",
                             path.stroke.width = 5,
                             tip.size = 10)
```

![\label{fig:highlightNodesById}Highlight nodes and shortest path using node IDs.](data:image/svg+xml;base64...)

Figure 7.7: Highlight nodes and shortest path using node IDs.

## 7.5 Different layouts for the same pathway

If the default layout is not ideal, users have two options:

* Modify the layout manually using tools like [newt editor](http://newteditor.org/)
* Download our [pre-generated SBGN-ML files](https://github.com/datapplab/SBGNhub/tree/master/data/SBGN.with.stamp) SBGN-ML files with a different layout. Currently there limited pathways with multiple layout. More will be added in the future.

A new layout for P00001 (“Adrenaline and noradrenaline biosynthesis”) pathway ID is included as part of the *SBGNview* package.

```
new.layout.file.path <- paste(path.package("SBGNview"), "extdata", sep = "/")
SBGNview(gene.data = gse16873,
         gene.id.type = "entrez",
         input.sbgn = "P00001.new.layout.sbgn",
         sbgn.dir =  new.layout.file.path,
         sbgn.gene.id.type = "pathwayCommons",
         output.file = "test.different.layout",
         output.formats =  c("svg"))
```

![\label{fig:differentLayoutFig}Graph with different layout.](data:image/svg+xml;base64...)

Figure 7.8: Graph with different layout.

## 7.6 SVG Editing Tool

SBGNview provides extensive graphical control options for adjusting glyph/arc attributes such as line color/width and text size/color/wrapping/positioning. The SBGNview main function outputs SVG file format by default and other (png, pdf, ps) specified file formats. There might be cases where you would like to adjust specific graphical details more easily. In such cases, [Inkscape](https://inkscape.org/) can be used to modify the generated SVG file and save/export the SVG to other file formats provided by Inkscape.

# 8 ID mapping

SBGNview can automatically map common ID types to SBGN-ML glyphs in our [SBGNview pathway collection](https://github.com/datapplab/SBGNhub/tree/master/data/SBGN.with.stamp). Supported ID types can be accessed as follow:

```
data("mapped.ids")
```

## 8.1 Map between two types of IDs

Besides *changeDataId* which changes ID for omics data, SBGNview provides functions to map between different types IDs:

```
mapping <- changeIds(input.ids = c("tyrosine", "(+-)-epinephrine"),
                     input.type = "compound.name",
                     output.type = "pathwayCommons",
                     mol.type = "cpd",
                     limit.to.pathways = "P00001")
```

```
head(mapping)
```

```
## $tyrosine
## [1] "SmallMolecule_96737c854fd379b17cb3b7715570b733"
##
## $`(+-)-epinephrine`
## [1] "SmallMolecule_db0211694be3283c6b1fb217c8f331ac"
## [2] "SmallMolecule_7753c3822ee83d806156d21648c931e6"
## [3] "SmallMolecule_a25ed355cc2a6a0800babeb708e2cba4"
```

```
mapping <- changeIds(input.ids = c("tyrosine", "(+-)-epinephrine"),
                     input.type = "compound.name",
                     output.type = "chebi",
                     mol.type = "cpd")
```

```
head(mapping)
```

```
## $tyrosine
## [1] "15277" "18186"
##
## $`(+-)-epinephrine`
## [1] "33568"
```

## 8.2 Extract molecule list from pathways

```
mol.list <- sbgn.gsets(database = "metacrop",
                       id.type = "ENZYME",
                       species = "ath",
                       output.pathway.name = FALSE,
                       truncate.name.length = 50)
```

```
mol.list[[1]]
```

```
## [1] "2.6.1.2"  "2.6.1.44"
```

```
mol.list <- sbgn.gsets(database = "pathwayCommons",
                       id.type = "ENTREZID",
                       species = "hsa")
```

```
mol.list[[1]]
```

```
## [1] "217" "219" "224"
```

```
mol.list <- sbgn.gsets(database = "pathwayCommons",
                       id.type = "ENTREZID",
                       species = "mmu")
```

```
mol.list[[1]]
```

```
## [1] "11669" "11671" "72535"
```

```
mol.list <- sbgn.gsets(database = "MetaCyc",
                       id.type = "KO",
                       species = "eco")
```

```
mol.list[[3]]
```

```
##  [1] "K00281" "K00287" "K00288" "K00382" "K00560" "K00600" "K00605" "K01934"
##  [9] "K02437" "K13403"
```

```
mol.list <- sbgn.gsets(database = "pathwayCommons",
                       id.type = "chebi",
                       mol.type = "cpd")
```

```
mol.list[[2]]
```

```
##  [1] "13390" "13392" "15377" "15378" "15379" "15775" "16468" "16793" "17996"
## [10] "19375" "28318" "28618" "28957" "33191" "48981"
```

# 9 Example using selected database

## 9.1 Use Reactome pathway database

```
is.reactome <- pathways.info[,"sub.database"]== "reactome"
reactome.ids <- pathways.info[is.reactome ,"pathway.id"]
SBGNview.obj <- SBGNview(gene.data = gse16873,
                         gene.id.type = "entrez",
                         input.sbgn =  reactome.ids[1:2],
                         output.file = "demo.reactome",
                         output.formats =  c("svg"))
SBGNview.obj
```

# 10 Test SBGN reference cards

```
reference.cards <- c("AF_Reference_Card.sbgn", "PD_Reference_Card.sbgn", "ER_Reference_Card.sbgn")
downloadSbgnFile(reference.cards)
SBGNview.obj <- SBGNview(gene.data = c(),
                         input.sbgn = reference.cards,
                         sbgn.gene.id.type ="glyph",
                         output.file = "./test.refcards",
                         output.formats = c("pdf"),
                         font.size = 1,
                         logic.node.font.scale = 10,
                         status.node.font.scale = 10)
SBGNview.obj
```

# 11 FAQs

## 11.1 Color key

### 11.1.1 Turn off color key

```
SBGNview(key.pos = "none")
```

# 12 Session Info

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
## [1] SBGNview_1.24.0      SBGNview.data_1.23.0 pathview_1.50.0
## [4] knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10                 generics_0.1.4
##  [3] SparseArray_1.10.0          xml2_1.4.1
##  [5] bitops_1.0-9                lattice_0.22-7
##  [7] RSQLite_2.4.3               digest_0.6.37
##  [9] magrittr_2.0.4              evaluate_1.0.5
## [11] grid_4.5.1                  KEGGgraph_1.70.0
## [13] bookdown_0.45               fastmap_1.2.0
## [15] blob_1.2.4                  Matrix_1.7-4
## [17] jsonlite_2.0.0              AnnotationDbi_1.72.0
## [19] graph_1.88.0                DBI_1.2.3
## [21] httr_1.4.7                  XML_3.99-0.19
## [23] Rgraphviz_2.54.0            Biostrings_2.78.0
## [25] jquerylib_0.1.4             abind_1.4-8
## [27] Rdpack_2.6.4                cli_3.6.5
## [29] rlang_1.1.6                 crayon_1.5.3
## [31] rbibutils_2.3               XVector_0.50.0
## [33] Biobase_2.70.0              bit64_4.6.0-1
## [35] DelayedArray_0.36.0         cachem_1.1.0
## [37] yaml_2.3.10                 S4Arrays_1.10.0
## [39] tools_4.5.1                 memoise_2.0.1
## [41] SummarizedExperiment_1.40.0 BiocGenerics_0.56.0
## [43] vctrs_0.6.5                 R6_2.6.1
## [45] org.Hs.eg.db_3.22.0         png_0.1-8
## [47] matrixStats_1.5.0           stats4_4.5.1
## [49] lifecycle_1.0.4             KEGGREST_1.50.0
## [51] Seqinfo_1.0.0               rsvg_2.7.0
## [53] S4Vectors_0.48.0            IRanges_2.44.0
## [55] bit_4.6.0                   pkgconfig_2.0.3
## [57] bslib_0.9.0                 GenomicRanges_1.62.0
## [59] xfun_0.53                   MatrixGenerics_1.22.0
## [61] htmltools_0.5.8.1           igraph_2.2.1
## [63] rmarkdown_2.30              compiler_4.5.1
## [65] RCurl_1.98-1.17
```

# References

Luo, Weijun, and Cory Brouwer. 2013. “Pathview: An R/Bioconductor Package for Pathway-Based Data Integration and Visualization.” *Bioinformatics* 29 (14): 1830–1.