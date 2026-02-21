# Structural Tendency Vignette

#### William McFadden

#### 2025-10-30

## Background

The composition of amino acids and the overall chemistry of Intrinsically Disordered Proteins (IDPs) are distinctly different from that of ordered proteins. Each amino acid has a tendency to favor a compact or extended secondary and tertiary structures based on the chemistry of the residue. Disorder-promoting residues, those enriched in IDPs, are typically hydrophilic, charged, or small. Order promoting residues, those enriched in structured proteins, tend to be aliphatic, hydrophobic, aromatic, or form tertiary structures. Disorder neutral residues neither favor order or disordered structures (Uversky, 2019).

Disorder-promoting residues are P, E, S, Q, K, A, and G; order-promoting residues are M, N, V, H, L, F, Y, I, W, and C; disorder‐neutral residues are D, T, and R (Uversky, 2013).

## Installation

The package can be installed from Bioconductor with the following line of code. It requires the BiocManager package to be installed

```
#BiocManager::install("idpr")
```

The most recent version of the package can be installed with the following line of code. This requires the devtools package to be installed.

```
#devtools::install_github("wmm27/idpr")
```

## Quick-use guide

```
library(idpr)
```

The structuralTendency function is used to convert an amino acid sequence into a data frame with each residue within the sequence in one column and the corresponding structural tendency in another column.

This example will use the *H. sapiens* TP53 sequence, acquired from UniProt (UniProt Consortium 2019) and stored within the **idpr** package for examples.

```
P53_HUMAN <- TP53Sequences[2]
print(P53_HUMAN)
#>                                                                                                                                                                                                                                                                                                                                                                                            P04637|P53_HUMAN
#> "MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPSQAMDDLMLSPDDIEQWFTEDPGPDEAPRMPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQKTYQGSYGFRLGFLHSGTAKSVTCTYSPALNKMFCQLAKTCPVQLWVDSTPPPGTRVRAMAIYKQSQHMTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLRVEYLDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTSSSPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGSRAHSSHLKSKKGQSTSRHKKLMFKTEGPDSD"
```

```
tendencyDF <- structuralTendency(P53_HUMAN)
head(tendencyDF)
#>   Position AA           Tendency
#> 1        1  M    Order Promoting
#> 2        2  E Disorder Promoting
#> 3        3  E Disorder Promoting
#> 4        4  P Disorder Promoting
#> 5        5  Q Disorder Promoting
#> 6        6  S Disorder Promoting
```

For convenient plotting, use structuralTendencyPlot(). Results can be as a pie chart or bar plot.

```
structuralTendencyPlot(P53_HUMAN)
```

![](data:image/png;base64...)

```
structuralTendencyPlot(P53_HUMAN,
                       graphType = "bar")
```

![](data:image/png;base64...)

## structuralTendency In Detail

Like most functions in **idpr**, the structuralTendency function will accept an amino acid sequence as a vector of single-letter residues or as a character string. It will also accept the path to a .fasta file as a character string (“.fasta” must be included within the string).

It will result in a data frame with 3 columns. The first column is “Position”, which indicates the numeric position of the residue in the submitted sequence. The second column is “AA”, which indicates the amino acid residue as a single letter. The third column is “Tendency”, which indicates the structural tendency of the residue that was matched by the function.

The following examples will use the *M. musculus* Tp53 sequence, acquired from UniProt (UniProt Consortium 2019) and stored within the **idpr** package for examples.

```
P53_MOUSE <- TP53Sequences[1]
print(P53_MOUSE)
#>                                                                                                                                                                                                                                                                                                                                                                                         P02340|P53_MOUSE
#> "MTAMEESQSDISLELPLSQETFSGLWKLLPPEDILPSPHCMDDLLLPQDVEEFFEGPSEALRVSGAPAAQDPVTETPGPVAPAPATPWPLSSFVPSQKTYQGNYGFHLGFLQSGTAKSVMCTYSPPLNKLFCQLAKTCPVQLWVSATPPAGSRVRAMAIYKKSQHMTEVVRRCPHHERCSDGDGLAPPQHLIRVEGNLYPEYLEDRQTFRHSVVVPYEPPEAGSEYTTIHYKYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRDSFEVRVCACPGRDRRTEEENFRKKEVLCPELPPGSAKRALPTCTSASPPQKKKPLDGEYFTLKIRGRKRFEMFRELNEALELKDAHATEESGDSRAHSSYLKTKKGQSTSRHKKTMVKKVGPDSD"
```

This will get the data frame.

```
tendencyDF <- structuralTendency(P53_MOUSE)
head(tendencyDF)
#>   Position AA           Tendency
#> 1        1  M    Order Promoting
#> 2        2  T   Disorder Neutral
#> 3        3  A Disorder Promoting
#> 4        4  M    Order Promoting
#> 5        5  E Disorder Promoting
#> 6        6  E Disorder Promoting
```

The data frame can be used for custom plotting. Another possibility is the use of the sequenceMap() function within **idpr**.

```
sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  customColors = c("#999999", "#E69F00", "#56B4E9"))
```

![](data:image/png;base64...)

structuralTendency defines order- and disorder-promoting residues based on Uversky (2013).

* Disorder-promoting: P, E, S, Q, K, A, and G
* Order-promoting: M, N, V, H, L, F, Y, I, W, and C
* Disorder‐neutral: D, T, and R.

However, there are other definitions of these categories. For example, Dunker et al. (2001) defines these categories as:

