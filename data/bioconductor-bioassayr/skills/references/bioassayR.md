Code

* Show All Code
* Hide All Code

# bioassayR Introduction and Examples

Authors: Tyler Backman, Thomas Girke

#### Last update: 29 October, 2025

#### Package

bioassayR 1.48.0

# 1 Introduction

*bioassayR* is a tool for cross-target analysis of biological screening data. It allows users to store, organize, and
systematically analyze data from a large number of small molecule bioactivity experiments of heterogenous design.
Users have the option of supplying their own bioactivity
data for analysis, or downloading a database from the authors website (<http://chemmine.ucr.edu/bioassayr>) pre-loaded with bioactivity data sourced from NCBI PubChem BioAssay (Backman, Cao, and Girke [2011](#ref-Backman2011a); Wang et al. [2012](#ref-Wang:2012hj)).
The pre-loaded database contains the results of thousands of bioassay experiments, where small molecules were screened against a defined biological target.
*bioassayR* allows users to leverage these data as a reference to
identify small molecules active against a protein or organism of interest, identify target selective compounds that may be useful as drugs or chemical genomics probes, and identify and compare the activity profiles of small molecules.

The design of bioassayR is based around four distinct objects, each which
is optimized for investigating bioactivity data in different ways.
The *bioassay* object stores activity data for a single assay, and also acts as
a gateway for importing new activity data, and editing the data for a single assay.
The *bioassayDB* object uses a SQL database to store and query thousands of
assays, in a time-efficient manner. Often users will wish to further investigate
a set of compounds or assays identified with a *bioassayDB* query by pulling
them out into a *bioassaySet* object. The *bioassaySet*
object stores activity data as a compound vs assay matrix, and can be created
from a list of assay ids or compounds of interest. Lastly, the *perTargetMatrix*
is a matrix of compounds vs targets, where replicates (assays hitting the same
target) from a *bioassaySet* object are summarized into a single value.
This internally uses a sparse matrix
to save system memory, while allowing the user to leverage R language matrix features to
further investigate these data.

![](data:image/png;base64...)

Organizational overview of bioassayR. Custom and public bioassays
are loaded into the bioassayDB database, and accessor functions will query
these data to identify targets and compounds of interest. A compound vs. target
sparse matrix or bioactivity fingerprint can be generated for further analysis of
any combination of compounds and targets.

# 2 Getting Started

## 2.1 Installation

The R software for running bioassayR can be downloaded from CRAN (<http://cran.at.r-project.org/>).
The *bioassayR* package can be installed from R using the *BiocManager* package.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("bioassayR") # Installs the package
```

## 2.2 Loading the Package and Documentation

```
library(bioassayR) # Loads the package
```

```
library(help="bioassayR") # Lists all functions and classes
vignette("bioassayR") # Opens this manual from R
```

## 2.3 Quick Tutorial

This example walks you through creating a new empty database, adding example small molecule bioactivity data, and performing queries on these data. If you are interested only in querying
a pre-built PubChem BioAssay database, skip to the later section titled “Prebuilt Database Example: Investigate Activity of a Known Drug.”

This example includes real experimental data from an antibiotics discovery experiment. These data are a “confirmatory bioassay” where 57 small molecules were screened against the mevalonate kinase protein from the *Streptococcus pneumonia* (SP) bacteria. Mevalonate kinase inhibitors are one possible class of antibiotic drugs that may be effective against this infamous bacteria.
These data were published as assay identifier (aid) 1000 in the NCBI PubChem BioAssay database, by Dr. Thomas S. Leyh.

First, create a new database. For purposes of this manual a temporary file is used, but you can replace the *tempfile* function call with a filename of your choice if you wish to save the resulting database for later.

```
library(bioassayR)
myDatabaseFilename <- tempfile()
mydb <- newBioassayDB(myDatabaseFilename, indexed=FALSE)
```

Next, specify the source and version of the data you plan to load. This is a required step, which makes it easier to track the origin of your data later. Feel free to use the current date for a version number, if your data isn’t versioned.

```
addDataSource(mydb, description="PubChem BioAssay", version="unknown")
```

After adding a data source, create or import a *data.frame* which contains the activity scores for each of the molecules in your assay.
This *data.frame* must contain three columns which includes a cid (unique compound identifier) for each compound, a binary activity score (1=active, 0=inactive, NA=inconclusive), and a numeric activity score.
Consult the *bioassay* man page for more details on formatting this *data.frame*. The *bioassayR* package contains an example activity score data frame that can be accessed as follows:

```
data(samplebioassay)
samplebioassay[1:10,] # print the first 10 scores
```

```
##         cid activity score
## 1    730195        0     0
## 2  16749973        1    80
## 3  16749974        1    80
## 4  16749975        1    80
## 5  16749976        1    80
## 6  16749977        1    80
## 7  16749978        1    80
## 8  16749979        1    80
## 9  16749980        1    80
## 10 16749981        1    80
```

All bioactivity data is loaded into the database, or retrieved from the database as an *bioassay* object which contains details on the assay experimental design, molecular targets, and the activity scores. A bioassay object which incorporates activity scores can be created as follows.
The source id value must exactly match that loaded earlier by *addDataSource*. The molecular target(s) for the assay are optional, and an unlimited number can be specified for a single assay as a vector passed to the targets option. The target types field should be a vector of equal length, describing the type of each target in the same order.

```
myAssay <- new("bioassay",aid="1000", source_id="PubChem BioAssay",
    assay_type="confirmatory", organism="unknown", scoring="activity rank",
    targets="116516899", target_types="protein", scores=samplebioassay)
myAssay
```

```
## class:        bioassay
## aid:      1000
## source_id:    PubChem BioAssay
## assay_type:   confirmatory
## organism:     unknown
## scoring:  activity rank
## targets:  116516899
## target_types:     protein
## total scores:     57
```

The *bioassay* object can be loaded into the database with the *loadBioassay* function. By repeating this step with different data, a large number of distinct assays can be loaded into the database.

```
loadBioassay(mydb, myAssay)
```

It is reccomended to use NCBI GI numbers as the label for any biomolecule
assay targets, as this is what is used in the pre-built database also
supplied with the package. In some cases it is useful to also store identifier translations,
which contain the corresponding IDs from other biological databases. For example,
in this case the mevalonate kinase target protein GI 116516899 has a corresponding
identifier in the UniProt Database of Q8DR51. This can be stored for future reference as follows.
Any number of translations from any category of choice can be stored in this way. It
can also be used to store annotation data for targets. For example, if you
have sequence level clustering data on your targets you could store them
in category “sequenceClustering” and store the cluster number as the identifier.

```
loadIdMapping(mydb, target="116516899", category="UniProt", identifier="Q8DR51")
```

Wait a minute! We accidentally labeled that assay as organism “unknown” when we know that it’s actually a screen against a protein from *Streptococcus pneumonia*.
After loading an assay into the database, you can later retrieve these data with the *getAssay* function. By combining this with the ability to delete an assay (the *dropBioassay* function) one can edit the database by (1) pulling an assay out, (2) deleting it from the database, (3) modifying the pulled out object, and (4) reloading the assay. For example, we can update the species annotation for our assay as follows:

```
tempAssay <- getAssay(mydb, "1000") # get assay from database
dropBioassay(mydb, "1000") # delete assay from database
organism(tempAssay) <- "Streptococcus pneumonia" # update organism
loadBioassay(mydb, tempAssay)
```

It is recommended to index your database after loading all of your data. This significantly speeds up access to the database, but can also slow down loading of data if indexing is performed before loading.

```
addBioassayIndex(mydb)
```

```
## Creating index: note this may take a long time for a large database
```

After indexing, you can query the database. Here are some example queries. First view the database summary provided by *bioassayR*:

```
mydb
```

```
## class:            BioassayDB
## assays:           1
## sources:      PubChem BioAssay
## source versions:  unknown
## writeable:       yes
```

Next, you can query the database for active targets for a given compound by cid. In this case, since only one assay has been loaded only a single target can be found. Experiment with loading more assays for a more interesting result!
When using the pre-built PubChem BioAssay database, these targets are returned
as NCBI Protein identifiers.

```
activeTargets(mydb, 16749979)
```

```
##           fraction_active total_screens
## 116516899               1             1
```

If target translations were loaded in a previous step, these can be accessed with
the *translateTargetId* function as follows. This accepts only a single target,
and will return a vector of all corresponding identifiers in the category of choice.
In some cases, you may wish to subset this result to only get a single indentifier
when the database contains a large number for some targets.

Here we request the UniProt identifiers for GI 116516899, as stored earlier with
the *loadIdMapping* function.

```
translateTargetId(mydb, target="116516899", category="UniProt")
```

```
## [1] "Q8DR51"
```

Lastly, disconnecting from the database after analysis reduces the chances of data corruption. If you are using a pre-built database in read only mode (as demonstrated in the Prebuilt Database Example section) you can optionally skip this step, as only writable databases are prone to corruption from failure to disconnect.

```
disconnectBioassayDB(mydb)
```

# 3 Examples

## 3.1 Loading User Supplied PubChem BioAssay Data

This section demonstrates the process for creating a new bioactivity database from user supplied data. As an example, we will demonstrate the process of downloading an assay from the NCBI PubChem BioAssay bioactivity data repository, and loading this into a new database (Wang et al. [2012](#ref-Wang:2012hj)).

First, get two files from PubChem BioAssay for the assay of interest: an XML file containing details on how the experiment was performed, and a CSV (comma separated value) file which contains the actual activity scores. For the purposes of this example, we will use the data from assay 1000, which is a confirmatory assay (titration assay) of 57 small molecules against a mevalonate kinase protein. More details on this assay were provided in the “Quick Tutorial,” where the same data is used. These files can be downloaded from PubChem BioAssay at <http://pubchem.ncbi.nlm.nih.gov/> or loaded from the example data repository included in this package as follows:

```
library(bioassayR)
extdata_dir <- system.file("extdata", package="bioassayR")
assayDescriptionFile <- file.path(extdata_dir, "exampleAssay.xml")
activityScoresFile <- file.path(extdata_dir, "exampleScores.csv")
```

Next, create a new empty database for loading these data into. This example uses the R *tempfile* function to create the database in a random location. If you would like to keep your resulting database, replace *myDatabaseFilename* with your desired path and filename.

```
myDatabaseFilename <- tempfile()
mydb <- newBioassayDB(myDatabaseFilename, indexed=F)
```

We will also add a data source to this database, specifying that our data here mirrors an assay provided by PubChem BioAssay.

```
addDataSource(mydb, description="PubChem BioAssay", version="unknown")
```

The XML file provided by PubChem BioAssay contains extensive details on how the assay was performed, molecular targets, and results scoring methods. You can extract these using the *parsePubChemBioassay* function as follows.
The *parsePubChemBioassay* function also requires a .csv file which contains the activity scores for each assay, in the standard CSV format provided by PubChem BioAssay.
For data from sources other than PubChem BioAssay, you may need to write your own code to parse out the assay details- or type them in manually.

```
myAssay <- parsePubChemBioassay("1000", activityScoresFile, assayDescriptionFile)
myAssay
```

```
## class:        bioassay
## aid:      1000
## source_id:    PubChem BioAssay
## assay_type:   confirmatory
## organism:     NA
## scoring:  IC50
## targets:  116516899
## target_types:     protein
## total scores:     57
```

Next, load the resulting data parsed from the XML and CSV files into the database. This creates records in the database for both the assay itself, and it’s molecular targets.

```
loadBioassay(mydb, myAssay)
```

To load additional assays, repeat the above steps. After all data is loaded, you can significantly improve subsequent query performance by adding an index to the database.

```
addBioassayIndex(mydb)
```

```
## Creating index: note this may take a long time for a large database
```

After indexing, perform a test query on your database to confirm that the data loaded correctly.

```
activeAgainst(mydb,"116516899")
```

```
##          fraction_active total_assays
## 16749973               1            1
## 16749974               1            1
## 16749975               1            1
## 16749976               1            1
## 16749977               1            1
## 16749978               1            1
## 16749979               1            1
## 16749980               1            1
## 16749981               1            1
## 16749982               1            1
## 16749983               1            1
## 16749984               1            1
## 16749985               1            1
## 16749986               1            1
## 16749987               1            1
## 16749988               1            1
## 16749989               1            1
## 16749990               1            1
## 16749991               1            1
## 16749992               1            1
## 16749993               1            1
## 16749994               1            1
## 16749995               1            1
## 16749996               1            1
## 16749997               1            1
## 16749998               1            1
## 16749999               1            1
## 16750000               1            1
## 16750001               1            1
## 16750002               1            1
## 16750003               1            1
## 16750004               1            1
## 16750005               1            1
## 16750006               1            1
## 16750007               1            1
## 16750016               1            1
```

Lastly, disconnect from the database to prevent data corruption.

```
disconnectBioassayDB(mydb)
```

## 3.2 Prebuilt Database Example: Investigate Activity of a Known Drug

A pre-built database containing large quantities of public domain bioactivity data sourced from the PubChem BioAssay database, can be downloaded from <http://chemmine.ucr.edu/bioassayr>.
While downloading the full database is recommended, it is possible to run this example using a small subset of the database, included within the *bioassayR* package for testing purposes.
This example demonstrates the utility of *bioassayR* for identifying the bioactivity patterns of a small drug-like molecule. In this example, we look at the binding activity patterns for the drug acetylsalicylic acid (aka Aspirin) and compare these binding data to annotated targets in the [DrugBank](http://www.DrugBank.ca) drug database (Wishart et al. [2008](#ref-Wishart:2008bb)).

The DrugBank database is a valuable resource containing numerous data on drug activity in humans, including known molecular targets. In this exercise, first take a look at the
annotated molecular targets for acetylsalicylic acid by searching this name at <http://drugbank.ca>. This will provide a point of reference for comparing to the bioactivity
data we find in the prebuild PubChem BioAssay database. Note that DrugBank also contains the PubChem CID of this compound, which you can use to query the bioassayR PubChem BioAssay
database.

To get started first connect to the database. The variable *sampleDatabasePath* can be replaced with the filename of the full test database you downloaded, if you would like to use
that instead of the small example version included with this software package.

```
library(bioassayR)
extdata_dir <- system.file("extdata", package="bioassayR")
sampleDatabasePath <- file.path(extdata_dir, "sampleDatabase.sqlite")
pubChemDatabase <- connectBioassayDB(sampleDatabasePath)
```

Next, use the *activeTargets* function to find all protein targets which acetylsalicylic acid shows activity against in the loaded database.
These target IDs are NCBI Protein identifiers as provided by PubChem BioAssay (Tatusova et al. [2014](#ref-Tatusova2014)). In which cases do these results agree with or disagree
with the annotated targets from DrugBank?

```
drugTargets <- activeTargets(pubChemDatabase, "2244")
drugTargets
```

```
##           fraction_active total_screens
## 116241312             1.0             2
## 117144                1.0             1
## 125987835             1.0             1
## 166897622             1.0             1
## 226694183             1.0             1
## 317373262             1.0             6
## 3914304               1.0            14
## 3915797               0.8            10
## 6686268               1.0             1
## 754286265             1.0            22
## 84028191              1.0             1
```

Now we would like to connect to the UniProt (Universal Protein Resource) database
to obtain annotation details on these targets
(Bateman et al. [2015](#ref-Bateman2015)). The *biomaRt* Bioconductor package
is an excellent tool for this purpose, but works best with *UniProt* identifers,
instead of the NCBI Protein identifiers we currently have, so we must
translate the identifiers first (Durinck et al. [2009](#ref-Durinck2009), [2005](#ref-Durinck2005)).

We will use the *translateTargetId* function in *bioassayR* to obtain
a corresponding UniProt identifier for each NCBI Protein identifier (GI).
These identifier translations were obtained from UniProt and come pre-loaded
into the database. The *translateTargetId* takes only a single query and returns
one or more UniProt identifiers. Here we call it with *sapply* which automates
calling the function multiple times, one for each protein stored in *drugTargets*.
In many instances, a single query GI will translate into multiple UniProt
identifiers. In this case, we keep only the first one as the annotation
details we are looking for here will likely be the same for all of them.

```
# run translateTargetId on each target identifier
uniProtIds <- lapply(row.names(drugTargets), translateTargetId, database=pubChemDatabase, category="UniProt")

# if any targets had more than one UniProt ID, keep only the first one
uniProtIds <- sapply(uniProtIds, function(x) x[1])
```

Next, we connect to Ensembl via biomaRt to obtain a description for each
target that is a *Homo sapiens* gene. For more information,
consult the *biomaRt* documentation. After retrieving these data, we call the
*match* function to ensure they are in the same order as the query data.

```
library(biomaRt)
ensembl <- useEnsembl(biomart="ensembl",dataset="hsapiens_gene_ensembl")
proteinDetails <- getBM(attributes=c("description","uniprotswissprot","external_gene_name"),
                        filters=c("uniprotswissprot"), mart=ensembl, values=uniProtIds)
proteinDetails <- proteinDetails[match(uniProtIds, proteinDetails$uniprotswissprot),]
```

Now we can view this annotation data. NAs represent proteins not found
on the *Homo sapiens* Ensembl, which may be from other species.

```
proteinDetails
```

```
##                                                                                                                   description
## 4                                    cytochrome P450, family 3, subfamily A, polypeptide 4 [Source:HGNC Symbol;Acc:HGNC:2637]
## 2                                    cytochrome P450, family 1, subfamily A, polypeptide 2 [Source:HGNC Symbol;Acc:HGNC:2596]
## 1                              integrin, beta 3 (platelet glycoprotein IIIa, antigen CD61) [Source:HGNC Symbol;Acc:HGNC:6156]
## NA                                                                                                                       <NA>
## 3         integrin, alpha 2b (platelet glycoprotein IIb of IIb/IIIa complex, antigen CD41) [Source:HGNC Symbol;Acc:HGNC:6138]
## 7    prostaglandin-endoperoxide synthase 1 (prostaglandin G/H synthase and cyclooxygenase) [Source:HGNC Symbol;Acc:HGNC:9604]
## NA.1                                                                                                                     <NA>
## 8    prostaglandin-endoperoxide synthase 2 (prostaglandin G/H synthase and cyclooxygenase) [Source:HGNC Symbol;Acc:HGNC:9605]
## 6                                    cytochrome P450, family 2, subfamily C, polypeptide 9 [Source:HGNC Symbol;Acc:HGNC:2623]
## NA.2                                                                                                                     <NA>
## 5                                    cytochrome P450, family 2, subfamily D, polypeptide 6 [Source:HGNC Symbol;Acc:HGNC:2625]
##      uniprot_swissprot external_gene_name
## 4               P08684             CYP3A4
## 2               P05177             CYP1A2
## 1               P05106              ITGB3
## NA                <NA>               <NA>
## 3               P08514             ITGA2B
## 7               P23219              PTGS1
## NA.1              <NA>               <NA>
## 8               P35354              PTGS2
## 6               P11712             CYP2C9
## NA.2              <NA>               <NA>
## 5               P10635             CYP2D6
```

Lastly, let’s again look at our active target list, with the annotation alongside.
Note, these only match up in length and order because in the above code
we removed all but one UniProt ID for each target protein, and then reordered
the biomaRt results with the *match* function to get them in the correct order.

```
drugTargets <- drugTargets[!is.na(proteinDetails[, 1]), ]
proteinDetails <- proteinDetails[!is.na(proteinDetails[, 1]), ]
cbind(proteinDetails, drugTargets)
```

```
##                                                                                                                description
## 4                                 cytochrome P450, family 3, subfamily A, polypeptide 4 [Source:HGNC Symbol;Acc:HGNC:2637]
## 2                                 cytochrome P450, family 1, subfamily A, polypeptide 2 [Source:HGNC Symbol;Acc:HGNC:2596]
## 1                           integrin, beta 3 (platelet glycoprotein IIIa, antigen CD61) [Source:HGNC Symbol;Acc:HGNC:6156]
## 3      integrin, alpha 2b (platelet glycoprotein IIb of IIb/IIIa complex, antigen CD41) [Source:HGNC Symbol;Acc:HGNC:6138]
## 7 prostaglandin-endoperoxide synthase 1 (prostaglandin G/H synthase and cyclooxygenase) [Source:HGNC Symbol;Acc:HGNC:9604]
## 8 prostaglandin-endoperoxide synthase 2 (prostaglandin G/H synthase and cyclooxygenase) [Source:HGNC Symbol;Acc:HGNC:9605]
## 6                                 cytochrome P450, family 2, subfamily C, polypeptide 9 [Source:HGNC Symbol;Acc:HGNC:2623]
## 5                                 cytochrome P450, family 2, subfamily D, polypeptide 6 [Source:HGNC Symbol;Acc:HGNC:2625]
##   uniprot_swissprot external_gene_name fraction_active total_screens
## 4            P08684             CYP3A4             1.0             2
## 2            P05177             CYP1A2             1.0             1
## 1            P05106              ITGB3             1.0             1
## 3            P08514             ITGA2B             1.0             1
## 7            P23219              PTGS1             1.0             6
## 8            P35354              PTGS2             0.8            10
## 6            P11712             CYP2C9             1.0             1
## 5            P10635             CYP2D6             1.0             1
```

## 3.3 Identify Target Selective Compounds

In the previous example, acetylsalicylic acid was found to show binding activity against numerous proteins, including the COX-1 cyclooxygenase enzyme (NCBI Protein ID 166897622).
COX-1 activity is theorized to be the key mechanism in this molecules function as a nonsteroidal anti-inflammatory drug (NSAID).
In this example, we will look for other small molecules which selectively bind to COX-1, under the assumption that these may be worth further investigation as potential nonsteroidal anti-inflammatory drugs.
This example shows how *bioassayR* can be used
identify small molecules which selectively bind to a target of interest, and assist in the
discovery of small molecule drugs and molecular probes.

First, we will start by connecting to a database.
Once again, the variable *sampleDatabasePath* can be replaced with the filename of the full PubChem BioAssay database (downloadable from <http://chemmine.ucr.edu/bioassayr>), if you would like to use
that instead of the small example version included with this software package.

```
library(bioassayR)
extdata_dir <- system.file("extdata", package="bioassayR")
sampleDatabasePath <- file.path(extdata_dir, "sampleDatabase.sqlite")
pubChemDatabase <- connectBioassayDB(sampleDatabasePath)
```

The *activeAgainst* function can be used to show all small molecules in the database which demonstrate activity against COX-1 as follows.
Each row name represents a small molecule cid. The column labeled “total assays” shows the total number of times each small molecule has been screened against the target of interest. The column labeled “fraction active” shows the portion of these which were annotated as active as a number between 0 and 1.
This function allows users to consider different binding assays from distinct sources as replicates, to assist in distinguishing potentially spurious binding results from those with demonstrated reproducibility.

```
activeCompounds <- activeAgainst(pubChemDatabase, "166897622")
activeCompounds[1:10,] # look at the first 10 compounds
```

```
##        fraction_active total_assays
## 237                  1            1
## 2244                 1            1
## 2662                 1            4
## 3033                 1            1
## 3194                 1            1
## 3672                 1            3
## 3715                 1            6
## 133021               1            2
## 156391               1            1
## 247704               1            1
```

Looking only at compounds which show binding to the target of interest is not sufficient for identifying drug candidates, as a portion of these compounds may be target unselective compounds (TUCs) which bind
indiscriminately to a large number of distinct protein targets. The R function *selectiveAgainst* provides the user with a list of compounds that show activity against a target of interest (in at least one assay), while also showing limited activity against other targets.

The *maxCompounds* option limits the maximum number of results returned, and the *minimumTargets*
option limits returned compounds to those screened against a specified minimum of distinct targets. Results are formatted as a *data.frame* whereby each row name represents a distinct compound. The first column shows the number of distinct targets this compound shows activity against, and the second shows the total number of targets it was screened against.

```
selectiveCompounds <- selectiveAgainst(pubChemDatabase, "166897622",
    maxCompounds = 10, minimumTargets = 1)
selectiveCompounds
```

```
##          active_targets tested_targets
## 2662                  1              1
## 3033                  1              1
## 133021                1              1
## 11314954              1              1
## 13015959              1              1
## 44563999              1              1
## 44564000              1              1
## 44564001              1              1
## 44564002              1              1
## 44564003              1              1
```

In the example database these compounds are only showing one tested target because very few assays are loaded. Users are encouraged to try this example for themselves with the full PubChem BioAssay database downloadable from <http://chemmine.ucr.edu/bioassayr> for a more interesting and informative result.

Users can combine *bioassayR* with the *ChemmineR* library to obtain structural information on these target selective compounds, and then perform further analysis- such as structural clustering, visualization, and computing physicochemical properties.

The *ChemmineR* software library can be used to download structural data for any of these compounds, and to visualize these structures as follows (Cao et al. [2008](#ref-Cao2008c)).
This example requires an active internet connection, as the compound structures are obtained from a remote server.

```
library(ChemmineR)
structures <- getIds(as.numeric(row.names(selectiveCompounds)))
```

Here we visualize just the first four compounds found with *selectiveAgainst*. Consult the vignette supplied with *ChemmineR* for numerous examples of visualizing and analyzing these structures further.

```
plot(structures[1:4], print=FALSE) # Plots structures to R graphics device
```

![](data:image/png;base64...)

## 3.4 Cluster Compounds by Activity Profile

This example demonstrates an example of clustering small molecules by similar bioactivity profiles across several distinct bioassay experiments.
In many cases it is too cpu and memory intensive to cluster all compounds in the database, so we first pull just a subset of these data from the database into an *bioassaySet* object, and then convert that into a compounds vs targets activity matrix for subsequent clustering according to similarities in activity profile.
The function *getBioassaySetByCids* extracts the activity data for a given list of compounds. Alternatively, the entire data for a given list of assay ids can be extracted with the function *getAssays*.

First, connect to the included sample database:

```
library(bioassayR)
extdata_dir <- system.file("extdata", package="bioassayR")
sampleDatabasePath <- file.path(extdata_dir, "sampleDatabase.sqlite")
sampleDB <- connectBioassayDB(sampleDatabasePath)
```

Next, select data from just 3 compounds to extract into a *bioassaySet* object for subsequent analysis.

```
compoundsOfInterest <- c("2244", "2662", "3715")
selectedAssayData <- getBioassaySetByCids(sampleDB, compoundsOfInterest)
selectedAssayData
```

```
## class:        bioassaySet
## assays:       792
## compounds:    3
## targets:  551
## sources:  PubChem BioAssay
```

The function *perTargetMatrix* converts the activity data extracted earlier into a matrix of targets (rows) vs compounds (columns). Data from multiple assays hitting the same target are summarized into a single value in the manner specified by the user. If you choose the *summarizeReplicates* option
*activesFirst*, any active scores take prescendence over inactives. If you choose the option *mode* the most abundant of either actives or inactives
is stored in the resulting matrix. You can also pass a custom function to decide how replicates are summarized.
In the resulting matrix a “2” represents an active compound vs target combination, a “1” represents an inactive combination, and a “0” represents
an untested or inconclusive combination. Inactive results can optionally be excluded from consideration
by passing the option inactives = FALSE. Here a sparse matrix (which omits actually storing 0 values) is used to save memory.
In a sparse matrix a period “.” entry is equal to a zero “0” entry, but is implied without
taking extra space in memory.

Here we create an activity matrix, choosing to include inactive values, and summarize replicates according to the statistical mode:

```
myActivityMatrix <- perTargetMatrix(selectedAssayData, inactives=TRUE, summarizeReplicates = "mode")
myActivityMatrix[1:15,] # print the first 15 rows
```

```
## 15 x 3 sparse Matrix of class "dgCMatrix"
##           2244 2662 3715
## 166897622    2    2    2
## 125987835    2    .    .
## 754286265    2    .    .
## 3914304      2    .    .
## 3915797      2    .    .
## 317373262    2    .    .
## 117144       2    .    .
## 6686268      2    .    .
## 84028191     2    .    .
## 116241312    2    .    .
## 73915100     1    .    .
## 160794       1    .    .
## 21464101     1    .    .
## 154146191    1    .    .
## 68565074     1    .    .
```

The activity matrix can also be optionally created with raw numeric scores, or scaled and centered
Z-scores, instead of discrete active/inactive values. For more details on this option, see the man pages for the
*perTargetMatrix* and *scaleBioassaySet* functions.

Next, we will re-create the activity matrix where protein targets
that are very similar at the sequence level (such as orthologues from different species)
are treated as replicates, and merged.

The function *perTargetMatrix* contains an option *assayTargets*
which let’s you specify the targets for each assay instead of taking them from the *bioassaySet* object.
The function *assaySetTargets* returns a vector of the targets for each assay
in a *bioassaySet* object, where the name of each element corresponds to it’s
assay identifier (aid). This is the format that must be passed to *perTargetMatrix*
to specify which assays are treated as replicates to be merged, so first we can
obtain these data, and then replace them with a custom merge criteria formatted
in the same manner.

```
myAssayTargets <- assaySetTargets(selectedAssayData)
myAssayTargets[1:5] # print the first 5 targets
```

```
##      399401      399404      399411      443726      347221
## "166897622" "166897622" "166897622" "166897622" "166897622"
```

The pre-built PubChem BioAssay database includes sequence level
protein target clustering results generated with the kClust tool
(options s=2.93, E-value < 1\*10^-4, c=0.8) (Hauser, Mayer, and Söding [2013](#ref-Hauser:2013im)).
Each cluster has a unique number, and targets which cluster together are assigned
the same cluster number.
These clustering results are stored in the database as target
translations under category “kClust”. Now we will access these
traslations, and make a compound vs. target cluster matrix as follows.

```
# get kClust protein cluster number for a single target
translateTargetId(database = sampleDB, target = "166897622", category = "kClust")
```

```
## [1] "1945"
```

```
# get kClust protein cluster numbers for all targets in myAssayTargets
customMerge <- sapply(myAssayTargets, translateTargetId, database = sampleDB, category = "kClust")
customMerge[1:5]
```

```
## 399401 399404 399411 443726 347221
## "1945" "1945" "1945" "1945" "1945"
```

```
mergedActivityMatrix <- perTargetMatrix(selectedAssayData, inactives=TRUE, assayTargets=customMerge)
mergedActivityMatrix[1:15,] # print the first 15 rows
```

```
## 15 x 3 sparse Matrix of class "dgCMatrix"
##      2244 2662 3715
## 1945    2    2    2
## 1210    2    .    .
## 2311    2    .    .
## 2784    2    .    .
## 2625    2    .    .
## 2363    2    .    .
## 2260    1    .    .
## 5458    1    .    .
## 1218    1    .    .
## 1484    1    .    .
## 4946    1    .    .
## 5734    1    .    .
## 1250    1    .    .
## 3182    1    .    .
## 5745    1    .    .
```

Note that the merged matrix is smaller, because several similar protein targets
have been collapsed into single clusters.

```
# get number of rows and columns for unmerged matrix
dim(myActivityMatrix)
```

```
## [1] 418   3
```

```
# get number of rows and columns for merged matrix
dim(mergedActivityMatrix)
```

```
## [1] 365   3
```

Now, to make it possible to use binary clustering methods, we simplify the matrix
into a binary matrix where “1” represents active, and “0” represents either inactive
or untested combinations. We caution the user to carefully consider if this makes sense within the context of the specific experiments being analyzed.

```
binaryMatrix <- 1*(mergedActivityMatrix > 1)
binaryMatrix[1:15,] # print the first 15 rows
```

```
## 15 x 3 sparse Matrix of class "dgCMatrix"
##      2244 2662 3715
## 1945    1    1    1
## 1210    1    .    .
## 2311    1    .    .
## 2784    1    .    .
## 2625    1    .    .
## 2363    1    .    .
## 2260    0    .    .
## 5458    0    .    .
## 1218    0    .    .
## 1484    0    .    .
## 4946    0    .    .
## 5734    0    .    .
## 1250    0    .    .
## 3182    0    .    .
## 5745    0    .    .
```

As mentioned earlier, “0” and “.” entries in a sparse matrix are numerically equivalent.

Cluster using the built in euclidean clustering functions within R to cluster.
This provides a dendrogram which indicates the similarity amongst compounds according to their activity profiles.

```
transposedMatrix <- t(binaryMatrix)
distanceMatrix <- dist(transposedMatrix)
clusterResults <- hclust(distanceMatrix, method="average")
plot(clusterResults)
```

![](data:image/png;base64...)

A second way to compare activity profiles and cluster data is to pass
the activity matrix to the *ChemmineR* cheminformatics library as an *FPset* (binary fingerprint) object.
This represents the bioactivity data as a binary fingerprint (bioactivity fingerprint), which is a
binary string for each compound, where each bit represents activity (with a 1) or inactivity (with a 0) against
the full set of targets these compounds have shown activity against. This allows for pairwise comparison
of the bioactivity profile among compounds.
See the *ChemmineR* documentation at <http://bioconductor.org/packages/ChemmineR/> for additional examples and details.

```
library(ChemmineR)
fpset <- bioactivityFingerprint(selectedAssayData)
fpset
```

```
## An instance of a 551 bit "FPset" of type "bioactivity" with 3 molecules
```

Perform activity profile similarity searching with the FPset object, by comparing
the first compound to all compounds.

```
fpSim(fpset[1], fpset, method="Tanimoto")
```

```
##      2244      2662      3715
## 1.0000000 0.1818182 0.1818182
```

Compute an all-against-all bioactivity fingerprint similarity matrix for these compounds.

```
simMA <- sapply(cid(fpset), function(x) fpSim(fpset[x], fpset, sorted=FALSE, method="Tanimoto"))
simMA
```

```
##           2244      2662      3715
## 2244 1.0000000 0.1818182 0.1818182
## 2662 0.1818182 1.0000000 1.0000000
## 3715 0.1818182 1.0000000 1.0000000
```

Convert similarity matrix to a distance matrix and perform hierarcheal clustering.

```
clusterResults <- hclust(as.dist(1-simMA), method="single")
plot(clusterResults)
```

![](data:image/png;base64...)

One way to visualize the relative bioactivity similarity for a large number of compounds is with a
multidimensional scaling (aka MDS or principal coordinates analysis) plot
where each compound is represented as a point and bioactivity distance is proportional to
the distance between any two points. Note that the X and Y axis both represent
bioactivity distance. The following example also applies a small position jitter, so that
points representing compounds with identical bioactivity do not overlap.

```
library(ggplot2)

# 2 dimensional MDS transformation
plotdata <- cmdscale(as.dist(1-simMA), k=2)
dat <- data.frame(xvar=plotdata[,1], yvar=plotdata[,2])

# setup plot theme
mytheme = theme(plot.margin = unit(c(.2,.2,.2,.2), units = "lines"),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.ticks.length = unit(0, "lines"))

# scatterplot of x and y variables
minR <- min(range(dat$xvar), range(dat$yvar)) - 0.1
maxR <- 0.2 + max(range(dat$xvar), range(dat$yvar))
scatter <- ggplot(dat, aes(xvar, yvar)) +
    xlim(minR, maxR) + ylim(minR,maxR) +
    geom_point(shape=19, position = position_jitter(w = 0.05, h = 0.05)) +
    scale_colour_brewer(palette="Set1") +
    mytheme + theme(legend.position="none") +
    xlab("Bioactivity Fingerprint Distance") +
    ylab("Bioactivity Fingerprint Distance")

plot(scatter)
```

![](data:image/png;base64...)

Finally, disconnect from the database.

```
disconnectBioassayDB(sampleDB)
```

## 3.5 Analyze and Load Raw Screening Data

This example demonstrates the basics of analyzing and loading data
from a high throughput screening experiment with scores for 21,888
distinct compounds.

This example is based on the cellHTS2 library
(Boutros, L, and Huber [2006](#ref-Boutros2006)). Example data
is used which is included with cellHTS2. This is actually data from
screening dsRNA against live cells, however we will treat it as small molecule
binding data against a protein target as the data format is the same.

First read in the screening data provided with cellHTS2.

```
library(cellHTS2)
library(bioassayR)

dataPath <- system.file("KcViab", package="cellHTS2")
x <- readPlateList("Platelist.txt",
                   name="KcViab",
                   path=dataPath)

x <- configure(x,
               descripFile="Description.txt",
               confFile="Plateconf.txt",
               logFile="Screenlog.txt",
               path=dataPath)

xn <- normalizePlates(x,
                      scale="multiplicative",
                      log=FALSE,
                      method="median",
                      varianceAdjust="none")
```

Next, score and summarize the replicates.

```
xsc <- scoreReplicates(xn, sign="-", method="zscore")
xsc <- summarizeReplicates(xsc, summary="mean")
```

Parse the annotation data.

```
xsc <- annotate(xsc, geneIDFile="GeneIDs_Dm_HFA_1.1.txt", path=dataPath)
```

Apply a sigmoidal transformation to generate binary calls.

```
y <- scores2calls(xsc, z0=1.5, lambda=2)
binaryCalls <- round(Data(y))
```

Convert the binary calls into an activity table that *bioassayR* can parse.

```
scoreDataFrame <- cbind(geneAnno(y), binaryCalls)
rawScores <- as.vector(Data(xsc))
rawScores <- rawScores[wellAnno(y) == "sample"]
scoreDataFrame <- scoreDataFrame[wellAnno(y) == "sample",]
activityTable <- cbind(cid=scoreDataFrame[,1],
     activity=scoreDataFrame[,2], score=rawScores)
activityTable <- as.data.frame(activityTable)
activityTable[1:10,]
```

Create a new (temporary in this case) *bioassayR* database to load these data into.

```
myDatabaseFilename <- tempfile()
mydb <- newBioassayDB(myDatabaseFilename, indexed=F)
addDataSource(mydb, description="other", version="unknown")
```

Create an assay object for the new assay.

```
myAssay <- new("bioassay",aid="1", source_id="other",
     assay_type="confirmatory", organism="unknown", scoring="activity rank",
     targets="2224444", target_types="protein", scores=activityTable)
```

Load this assay object into the *bioassayR* database.

```
loadBioassay(mydb, myAssay)
mydb
```

Now that these data are loaded, you can use them to perform any of the other analysis examples in this document.

Lastly, for the purposes of this example, disconnect from the example database.

```
disconnectBioassayDB(mydb)
```

## 3.6 Custom SQL Queries

While many pre-built queries are provided (see other examples and man pages)
advanced users can also build their own SQL queries.
As bioassayR uses a SQLite database, you can consult <http://www.sqlite.org> for specifics on building SQL queries.
We also reccomend the book “Using SQLite” (Kreibich [2010](#ref-Kreibich2010)).

To get started first connect to a database. If you downloaded the full PubChem BioAssay
database from the authors website, the variable *sampleDatabasePath* can be replaced with the filename of the database you downloaded, if you would like to use
that instead of the small example version included with this software package.

```
library(bioassayR)
extdata_dir <- system.file("extdata", package="bioassayR")
sampleDatabasePath <- file.path(extdata_dir, "sampleDatabase.sqlite")
pubChemDatabase <- connectBioassayDB(sampleDatabasePath)
```

First you will want to see the structure
of the database as follows:

```
queryBioassayDB(pubChemDatabase, "SELECT * FROM sqlite_master WHERE type='table'")
```

```
##    type               name           tbl_name rootpage
## 1 table           activity           activity        2
## 2 table             assays             assays        3
## 3 table            sources            sources        4
## 4 table            targets            targets        5
## 5 table targetTranslations targetTranslations        6
##                                                                                                  sql
## 1                  CREATE TABLE activity (aid INTEGER, cid INTEGER, activity INTEGER, score INTEGER)
## 2 CREATE TABLE assays (source_id INTEGER, aid INTEGER, assay_type TEXT, organism TEXT, scoring TEXT)
## 3           CREATE TABLE sources (source_id INTEGER PRIMARY KEY ASC, description TEXT, version TEXT)
## 4                                  CREATE TABLE targets (aid INTEGER, target TEXT, target_type TEXT)
## 5                      CREATE TABLE targetTranslations (target TEXT, category TEXT, identifier TEXT)
```

For example, you can find the first 10 assays a given compound has participated in as follows:

```
queryBioassayDB(pubChemDatabase, "SELECT DISTINCT(aid) FROM activity WHERE cid = '2244' LIMIT 10")
```

```
##       aid
## 1  399401
## 2  399404
## 3  399411
## 4  443726
## 5     410
## 6     411
## 7     422
## 8     429
## 9     436
## 10    445
```

This example prints the activity scores from a specified assay:

```
queryBioassayDB(pubChemDatabase, "SELECT * FROM activity WHERE aid = '393818'")
```

```
##      aid      cid activity score
## 1 393818     3672        1    NA
## 2 393818     2662        1    NA
## 3 393818 25258347       NA    NA
## 4 393818 25258348        1    NA
## 5 393818 25258349        1    NA
## 6 393818 25258350        1    NA
```

A *NATURAL JOIN* automatically merges tables which share common rows, making
it easier to parse data spread across many tables. Here we merge the activity
table (raw scores), with the assay table (assay annotation details) and the
protein targets table:

```
queryBioassayDB(pubChemDatabase, "SELECT * FROM activity NATURAL JOIN assays NATURAL JOIN targets WHERE cid = '2244' LIMIT 10")
```

```
##       aid  cid activity score source_id   assay_type         organism scoring    target target_type
## 1  399401 2244       NA    NA         1 confirmatory       Bos_taurus    IC50 166897622     protein
## 2  399404 2244       NA    NA         1 confirmatory       Bos_taurus    IC50 166897622     protein
## 3  399411 2244       NA    NA         1 confirmatory       Bos_taurus    IC50 166897622     protein
## 4  443726 2244        1    NA         1 confirmatory       Bos_taurus    IC50 166897622     protein
## 5     410 2244        0     0         1 confirmatory     Homo_sapiens    <NA>  73915100     protein
## 6     411 2244        0     0         1 confirmatory Photinus_pyralis Potency    160794     protein
## 7     422 2244        0    -6         1    screening     Homo_sapiens    <NA>  21464101     protein
## 8     429 2244        0    -2         1    screening     Homo_sapiens    <NA> 154146191     protein
## 9     429 2244        0    -2         1    screening     Homo_sapiens    <NA>   4261762     protein
## 10    436 2244        0     5         1    screening     Homo_sapiens    <NA>  68565074     protein
```

Lastly, disconnecting from the database after analysis reduces the chances of data corruption. If you are using a pre-built database in read only mode (as demonstrated in the Prebuilt Database Example section) you can optionally skip this step, as only writable databases are prone to corruption from failure to disconnect.

```
disconnectBioassayDB(pubChemDatabase)
```

# 4 Building PubChem BioAssay Database

As mentioned in the above examples, a pre-built database containing large
quantities of public domain bioactivity data sourced from the PubChem BioAssay database, can be downloaded from <http://chemmine.ucr.edu/bioassayr>.
Advanced users can re-build this database from the raw data themselves, by using
the code provided on GitHub at <https://github.com/TylerBackman/pubchem-bioassay-database>.
This code is written for Linux systems, but a Dockerfile is included
to allow it to run on other platforms.

# 5 Version Information

This document was compiled in an R session with the following
configuration.

```
 sessionInfo()
```

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86\_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86\_64-linux-gnu/lapack/liblapack.so.3.12.0 LAPACK version 3.12.0

locale:
[1] LC\_CTYPE=en\_US.UTF-8 LC\_NUMERIC=C LC\_TIME=en\_GB
[4] LC\_COLLATE=C LC\_MONETARY=en\_US.UTF-8 LC\_MESSAGES=en\_US.UTF-8
[7] LC\_PAPER=en\_US.UTF-8 LC\_NAME=C LC\_ADDRESS=C
[10] LC\_TELEPHONE=C LC\_MEASUREMENT=en\_US.UTF-8 LC\_IDENTIFICATION=C

time zone: America/New\_York
tzcode source: system (glibc)

attached base packages:
[1] stats graphics grDevices utils datasets methods base

other attached packages:
[1] ggplot2\_4.0.0 ChemmineR\_3.62.0 biomaRt\_2.66.0 bioassayR\_1.48.0
[5] BiocGenerics\_0.56.0 generics\_0.1.4 rjson\_0.2.23 Matrix\_1.7-4
[9] RSQLite\_2.4.3 DBI\_1.2.3 BiocStyle\_2.38.0 rmarkdown\_2.30

loaded via a namespace (and not attached):
[1] KEGGREST\_1.50.0 gtable\_0.3.6 xfun\_0.53 bslib\_0.9.0
[5] httr2\_1.2.1 htmlwidgets\_1.6.4 Biobase\_2.70.0 lattice\_0.22-7
[9] vctrs\_0.6.5 tools\_4.5.1 bitops\_1.0-9 stats4\_4.5.1
[13] curl\_7.0.0 AnnotationDbi\_1.72.0 tibble\_3.3.0 blob\_1.2.4
[17] pkgconfig\_2.0.3 dbplyr\_2.5.1 RColorBrewer\_1.1-3 S4Vectors\_0.48.0
[21] S7\_0.2.0 lifecycle\_1.0.4 compiler\_4.5.1 farver\_2.1.2
[25] stringr\_1.5.2 Biostrings\_2.78.0 progress\_1.2.3 tinytex\_0.57
[29] codetools\_0.2-20 Seqinfo\_1.0.0 htmltools\_0.5.8.1 sass\_0.4.10
[33] RCurl\_1.98-1.17 yaml\_2.3.10 pillar\_1.11.1 crayon\_1.5.3
[37] jquerylib\_0.1.4 DT\_0.34.0 cachem\_1.1.0 magick\_2.9.0
[41] tidyselect\_1.2.1 digest\_0.6.37 stringi\_1.8.7 dplyr\_1.1.4
[45] bookdown\_0.45 labeling\_0.4.3 rsvg\_2.7.0 fastmap\_1.2.0
[49] grid\_4.5.1 cli\_3.6.5 magrittr\_2.0.4 base64enc\_0.1-3
[53] dichromat\_2.0-0.1 XML\_3.99-0.19 withr\_3.0.2 prettyunits\_1.2.0
[57] filelock\_1.0.3 scales\_1.4.0 rappdirs\_0.3.3 bit64\_4.6.0-1
[61] XVector\_0.50.0 httr\_1.4.7 bit\_4.6.0 gridExtra\_2.3
[65] png\_0.1-8 hms\_1.1.4 memoise\_2.0.1 evaluate\_1.0.5
[69] knitr\_1.50 IRanges\_2.44.0 BiocFileCache\_3.0.0 rlang\_1.1.6
[73] Rcpp\_1.1.0 glue\_1.8.0 BiocManager\_1.30.26 jsonlite\_2.0.0
[77] R6\_2.6.1

# 6 Funding

This software was developed with funding from the National Science
Foundation:
[ABI-0957099](http://www.nsf.gov/awardsearch/showAward.do?AwardNumber=0957099),
2010-0520325 and IGERT-0504249.

# References

Backman, T W, Y Cao, and T Girke. 2011. “ChemMine tools: an online service for analyzing and clustering small molecules.” *Nucleic Acids Res* 39 (Web Server issue): 486–91. <https://doi.org/10.1093/nar/gkr320>.

Bateman, A., M. J. Martin, C. O’Donovan, M. Magrane, R. Apweiler, E. Alpi, R. Antunes, et al. 2015. “UniProt: a hub for protein information.” *Nucleic Acids Res.* 43 (Database issue): D204–212.

Boutros, Michael, Ligia P. Bras L, and Wolfgang Huber. 2006. “Analysis of Cell-Based Rnai Screens.” *Genome Biology* 7 (7): R66.

Cao, Y, A Charisi, L C Cheng, T Jiang, and T Girke. 2008. “ChemmineR: a compound mining framework for R.” *Bioinformatics* 24 (15): 1733–4. <https://doi.org/10.1093/bioinformatics/btn307>.

Durinck, Steffen, Yves Moreau, Arek Kasprzyk, Sean Davis, Bart De Moor, Alvis Brazma, and Wolfgang Huber. 2005. “BioMart and Bioconductor: A Powerful Link Between Biological Databases and Microarray Data Analysis.” *Bioinformatics* 21: 3439–40.

Durinck, Steffen, Paul T. Spellman, Ewan Birney, and Wolfgang Huber. 2009. “Mapping Identifiers for the Integration of Genomic Datasets with the R/Bioconductor Package biomaRt.” *Nature Protocols* 4: 1184–91.

Hauser, Maria, Christian E Mayer, and Johannes Söding. 2013. “kClust: fast and sensitive clustering of large protein sequence databases.” *BMC Bioinformatics* 14 (1): 248.

Kreibich, Jay A. 2010. *Using Sqlite*. O’Reilly Media.

Tatusova, T., S. Ciufo, B. Fedorov, K. O’Neill, and I. Tolstoy. 2014. “RefSeq microbial genomes database: new representation and annotation strategy.” *Nucleic Acids Res.* 42 (Database issue): D553–559.

Wang, Yanli, Jewen Xiao, Tugba O Suzek, Jian Zhang, Jiyao Wang, Zhigang Zhou, Lianyi Han, et al. 2012. “PubChem’s BioAssay Database.” *Nucleic Acids Research* 40 (Database issue): D400–12.

Wishart, David S, Craig Knox, An Chi Guo, Dean Cheng, Savita Shrivastava, Dan Tzur, Bijaya Gautam, and Murtaza Hassanali. 2008. “DrugBank: a knowledgebase for drugs, drug actions and drug targets.” *Nucleic Acids Research* 36 (Database issue): D901–6.