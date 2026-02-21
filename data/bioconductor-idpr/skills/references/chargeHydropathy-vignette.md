# Charge and Hydropathy Vignette

```
library(idpr)
```

## Background

The composition of amino acids and the overall chemistry of Intrinsically Disordered Proteins (IDPs) are distinctly different from that of ordered proteins. Each amino acid has unique chemical characteristics that can either favor a compact or an extended structure (Uversky, 2019) . Disorder-promoting residues, those enriched in IDPs, are typically hydrophilic, charged, or small residues. Order promoting residues, those enriched in structured proteins, tend to be aliphatic, hydrophobic, aromatic, or form tertiary structures (Uversky, 2013).
Therefore, there is a distinct difference of biochemistry between IDPs and ordered proteins.

It was shown in Uversky, Gillespie, & Fink (2000) that both high net charge and low mean hydropathy are properties of IDPs. One explanation is that a high net charge leads to increased repulsion of residues causing an extended structure and low hydrophobicity will reduce the hydrophobic interactions causing reduced protein packing. When both average net charge and mean scaled hydropathy are plotted, IDPs occupy a unique area on the plot. The barrier between unfolded and compact proteins is: \[<R> = 2.785 <H> - 1.151 \] where <R> is the absolute mean net charge and <H> is the mean scaled hydropathy (Uversky, Gillespie, & Fink, 2000).

An alternative version of the Charge Hydropathy plot mentioned was shown in Uversky (2016), where the average net charge is shown rather than the absolute value. This creates two cutoff lines. One for positively charged peptides: \[<R> = 2.785 <H> - 1.151 \] and another for negatively charged peptides: \[<R> = - 2.785 <H> + 1.151 \] (Uversky, 2016).

This plot allows a distinction between negative and positive proteins while preserving the information of the charge-hydropathy plot.

Further, a this can be used to identify folded regions on a protein. FoldIndex used this equation and set variables to 0 and using a sliding window, the resulting values would identify regions predicted as folded or unfolded. \[ Score = 2.785 <H> - \lvert<R>\rvert -1.151 \] When windows have a negative score (<0) sequences are predicted as disordered. When windows have a positive score (>0) sequences are predicted as ordered. This was described in Prilusky, J., Felder, C. E., et al. (2005).

## Installation

The idpr package can be installed from Bioconductor with the following line of code. It requires the BiocManager package to be installed

```
#BiocManager::install("idpr")
```

The most recent version of the package can be installed with the following line of code. This requires the devtools package to be installed.

```
#devtools::install_github("wmm27/idpr")
```

## Methods

Methods are originally described in Uversky, Gillespie, & Fink (2000). The calculations shown here are to explain how chargeHydropathyPlot() obtains the values for graphing, and are done automatically within the function.

Mean scaled hydropathy is calculated by normalizing the Kyte and Doolittle scale on a scale of 0 to 1, with Arg having a hydropathy of 0 and Ile having a hydropathy of 1, averaged by the sequence length (Kyte & Doolittle, 1982; Uversky, 2016).

Net charge is calculated with the Henderson-Hasselbalch equation (Po & Senozan, 2001). While there is not one agreed upon set of pKa values, the Isoelectric Point Calculator does a great job at unifying these data sets (Kozlowski, 2016). The net charge is then averaged over the sequence length.

Both values are plotted in the Charge-Hydropathy plot to identify a protein or proteins location in that space.

### Example calulations

Examples will use the *H. sapiens* TP53 sequence, acquired from UniProt (UniProt Consortium 2019) and stored within the **idpr** package for examples.

```
HUMAN_P53 <- TP53Sequences[2]
print(HUMAN_P53)
#>                                                                                                                                                                                                                                                                                                                                                                                            P04637|P53_HUMAN
#> "MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPSQAMDDLMLSPDDIEQWFTEDPGPDEAPRMPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQKTYQGSYGFRLGFLHSGTAKSVTCTYSPALNKMFCQLAKTCPVQLWVDSTPPPGTRVRAMAIYKQSQHMTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLRVEYLDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTSSSPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGSRAHSSHLKSKKGQSTSRHKKLMFKTEGPDSD"
```