* Disorder-promoting: A, R, G, Q, S, P, E, and K
* Order-promoting: W, C, F, I, Y, V, L, and N
* Disorder‐neutral: H, M, T, and D.

structuralTendency allows for the user to specify different definitions. An example of this using the Dunker et al. (2001) definitions rather than the default is below.

```
tendencyDF <- structuralTendency(P53_MOUSE,
                 disorderPromoting = c("A", "R", "G", "Q", "S", "P", "E", "K"),
                 disorderNeutral = c("H", "M", "T", "D"),
                 orderPromoting = c("W", "C", "F", "I", "Y", "V", "L", "N"))
head(tendencyDF)
#>   Position AA           Tendency
#> 1        1  M   Disorder Neutral
#> 2        2  T   Disorder Neutral
#> 3        3  A Disorder Promoting
#> 4        4  M   Disorder Neutral
#> 5        5  E Disorder Promoting
#> 6        6  E Disorder Promoting

sequenceMap(
  sequence = P53_MOUSE,
  property = tendencyDF$Tendency,
  customColors = c("#999999", "#E69F00", "#56B4E9"))
```

![](data:image/png;base64...)

## structuralTendencyPlot In Detail

structuralTendencyPlot is a function for summarizing and plotting results from structuralTendency. This function accepts the same arguments as structuralTendency() for sequence and definitions of residue tendency.

The function will get the amino acid composition for the protein and match it to the tendency definition.

The results can be visualized in the form of a pie chart (default) or a bar chart.

```
structuralTendencyPlot(P53_MOUSE)
```

![](data:image/png;base64...)

```
structuralTendencyPlot(P53_MOUSE,
                       graphType = "bar",
                       proteinName = names(P53_MOUSE))
```

![](data:image/png;base64...)

In addition to the compositional profile of each residue, a summary of the profile focused only on the structural tendency can be given by setting summarize = TRUE. This shifts the focus from amino acid identity to the general composition. The graphType is preserved.

```
structuralTendencyPlot(P53_MOUSE,
                       summarize = TRUE)
```

![](data:image/png;base64...)

```
structuralTendencyPlot(P53_MOUSE,
                       graphType = "bar",
                       proteinName = names(P53_MOUSE),
                       summarize = TRUE)
```

![](data:image/png;base64...)

In addition to the default plotting, a data frame of the compositional profile can be produced by setting graphType = “none”. This can be used for further data analysis or for custom plotting. The “summarize” argument is preserved.

```
compositionDF <- structuralTendencyPlot(P53_MOUSE,
                                        graphType = "none")
head(compositionDF)
#>   AA           Tendency Total Frequency
#> 1  A Disorder Promoting    24     6.154
#> 2  C    Order Promoting    12     3.077
#> 3  D   Disorder Neutral    17     4.359
#> 4  E Disorder Promoting    32     8.205
#> 5  F    Order Promoting    13     3.333
#> 6  G Disorder Promoting    24     6.154

summaryDF <- structuralTendencyPlot(P53_MOUSE,
                                    graphType = "none",
                                    summarize = TRUE)
head(summaryDF)
#>             Tendency Total Frequency                 AA
#> 1   Disorder Neutral    65  16.66667   Disorder Neutral
#> 2 Disorder Promoting   191  48.97436 Disorder Promoting
#> 3    Order Promoting   134  34.35897    Order Promoting
```

## References

### Citations

Dunker, A. K., Lawson, J. D., Brown, C. J., Williams, R. M., Romero, P., Oh, J. S., . . . Obradovic, Z. (2001). Intrinsically disordered protein. Journal of Molecular Graphics and Modelling, 19(1), 26-59. doi:https://doi.org/10.1016/S1093-3263(00)00138-8

UniProt Consortium. (2019). UniProt: a worldwide hub of protein knowledge. Nucleic acids research, 47(D1), D506-D515.

Uversky, V. N. (2013). A decade and a half of protein intrinsic disorder: Biology still waits for physics. Protein Science, 22(6), 693-724. doi:10.1002/pro.2261

Uversky, V. N. (2019). Intrinsically Disordered Proteins and Their “Mysterious” (Meta)Physics. Frontiers in Physics, 7(10). doi:10.3389/fphy.2019.00010

### Additional Information

R Version

```
R.version.string
#> [1] "R version 4.5.1 Patched (2025-08-23 r88802)"
```

System Information

```
as.data.frame(Sys.info())
#>                                                                 Sys.info()
#> sysname                                                              Linux
#> release                                                   6.8.0-79-generic
#> version        #79-Ubuntu SMP PREEMPT_DYNAMIC Tue Aug 12 14:42:46 UTC 2025
#> nodename                                                         nebbiolo2
#> machine                                                             x86_64
#> login                                                            biocbuild
#> user                                                             biocbuild
#> effective_user                                                   biocbuild
```

```
citation()
```

To cite R in publications use:

R Core Team (2025). *R: A Language and Environment for Statistical Computing*. R Foundation for Statistical Computing, Vienna, Austria. <https://www.R-project.org/>.

A BibTeX entry for LaTeX users is

@Manual{, title = {R: A Language and Environment for Statistical Computing}, author = {{R Core Team}}, organization = {R Foundation for Statistical Computing}, address = {Vienna, Austria}, year = {2025}, url = {<https://www.R-project.org/>}, }

We have invested a lot of time and effort in creating R, please cite it when using it for data analysis. See also ‘citation(“pkgname”)’ for citing R packages.