# Analysis of high-throughput sequencing of T and B cell receptors with LymphoSeq

#### David G. Coffey, MD

#### April 14, 2017

Application of high-throughput sequencing of T and B lymphocyte antigen receptors has great potential for improving the monitoring of lymphoid malignancies, assessing immune reconstitution after hematopoietic stem cell transplantation, and characterizing the composition of lymphocyte repertoires [(Warren, E. H. *et al. Blood* 2013;122:19–22)](https://www.ncbi.nlm.nih.gov/pubmed/?term=23656731). LymhoSeq is an R package designed to import, analyze, and visualize antigen receptor sequencing from [Adaptive Biotechnologies’ ImmunoSEQ assay](http://www.adaptivebiotech.com/immunoseq). The package is also adaptable to the analysis of T and B cell receptor sequencing processed using other platforms such as [MiXCR](https://milaboratory.com/software/mixcr/) or [IMGT/HighV-QUEST](http://www.imgt.org/HighV-QUEST/login.action). This vignette has been written to highlight some of the features of LymphoSeq and guide the user through a typical workflow.

## Importing data

The LymphoSeq function `readImmunoSeq` imports tab-separated value (`.tsv`) files exported by Adaptive Biotechnologies ImmunoSEQ analyzer v2 where each row represents a unique sequence and each column is a variable with information about that sequence such as read count, frequency, or variable gene name. **Note that the file format for ImmunoSEQ analyzer v3 is not yet supported and users must choose to export the v2 format from the analyzer software.** Only files with the extension `.tsv` are imported while all other are disregarded. It is possible to import files processed using other platforms as long as the files are tab-delimited, are given the extension `.tsv` and have identical column names as the ImmunoSEQs files (see `readImmunoSeq` manual for a list of column names used by this file type). Refer to the LymphoSeq manual regarding the required column names used by each function.

To explore the features of LymphoSeq, this package includes 2 example data sets. The first is a data set of T cell receptor beta (TCRB) sequencing from 10 blood samples acquired serially from a single patient who underwent a bone marrow transplant [(Kanakry, C.G., *et al. JCI Insight* 2016;1(5):pii: e86252)](https://www.ncbi.nlm.nih.gov/pubmed/?term=27213183). The second, is a data set of B cell receptor immunoglobulin heavy (IGH) chain sequencing from Burkitt lymphoma tumor biopsies acquired from 10 different individuals [(Lombardo, K.A., *et al. Blood Advances* 2017 1:535-544)](http://www.bloodadvances.org/content/1/9/535). To improve performance, both data sets contain only the top 1,000 most frequent sequences. The complete data sets are publicly available through [Adapatives’ immuneACCESS portal](https://clients.adaptivebiotech.com/immuneaccess). As shown in the example below, you can specify the path to the example data sets using the command `system.file("extdata", "TCRB_sequencing", package = "LymphoSeq")` for the TCRB files and `system.file("extdata", "IGH_sequencing", package = "LymphoSeq")` for the IGH files.

`readImmunoSeq` imports each file in the specified directory as a list object where each file becomes a data frame. You can import all columns from each file by setting the `columns` parameter to `"all"` or list just those columns of interest. Be aware that Adaptive Biotechnologies has changed the column names of their files over time and if the headings of your files are not all the same, you will need to specify `"all"` or provide all variations of the column header. By default, the `columns` parameter is set to import only those columns used by LymphoSeq.

```
library(LymphoSeq)
```

```
## Loading required package: LymphoSeqDB
```

```
TCRB.path <- system.file("extdata", "TCRB_sequencing", package = "LymphoSeq")

TCRB.list <- readImmunoSeq(path = TCRB.path)
```

Notice that each data frame listed in the `TCRB.list` object is named according the ImmunoSEQ file names. If different names are desired, you may rename the original `.tsv` files or assign `names(TCRB.list)` to a new character vector of desired names in the same order as the list.

```
names(TCRB.list)
```

```
 [1] "TRB_CD4_949"       "TRB_CD8_949"       "TRB_CD8_CMV_369"
 [4] "TRB_Unsorted_0"    "TRB_Unsorted_1320" "TRB_Unsorted_1496"
 [7] "TRB_Unsorted_32"   "TRB_Unsorted_369"  "TRB_Unsorted_83"
[10] "TRB_Unsorted_949"
```

Having the data in the form of a list makes it easy to apply a function over that list using the base function `lapply`. For example, you may use the function `dim` to report the dimensions of each data frame as shown below. Noticed that each data frame in the example below has less than 1,000 rows and 11 columns.

```
lapply(TCRB.list, dim)
```

```
$TRB_CD4_949
[1] 1000   11

$TRB_CD8_949
[1] 1000   11

$TRB_CD8_CMV_369
[1] 414  11

$TRB_Unsorted_0
[1] 1000   11

$TRB_Unsorted_1320
[1] 1000   11

$TRB_Unsorted_1496
[1] 1000   11

$TRB_Unsorted_32
[1] 920  11

$TRB_Unsorted_369
[1] 1000   11

$TRB_Unsorted_83
[1] 1000   11

$TRB_Unsorted_949
[1] 1000   11
```

In place of `dim`, you may also use `colnames`, `nrow`, `ncol`, or other more complex functions that perform operations on subsetted columns.

## Subsetting data

If you imported all of the files from your project but just want to perform an analysis on a subset, use standard R methods to subset the list. Remember that a single bracket `[` returns a list and a double bracket `[[` returns a single data frame.

```
CMV <- TCRB.list[grep("CMV", names(TCRB.list))]
names(CMV)
```

```
[1] "TRB_CD8_CMV_369"
```

```
TRB_Unsorted_0 <- TCRB.list[["TRB_Unsorted_0"]]
head(TRB_Unsorted_0)
```

For more complex subsetting, you can use a metadata file where one column contains the file names and the other columns have additional information about the sample files. You can then subset the metadata file using criteria from the other columns to give you just a character vector of file names that you can use to subset TCRB.list. In the example below, a metadata file is imported for the example TCRB data set which contains information on the number of days post bone marrow transplant the sample was collected and the cellular phenopyte the blood sample was sorted for prior to sequencing.

```
TCRB.metadata <- read.csv(system.file("extdata", "TCRB_metadata.csv", package = "LymphoSeq"))
TCRB.metadata
```

```
selected <- as.character(TCRB.metadata[TCRB.metadata$phenotype == "Unsorted" &
                                 TCRB.metadata$day > 300, "samples"])
TCRB.list.selected <- TCRB.list[selected]
names(TCRB.list.selected)
```

```
[1] "TRB_Unsorted_369"  "TRB_Unsorted_949"  "TRB_Unsorted_1320"
[4] "TRB_Unsorted_1496"
```

## Extracting productive sequences

A productive sequence is defined as a sequences that is in frame and does not have an early stop codon. If you sequenced genomic DNA as opposed to complimentary DNA made from RNA, then you will have unproductive and productive sequences in your data files. Use the function `productiveSeq` to remove unproductive sequences and recompute the frequencyCount for each of your samples.

If you are interested in just the complementarity determining region 3 (CDR3) amino acid sequences, then set aggregate to `"aminoAcid"` and the count and estimated number of genomes for duplicate amino acid sequences will be summed. Note that the resulting list of data frames will have columns corresponding to “aminoAcid”, “count”, “frequencyCount”, and “estimatedNumberGenomes” (if this column is available) only. All other columns, such as those corresponding to the V, D, and J gene names, will be removed if they were included in your original file list. The reason for this is to avoid confusion since a single amino acid CDR3 sequence may be encoded by multiple different nucleotide sequences with differing V, D, and J genes.

```
productive.TRB.aa <- productiveSeq(file.list = TCRB.list, aggregate = "aminoAcid",
                               prevalence = FALSE)
```

Alternatively, you may set aggregate to `"nucleotide"` and the resulting list of data frames will all have the same columns as your original file list. Take note that some LymphoSeq functions require a productive sequence list aggregated by amino acid or nucleotide.

```
productive.TRB.nt <- productiveSeq(file.list = TCRB.list, aggregate = "nucleotide",
                               prevalence = FALSE)
```

If the parameter `prevalence` is set to `TRUE`, then a new column is added to each of the data frames giving the prevalence (%) of each TCR beta CDR3 amino acid sequence in 55 healthy donor peripheral blood samples. Values range from 0 to 100% where 100% means the sequence appeared in the blood of all 55 individuals. The data for this operation resides in a separate package that is automatically loaded called LymphoSeqDB. Please refer to that package manual for more details.

Notice in the example below that there are no amino acid sequences given in the first and fourth row of the TCRB.list data frame for sample “TRB\_Unsorted\_949”. This is because the nucleotide sequence is out of frame and does not produce a productively transcribed amino acid sequence. If an asterisk (\*) appears in the amino acid sequences, this would indicate an early stop codon.

```
head(TCRB.list[["TRB_Unsorted_0"]])
```

After `productiveSeq` is run, the unproductive sequences are removed and the frequencyCount is recalculated for each sequence. If there were two identical amino acid sequences that differed in their nucleotide sequence, they would be combined and their counts added together.

```
head(productive.TRB.aa[["TRB_Unsorted_0"]])
```

Finally, notice that the productive.TRB.nt data frame for sample “TRB\_Unsorted\_949” below has additional columns not present in productive.TRB.aa but are in TCRB.list. This is because the data frame was aggregated by nucleotide sequence and all of the original columns from TCRB.list were carried over.

```
head(productive.TRB.nt[["TRB_Unsorted_0"]])
```

## Create a table of summary statistics

To create a table summarizing the total number of sequences, number of unique productive sequences, number of genomes, entropy, clonality, Gini coefficient, and the frequency (%) of the top productive sequence in each imported file, use the function `clonality`.

```
clonality(file.list = TCRB.list)
```

The clonality score is derived from the Shannon entropy, which is calculated from the frequencies of all productive sequences divided by the logarithm of the total number of unique productive sequences. This normalized entropy value is then inverted (1 - normalized entropy) to produce the clonality metric.

The [Gini coefficient](https://en.wikipedia.org/wiki/Gini_coefficient) is an alternative metric used to calculate repertoire diversity and is derived from the [Lorenz curve](https://en.wikipedia.org/wiki/Lorenz_curve). The Lorenz curve is drawn such that x-axis represents the cumulative percentage of unique sequences and the y-axis represents the cumulative percentage of reads. A line passing through the origin with a slope of 1 reflects equal frequencies of all clones. The Gini coefficient is the ratio of the area between the line of equality and the observed Lorenz curve over the total area under the line of equality.

Both Gini coefficient and clonality are reported on a scale from 0 to 1 where 0 indicates all sequences have the same frequency and 1 indicates the repertoire is dominated by a single sequence.

## Calculate clonal relatedness

One of the drawbacks of the clonality metric is that it does not take into account sequence similarity. This is particularly important when studying affinity maturation or B cell malignancies[(Lombardo, K.A., *et al. Blood Advances* 2017 1:535-544)](http://www.bloodadvances.org/content/1/9/535). Clonal relatedness is a useful metric that takes into account sequence similarity without regard for clonal frequency. It is defined as the proportion of nucleotide sequences that are related by a defined edit distance threshold. The value ranges from 0 to 1 where 0 indicates no sequences are related and 1 indicates all sequences are related. Edit distance is a way of quantifying how dissimilar two sequences are to one another by counting the minimum number of operations required to transform one sequence into the other. For example, an edit distance of 0 means the sequences are identical and an edit distance of 1 indicates that the sequences different by a single amino acid or nucleotide.

```
IGH.path <- system.file("extdata", "IGH_sequencing", package = "LymphoSeq")

IGH.list <- readImmunoSeq(path = IGH.path)
```

```
clonalRelatedness(list = IGH.list, editDistance = 10)
```

## Draw a phylogenetic tree

A phylogenetic tree is a useful way to visualize the similarity between sequences. The `phyloTree` function create a phylogenetic tree of a single sample using neighbor joining tree estimation for amino acid or nucleotide CDR3 sequences. Each leaf in the tree represents a sequence color coded by the V, D, and J gene usage. The number next to each leaf refers to the sequence count. A triangle shaped leaf indicates the most frequent sequence. The distance between leaves on the horizontal axis corresponds to the sequence similarity (i.e. the further apart the leaves are horizontally, the less similar the sequences are to one another).

```
productive.IGH.nt <- productiveSeq(file.list = IGH.list, aggregate = "nucleotide")
```

```
phyloTree(list = productive.IGH.nt, sample = "IGH_MVQ92552A_BL", type = "nucleotide",
         layout = "rectangular")
```

```
Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
ℹ Please use tidy evaluation idioms with `aes()`.
ℹ See also `vignette("ggplot2-in-packages")` for more information.
ℹ The deprecated feature was likely used in the LymphoSeq package.
  Please report the issue to the authors.
This warning is displayed once every 8 hours.
Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
generated.
```

```
Warning: The `<scale>` argument of `guides()` cannot be `FALSE`. Use "none" instead as
of ggplot2 3.3.4.
ℹ The deprecated feature was likely used in the LymphoSeq package.
  Please report the issue to the authors.
This warning is displayed once every 8 hours.
Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
generated.
```

![](data:image/png;base64...)

## Multiple sequence alignment

In LymphoSeq, you can perform a multiple sequence alignment using one of three methods provided by the Bioconductor msa package (ClustalW, ClustalOmega, or Muscle) and output results to the console or as a pdf file. One may perform the alignment of all amino acid or nucleotide sequences in a single sample. Alternatively, one may search for a given sequence within a list of samples using an edit distance threshold.

```
alignSeq(list = productive.IGH.nt, sample = "IGH_MVQ92552A_BL", type = "aminoAcid",
         method = "ClustalW", output = "consule")
```

```
use default substitution matrix
```

## Searching for sequences

To search for one or more amino acid or nucleotide CDR3 sequences in a list of data frames, use the function `searchSeq`. You may specify to search in either a list of productive or unproductive data frames.

```
searchSeq(list = productive.TRB.aa, sequence = "CASSPVSNEQFF", type = "aminoAcid",
          match = "global", editDistance = 0)
```

If you have only a partial sequence, set the parameter match to `"partial"`. If you are looking for related sequences that differ by one or more nucleotides or amino acids, then increase the `editDistance` value. Edit distance is a way of quantifying how dissimilar two sequences are to one another by counting the minimum number of operations required to transform one sequence into the other. For example, an edit distance of 0 means the sequences are identical and an edit distance of 1 indicates that the sequences differ by a single amino acid or nucleotide.

## Searching for published sequences

To search your entire list of data frames for a published amino acid CDR3 TCRB sequence with known antigen specificity, use the function `searchPublished`.

```
published <- searchPublished(list = productive.TRB.aa)
head(published)
```

For each found sequence, a table is provides listing the antigen, epitope, HLA type, PubMed ID (PMID), and prevalence (%) of the sequence among 55 healthy donor blood samples. The data for this function resides in the separate LymphoSeqDB package that is automatically loaded when the function is called. Please refer to that package manual for more details.

## Visualizing repertoire diversity

Antigen receptor repertoire diversity can be characterized by a number such as clonality or Gini coefficient calculated by the `clonality` function. Alternatively, you can visualize the repertoire diversity by plotting the Lorenz curve for each sample as defined above. In this plot, the more diverse samples will appear near the dotted diagonal line (the line of equality) whereas the more clonal samples will appear to have a more bowed shape.

```
lorenzCurve(samples = names(productive.TRB.aa), list = productive.TRB.aa)
```

```
Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
ℹ Please use `linewidth` instead.
ℹ The deprecated feature was likely used in the LymphoSeq package.
  Please report the issue to the authors.
This warning is displayed once every 8 hours.
Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
generated.
```

![](data:image/png;base64...)

Alternatively, you can get a feel for the repertoire diversity by plotting the cumulative frequency of a selected number of the top most frequent clones using the function `topSeqsPlot`. In this case, each of the top sequences are represented by a different color and all less frequent clones will be assigned a single color (violet).

```
topSeqsPlot(list = productive.TRB.aa, top = 10)
```

![](data:image/png;base64...)

Both of these functions are built using the [ggplot2 package](http://docs.ggplot2.org/current/). You can reformat the plot using ggplot2 functions. Please refer to the `lorenzCurve` and `topSeqsPlot` manual for specific examples.

## Comparing samples

To compare the T or B cell repertoires of all samples in a pairwise fashion, use the `bhattacharyyaMatrix` or `similarityMatrix` functions. Both the Bhattacharyya coefficient and similarity score are measures of the amount of overlap between two samples. The value for each ranges from 0 to 1 where 1 indicates the sequence frequencies are identical in the two samples and 0 indicates no shared frequencies. The Bhattacharyya coefficient differs from the similarity score in that it involves weighting each shared sequence in the two distributions by the arithmetic mean of the frequency of each sequence, while calculating the similarity scores involves weighting each shared sequence in the two distributions by the geometric mean of the frequency of each sequence in the two distributions.

```
bhattacharyya.matrix <- bhattacharyyaMatrix(productive.seqs = productive.TRB.aa)
bhattacharyya.matrix
```

```
similarity.matrix <- similarityMatrix(productive.seqs = productive.TRB.aa)
similarity.matrix
```

The results of either function can be visualized by the `pairwisePlot` function.

```
pairwisePlot(matrix = bhattacharyya.matrix)
```

![](data:image/png;base64...)

To view sequences shared between two or more samples, use the function `commonSeqs`. This function requires that a productive amino acid list be specified.

```
common <- commonSeqs(samples = c("TRB_Unsorted_0", "TRB_Unsorted_32"),
                    productive.aa = productive.TRB.aa)
head(common)
```

To visualize the number of overlapping sequences between two or three samples in the form of a Venn diagram, use the function `commonSeqVenn`.

```
commonSeqsVenn(samples = c("TRB_Unsorted_32", "TRB_Unsorted_83"),
               productive.seqs = productive.TRB.aa)
```

![](data:image/png;base64...)

```
commonSeqsVenn(samples = c("TRB_Unsorted_0", "TRB_Unsorted_32", "TRB_Unsorted_83"),
               productive.seqs = productive.TRB.aa)
```

![](data:image/png;base64...)

To compare the frequency of sequences between two samples as a scatter plot, use the function `commonSeqsPlot`.

```
commonSeqsPlot("TRB_Unsorted_32", "TRB_Unsorted_83",
               productive.aa = productive.TRB.aa, show = "common")
```

![](data:image/png;base64...)

If you have more than 3 samples to compare, use the `commonSeqBar` function. You can chose to color a single sample with the `color.sample` argument or a desired intersection with the `color.intersection` argument.

```
commonSeqsBar(productive.aa = productive.TRB.aa,
              samples = c("TRB_CD4_949", "TRB_CD8_949",
                          "TRB_Unsorted_949", "TRB_Unsorted_1320"),
              color.sample = "TRB_CD8_949",
              labels = "no")
```

```
Warning in geom_point(data = pCustomDat, aes_string(x = "x", y = "freq2"), :
Ignoring empty aesthetic: `colour`.
```

```
Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
ℹ Please use the `linewidth` argument instead.
ℹ The deprecated feature was likely used in the UpSetR package.
  Please report the issue to the authors.
This warning is displayed once every 8 hours.
Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
generated.
```

## Differential abundance

When comparing a sample from two different time points, it is useful to identify sequences that are significantly more or less abundant in one versus the other time point [(DeWitt, W.S., *et al. Journal of Virology* 2015 89(8):4517-4526)](https://www.ncbi.nlm.nih.gov/pubmed/25653453). The `differentialAbundance` function uses a Fisher exact test to calculate differential abundance of each sequence in two time points and reports the log2 transformed fold change, P value and adjusted P value.

```
differentialAbundance(list = productive.TRB.aa,
                      sample1 = "TRB_Unsorted_949",
                      sample2 = "TRB_Unsorted_1320",
                      type = "aminoAcid", q = 0.01)
```

## Finding recurring sequences

To create a data frame of unique, productive amino acid sequences as rows and sample names as headers use the `seqMatrix` function. Each value in the data frame represents the frequency that each sequence appears in the sample. You can specify your own list of sequences or all unique sequences in the list using the output of the function `uniqueSeqs`. The `uniqueSeqs` function creates a data frame of all unique, productive sequences and reports the total count in all samples.

```
unique.seqs <- uniqueSeqs(productive.aa = productive.TRB.aa)
head(unique.seqs)
```

```
sequence.matrix <- seqMatrix(productive.aa = productive.TRB.aa, sequences = unique.seqs$aminoAcid)
head(sequence.matrix)
```

If just the top clones with a frequency greater than a specified amount are of interest to you, then use the `topFreq` function. This creates a data frame of the top productive amino acid sequences having a minimum specified frequency and reports the minimum, maximum, and mean frequency that the sequence appears in a list of samples. For TCRB sequences, the prevalence (%) and the published antigen specificity of that sequence are also provided.

```
top.freq <- topFreq(productive.aa = productive.TRB.aa, percent = 0.1)
head(top.freq)
```

One very useful thing to do is merge the output of `seqMatrix` and `topFreq`.

```
top.freq <- topFreq(productive.aa = productive.TRB.aa, percent = 0)
top.freq.matrix <- merge(top.freq, sequence.matrix)
head(top.freq.matrix)
```

## Tracking sequences across samples

To visually track the frequency of sequences across multiple samples, use the function `cloneTrack`. This function takes the output from the `seqMatrix` function. You can specify a character vector of amino acid sequences using the parameter `track` to highlight those sequences with a different color. Alternatively, you can highlight all of the sequences from a given sample using the parameter `map`. If the mapping feature is use, then you must specify a productive amino acid list and a character vector of labels to title the mapped samples. To hide sequences that are not being tracked or mapped, set `unassigned` to FALSE.

```
cloneTrack(sequence.matrix = sequence.matrix,
           productive.aa = productive.TRB.aa,
           map = c("TRB_CD4_949", "TRB_CD8_949"),
           label = c("CD4", "CD8"),
           track = "CASSPPTGERDTQYF",
           unassigned = FALSE)
```

![](data:image/png;base64...)

Refer to the `cloneTrack` manual for examples on how to reformat the chart using ggplot2 function.

## Comparing V(D)J gene usage

To compare the V, D, and J gene usage across samples, start by creating a data frame of V, D, and J gene counts and frequencies using the function `geneFreq`. You can specify if you are interested in the “VDJ”, “DJ”, “VJ”, “DJ”, “V”, “D”, or “J” loci using the `locus` parameter. Set `family` to TRUE if you prefer the family names instead of the gene names as reported by ImmunoSeq.

```
vGenes <- geneFreq(productive.nt = productive.TRB.nt, locus = "V", family = TRUE)
head(vGenes)
```

To create a chord diagram showing VJ or DJ gene associations from one or more more samples, combine the output of `geneFreq` with the function `chordDiagramVDJ`. This function works well the `topSeqs` function that creates a data frame of a selected number of top productive sequences. In the example below, a chord diagram is made showing the association between V and J genes of just the single dominant clones in each sample. The size of the ribbons connecting VJ genes correspond to the number of samples that have that recombination event. The thicker the ribbon, the higher the frequency of the recombination.

```
top.seqs <- topSeqs(productive.seqs = productive.TRB.nt, top = 1)
chordDiagramVDJ(sample = top.seqs,
                association = "VJ",
                colors = c("darkred", "navyblue"))
```

![](data:image/png;base64...)

You can also visualize the results of `geneFreq` as a heat map, word cloud, our cumulative frequency bar plot with the support of additional R packages as shown below.

```
vGenes <- geneFreq(productive.nt = productive.TRB.nt, locus = "V", family = TRUE)
library(RColorBrewer)
library(grDevices)
RedBlue <- grDevices::colorRampPalette(rev(RColorBrewer::brewer.pal(11, "RdBu")))(256)
library(wordcloud)
wordcloud::wordcloud(words = vGenes[vGenes$samples == "TRB_Unsorted_83", "familyName"],
                     freq = vGenes[vGenes$samples == "TRB_Unsorted_83", "frequencyGene"],
                     colors = RedBlue)
```

![](data:image/png;base64...)

```
library(reshape)
vGenes <- reshape::cast(vGenes, familyName ~ samples, value = "frequencyGene", sum)
rownames(vGenes) = as.character(vGenes$familyName)
vGenes$familyName = NULL
library(pheatmap)
pheatmap::pheatmap(vGenes, color = RedBlue, scale = "row")
```

![](data:image/png;base64...)

```
vGenes <- geneFreq(productive.nt = productive.TRB.nt, locus = "V", family = TRUE)
library(ggplot2)
multicolors <- grDevices::colorRampPalette(rev(RColorBrewer::brewer.pal(9, "Set1")))(28)
ggplot2::ggplot(vGenes, aes(x = samples, y = frequencyGene, fill = familyName)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  scale_y_continuous(expand = c(0, 0)) +
  guides(fill = guide_legend(ncol = 2)) +
  scale_fill_manual(values = multicolors) +
  labs(y = "Frequency (%)", x = "", fill = "") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
```

![](data:image/png;base64...)

## Removing sequences

Occasionally you may identify one or more sequences in your data set that appear to be contamination. You can remove an amino acid sequence from all data frames using the function `removeSeq` and recompute frequencyCount for all remaining sequences.

```
searchSeq(list = productive.TRB.aa, sequence = "CASSESAGSTGELFF")
```

```
cleansed <- removeSeq(file.list = productive.TRB.aa, sequence = "CASSESAGSTGELFF")
searchSeq(list = cleansed, sequence = "CASSESAGSTGELFF")
```

```
No sequences found.
```

## Merging samples

If you need to combine multiple samples into one, use the `mergeFiles` function. It merges two or more sample data frames into a single data frame and aggregates count, frequencyCount, and estimatedNumberGenomes.

```
TRB_949_Merged <- mergeFiles(samples = c("TRB_CD4_949", "TRB_CD8_949"),
                                file.list = TCRB.list)
```

## Conclusion

Advances in high-throughput sequencing have enabled characterizing T and B lymphocyte repertoires with unprecedented depth. LymphoSeq was developed as a tool to assist in the analysis of targeted next generation sequencing of the hypervariable CDR3 region of T and B cell receptors. The three key features of this R package are to characterize lymphocyte repertoire diversity, compare two or more lymphocyte repertoires, and track the frequency of CDR3 sequences across multiple samples. LymphoSeq also provides the unique ability to search for sequences in a curated database of published TCRB sequences with known antigen specificity. Finally, LymphoSeq can assign the percent prevalence that any given TCRB sequence appears in a the peripheral blood in healthy population of donors.

## Session info

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
## [1] ggplot2_4.0.0      pheatmap_1.0.13    reshape_0.8.10     wordcloud_2.6
## [5] RColorBrewer_1.1-3 LymphoSeq_1.38.0   LymphoSeqDB_0.99.2
##
## loaded via a namespace (and not attached):
##  [1] ggiraph_0.9.2           tidyselect_1.2.1        dplyr_1.1.4
##  [4] farver_2.1.2            Biostrings_2.78.0       S7_0.2.0
##  [7] fastmap_1.2.0           lazyeval_0.2.2          fontquiver_0.2.1
## [10] digest_0.6.37           lifecycle_1.0.4         tidytree_0.4.6
## [13] VennDiagram_1.7.3       magrittr_2.0.4          compiler_4.5.1
## [16] rlang_1.1.6             sass_0.4.10             tools_4.5.1
## [19] igraph_2.2.1            yaml_2.3.10             data.table_1.17.8
## [22] knitr_1.50              lambda.r_1.2.4          phangorn_2.12.1
## [25] labeling_0.4.3          htmlwidgets_1.6.4       plyr_1.8.9
## [28] aplot_0.2.9             withr_3.0.2             purrr_1.1.0
## [31] BiocGenerics_0.56.0     grid_4.5.1              stats4_4.5.1
## [34] gdtools_0.4.4           msa_1.42.0              colorspace_2.1-2
## [37] scales_1.4.0            dichromat_2.0-0.1       cli_3.6.5
## [40] UpSetR_1.4.0            rmarkdown_2.30          crayon_1.5.3
## [43] treeio_1.34.0           generics_0.1.4          stringdist_0.9.15
## [46] ggtree_4.0.1            ape_5.8-1               cachem_1.1.0
## [49] parallel_4.5.1          ggplotify_0.1.3         formatR_1.14
## [52] XVector_0.50.0          yulab.utils_0.2.1       vctrs_0.6.5
## [55] Matrix_1.7-4            jsonlite_2.0.0          fontBitstreamVera_0.1.1
## [58] gridGraphics_0.5-1      IRanges_2.44.0          patchwork_1.3.2
## [61] S4Vectors_0.48.0        systemfonts_1.3.1       ineq_0.2-13
## [64] tidyr_1.3.1             jquerylib_0.1.4         glue_1.8.0
## [67] codetools_0.2-20        gtable_0.3.6            shape_1.4.6.1
## [70] futile.logger_1.4.3     quadprog_1.5-8          tibble_3.3.0
## [73] pillar_1.11.1           rappdirs_0.3.3          htmltools_0.5.8.1
## [76] Seqinfo_1.0.0           circlize_0.4.16         R6_2.6.1
## [79] evaluate_1.0.5          lattice_0.22-7          futile.options_1.0.1
## [82] fontLiberation_0.1.0    ggfun_0.2.0             bslib_0.9.0
## [85] Rcpp_1.1.0              fastmatch_1.1-6         gridExtra_2.3
## [88] nlme_3.1-168            xfun_0.54               fs_1.6.6
## [91] pkgconfig_2.0.3         GlobalOptions_0.1.2
```