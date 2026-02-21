gCMAPWeb : a web interface for gene-set enrichment analysis

Thomas Sandmann

October 30, 2018

This document provides technical detail on the use of the gCMAPWeb package, including a short
description of input and output data and the conﬁguration of the web application. For expanded
examples using real biological datasets available from public databases, please refer to the tutorial
vignette instead.

Contents

1 Introduction

2 Quickstart

3 Submitting gene sets and proﬁles

4 Understanding gCMAPWeb results

5 Conﬁguration

6 Customizing the gCMAPWeb web interface

7 Deploying gCMAPWeb through rApache

2

2

2

3

5

9

12

1

1 Introduction

The gCMAPWeb package provides a graphical user interface for thegCMAP package, oﬀering users a
simple and comfortable way to compare gene sets or diﬀerential gene expression proﬁles to reference
datasets through their web browser.

Leveraging the Rook package, gCMAPWeb can directly use R’s built-in webserver to provide a
single-user interface. Alternatively, gCMAPWeb can be registered with an apache webserver through
the rApache module, oﬀering a production-quality, multi-user application.

This vignette provides a step-by-step demonstration of

(cid:136) the diﬀerent types of analyses supported by gCMAPWeb

(cid:136) its conﬁguration and customization

(cid:136) the deployment of gCMAPWeb instances through an apache webserver

2 Quickstart

To start gCMAPWeb on the local machine, start R, load the gCMAPWeb library and simply type
gCMAPWeb().

> library( gCMAPWeb )
> gCMAPWeb()

Your web browser will open the gCMAPWeb index page, prompting you to choose one of the tree
supported query types. This gCMAPWeb instance is populated with small, simulated datasets, allowing
you to get a ﬁrst glimpse of the input / output of the gCMAPWeb package.

Many elements on the index.rhtml page can be conﬁgured through global options. Please refer to

section ”Customizing the gCMAPWeb web interface” for details.

3 Submitting gene sets and proﬁles

gCMAPWeb supports three diﬀerent types of queries:

Directional queries

A list with two components, identifying up- and down-regulated genes.

For this query, up- and down-regulated gene sets are submitted separately, allowing gCMAPWeb to
retrieve experiments in which the query genes changed expression in a consistent fashion, e.g.
in the
same (correlated) or opposite (anti-correlated) directions as your query. To identify reference experi-
ments with signiﬁcantly similar expression changes, gCMAPWeb calculates the JG score and obtains
a parametric p-value based on a normal distribution. P-values are converted into local false-discovery
rates using Benjamini Hochberg’s multiple-testing adjustment method.

This query type should also be used if only either up- or down-regulated genes are known, by
submitting only one of the two gene sets. Also, this query is the right choice if the set is expected to
show consistent but unknown behavior. gCMAPWeb will retrieve reference datasets showing correlated
and anti-correlated or results.

2

Non-directional queries

A single list of gene identiﬁers, potentially including both up- and down-regulated mem-
bers.

This query is recommended if the query genes are expected to show mixed diﬀerential expression,
e.g. that some members will be up- and others down-regulated. Using Fisher’s exact test, gCMAPWeb
will retrieve all experiments, in which a signiﬁcant fraction of your genes of interest showed diﬀerential
expression either way. P-values are converted into local false-discovery rates using Benjamini Hochberg’s
multiple-testing adjustment method.

Proﬁle queries

a vector of diﬀerential expression scores (e.g.
z-scores, assumed to be normally dis-
tributed) for all assayed genes, e.g. the complete results of a two-class diﬀerential expres-
sion analysis.

If you the complete set of diﬀerential expression scores (e.g. z-scores) from a global diﬀerential
gene expression analysis, a proﬁle query can be performed. Technically, a proﬁle query is the reverse
of a directional query:
in the former, you provide the global diﬀerential gene expression scores and
gCMAPWeb matches them to the gene identiﬁers in the reference database. In the latter, you provide a
list of gene identiﬁers and gCMAPWeb retrieves the diﬀerential expression scores these genes received in
other experiments from its reference database. As for the directional query type, gCMAPWeb calculates
the JG score and derives parametric p-values using a normal distribution. For this procedure to be
valid, the submitted scores should be approximately normally distributed.