The first portion is calculating the mean scaled hydropathy of the sequence. This will correspond to the value on the X-axis

```
P53_msh <- meanScaledHydropathy(HUMAN_P53)
print(P53_msh)
#> [1] 0.4159389
```

The second value is the net charge. Setting averaged = TRUE will average the calculated net charge by the sequence length.This will correspond to the value on the Y-axis. Total Net charge can be calculated by setting averaged to FALSE.

```
P53_nc <- netCharge(HUMAN_P53,
                     averaged = TRUE)
print(P53_nc)
#> [1] -0.01469136
```

The chargeHydropathyFunction will automatically calculate these values and plot it as a point within the charge-hydropathy space according to Uversky, Gillespie, & Fink (2000) / Uversky (2016)

Since a ggplot is returned, the user can assign the plot to an object to modify aesthetics and/or add annotations. The example shown here will label the cooridnates on the returned plot.

```
chargeHydropathyPlot(HUMAN_P53) +
  ggplot2::annotate("text",
                    x = P53_msh,
                    y = P53_nc + 0.1, #offset from point
                    label = paste("(", P53_msh, ", ", P53_nc, ")",
                                  collapse = "",
                                  sep = ""))
#> Warning: `aes_()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`
#> ℹ The deprecated feature was likely used in the idpr package.
#>   Please report the issue at <https://github.com/wmm27/idpr/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

---

## Using the chargeHydropathyPlot Function

The plot above shows calculations for one protein, but the function can accept multiple sequences.

The following examples will use highly similar TP53 sequences, acquired from UniProt (UniProt Consortium 2019) that were stored within the **idpr** package for examples.

```
TP53_Sequences <- TP53Sequences
print(TP53_Sequences)
#>                                                                                                                                                                                                                                                                                                                                                                                                      P02340|P53_MOUSE
#>              "MTAMEESQSDISLELPLSQETFSGLWKLLPPEDILPSPHCMDDLLLPQDVEEFFEGPSEALRVSGAPAAQDPVTETPGPVAPAPATPWPLSSFVPSQKTYQGNYGFHLGFLQSGTAKSVMCTYSPPLNKLFCQLAKTCPVQLWVSATPPAGSRVRAMAIYKKSQHMTEVVRRCPHHERCSDGDGLAPPQHLIRVEGNLYPEYLEDRQTFRHSVVVPYEPPEAGSEYTTIHYKYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRDSFEVRVCACPGRDRRTEEENFRKKEVLCPELPPGSAKRALPTCTSASPPQKKKPLDGEYFTLKIRGRKRFEMFRELNEALELKDAHATEESGDSRAHSSYLKTKKGQSTSRHKKTMVKKVGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      P04637|P53_HUMAN
#>           "MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPSQAMDDLMLSPDDIEQWFTEDPGPDEAPRMPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQKTYQGSYGFRLGFLHSGTAKSVTCTYSPALNKMFCQLAKTCPVQLWVDSTPPPGTRVRAMAIYKQSQHMTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLRVEYLDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTSSSPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGSRAHSSHLKSKKGQSTSRHKKLMFKTEGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                        P10361|P53_RAT
#>             "MEDSQSDMSIELPLSQETFSCLWKLLPPDDILPTTATGSPNSMEDLFLPQDVAELLEGPEEALQVSAPAAQEPGTEAPAPVAPASATPWPLSSSVPSQKTYQGNYGFHLGFLQSGTAKSVMCTYSISLNKLFCQLAKTCPVQLWVTSTPPPGTRVRAMAIYKKSQHMTEVVRRCPHHERCSDGDGLAPPQHLIRVEGNPYAEYLDDRQTFRHSVVVPYEPPEVGSDYTTIHYKYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRDSFEVRVCACPGRDRRTEEENFRKKEEHCPELPPGSAKRALPTSTSSSPQQKKKPLDGEYFTLKIRGRERFEMFRELNEALELKDARAAEESGDSRAHSSYPKTKKGQSTSRHKKPMIKKVGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      Q29537|P53_CANLF
#>                       "MEESQSELNIDPPLSQETFSELWNLLPENNVLSSELCPAVDELLLPESVVNWLDEDSDDAPRMPATSAPTAPGPAPSWPLSSSVPSPKTYPGTYGFRLGFLHSGTAKSVTWTYSPLLNKLFCQLAKTCPVQLWVSSPPPPNTCVRAMAIYKKSEFVTEVVRRCPHHERCSDSSDGLAPPQHLIRVEGNLRAKYLDDRNTFRHSVVVPYEPPEVGSDYTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNVLGRNSFEVRVCACPGRDRRTEEENFHKKGEPCPEPPPGSTKRALPPSTSSSPPQKKKPLDGEYFTLQIRGRERYEMFRNLNEALELKDAQSGKEPGGSRAHSSHLKAKKGQSTSRHKKLMFKREGLDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      Q00366|P53_MESAU
#>        "MEEPQSDLSIELPLSQETFSDLWKLLPPNNVLSTLPSSDSIEELFLSENVAGWLEDPGEALQGSAAAAAPAAPAAEDPVAETPAPVASAPATPWPLSSSVPSYKTYQGDYGFRLGFLHSGTAKSVTCTYSPSLNKLFCQLAKTCPVQLWVSSTPPPGTRVRAMAIYKKLQYMTEVVRRCPHHERSSEGDGLAPPQHLIRVEGNMHAEYLDDKQTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDPSGNLLGRNSFEVRICACPGRDRRTEEKNFQKKGEPCPELPPKSAKRALPTNTSSSPQPKRKTLDGEYFTLKIRGQERFKMFQELNEALELKDAQALKASEDSGAHSSYLKSKKGQSASRLKKLMIKREGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      O09185|P53_CRIGR
#>           "MEEPQSDLSIELPLSQETFSDLWKLLPPNNVLSTLPSSDSIEELFLSENVTGWLEDSGGALQGVAAAAASTAEDPVTETPAPVASAPATPWPLSSSVPSYKTYQGDYGFRLGFLHSGTAKSVTCTYSPSLNKLFCQLAKTCPVQLWVNSTPPPGTRVRAMAIYKKLQYMTEVVRRCPHHERSSEGDSLAPPQHLIRVEGNLHAEYLDDKQTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDPSGNLLGRNSFEVRICACPGRDRRTEEKNFQKKGEPCPELPPKSAKRALPTNTSSSPPPKKKTLDGEYFTLKIRGHERFKMFQELNEALELKDAQASKGSEDNGAHSSYLKSKKGQSASRLKKLMIKREGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      Q9TTA1|P53_TUPBE
#>           "MEEPQSDPSVEPPLSQETFSDLWKLLPENNVLSPLPSQAMDDLMLSPDDIEQWFTEDPGPDEAPRMPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQKTYQGSYGFRLGFLHSGTAKSVTCTYSPDLNKLFCQLAKTCPVQLWVDSAPPPGTRVRAMAIYKQSQYVTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLHAEYSDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGKLLGRNSFEVRICACPGRDRRTEEENFRKKGESCPKLPTGSIKRALPTGSSSSPQPKKKPLDEEYFTLQIRGRERFEMLREINEALELKDAMAGKESAGSRAHSSHLKSKKGQSTSRHRKLMFKTEGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                                      Q95330|P53_RABIT
#>             "MEESQSDLSLEPPLSQETFSDLWKLLPENNLLTTSLNPPVDDLLSAEDVANWLNEDPEEGLRVPAAPAPEAPAPAAPALAAPAPATSWPLSSSVPSQKTYHGNYGFRLGFLHSGTAKSVTCTYSPCLNKLFCQLAKTCPVQLWVDSTPPPGTRVRAMAIYKKSQHMTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLRAEYLDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRNSFEVRVCACPGRDRRTEEENFRKKGEPCPELPPGSSKRALPTTTTDSSPQTKKKPLDGEYFILKIRGRERFEMFRELNEALELKDAQAEKEPGGSRAHSSYLKAKKGQSTSRHKKPMFKREGPDSD"
#>                                                                                                                                                                                                                                                                                                                                                                                           A0A2I2Y7Z8|A0A2I2Y7Z8_GORGO
#> "MDDLMLSPDDIEQWFTEDPGPDEAPRMPEAAPPVAPAPAAPTPAAPAPAPSWPLSSSVPSQKTYQGSYGFRLGFLHSGTAKSVTCTYSPTLNKMFCQLAKTCPVQLWVDSTPPPGTRVRAMAIYKQSQHMTEVVRRCPHHERCSDSDGLAPPQHLIRVEGNLRVEYLDDRNTFRHSVVVPYEPPEVGSDCTTIHYNYMCNSSCMGGMNRRPILTIITLEDSSGNLLGRNSFEVRVCACPGRDRRTEEENLRKKGEPHHELPPGSTKRALPNNTSSSPQPKKKPLDGEYFTLQIRGRERFEMFRELNEALELKDAQAGKEPGGRNAKHSPGDPDPPLSETFNLNICPYPAGKLELLKLSPCPCLCRQVTLMSFLFFLIFFYFRLYWGIIEPPKLHTFKVCSVMI"
```

```
gg <- chargeHydropathyPlot(
  sequence = TP53_Sequences,
  pKaSet = "IPC_protein")
