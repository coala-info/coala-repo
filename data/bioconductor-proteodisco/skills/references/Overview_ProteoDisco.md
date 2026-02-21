# Overview of Proteodisco

Job van Riet, Wesley van de Geer and Harmen van de Werken

#### 30 October 2025

#### Package

ProteoDisco 1.16.0

# Contents

* [1 Abstract](#abstract)
* [2 Standard ProteoDisco workflow.](#standard-proteodisco-workflow.)
  + [2.1 Logging parameters.](#logging-parameters.)
* [3 Step 1 - Generating the `ProteoDiscography`](#step-1---generating-the-proteodiscography)
  + [3.1 Using FASTA and GTF files.](#using-fasta-and-gtf-files.)
  + [3.2 Using pre-generated resources.](#using-pre-generated-resources.)
  + [3.3 Inspecting the initial `ProteoDiscography`.](#inspecting-the-initial-proteodiscography.)
* [4 Step 2 - Import (somatic) variants into the `ProteoDiscography`.](#step-2---import-somatic-variants-into-the-proteodiscography.)
  + [4.1 Importing SNVs/MNVs/InDels (VCF).](#importing-snvsmnvsindels-vcf.)
  + [4.2 Importing manually-curated transcript sequences from complex events.](#importing-manually-curated-transcript-sequences-from-complex-events.)
  + [4.3 Viewing all imported ProteoDiscography records](#viewing-all-imported-proteodiscography-records)
* [5 Step 3 - Incorporation of the somatic variants into (m)RNA transcripts.](#step-3---incorporation-of-the-somatic-variants-into-mrna-transcripts.)
* [6 Step 4 - Importing splicing-events to generate splicing-isoforms.](#step-4---importing-splicing-events-to-generate-splicing-isoforms.)
* [7 (Optional) Determine proteotypic peptides.](#optional-determine-proteotypic-peptides.)
* [8 (Optional) Convert TxIDs to gene symbols.](#optional-convert-txids-to-gene-symbols.)
* [9 Final step - Generate output FASTA](#final-step---generate-output-fasta)
* [10 Session Information](#session-information)

# 1 Abstract

`ProteoDisco` is an *R* package to facilitate proteogenomics studies by generating novel variant protein sequences and their proteotypic peptides, based on observed (somatic) genomic or transcriptomic variants within coding regions. The major steps of `ProteoDisco` can be summarized as:

1. **Generation or selection of the annotation database, a.k.a. the `ProteoDiscography`.**
2. **Import (somatic) variants and manual transcripts sequences into the `ProteoDiscography`.**
3. **Incorporation of genomic variants and fusion-events within mRNA transcripts of genes.**

* (*Optional*) **Determining transcripts with unique proteotypic peptides.**

4. **Review and quality control of the customized protein database.**
5. **Output the customized protein database as FASTA.**

* Using the custom protein database in proteomics to detect additional protein based on their proteotypic fragments.

This can be done on a step-by-step basis in which users can customize advanced options or by performing the functions with default parameters, which will generate custom protein databases suitable for most research purposes.

Below, the entire workflow is given using a number of manually-curated genomic variant sets on the human reference genome (GRCh37 and GRCh38), however this can be easily applied to any other organism for which a reference genome sequence and annotations are known (or novel). We accomplish this by inheriting from flexible and well-maintained Bioconductor infrastructure and classes.

# 2 Standard ProteoDisco workflow.

ProteoDisco provides a flexible infrastructure to facilitate a range of experimental purposes, yet the following work-flow is the core of ProteoDisco:

```
# Generate the ProteoDiscography (containing the genome-sequences and annotations used throughout the incorporation of genomic variants)
# In this case, we supply an existing reference genome with known annotations (GRCh37 with GENCODE annotations).
ProteoDiscography.hg19 <- ProteoDisco::generateProteoDiscography(
TxDb = TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene,
genomeSeqs = BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
)

# Supply the ProteoDiscography with genomic variants to incorporate in downstream analysis. This can be one or multiple VCF / MAF files.
# Additional manual sequences and exon-exon mapping (i.e., splice junctions) can also be given as shown in the sections below.
ProteoDiscography.hg19 <- ProteoDisco::importGenomicVariants(
ProteoDiscography = ProteoDiscography.hg19,
# Provide the VCF / MAF files.
files = system.file('extdata', 'validationSet_hg19.vcf', package = 'ProteoDisco'),
# We can replace the original samples within the VCF with nicer names.
samplenames = 'Validation Set (GRCh37)',
# Number of threads used for parallelization.
# We run samples sequentially and parallelize within (variant-wise multi-threading).
threads = 1,
# To increase import-speed for this example, do not check for validity of the reference anchor with the given reference sequences.
performAnchorCheck = FALSE
)

# Incorporate the given genomic variants into their respective overlapping coding-sequences (i.e. transcripts).
# This can be done in a sample-specific or aggregated cohort-wide manner and can be performed per exon or transcript separately.
ProteoDiscography.hg19 <- ProteoDisco::incorporateGenomicVariants(
ProteoDiscography = ProteoDiscography.hg19,
# Do not aggregate samples and generate mutant transcripts from the mutations per sample.
aggregateSamples = FALSE,
# If there are multiple mutations within the same exon (CDS), place them on the same mutant CDS sequence.
aggregateWithinExon = TRUE,
# Aggregate multiple mutant exons (CDS) within the same transcripts instead of incorporating one at a time.
aggregateWithinTranscript = TRUE,
# If there are overlapping mutations on the same coding position, retain only the first of the overlapping mutations.
# If set to FALSE, throw an error and specify which CDS had overlapping mutations.
ignoreOverlappingMutations = TRUE,
# Number of threads.
threads = 1
)
```

We can then export the results to a FASTA database.

```
# Output custom protein database (FASTA) containing the generated protein variant sequences.
ProteoDisco::exportProteoDiscography(
  ProteoDiscography = ProteoDiscography.hg19,
  outFile = 'example.fasta',
  aggregateSamples = TRUE
)
```

## 2.1 Logging parameters.

Various logging messages are generated using the ParallelLogger package.
For illustration purposes, we will be logging the TRACE-messages to have a better understanding of the underlying happenings.

```
# Display tracing messages:
ParallelLogger::clearLoggers()
ParallelLogger::registerLogger(ParallelLogger::createLogger(threshold = 'TRACE', appenders =list(ParallelLogger::createConsoleAppender(layout = ParallelLogger::layoutTimestamp))))
```

```
## Currently in a tryCatch or withCallingHandlers block, so unable to add global calling handlers. ParallelLogger will not capture R messages, errors, and warnings, only explicit calls to ParallelLogger. (This message will not be shown again this R session)
```

```
# Or only display general information messages:
ParallelLogger::clearLoggers()
ParallelLogger::registerLogger(ParallelLogger::createLogger(threshold = 'INFO', appenders =list(ParallelLogger::createConsoleAppender(layout = ParallelLogger::layoutTimestamp))))
```

# 3 Step 1 - Generating the `ProteoDiscography`

Prior to integrating (somatic) variants into (m)RNA transcripts, we need to generate (or select) the database (`ProteoDiscography`) which contains the genome-sequences and respective transcript-annotations which will be used in all downstream analysis.

The `ProteoDiscography` can be generated via the following options:

1. Using a FASTA file containing the genome-sequences of the respective organism and a GTF/GFF file containing annotations (i.e., exons and transcripts).
2. Using pre-generated `TxDb` and/or `BSGenome` objects available from AnnotationHub or BioConductor.

We go over these options in the sections below. It is required that the given TxDB contains the ‘EXONID’, ‘TXID’ and ‘GENEID’ columns as these are used for indexing overlapping exons and transcripts; additional annotations can be added in downstream analysis.

In addition, during the creation of the `ProteoDiscography`, non-standard genetic code tables can be specified (using `geneticCode`), e.g. the vertebrate mitochondrial genetic code instead of the standard codon-table. This alters the manner of translation in accordance to the given organism or allows for customized translations. For most organisms or scenarios, The Standard Genetic Code can be used and is selected as default. We make use of the genetic code tables provided by Biostrings (Biostrings::GENETIC\_CODE\_TABLE).

## 3.1 Using FASTA and GTF files.

We can generate our `ProteoDiscography` by supplying genome-sequences (FASTA) and annotations of genes and transcripts (GTF/GFF), such as those available from the Ensembl GENCODE project.

In this example, we will generate the `ProteoDiscography` based on the latest (at-the-time) annotations from GENCODE (v37) and respective reference genome used (GRCh38.p12), both of which we will retrieve from their online repository.

```
# Download the latest annotation.
URL.annotations <- 'ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_37/gencode.v37.annotation.gff3.gz'
utils::download.file(URL.annotations, basename(URL.annotations))

# Download the respective reference genome (GRCh38.p12)
URL.genome <- 'ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_37/GRCh38.p12.genome.fa.gz'
utils::download.file(URL.genome, basename(URL.genome))

# Use the latest annotations to generate a TxDb.
TxDb <- GenomicFeatures::makeTxDbFromGFF(
  file = basename(URL.annotations),
  dataSource = 'GENCODE (v37)',
  organism = 'Homo sapiens', taxonomyId = 9606
)

# Import the genome-sequences.
genomeSeqs <- Biostrings::readDNAStringSet(filepath = basename(URL.genome), format = 'fasta')

# Clean the chromosomal names and use the chr-prefix.
names(genomeSeqs) <- gsub(' .*', '', names(genomeSeqs))

# Generate the ProteoDiscography.
ProteoDiscography <- ProteoDisco::generateProteoDiscography(
  TxDb = TxDb,
  genomeSeqs = genomeSeqs,
  geneticCode = 'Standard'
)
```

## 3.2 Using pre-generated resources.

Several annotation databases and reference sequences are already available within the BioConductor framework, including those for *Homo sapiens* (GRCh37 / GRCh38 with UCSC annotation), *Mus musculus*, *C. elegans* and others, as can be seen from the [BioConductor website](https://bioconductor.org/packages/release/data/annotation/).

These pre-generated databases can simply be installed and used without further tweaking. For example, we can use the pre-generated *Homo sapiens* (e.g., GRCh37) transcript-annotations and genome-sequences:

```
# Attach the required packages.
require(BSgenome.Hsapiens.UCSC.hg19)
```

```
## Loading required package: BSgenome.Hsapiens.UCSC.hg19
```

```
## Loading required package: BSgenome
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: Biostrings
```

```
## Loading required package: XVector
```

```
##
## Attaching package: 'XVector'
```

```
## The following object is masked from 'package:plyr':
##
##     compact
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
## Loading required package: BiocIO
```

```
## Loading required package: rtracklayer
```

```
require(TxDb.Hsapiens.UCSC.hg19.knownGene)
```

```
## Loading required package: TxDb.Hsapiens.UCSC.hg19.knownGene
```

```
## Loading required package: GenomicFeatures
```

```
# Generate the ProteoDiscography.
ProteoDiscography.hg19 <- ProteoDisco::generateProteoDiscography(
TxDb = TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene,
genomeSeqs = BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
)
```

## 3.3 Inspecting the initial `ProteoDiscography`.

The `ProteoDiscography` is used as the reference database throughout the downstream analysis, several sanity-checks are performed to make sure all components are valid. Using summary (or print) functions, or just simply calling the `ProteoDiscography`, we can display information on the respective object.

```
print(ProteoDiscography.hg19)
summary(ProteoDiscography.hg19)
```

# 4 Step 2 - Import (somatic) variants into the `ProteoDiscography`.

Now that we have the `ProteoDiscography`, containing the genome-sequences with respective transcript annotations, we can import our (somatic) variants into the `ProteoDiscography`. This allows us to integrate these variants at a later stage (step 3).

Currently, the following alterations can be incorporated:

* Single nucleotide variants (SNVs), multi-nucleotide variants (MNVs) and small insertions/deletions (InDels).
* Novel exon-exon junctions and aberrant branchpoint-usage such as 5’ and 3’ donor/acceptor extensions and shortenings.
* Stitching canonical exons together for common gene-fusions.
* Optionally, with respective incorporation of additional input-variants.

Furthermore, we allow users to provide their own set of manually-curated (or automated) mRNA sequences and check these for proteotypic peptides and as output for the custom protein-database.

## 4.1 Importing SNVs/MNVs/InDels (VCF).

We can import VCF or MAF files containing the (genomic) positions and reference/variant alleles of SNV, MNV and InDels. This is achieved by supplying one or more VCF/MAF files, or by providing `VRanges` objects which users have pre-filtered / annotated themselves.

By default, ProteoDisco validates all given reference alleles by checking whether these correspond with the nucleotide(s) present on the given reference genome; this can be disabled by setting **performAnchorCheck = FALSE**. However, if the reference genome contains mismatches with the given reference alleles, this can give rise to problems in downstream-analysis as there is likely a disconcordance between the reference genomes used for variant-calling and proteogenomics.

To simply import all SNVs, MNVs and InDels present in VCF / MAF file(s) into the `ProteoDiscography`, we use the `importGenomicVariants` function:

```
# Lets produce a ProteoDiscography using pre-generated (BioConductor) resources for hg19 with UCSC annotations.
require(BSgenome.Hsapiens.UCSC.hg19)
require(TxDb.Hsapiens.UCSC.hg19.knownGene)

# Initialize the ProteoDiscography.
ProteoDiscography.hg19 <- ProteoDisco::generateProteoDiscography(
TxDb = TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene,
genomeSeqs = BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
)

# Select one or more VCF or MAF files.
# In this case, we make use of the provided GRCh37 test file.
files.muts <- c(
system.file('extdata', 'validationSet_hg19.vcf', package = 'ProteoDisco')
)

# Import the genomic (somatic) variants.
ProteoDiscography.hg19 <- ProteoDisco::importGenomicVariants(
ProteoDiscography = ProteoDiscography.hg19,
# Provide the VCF / MAF files.
files = files.muts,
# We can replace the original samples within the VCF with nicer names.
samplenames = 'Validation Set (GRCh37)',
# For illustration purposes, do not check the validity of the reference anchor.
performAnchorCheck = FALSE
)
```

* **Note**: During incorporation of the somatic mutations to the `ProteoDiscography`, a sanity check is performed to determine if all reference anchors (genomic position and nucleotide) of the supplied variants indeed match the given nucleotide on the reference sequence.
* If non-matching reference anchors are detected, it will either stop and give an error displaying the erroneous records or, by setting ignoreNonMatch = TRUE, it will remove these non-matching records and continue with the remainder.\*

If everything went as expected, we successfully imported genomic variants (SNV, InDels and MNV) into our `ProteoDiscography`.
We can check this, and other helpful information, using several methods such as:

```
library(ggplot2)

# Print an overview of supplied variants, their respective mutational types and an overview per patients.
summary(ProteoDiscography.hg19, verbose = FALSE)

# We can also capture the summary output and display / handle only certain parts.
# The 'verbose' parameters toggles whether additional information is printed to the console.
z <- summary(ProteoDiscography.hg19, verbose = FALSE)

# Generate a quick overview of the mutational categories (SNV, MNV and InDels) per imported sample.
reshape2::melt(z$overviewMutations, id.vars = 'sample') %>%
dplyr::filter(!is.na(value)) %>%
ggplot2::ggplot(ggplot2::aes(x = sample, y = value, fill = variable)) +
ggplot2::geom_bar(stat = 'identity', width = .8, color = 'black', position = ggplot2::position_dodge(preserve = 'single')) +
ggplot2::scale_y_continuous(trans = scales::pseudo_log_trans(), breaks = c(0, 10, 100, 1000, 10000)) +
ggplot2::labs(x = 'Provided samples', y = 'Nr. of variants (log10)') +
ggplot2::scale_fill_brewer(name = 'Category', palette = 'Greens') +
ggplot2::theme_minimal()
```

![](data:image/png;base64...)

## 4.2 Importing manually-curated transcript sequences from complex events.

Mutant (m)RNA sequences originating from multiple (un-)phased complex events such as an large-scale genomic deletion coupled with several mutations incl. a splice-site mutation are computationally difficult to model due to all the theoretical possibilities. We therefore include the possibility to add manually-curated mRNA sequences or those derived from single-molecule sequencing (e.g., nanopore) and check these for proteotypic peptides.

These can be added using a `DataFrame` with the following columns:

* **sample** (*character*): Name of the sample.
* **identifier** (*character*): The identifier which will be used in downstream analysis. E.g. used as identifier within the FASTA header.
* **gene** (*character*): Name of the gene (can be left blank).
* **Tx.SequenceMut** (*DNAStringSet*): The mutant mRNA sequence. This does not necessarily have to be from an element present in the TxDb.

```
# TMPRSS2-ERG sequence from ENA.
testSeq1 <- Biostrings::DNAString('ATGACCGCGTCCTCCTCCAGCGACTATGGACAGACTTCCAAGATGAGCCCACGCGTCCCTCAGCAGGATTGGCTGTCTCAACCCCCAGCCAGGGTCACCATCAAAATGGAATGTAACCCTAGCCAGGTGAATGGCTCAAGGAACTCTCCTGATGAATGCAGTGTGGCCAAAGGCGGGAAGATGGTGGGCAGCCCAGACACCGTTGGGATGAACTACGGCAGCTACATGGAGGAGAAGCACATGCCACCCCCAAACATGACCACGAACGAGCGCAGAGTTATCGTGCCAGCAGATCCTACGCTATGGAGTACAGACCATGTGCGGCAGTGGCTGGAGTGGGCGGTGAAAGAATATGGCCTTCCAGACGTCAACATCTTGTTATTCCAGAACATCGATGGGAAGGAACTGTGCAAGATGACCAAGGACGACTTCCAGAGGCTCACCCCCAGCTACAACGCCGACATCCTTCTCTCACATCTCCACTACCTCAGAGAGACTCCTCTTCCACATTTGACTTCAGATGATGTTGATAAAGCCTTACAAAACTCTCCACGGTTAATGCATGCTAGAAACACAGGGGGTGCAGCTTTTATTTTCCCAAATACTTCAGTATATCCTGAAGCTACGCAAAGAATTACAACTAGGCCAGTCTCTTACAGATAA')

# Partial CDS of BCR-ABL from ENA.
testSeq2 <- Biostrings::DNAString('ATGATGAGTCTCCGGGGCTCTATGGGTTTCTGAATGTCATCGTCCACTCAGCCACTGGATTTAAGCAGAGTTCAAAAGCCCTTCAGCGGCCAGTAGCATCTGACTTTGAGCCTCAGGGTCTGAGTGAAGCCGCTCGTTGGAACTCCAAGGAAAACCTTCTCGCTGGACCCAGTGAAAATGACCCCAACCTTTTCGTTGCACTGTATGATTTTGTGGCCAGTGGAGATAACACTCTAAGCATAACTAAAGGTGAAAAGCTCCGGGTCTTAGGCTATAATCACAATGGGGAATGGTTTGAAGCCCAAACCAAAAATGGCCAAGGCTGGGTCCCAAGCAACTACATCACGCCAGTCAACAGTCTGGAGAAACACTCCTGGTACCATGGGCCTGTGTCCCGCAATGCCGCTGAGTATCTGCTGAGCAGCGGGATCAAT')

# Generate DataFrame containing the mutant sequences and metadata and add these to our test sample.
manualSeq <- S4Vectors::DataFrame(
  sample = rep('Validation Set (GRCh37)', 2),
  identifier = c('TMPRSS2-ERG prostate cancer specific isoform 1', 'Homo sapiens (human) partial bcr/c-abl oncogene protein'),
  gene = c('TMPRSS2-ERG', 'BCR-ABL1'),
  Tx.SequenceMut = Biostrings::DNAStringSet(base::list(testSeq1, testSeq2))
)

# Add to ProteoDiscography.
ProteoDiscography.hg19 <- ProteoDisco::importTranscriptSequences(
  ProteoDiscography.hg19,
  transcripts = manualSeq,
  removeExisting = TRUE
)
```

## 4.3 Viewing all imported ProteoDiscography records

Imported genomic variants, splice-junctions and/or manual sequences can be retrieved using the `getDiscography` function.

```
# Retrieve / view the records imported into the ProteoDiscography.
getDiscography(ProteoDiscography.hg19)
```

# 5 Step 3 - Incorporation of the somatic variants into (m)RNA transcripts.

Now that we have a `ProteoDiscography` with at least one sample containing one or more mutational events, we can start the process of incorporating these events into the (m)RNA transcripts of overlapping genetic elements (i.e. genes).

We can choose to incorporate all supplied variants (incl. synonymous variants) for all samples simultaneously or to perform this on a per-sample basis (*aggregateSamples*). Similarly, we can choose between incorporating all mutations (per-sample or all samples aggregated) within the same transcript (e.g. a single RNA transcript containing 5 mutations) or to generate separate transcripts, each harboring only a single mutation (e.g. 5 transcripts for 5 mutations) (*aggregateWithinTranscript*).

```
ProteoDiscography.hg19 <- ProteoDisco::incorporateGenomicVariants(
  ProteoDiscography = ProteoDiscography.hg19,
  # Do not aggregate samples and generate mutant transcripts from the mutations per sample.
  aggregateSamples = FALSE,
  # If there are multiple mutations within the same exon (CDS), place them on the same mutant CDS sequence.
  aggregateWithinExon = TRUE,
  # Aggregate multiple mutant exons (CDS) within the same transcripts instead of incorporating one at a time.
  aggregateWithinTranscript = TRUE,
  # If there are overlapping mutations on the same coding position, retain only the first of the overlapping mutations.
  # If set to FALSE, throw an error and specify which CDS had overlapping mutations.
  ignoreOverlappingMutations = TRUE,
  # Number of threads.
  threads = 4
)
```

This step has generated mutant transcript sequences (based on the given parameters) from the genomic mutations. We can see this by simply printing the `ProteoDiscography` or by `mutantTranscripts()` which will retrieve these mutant transcript and their information.

```
# Simply print the ProteoDiscography and it will state the number of mutant transcripts currently generated.
summary(ProteoDiscography.hg19)

# Retrieve the mutant transcript sequences.
# This will retrieve a list of all the generated (and imported) transcript sequences per input type and the respective amino-acid sequence.
x <- ProteoDisco::mutantTranscripts(ProteoDiscography.hg19)

# Visualization of the number of incorporated genomic mutations per transcript.
barplot(table(x$genomicVariants$numberOfMutationsInTx))
```

![](data:image/png;base64...)

If needed, curated mutant transcript and information can be given to the `ProteoDiscography` using the `setMutantTranscripts` function.
This allows users to alter or remove certain generated mutant transcripts. However, we advise to do this prior to the import of the mutations as we perform several sanity checks throughout the incorporation such as checking the reference anchors on the genome and CDS, shortening of exon-intron mutations etc. and manually altering or adding mutant records might affect downstream functions. Preferably, manual mutant sequences should by given to the `ProteoDiscography` by `importTranscriptSequences()`.

```
x <- ProteoDisco::mutantTranscripts(ProteoDiscography.hg19)
x <- x$genomicVariants
x

# Only keep the first 10 mutant transcripts of the incorporated genomic variants.
ProteoDiscography.hg19.subset <- ProteoDisco::setMutantTranscripts(ProteoDiscography.hg19, x[1:10,], slotType = 'genomicVariants')

y <- ProteoDisco::mutantTranscripts(ProteoDiscography.hg19.subset)
y <- y$genomicVariants
y
```

# 6 Step 4 - Importing splicing-events to generate splicing-isoforms.

Alternative splicing or other forms of splicing-events (e.g., fusion-genes or alternative branch point usage) have the potential to extend the repertoire of (translatable) mRNA transcripts.

ProteoDisco facilitates the generation of transcripts from such splice-junctions using the `importSpliceJunctions()` function. The imported splice-junctions can then be converted into their respective (m)RNA and protein products using the `generateJunctionModels()` function. This will generate a putative fragment of the splice-isoform based on the up- and downstream (adjacent, nearest or cryptic) exons.

Only the two adjacent, nearest or cryptic exons will be used in generating the putative splice-isoform fragment, as each splice-junction is regarded as an independent event. E.g., if a splice-junction spanning *TMPRSS2* (exon 2; E2) and *ERG* (exon 4; E4) is given, it will generate a 3-frame translation of TMPRSS2:E2 and ERG:E4 splice-transcript and will not include the first exon of TMPRSS2 or extend further into ERG (exon 5 and further). This will provide a putative proteotypical fragment just for the observed splice-junction.

Complete transcript-sequences spanning multiple exons can more confidently be added using the `importTranscriptSequences` function as derived from single molecule sequencing (e.g., nanopore). Canonical splice-junctions can be ignored by supplying `skipCanonical = TRUE` in the `generateJunctionModels()` function.

In addition to supplying BED or SJ.out.tab files containing the splice-junctions, users can also supply a pre-defined `tibble` containing splice-junctions in the following simple format:
\* junctionA: Genomic coordinates of the 5’-junction. (format: chr:start:strand, i.e.: chr1:100:+)
\* junctionB: Genomic coordinates of the 3’-junction. (format: chr:end:strand, i.e.: chr1:150:+)
\* sample: Name of the sample. (character, optional)
\* identifier: The identifier which will be used in downstream analysis. (character, optional)

This also allows for the generation of splice-isoforms from two (cryptic) exons on different chromosomes, for instance BCR-ABL (chr22 and chr9, respectively).

```
# Import splice-junctions from BED files.
files.Splicing <- c(
  system.file('extdata', 'spliceJunctions_pyQUILTS_chr22.bed', package = 'ProteoDisco')
)

# Import splice-junctions from BED or SJ,out.tab files into our ProteoDiscography.
ProteoDiscography.hg19 <- ProteoDisco::importSpliceJunctions(
  ProteoDiscography = ProteoDiscography.hg19,
  inputSpliceJunctions = system.file('extdata', 'spliceJunctions_pyQUILTS_chr22.bed', package = 'ProteoDisco'),
  # (Optional) Rename samples.
  samples = c('pyQUILTS'),
  # Specify that the given BED files are obtained from TopHat.
  # Chromosomal coordinates from TopHat require additional formatting.
  isTopHat = TRUE,
  aggregateSamples = FALSE,
  removeExisting = TRUE
)

# Or, import splice-junctions (even spanning different chromosomes) based on our format.
testSJ <- readr::read_tsv(system.file('extdata', 'validationSetSJ_hg19.txt', package = 'ProteoDisco')) %>%
  dplyr::select(sample, identifier, junctionA, junctionB)

# Add custom SJ to ProteoDiscography.
ProteoDiscography.hg19 <- ProteoDisco::importSpliceJunctions(
  ProteoDiscography = ProteoDiscography.hg19,
  inputSpliceJunctions = testSJ,
  # Remove existing SJ-input.
  removeExisting = TRUE
)

# Generate junction-models from non-canonical splice-junctions.
ProteoDiscography.hg19 <- ProteoDisco::generateJunctionModels(
  ProteoDiscography = ProteoDiscography.hg19,
  # Max. distance from a known exon-boundary before introducing a novel exon.
  # If an adjacent exon is found within this distance, it will shorten or elongate that exon towards the SJ.
  maxDistance = 150,
  # Should we skip known exon-exon junctions (in which both the acceptor and donor are located on known adjacent exons within the same transcript)
  skipCanonical = TRUE,
  # Perform on multiple threads (optional)
  threads = 4
)
```

# 7 (Optional) Determine proteotypic peptides.

To reduce the search space in subsequent MS/MS analysis, we can perform an optional (and simple) procedure to determine which variant peptide sequences contain unique proteotypic peptides not seen in the wild-type databases or additional databases supplied by the user. These proteotypic peptides can later be used as unique identifiers to detect the presence of variant proteins in MS/MS experiments.

Conceptually, we cleave the variant protein-sequence with the same protease as would be used in the respective MS/MS experiment (e.g. Trypsin) and compare the resulted cleaved peptides against the input TxDb (and additional databases) cleaved in the same manner and then determine unique the number of peptides which are not seen in the input TxDb (and additional database). In addition, it also checks whether the cleaved peptide does not also occur within another variant protein with *checkWithinMutantSeqs = TRUE*.

```
# Load additional peptide sequences against which proteotypic fragments are checked.
# In this case, load the first 100 human Swiss-Prot/Uniprot database entries.
peptides.SwissProt <- base::textConnection(RCurl::getURL('https://www.uniprot.org/uniprot/?query=*&format=fasta&limit=100&fil=organism:%22Homo%20sapiens%20(Human)%20[9606]%22%20AND%20reviewed:yes')) %>%
  seqinr::read.fasta(., seqtype = 'AA', seqonly = FALSE, as.string = TRUE) %>%
  Biostrings::AAStringSetList() %>%
  unlist()

# Check proteotypic fragments.
ProteoDiscography.hg19 <- ProteoDisco::checkProteotypicFragments(
  ProteoDiscography.hg19,
  additionalPeptides = peptides.SwissProt,
  # Protease used in the experiment (see cleaver package)
  enzymUsed = 'trypsin',
  # Number of potentially-missed cleavages (see cleaver package)
  missedCleavages = 1,
  # Should proteotypic fragments also be unique among the generated variant-sequences.
  checkWithinMutantSeqs = FALSE
)

# We can now appreciate that additional information is added to the mutant transcript denoting how many, and which fragments are unique to the mutant transcripts.
ProteoDisco::mutantTranscripts(ProteoDiscography.hg19)
```

# 8 (Optional) Convert TxIDs to gene symbols.

By default, ProteoDisco will assign the `geneID` of the respective overlapping transcript. Depending on the given TxDb this could be just an ENTREZ identifier instead of a gene symbol (as is the case for TxDb.Hsapiens.UCSC.hg19.knownGene). We can convert the ENTREZ identifier into a gene symbol (or similar) for use in downstream analysis and export to ease the interpretation of protein variant or proteotypic peptides.

To convert the ENTREZ identifiers of the human transcripts, we can make use of additional BioConductor packages such as `org.Hs.eg.db` or `biomaRt` which houses functions and conversion tables between several identifiers and gene-symbols.

```
require(org.Hs.eg.db)
```

```
## Loading required package: org.Hs.eg.db
```

```
##
```

```
# Retrieve the all imported mutant transcripts.
x <- ProteoDisco::mutantTranscripts(ProteoDiscography.hg19)

# Convert ENTREZ identifiers to gene symbols.
geneSymbols <- unique(AnnotationDbi::select(
  org.Hs.eg.db, keys = x$genomicVariants$geneID,
  keytype = 'ENTREZID', columns = 'SYMBOL')
)
```

```
## 'select()' returned many:1 mapping between keys and columns
```

```
# Add the gene symbols back to the mutant transcript.
x$genomicVariants <- merge(
  x$genomicVariants, geneSymbols,
  by.x = 'geneID', by.y = 'ENTREZID', all.x = TRUE
)

# Add the mutant transcripts (with symbols) back into the ProteoDiscography.
ProteoDiscography.hg19 <- ProteoDisco::setMutantTranscripts(
  ProteoDiscography.hg19,
  transcripts = x$genomicVariants,
  slotType = 'genomicVariants'
)

# We now have the SYMBOL column in our mutant transcripts DataFrame.
head(ProteoDisco::mutantTranscripts(ProteoDiscography.hg19)$genomicVariants)
```

# 9 Final step - Generate output FASTA

Having imported all our mutations (either via VCF/MAF input, manually or by supplying splicing events) and converting these into variant protein sequences, with or without proteotypic peptides, we next export our results into a database (FASTA file) containing the resulting variant sequences and assorted information.

Prior to exporting, users can specify to only output variant protein sequences contain at least *n* proteotypic peptides to remove variant protein sequences which are indistinguishable from other (e.g. wild-type) protein sequences.

```
ProteoDisco::exportProteoDiscography(
  ProteoDiscography = ProteoDiscography.hg19,
  outFile = 'example.fasta',
  aggregateSamples = TRUE
)
```

# 10 Session Information

```
utils::sessionInfo()
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] org.Hs.eg.db_3.22.0
##  [2] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [3] GenomicFeatures_1.62.0
##  [4] BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [5] BSgenome_1.78.0
##  [6] rtracklayer_1.70.0
##  [7] BiocIO_1.20.0
##  [8] Biostrings_2.78.0
##  [9] XVector_0.50.0
## [10] GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0
## [12] ProteoDisco_1.16.0
## [13] AnnotationDbi_1.72.0
## [14] IRanges_2.44.0
## [15] S4Vectors_0.48.0
## [16] Biobase_2.70.0
## [17] BiocGenerics_0.56.0
## [18] generics_0.1.4
## [19] scales_1.4.0
## [20] reshape2_1.4.4
## [21] ggplot2_4.0.0
## [22] dplyr_1.1.4
## [23] plyr_1.8.9
## [24] knitr_1.50
## [25] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                   bitops_1.0-9
##  [3] rlang_1.1.6                 magrittr_2.0.4
##  [5] cleaver_1.48.0              matrixStats_1.5.0
##  [7] compiler_4.5.1              RSQLite_2.4.3
##  [9] png_0.1-8                   vctrs_0.6.5
## [11] stringr_1.5.2               pkgconfig_2.0.3
## [13] ParallelLogger_3.5.1        crayon_1.5.3
## [15] fastmap_1.2.0               backports_1.5.0
## [17] magick_2.9.0                utf8_1.2.6
## [19] Rsamtools_2.26.0            rmarkdown_2.30
## [21] tzdb_0.5.0                  UCSC.utils_1.6.0
## [23] tinytex_0.57                purrr_1.1.0
## [25] bit_4.6.0                   xfun_0.53
## [27] cachem_1.1.0                cigarillo_1.0.0
## [29] GenomeInfoDb_1.46.0         jsonlite_2.0.0
## [31] blob_1.2.4                  DelayedArray_0.36.0
## [33] BiocParallel_1.44.0         parallel_4.5.1
## [35] R6_2.6.1                    VariantAnnotation_1.56.0
## [37] bslib_0.9.0                 stringi_1.8.7
## [39] RColorBrewer_1.1-3          jquerylib_0.1.4
## [41] Rcpp_1.1.0                  bookdown_0.45
## [43] SummarizedExperiment_1.40.0 readr_2.1.5
## [45] Matrix_1.7-4                tidyselect_1.2.1
## [47] rstudioapi_0.17.1           dichromat_2.0-0.1
## [49] abind_1.4-8                 yaml_2.3.10
## [51] codetools_0.2-20            curl_7.0.0
## [53] lattice_0.22-7              tibble_3.3.0
## [55] withr_3.0.2                 KEGGREST_1.50.0
## [57] S7_0.2.0                    evaluate_1.0.5
## [59] archive_1.1.12              pillar_1.11.1
## [61] BiocManager_1.30.26         MatrixGenerics_1.22.0
## [63] checkmate_2.3.3             vroom_1.6.6
## [65] RCurl_1.98-1.17             hms_1.1.4
## [67] glue_1.8.0                  tools_4.5.1
## [69] GenomicAlignments_1.46.0    XML_3.99-0.19
## [71] grid_4.5.1                  tidyr_1.3.1
## [73] restfulr_0.0.16             cli_3.6.5
## [75] S4Arrays_1.10.0             gtable_0.3.6
## [77] sass_0.4.10                 digest_0.6.37
## [79] SparseArray_1.10.0          rjson_0.2.23
## [81] farver_2.1.2                memoise_2.0.1
## [83] htmltools_0.5.8.1           lifecycle_1.0.4
## [85] httr_1.4.7                  bit64_4.6.0-1
```