For this query, two pieces of information need to be submitted for every gene:

(cid:136) a gene identiﬁer

(cid:136) the associated diﬀerential gene expression score for this gene

Selecting reference datasets

Users can select either a single or multiple reference datasets from the same species for analysis. In-
ternally, each set will be processed separately and p-value correction is applied within each reference
dataset.

For more information on the elements in the user interface, please consult the help.html ﬁle available

through the ”Help” menu item on the gCMAPWeb index page.

4 Understanding gCMAPWeb results

Once you submitted your query, the gCMAP tool will search all selected databases for signiﬁcantly
similar experiments. The ﬁrst result page will present a list of the most signiﬁcant reference datasets
matching your query (if any). A separate panel with results will be generated with results for each
searched reference database.

Gene set reports

The main gCMAPWeb result page presents information about the detected similar experiments (not
individual genes). At the top of the page, a density plot provides a high-level overview ( Figure 1).
Reference instances with similarity scores >3 or <-3 are highlighted as green and blue dashes at the
bottom of the plot and in the heatmap on the right.

3

Figure 1: Example of a gene-set score density plot, as found on the main gCMAPWeb result page.
The grey density plot summarizes the scores for all experiments in this reference dataset - similar or not.
For reference, the normal distribution is shown as a dashed line. Reference instances with similarity
scores >3 (correlated experiments) or <-3 (anti-correlated experiments) are indicated in the rug plot.
On the right, the same similarity scores are shown as an ordered heatmap. High scores are shown at
the top (green) and low scores at the bottom (blue).

In this example, only few experiments received high scores (green), indicating expression changes in
the same direction as in the query, but a large number of experiments showed consistent changes of the
query genes in the opposite direction (blue) than speciﬁed in the query.

Gene-level reports

For each reported gene set, gCMAPWeb generates a separate html page with detailed results for indi-
vidual query genes. (If you submitted a complete proﬁle, you will be presented with the scores for the
those genes signiﬁcantly changing in similar experiments.)

Gene-level results are linked via the nFound column in the main result table. For directional queries,

the gene-level report will display the distribution of scores in a density plot.

While the density plot on the main result page displayed the similiarity scores for each reference
dataset, summarizing a potentially large number of genes, this plot shows the diﬀerential gene expression
scores of individual (query) genes ( Figure 2).

For more information about the elements presented in the gCMAPWeb output, please consult the
help.html ﬁle available through the ”Help” menu item on the gCMAPWeb index page for additional
examples for all query types.

4

Figure 2: Example of a gene score density plot. The grey density plot summarizes the scores for all
genes assayed in this reference dataset. For reference, the normal distribution is shown as a dashed line.
The distribution of query genes submitted as ”up-regulated” is shown in green, that of ”down-regulated”
query genes is shown in blue. (For non-directional queries, a single query gene density is shown in
black.) Query gene scores are also indicated in the rug plot following the same color scheme as outlined
above. In this example, an anti-correlated result is shown: query genes submitted as ”up-regulated”
(green) are shifted toward negative scores, while ”down-regulated” query genes are shifted to positive
scores.

5 Conﬁguration

This section will take you through the steps necessary to search your own datasets with gCMAPWeb.

Reference datasets

gCMAPWeb can query either quantitative diﬀerential expression data, e.g. z-scores, stored in NChan-
nelSet objects, or gene-set collections provided as CMAPCollection objects. To avoid reading large
datasets fully in to memory, gCMAPWeb can take advantage of the bigmemory and bigmemoryExtras
packages to retrieve only the required data from a binary ﬁle stored on disk. Note: At the time or
writing these two packages were only available for Unix and Mac OS X but not Windows operating
systems.

All reference datasets must be provided with Entrez gene identiﬁers. If available, information
from the abstract , title slots will be used for labels and pop-over help on the submission page (see
ﬁgure 3).

For example, please take a look at the cmap1 NChannelSet and the cmap5 CMAPCollection objects

provided with the package.

> library(gCMAPWeb)
> data( "cmap1" )
> cmap1

NChannelSet (storageMode: lockedEnvironment)
assayData: 1000 features, 10 samples

5

element names: p, z

protocolData: none
phenoData