plot(gg)
#> Warning in ggplot2::geom_segment(aes(x = intersectionPointX, y = 0, xend = positiveBoundaryX, : All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_segment(aes(x = intersectionPointX, y = 0, xend = negativeBoundaryX, : All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_segment(aes(x = insolubleValue, y = insolubleMax, : All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_label(aes(x = 0.85, y = 0.35, label = "Insoluble Proteins")): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_label(aes(x = 0.7, y = 0.5, label = "Collapsed Proteins")): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_label(ggplot2::aes(x = 0.4, y = 0.8, label = "Extended IDPs")): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_segment(ggplot2::aes(x = 1, y = 0, xend = 0, yend = 1)): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_segment(ggplot2::aes(x = 1, y = 0, xend = 0, yend = -1.125)): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_segment(ggplot2::aes(x = 0, y = 1, xend = 0, yend = -1.125)): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
```

![](data:image/png;base64...)

Since it is a ggplot, the user can add additional parameters to the plot like labels, custom themes, and other supported features. An example of this is shown in “Methods”.

If you do not wish to use the IPC\_protein pKa set, you can change this to any accepted by netCharge().

```
chargeHydropathyPlot(
  sequence = TP53_Sequences,
  pKaSet = "EMBOSS")  #Using EMBOSS pKa set
