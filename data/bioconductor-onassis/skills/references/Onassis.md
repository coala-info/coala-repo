# Onassis: Ontology Annotation and Semantic Similarity software

Eugenia Galeota

#### *2018-11-28*

# Contents

* [1 Introduction to OnASSis](#introduction-to-onassis)
* [2 Installation](#installation)
* [3 Retrieving metadata from public repositories](#retrieving-metadata-from-public-repositories)
  + [3.1 Handling GEO (Gene Expression Omnibus) metadata](#handling-geo-gene-expression-omnibus-metadata)
  + [3.2 Handling SRA (Sequence Read Archive) metadata](#handling-sra-sequence-read-archive-metadata)
* [4 Annotating text with ontology concepts](#annotating-text-with-ontology-concepts)
  + [4.1 Data preparation](#data-preparation)
  + [4.2 Creation of a Conceptmapper Dictionary](#creation-of-a-conceptmapper-dictionary)
  + [4.3 Setting the options for the annotator](#setting-the-options-for-the-annotator)
  + [4.4 Running the entity finder](#running-the-entity-finder)
* [5 Semantic similarity](#semantic-similarity)
  + [5.1 Semantic similarity between ontology terms](#semantic-similarity-between-ontology-terms)
  + [5.2 Semantic similarity between annotated samples](#semantic-similarity-between-annotated-samples)
* [6 Onassis class](#onassis-class)
  + [6.1 Metadata annotation](#metadata-annotation)
  + [6.2 Semantic similarity of semantic sets](#semantic-similarity-of-semantic-sets)
  + [6.3 Integrating the annotations from different ontologies](#integrating-the-annotations-from-different-ontologies)
  + [6.4 Semantically-driven analysis of omics data](#semantically-driven-analysis-of-omics-data)
* [7 Performances of the tool](#performances-of-the-tool)
* [8 Session Info](#session-info)
* [References](#references)

# 1 Introduction to OnASSis

Public repositories of biological omics data contain thousands of experiments. While these resources are extrenely useful, those data are difficult to mine. The annotation of the associated metadata with controlled vocabularies or ontology terms can facilitate the retrieval of the datasets of interest (Galeota and Pelizzola 2016).
**OnASSiS** (Ontology Annotations and Semantic Similarity software) is a package aimed at matching metadata associated with biological experiments with concepts from ontologies, allowing the construction of semantically structured omics datasets, possibly representing various data types from independent studies. The recognition of entities specific for a domain allows the retrieval of samples related to a given cell type or experimental condition, but also allows unravelling previously unanticipated relationships between experiments. Onassis applies Natural Language Processing tools to annotate sample’s and experiments’ descriptions, recognizing concepts from a multitude of biomedical ontologies and quantifying the similarities between pairs or groups of query studies. Moreover, it assists the semantically-driven analysis of the corresponding omics data.
In particular the software includes modules to enable:

* the **retrieval** of samples’ metadata from repositories of large scale biologial data
* the **annotation** of these data with concepts belonging to Open Biomedical Ontologies (OBO)
* the organization of the annotated samples in structured groups based on **semantic similarity** measures
* the **comparison** of omics data (e.g. gene expression or ChIP enrichment) based on the entities associated to a set of samples and their relationship

Onassis relies on Conceptmapper, an Apache UIMA (Unstructured Information Management Architecture) dictionary lookup tool to retrieve dictionary terms in a given text. <https://uima.apache.org/downloads/sandbox/ConceptMapperAnnotatorUserGuide/ConceptMapperAnnotatorUserGuide.html>
In particular, the ccp-nlp Conceptmapper wrapper, specific for the biomedical domain, implements a pipeline through which it is possible to retrieve concepts from OBO ontologies in any given text with different adjustable options (Verspoor et al. 2009).

Onassis features can be easily accessed through a main class named Onassis, having as slots ‘dictionary’, ‘entities’, ‘similarity’ and ‘scores’. In the following sections we first show details on the usage of classes and methods constituting the building blocks of a semantically-driven integrative analysis workflow. Next, in Section 6 we show how the Onassis class wraps all these functions for a simplified access and usage.
Regarding the input data, Onassis can handle any type of text, but is particularly well suited for the analysis of the metadata from Gene Expression Omnibus (GEO). Indeed, it allows associating concepts from any OBO ontology to GEO metadata retrieved using *[GEOmetadb](https://bioconductor.org/packages/3.8/GEOmetadb)*. In general, any table or database (such as Sequence Read Archive (SRA) (Zhu et al. 2013) or Cistrome (Mei et al. 2017)) containing textual descriptions that can be easily imported in R as a data frame can be used as input for Onassis.
Regarding the dictionary module, gene/protein symbols or epigenetic modifications can also be recognized in the text, in addition to ontology concepts. This can be particularly important, especially when dealing with experiments directed to specific factors or marks (such as ChIP-seq experiments).
The similarity module uses different semantic similarity measures to determine the semantic similarity of concepts in a given ontology. This
module has been developed on the basis of the Java slib <http://www.semantic-measures-library.org/sml>.
The score module applies statistical tests to determine if omics data from samples annotated with different concepts, belonging to one or more ontologies, are significantly different.

# 2 Installation

To run Onassis Java (>= 1.8) is needed. To install the package please run the following code

```
source("https://bioconductor.org/biocLite.R")
biocLite("Onassis")
```

Onassis can be loaded with the following code

```
library(Onassis)
```

Some of the optional functions, which will be described in the following parts of the vignette, require additional libraries. These include:

* org.Hs.eg.db (Bioconductor)
* GenomicRanges (Bioconductor)
* gplots (CRAN)
* GEOmetadb (Bioconductor)
* SRAdb (Bioconductor)

# 3 Retrieving metadata from public repositories

One of the most straightforward ways to retrieve metadata of samples provided in GEO is through the *[GEOmetadb](https://bioconductor.org/packages/3.8/GEOmetadb)* package. In order to use GEOmetadb through Onassis, the corresponding SQLite database should be available. This can be downloaded by Onassis (see below), and this step has to be performed only once. As described below, Onassis provides functions to facilitate the retrieval of specific GEO metadata without the need of explicitly making SQL queries to the database. Additionally, an example on how to access *[SRAdb](https://bioconductor.org/packages/3.8/SRAdb)* metadata, is also provided.

## 3.1 Handling GEO (Gene Expression Omnibus) metadata

First, it is necessary to obtain a connection to the GEOmetadb SQLite database. If this were already downloaded, `connectToGEODB` returns a connection to the database given the full path to the SQLite database file. Alternatively, by setting `download` to TRUE the database is downloaded. The `getGEOmetadata` function can be used to retrieve the metadata related to specific GEO samples, taking as minimal parameters the connection to the database and one of the experiment types available. Optionally it is possible to specify the organism and the platform. The following code illustrates how to download the metadata corresponding to expression arrays, or DNA methylation sequencing experiments. The meth\_metadata object, containing the results for the latter, was stored within Onassis. Therefore, the queries illustrated here can be skipped.

```
require('GEOmetadb')

## Running this function might take some time if the database (6.8GB) has to be downloaded.
geo_con <- connectToGEODB(download=TRUE)

#Showing the experiment types available in GEO
experiments <- experiment_types(geo_con)

#Showing the organism types available in GEO
species <- organism_types(geo_con)

#Retrieving Human gene expression metadata, knowing the GEO platform identifier, e.g. the Affymetrix Human Genome U133 Plus 2.0 Array
expression <- getGEOMetadata(geo_con, experiment_type='Expression profiling by array', gpl='GPL570')

#Retrieving the metadata associated to experiment type "Methylation profiling by high througput sequencing"
meth_metadata <- getGEOMetadata(geo_con, experiment_type='Methylation profiling by high throughput sequencing', organism = 'Homo sapiens')
```

Some of the experiment types available are the following:

| experiments |
| --- |
| Expression profiling by MPSS |
| Expression profiling by RT-PCR |
| Expression profiling by SAGE |
| Expression profiling by SNP array |
| Expression profiling by array |
| Expression profiling by genome tiling array |
| Expression profiling by high throughput sequencing |
| Genome binding/occupancy profiling by SNP array |
| Genome binding/occupancy profiling by array |
| Genome binding/occupancy profiling by genome tiling array |

Some of the organisms available are the following:

| species |
| --- |
| Homo sapiens |
| Drosophila melanogaster |
| Mus musculus |
| Zea mays |
| Arabidopsis thaliana |
| Caenorhabditis elegans |
| Helicobacter pylori |
| Escherichia coli |
| Rattus norvegicus |
| Saccharomyces cerevisiae |

As specified above, meth\_metadata was previously saved and can be loaded from the Onassis package external data (hover on the table to view additional rows and columns):

```
meth_metadata <- readRDS(system.file('extdata', 'vignette_data', 'GEOmethylation.rds', package='Onassis'))
```

Table 1: GEOmetadb metadata for Methylation profiling by high throughput sequencing (only the first 10 entries are shown).

|  | series\_id | gsm | title | gpl | source\_name\_ch1 | organism\_ch1 | characteristics\_ch1 | description | experiment\_title | experiment\_summary |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1251 | GSE42590 | GSM1045538 | 2316\_DLPFC\_Control | GPL10999 | Brain (dorsolateral prefrontal cortex) | Homo sapiens | tissue: Heterogeneous brain tissue | NA | Genome-wide DNA methylation profiling of human dorsolateral prefrontal cortex | Reduced representation bisulfite sequencing (RRBS) |
| 511 | GSE27432 | GSM678217 | hEB16d\_H9\_p65\_RRBS | GPL9115 | embryoid body from hES H9 p65 | Homo sapiens | cell type: hEB16d\_H9\_p65 | reduced representation bisulfite sequencing | Genomic distribution and inter-sample variation of non-CG methylation across human cell types | DNA methylation plays an important role in develop |
| 2731 | GSE58889 | GSM1421876 | Normal\_CD19\_11 | GPL11154 | Normal CD19+ cells | Homo sapiens | cell type: Normal CD19+ cells; disease status: healthy | NA | Methylation disorder in CLL | We performed RRBS and WGBS on primary human chroni |
| 1984 | GSE50761 | GSM1228607 | Time Course Off-target Day 7 1 HBB133 | GPL15520 | K562 cells | Homo sapiens | cell line: K562 cells; target loci: Time Course Off-target Day 7 1 | 2013.03.16.\_MM364\_analysis.csv | Targeted DNA demethylation using TALE-TET1 fusion proteins | Recent large-scale studies have defined genomewide |
| 851 | GSE36173 | GSM882245 | H1 human ES cells | GPL10999 | H1 human ES cells | Homo sapiens | cell line: H1 | 5-hmC whole genome bisulfite sequencing | Base Resolution Analysis of 5-Hydroxymethylcytosine in the Mammalian Genome | The study of 5-hydroxylmethylcytosines (5hmC), the |
| 1966 | GSE50761 | GSM1228589 | Time Course HB-6 Day 4 1 HBB115 | GPL15520 | K562 cells | Homo sapiens | cell line: K562 cells; target loci: Time Course HB-6 Day 4 1 | 2013.03.16.\_MM364\_analysis.csv | Targeted DNA demethylation using TALE-TET1 fusion proteins | Recent large-scale studies have defined genomewide |
| 1827 | GSE50761 | GSM1228450 | Off target -650 to -850 3 RHOX117 | GPL15520 | 293 cells | Homo sapiens | cell line: 293 cells; target loci: Off target -650 to -850 3 | 2013-07-23-MM195-288-394\_analysis.csv | Targeted DNA demethylation using TALE-TET1 fusion proteins | Recent large-scale studies have defined genomewide |
| 378 | GSE26592 | GSM655200 | Endometrial Recurrent 5 | GPL9052 | Human endometrial specimen | Homo sapiens | tissue: Human endometrial specimen; cell type: primary tissues; disease status: Recurrent; chromatin selection: MBD protein | MBDCap using MethylMiner Methylated DNA Enrichment Kit (Invitrogen, ME 10025); library strategy: Endometrial samples: MBDCao-seq. Breast cells: MBDCap-seq.; library selection: Endometrial samples: MBDCap. Breast cells: MBDCap-seq. | Neighboring genomic regions influence differential methylation patterns of CpG islands in endometrial and breast cancers | We report the global methylation patterns by MBDCa |
| 1754 | GSE50761 | GSM1228377 | Initial Screen RH-3 -250-+1 2 RHOX44 | GPL15520 | HeLa cells | Homo sapiens | cell line: HeLa cells; target loci: Initial Screen RH-3 -250-+1 2 | 2013-07-12-MM564\_analysis.csv | Targeted DNA demethylation using TALE-TET1 fusion proteins | Recent large-scale studies have defined genomewide |
| 2371 | GSE54961 | GSM1327281 | Healthy Control | GPL9052 | Healthy Control | Homo sapiens | etiology: Healthy Control; tissue: Peripheral venous blood; molecule subtype: serum cell-free DNA | Sample 1 | Epigenome analysis of serum cell-free circulating DNA in progression of HBV-related Hepatocellular carcinoma | Purpose: Aberrantly methylated DNA are hallmarks |

## 3.2 Handling SRA (Sequence Read Archive) metadata

In this section we provide an example showing how it is possible to retrieve metadata from other sources such as SRA. This database is not directly supported by Onassis, since it is not available for Windows platforms. Hence, the code reported below is slightly more complicated, and exemplifies how to query the SRA database provided by the SRAdb package and store metadata of human ChIP-seq experiments within a data frame. Due to the size of the SRA database (2.4 GB for the compressed file, 36 GB for the .sqlite file), a sample of the results of the query is available within Onassis as external data (see below), and the example code illustrated here can be skipped.

```
# Optional download of SRAdb and connection to the corresponding sqlite file
require(SRAdb)
sqliteFileName <- '/pathto/SRAdb.sqlite'
sra_con <- dbConnect(SQLite(), sqliteFileName)

# Query for the ChIP-Seq experiments contained in GEO for human samples
library_strategy <- 'ChIP-Seq' #ChIP-Seq data
library_source='GENOMIC'
taxon_id=9606 #Human samples
center_name='GEO' #Data from GEO

# Query to the sample table
samples_query <- paste0("select sample_accession, description, sample_attribute, sample_url_link from sample where taxon_id='", taxon_id, "' and sample_accession IS NOT NULL", " and center_name='", center_name, "'"  )

samples_df <- dbGetQuery(sra_con, samples_query)
samples <- unique(as.character(as.vector(samples_df[, 1])))

experiment_query <- paste0("select experiment_accession, center_name, title, sample_accession, sample_name, experiment_alias, library_strategy, library_layout, experiment_url_link, experiment_attribute from experiment where library_strategy='", library_strategy, "'" , " and library_source ='", library_source,"' ", " and center_name='", center_name, "'" )
experiment_df <- dbGetQuery(sra_con, experiment_query)

#Merging the columns from the sample and the experiment table
experiment_df <- merge(experiment_df, samples_df, by = "sample_accession")

# Replacing the '_' character with white spaces
experiment_df$sample_name <- sapply(experiment_df$sample_name, function(value) {gsub("_", " ", value)})
experiment_df$experiment_alias <- sapply(experiment_df$experiment_alias, function(value) {gsub("_", " ", value)})

sra_chip_seq <- experiment_df
```

The query returns a table with thousands of samples. Alternatively, as described above, a sample of this table useful for the subsequent examples can be retrieved in Onassis:

```
sra_chip_seq <- readRDS(system.file('extdata', 'vignette_data', 'GEO_human_chip.rds',  package='Onassis'))
```

Table 2: Metadata of ChIP-seq human samples obtained from SRAdb (first 10 entries)

|  | sample\_accession | experiment\_accession | center\_name | title | library\_strategy | library\_layout | experiment\_url\_link | experiment\_attribute | description | sample\_attribute | sample\_url\_link |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 5904 | SRS421364 | SRX278504 | GEO | GSM1142700: p53 ChIP LCL nutlin-3 treated; Homo sapiens; ChIP-Seq | ChIP-Seq | SINGLE - | GEO Sample: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1142700> | GEO Accession: GSM1142700 | NA | source\_name: lymphoblastoid cells || cell type: nutlin-3 treated lymphoblastoid cells || coriell id: GM12878 || chip antibody: mouse monoclonal anti-human p53 (BD Pharmingen, cat# 554294) || BioSampleModel: Generic | GEO Sample GSM1142700: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1142700> |
| 4981 | SRS371783 | SRX199902 | GEO | GSM1022674: UW\_ChipSeq\_A549\_InputRep1 | ChIP-Seq | SINGLE - | GEO Web Link: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1022674> | GEO Accession: GSM1022674 | NA | source\_name: A549 || biomaterial\_provider: ATCC || lab: UW || lab description: Stamatoyannopoulous - University of Washington || datatype: ChipSeq || datatype description: Chromatin IP Sequencing || cell: A549 || cell organism: human || cell description: epithelial cell line derived from a lung carcinoma tissue. (PMID: 175022), “This line was initiated in 1972 by D.J. Giard, et al. through explant culture of lung carcinomatous tissue from a 58-year-old caucasian male.” - ATCC, newly promoted to tier 2: not in 2011 analysis || cell karyotype: cancer || cell lineage: endoderm || cell sex: M || antibody: Input || antibody description: Control signal which may be subtracted from experimental raw signal before peaks are called. || treatment: None || treatment description: No special treatment or protocol applies || control: std || control description: Standard input signal for most experiments. || controlid: wgEncodeEH001904 || labexpid: DS18301 || labversion: WindowDensity-bin20-win+/-75 || replicate: 1 || BioSampleModel: Generic | GEO Sample GSM1022674: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1022674> |
| 4619 | SRS365824 | SRX190055 | GEO | GSM945272: UW\_ChipSeq\_HRPEpiC\_Input | ChIP-Seq | SINGLE - | GEO Web Link: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM945272> | GEO Accession: GSM945272 | NA | source\_name: HRPEpiC || biomaterial\_provider: ScienCell || lab: UW || lab description: Stamatoyannopoulous - University of Washington || datatype: ChipSeq || datatype description: Chromatin IP Sequencing || cell: HRPEpiC || cell organism: human || cell description: retinal pigment epithelial cells || cell karyotype: normal || cell lineage: ectoderm || cell sex: U || antibody: Input || antibody description: Control signal which may be subtracted from experimental raw signal before peaks are called. || treatment: None || treatment description: No special treatment or protocol applies || control: std || control description: Standard input signal for most experiments. || controlid: wgEncodeEH000962 || labexpid: DS16014 || labversion: Bowtie 0.12.7 || replicate: 1 || BioSampleModel: Generic | GEO Sample GSM945272: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM945272> |
| 911 | SRS117344 | SRX028649 | GEO | GSM608166: H3K27me3\_K562\_ChIP-seq\_rep1 | ChIP-Seq | SINGLE - | GEO Web Link: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM608166> | GEO Accession: GSM608166 | NA | source\_name: chronic myeloid leukemia cell line || cell line: K562 || harvest date: 2008-06-12 || chip antibody: CST monoclonal rabbit rabbit anti-H3K27me3 || BioSampleModel: Generic | GEO Sample GSM608166: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM608166> |
| 4244 | SRS362733 | SRX186665 | GEO | GSM1003469: Broad\_ChipSeq\_Dnd41\_H3K79me2 | ChIP-Seq | SINGLE - | GEO Web Link: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1003469> | GEO Accession: GSM1003469 | NA | source\_name: Dnd41 || biomaterial\_provider: DSMZ || datatype: ChipSeq || datatype description: Chromatin IP Sequencing || antibody antibodydescription: Rabbit polyclonal antibody raised against a peptide containing K79 di-methylation. Antibody Target: H3K79me2 || antibody targetdescription: H3K79me2 is a mark of the transcriptional transition region - the region between the initiation marks (K4me3, etc) and the elongation marks (K36me3). || antibody vendorname: Active Motif || antibody vendorid: 39143 || controlid: wgEncodeEH002434 || replicate: 1,2 || softwareversion: ScriptureVPaperR3 || cell sex: M || antibody: H3K79me2 || antibody antibodydescription: Rabbit polyclonal antibody raised against a peptide containing K79 di-methylation. Antibody Target: H3K79me2 || antibody targetdescription: H3K79me2 is a mark of the transcriptional transition region - the region between the initiation marks (K4me3, etc) and the elongation marks (K36me3). || antibody vendorname: Active Motif || antibody vendorid: 39143 || treatment: None || treatment description: No special treatment or protocol applies || control: std || control description: Standard input signal for most experiments. || controlid: Dnd41/Input/std || softwareversion: ScriptureVPaperR3 || BioSampleModel: Generic | GEO Sample GSM1003469: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1003469> |
| 7502 | SRS494656 | SRX369112 | GEO | GSM1252315: CHG092; Homo sapiens; ChIP-Seq | ChIP-Seq | SINGLE - | GEO Sample GSM1252315: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1252315> | GEO Accession: GSM1252315 | NA | source\_name: Gastric Primary Sample || tissuetype: Tumor || chip antibody: H3K4me1 || reads length: 101 || BioSampleModel: Generic | GEO Sample GSM1252315: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1252315> |
| 2127 | SRS266173 | SRX099863 | GEO | GSM808752: MCF7\_CTCF\_REP1 | ChIP-Seq | SINGLE - | GEO Web Link: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM808752> | GEO Accession: GSM808752: | NA | source\_name: breast adenocarcinoma cells || cell type: breast adenocarcinoma cells || cell line: MCF7 || antibody: CTCF || BioSampleModel: Generic | GEO Sample GSM808752: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM808752> |
| 6299 | SRS468164 | SRX332680 | GEO | GSM1204476: Input DNA for ChIP; Homo sapiens; ChIP-Seq | ChIP-Seq | SINGLE - | GEO Sample GSM1204476: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1204476> | GEO Accession: GSM1204476 | NA | source\_name: MDAMB231 || cell line: MDAMB231 || chip antibody: input || BioSampleModel: Generic | GEO Sample GSM1204476: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1204476> |
| 832 | SRS115184 | SRX027300 | GEO | GSM593367: H3K4me3\_H3 | ChIP-Seq | SINGLE - | GEO Web Link: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM593367> | GEO Accession: GSM593367 | NA | source\_name: LCL || chip antibody: H3K4me3 || cell type: lymphoblastoid cell line || BioSampleModel: Generic | GEO Sample GSM593367: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM593367> |
| 8638 | SRS598154 | SRX528309 | GEO | GSM1375207: H3\_ChIPSeq\_Human; Homo sapiens; ChIP-Seq | ChIP-Seq | SINGLE - | GEO Sample GSM1375207: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1375207> | GEO Accession: GSM1375207 | NA | source\_name: H3\_ChIPSeq\_Human || donor age: adult || cell type: sperm || chip antibody: H3F3B || chip antibody vendor: Abnova || BioSampleModel: Generic | GEO Sample GSM1375207: <http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM1375207> |

# 4 Annotating text with ontology concepts

The Onassis `EntityFinder` class has methods for annotating any text with dictionary terms. More specifically, Onassis can take advantage of the OBO dictionaries (<http://www.obofoundry.org/>).

## 4.1 Data preparation

The findEntities method supports input text in the form of:

* The path of a directory containing named documents.
  + The path of a single file containing multiple documents. In this case each row contains the name/identifier of the document followed by a ‘|’ separator and the text to annotate.

Alternatively, the annotateDF method supports input text in the form of a data frame. In this case each row represents a document; the first column has to be the document identifier; the remaining columns will be combined and contain the text to analyze. This option can be conveniently used with the metadata retrieved from *[GEOmetadb](https://bioconductor.org/packages/3.8/GEOmetadb)* and *[SRAdb](https://bioconductor.org/packages/3.8/SRAdb)*, possibly selecting a subset of the available columns.

## 4.2 Creation of a Conceptmapper Dictionary

Onassis handles the convertion of OBO dictionaries into a format suitable to Conceptmapper: XML files with a set of entries specified by the xml tag `<token>` with a canonical name (the name of the entry) and one or more variants (synonyms).

The constructor `CMdictionary` creates an instance of the class `CMdictionary`.

* If an XML file containing the Conceptmapper dictionary is already available, it can be uploaded into Onassis indicating its path and setting the `dictType` option to “CMDICT”.
  + If the dictionary has to be built from an OBO ontology (OBO or OWL formats are supported), the path or URL to the corresponding file has to be provided and dictType has to be set to “OBO”. The synonymType argument can be set to EXACT\_ONLY or ALL to consider only canonical concept names or also to include any synonym. The resulting XML file is written in the indicated outputdir.
  + Additionally, to facilitate the named entity recognition of specific targets, such in the case of ChIP-seq experiments, these can be included within a specific dictionary, and dictType has to be set to ENTREZ. If a specific Org.xx.eg.db Bioconductor library is installed and loaded, it can be indicated in the inputFileOrDb parameter as a character string, and gene names will be derived from it. Instead, if inputFileOrDb is empty and a specific species is indicated in the taxID parameter, gene names will be derived from the corresponding gene\_info.gz file downloaded from NCBI (300MB). Finally, if dictType is set to TARGET, known histone post-translational modifications and epigenetic marks are also included, in addition to gene names.

```
# If a Conceptmapper dictionary is already available the dictType CMDICT can be specified and the corresponding file loaded
sample_dict <- CMdictionary(inputFileOrDb=system.file('extdata', 'cmDict-sample.cs.xml', package = 'Onassis'), dictType = 'CMDICT')

#Creation of a dictionary from the file sample.cs.obo available in OnassisJavaLibs
obo <- system.file('extdata', 'sample.cs.obo', package='OnassisJavaLibs')

sample_dict <- CMdictionary(inputFileOrDb=obo, outputDir=getwd(), synonymType='ALL')

# Creation of a dictionary for human genes/proteins. This requires org.Hs.eg.db to be installed
require(org.Hs.eg.db)
targets <- CMdictionary(dictType='TARGET', inputFileOrDb = 'org.Hs.eg.db', synonymType='EXACT')
```

The following XML markup code illustrates a sample of the Conceptmapper dictionary corresponding to the Brenda tissue ontology.

```
   <?xml version="1.0" encoding="UTF-8" ?>
   <synonym>
      <token id="http://purl.obolibrary.org/obo/BTO_0005205" canonical="cerebral artery">
        <variant base="cerebral artery"/>
      </token>
      <token id="http://purl.obolibrary.org/obo/BTO_0002179" canonical="184A1N4 cell">
        <variant base="184A1N4 cell"/>
        <variant base="A1N4 cell"/>
      </token>
      <token id="http://purl.obolibrary.org/obo/BTO_0003871" canonical="uterine endometrial cancer cell">
        <variant base="uterine endometrial cancer cell"/>
        <variant base="endometrial cancer cell"/>
        <variant base="uterine endometrial carcinoma cell"/>
        <variant base="endometrial carcinoma cell"/>
      </token>
  </synonym>
```

## 4.3 Setting the options for the annotator

Conceptmapper includes 7 different options controlling the annotation step. These are documented in detail in the documentation of the CMoptions function. They can be listed through the `listCMOptions` function. The `CMoptions` constructor instantiates an object of class CMoptions with the different parameters that will be required for the subsequent step of annotation. We also provided getter and setter methods for each of the 7 parameters.

```
#Creating a CMoptions object and showing hte default parameters
opts <- CMoptions()
show(opts)
```

```
## CMoptions object to set ConceptMapper Options
```

```
## SearchStrategy: CONTIGUOUS_MATCH
## CaseMatch: CASE_INSENSITIVE
## Stemmer: NONE
## StopWords: NONE
## OrderIndependentLookup: ON
## FindAllMatches: YES
## SynonymType: ALL
```

To obtain the list of all the possible combinations:

```
combinations <- listCMOptions()
```

To create a CMoptions object having has SynonymType ‘EXACT\_ONLY’, that considers only exact synonyms, rather than ‘ALL’ other types included in OBO (RELATED, NARROW, BROAD)

```
myopts <- CMoptions(SynonymType='EXACT_ONLY')
myopts
```

```
## CMoptions object to set ConceptMapper Options
```

```
## SearchStrategy: CONTIGUOUS_MATCH
## CaseMatch: CASE_INSENSITIVE
## Stemmer: NONE
## StopWords: NONE
## OrderIndependentLookup: ON
## FindAllMatches: YES
## SynonymType: EXACT_ONLY
```

To change a given parameter, for example to use a search strategy based on the Longest match of not-necessarily contiguous tokens where overlapping matches are allowed:

```
#Changing the SearchStrategy parameter
SearchStrategy(myopts) <- 'SKIP_ANY_MATCH_ALLOW_OVERLAP'
myopts
```

```
## CMoptions object to set ConceptMapper Options
```

```
## SearchStrategy: SKIP_ANY_MATCH_ALLOW_OVERLAP
## CaseMatch: CASE_INSENSITIVE
## Stemmer: NONE
## StopWords: NONE
## OrderIndependentLookup: ON
## FindAllMatches: YES
## SynonymType: EXACT_ONLY
```

## 4.4 Running the entity finder

The class `EntityFinder` defines a type system and runs the Conceptmapper pipeline. It can search for concepts of any OBO ontology in a given text. The `findEntities` and `annotateDF` methods accept text within files or data.frame, respectively, as described in Section 4.1.
The function `EntityFinder` automatically adapts to the provided input type, creates an instance of the `EntityFinder` class to initialize the type system and runs Conceptmapper with the provided options and dictionary.
For example, to annotate the metadata derived from ChIP-seq experiments obtained from SRA with tissue and cell type concepts belonging to the sample ontology available in Onassis and containing tissues and cell names, the following code can be used:

```
sra_chip_seq <- readRDS(system.file('extdata', 'vignette_data', 'GEO_human_chip.rds',  package='Onassis'))
chipseq_dict_annot <- EntityFinder(sra_chip_seq[1:50, c('experiment_accession', 'title', 'experiment_attribute', 'sample_attribute', 'description')], dictionary=sample_dict, options=myopts)
```

The resulting data.frame contains, for each row, a match to the provided dictionary for the document/sample indicated in the first column. The annotation is reported with the id of the concept (term\_id), its canonical name (term name), its URL in the obo format, and the matching sentence of the document.

Table 3: Annotating the metadata of DNA methylation sequencing experiments with a dictionary including CL (Cell line) and UBERON ontologies

| sample\_id | term\_id | term\_name | term\_url | matched\_sentence |
| --- | --- | --- | --- | --- |
| SRX027300 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRX028649 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRX033328 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | T lymphoma cells with 10 ug/ml DRB treatment, pol II ChIP || cell |
| SRX033328 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell line: Jurkat || cell type: T |
| SRX033328 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRX033328 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell type: T |
| SRX047080 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | Prostate |
| SRX047080 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRX080398 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell: HCPEpiC || cell organism: Human || cell description: Human Choroid Plexus Epithelial |
| SRX080398 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRX080398 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell organism: Human || cell description: Human Choroid Plexus Epithelial |
| SRX080398 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell description: Human Choroid Plexus Epithelial |
| SRX080398 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | Epithelial Cells || cell |
| SRX084599 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRX092417 | CL\_0000236 | B cell | <http://purl.obolibrary.org/obo/CL_0000236> | B cells || cell |
| SRX092417 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRX092417 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | Cell |
| SRX096365 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRX099863 | UBERON\_0000310 | breast | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast |
| SRX099863 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |

The function `filterTerms` can be used to remove all the occurrences of unwanted terms, for example very generic terms.

```
chipseq_dict_annot <- filterTerms(chipseq_dict_annot, c('cell', 'tissue'))
```

(#tab:showchipresults\_filtered)Filtered Annotations

|  | sample\_id | term\_id | term\_name | term\_url | matched\_sentence |
| --- | --- | --- | --- | --- | --- |
| 3 | SRX033328 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | T lymphoma cells with 10 ug/ml DRB treatment, pol II ChIP || cell |
| 4 | SRX033328 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell line: Jurkat || cell type: T |
| 6 | SRX033328 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell type: T |
| 7 | SRX047080 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | Prostate |
| 9 | SRX080398 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell: HCPEpiC || cell organism: Human || cell description: Human Choroid Plexus Epithelial |
| 11 | SRX080398 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell organism: Human || cell description: Human Choroid Plexus Epithelial |
| 12 | SRX080398 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell description: Human Choroid Plexus Epithelial |
| 13 | SRX080398 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | Epithelial Cells || cell |
| 15 | SRX092417 | CL\_0000236 | B cell | <http://purl.obolibrary.org/obo/CL_0000236> | B cells || cell |
| 19 | SRX099863 | UBERON\_0000310 | breast | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast |
| 21 | SRX101132 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate |
| 28 | SRX129103 | CL\_0000236 | B cell | <http://purl.obolibrary.org/obo/CL_0000236> | B-cell |
| 30 | SRX150687 | CL\_0000222 | mesodermal cell | <http://purl.obolibrary.org/obo/CL_0000222> | cell: GM12878 || cell organism: human || cell description: B-lymphocyte, lymphoblastoid, International HapMap Project - CEPH/Utah - European Caucasion, Epstein-Barr Virus || cell karyotype: normal || cell lineage: mesoderm |
| 31 | SRX150687 | CL\_0000236 | B cell | <http://purl.obolibrary.org/obo/CL_0000236> | cell: GM12878 || cell organism: human || cell description: B |
| 33 | SRX150687 | CL\_0000222 | mesodermal cell | <http://purl.obolibrary.org/obo/CL_0000222> | cell organism: human || cell description: B-lymphocyte, lymphoblastoid, International HapMap Project - CEPH/Utah - European Caucasion, Epstein-Barr Virus || cell karyotype: normal || cell lineage: mesoderm |
| 34 | SRX150687 | CL\_0000236 | B cell | <http://purl.obolibrary.org/obo/CL_0000236> | cell organism: human || cell description: B |
| 35 | SRX150687 | CL\_0000222 | mesodermal cell | <http://purl.obolibrary.org/obo/CL_0000222> | cell description: B-lymphocyte, lymphoblastoid, International HapMap Project - CEPH/Utah - European Caucasion, Epstein-Barr Virus || cell karyotype: normal || cell lineage: mesoderm |
| 36 | SRX150687 | CL\_0000236 | B cell | <http://purl.obolibrary.org/obo/CL_0000236> | cell description: B |
| 37 | SRX150687 | CL\_0000945 | lymphocyte of B lineage | <http://purl.obolibrary.org/obo/CL_0000945> | B-lymphocyte, lymphoblastoid, International HapMap Project - CEPH/Utah - European Caucasion, Epstein-Barr Virus || cell karyotype: normal || cell lineage: mesoderm || cell sex: F || treatment: None || treatment description: No special treatment or protocol applies || antibody: Pol2(phosphoS2) || antibody antibodydescription: Rabbit polyclonal against peptide conjugated to KLH derived from within residues 1600 - 1700 of |
| 38 | SRX150687 | CL\_0000236 | B cell | <http://purl.obolibrary.org/obo/CL_0000236> | B-lymphocyte, lymphoblastoid, International HapMap Project - CEPH/Utah - European Caucasion, Epstein-Barr Virus || cell |

The function `EntityFinder` can also be used to identify the targeted entity of each ChIP-seq experiment, by retrieving gene names and epigenetic marks in the ChIP-seq metadata.

```
#Finding the TARGET entities
target_entities <- EntityFinder(input=sra_chip_seq[1:50, c('experiment_accession', 'title', 'experiment_attribute', 'sample_attribute', 'description')], options = myopts, dictionary=targets)
```

Table 4: Annotations of ChIP-seq test metadata obtained from SRAdb and stored into files with the TARGETs (genes and histone variants)

| sample\_id | term\_id | term\_name | term\_url | matched\_sentence |
| --- | --- | --- | --- | --- |
| SRX027300 | H3K4me3 | H3K4me3 | NA | H3K4me3 |
| SRX028649 | H3K27me3 | H3K27me3 | NA | H3K27me3 |
| SRX080398 | 10664 | CTCF | NA | CTCF |
| SRX084599 | 604 | BCL6 | NA | BCL6 |
| SRX096365 | H3K4me2 | H3K4me2 | NA | H3K4me2 |
| SRX099863 | 10664 | CTCF | NA | CTCF |
| SRX109450 | H3K27me3 | H3K27me3 | NA | H3K27me3 |
| SRX113180 | H3K4me2 | H3K4me2 | NA | H3K4me2 |
| SRX114958 | 23133 | PHF8 | NA | PHF8 |
| SRX114963 | 23512 | SUZ12 | NA | SUZ12 |
| SRX116426 | 10013 | HDAC6 | NA | HDAC6 |
| SRX150687 | 1283 | CTD | NA | CTD |
| SRX155719 | 3297 | HSF1 | NA | HSF1 |
| SRX185917 | 2305 | FOXM1 | NA | FOXM1 |
| SRX186621 | 7975 | MAFK | NA | MAFK |
| SRX186621 | 4778 | NFE2 | NA | NFE2 |
| SRX186665 | H3K79me2 | H3K79me2 | NA | H3K79me2 |
| SRX186733 | 929 | CD14 | NA | CD14 |
| SRX186733 | H3K79me2 | H3K79me2 | NA | H3K79me2 |
| SRX190202 | 6938 | TCF12 | NA | TCF12 |

# 5 Semantic similarity

Once a set of samples is annotated, i.e. associated to a set of ontology concepts, Onassis allows the quantification of the similarity among these samples based on the semantic similarity between the corresponding concepts. `Similarity` is an Onassis class applying methods of the Java library slib (Harispe et al. 2014), which builds a semantic graph starting from OBO ontology concepts and their hierarchical relationships.
The following methods are available and are automatically chosen depending on the settings of the `Similarity` function. The `sim` and `groupsim` methods allow the computation of semantic similarity between single terms (pairwise measures) and between group of terms (groupwise measures), respectively. Pairwise measures can be edge based, if they rely only on the structure of the ontology, or information-content based if they also consider the information that each term in the ontology carries. Rather, groupwise measures can be indirect, if they compute the pairwise similarity between each couple of terms, or direct if they consider each set of concepts as a whole.
The `samplesim` method allows to determine the semantic similarity between two documents, each possibly associated to multiple concepts. Finally, the `multisim` method allows to determine the semantic similarity between documents annotated with two or more ontologies: first `samplesim` is run for each ontology, then a user defined function can be used to aggregate the resulting semantic similarities for each pair of documents.

The function `listSimilarities` shows all the measures supported by Onassis. For details about the measures run `{?Similarity}`.

```
#Instantiating the Similarity
similarities <- listSimilarities()
```

## 5.1 Semantic similarity between ontology terms

The following example shows pairwise similarities between the individual concepts of previously annotated ChIP-seq experiments metadata. The **lin** similarity measure is used by default, which relies on a ratio between the Information content (IC) of the terms most specific common ancestor, and the sum of their IC (based on the information content of their most informative common ancestor). In particular, the  **seco**  information content is used by default, which determines the specificity of each concept based on the number of concepts it subsumes.

```
#Retrieving URLS of concepts
found_terms <- as.character(unique(chipseq_dict_annot$term_url))

# Creating a dataframe with all possible couples of terms and adding a column to store the similarity
pairwise_results <- t(combn(found_terms, 2))
pairwise_results <- cbind(pairwise_results, rep(0, nrow(pairwise_results)))

# Similarity computation for each couple of terms
for(i in 1:nrow(pairwise_results)){
    pairwise_results[i, 3] <- Similarity(obo, pairwise_results[i,1], pairwise_results[i, 2])
}
colnames(pairwise_results) <- c('term1', 'term2', 'value')

# Adding the term names from the annotation table to the comparison results
pairwise_results <- merge(pairwise_results, chipseq_dict_annot[, c('term_url', 'term_name')], by.x='term2', by.y='term_url')
colnames(pairwise_results)[length(colnames(pairwise_results))] <- 'term2_name'
pairwise_results <- merge(pairwise_results, chipseq_dict_annot[, c('term_url', 'term_name')], by.x='term1', by.y='term_url')
colnames(pairwise_results)[length(colnames(pairwise_results))] <- 'term1_name'
pairwise_results <- unique(pairwise_results)
# Reordering the columns
pairwise_results <- pairwise_results[, c('term1', 'term1_name', 'term2', 'term2_name', "value")]
```

Table 5: Pairwise similarities of cell type terms annotating the ChIP-seq metadata

|  | term1 | term1\_name | term2 | term2\_name | value |
| --- | --- | --- | --- | --- | --- |
| 1 | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000055> | non-terminally differentiated cell | 0.729933133609861 |
| 16 | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000236> | B cell | 0.391845067198581 |
| 121 | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell | <http://purl.obolibrary.org/obo/UBERON_0000926> | mesoderm | 0.0519216647312627 |
| 166 | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000222> | mesodermal cell | 0.391845067198581 |
| 211 | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast | 0.0548979704654821 |
| 226 | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell | <http://purl.obolibrary.org/obo/CL_0002327> | mammary gland epithelial cell | 0.830359471632107 |
| 391 | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000945> | lymphocyte of B lineage | 0.428161870137102 |
| 631 | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000542> | lymphocyte | 0.45270539422977 |
| 676 | <http://purl.obolibrary.org/obo/CL_0000084> | T cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell | 0.0475176554118867 |
| 691 | <http://purl.obolibrary.org/obo/CL_0000084> | T cell | <http://purl.obolibrary.org/obo/CL_0000542> | lymphocyte | 0.0459017490429164 |
| 711 | <http://purl.obolibrary.org/obo/CL_0000084> | T cell | <http://purl.obolibrary.org/obo/CL_0002327> | mammary gland epithelial cell | 0.0406258626128426 |
| 716 | <http://purl.obolibrary.org/obo/CL_0000084> | T cell | <http://purl.obolibrary.org/obo/CL_0000222> | mesodermal cell | 0.0406258626128426 |
| 721 | <http://purl.obolibrary.org/obo/CL_0000084> | T cell | <http://purl.obolibrary.org/obo/CL_0000055> | non-terminally differentiated cell | 0.0475176554118867 |
| 761 | <http://purl.obolibrary.org/obo/CL_0000084> | T cell | <http://purl.obolibrary.org/obo/UBERON_0000926> | mesoderm | 0.0438023301930405 |
| 806 | <http://purl.obolibrary.org/obo/CL_0000084> | T cell | <http://purl.obolibrary.org/obo/CL_0000236> | B cell | 0.0406258626128426 |
| 871 | <http://purl.obolibrary.org/obo/CL_0000084> | T cell | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland | 0.0406258626128426 |
| 916 | <http://purl.obolibrary.org/obo/CL_0000084> | T cell | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast | 0.0459017490429164 |
| 931 | <http://purl.obolibrary.org/obo/CL_0000084> | T cell | <http://purl.obolibrary.org/obo/CL_0000945> | lymphocyte of B lineage | 0.0438023301930405 |
| 1021 | <http://purl.obolibrary.org/obo/CL_0000222> | mesodermal cell | <http://purl.obolibrary.org/obo/CL_0002327> | mammary gland epithelial cell | 0.407168835846172 |
| 1039 | <http://purl.obolibrary.org/obo/CL_0000222> | mesodermal cell | <http://purl.obolibrary.org/obo/UBERON_0000926> | mesoderm | 0.921811689010297 |
| 1075 | <http://purl.obolibrary.org/obo/CL_0000222> | mesodermal cell | <http://purl.obolibrary.org/obo/CL_0000542> | lymphocyte | 0.58549535261452 |
| 1093 | <http://purl.obolibrary.org/obo/CL_0000222> | mesodermal cell | <http://purl.obolibrary.org/obo/CL_0000055> | non-terminally differentiated cell | 0.391845067198581 |
| 1165 | <http://purl.obolibrary.org/obo/CL_0000222> | mesodermal cell | <http://purl.obolibrary.org/obo/CL_0000945> | lymphocyte of B lineage | 0.558716417052732 |
| 1219 | <http://purl.obolibrary.org/obo/CL_0000236> | B cell | <http://purl.obolibrary.org/obo/CL_0000222> | mesodermal cell | 0.518199289825233 |
| 1231 | <http://purl.obolibrary.org/obo/CL_0000236> | B cell | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast | 0.0459017490429164 |
| 1255 | <http://purl.obolibrary.org/obo/CL_0000236> | B cell | <http://purl.obolibrary.org/obo/CL_0000055> | non-terminally differentiated cell | 0.391845067198581 |
| 1303 | <http://purl.obolibrary.org/obo/CL_0000236> | B cell | <http://purl.obolibrary.org/obo/CL_0002327> | mammary gland epithelial cell | 0.335013243552152 |
| 1411 | <http://purl.obolibrary.org/obo/CL_0000236> | B cell | <http://purl.obolibrary.org/obo/CL_0000542> | lymphocyte | 0.870134783835804 |
| 1519 | <http://purl.obolibrary.org/obo/CL_0000236> | B cell | <http://purl.obolibrary.org/obo/UBERON_0000926> | mesoderm | 0.0438023301930405 |
| 1579 | <http://purl.obolibrary.org/obo/CL_0000236> | B cell | <http://purl.obolibrary.org/obo/CL_0000945> | lymphocyte of B lineage | 0.921811689010297 |
| 1615 | <http://purl.obolibrary.org/obo/CL_0000542> | lymphocyte | <http://purl.obolibrary.org/obo/UBERON_0000926> | mesoderm | 0.0499984102249816 |
| 1617 | <http://purl.obolibrary.org/obo/CL_0000542> | lymphocyte | <http://purl.obolibrary.org/obo/CL_0000055> | non-terminally differentiated cell | 0.45270539422977 |
| 1619 | <http://purl.obolibrary.org/obo/CL_0000542> | lymphocyte | <http://purl.obolibrary.org/obo/CL_0002327> | mammary gland epithelial cell | 0.378519810843921 |
| 1631 | <http://purl.obolibrary.org/obo/CL_0000945> | lymphocyte of B lineage | <http://purl.obolibrary.org/obo/CL_0000055> | non-terminally differentiated cell | 0.428161870137102 |
| 1633 | <http://purl.obolibrary.org/obo/CL_0000945> | lymphocyte of B lineage | <http://purl.obolibrary.org/obo/UBERON_0000926> | mesoderm | 0.0475176554118867 |
| 1635 | <http://purl.obolibrary.org/obo/CL_0000945> | lymphocyte of B lineage | <http://purl.obolibrary.org/obo/CL_0000542> | lymphocyte | 0.947792987857007 |
| 1636 | <http://purl.obolibrary.org/obo/CL_0000945> | lymphocyte of B lineage | <http://purl.obolibrary.org/obo/CL_0002327> | mammary gland epithelial cell | 0.361207363224677 |
| 1641 | <http://purl.obolibrary.org/obo/CL_0002327> | mammary gland epithelial cell | <http://purl.obolibrary.org/obo/CL_0000055> | non-terminally differentiated cell | 0.606106891151053 |
| 1647 | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast | <http://purl.obolibrary.org/obo/CL_0000222> | mesodermal cell | 0.460045904728659 |
| 1651 | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast | <http://purl.obolibrary.org/obo/CL_0000945> | lymphocyte of B lineage | 0.0499984102249816 |
| 1659 | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast | <http://purl.obolibrary.org/obo/CL_0000055> | non-terminally differentiated cell | 0.0548979704654821 |
| 1671 | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast | <http://purl.obolibrary.org/obo/UBERON_0000926> | mesoderm | 0.501104300959006 |
| 1707 | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast | <http://purl.obolibrary.org/obo/CL_0002327> | mammary gland epithelial cell | 0.870134783835804 |
| 1727 | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast | <http://purl.obolibrary.org/obo/CL_0000542> | lymphocyte | 0.0527524584646166 |
| 1763 | <http://purl.obolibrary.org/obo/UBERON_0000926> | mesoderm | <http://purl.obolibrary.org/obo/CL_0002327> | mammary gland epithelial cell | 0.439004679408628 |
| 1772 | <http://purl.obolibrary.org/obo/UBERON_0000926> | mesoderm | <http://purl.obolibrary.org/obo/CL_0000055> | non-terminally differentiated cell | 0.0519216647312627 |
| 1778 | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland | <http://purl.obolibrary.org/obo/CL_0000055> | non-terminally differentiated cell | 0.0475176554118867 |
| 1796 | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell | 0.0475176554118867 |
| 1868 | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland | <http://purl.obolibrary.org/obo/CL_0000222> | mesodermal cell | 0.407168835846172 |
| 2030 | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland | <http://purl.obolibrary.org/obo/CL_0000236> | B cell | 0.0406258626128426 |
| 2066 | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0000926> | mesoderm | 0.439004679408628 |
| 2084 | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland | <http://purl.obolibrary.org/obo/CL_0000945> | lymphocyte of B lineage | 0.0438023301930405 |
| 2156 | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland | <http://purl.obolibrary.org/obo/CL_0002327> | mammary gland epithelial cell | 0.407168835846172 |
| 2255 | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland | <http://purl.obolibrary.org/obo/CL_0000542> | lymphocyte | 0.0459017490429164 |
| 2273 | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0000310> | breast | 0.460045904728659 |

Noteworthy, the terms ‘B-cell’ and ‘lymphocyte’ are closer (similarity 0.83) than ‘B cell’ and ‘epithelial cell’ (similarity 0.26).
It is also possible to compute the semantic similarity between two groups of terms.
For example, to determine a value of similarity for the combination of (‘non-terminally differentiated cell’, ‘epithelial cell’) and the combination of (‘lymphocyte’ , ‘B cell’) we can use the **ui** measure (set as default measure in Onassis), a groupwise direct measure combining the intersection and the union of the set of ancestors of the two groups of concepts.

```
oboprefix <- 'http://purl.obolibrary.org/obo/'
Similarity(obo, paste0(oboprefix, c('CL_0000055', 'CL_0000066')) , paste0(oboprefix, c('CL_0000542', 'CL_0000236')))
```

```
## [1] 0.1764706
```

The similarity between these two groups of terms is low (in the interval [0, 1]), while the addition of the term ‘lymphocyte of B lineage’ to the first group the group similarity increases.

```
Similarity(obo, paste0(oboprefix, c('CL_0000055', 'CL_0000236' ,'CL_0000236')), paste0(oboprefix, c('CL_0000542', 'CL_0000066')))
```

```
## [1] 0.6470588
```

## 5.2 Semantic similarity between annotated samples

Similarity also supports the computation of the similarity between annotated samples. Since each sample is typically associated tu multiple terms, Similarity runs in the groupwise mode when applied to samples. To this end, samples identifiers and a data frame with previously annotated concepts returned by EntityFinder are required.

```
# Extracting all the couples of samples
annotated_samples <- as.character(as.vector(unique(chipseq_dict_annot$sample_id)))

samples_couples <- t(combn(annotated_samples, 2))

# Computing the samples semantic similarity
similarity_results <- apply(samples_couples, 1, function(couple_of_samples){
    Similarity(obo, couple_of_samples[1], couple_of_samples[2], chipseq_dict_annot)
})

#Creating a matrix to store the results of the similarity between samples
similarity_matrix <- matrix(0, nrow=length(annotated_samples), ncol=length(annotated_samples))
rownames(similarity_matrix) <- colnames(similarity_matrix) <- annotated_samples

# Filling the matrix with similarity values
similarity_matrix[lower.tri(similarity_matrix, diag=FALSE)] <- similarity_results
similarity_matrix <- t(similarity_matrix)
similarity_matrix[lower.tri(similarity_matrix, diag=FALSE)] <- similarity_results
# Setting the diagonal to 1
diag(similarity_matrix) <- 1

# Pasting the annotations to the sample identifiers
samples_legend <- aggregate(term_name ~ sample_id, chipseq_dict_annot, function(aggregation) paste(unique(aggregation), collapse=',' ))
rownames(similarity_matrix) <- paste0(rownames(similarity_matrix), ' (', samples_legend[match(rownames(similarity_matrix), samples_legend$sample_id), c('term_name')], ')')

# Showing a heatmap of the similarity between samples
heatmap.2(similarity_matrix, density.info = "none", trace="none", main='Samples\n semantic\n similarity', margins=c(12,50), cexRow = 2, cexCol = 2, keysize = 0.5)
```

![](data:image/png;base64...)

# 6 Onassis class

The class Onassis was built to wrap the main functionalities of the package in a single class.
It consists of 4 slots:

* dictionary: stores the source dictionary used to find entities.
* entities: a table containing the annotations of documents (samples). The list of unique concepts belonging to the dictionary and found in the metadata representing a given sample is defined as a that sample semantic set
* similarity: a matrix of the similarities between the unique semantic sets identified in the entities table
* scores: a dataset of quantitative measurements (e.g. gene expression) associated to the same samples annotated in the entities slot.

## 6.1 Metadata annotation

In this section we illustrate the use of the Onassis class to annotate the metadata of ChIP-seq samples having as target H3K27ac. The dataset used for the following examples was obtained by annotating the all the ChIP-seq samples from SRA with target entities (as described in Section 4.2) and selecting the sample identifiers having H3K27ac as target. To load it from the vignette data:

```
h3k27ac_chip <- readRDS(system.file('extdata', 'vignette_data', 'h3k27ac_metadata.rds',  package='Onassis'))
```

The method `annotate` takes as input a data frame of metadata to annotate, the type of dictionary and the path of an ontology file and returns an instance of class Onassis.
The input data frame should have unique identifiers in the first column (sample identifiers or generic document identifiers) and for each row one or more columns containing the metadata related to the identifier. Importantly, to subsequently compute the semantic similarities, the dictionary given to the method needs to be an ‘OBO’ ontology. To annotate tissue and cell types we used the previously loaded dictionary available in `OnassisJavaLibs` containing a sample of the Cell Line ontology CL merged with UBERON terms to identify also tissues.

```
cell_annotations <- annotate(h3k27ac_chip, 'OBO', obo, FindAllMatches='YES' )
```

To slot `entities` of an Onassis object reports for each sample the unique list of concepts found in the corresponding metadata. Specifically, term ids, term urls and term names are reported, and multiple entries per sample are comma separated. We usually refer to these unique lists as semantic sets.

To retrieve the semantic sets in an object of class Onassis we provided the accessor method `entities`

```
cell_entities <- entities(cell_annotations)
```

Table 6:  Semantic sets of ontology concepts (entities) associated to each sample, stored in the entities slot of the Onassis object

| sample\_id | term\_id | term\_name | term\_url | matched\_sentence |
| --- | --- | --- | --- | --- |
| SRS374641 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRS647794 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRS664753 | CL\_0000000, CL\_0002553 | cell, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000000>, <http://purl.obolibrary.org/obo/CL_0002553> | cell, Lung Fibroblasts |
| SRS916623 | CL\_0000000, CL\_0000066, UBERON\_0000479 | cell, epithelial cell, tissue | <http://purl.obolibrary.org/obo/CL_0000000>, <http://purl.obolibrary.org/obo/CL_0000066>, <http://purl.obolibrary.org/obo/UBERON_0000479> | cell, epithelial cell, tissue |
| SRS688199 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRS647792 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRS115326 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |
| SRS211230 | CL\_0000000, CL\_0002553 | cell, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000000>, <http://purl.obolibrary.org/obo/CL_0002553> | cell, lung fibroblasts |
| SRS722736 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | Cell |
| SRS544404 | CL\_0000000 | cell | <http://purl.obolibrary.org/obo/CL_0000000> | cell |

The `filterconcepts` method can be used to filter out unwanted annotations, for example terms that we consider redundant or too generic. The method modifies the entities slot of the Onassis object and returns a new Onassis object with filtered semantic sets.

```
filtered_cells <- filterconcepts(cell_annotations, c('cell', 'tissue'))
```

Table 7: Entities in filtered Onassis object

|  | sample\_id | term\_id | term\_name | term\_url | matched\_sentence |
| --- | --- | --- | --- | --- | --- |
| 24 | SRS174052 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | cell, Prostate |
| 25 | SRS174053 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | cell, Prostate |
| 27 | SRS192719 | UBERON\_0000310 | breast | <http://purl.obolibrary.org/obo/UBERON_0000310> | cell, breast |
| 28 | SRS211217 | CL\_0000222, UBERON\_0000926 | mesodermal cell, mesoderm | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926> | cell, mesoderm || cell, mesoderm |
| 29 | SRS211230 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | cell, lung fibroblasts |
| 30 | SRS211238 | CL\_0002327 | mammary gland epithelial cell | <http://purl.obolibrary.org/obo/CL_0002327> | cell, mammary epithelial cells |
| 32 | SRS211244 | CL\_0000222, UBERON\_0000926 | mesodermal cell, mesoderm | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926> | cell, mesoderm || cell, mesoderm |
| 33 | SRS211255 | CL\_0000222, CL\_0000236, CL\_0000542, UBERON\_0000926 | mesodermal cell, B cell, lymphocyte, mesoderm | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542>, <http://purl.obolibrary.org/obo/UBERON_0000926> | cell, mesoderm, B-lymphocyte, lymphocyte, mesoderm |
| 34 | SRS211287 | CL\_0000222, UBERON\_0000926 | mesodermal cell, mesoderm | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926> | cell, mesoderm, mesoderm |
| 35 | SRS211291 | CL\_0002327 | mammary gland epithelial cell | <http://purl.obolibrary.org/obo/CL_0002327> | cell, mammary epithelial cells |
| 37 | SRS211317 | CL\_0000222, UBERON\_0000926 | mesodermal cell, mesoderm | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926> | cell, mesoderm || cell, mesoderm |
| 38 | SRS211334 | CL\_0000222, UBERON\_0000926 | mesodermal cell, mesoderm | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926> | cell, mesoderm || cell, mesoderm |
| 40 | SRS211349 | CL\_0000222, UBERON\_0000926 | mesodermal cell, mesoderm | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926> | cell, mesoderm || cell, mesoderm |
| 41 | SRS211350 | CL\_0000222, CL\_0000236, CL\_0000542, UBERON\_0000926 | mesodermal cell, B cell, lymphocyte, mesoderm | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542>, <http://purl.obolibrary.org/obo/UBERON_0000926> | cell, mesoderm, B-lymphocyte, lymphocyte, mesoderm |
| 43 | SRS211356 | CL\_0000222, UBERON\_0000926 | mesodermal cell, mesoderm | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926> | cell, mesoderm, mesoderm |
| 48 | SRS295810 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon |
| 49 | SRS295811 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon |
| 50 | SRS295812 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon |
| 51 | SRS295813 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon |
| 52 | SRS295814 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon |
| 53 | SRS295815 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon |
| 54 | SRS295816 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon |
| 56 | SRS344610 | UBERON\_0001911, UBERON\_0002530 | mammary gland, gland | <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, mammary gland, gland |
| 57 | SRS345459 | UBERON\_0000310 | breast | <http://purl.obolibrary.org/obo/UBERON_0000310> | cell, breast |
| 82 | SRS365708 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | cell, fibroblast, lung fibroblast |
| 117 | SRS494677 | CL\_0000084, CL\_0000542 | T cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000084>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, T lymphocyte, lymphocyte |
| 118 | SRS494678 | CL\_0000084, CL\_0000542 | T cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000084>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, T lymphocyte, lymphocyte |
| 119 | SRS494679 | CL\_0000084, CL\_0000542 | T cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000084>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, T lymphocyte, lymphocyte |
| 135 | SRS542924 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell, T-cell |
| 136 | SRS542930 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell, T-cell |
| 137 | SRS542938 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell, T-cell |
| 138 | SRS542944 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell, T-cell |
| 157 | SRS558528 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | cell, prostate |
| 158 | SRS580028 | CL\_0000236 | B cell | <http://purl.obolibrary.org/obo/CL_0000236> | cell, B-cell |
| 164 | SRS625672 | UBERON\_0000310 | breast | <http://purl.obolibrary.org/obo/UBERON_0000310> | cell, breast |
| 165 | SRS625673 | UBERON\_0000310 | breast | <http://purl.obolibrary.org/obo/UBERON_0000310> | cell, breast |
| 166 | SRS625674 | UBERON\_0000310 | breast | <http://purl.obolibrary.org/obo/UBERON_0000310> | cell, breast |
| 167 | SRS625675 | UBERON\_0000310 | breast | <http://purl.obolibrary.org/obo/UBERON_0000310> | cell, breast |
| 168 | SRS625676 | UBERON\_0000310 | breast | <http://purl.obolibrary.org/obo/UBERON_0000310> | cell, breast |
| 169 | SRS625677 | UBERON\_0000310 | breast | <http://purl.obolibrary.org/obo/UBERON_0000310> | cell, breast |
| 170 | SRS641761 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, colon |
| 171 | SRS641769 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, colon |
| 172 | SRS645145 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | cell, lung fibroblasts |
| 173 | SRS645146 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | cell, lung fibroblasts |
| 174 | SRS646274 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, colon |
| 236 | SRS664752 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | cell, Lung Fibroblasts |
| 237 | SRS664753 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | cell, Lung Fibroblasts |
| 303 | SRS916587 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue |
| 304 | SRS916588 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue |
| 305 | SRS916597 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue |
| 306 | SRS916598 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue |
| 307 | SRS916606 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue |
| 308 | SRS916607 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue |
| 309 | SRS916614 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue |
| 310 | SRS916615 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue |
| 311 | SRS916622 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue |
| 312 | SRS916623 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue |
| 313 | SRS381055 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast, lung fibroblast |
| 314 | SRS381056 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast, lung fibroblast |
| 315 | SRS435929 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast, lung fibroblast |

## 6.2 Semantic similarity of semantic sets

The method `sim` populates the similarity slot within an Onassis object. Specifically, it generates a matrix containing semantic similarities between the semantic sets for each pair of samples annotated in the entities slot.

```
filtered_cells <- sim(filtered_cells)
```

The matrix of similarities can be accessed using the method `simil(filtered_cells)`.

Semantic sets with semantic similarities above a given threshold can be combined using the method `collapse`. This method, based on hierarchical clustering, unifies the similar semantic sets by concatenating their unique concepts. Term names and term urls in the `entities` slot will be updated accordingly. For each concept, the number of samples associated is also reported in bracket squares, while the total number of samples associated to a given semantic set is indicated in parentheses.
After the collapse, the similarity matrix in the `similarity` slot is consequently updated with the similarities of the new semantic sets.

```
collapsed_cells <- Onassis::collapse(filtered_cells, 0.9)
```

Table 8:  Collapsed Entities in filtered Onassis object

| sample\_id | term\_id | term\_name | term\_url | matched\_sentence | short\_label | cluster |
| --- | --- | --- | --- | --- | --- | --- |
| SRS435929 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast, lung fibroblast | fibroblast [4], fibroblast of lung [4] (4) | 6 |
| SRS381055 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast, lung fibroblast | fibroblast [4], fibroblast of lung [4] (4) | 6 |
| SRS365708 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | cell, fibroblast, lung fibroblast | fibroblast [4], fibroblast of lung [4] (4) | 6 |
| SRS381056 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast, lung fibroblast | fibroblast [4], fibroblast of lung [4] (4) | 6 |
| SRS916588 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue | epithelial cell [10] (10) | 10 |
| SRS916587 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue | epithelial cell [10] (10) | 10 |
| SRS916607 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue | epithelial cell [10] (10) | 10 |
| SRS916597 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue | epithelial cell [10] (10) | 10 |
| SRS916598 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue | epithelial cell [10] (10) | 10 |
| SRS916606 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue | epithelial cell [10] (10) | 10 |
| SRS916623 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue | epithelial cell [10] (10) | 10 |
| SRS916614 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue | epithelial cell [10] (10) | 10 |
| SRS916615 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue | epithelial cell [10] (10) | 10 |
| SRS916622 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | cell, epithelial cell, tissue | epithelial cell [10] (10) | 10 |
| SRS542938 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell, T-cell | T cell [4] (4) | 8 |
| SRS542924 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell, T-cell | T cell [4] (4) | 8 |
| SRS542944 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell, T-cell | T cell [4] (4) | 8 |
| SRS542930 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | cell, T-cell | T cell [4] (4) | 8 |
| SRS494678 | CL\_0000084, CL\_0000542 | T cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000084>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, T lymphocyte, lymphocyte | T cell [3], lymphocyte [3] (3) | 7 |
| SRS494679 | CL\_0000084, CL\_0000542 | T cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000084>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, T lymphocyte, lymphocyte | T cell [3], lymphocyte [3] (3) | 7 |
| SRS494677 | CL\_0000084, CL\_0000542 | T cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000084>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, T lymphocyte, lymphocyte | T cell [3], lymphocyte [3] (3) | 7 |
| SRS211350 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, mesoderm, B-lymphocyte, lymphocyte, mesoderm | mesoderm [9], mesodermal cell [9], B cell [2] (9) | 3 |
| SRS211255 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, mesoderm, B-lymphocyte, lymphocyte, mesoderm | mesoderm [9], mesodermal cell [9], B cell [2] (9) | 3 |
| SRS211217 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, mesoderm || cell, mesoderm | mesoderm [9], mesodermal cell [9], B cell [2] (9) | 3 |
| SRS211334 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, mesoderm || cell, mesoderm | mesoderm [9], mesodermal cell [9], B cell [2] (9) | 3 |
| SRS211287 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, mesoderm, mesoderm | mesoderm [9], mesodermal cell [9], B cell [2] (9) | 3 |
| SRS211356 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, mesoderm, mesoderm | mesoderm [9], mesodermal cell [9], B cell [2] (9) | 3 |
| SRS211244 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, mesoderm || cell, mesoderm | mesoderm [9], mesodermal cell [9], B cell [2] (9) | 3 |
| SRS211317 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, mesoderm || cell, mesoderm | mesoderm [9], mesodermal cell [9], B cell [2] (9) | 3 |
| SRS211349 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | cell, mesoderm || cell, mesoderm | mesoderm [9], mesodermal cell [9], B cell [2] (9) | 3 |
| SRS580028 | CL\_0000236 | B cell | <http://purl.obolibrary.org/obo/CL_0000236> | cell, B-cell | B cell [1] (1) | 9 |
| SRS211291 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, mammary epithelial cells | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS211238 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, mammary epithelial cells | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS664753 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | cell, Lung Fibroblasts | fibroblast of lung [5] (5) | 4 |
| SRS211230 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | cell, lung fibroblasts | fibroblast of lung [5] (5) | 4 |
| SRS645146 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | cell, lung fibroblasts | fibroblast of lung [5] (5) | 4 |
| SRS645145 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | cell, lung fibroblasts | fibroblast of lung [5] (5) | 4 |
| SRS664752 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | cell, Lung Fibroblasts | fibroblast of lung [5] (5) | 4 |
| SRS295810 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon | colon epithelial cell [10] (10) | 5 |
| SRS295813 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon | colon epithelial cell [10] (10) | 5 |
| SRS641761 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, colon | colon epithelial cell [10] (10) | 5 |
| SRS295811 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon | colon epithelial cell [10] (10) | 5 |
| SRS295812 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon | colon epithelial cell [10] (10) | 5 |
| SRS646274 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, colon | colon epithelial cell [10] (10) | 5 |
| SRS295815 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon | colon epithelial cell [10] (10) | 5 |
| SRS295816 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon | colon epithelial cell [10] (10) | 5 |
| SRS641769 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, colon | colon epithelial cell [10] (10) | 5 |
| SRS295814 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | cell, Colon | colon epithelial cell [10] (10) | 5 |
| SRS625675 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, breast | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS625672 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, breast | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS625673 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, breast | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS192719 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, breast | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS625674 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, breast | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS625676 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, breast | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS625677 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, breast | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS345459 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, breast | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS344610 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | cell, mammary gland, gland | breast [8], mammary gland epithelial cell [2], gland [1] (11) | 2 |
| SRS174052 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | cell, Prostate | prostate gland [3] (3) | 1 |
| SRS174053 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | cell, Prostate | prostate gland [3] (3) | 1 |
| SRS558528 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | cell, prostate | prostate gland [3] (3) | 1 |

In the following heatmap the similarity values of collapsed cell/tissue semantic sets is reported.

```
heatmap.2(simil(collapsed_cells), density.info = "none", trace="none", margins=c(36, 36), cexRow = 1.5, cexCol = 1.5, keysize=0.5)
```

![](data:image/png;base64...)

## 6.3 Integrating the annotations from different ontologies

In typical integrative analyses scenarios, users could be interested in annotating concepts from different domains of interest. In this case, one possibility could be building a tailored application ontology including the concepts from different ontologies and their relationships. However this is complicated, since it requires to match and integrate the relationships from one ontology to the other. Rather, Onassis allows integrating two ontologies by repeating the annotation process with another ontology, while keeping separate the semantic sets from the two ontologies. In the following example ChIP-seq samples will be annotated with information about disease conditions. For this particular semantic type, Onassis provides also a boolean variable `disease` that can be set to TRUE to recognize samples metadata explicitly annotated as `Healthy` conditions, to be differentiated from metadata where disease terms are simply lacking.

```
obo2 <- system.file('extdata', 'sample.do.obo', package='OnassisJavaLibs')
disease_annotations <- annotate(h3k27ac_chip, 'OBO',obo2, disease=TRUE )
```

Table 9:  Disease entities

| sample\_id | term\_id | term\_name | term\_url | matched\_sentence |
| --- | --- | --- | --- | --- |
| SRS494677 | DOID\_0060058 | lymphoma | <http://purl.obolibrary.org/obo/DOID_0060058> | lymphoma |
| SRS494678 | DOID\_0060058 | lymphoma | <http://purl.obolibrary.org/obo/DOID_0060058> | lymphoma |
| SRS494679 | DOID\_0060058 | lymphoma | <http://purl.obolibrary.org/obo/DOID_0060058> | lymphoma |
| SRS174052 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS174053 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS192719 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS267283 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS295810 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | Cancer |
| SRS295811 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | Cancer |
| SRS295812 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | Cancer |
| SRS295813 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | Cancer |
| SRS344609 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS344610 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS345463 | DOID\_162, DOID\_9256 | cancer, colorectal cancer | <http://purl.obolibrary.org/obo/DOID_162>, <http://purl.obolibrary.org/obo/DOID_9256> | cancer, colorectal cancer |
| SRS477159 | DOID\_162, DOID\_9256 | cancer, colorectal cancer | <http://purl.obolibrary.org/obo/DOID_162>, <http://purl.obolibrary.org/obo/DOID_9256> | cancer, colorectal cancer |
| SRS477161 | DOID\_162, DOID\_9256 | cancer, colorectal cancer | <http://purl.obolibrary.org/obo/DOID_162>, <http://purl.obolibrary.org/obo/DOID_9256> | cancer, colorectal cancer |
| SRS558528 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625672 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625673 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625674 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625675 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625676 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625677 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS641761 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS641769 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS646274 | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS674274 | DOID\_162, DOID\_9256 | cancer, colorectal cancer | <http://purl.obolibrary.org/obo/DOID_162>, <http://purl.obolibrary.org/obo/DOID_9256> | cancer, colorectal cancer |
| SRS674275 | DOID\_162, DOID\_9256 | cancer, colorectal cancer | <http://purl.obolibrary.org/obo/DOID_162>, <http://purl.obolibrary.org/obo/DOID_9256> | cancer, colorectal cancer |
| SRS211230 | Healthy | Healthy | Healthy | Healthy |
| SRS211238 | Healthy | Healthy | Healthy | Healthy |
| SRS211255 | Healthy | Healthy | Healthy | Healthy |
| SRS211287 | Healthy | Healthy | Healthy | Healthy |
| SRS211291 | Healthy | Healthy | Healthy | Healthy |
| SRS211350 | Healthy | Healthy | Healthy | Healthy |
| SRS295814 | Healthy | Healthy | Healthy | Healthy |
| SRS295815 | Healthy | Healthy | Healthy | Healthy |
| SRS295816 | Healthy | Healthy | Healthy | Healthy |
| SRS365708 | Healthy | Healthy | Healthy | Healthy |
| SRS494661 | Healthy | Healthy | Healthy | Healthy |

The method `mergeonassis` can be used to combine two Onassis objects in which the same set of samples was annotated with two different ontologies. This is useful to perform a nested analysis driven by the annotation provided by the two ontologies. The first object associates the samples metadata to semantic sets from a primary domain of interest. For each semantic set, the associated samples will be further separated based on the semantic sets belonging to a secondary domain. For example, users could be interested in comparing different diseases (secondary domain) within each cell type (primary domain), for a set of cell type.

```
cell_disease_onassis <- mergeonassis(collapsed_cells, disease_annotations)
```

The following table shows merged entities:

Table 10:  Cell and disease entities

| sample\_id | term\_id\_1 | term\_name\_1 | term\_url\_1 | short\_label\_1 | matched\_sentence\_1 | term\_id\_2 | term\_name\_2 | term\_url\_2 | matched\_sentence\_2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SRS174052 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland [3] (3) | cell, Prostate | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS174053 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland [3] (3) | cell, Prostate | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS192719 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, breast | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS211217 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | mesoderm [9], mesodermal cell [9], B cell [2] (9) | cell, mesoderm || cell, mesoderm | NA | NA | NA | NA |
| SRS211230 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast of lung [5] (5) | cell, lung fibroblasts | Healthy | Healthy | Healthy | Healthy |
| SRS211238 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, mammary epithelial cells | Healthy | Healthy | Healthy | Healthy |
| SRS211244 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | mesoderm [9], mesodermal cell [9], B cell [2] (9) | cell, mesoderm || cell, mesoderm | NA | NA | NA | NA |
| SRS211255 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | mesoderm [9], mesodermal cell [9], B cell [2] (9) | cell, mesoderm, B-lymphocyte, lymphocyte, mesoderm | Healthy | Healthy | Healthy | Healthy |
| SRS211287 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | mesoderm [9], mesodermal cell [9], B cell [2] (9) | cell, mesoderm, mesoderm | Healthy | Healthy | Healthy | Healthy |
| SRS211291 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, mammary epithelial cells | Healthy | Healthy | Healthy | Healthy |
| SRS211317 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | mesoderm [9], mesodermal cell [9], B cell [2] (9) | cell, mesoderm || cell, mesoderm | NA | NA | NA | NA |
| SRS211334 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | mesoderm [9], mesodermal cell [9], B cell [2] (9) | cell, mesoderm || cell, mesoderm | NA | NA | NA | NA |
| SRS211349 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | mesoderm [9], mesodermal cell [9], B cell [2] (9) | cell, mesoderm || cell, mesoderm | NA | NA | NA | NA |
| SRS211350 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | mesoderm [9], mesodermal cell [9], B cell [2] (9) | cell, mesoderm, B-lymphocyte, lymphocyte, mesoderm | Healthy | Healthy | Healthy | Healthy |
| SRS211356 | CL\_0000222, UBERON\_0000926, CL\_0000236, CL\_0000542 | mesoderm, mesodermal cell, B cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000222>, <http://purl.obolibrary.org/obo/UBERON_0000926>, <http://purl.obolibrary.org/obo/CL_0000236>, <http://purl.obolibrary.org/obo/CL_0000542> | mesoderm [9], mesodermal cell [9], B cell [2] (9) | cell, mesoderm, mesoderm | NA | NA | NA | NA |
| SRS295810 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | colon epithelial cell [10] (10) | cell, Colon | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | Cancer |
| SRS295811 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | colon epithelial cell [10] (10) | cell, Colon | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | Cancer |
| SRS295812 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | colon epithelial cell [10] (10) | cell, Colon | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | Cancer |
| SRS295813 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | colon epithelial cell [10] (10) | cell, Colon | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | Cancer |
| SRS295814 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | colon epithelial cell [10] (10) | cell, Colon | Healthy | Healthy | Healthy | Healthy |
| SRS295815 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | colon epithelial cell [10] (10) | cell, Colon | Healthy | Healthy | Healthy | Healthy |
| SRS295816 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | colon epithelial cell [10] (10) | cell, Colon | Healthy | Healthy | Healthy | Healthy |
| SRS344610 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, mammary gland, gland | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS345459 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, breast | NA | NA | NA | NA |
| SRS365708 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast [4], fibroblast of lung [4] (4) | cell, fibroblast, lung fibroblast | Healthy | Healthy | Healthy | Healthy |
| SRS381055 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast [4], fibroblast of lung [4] (4) | fibroblast, lung fibroblast | NA | NA | NA | NA |
| SRS381056 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast [4], fibroblast of lung [4] (4) | fibroblast, lung fibroblast | NA | NA | NA | NA |
| SRS435929 | CL\_0000057, CL\_0002553 | fibroblast, fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0000057>, <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast [4], fibroblast of lung [4] (4) | fibroblast, lung fibroblast | NA | NA | NA | NA |
| SRS494677 | CL\_0000084, CL\_0000542 | T cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000084>, <http://purl.obolibrary.org/obo/CL_0000542> | T cell [3], lymphocyte [3] (3) | cell, T lymphocyte, lymphocyte | DOID\_0060058 | lymphoma | <http://purl.obolibrary.org/obo/DOID_0060058> | lymphoma |
| SRS494678 | CL\_0000084, CL\_0000542 | T cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000084>, <http://purl.obolibrary.org/obo/CL_0000542> | T cell [3], lymphocyte [3] (3) | cell, T lymphocyte, lymphocyte | DOID\_0060058 | lymphoma | <http://purl.obolibrary.org/obo/DOID_0060058> | lymphoma |
| SRS494679 | CL\_0000084, CL\_0000542 | T cell, lymphocyte | <http://purl.obolibrary.org/obo/CL_0000084>, <http://purl.obolibrary.org/obo/CL_0000542> | T cell [3], lymphocyte [3] (3) | cell, T lymphocyte, lymphocyte | DOID\_0060058 | lymphoma | <http://purl.obolibrary.org/obo/DOID_0060058> | lymphoma |
| SRS542924 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | T cell [4] (4) | cell, T-cell | NA | NA | NA | NA |
| SRS542930 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | T cell [4] (4) | cell, T-cell | NA | NA | NA | NA |
| SRS542938 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | T cell [4] (4) | cell, T-cell | NA | NA | NA | NA |
| SRS542944 | CL\_0000084 | T cell | <http://purl.obolibrary.org/obo/CL_0000084> | T cell [4] (4) | cell, T-cell | NA | NA | NA | NA |
| SRS558528 | UBERON\_0002367 | prostate gland | <http://purl.obolibrary.org/obo/UBERON_0002367> | prostate gland [3] (3) | cell, prostate | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS580028 | CL\_0000236 | B cell | <http://purl.obolibrary.org/obo/CL_0000236> | B cell [1] (1) | cell, B-cell | NA | NA | NA | NA |
| SRS625672 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, breast | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625673 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, breast | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625674 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, breast | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625675 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, breast | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625676 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, breast | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS625677 | UBERON\_0000310, CL\_0002327, UBERON\_0001911, UBERON\_0002530 | breast, mammary gland epithelial cell, gland, mammary gland | <http://purl.obolibrary.org/obo/UBERON_0000310>, <http://purl.obolibrary.org/obo/CL_0002327>, <http://purl.obolibrary.org/obo/UBERON_0001911>, <http://purl.obolibrary.org/obo/UBERON_0002530> | breast [8], mammary gland epithelial cell [2], gland [1] (11) | cell, breast | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS641761 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | colon epithelial cell [10] (10) | cell, colon | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS641769 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | colon epithelial cell [10] (10) | cell, colon | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS645145 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast of lung [5] (5) | cell, lung fibroblasts | NA | NA | NA | NA |
| SRS645146 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast of lung [5] (5) | cell, lung fibroblasts | NA | NA | NA | NA |
| SRS646274 | CL\_0011108 | colon epithelial cell | <http://purl.obolibrary.org/obo/CL_0011108> | colon epithelial cell [10] (10) | cell, colon | DOID\_162 | cancer | <http://purl.obolibrary.org/obo/DOID_162> | cancer |
| SRS664752 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast of lung [5] (5) | cell, Lung Fibroblasts | NA | NA | NA | NA |
| SRS664753 | CL\_0002553 | fibroblast of lung | <http://purl.obolibrary.org/obo/CL_0002553> | fibroblast of lung [5] (5) | cell, Lung Fibroblasts | NA | NA | NA | NA |
| SRS916587 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell [10] (10) | cell, epithelial cell, tissue | NA | NA | NA | NA |
| SRS916588 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell [10] (10) | cell, epithelial cell, tissue | NA | NA | NA | NA |
| SRS916597 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell [10] (10) | cell, epithelial cell, tissue | NA | NA | NA | NA |
| SRS916598 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell [10] (10) | cell, epithelial cell, tissue | NA | NA | NA | NA |
| SRS916606 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell [10] (10) | cell, epithelial cell, tissue | NA | NA | NA | NA |
| SRS916607 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell [10] (10) | cell, epithelial cell, tissue | NA | NA | NA | NA |
| SRS916614 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell [10] (10) | cell, epithelial cell, tissue | NA | NA | NA | NA |
| SRS916615 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell [10] (10) | cell, epithelial cell, tissue | NA | NA | NA | NA |
| SRS916622 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell [10] (10) | cell, epithelial cell, tissue | NA | NA | NA | NA |
| SRS916623 | CL\_0000066 | epithelial cell | <http://purl.obolibrary.org/obo/CL_0000066> | epithelial cell [10] (10) | cell, epithelial cell, tissue | NA | NA | NA | NA |

## 6.4 Semantically-driven analysis of omics data

The method `compare` exploits the Onassis object to analyze the actual omics data.
To this end, a score matrix containing measurements for any arbitrary genomic unit (rows) within each sample (columns) is necessary. For example, genomics units can be genes, for expression analyses, or genomic regions (such as promoters) for enrichment analyses (such as ChIP-seq experiments).
We suggest to take advantage of data repositories where omics data were reanalyzed with standardazied analysis pipelines. This would minimize confunding issues related to the differences due to alternative analysis and normalization procedures. For example, CistromeDB provides ChIP-seq data from GEO re-analyzed with a standardized pipeline (Mei et al. 2017).
To illustrate the `compare` method, we obtained from Cistrome the genomic positions of H3K27ac peaks for the previously annotated ChIP-seq samples. Cistrome samples can be retrieved using GSMs (GEO) sample identifiers, which were matched with those reported in the SRA ChIP-seq metadata table. We precomputed a score matrix having as rows human promoter regions in chromosome 20, and as columns the sample identifiers. Each entry of the matrix contains the peak score value reported by Cistrome if there was a peak for a given promoter region in a given sample, or 0 if there was no peak overlapping that promoter region. Promoters for the human genome were obtained using the Bioconductor annotation package `TxDb.Hsapiens.UCSC.hg19.knownGene` considering 2000 bases upstream and 2000 bases downstream transcription start sites of genes. The score table can be retrieved from the vignette\_data:

```
score_matrix <- readRDS(system.file('extdata', 'vignette_data', 'score_matrix.rds', package='Onassis'))
```

The method `compare` can be used with any test function to compare scores across different semantic sets. When by = ‘col’ samples will be compared, meaning that the distribution of all the scores of the samples associated to a given semantic state will be compared with those of any other semantic state. This process will be then repeated for any pair of semantic states. Hence, test statistic and p-values are reported. In this example, these measure global differences in the distribution of H3K27ac at promoters among variuos cell types. The method returns a matrix whose each elements includes test statistic and p-value.

```
cell_comparisons_by_col <- compare(collapsed_cells, score_matrix=as.matrix(score_matrix), by='col', fun_name='wilcox.test')

matrix_of_p_values <- matrix(NA, nrow=nrow(cell_comparisons_by_col), ncol=ncol(cell_comparisons_by_col))
for(i in 1:nrow(cell_comparisons_by_col)){
    for(j in 1:nrow(cell_comparisons_by_col)){
     result_list <- cell_comparisons_by_col[i,j][[1]]
     matrix_of_p_values[i, j] <- result_list[2]
    }
}
colnames(matrix_of_p_values) <- rownames(matrix_of_p_values) <- colnames(cell_comparisons_by_col)
```

In the following heatmap -log10 p-values of the test are shown:

```
heatmap.2(-log10(matrix_of_p_values), density.info = "none", trace="none", main='Changes in\n H3K27ac signal \nin promoter regions', margins=c(36,36), cexRow = 1.5, cexCol = 1.5, keysize=1)
```

![](data:image/png;base64...)

By setting by=‘row’, we can use `compare` to test for differences for each genomic unit in the different tissue/cell type semantic sets. In this example, for each promoter, the distribution of the scores within samples associated to a given semantic state, will be compared with those of any other semantic state. This process will be then repeated for any pair of semantic states. This allows measuring differences in the distribution of H3K27ac among variuos cell types within each specific promoter. Indeed, `compare` returns a matrix whose elements are lists with genomic regions including test statistics and p-values.
After the application of the wilcoxon test we extracted for each couple of semantic sets the number of regions having a p.value <= 0.1.

```
cell_comparisons <- compare(collapsed_cells, score_matrix=as.matrix(score_matrix), by='row', fun_name='wilcox.test', fun_args=list(exact=FALSE))

# Extraction of p-values less than 0.1
significant_features <- matrix(0, nrow=nrow(cell_comparisons), ncol=ncol(cell_comparisons))
colnames(significant_features) <- rownames(significant_features) <- rownames(cell_comparisons)
for(i in 1:nrow(cell_comparisons)){
    for(j in 1:nrow(cell_comparisons)){
     result_list <- cell_comparisons[i,j][[1]]
     significant_features[i, j] <- length(which(result_list[,2]<=0.1))
    }
}
```

In the following table we report, for each pair of semantic states, the number of promoter regions with different H3K27ac binding patterns

Table 11:  Number of promoter regions with p.value <=0.1

|  | prostate gland [3] (3) | breast [8], mammary gland epithelial cell [2], gland [1] (11) | mesoderm [9], mesodermal cell [9], B cell [2] (9) | fibroblast of lung [5] (5) | colon epithelial cell [10] (10) | fibroblast [4], fibroblast of lung [4] (4) | T cell [3], lymphocyte [3] (3) | T cell [4] (4) | B cell [1] (1) | epithelial cell [10] (10) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| prostate gland [3] (3) | 0 | 78 | 89 | 75 | 46 | 30 | 82 | 36 | 0 | 135 |
| breast [8], mammary gland epithelial cell [2], gland [1] (11) | 78 | 0 | 107 | 81 | 127 | 48 | 100 | 59 | 55 | 161 |
| mesoderm [9], mesodermal cell [9], B cell [2] (9) | 89 | 107 | 0 | 32 | 118 | 35 | 100 | 54 | 32 | 91 |
| fibroblast of lung [5] (5) | 75 | 81 | 32 | 0 | 108 | 7 | 85 | 22 | 51 | 61 |
| colon epithelial cell [10] (10) | 46 | 127 | 118 | 108 | 0 | 80 | 93 | 92 | 27 | 170 |
| fibroblast [4], fibroblast of lung [4] (4) | 30 | 48 | 35 | 7 | 80 | 0 | 71 | 27 | 0 | 69 |
| T cell [3], lymphocyte [3] (3) | 82 | 100 | 100 | 85 | 93 | 71 | 0 | 61 | 0 | 143 |
| T cell [4] (4) | 36 | 59 | 54 | 22 | 92 | 27 | 61 | 0 | 0 | 118 |
| B cell [1] (1) | 0 | 55 | 32 | 51 | 27 | 0 | 0 | 0 | 0 | 50 |
| epithelial cell [10] (10) | 135 | 161 | 91 | 61 | 170 | 69 | 143 | 118 | 50 | 0 |

If annotations from two ontologies are provided, for example cell types and diseases, `compare` returns a nested analysis: the method iterates for each cell type, and performs all pair-wise comparisons (of the scores) between the diseases associated to a given cell type. Therefore, a named list with the semantic sets of the first level ontology (cell type) is returned. Each entry of the list contains a matrix with the results of the test for each pair of second level semantic sets (diseases). For example, to use a wilcoxon test to compare H3K27ac between different diseases within each tissue/cell type, promoter by promoter, the following code can be used:

```
disease_comparisons <- compare(cell_disease_onassis, score_matrix=as.matrix(score_matrix), by='row', fun_name='wilcox.test', fun_args=list(exact=FALSE))
```

To visualize the diseases associated with the tissue semantic set “breast [8], mammary gland epithelial cell [2], gland [1] (11)” the following code can be used:

```
rownames(disease_comparisons$`breast [8], mammary gland epithelial cell [2], gland [1] (11)`)
```

```
## [1] "cancer"  "Healthy"
```

To access to the test results for the the comparison of “Healthy”" with “breast cancer, cancer”

```
selprom <- (disease_comparisons$`breast [8], mammary gland epithelial cell [2], gland [1] (11)`[2,1][[1]])
selprom <- selprom[is.finite(selprom[,2]),]
head(selprom)
```

```
##                       statistic    p.value
## chr20:236377-240376          12 0.08011831
## chr20:304215-308214          12 0.08011831
## chr20:325370-329369           5 0.42188125
## chr20:359308-363307           7 0.80258735
## chr20:359941-363940           7 0.80258735
## chr20:2841102-2845101        12 0.08011831
```

To determine the number of promoter regions having p.value <= 0.1 within each comparison

```
disease_matrix <- disease_comparisons[[1]]

# Extracting significant p-values
significant_features <- matrix(0, nrow=nrow(disease_matrix), ncol=ncol(disease_matrix))
colnames(significant_features) <- rownames(significant_features) <- rownames(disease_matrix)
for(i in 1:nrow(disease_matrix)){
    for(j in 1:nrow(disease_matrix)){
     result_list <- disease_matrix[i,j][[1]]
     significant_features[i, j] <- length(which(result_list[,2]<=0.1))
    }
}
```

Table 12:  Number of promoter regions with p.value <= 0.1

|  | cancer | Healthy |
| --- | --- | --- |
| cancer | 0 | 49 |
| Healthy | 49 | 0 |

Noteworthy, 5 of the 19 promoters that were differential for H3K27ac in breast cancer, refer to genes found to be important in that disease (according to GeneCards). In particular, these include CDC25B, which was recently identifed as therapeutic target for triple-negative breast cancer (Liu et al. 2018).

Alternatively, when not available within R libraries, personalized test functions can be applied. The code below for example implements a function named signal to noise statistic that could be applied as an alternative to the wilcoxon test.

```
personal_t <- function(x, y){
        if(is.matrix(x))
            x <- apply(x, 1, mean)
        if(is.matrix(y))
            y <- apply(y, 1, mean)
        signal_to_noise_statistic <- abs(mean(x) - mean(y)) / (sd(x) + sd(y))
        return(list(statistic=signal_to_noise_statistic, p.value=NA))
}

disease_comparisons <- compare(cell_disease_onassis, score_matrix=as.matrix(score_matrix), by='col', fun_name='personal_t')
```

Further details and examples about `compare` are available in the help page of the method.

# 7 Performances of the tool

In this section we provide a table with details on the performance of Onassis in running the annotation, semantic similarity, and data integrative analysis tasks. Different input sizes and dictionary sizes were tested and run time and memory footprint are reported. Tests were run on a desktop computer having a 3,5 GHz Intel Core i7 processor and 24 GB RAM. The table reports the name of the function, the elapsed time in seconds as reported by the R system.time function, the size of the object in bytes as reported by object\_size function, a description and the used code. We additionaly report the performances of the queries to SRA used to obtain the ChIP-seq dataset used in the vignette.

Table 13:  Onassis performances

| Tested\_fun | Elasped time (seconds) | Object\_size | Details | Ref Code (don’t run) |
| --- | --- | --- | --- | --- |
| experiment\_types | 3.640 | 2.78 kB | Retrieving the experiment types available in GEO | experiments <- experiment\_types(geo\_con) |
| organism\_types | 111.629 | 305Kb | Retrieval of organisms available in GEO | species <- organism\_types(geo\_con) |
| getGEOMetadata | 91.83 | 49.4 MB | Retrieval of microarray experiments by platform identifier | expression <- getGEOMetadata(geo\_con, experiment\_type=‘Expression profiling by array’, gpl=‘GPL570’) |
| getGEOmetadata | 142.533 | 3.31 MB | Retrieval of Methylation data by experiment type | meth\_metadata <- getGEOMetadata(geo\_con, experiment\_type=‘Methylation profiling by high throughput sequencing’, organism = ‘Homo sapiens’) |
| dbGetQuery | 29.665 | 11.1 MB | Query to SRA sample table to obtain Homo sapiens samples from GEO database. This is not dependent on Onassis | samples\_df <- dbGetQuery(sra\_con, samples\_query) |
| dbGetQuery | 18.436 | 21.9 MB real object/ 538 Kb sample object | Query to SRA experiment table to obtain ChIP-seq experiments. The resulting sra\_chip\_seq in Onassis is a sample of the initial table containing only 500 samples instead of ~10000. This is not dependent on Onassis | experiment\_df <- dbGetQuery(sra\_con, experiment\_query) |
| CMdictionary | 0.798 | 2.88 kb | Conversion of sample cell line and tissue obo file to Conceptmapper XML dictionary. The dictionary contains only 55 concepts. | obo <- system.file(‘extdata’, ‘sample.cs.obo’, package=‘OnassisJavaLibs’) sample\_dict <- CMdictionary(inputFileOrDb=obo, outputDir=getwd(), synonymType=‘ALL’) |
| CMdictionary | 84.097 | 2.88 kB | Converting the CL dictionary (versione merged with UBERON) obtained from <http://www.obofoundry.org/> in owl format to Conceptmapper XML dictionary. | obo2 <- clo\_merged.owl sample\_dict2 <- CMdictionary(inputFileOrDb=obo2, outputDir=getwd(), synonymType=‘ALL’) |
| CMdictionary | 99.051 | 3.03 kB | Creation of a dictionary for ChIP-seq targets with human gene symbols and histone modifications. The returned object refers to an XML fil with ~60000 gene symbols occupying 4.6 MB in the file system | targets <- CMdictionary(dictType=‘TARGET’, inputFileOrDb = ‘org.Hs.eg.db’) |
| EntityFinder | 0.321 | 16.1 kB | Annotation of 20 samples metadata with a dictionary containing 55 concepts | chipseq\_dict\_annot <- EntityFinder(sra\_chip\_seq[1:20,c(‘sample\_accession’, ‘title’, ‘experiment\_attribute’, ‘sample\_attribute’, ‘description’)], dictionary=sample\_dict, options=myopts) |
| EntityFinder | 1.453 | 196 kB | Annotation of 500 samples metadata with a dictionary containing 55 concepts | chipseq\_dict\_annot <- EntityFinder(sra\_chip\_seq[,c(‘sample\_accession’, ‘title’, ‘experiment\_attribute’, ‘sample\_attribute’, ‘description’)], dictionary=sample\_dict2, options=myopts) |
| EntityFinder | 26.423 | 3.53 MB | Annotation of 9824 samples with a dictionary containing 55 concepts | chipseq\_dict\_annot <- EntityFinder(sra\_chip\_seq[,c(‘sample\_accession’, ‘title’, ‘experiment\_attribute’, ‘sample\_attribute’, ‘description’)], dictionary=sample\_dict, options=myopts) |
| EntityFinder | 0.996 | 18.7 kB | Annotation of 20 samples metadata with a dictionary containing ~60000 gene symbols | target\_entities <- EntityFinder(input=sra\_chip\_seq[1:20,c(‘sample\_accession’, ‘title’, ‘experiment\_attribute’, ‘sample\_attribute’, ‘description’)], options = myopts, dictionary=targets) |
| EntityFinder | 1.957 | 69.8 kB | Annotation of 500 samples metadata with a dictionary containing ~60000 gene symbols | target\_entities <- EntityFinder(input=sra\_chip\_seq[,c(‘sample\_accession’, ‘title’, ‘experiment\_attribute’, ‘sample\_attribute’, ‘description’)], options = myopts, dictionary=targets) |
| EntityFinder | 15.372 | 1.35 MB | Annotation of 9824 samples metadata with a dictionary containing ~60000 gene symbols | target\_entities <- EntityFinder(input=sra\_chip\_seq[,c(‘sample\_accession’, ‘title’, ‘experiment\_attribute’, ‘sample\_attribute’, ‘description’)], options = myopts, dictionary=targets) |
| Similarity | 54.189 | 21.9 kB | Computation of the paiwise semantic similarities between 24 concepts couples (for a total of 276 combinations) belonging to a dictionary containing 55 concepts | for(i in 1:nrow(pairwise\_results)){ pairwise\_results[i, 3] <- Similarity(obo, pairwise\_results[i,1], pairwise\_results[i, 2]) } |
| Similarity | 0.109 | 56 B | Computation of similarity between two groups of concepts | oboprefix <- ‘<http://purl.obolibrary.org/obo/>’ Similarity(obo, paste0(oboprefix, c(‘CL\_0000055’, ‘CL\_0000066’)) , paste0(oboprefix, c(‘CL\_0000542’, ‘CL\_0000236’))) |
| Similarity | 14024.556 (3h 53min) | 1.84 MB | Computation of semantic similarity between 469 annotated samples (with 109747 possible couples) | annotated\_samples <- as.character(as.vector(unique(chipseq\_dict\_annot$sample\_id))) similarity\_results <- apply(samples\_couples, 1, function(couple\_of\_samples){ Similarity(obo, couple\_of\_samples[1], couple\_of\_samples[2], chipseq\_dict\_annot) }) |
| annotate | 1.605 | 43.6 | Using annotate of the class Onassis to annotate 338 samples with concepts from a dictionary of size 55 | cell\_annotations <- annotate(h3k27ac\_chip, ‘OBO’, obo, FindAllMatches=‘YES’) |
| sim | 4.246 | 15.9 kB | Computing the similarities of an Onassis object between 13 semantic sets | filtered\_cells <- sim(filtered\_cells) |
| collapse | 3.314 | 727 kB | Cutting of the hierarchical tree obtained by applying hierarchical clustering to the similarity matrix of an Onassis object and recomputing the similarity between unified clusters of semantic sets | collapsed\_cells <- Onassis::collapse(filtered\_cells, 0.9) |
| annotate | 0.847 | 11 kB | Annotating 339 samples mtadata with a dictionary containing 23 terms | disease\_annotations <- annotate(h3k27ac\_chip, ‘OBO’,obo2, disease=TRUE ) |
| mergeonassis | 0.002 | 20.5 kB | Merging two objects of class Onassis | cell\_disease\_onassis <- mergeonassis(collapsed\_cells, disease\_annotations) |
| compare | 3.668 | 37.7 kB | Comparison of data from 60 samples annotated within 10 semantic sets by using Wilcox test on columns | cell\_comparisons\_by\_col <- compare(collapsed\_cells, score\_matrix=as.matrix(score\_matrix), by=‘col’, fun\_name=‘wilcox.test’) |
| compare | 25.956 | 1.1 MB | Comparison of data from 60 samples annotated within 10 semantic sets by using Wilcoxon.test on rows | cell\_comparisons <- compare(collapsed\_cells, score\_matrix=as.matrix(score\_matrix), by=‘row’, fun\_name=‘wilcox.test’, fun\_args=list(exact=FALSE)) |
| compare | 4.295 | 235 kB | Comparison of diseases within tissue semantic sets using Wilcox.test on rows of the subsets of the score matrix | disease\_comparisons <- compare(cell\_disease\_onassis, score\_matrix=as.matrix(score\_matrix), by=‘row’, fun\_name=‘wilcox.test’, fun\_args=list(exact=FALSE)) |

# 8 Session Info

Here is the output of sessionInfo() on the system on which this document was compiled through kintr:

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8          LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8           LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8       LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8          LC_NAME=en_US.UTF-8
##  [9] LC_ADDRESS=en_US.UTF-8        LC_TELEPHONE=en_US.UTF-8
## [11] LC_MEASUREMENT=en_US.UTF-8    LC_IDENTIFICATION=en_US.UTF-8
##
## attached base packages:
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] kableExtra_0.9.0      org.Hs.eg.db_3.7.0    AnnotationDbi_1.44.0
##  [4] IRanges_2.16.0        S4Vectors_0.20.1      Biobase_2.42.0
##  [7] BiocGenerics_0.28.0   gplots_3.0.1          DT_0.5
## [10] Onassis_1.4.5         OnassisJavaLibs_1.4.2 rJava_0.9-10
## [13] BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.0         tidyr_0.8.2        gtools_3.8.1
##  [4] assertthat_0.2.0   rprojroot_1.3-2    digest_0.6.18
##  [7] R6_2.3.0           backports_1.1.2    RSQLite_2.1.1
## [10] evaluate_0.12      highr_0.7          httr_1.3.1
## [13] pillar_1.3.0       rlang_0.3.0.1      rstudioapi_0.8
## [16] data.table_1.11.8  gdata_2.18.0       blob_1.1.1
## [19] rmarkdown_1.10     readr_1.2.1        stringr_1.3.1
## [22] htmlwidgets_1.3    RCurl_1.95-4.11    bit_1.1-14
## [25] munsell_0.5.0      compiler_3.5.1     xfun_0.4
## [28] pkgconfig_2.0.2    htmltools_0.3.6    tidyselect_0.2.5
## [31] tibble_1.4.2       GEOquery_2.50.0    bookdown_0.7
## [34] viridisLite_0.3.0  crayon_1.3.4       dplyr_0.7.8
## [37] bitops_1.0-6       DBI_1.0.0          magrittr_1.5
## [40] scales_1.0.0       KernSmooth_2.23-15 stringi_1.2.4
## [43] bindrcpp_0.2.2     limma_3.38.2       xml2_1.2.0
## [46] tools_3.5.1        bit64_0.9-7        glue_1.3.0
## [49] purrr_0.2.5        hms_0.4.2          yaml_2.2.0
## [52] colorspace_1.3-2   BiocManager_1.30.4 caTools_1.17.1.1
## [55] rvest_0.3.2        memoise_1.1.0      GEOmetadb_1.44.0
## [58] knitr_1.20         bindr_0.1.1
```

# References

Galeota, Eugenia, and Mattia Pelizzola. 2016. “Ontology-Based Annotations and Semantic Relations in Large-Scale (Epi) Genomics Data.” *Briefings in Bioinformatics*. Oxford Univ Press, bbw036.

Harispe, Sébastien, Sylvie Ranwez, Stefan Janaqi, and Jacky Montmain. 2014. “The Semantic Measures Library and Toolkit: Fast Computation of Semantic Similarity and Relatedness Using Biomedical Ontologies.” *Bioinformatics* 30 (5). Oxford Univ Press:740–42.

Liu, Jeff C., Letizia Granieri, Mariusz Shrestha, Dong-Yu Wang, Ioulia Vorobieva, Elizabeth A. Rubie, Rob Jones, et al. 2018. “Identification of Cdc25 as a Common Therapeutic Target for Triple-Negative Breast Cancer.” *Cell Reports* 23 (1):112–26. [https://doi.org/https://doi.org/10.1016/j.celrep.2018.03.039](https://doi.org/https%3A//doi.org/10.1016/j.celrep.2018.03.039).

Mei, Shenglin, Qian Qin, Qiu Wu, Hanfei Sun, Rongbin Zheng, Chongzhi Zang, Muyuan Zhu, et al. 2017. “Cistrome Data Browser: A Data Portal for Chip-Seq and Chromatin Accessibility Data in Human and Mouse.” *Nucleic Acids Research* 45 (D1):D658–D662. <https://doi.org/10.1093/nar/gkw983>.

Verspoor, K., W. Baumgartner Jr, C. Roeder, and L. Hunter. 2009. “Abstracting the Types away from a UIMA Type System.” *From Form to Meaning: Processing Texts Automatically. Tübingen:Narr*, 249–56.

Zhu, Yuelin, Robert M. Stephens, Paul S. Meltzer, and Sean R. Davis. 2013. “SRAdb: Query and Use Public Next-Generation Sequencing Data from Within R.” *BMC Bioinformatics* 14 (1):19. <https://doi.org/10.1186/1471-2105-14-19>.