sampleNames: Exp1 Exp2 ... Exp10 (10 total)
varLabels: Name Treatment Date
varMetadata: labelDescription channel

featureData: none
experimentData: use
Annotation: org.Hs.eg

’

experimentData(object)

’

> experimentData( cmap1 )@title

[1] "Reference dataset 1"

> abstract( cmap1 )

[1] "A first test dataset with experiment with random z-scores for 1000 genes"

> data( "cmap5" )
> cmap5

CMAPCollection (storageMode: lockedEnvironment)
assayData: 1000 features, 10 samples

element names: members

protocolData: none
phenoData

sampleNames: Exp1 Exp2 ... Exp10 (10 total)
varLabels: Name signed
varMetadata: labelDescription

featureData: none
experimentData: use
Annotation:

’

experimentData(object)

’

By default, NChannelSet reference objects are made available for all three query types, unsigned,
directional and proﬁle. CMAPCollections, on the other hand, only provide gene set membership infor-
mation. If gene-signs are included in the CMAPCollection, indicating whether genes are expected to
be up- or down-regulated, the reference dataset is made available for non-directional (unsigned) and
proﬁle queries. If the CMAPCollection contains (any) unsigned gene sets, the reference dataset can
only be selected for non-directional queries. To manually include or exclude reference datasets from
speciﬁc query types, a character vector with the supported query types (unsigned, directional, pro-
ﬁle ) can be speciﬁed by specifying experimentData@other$supported.query in the NChannelSet or
CMAPCollection.

To hide the cmap1 reference dataset on the proﬁle submission page, simply include information

about the supported query type(s) in the experimentData slot

> cmap1@experimentData@other$supported.query <- c("unsigned", "directional")

By default, all of the sample annotations available in the phenoData slot of the reference dataset
will be included in the table of signiﬁcantly similar reference experiments. To exclude non-informative
columns, an additional include column can be included as an additional varMetdata column, indi-
cating for each phenoData column whether is it should be included in the result table or not.

For example, the following commands prevents cmap1’s ”Date” column from the being displayed.

> head( pData( cmap1 ), n=3)

6

Name Treatment

Exp1 Exp1
Exp2 Exp2
Exp3 Exp3

Date
a 01.01.2010
b 01.02.2010
c 01.03.2010

> varMetadata( cmap1 )

Name
Treatment
Date

labelDescription channel
<NA>
<NA>
<NA>

Experiment name
Agent
Date of experiment

> varMetadata( cmap1 )$include <- c(TRUE, TRUE, FALSE)
> varMetadata( cmap1 )

Name
Treatment
Date

labelDescription channel include
TRUE
TRUE
FALSE

Experiment name
Agent
Date of experiment

<NA>
<NA>
<NA>

Reference datasets are speciﬁed by providing the full path to the corresponding Rdata ﬁle in the

conﬁguration ﬁle. (Please note that each Rdata ﬁle should only contain a single eSet.)

Essential information : the conﬁguration ﬁle

gCMAPWeb’s conﬁguration ﬁle is in YAML format provides details on the reference datasets to be included
in gCMAPWeb in the form of a nested list. It includes e.g. the path to the RData ﬁle and the name of
the associated annotation package.

Here is a simple example of a conﬁguration for a gCMAPWeb instance supporting only human gene

queries:

species:
human:

annotation: org.Hs.eg
platforms:

- hgug4100a
- hgug4110b

cmaps:

reference1: /home/data/ref1.rdata
reference2: /home/data/ref2.rdata

In this example

(cid:136) species: contains only one supported species, human.

(cid:136) annotation: speciﬁes that mappings between gene identiﬁers are retrieved from Bioconductor’s
org.Hs.eg annotation package. gCMAPWeb automatically loads the speciﬁed annotation pack-
ages, so they must be installed on the user’s system.

(cid:136) platforms: speciﬁes two microarrays (hgug4100a, hgug4110b). Users submitting queries with
”probe” as identiﬁer type will be prompted to choose one of these two supported platforms.
gCMAPWeb automatically loads the speciﬁed annotation packages, so they must be installed
on the user’s system.

7