#> Warning in ggplot2::geom_segment(aes(x = intersectionPointX, y = 0, xend = positiveBoundaryX, : All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_segment(aes(x = intersectionPointX, y = 0, xend = negativeBoundaryX, : All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_segment(aes(x = insolubleValue, y = insolubleMax, : All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_label(aes(x = 0.85, y = 0.35, label = "Insoluble Proteins")): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_label(aes(x = 0.7, y = 0.5, label = "Collapsed Proteins")): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_label(ggplot2::aes(x = 0.4, y = 0.8, label = "Extended IDPs")): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_segment(ggplot2::aes(x = 1, y = 0, xend = 0, yend = 1)): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_segment(ggplot2::aes(x = 1, y = 0, xend = 0, yend = -1.125)): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning in ggplot2::geom_segment(ggplot2::aes(x = 0, y = 1, xend = 0, yend = -1.125)): All aesthetics have length 1, but the data has 9 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
```

![](data:image/png;base64...)

## Using FoldIndexR to predict folded and unfolded windows.

Predictions are made on a scale of -1 to 1, where any residues with a negative score are predicted disordered (green; under 0), and any residue with a positive score are predicted ordered (purple; above 0).

Functionally, this uses a large sliding window, (default 51) as described in Prilusky, J., Felder, C. E., et al. (2005), for both scaled hydropathy and local charge.

```
foldIndexR(sequence = HUMAN_P53,
           plotResults = TRUE)
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the idpr package.
#>   Please report the issue at <https://github.com/wmm27/idpr/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

