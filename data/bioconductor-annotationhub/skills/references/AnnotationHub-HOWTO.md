# AnnotationHub How-To’s

#### 29 October 2025

# Contents

* [1 Accessing Genome-Scale Data](#accessing-genome-scale-data)
  + [1.1 Non-model organism gene annotations](#non-model-organism-gene-annotations)
  + [1.2 Roadmap Epigenomics Project](#roadmap-epigenomics-project)
  + [1.3 Ensembl GTF and FASTA files for TxDb gene models and sequence queries](#ensembl-gtf-and-fasta-files-for-txdb-gene-models-and-sequence-queries)
  + [1.4 liftOver to map between genome builds](#liftover-to-map-between-genome-builds)
  + [1.5 Working with dbSNP Variants](#working-with-dbsnp-variants)
* [2 sessionInfo](#sessioninfo)

**Package**: *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)*
**Authors**: Bioconductor Package Maintainer [cre],
Martin Morgan [aut],
Marc Carlson [ctb],
Dan Tenenbaum [ctb],
Sonali Arora [ctb],
Valerie Oberchain [ctb],
Kayla Morrell [ctb],
Lori Shepherd [aut]
**Modified**: Mon March 18 2024
**Compiled**: Wed Oct 29 22:30:39 2025

# 1 Accessing Genome-Scale Data

## 1.1 Non-model organism gene annotations

*Bioconductor* offers pre-built `org.*` annotation packages for model
organisms, with their use described in the
[OrgDb](http://bioconductor.org/help/workflows/annotation/Annotation_Resources/#OrgDb)
section of the Annotation work flow. Here we discover available `OrgDb`
objects for less-model organisms

```
library(AnnotationHub)
ah <- AnnotationHub()
query(ah, "OrgDb")
```

```
## AnnotationHub with 1977 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/, NCBI, ICAR-IARI, New Delhi
## # $species: Escherichia coli, Coffea arabica, greater Indian_fruit_bat, Zophobas morio, Zophobas...
## # $rdataclass: OrgDb, TxDb
## # additional mcols(): taxonomyid, genome, description, coordinate_1_based, maintainer,
## #   rdatadateadded, preparerclass, tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH111588"]]'
##
##              title
##   AH111588 | OrgDb Sqlite file for Coffea arabica
##   AH119520 | org.Ag.eg.db.sqlite
##   AH119521 | org.At.tair.db.sqlite
##   AH119522 | org.Bt.eg.db.sqlite
##   AH119523 | org.Cf.eg.db.sqlite
##   ...        ...
##   AH121493 | org.Chlamydomonas_reinhardtii.eg.sqlite
##   AH121494 | org.Chlamydomonas_smithii.eg.sqlite
##   AH121495 | org.Puccinia_striiformis_f._sp._tritici.eg.sqlite
##   AH121496 | org.Colius_striatus.eg.sqlite
##   AH121717 | org.Hbacteriophora.eg.db
```

```
orgdb <- query(ah, c("OrgDb", "maintainer@bioconductor.org"))[[1]]
```

```
## loading from cache
```

The object returned by AnnotationHub is directly usable with the
`select()` interface, e.g., to discover the available keytypes for
querying the object, the columns that these keytypes can map to, and
finally selecting the SYMBOL and GENENAME corresponding to the first 6
ENTREZIDs

```
library(AnnotationDbi)
AnnotationDbi::keytypes(orgdb)
```

```
##  [1] "ACCNUM"       "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS" "ENTREZID"     "ENZYME"
##  [7] "EVIDENCE"     "EVIDENCEALL"  "GENENAME"     "GO"           "GOALL"        "ONTOLOGY"
## [13] "ONTOLOGYALL"  "PATH"         "PMID"         "REFSEQ"       "SYMBOL"       "UNIPROT"
```

```
AnnotationDbi::columns(orgdb)
```

```
##  [1] "ACCNUM"       "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS" "ENTREZID"     "ENZYME"
##  [7] "EVIDENCE"     "EVIDENCEALL"  "GENENAME"     "GO"           "GOALL"        "ONTOLOGY"
## [13] "ONTOLOGYALL"  "PATH"         "PMID"         "REFSEQ"       "SYMBOL"       "UNIPROT"
```

```
egid <- head(keys(orgdb, "ENTREZID"))
AnnotationDbi::select(orgdb, egid, c("SYMBOL", "GENENAME"), "ENTREZID")
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##   ENTREZID     SYMBOL                                    GENENAME
## 1  1267439 LOC1267439                  uncharacterized LOC1267439
## 2  1267440 LOC1267440                                  histone H4
## 3  1267450 LOC1267450                     zinc finger protein 418
## 4  1267513      Fbxl7     F-box and leucine-rich repeat protein 7
## 5  1267546    Dbp21E2 putative ATP-dependent RNA helicase Dbp21E2
## 6  1267549 LOC1267549                                     astacin
```

## 1.2 Roadmap Epigenomics Project

All Roadmap Epigenomics files are hosted
[here](http://egg2.wustl.edu/roadmap/data/byFileType/). If one had to
download these files on their own, one would navigate through the web
interface to find useful files, then use something like the following
*R* code.

```
url <- "http://egg2.wustl.edu/roadmap/data/byFileType/peaks/consolidated/broadPeak/E001-H3K4me1.broadPeak.gz"
filename <-  basename(url)
download.file(url, destfile=filename)
if (file.exists(filename))
   data <- import(filename, format="bed")
```

This would have to be repeated for all files, and the onus would lie
on the user to identify, download, import, and manage the local disk
location of these files.

*[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* reduces this task to just a few lines of *R* code

```
library(AnnotationHub)
ah = AnnotationHub()
epiFiles <- query(ah, "EpigenomeRoadMap")
```

A look at the value returned by `epiFiles` shows us that
18250 roadmap resources are available via
*[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)*. Additional information about
the files is also available, e.g., where the files came from
(dataprovider), genome, species, sourceurl, sourcetypes.

```
epiFiles
```

```
## AnnotationHub with 18250 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: BroadInstitute, NA
## # $species: Homo sapiens
## # $rdataclass: BigWigFile, GRanges, data.frame
## # additional mcols(): taxonomyid, genome, description, coordinate_1_based, maintainer,
## #   rdatadateadded, preparerclass, tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH28856"]]'
##
##              title
##   AH28856  | E001-H3K4me1.broadPeak.gz
##   AH28857  | E001-H3K4me3.broadPeak.gz
##   AH28858  | E001-H3K9ac.broadPeak.gz
##   AH28859  | E001-H3K9me3.broadPeak.gz
##   AH28860  | E001-H3K27me3.broadPeak.gz
##   ...        ...
##   AH49542  | E061_mCRF_FractionalMethylation.bigwig
##   AH49543  | E081_mCRF_FractionalMethylation.bigwig
##   AH49544  | E082_mCRF_FractionalMethylation.bigwig
##   AH116724 | TENET_consensus_enhancer_regions
##   AH116726 | TENET_consensus_promoter_regions
```

A good sanity check to ensure that we have files only from the Roadmap Epigenomics
project is to check that all the files in the returned smaller hub object
come from *Homo sapiens* and the hg19, hg38 genome

```
unique(epiFiles$species)
```

```
## [1] "Homo sapiens"
```

```
unique(epiFiles$genome)
```

```
## [1] "hg19" "hg38"
```

Broadly, one can get an idea of the different files from this project
looking at the sourcetype

```
table(epiFiles$sourcetype)
```

```
##
##      BED   BigWig      GTF Multiple      Zip      tab
##     8298     9932        3        2       14        1
```

To get a more descriptive idea of these different files one can use:

```
sort(table(epiFiles$description), decreasing=TRUE)
```

```
##
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Bigwig File containing -log10(p-value) signal tracks from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          6881
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Bigwig File containing fold enrichment signal tracks from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          2947
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Narrow ChIP-seq peaks for consolidated epigenomes from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          2894
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                Broad ChIP-seq peaks for consolidated epigenomes from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          2534
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Gapped ChIP-seq peaks for consolidated epigenomes from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          2534
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   Narrow DNasePeaks for consolidated epigenomes from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           131
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                15 state chromatin segmentations from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           127
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Broad domains on enrichment for DNase-seq for consolidated epigenomes from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            78
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              RRBS fractional methylation calls from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            51
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Whole genome bisulphite fractional methylation calls from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            37
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    MeDIP/MRE(mCRF) fractional methylation calls from EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            16
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      GencodeV10 gene/transcript coordinates and annotations corresponding to hg19 version of the human genome
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             3
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            RNA-seq read count matrix for intronic protein-coding RNA elements
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             2
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           RNA-seq read counts matrix for ribosomal gene exons
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             2
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               RPKM expression matrix for ribosomal gene exons
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             2
## A composite GRanges object containing regions of putative enhancer elements from a variety of sources, primarily for use in the TENET Bioconductor package. This dataset is composed of regions of strong enhancers as annotated by the Roadmap Epigenomics ChromHMM expanded 18-state model based on 98 reference epigenomes, lifted over to the hg38 genome, as well as regions of human permissive enhancers identified by the FANTOM5 project. For additional information on component datasets, see the manifest file hosted at https://github.com/rhielab/TENET.AnnotationHub/blob/devel/data-raw/TENET_consensus_datasets_manifest.tsv
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
##                                                                      A composite GRanges object containing regions of putative promoter elements from a variety of sources, primarily for use in the TENET Bioconductor package. This dataset is composed of regions flanking transcription start sites as annotated by the Roadmap Epigenomics ChromHMM expanded 18-state model based on 98 reference epigenomes, lifted over to the hg38 genome. For additional information on component datasets, see the manifest file hosted at https://github.com/rhielab/TENET.AnnotationHub/blob/devel/data-raw/TENET_consensus_datasets_manifest.tsv
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Metadata for EpigenomeRoadMap Project
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                RNA-seq read counts matrix for non-coding RNAs
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           RNA-seq read counts matrix for protein coding exons
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           RNA-seq read counts matrix for protein coding genes
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                RNA-seq read counts matrix for ribosomal genes
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    RPKM expression matrix for non-coding RNAs
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               RPKM expression matrix for protein coding exons
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               RPKM expression matrix for protein coding genes
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     RPKM expression matrix for ribosomal RNAs
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             1
```

The ‘metadata’ provided by the Roadmap Epigenomics Project is also
available. Note that the information displayed about a hub with a
single resource is quite different from the information displayed when
the hub references more than one resource.

```
metadata.tab <- query(ah , c("EpigenomeRoadMap", "Metadata"))
metadata.tab
```

```
## AnnotationHub with 1 record
## # snapshotDate(): 2025-10-28
## # names(): AH41830
## # $dataprovider: BroadInstitute
## # $species: Homo sapiens
## # $rdataclass: data.frame
## # $rdatadateadded: 2015-05-11
## # $title: EID_metadata.tab
## # $description: Metadata for EpigenomeRoadMap Project
## # $taxonomyid: 9606
## # $genome: hg19
## # $sourcetype: tab
## # $sourceurl: http://egg2.wustl.edu/roadmap/data/byFileType/metadata/EID_metadata.tab
## # $sourcesize: 18035
## # $tags: c("EpigenomeRoadMap", "Metadata")
## # retrieve record with 'object[["AH41830"]]'
```

So far we have been exploring information about resources, without
downloading the resource to a local cache and importing it into R.
One can retrieve the resource using `[[` as indicated at the
end of the show method

```
## loading from cache
```

```
metadata.tab <- ah[["AH41830"]]
```

```
## loading from cache
```

The metadata.tab file is returned as a *data.frame*. The first 6 rows
of the first 5 columns are shown here:

```
metadata.tab[1:6, 1:5]
```

```
##    EID    GROUP   COLOR          MNEMONIC                                   STD_NAME
## 1 E001      ESC #924965            ESC.I3                                ES-I3 Cells
## 2 E002      ESC #924965           ESC.WA7                               ES-WA7 Cells
## 3 E003      ESC #924965            ESC.H1                                   H1 Cells
## 4 E004 ES-deriv #4178AE ESDR.H1.BMP4.MESO H1 BMP4 Derived Mesendoderm Cultured Cells
## 5 E005 ES-deriv #4178AE ESDR.H1.BMP4.TROP H1 BMP4 Derived Trophoblast Cultured Cells
## 6 E006 ES-deriv #4178AE       ESDR.H1.MSC          H1 Derived Mesenchymal Stem Cells
```

One can keep constructing different queries using multiple arguments to
trim down these 18250 to get the files one wants.
For example, to get the ChIP-Seq files for consolidated epigenomes,
one could use

```
bpChipEpi <- query(ah , c("EpigenomeRoadMap", "broadPeak", "chip", "consolidated"))
```

To get all the bigWig signal files, one can query the hub using

```
allBigWigFiles <- query(ah, c("EpigenomeRoadMap", "BigWig"))
```

To access the 15 state chromatin segmentations, one can use

```
seg <- query(ah, c("EpigenomeRoadMap", "segmentations"))
```

If one is interested in getting all the files related to one sample

```
E126 <- query(ah , c("EpigenomeRoadMap", "E126", "H3K4ME2"))
E126
```

```
## AnnotationHub with 6 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: BroadInstitute
## # $species: Homo sapiens
## # $rdataclass: GRanges, BigWigFile
## # additional mcols(): taxonomyid, genome, description, coordinate_1_based, maintainer,
## #   rdatadateadded, preparerclass, tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH29817"]]'
##
##             title
##   AH29817 | E126-H3K4me2.broadPeak.gz
##   AH30868 | E126-H3K4me2.narrowPeak.gz
##   AH31801 | E126-H3K4me2.gappedPeak.gz
##   AH32990 | E126-H3K4me2.fc.signal.bigwig
##   AH34022 | E126-H3K4me2.pval.signal.bigwig
##   AH40177 | E126-H3K4me2.imputed.pval.signal.bigwig
```

Hub resources can also be selected using `$`, `subset()`, and
`BiocHubsShiny()`; see the main
[*AnnotationHub* vignette](AnnotationHub.html) for additional detail.

Hub resources are imported as the appropriate *Bioconductor* object
for use in further analysis. For example, peak files are returned as
*GRanges* objects.

```
## loading from cache
```

```
## require("rtracklayer")
```

```
peaks <- E126[['AH29817']]
```

```
## loading from cache
```

```
seqinfo(peaks)
```

```
## Seqinfo object with 298 sequences (2 circular) from hg19 genome:
##   seqnames       seqlengths isCircular genome
##   chr1            249250621      FALSE   hg19
##   chr2            243199373      FALSE   hg19
##   chr3            198022430      FALSE   hg19
##   chr4            191154276      FALSE   hg19
##   chr5            180915260      FALSE   hg19
##   ...                   ...        ...    ...
##   chrUn_gl000245      36651      FALSE   hg19
##   chrUn_gl000246      38154      FALSE   hg19
##   chrUn_gl000247      36422      FALSE   hg19
##   chrUn_gl000248      39786      FALSE   hg19
##   chrUn_gl000249      38502      FALSE   hg19
```

BigWig files are returned as *BigWigFile* objects. A *BigWigFile* is a
reference to a file on disk; the data in the file can be read in using
`rtracklayer::import()`, perhaps querying these large files for
particular genomic regions of interest as described on the help page
`?import.bw`.

Each record inside *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* is associated with a
unique identifier. Most *GRanges* objects returned by
*[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* contain the unique AnnotationHub identifier of
the resource from which the *GRanges* is derived. This can come handy
when working with the *GRanges* object for a while, and additional
information about the object (e.g., the name of the file in the cache,
or the original sourceurl for the data underlying the resource) that
is being worked with.

```
metadata(peaks)
```

```
## $AnnotationHubName
## [1] "AH29817"
##
## $`File Name`
## [1] "E126-H3K4me2.broadPeak.gz"
##
## $`Data Source`
## [1] "http://egg2.wustl.edu/roadmap/data/byFileType/peaks/consolidated/broadPeak/E126-H3K4me2.broadPeak.gz"
##
## $Provider
## [1] "BroadInstitute"
##
## $Organism
## [1] "Homo sapiens"
##
## $`Taxonomy ID`
## [1] 9606
```

```
ah[metadata(peaks)$AnnotationHubName]$sourceurl
```

```
## [1] "http://egg2.wustl.edu/roadmap/data/byFileType/peaks/consolidated/broadPeak/E126-H3K4me2.broadPeak.gz"
```

## 1.3 Ensembl GTF and FASTA files for TxDb gene models and sequence queries

*Bioconductor* represents gene models using ‘transcript’
databases. These are available via packages such as
*[TxDb.Hsapiens.UCSC.hg38.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg38.knownGene)*
or can be constructed using functions such as
*[txdbmaker](https://bioconductor.org/packages/3.22/txdbmaker)*::`makeTxDbFromBiomart()`.

*AnnotationHub* provides an easy way to work with gene models
published by Ensembl. Let’s see what Ensembl’s Release-94 has in terms
of data for pufferfish, *Takifugu rubripes*.

```
query(ah, c("Takifugu", "release-94"))
```

```
## AnnotationHub with 7 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: Ensembl
## # $species: Takifugu rubripes
## # $rdataclass: TwoBitFile, GRanges
## # additional mcols(): taxonomyid, genome, description, coordinate_1_based, maintainer,
## #   rdatadateadded, preparerclass, tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH64856"]]'
##
##             title
##   AH64856 | Takifugu_rubripes.FUGU5.94.abinitio.gtf
##   AH64857 | Takifugu_rubripes.FUGU5.94.chr.gtf
##   AH64858 | Takifugu_rubripes.FUGU5.94.gtf
##   AH66114 | Takifugu_rubripes.FUGU5.cdna.all.2bit
##   AH66115 | Takifugu_rubripes.FUGU5.dna_rm.toplevel.2bit
##   AH66116 | Takifugu_rubripes.FUGU5.dna_sm.toplevel.2bit
##   AH66117 | Takifugu_rubripes.FUGU5.ncrna.2bit
```

We see that there is a GTF file descrbing gene models, as well as
various DNA sequences. Let’s retrieve the GTF and top-level DNA
sequence files. The GTF file is imported as a *GRanges* instance, the
DNA sequence as a twobit file.

```
gtf <- ah[["AH64858"]]
```

```
## loading from cache
```

```
## Importing File into R ..
```

```
dna <- ah[["AH66116"]]
```

```
## loading from cache
```

```
head(gtf, 3)
```

```
## GRanges object with 3 ranges and 22 metadata columns:
##       seqnames        ranges strand |   source       type     score     phase            gene_id
##          <Rle>     <IRanges>  <Rle> | <factor>   <factor> <numeric> <integer>        <character>
##   [1]        1 217531-252954      + |  ensembl gene              NA      <NA> ENSTRUG00000009922
##   [2]        1 217531-252954      + |  ensembl transcript        NA      <NA> ENSTRUG00000009922
##   [3]        1 217531-217702      + |  ensembl exon              NA      <NA> ENSTRUG00000009922
##       gene_version   gene_name gene_source   gene_biotype      transcript_id transcript_version
##        <character> <character> <character>    <character>        <character>        <character>
##   [1]            2       sdk2b     ensembl protein_coding               <NA>               <NA>
##   [2]            2       sdk2b     ensembl protein_coding ENSTRUT00000025027                  2
##   [3]            2       sdk2b     ensembl protein_coding ENSTRUT00000025027                  2
##       transcript_name transcript_source transcript_biotype exon_number            exon_id
##           <character>       <character>        <character> <character>        <character>
##   [1]            <NA>              <NA>               <NA>        <NA>               <NA>
##   [2]       sdk2b-201           ensembl     protein_coding        <NA>               <NA>
##   [3]       sdk2b-201           ensembl     protein_coding           1 ENSTRUE00000325931
##       exon_version  protein_id protein_version projection_parent_gene projection_parent_transcript
##        <character> <character>     <character>            <character>                  <character>
##   [1]         <NA>        <NA>            <NA>                   <NA>                         <NA>
##   [2]         <NA>        <NA>            <NA>                   <NA>                         <NA>
##   [3]            1        <NA>            <NA>                   <NA>                         <NA>
##               tag
##       <character>
##   [1]        <NA>
##   [2]        <NA>
##   [3]        <NA>
##   -------
##   seqinfo: 1627 sequences (1 circular) from FUGU5 genome; no seqlengths
```

```
dna
```

```
## TwoBitFile object
## resource: /home/biocbuild/.cache/R/AnnotationHub/3f089640f8f82c_72862
```

```
head(seqlevels(dna))
```

```
## [1] "1" "2" "3" "4" "5" "6"
```

Let’s identify the 25 longest DNA sequences, and keep just the
annotations on these scaffolds.

```
keep <- names(tail(sort(seqlengths(dna)), 25))
gtf_subset <- gtf[seqnames(gtf) %in% keep]
```

It is trivial to make a TxDb instance of this subset (or of the entire
gtf)

```
library(txdbmaker)         # for makeTxDbFromGRanges
txdb <- makeTxDbFromGRanges(gtf_subset)
```

```
## Warning in .get_cds_IDX(mcols0$type, mcols0$phase): The "phase" metadata column contains non-NA values for features of type stop_codon. This
##   information was ignored.
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information is not available for
## this TxDb object
```

and to use that in conjunction with the DNA sequences, e.g., to find
exon sequences of all annotated genes.

```
library(Rsamtools)               # for getSeq,FaFile-method
exons <- exons(txdb)
length(exons)
```

```
## [1] 178769
```

```
getSeq(dna, exons)
```

```
## DNAStringSet object of length 178769:
##          width seq
##      [1]   172 CGATACGGCGCGCTCCGTTTGCCTCCGCCCCCCCCGTGGCG...GCGTTTCTGGGCCCCGCCCCCCTCGCCTCCCTCCGTGGCAG
##      [2]    28 TTGGGATTATTCTCACACGCTGATCGGT
##      [3]   160 ACGACGTGCCCCCCTACTTCAAGACGGAGCCGGCCCGGAGC...CACAACAACACGGAGCTGACGCGCTTCTCGCTGGAGTACAG
##      [4]   107 GTACGTGATCCCGTCTTTGGACCGCTCCCACGCCGGATTCT...GGGCGCCCTGCTGCAGAGACGCACCGAAGTCCAGGTGGTCT
##      [5]   148 TTATGGGAAGCTTCGAGGAGGGCGAGCGAGCCCAGTCCGTC...TGGTACCGGGATGGACGCAAGATTCCCCCGAGCAGCCGCAT
##      ...   ... ...
## [178765]    54 ATGCCCTCAATTACACTACCGCAGAAGGAGAACGCTCTCTTCAAAAGAATATTG
## [178766]   863 CTCTTGGTGAGGGGAAGGATGAATTTATCCGATGTCCAGTG...GTGATATAAGTTTTAGGGAAGAGCCCCATAGGCTGATGTAG
## [178767]   270 TTTGTGCAATGGGTGGCACCAGCAGCACCAGCAGGTTGTTT...CCCGTCTATCCGGATCATGCAGTGGAACATACTGGCACAAG
## [178768]   982 CAGTTGTACAGAAATCGTTGGAGCAGACCTGGAGGCTGTTG...CCCGTCTATCCGGATCATGCAGTGGAACATACTGGCACAAG
## [178769]   627 GGGGGAGATTCCGATGGTGGTATATTTAAAAAGTTGAAACT...GCCAAAGTGTTCCAGTTCCACCCATCGTGGCGGCCCGCCAG
```

There is a one-to-one mapping between the genomic ranges contained in
`exons` and the DNA sequences returned by `getSeq()`.

Some difficulties arise when working with this partly assembled genome
that require more advanced GenomicRanges skills, see the
*[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* vignettes, especially “*GenomicRanges*
HOWTOs” and “An Introduction to *GenomicRanges*”.

## 1.4 liftOver to map between genome builds

Suppose we wanted to lift features from one genome build to another,
e.g., because annotations were generated for hg19 but our experimental
analysis used hg18. We know that UCSC provides ‘liftover’ files for
mapping between genome builds.

In this example, we will take our broad Peak *GRanges* from E126 which
comes from the ‘hg19’ genome, and lift over these features to their
‘hg38’ coordinates.

```
chainfiles <- query(ah , c("hg38", "hg19", "chainfile"))
chainfiles
```

```
## AnnotationHub with 4 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: UCSC, NCBI
## # $species: Homo sapiens
## # $rdataclass: ChainFile
## # additional mcols(): taxonomyid, genome, description, coordinate_1_based, maintainer,
## #   rdatadateadded, preparerclass, tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH14108"]]'
##
##             title
##   AH14108 | hg38ToHg19.over.chain.gz
##   AH14150 | hg19ToHg38.over.chain.gz
##   AH78915 | Chain file for Homo sapiens rRNA hg19 to hg38
##   AH78916 | Chain file for Homo sapiens rRNA hg38 to hg19
```

We are interested in the file that lifts over features from hg19 to
hg38 so lets download that using

```
## loading from cache
```

```
chain <- chainfiles[['AH14150']]
```

```
## loading from cache
```

```
chain
```

```
## Chain of length 25
## names(25): chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 ... chr18 chr19 chr20 chr21 chr22 chrX chrY chrM
```

Perform the liftOver operation using `rtracklayer::liftOver()`:

```
library(rtracklayer)
gr38 <- liftOver(peaks, chain)
```

This returns a *GRangeslist*; update the genome of the result to get
the final result

```
genome(gr38) <- "hg38"
gr38
```

```
## GRangesList object of length 153266:
## [[1]]
## GRanges object with 1 range and 5 metadata columns:
##       seqnames            ranges strand |        name     score signalValue    pValue    qValue
##          <Rle>         <IRanges>  <Rle> | <character> <numeric>   <numeric> <numeric> <numeric>
##   [1]     chr1 28667912-28670147      * |      Rank_1       189     10.5585   22.0132   18.9991
##   -------
##   seqinfo: 23 sequences from hg38 genome; no seqlengths
##
## [[2]]
## GRanges object with 1 range and 5 metadata columns:
##       seqnames            ranges strand |        name     score signalValue    pValue    qValue
##          <Rle>         <IRanges>  <Rle> | <character> <numeric>   <numeric> <numeric> <numeric>
##   [1]     chr4 54090990-54092984      * |      Rank_2       188     8.11483   21.8044   18.8066
##   -------
##   seqinfo: 23 sequences from hg38 genome; no seqlengths
##
## [[3]]
## GRanges object with 1 range and 5 metadata columns:
##       seqnames            ranges strand |        name     score signalValue    pValue    qValue
##          <Rle>         <IRanges>  <Rle> | <character> <numeric>   <numeric> <numeric> <numeric>
##   [1]    chr14 75293392-75296621      * |      Rank_3       180     8.89834   20.9771   18.0282
##   -------
##   seqinfo: 23 sequences from hg38 genome; no seqlengths
##
## ...
## <153263 more elements>
```

## 1.5 Working with dbSNP Variants

One may also be interested in working with common germline variants with
evidence of medical interest. This information is available at
[NCBI](https://www.ncbi.nlm.nih.gov/variation/docs/human_variation_vcf/).

Query the dbDNP files in the hub:

This returns a *VcfFile* which can be read in using `r Biocpkg("VariantAnnotation")`; because VCF files can be large, `readVcf()`
supports several strategies for importing only relevant parts of the file
(e.g., particular genomic locations, particular features of the variants), see
`?readVcf` for additional information.

```
variants <- readVcf(vcf, genome="hg19")
variants
```

```
## class: CollapsedVCF
## dim: 111138 0
## rowRanges(vcf):
##   GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER
## info(vcf):
##   DataFrame with 58 columns: RS, RSPOS, RV, VP, GENEINFO, dbSNPBuildID, SAO, SSR, WGT, VC, PM, T...
## info(header(vcf)):
##                 Number Type    Description
##    RS           1      Integer dbSNP ID (i.e. rs number)
##    RSPOS        1      Integer Chr position reported in dbSNP
##    RV           0      Flag    RS orientation is reversed
##    VP           1      String  Variation Property.  Documentation is at ftp://ftp.ncbi.nlm.nih.g...
##    GENEINFO     1      String  Pairs each of gene symbol:gene id.  The gene symbol and id are de...
##    dbSNPBuildID 1      Integer First dbSNP Build for RS
##    SAO          1      Integer Variant Allele Origin: 0 - unspecified, 1 - Germline, 2 - Somatic...
##    SSR          1      Integer Variant Suspect Reason Codes (may be more than one value added to...
##    WGT          1      Integer Weight, 00 - unmapped, 1 - weight 1, 2 - weight 2, 3 - weight 3 o...
##    VC           1      String  Variation Class
##    PM           0      Flag    Variant is Precious(Clinical,Pubmed Cited)
##    TPA          0      Flag    Provisional Third Party Annotation(TPA) (currently rs from PHARMG...
##    PMC          0      Flag    Links exist to PubMed Central article
##    S3D          0      Flag    Has 3D structure - SNP3D table
##    SLO          0      Flag    Has SubmitterLinkOut - From SNP->SubSNP->Batch.link_out
##    NSF          0      Flag    Has non-synonymous frameshift A coding region variation where one...
##    NSM          0      Flag    Has non-synonymous missense A coding region variation where one a...
##    NSN          0      Flag    Has non-synonymous nonsense A coding region variation where one a...
##    REF          0      Flag    Has reference A coding region variation where one allele in the s...
##    SYN          0      Flag    Has synonymous A coding region variation where one allele in the ...
##    U3           0      Flag    In 3' UTR Location is in an untranslated region (UTR). FxnCode = 53
##    U5           0      Flag    In 5' UTR Location is in an untranslated region (UTR). FxnCode = 55
##    ASS          0      Flag    In acceptor splice site FxnCode = 73
##    DSS          0      Flag    In donor splice-site FxnCode = 75
##    INT          0      Flag    In Intron FxnCode = 6
##    R3           0      Flag    In 3' gene region FxnCode = 13
##    R5           0      Flag    In 5' gene region FxnCode = 15
##    OTH          0      Flag    Has other variant with exactly the same set of mapped positions o...
##    CFL          0      Flag    Has Assembly conflict. This is for weight 1 and 2 variant that ma...
##    ASP          0      Flag    Is Assembly specific. This is set if the variant only maps to one...
##    MUT          0      Flag    Is mutation (journal citation, explicit fact): a low frequency va...
##    VLD          0      Flag    Is Validated.  This bit is set if the variant has 2+ minor allele...
##    G5A          0      Flag    >5% minor allele frequency in each and all populations
##    G5           0      Flag    >5% minor allele frequency in 1+ populations
##    HD           0      Flag    Marker is on high density genotyping kit (50K density or greater)...
##    GNO          0      Flag    Genotypes available. The variant has individual genotype (in SubI...
##    KGPhase1     0      Flag    1000 Genome phase 1 (incl. June Interim phase 1)
##    KGPhase3     0      Flag    1000 Genome phase 3
##    CDA          0      Flag    Variation is interrogated in a clinical diagnostic assay
##    LSD          0      Flag    Submitted from a locus-specific database
##    MTP          0      Flag    Microattribution/third-party annotation(TPA:GWAS,PAGE)
##    OM           0      Flag    Has OMIM/OMIA
##    NOC          0      Flag    Contig allele not present in variant allele list. The reference s...
##    WTD          0      Flag    Is Withdrawn by submitter If one member ss is withdrawn by submit...
##    NOV          0      Flag    Rs cluster has non-overlapping allele sets. True when rs set has ...
##    CAF          .      String  An ordered, comma delimited list of allele frequencies based on 1...
##    COMMON       1      Integer RS is a common SNP.  A common SNP is one that has at least one 10...
##    CLNHGVS      .      String  Variant names from HGVS.    The order of these variants correspon...
##    CLNALLE      .      Integer Variant alleles from REF or ALT columns.  0 is REF, 1 is the firs...
##    CLNSRC       .      String  Variant Clinical Chanels
##    CLNORIGIN    .      String  Allele Origin. One or more of the following values may be added: ...
##    CLNSRCID     .      String  Variant Clinical Channel IDs
##    CLNSIG       .      String  Variant Clinical Significance, 0 - Uncertain significance, 1 - no...
##    CLNDSDB      .      String  Variant disease database name
##    CLNDSDBID    .      String  Variant disease database ID
##    CLNDBN       .      String  Variant disease name
##    CLNREVSTAT   .      String  no_assertion - No assertion provided, no_criteria - No assertion ...
##    CLNACC       .      String  Variant Accession and Versions
## geno(vcf):
##   List of length 0:
```

`rowRanges()` returns information from the CHROM, POS and ID fields of the VCF
file, represented as a *GRanges* instance

```
rowRanges(variants)
```

```
## GRanges object with 111138 ranges and 5 metadata columns:
##               seqnames    ranges strand | paramRangeID            REF                ALT      QUAL
##                  <Rle> <IRanges>  <Rle> |     <factor> <DNAStringSet> <DNAStringSetList> <numeric>
##   rs786201005        1   1014143      * |           NA              C                  T        NA
##   rs672601345        1   1014316      * |           NA              C                 CG        NA
##   rs672601312        1   1014359      * |           NA              G                  T        NA
##   rs115173026        1   1020217      * |           NA              G                  T        NA
##   rs201073369        1   1020239      * |           NA              G                  C        NA
##           ...      ...       ...    ... .          ...            ...                ...       ...
##   rs527236200       MT     15943      * |           NA              T                  C        NA
##   rs118203890       MT     15950      * |           NA              G                  A        NA
##   rs199474700       MT     15965      * |           NA              A                  G        NA
##   rs199474701       MT     15967      * |           NA              G                  A        NA
##   rs199474699       MT     15990      * |           NA              C                  T        NA
##                    FILTER
##               <character>
##   rs786201005           .
##   rs672601345           .
##   rs672601312           .
##   rs115173026           .
##   rs201073369           .
##           ...         ...
##   rs527236200           .
##   rs118203890           .
##   rs199474700           .
##   rs199474701           .
##   rs199474699           .
##   -------
##   seqinfo: 25 sequences from hg19 genome; no seqlengths
```

Note that the broadPeaks files follow the UCSC chromosome naming convention,
and the vcf data follows the NCBI style of chromosome naming convention.
To bring these ranges in the same chromosome
naming convention (ie UCSC), we would use

```
library(GenomeInfoDb)
seqlevelsStyle(variants) <- seqlevelsStyle(peaks)
```

And then finally to find which variants overlap these broadPeaks we would use:

```
overlap <- findOverlaps(variants, peaks)
```

```
## Warning in .merge_two_Seqinfo_objects(x, y): The 2 combined objects have no sequence levels in common. (Use
##   suppressWarnings() to suppress this warning.)
```

```
overlap
```

```
## Hits object with 0 hits and 0 metadata columns:
##    queryHits subjectHits
##    <integer>   <integer>
##   -------
##   queryLength: 111138 / subjectLength: 153266
```

Some insight into how these results can be interpretted comes from
looking a particular peak, e.g., the 3852nd peak

```
idx <- subjectHits(overlap) == 3852
overlap[idx]
```

```
## Hits object with 0 hits and 0 metadata columns:
##    queryHits subjectHits
##    <integer>   <integer>
##   -------
##   queryLength: 111138 / subjectLength: 153266
```

There are three variants overlapping this peak; the coordinates of the
peak and the overlapping variants are

```
peaks[3852]
```

```
## GRanges object with 1 range and 5 metadata columns:
##       seqnames            ranges strand |        name     score signalValue    pValue    qValue
##          <Rle>         <IRanges>  <Rle> | <character> <numeric>   <numeric> <numeric> <numeric>
##   [1]    chr22 50622494-50626143      * |   Rank_3852        79     6.06768   10.1894   7.99818
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
```

```
rowRanges(variants)[queryHits(overlap[idx])]
```

```
## GRanges object with 0 ranges and 5 metadata columns:
##    seqnames    ranges strand | paramRangeID            REF                ALT      QUAL      FILTER
##       <Rle> <IRanges>  <Rle> |     <factor> <DNAStringSet> <DNAStringSetList> <numeric> <character>
##   -------
##   seqinfo: 25 sequences from hg19 genome; no seqlengths
```

# 2 sessionInfo

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] GenomeInfoDb_1.46.0               BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [3] BSgenome_1.78.0                   BiocIO_1.20.0
##  [5] rtracklayer_1.70.0                VariantAnnotation_1.56.0
##  [7] SummarizedExperiment_1.40.0       MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0                 Rsamtools_2.26.0
## [11] Biostrings_2.78.0                 XVector_0.50.0
## [13] txdbmaker_1.6.0                   GenomicFeatures_1.62.0
## [15] AnnotationDbi_1.72.0              Biobase_2.70.0
## [17] GenomicRanges_1.62.0              IRanges_2.44.0
## [19] Seqinfo_1.0.0                     S4Vectors_0.48.0
## [21] AnnotationHub_4.0.0               BiocFileCache_3.0.0
## [23] dbplyr_2.5.1                      BiocGenerics_0.56.0
## [25] generics_0.1.4                    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1         dplyr_1.1.4              blob_1.2.4
##  [4] filelock_1.0.3           bitops_1.0-9             fastmap_1.2.0
##  [7] RCurl_1.98-1.17          GenomicAlignments_1.46.0 XML_3.99-0.19
## [10] digest_0.6.37            lifecycle_1.0.4          KEGGREST_1.50.0
## [13] RSQLite_2.4.3            magrittr_2.0.4           compiler_4.5.1
## [16] rlang_1.1.6              sass_0.4.10              progress_1.2.3
## [19] tools_4.5.1              yaml_2.3.10              knitr_1.50
## [22] prettyunits_1.2.0        S4Arrays_1.10.0          bit_4.6.0
## [25] curl_7.0.0               DelayedArray_0.36.0      abind_1.4-8
## [28] BiocParallel_1.44.0      withr_3.0.2              purrr_1.1.0
## [31] grid_4.5.1               biomaRt_2.66.0           cli_3.6.5
## [34] rmarkdown_2.30           crayon_1.5.3             httr_1.4.7
## [37] rjson_0.2.23             DBI_1.2.3                cachem_1.1.0
## [40] stringr_1.5.2            parallel_4.5.1           BiocManager_1.30.26
## [43] restfulr_0.0.16          vctrs_0.6.5              Matrix_1.7-4
## [46] jsonlite_2.0.0           bookdown_0.45            hms_1.1.4
## [49] bit64_4.6.0-1            jquerylib_0.1.4          glue_1.8.0
## [52] codetools_0.2-20         stringi_1.8.7            BiocVersion_3.22.0
## [55] UCSC.utils_1.6.0         tibble_3.3.0             pillar_1.11.1
## [58] rappdirs_0.3.3           htmltools_0.5.8.1        R6_2.6.1
## [61] httr2_1.2.1              evaluate_1.0.5           lattice_0.22-7
## [64] png_0.1-8                cigarillo_1.0.0          memoise_2.0.1
## [67] bslib_0.9.0              SparseArray_1.10.0       xfun_0.53
## [70] pkgconfig_2.0.3
```