(cid:136) cmaps: contains the full path to the reference datasets for this species. Each path must be
preceded by a unique identiﬁer (e.g. reference.1). As this identiﬁer is used as an object name
both in R and javascript, it must be a single alpha-numeric single string and must not contain
spaces, hyphens, dots, etc. This identiﬁer is only displayed on the submission page if the eSet
does not have a title.

Additional species can be added by duplicating the species block of the conﬁguration and modi-

fying the respective ﬁelds. (See default conﬁguration ﬁle for an example with two species.)

When gCMAPWeb is invoked without additional parameters, the default conﬁguration ﬁle in the
config directory of the gCMAPWeb package is read. You can obtain the full path to the default
conﬁguration ﬁle on your system with the following command:

> system.file("config", "config.yml", package = "gCMAPWeb")

To read your own, customized conﬁguration ﬁle instead, provide its path via the config.file.path

parameter.

> gCMAPWeb( config.file.path = "/path/to/your/config_file.yml")

Additional information : eSet slots

The conﬁguration ﬁle provides all required information to start a gCMAPWeb instance. To ﬁne-tune
the information displayed about each reference dataset, three diﬀerent settings can be customized on
the object level using the default slots of eSet objects.

Figure 3: Reference dataset information

If present, three diﬀerent slots are used by gCMAPWeb (see ﬁgure 3):

(cid:136) abstract: Text in the abstract slots will be displayed as pop-up information upon mouse-over. If
no abstract is provided, generic information about the number of experiments in the dataset is
displayed instead.

(cid:136) title: The eSet title will be used as the reference database name displayed on the submission page.
If not title is provided, the unique identiﬁer speciﬁed for this dataset in the conﬁguration ﬁle is
used instead.

(cid:136) other$supported.query: Deﬁnes for which query type this dataset should be made available, one
or more of ”directional”, ”unsigned” and /or ”proﬁle”. If no other$supported.query information is
provided, the class of the reference dataset evaluated instead with the following defaults:

– NChannelSet: available for all three query types

– CMAPCollection, unsignedavailable for non-directional/unsigned queries only

– CMAPCollection, signedavailable for non-directional/unsigned and proﬁle queries

8

6 Customizing the gCMAPWeb web interface

Many elements of the user interface and parameters of the gCMAPWeb search methods can be set
through global parameters. These can either be called before executing the gCMAPWeb() function for
local instances or be included in the start-up script executed by the rApache server (see below).

Navigation bar

Please note that text elements displayed on the html page(s) are intepreted as html code.

(cid:136) site.title Brand shown on the upper left of the menu bar

(cid:136) home.url URL linked to brand item in the menu bar

(cid:136) doc.url URL linked to ”Help” item in the menu bar

(cid:136) feedback.url URL linked to ”Feedback” item in the menu bar

(cid:136) contact.email URL linked to ”Contact” item in the menu bar

(cid:136) name.out additional element on the far right of the menu bar

(cid:136) link.out URL linked to ”name.out” item in the menu bar

Processing options

(cid:136) save.intermediates Logical, should intermediate ﬁles be saved (for debugging). Default: TRUE

(cid:136) element AssayDataElementName of the assayData slot with diﬀerential expression scores to re-

trieve from NChannelSet reference datasets. Default: ”z”

(cid:136) min.set.size Minimum number of elements a reference gene set must contain to be searched. (Note:
not to be confused with option min.found, the minimum number of overlap between query and
reference sets ) Default: 5

(cid:136) max.set.size Maximum number of elements a reference gene set may contain to be searched. (Note:

only applies to non-directional and proﬁle queries ) Default: Inf

(cid:136) lower.threshold Lower score threshold applied to reference datasets or proﬁle queries to identify

signﬁcantly down-regulated genes. Default=-3

(cid:136) higher.threshold Lower score threshold applied to reference datasets or proﬁle queries to identify

signﬁcantly up-regulated genes. Default= 3

(cid:136) induce.from.element AssayDataElementName of the assayData slot with diﬀerential expression
scores to threshold when gene sets are induced from NChannelSet reference datasets. Default: ”z”
(cid:136) cmaps.concatenated.by Character string used to concatenate multiple requested reference dataset

names in the html POST request . Default: ”,”