## Calculating Scaled Hydropathy

### Mean Scaled Hydropathy

meanScaledHydropathy is used to calculate the scaled hydropathy of a sequence. See the introduction and methods for more details.

```
 meanScaledHydropathy(HUMAN_P53)
#> [1] 0.4159389
```

### Global Hydropathy

scaledHydropathyGlobal is used to match the scaled hydropathy of an amino acid sequence for each residue in the sequence.

The results can be a data frame of matched values. It will result in a data frame with 3 columns. The first column is “Position”, which indicates the numeric position of the residue in the submitted sequence. The second column is “AA”, which indicates the amino acid residue as a single letter. The third column is “Hydropathy”, which indicates the value of scaled hydropathy for that residue, which was matched by the function.

```
P53_shg <- scaledHydropathyGlobal(HUMAN_P53)
head(P53_shg)
#>   Position AA Hydropathy
#> 1        1  M      0.711
#> 2        2  E      0.111
#> 3        3  E      0.111
#> 4        4  P      0.322
#> 5        5  Q      0.111
#> 6        6  S      0.411
```

Or results can be returned as a plot

```
scaledHydropathyGlobal(HUMAN_P53,
                       plotResults = TRUE)
```

![](data:image/png;base64...)

(This is not the most aesthetically pleasing plot, so a sequenceMap from **idpr** is reccomended in this case for visualizations.)

```
P53_shg <- scaledHydropathyGlobal(HUMAN_P53)
sequenceMap(sequence = P53_shg$AA,
            property = P53_shg$Hydropathy,
            customColors = c("chocolate1", "grey65", "skyblue3"))
```

![](data:image/png;base64...)

### Local Hydrophobicity

scaledHydropathyLocal is a function used to calculate the average hydrophobicity of a sequence using a sliding window. The results are returned as a data frame or a plot.

The scaled hydropathy is matched to each residue then the average of each window is calculated.

This can be helpful to identify regions of high or low hydrophobicity within a protein. This may help with identifying IDRs as well.

Results can be returned as a data frame of window hydropathy scores. It will result in a data frame with 3 columns. The first column is “Position”, which indicates the numeric position of the residue in the submitted sequence. The second column is “Window” which indicates all the residues within the sliding window that were used for calculations. The “CenterResidue” column specifies the amino acid residue as a single letter that is located in the center of the window and is located at the number specified by “Position” And finally, the “WindowHydropathy” is the calculated average hydropathy for the residues specified in the “Window” column.

```
P53_shl <- scaledHydropathyLocal(HUMAN_P53,
                                 plotResults = FALSE)
head(P53_shl)
#>   Position    Window CenterResidue WindowHydropathy
#> 1        5 MEEPQSDPS             Q        0.2912222
#> 2        6 EEPQSDPSV             S        0.3196667
#> 3        7 EPQSDPSVE             D        0.3196667
#> 4        8 PQSDPSVEP             P        0.3431111
#> 5        9 QSDPSVEPP             S        0.3431111
#> 6       10 SDPSVEPPL             V        0.4332222
```

The results can also return a plot that shows each window’s hydropathy score along the sequence.

```
scaledHydropathyLocal(HUMAN_P53,
                       plotResults = TRUE)
```

![](data:image/png;base64...)

The window size can be specified as well by the “window” argument. **This must be an odd integer**

```
scaledHydropathyLocal(HUMAN_P53,
                       window = 3,
                       plotResults = TRUE)
```

![](data:image/png;base64...)

## Calculating Charge

### Net Charge