(cid:136) max.results Maximum number of similar reference datasets to return with FDR < option max.padj.
As gene-level pages are created for each signiﬁcant set, increasing this number can lead to increased
processing time. Default: ”50”

(cid:136) min.found Minimum number of query genes found in a reference gene set for it to be included in

the result table. Default: ”1”

(cid:136) max.padj Maximum adjusted p-value / FDR for a gene set to be included in the result table.

Default: 0.1

9

Output options

(cid:136) gene.level.report Logical, should sub-pages be created for each of the top max.results signiﬁcant

gene sets ? Default=TRUE

(cid:136) gene.level.plot Logical, should gene-level pages include a plot of score distributions ? Default=TRUE

(cid:136) show.heatmap Logical, should gene-level scores (if available) be displayed in a heatmap on the

main result page ? Default=TRUE

(cid:136) excluded.cols Character vector with columns to exclude from a CMAPResults object when the
html output is created. Default=c(”geneScores”, ”signed”, ”pval”, ”UID”, ”z.shift”, ”log fc.shift”,
”mod fc.shift”)

(cid:136) swap.colnames List of column names to rename when the html output is created. Default=list(padj=”FDR”,

nFound=”Genes”)

(cid:136) table.javascript Logica, should the dataTable javascript module be used to render the output html

tabels ? Default=TRUE

show.heatmap

Index page

Figure 4: Options available to customize the index page

The following options are available to customize the index html page (see ﬁgure ﬁgure 4 for a
graphical overview). Please note that text elements displayed on the html page(s) are intepreted as
html code.

(cid:136) index.main Main title shown on the index page. Default=”gConnectivity Map”

(cid:136) index.sub Subtitle shown on the index page. Default=”a search engine for diﬀerential gene ex-

pression proﬁles.”

10

(cid:136) index.text Text shown on the the index page. Default=”Compare your favorite genes to a reference

database of diﬀerential expression experiments”

(cid:136) index.message Text shown in a box highlighed in green on the the index page. Default=NULL

(cid:136) index.quote Text shown as quote on the the index page.

(cid:136) supported.inputType They query type(s) oﬀered. Default: c(”single”, ”non-directional”, ”direc-

tional”, ”proﬁle”)

(cid:136) supported.idType The supported gene identﬁer types. Default: c(”symbol”, ”entrez”, ”probe”)

Examples

The following options specify which gene identiﬁers are pasted into the submission boxes when the
”Example query” button is pressed.

Figure 5: Options populating the Example query button on the directional query submission page.

The following options are available to customize the index html page (see ﬁgure ﬁgure 5 for a

screenshot of the directional query submission page with relevant options).

(cid:136) single.gene.example Example input for a single gene lookup.

(cid:136) single.gene.example.popover Text to be displayed in the pop-over element for the Example query

button for singel gene lookups.

(cid:136) signed.input.example.down Example query for down-regulated genes in a directional query

(cid:136) signed.input.example.up Example query for up-regulated genes in a directional query

(cid:136) signed.input.example.popover Text to be displayed in the pop-over element for the Example query

button for signed queries.

(cid:136) unsigned.input.example Example query for a non-directional query

(cid:136) unsigned.input.example.popover Text to be displayed in the pop-over element for the Example

query button for unsigned queries.

(cid:136) proﬁle.input.example Example gene identiﬁer / score pairs for a non-directional query. Newlines

have to be included as \\n strings between consecutive id-score pairs.

(cid:136) proﬁle.input.example.popover Text to be displayed in the pop-over element for the Example query

button for proﬁle queries.

11

Figure legends

(cid:136) gene.proﬁle.legend Legend for the density plot on the main result page for proﬁle queries

(cid:136) gene.set.legend Legend for the density plot on the main result page for directional and non-

directional queries

(cid:136) heatmap.legend Legend for the heatmap plot on the main result page for directional and non-

directional queries

(cid:136) gene.density.legend Legend for the density plot on gene-level report pages

(cid:136) gene.pie.legend Legend for the pie charts on gene-level report pages

For example, the main title of the gCMAPWeb index page can be retrieved and set using the

site.title option.

> getOption( "site.title", default="gCMAP")
> options( site.title="New site title")

7 Deploying gCMAPWeb through rApache

To run gCMAPWeb in a multi-user environment, the application can be deployed through rApache.
For installation and conﬁguration options of Apache and rApache, please consult the respective project
pages. The following instructions assume that you have access to the Apache installation directory,
especially the httpd.conf ﬁle.

Once a working webserver is available, the following steps are required to deploy gCMAPWeb:

1. Locate the the htdocs directory within the gCMAPWeb installation directory on your system and
copy its contents (including all subdirectories) into the htdocs directory of your Apache instal-
lation. You can retrieve the location of gCMAPWeb’s htdocs directory by issuing the following
commands in your R console:

> library( gCMAPWeb )
> system.file("htdocs", package="gCMAPWeb")

2. Locate the gCMAP_app.R , rapache_config.R and config.yml ﬁles in gCMAPWeb’s installation

directory and copy them to a location accessible to the Apache server.

> system.file("config", "rapache", "gCMAP_app.R", package="gCMAPWeb")
> system.file("config", "rapache", "rapache_config.R", package="gCMAPWeb")
> system.file("config", "config.yml", package="gCMAPWeb")

3. Edit the new copy of the gCMAP_app.R text file with a text editor of your choice and

change the ’root.url’ variable (first line) to point toward the location of your Apache
htdocs directory.

4. Edit the new copy of the rapache_config.R text ﬁle with a text editor of your choice and change
the config.file.path variable to point toward the location of your copy of the config.yml
ﬁle. The the rapache_config.R is executed upon startup for each R session by the Apache web
server. Use the options command to set any global options to ﬁne-tune the look and behavior
of gCMAPWeb

5. Open the httpd.conf of your Apache webserver and ensure that rApache has been installed
correctly, e.g. by testing that the r-info test application is accessible, as described in the rApache
manual.

12

6. Add or modify the REvalOnstartup and RSourceOnStartup command lines to include the fol-

lowing lines (replace PATH_TO_YOUR with the path to your rapache_config.R ﬁle):

REvalOnStartup "library(gCMAPWeb)"
RSourceOnStartup "PATH_TO_YOUR/rapache_config.R"

These lines will instruct Apache to load the gCMAPWeb package upon starting an R session and
execute the commands in the rapache_config.R R script. (You can add additional commands
to the rapache_config.R ﬁle, e.g. specifying the number of cores available on your system, etc.)

7. To register the gCMAPWeb application with the Apache webserver, add the following lines to the

httpd.conf , replacing PATH_TO_YOUR with the path to your gCMAP_app.R ﬁle:

<Location /gcmap>

SetHandler r-handler
RFileEval PATH_TO_YOUR/gCMAP_app.R:Rook::Server$call(gcmap)

</Location>

8. After restarting the Apache server, your gCMAPWeb application will be available at

YOUR_HOST_NAME://gcmap/index.rhtml

13

> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats4
[8] methods

parallel stats
base

graphics grDevices utils

datasets

other attached packages:

[1] gCMAPWeb_1.22.0
[4] limma_3.38.0
[7] annotate_1.60.0

[10] IRanges_2.16.0
[13] BiocGenerics_0.28.0

Rook_1.1-1
GSEABase_1.44.0
XML_3.98-1.16
S4Vectors_0.20.0

gCMAP_1.26.0
graph_1.60.0
AnnotationDbi_1.44.0
Biobase_2.42.0

loaded via a namespace (and not attached):

[1] Rcpp_0.12.19
[5] tools_3.5.1
[9] memoise_1.1.0
[13] Category_2.48.0
[17] hwriter_1.3.2
[21] RBGL_1.58.0
[25] splines_3.5.1

compiler_3.5.1
digest_0.6.18
lattice_0.20-35
yaml_2.2.0
genefilter_1.64.0 bit64_0.9-7
survival_2.43-1
xtable_1.8-3

RColorBrewer_1.1-2 bitops_1.0-6
bit_1.1-14
Matrix_1.2-14
GSEAlm_1.42.0

RSQLite_2.1.1
DBI_1.0.0
DESeq_1.34.0
grid_3.5.1
geneplotter_1.60.0 blob_1.1.1
brew_1.0-6

RCurl_1.95-4.11

14