netCharge is used to calculate the net charge of a sequence. See the introduction and methods for more details.

```
netCharge(HUMAN_P53)
#> [1] -5.773703
```

Setting averaged = TRUE will average the calculated net charge by the sequence length (Shown before in methods).

```
netCharge(HUMAN_P53,
          averaged = TRUE)
#> [1] -0.01469136
```

netCharge relies on the Henderson-Hasselbalch equation (via the hendersonHasselbalch function). Therefore the pH and pKa are critical for calculations. netCharge allows for different pH values using the pH argument.

```
netCharge(HUMAN_P53,
          pH = 5.5)
#> [1] 5.572653
netCharge(HUMAN_P53,
          pH = 7)
#> [1] -5.773703
netCharge(HUMAN_P53,
          pH = 8)
#> [1] -13.01845
```

There are also many pKa sets that are preloaded in **idpr**. pKa datasets used within this vignette are cited. See the documentation for netCharge or pKaData within **idpr** for additional information and citations for available pKa sets. Additionally, see Kozlowski (2016) for further details on pKa data sets.

* “EMBOSS” - (Rice, Longden, & Bleasby, 2000)
* “DTASelect”
* “Solomons”
* “Sillero”
* “Rodwell”
* “Lehninger”
* “Toseland”
* “Thurlkill”
* “Nozaki”
* “Dawson”
* “Bjellqvist”
* “ProMoST”
* “Vollhardt”
* “IPC\_protein” (Kozlowski, 2016).
* “IPC\_peptide” (Kozlowski, 2016).

```
netCharge(HUMAN_P53,
          pKaSet = "IPC_protein")
#> [1] -5.773703
netCharge(HUMAN_P53,
          pKaSet = "IPC_peptide")
#> [1] -3.286671
netCharge(HUMAN_P53,
          pKaSet = "EMBOSS")
#> [1] -1.404403
```

Alternatively, the user may supply a custom pKa dataset. The format must be a data frame where: Column 1 must be a character vector of residues AND Column 2 must be a numeric vector of pKa values. This can be helpful if there is a data set the user prefers or if there are noncannonical amino acids. Here is an example using the pKa values from Wikipedia (Proteinogenic amino acid, n.d.). <https://en.wikipedia.org/wiki/Proteinogenic_amino_acid#Chemical_properties>

```
print(custom_pKa)
#>    AA   pKa
#> 1   C  8.55
#> 2   D  3.67
#> 3   E  4.25
#> 4   H  6.54
#> 5   K 10.40
#> 6   R 12.30
#> 7   Y  9.84
#> 8 NH3  9.28
#> 9 COO  1.99

netCharge(HUMAN_P53,
          pKaSet = custom_pKa,
          includeTermini = FALSE)
#> [1] -1.143015
```

### Global Charge Distibution

chargeCalculationGlobal is a function used to calculate the charge of each residue, independent of other amino acids, within a sequence. The results are returned as a data frame (default) or a plot.

chargeCalculationGlobal accepts the same pKa and pH arguments as netCharge.

The results can return a data frame of charge for each residue

It will result in a data frame with 3 columns. The first column is “Position”, which indicates the numeric position of the residue in the submitted sequence. The second column is “AA”, which indicates the amino acid residue as a single letter. The third column is “Charge”, which indicates the calculated charge for the residue at the specified pH.

```
P53_ccg <- chargeCalculationGlobal(HUMAN_P53)
head(P53_ccg)
#>   Position AA     Charge
#> 1        1  M  0.9920106
#> 2        2  E -0.9974244
#> 3        3  E -0.9974244
#> 4        4  P  0.0000000
#> 5        5  Q  0.0000000
#> 6        6  S  0.0000000
```

The results can return a ggplot visualizing the charge distribution.

```
chargeCalculationGlobal(HUMAN_P53,
                        plotResults = TRUE)
```

![](data:image/png;base64...)

(This is not the most aesthetically pleasing plot, so a sequenceMap from **idpr** is recommended in this case for visualizations.)

```
P53_ccg <- chargeCalculationGlobal(HUMAN_P53) #repeating from above
sequenceMap(sequence = P53_ccg$AA,
            property = P53_ccg$Charge,
            customColors = c("red", "blue", "grey65"))
```

![](data:image/png;base64...)

The C-terminus here has a charge of ~ -2 since the function aggregates the termini values with residue charges by default. If you wish to calculate the termini as separate values, use sumTermini = FALSE. This will add 2 residues to the data frame as “NH3” and “COO”

```
P53_ccg <- chargeCalculationGlobal(HUMAN_P53,
                        sumTermini = FALSE)
head(P53_ccg)
#>   Position  AA     Charge
#> 1        0 NH3  0.9920106
#> 2        1   M  0.0000000
#> 3        2   E -0.9974244
#> 4        3   E -0.9974244
#> 5        4   P  0.0000000
#> 6        5   Q  0.0000000
```

If you wish to completely ignore the termini for calculation, set includeTermini = FALSE.

```
P53_ccg <- chargeCalculationGlobal(HUMAN_P53,
                        includeTermini = FALSE)
head(P53_ccg)
#>   Position AA     Charge
#> 1        1  M  0.0000000
#> 2        2  E -0.9974244
#> 3        3  E -0.9974244
#> 4        4  P  0.0000000
#> 5        5  Q  0.0000000
#> 6        6  S  0.0000000
```

### Local Charge

chargeCalculationLocal is a function used to calculate the charge of a sequence using a sliding window. The results are returned as a data frame (default) or a plot.

chargeCalculationLocal accepts the same pKa and pH arguments as netCharge.

Unlike chargeCalculationGlobal, the chargeCalculationLocal function does not consider termini for calculations.

Results can be returned as a data frame of window hydropathy scores. It will result in a data frame with 4 columns. The first column is “Position”, which indicates the numeric position of the residue in the submitted sequence. The “CenterResidue” column specifies the amino acid residue as a single letter that is located in the center of the window and is located at the number specified by “Position”. The “Window” column contains all the residues within the sliding window that were used for calculating the charge. And finally, the “windowCharge” is the calculated average charge for the residues specified in the “Window” column.

```
P53_cgl <- chargeCalculationLocal(HUMAN_P53)
head(P53_cgl)
#>   Position CenterResidue    Window windowCharge
#> 1        5             Q MEEPQSDPS   -0.3326783
#> 2        6             S EEPQSDPSV   -0.3326783
#> 3        7             D EPQSDPSVE   -0.3326783
#> 4        8             P PQSDPSVEP   -0.2218534
#> 5        9             S QSDPSVEPP   -0.2218534
#> 6       10             V SDPSVEPPL   -0.2218534
```

Alternatively, results can be returned as a plot of each window’s charge.

```
chargeCalculationLocal(HUMAN_P53,
                       plotResults = TRUE)
```

![](data:image/png;base64...)

The window size can be specified as well via the “window” argument. **This must be an odd integer**

```
chargeCalculationLocal(HUMAN_P53,
                       window = 11,
                       plotResults = TRUE)
```

![](data:image/png;base64...)

## References

### Packages Used

```
citation("ggplot2")
#> To cite ggplot2 in publications, please use
#>
#>   H. Wickham. ggplot2: Elegant Graphics for Data Analysis.
#>   Springer-Verlag New York, 2016.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Book{,
#>     author = {Hadley Wickham},
#>     title = {ggplot2: Elegant Graphics for Data Analysis},
#>     publisher = {Springer-Verlag New York},
#>     year = {2016},
#>     isbn = {978-3-319-24277-4},
#>     url = {https://ggplot2.tidyverse.org},
#>   }
```

### Citations

### References

Consortium, T. U. (2018). UniProt: a worldwide hub of protein knowledge. Nucleic acids research, 47(D1), D506-D515. doi:10.1093/nar/gky1049

Kozlowski, L. P. (2016). IPC – Isoelectric Point Calculator. Biology Direct, 11(1), 55. doi:10.1186/s13062-016-0159-9

Kyte, J., & Doolittle, R. F. (1982). A simple method for displaying the hydropathic character of a protein. Journal of molecular biology, 157(1), 105-132.

Po, H. N., & Senozan, N. (2001). The Henderson-Hasselbalch equation: its history and limitations. Journal of Chemical Education, 78(11), 1499.

Prilusky, J., Felder, C. E., et al. (2005). FoldIndex: a simple tool to predict whether a given protein sequence is intrinsically unfolded. Bioinformatics, 21(16), 3435-3438.

Proteinogenic amino acid. (n.d.). In Wikipedia. Retrieved July 12th, 2020. <https://en.wikipedia.org/wiki/Proteinogenic_amino_acid#Chemical_properties>

Rice, P., Longden, I., & Bleasby, A. (2000). EMBOSS: The European Molecular Biology Open Software Suite. Trends in Genetics, 16(6), 276-277. doi:10.1016/S0168-9525(00)02024-2

Uversky, V. N. (2013). A decade and a half of protein intrinsic disorder: Biology still waits for physics. Protein Science, 22(6), 693-724. doi:10.1002/pro.2261

Uversky, V. N. (2016). Paradoxes and wonders of intrinsic disorder: Complexity of simplicity. Intrinsically Disordered Proteins, 4(1), e1135015. doi:10.1080/21690707.2015.1135015

Uversky, V. N. (2019). Intrinsically Disordered Proteins and Their “Mysterious” (Meta)Physics. Frontiers in Physics, 7(10). doi:10.3389/fphy.2019.00010

Uversky, V. N., Gillespie, J. R., & Fink, A. L. (2000). Why are “natively unfolded” proteins unstructured under physiologic conditions?. Proteins: structure, function, and bioinformatics, 41(3), 415-427. [https://doi.org/10.1002/1097-0134(20001115)41:3](https://doi.org/10.1002/1097-0134%2820001115%2941%3A3)<415::AID-PROT130>3.0.CO;2-7

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
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] idpr_1.20.0
#>
#> loaded via a namespace (and not attached):
#>  [1] crayon_1.5.3       vctrs_0.6.5        cli_3.6.5          knitr_1.50
#>  [5] rlang_1.1.6        xfun_0.53          generics_0.1.4     S7_0.2.0
#>  [9] jsonlite_2.0.0     labeling_0.4.3     glue_1.8.0         plyr_1.8.9
#> [13] htmltools_0.5.8.1  sass_0.4.10        scales_1.4.0       rmarkdown_2.30
#> [17] grid_4.5.1         tibble_3.3.0       evaluate_1.0.5     jquerylib_0.1.4
#> [21] fastmap_1.2.0      yaml_2.3.10        lifecycle_1.0.4    compiler_4.5.1
#> [25] dplyr_1.1.4        RColorBrewer_1.1-3 Rcpp_1.1.0         pkgconfig_2.0.3
#> [29] farver_2.1.2       digest_0.6.37      R6_2.6.1           tidyselect_1.2.1
#> [33] dichromat_2.0-0.1  pillar_1.11.1      magrittr_2.0.4     bslib_0.9.0
#> [37] withr_3.0.2        tools_4.5.1        gtable_0.3.6       ggplot2_4.0.0
#> [41] cachem_1.1.0
```

```
citation()
```

To cite R in publications use:

R Core Team (2025). *R: A Language and Environment for Statistical Computing*. R Foundation for Statistical Computing, Vienna, Austria. <https://www.R-project.org/>.

A BibTeX entry for LaTeX users is

@Manual{, title = {R: A Language and Environment for Statistical Computing}, author = {{R Core Team}}, organization = {R Foundation for Statistical Computing}, address = {Vienna, Austria}, year = {2025}, url = {<https://www.R-project.org/>}, }

We have invested a lot of time and effort in creating R, please cite it when using it for data analysis. See also ‘citation(“pkgname”)’ for citing R packages.