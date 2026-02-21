# Rapid Comparison of Surface Protein Isoform Membrane Topologies Through surfaltr

#### Aditi Merchant & Pooja Gangras

---

## **Abstract**

Cell surface proteins are of great biomedical relevance, serving as cell type differentiators and indicators of disease states.1 Consequently, proteins on the plasma membrane form a major fraction of the druggable proteome and are also used to target novel therapeutic modalities to specific cells.1 Alternatively spliced surface protein isoforms have been shown to differ based on their localization within cells and their transmembrane (TM) topology.1,2 Thus, in depth analysis of cell surface protein isoforms can not only expand the diversity of the druggable proteome but also aid in differentiating delivery between closely related cell types. The transcriptomic and proteomic approaches available today make it possible to identify several novel alternatively spliced isoforms.3 However, there exists a need for bioinformatic approaches to streamline batch processing of isoforms to predict and visualize their TM topologies. To address this gap, we have developed an R package, surfaltr, which matches inputted novel or alternative isoforms to their annotated principal counterparts, rapidly predicts their TM topologies, and generates a user-friendly graphical output. Further, surfaltr facilitates the prioritization of biologically diverse isoform pairs through the incorporation of three different ranking metrics in the graphical output and through several protein alignment functions. This vignette explains how the package can be used and demonstrates two different workflows starting from either Ensembl transcript ID’s or amino acid sequence inputs.

## **Installation**

#### **surfaltr Installation**

surfaltr is freely available for download via Bioconductor. surfaltr has some dependencies which should all be installed/imported automatically when the code shown below is run to install surfaltr:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("surfaltr")
```

To load surfaltr, the following code can be used:

```
library(surfaltr)
```

The dependencies of the package that are automatically imported include: dplyr (>= 1.0.6), biomaRt(>= 2.46.0), protr (>= 1.6-2), seqinr (>= 4.2-5), ggplot2 (>= 3.3.2), utils (>= 2.10.1), stringr (>= 1.4.0), Biostrings(>= 2.58.0), readr (>= 1.4.0), httr (>= 1.4.2), testthat (>= 3.0.0), xml2 (>= 1.3.2), msa(>= 1.22.0), methods (>= 4.0.3)

The dependency of the package which is NOT automatically imported: TMHMM standalone software

surfaltr predicts TM domains either using TMHMM standalone software OR using the Phobius API. If the user intends to use the TMHMM fuctionality of surfaltr then they must install the TMHMM standalone software (details below).

#### **When to Use Phobius or TMHMM**

In terms of prediction specificity, Phobius’s ability to detect signal peptides contributes to a greater amount of detail than TMHMM. Additionally, as all sequences are run using an API as opposed to local software, the run time for Phobius is also slightly lower. However, if a protein has no TM domains and no signal peptide, Phobius automatically flags the protein as internal, which is not always true and should be verified experimentally before drawing any conclusions. If sequences are considered private information and should not be posted externally, we recommend using TMHMM to ensure everything is run locally.

#### **Phobius Installation**

As run\_phobius() relies on the Phobius API, a copy of the software does not need to be downloaded on the user’s device and will instead automatically be called by the surfaltr functions.

#### **TMHMM Standalone Software Installation**

In order to be able to use TMHMM4 within surfaltr to predict membrane topology, it is important to first ensure that you have TMHMM 2.0 standalone software installed on your computer. To do this,
1. Navigate to <https://services.healthtech.dtu.dk/service.php?TMHMM-2.0>   2. follow directions for installation of Linux version of standalone software (tmhmm-2.0c.Linux.tar.gz).
3. Untar the tmhmm-2.0c.Linux.tar.gz file.
4. Extract it to a place where you store software.
5. Insert the correct path for perl 5.x in the first line of the scripts bin/tmhmm and bin/tmhmmformat.pl (if not /usr/local/bin/perl or #!/usr/bin/env perl). Use which perl and 6. perl -v in the terminal to help find the correct path.
6. Make sure you have an executable version of decodeanhmm in the bin directory.
7. Make sure to record the path to which TMHMM 2.0 is installed, as this information will be needed in order to run TMHMM in future functions.
TMHMM license and thus the TMHMM 2.0 standalone software is freely available to all academic institutions upon request from the official website linked above.

#### **Troubleshooting TMHMM Installation**

If the TMHMM standlone software is NOT installed in the correct path or folder you will receive error messages when running surfaltr functions. In this scenario please check the directory in which TMHMM2.0c was downloaded and make sure that the directory structure is as such: path/to/folder/TMHMM2.0c/bin/decodeanhmm.linux

TMHMM may get downloaded with the following directory names and structure: path/to/folder/TMHMM2.0c/tmhmm-2.0c/decodeanhmm.Linux\_x86\_64 Please fix the directory structure to be the one shown above to use TMHMM within surfaltr. OR run the following code:

```
check_tmhmm_install(path/to/folder/TMHMM2.0c)
```

This function also prints a helpful method providing tips on how to fix the installation if TMHMM is not found at the folder path specified. If TMHMM installation is problematic for some reason we recommend only using the Phobius method within surfaltr to predict TM domains.

## **surfaltr pipeline and quick start**

surfaltr allows users to have dynamic options about which output they want to receive through the presence of consensus functions allowing for rapid processing and individual functions producing intermediate outputs. surfaltr allows users to pair novel isoforms or condition/tissue associated alternatively/mis-spliced isoforms with their counterpart principal isoforms, as annotated by APPRIS5. It then predicts the TM topologies of isoform pairs using either TMHMM or Phobius, as inputted by user, and generates a plot for rapid cross-isoform comparison. Finally, it allows the user to generate cross-organism and single organism multiple sequence alignments of isoform pairs through the standalone functions align\_prts() and align\_org\_prts(). All functionalities withing surfaltr are dependent on the most recent Ensembl human and mouse annotations (GRCh38.p13 and GRCm39 respectively) . The overall workflow of surfaltr is shown in the figure below:

![](data:image/png;base64...) Figure 1: Overall surfaltr workflow and functions.

Now we describe the overall functions which will generate a plot of TM topologies for transcripts-of- interest paired with gene-matched annotated principal isoforms. To rapidly generate isoform pair plots, the functions graph\_from\_ids() or graph\_from\_aas() can be used. If you are using the graph\_from\_ids() function, input data should be formatted with only gene names and transcript IDs according to guidelines detailed in the [“Obtaining and Formatting Input Data Section”](#Obtaining_and_Formatting_Input_Data). If you are using the graph\_from\_aas() function, input data should be formatted with gene names, unique transcript identifiers, and amino acid sequences according to guidelines detailed in the [“Obtaining and Formatting Input Data Section”](#Obtaining_and_Formatting_Input_Data). Other input parameters are described in detail in the [“Rapid Plotting of Paired Isoforms”](#Rapid_Plotting_of_Paired_Isoforms) section below.

```
graph_from_aas(data_file = system.file("extdata", "CRB1.csv", package="surfaltr"),
               organism = "mouse", rank = "combo",
               n_prts = 20, mode = "phobius", size_txt = 2, space_left = -400,
               temp = FALSE)

graph_from_ids(data_file = system.file("extdata", "hpa_genes.csv",package="surfaltr"),
               organism = "human",
               rank = "combo", n_prts = 20, mode = "phobius", size_txt = 2,
               space_left = -400, temp = FALSE)
```

## **How to get help for surfaltr**

All questions can be emailed to the maintainer at gangras\_pooja@lilly.com.

## **Input data**

As mentioned above, surfaltr is able to process two different forms of inputs: transcript IDs and amino acid sequences. This enables surfaltr to process novel transcripts in addition to transcripts already documented on Ensembl and annotated by APPRIS.

## **Obtaining and Formatting Input Data**

Input to the surfaltr package must be formatted as a comma separated text file either 1) containing transcript ID’s and corresponding gene names or 2) containing amino acid sequences for novel isoforms with unique identifiers and corresponding gene names. For files containing only transcript IDs and gene names, column names should be titled “gene\_name” and “transcript”. For files containing amino acid sequences, columns should be titled “external\_gene\_name”, “transcript\_id”, and “protein\_sequence”. The input transcripts and amino acid sequences can be derived from multiple upstream analysis procedures such as differential isoform expression analysis, long read sequencing for identification of novel isoforms, and others.

#### **Why filter genes known to encode surface proteins?**

While surfaltr can be used to plot topology of several proteins with the limit being set by the bulk processing power of TMHMM standalone software and Phobius web server, we recommend limiting input to isoforms of genes known to encode surface proteins. This can be done by using existing protein repositories and annotation systems such as Uniprot and Surfacegenie6 to filter out isoforms that map to genes known not to encode surface proteins. This pre-processing step will ensure optimum performance of the package.

#### **Gene name and transcript ID’s input (Input type 1)**

The example input table containing data from Uhlén et al. 7 is shown below with column names “gene\_name” and “transcript”. This matches the format required for surfaltr to be able to process ID-based input data. This exmaple dataset is provided along with the package for the user and can be loaded

| gene\_name | transcript |
| --- | --- |
| IGSF1 | ENST00000370903 |
| TAPBP | ENST00000434618 |
| CD300LG | ENST00000377203 |
| SEZ6L2 | ENST00000346932 |
| SEZ6L2 | ENST00000346932 |
| CD8A | ENST00000352580 |

#### **Gene name and amino acid sequence input (Input type 2)**

The example input table containing data from Ray et al. 8 is shown below with column names “external\_gene\_name”, “transcript\_id”, and “protein\_sequence”. This matches the format required for surfaltr to be able to process amino acid sequence-based input data.

| external\_gene\_name | transcript\_id | protein\_sequence |
| --- | --- | --- |
| Crb1 | ENS1 | MKLKRTAYLLFLYLSSSLLICIKNSFCNKNNTRCLSGPCQNNSTCKHFPQDNNCCLDTANNLDKDCEDLK… |
| Crb1 | ENS2 | MNADPSLVSTVPHVRTLQGATPVTVHLDSLESTVNSALMNVKVSRVSMEVYVWMEETGIHCEEDVDECLL… |
| Igsf9 | ENS3 | MIWCLRLTVLSLIISQGADGRRKPEVVSVVGRAGESAVLGCDLLPPAGHPPLHVIEWLRFGFLLPIFIQF… |
| Igsf9 | ENS4 | MIWCLRLTVLSLIISQGADGRRKPEVVSVVGRAGESAVLGCDLLPPAGHPPLHVIEWLRFGFLLPIFIQF… |
| Igsf9 | ENS5 | MKVAGGPMGILRPLILSPRPGLEVYPSRTQLPGLLPQPVLAGVVGGVCFLGVAVLVSILAACLMNRRRAA… |
| Igsf9 | ENS6 | MIWCLRLTVLSLIISQGADGRRKPEVVSVVGRAGESAVLGCDLLPPAGHPPLHVIEWLRFGFLLPIFIQF… |

## **About the example datasets**

The example datasets have been derived from two different sources and saved in the data/ folder within the package installation and in the data/ folder on the surfaltr package.

1. For the transcript ID input, we have included 10 unique transcripts from 7 different genes annotated as alternative by APPRIS. These genes were derived from supplementary data 12 from Uhlén et al. 7. This data has been formatted to be compatible with the package as described [above](#exid).
2. For the amino acid input, we have utilized the supplementary data 1 from Ray et al. 8. This data includes novel isoforms expressed in mouse retina identified by long read sequencing and further validated by cell surface proteomics approaches. The data has been formatted to be compatible with the package as described [above](#exaa).

## **Rapid Plotting of Paired Isoforms**

As mentioned in [quick start](#qs), overall functions graph\_from\_ids() or graph\_from\_aas() can be used to directly generate TM topology plots of paired isoforms from input isoform ID/AA seq .csv files.

*Note: For a standard number of transcripts (25-50), the run time can be expected to be 1-2 minutes. If a large number of transcripts are provided (e.g. 500), the run time can be expected to be closer to 15 minutes. Occasionally, if Ensembl BioMart, TMHMM, or Phobius is down, run time can take much longer. In the event that a function has been running for more than 30 minutes, please stop the function and try again later.*

#### **From known Ensembl Transcript Models (Input type 1)**

When a .csv file containing known [Ensemble transcript IDs and gene names](#exid) is provided, the graph\_from\_ids() function can be utilized to obtain the completed plot of paired isoforms. Additionally, the function can include optional inputs summarized in the table below:

| Input.Variable | Description | Parameters | Default | Example | Recommended.Values |
| --- | --- | --- | --- | --- | --- |
| data\_file | Path/to/input .csv file | String containing path | N/A | "~/gene \_id\_data.csv" | N/A |
| organism | Organism from gene information is derived from | “mouse”, “human” | | hu | an | “mouse” | | N/A |
| rank | Method to rank which isoform pairs are most significant | “combo”, “length”, T |  | l | ngth | “combo” | | N/A |
| n\_prts | Number of genes to display isoforms from | Integer | 20 | 15 | 5 to 25 |
| mode | TM topology prediction model to use | “phobius”, “tmhmm” | | pho | ius | “tmhmm” | | N/A |
| size\_txt | Size of text of transcript labels on resultant plot | Double | 2 | 3 | 0.5 to 4 |
| space\_left | Amount of space in graph left of start of topology bars for transcript labels | Double | -400 | -150 | -100 to -500 |
| temp | States whether output files should be deleted after run | Boolean | FALSE | FALSE | FALSE |
| tmhmm\_folder\_name | Path/to/TMHMM 2.0/folder | String containing path | NULL | “~/TMHMM2.0c” | Path if mode is TMHMM, Null if mode is Phobius |

An example of the code required to run this function applied to the Uhlén et al. 7. data is shown below:

```
graph_from_ids(data_file = system.file("extdata", "hpa_genes.csv",package="surfaltr"), organism = "human",
               rank = "combo", n_prts = 20, mode = "phobius", size_txt = 2,
               space_left = -400, tmhmm_folder_name = NULL)
```

#### **From Amino Acid Sequence Input (Input type 2)**

When a .csv file containing [gene names and amino acid sequences is provided](#exaa), the graph\_from\_aas() function can be utilized to obtain the completed plot of paired isoforms. Additionally, the function can also include the optional inputs summarized in the table [above](#ti).

An example of the code required to run this function applied to the Ray et al. 8 data is shown below:

```
graph_from_aas(data_file = system.file("extdata", "CRB1.csv", package="surfaltr"), organism = "mouse", rank = "TM",
               n_prts = 10, mode = "phobius", size_txt = 2, space_left = -400,
               tmhmm_folder_name = NULL)
```

## **Isoform Pairing of Input Data and FASTA File Generation**

If the user is taking a sequential approach instead of using the overall functions, the following functions can be used to generate intermediate output. The first function that needs to be run is the get\_pairs() function, which retrieves APPRIS annotations, pairs alternative and principal isoforms together, and retrieves amino acid sequences to create a FASTA file. In order to function correctly, the input data needs to follow the format mentioned [above](#Obtaining_and_Formatting_Input_Data). The input parameters include a string containing the path to the input data file (data\_file), a boolean stating if the data contains amino acids (if\_aa), a string with the organism the data is derived from (organism), and a boolean stating if output files should be deleted after running (temp, recommended to always be FALSE). More details about these parameters can be found [above](#ti).

The output of the function contains two separate components: 1) a data frame containing the paired isoforms along with APPRIS annotations and amino sequences and 2) a FASTA file containing the transcript ID followed by the amino acid sequence for each transcript. These outputs are described in more detail [below](#isoout). An example of the code required to run this function applied to the Ray et al. 8 data is shown below:

```
AA_seq <- get_pairs(data_file = system.file("extdata", "CRB1.csv", package="surfaltr"), if_aa = TRUE, organism = "mouse", temp = FALSE)
```

##### **Output 1: Paired Isoforms**

Below is a table depicting the table output from the get\_pairs function applied to the Ray et al. 8 dataset:

![](data:image/png;base64...)

##### **Output 2: FASTA File**

Below is a snippet of the FASTA file produced from this function when applied to the Ray et al. 8 dataset:

![](data:image/png;base64...)

## **Determine TM topology**

Once an appropriate FASTA file is generated containing the amino acid sequences for each transcript, surfaltr can rapidly predict TM topology using the functions described below. The TM topology of surface proteins is very challenging to study by wet-lab experiments and thus several prediction algorithms described in detail in Punta et al. 9 have been developed to predict TM topology. Using the Uniprot database as a reference,10 we have chosen to include two different TM domain prediction tools in our package: TMHMM4 and Phobius.11

An example output plot generated from TMHMM versus Phobius applied to the Ray et al. 8 dataset is shown below:

![](data:image/png;base64...) Figure 2: Resultant Isoform Plot from TMHMM and Phobius TM Topology Prediction Algorithms for Uhlén et al. data

#### **Using TMHMM**

In order predict TM topology using TMHMM 2.0,4 surfaltr includes a function called get\_tmhmm(). This function uses the AA.fasta file generated as the output of the get\_pairs() function and the full path to the folder containing the TMHMM 2.0 software as input (fasta\_file\_name). The path to TMHMM 2.0 should be provided as a string and end in “TMHMM2.0c”. For the fasta file input parameter, the input should be provided as a string that just includes the file name of the fasta file to be used without a path. The function will return a data frame (output as path to/working directory/mem\_topo\_tmhmm.csv) with the TMHMM-predicted location for each amino acid in all the protein sequences. The topology is expressed as i- inside the plasma membrane, M- TM, o- outside the plasma membrane and O – unknown/assumed to be outside.

To run get\_tmhmm alone, the following code can be used:

```
mem_topo <- get_tmhmm(fasta_file_name = "AA.fasta", tmhmm_folder_name = "~/path/to/TMHMM2.0c")
```

It’s important to note that in order for this function to run, there needs to be a FASTA file containing the amino acid sequences for each transcript within the “output” folder in the working directory. If the get\_pairs function is run before the get\_tmhmm() function, this folder and file will be created automatically. The code below can be used to automate the fasta file generation and membrane topology prediction process:

```
AA_lst <- get_pairs(data_file = system.file("extdata", "CRB1.csv", package="surfaltr"), if_aa = TRUE, organism = "mouse")
mem_topo <- get_tmhmm("AA.fasta", tmhmm_folder_name = "~/path/to/TMHMM2.0c")
```

#### **When to Use TMHMM**

If the transcripts being run are not public information or should be kept private, the TMHMM standalone software along with the tmhmm R package provides an avenue to evaluate TM topology without using an external server, making it the ideal TM prediction algorithm in this instance. However, TMHMM is not able to predict the presence of signal peptides, possibly resulting in inaccuracies in TM prediction at the beginning of the sequence. Additionally, if a protein has no TM domains, TMHMM automatically flags the protein as extracellular, which is not always true and should be either verified experimentally or verified by comparison to the prediction by Phobius.

#### **Using Phobius**

In order predict TM topology using Phobius, surfaltr includes a function called run\_phobius(). This function takes in the AA.fasta file generated as the output of the get\_pairs() function (fasta\_file\_name). Additionally, this function is reliant on the data frame returned by the get\_pairs() function as an input parameter (AA\_seq). The function will return a data frame (output as path to/working directory/mem\_topo\_phobius.csv) with the Phobius-predicted location for each amino acid in all the protein sequences. The topology is expressed as i- inside the plasma membrane, M- TM, o- outside the plasma membrane and s – signal peptide.

To run run\_phobius alone, the following code can be used:

```
topo <- run_phobius(AA_seq = AA_lst, fasta_file_name = "~/<your-workin-directory>/output/AA.fasta")
```

To automatically generate the FASTA file used by the function, the following code can be used:

```
AA_lst <- get_pairs(data_file = "~/CRB1.csv", if_aa = TRUE, organism = "mouse")
mem_topo <- run_phobius(AA_seq = AA_lst, fasta_file_name = "~/<your-workin-directory>/output/AA.fasta")
```

#### **Interpreting Results from Both Phobius and TMHMM**

The usage of TM predictions from both TMHMM and Phobius serves as a powerful tool for evaluating which TM predictions are likely to be accurate biologically. Generally speaking, if TM domains appear in both TMHMM and Phobius predictions, they are likely to be witnessed experimentally as well. If certain domains are only seen on one of the outputs, the likelihood of the domain actually being present is lower. However, as Phobius is able to differentiate between signal peptides and TM domains, any TM regions predicted at the beginning of the sequence by Phobius are likely to be present regardless of TMHMM’s prediction. TMHMM’s TM predictions tend to be more conservative than Phobius’s. Thus, evaluating membrane topology using both methods is an effective way to decide which TM regions are most likely to be present experimentally.

## **Ranking and Plotting of Isoform Pairs**

To easily visualize the differences that may exist between isoform pairs, surfaltr includes options to easily filter by the most significantly different isoforms and view the differences in TM topology between isoforms. This is accomplished by a single function: plot\_isoforms().It produces a TM topology plot of all paired isoforms ranked by either length, TM, or a combination metric calculated using both factors. In order to use plot\_isoforms(), several inputs need to be provided. These include the data frame returned by the get\_phobius() or get\_tmhmm() function (AA\_seq), the data\_frame returned by the get\_pairs() function (topo), method of ranking (rank), number of genes to be displayed (n\_prts), size of text labels (size\_txt), and amount of space left of the plot for transcript labels (space\_left). More detail on these inputs can be found [above](#ti) and in the help page for this function.

To plot isoform pairs, the following code can be used:

```
AA_lst <- get_pairs(data_file = system.file("extdata", "CRB1.csv", package="surfaltr"), if_aa = TRUE, organism = "mouse")
mem_topo <- run_phobius(AA_seq = AA_lst, fasta_file_name = "~/<your-working-directory>/AA.fasta")
plot_isoforms(topo = mem_topo, AA_seq = AA_lst, rank = "combo", n_prts = 15,
              size_txt = 3, space_left = -400)
```

The output plot will automatically be saved as a pdf within the “output” folder within the working directory.

#### **Ranking criteria**

To determine which alternatively spliced/mis-spliced isoforms are significantly different from the principal isoforms, surfaltr provides users the option to sort or rank isoform pairs by three different criteria: length, difference in number of TM domains, and a combination metric that takes both length and TM difference into account. The ranking equations are described below:

##### **Ranked by Length**

*Length Difference = |Prnc Length - Alt Length|*

When ranking by length, the differences in length that are the largest will always be ranked higher than those that are lower. Thus, as expected, isoform pairs where the alternatively/mis-spliced isoform is nearly equal in length to the principal isoform will be ranked last and displayed at the bottom of the plot.

##### **Ranked by Number of TM Domains**

*TM Difference = Alt TM - Prnc TM*

In this situation, a positive TM difference is ranked higher than a negative or zero TM difference as this indicates that the alternative isoform has gained a TM domain and therefore may have a novel extracellular domain and/or function. For any difference below 0, isoform pairs will be ranked so that alternatively/mis-spliced transcripts that have more TM domains lost will be ranked higher than those that have lost only a few domains. To contextualize this ranking system, the following table can be used as an example:

| Difference.in.Number.of.TM.Domains | Rank |
| --- | --- |
| 3 | 1 |
| -4 | 5 |
| -16 | 4 |
| 2 | 2 |
| 1 | 3 |
| 0 | 8 |
| -1 | 7 |
| -2 | 6 |

##### **Ranked by Combo Metric**

*Combo Difference = ∆TM \* |∆Length|* *If ∆TM or ∆Length is 0, rank by -|∆Length|/100*

In this situation, isoforms that have a high difference in both length and number of TM domains are ranked higher than those that have very small differences. For any difference below 0, isoform pairs will be ranked so that pairs that have a more negative combo difference will be ranked higher than those that have a combo difference close to 0 as this is indicative of a larger difference between principal and alternative/mis-spliced isoforms. If the difference in TM domains or difference in length is between the isoform pairs is equal to 0, the isoforms will be ranked by their -1\*difference in length/100 in order to prioritize isoforms that have both TM and length differences.
To contextualize this ranking system, the following table can be used as an example:

| Difference.in.Number.of.TM.Domains | Difference.in.Length | Combo.Metric | Rank |
| --- | --- | --- | --- |
| 3 | 200 | 600.0 | 1 |
| -4 | 100 | -400.0 | 5 |
| -8 | 150 | -1200.0 | 4 |
| 2 | 10 | 20.0 | 3 |
| 1 | 40 | 40.0 | 2 |
| 0 | 100 | -1.0 | 7 |
| -1 | 300 | -300.0 | 6 |
| 0 | 20 | -0.2 | 8 |

An example of how the different ranking systems change the appearance of the plots is shown below:

![](data:image/png;base64...) Figure 3: Comparison of Length, TM, and Combo Ranking Metrics for Uhlén et al. data

#### **Choosing and Formatting Isoform Pairs to Display**

In addition to ranking the proteins, the plot\_isoforms() function can also choose how many proteins to display. Depending on the number supplied to the n\_prts input parameter, the user can choose the number of top-ranked pairs to display on the plot. Generally, it is recommended to limit the number of isoform pairs displayed in the plot to under 30 as otherwise the plot can appear cluttered. However, if the user wants to view all isoforms on the same plot, they simply have to enter the total number of genes they entered into the n\_prts parameter. As the number of isoform pairs displayed gets larger, the size\_txt parameter should be reduced and the space\_left parameter should be increased to accommodate more isoform plots. Similarly, if only a few isoforms are plotted, the size\_txt parameter should be increased and the space\_left parameter decreased. The following table provides helpful guidelines for size parameters that can be used for different values of n\_prts:

| n\_prts | size\_txt | space\_left |
| --- | --- | --- |
| 1 | 4.0 | -100 |
| 5 | 3.0 | -250 |
| 20 | 2.0 | -400 |
| 30 | 1.5 | -500 |

#### **Plot Interpretation**

As aforementioned, the output of plot\_isoforms() is a plot depicting ranked isoform pairs. Both membrane topology and APPRIS categorization are differentiated through color, as shown below:

![](data:image/png;base64...) Figure 4: Color Categorization for Membrane Topology and Principal Versus Alternative Differentiation

Although the plots provide an accurate prediction of TM topology for principal and alternative isoforms, there are a few caveats to keep in mind when interpreting the plots. Firstly, on plots created using Phobius’s model, any isoforms that have no TM region and no signal peptide will always be classified as intracellular. Due to the difficulty associated with predicting non-surface protein localization *in silico*, it is hard to tell if these isoforms are actually intracellular. Thus, these isoforms should not be regarded as intracellular but rather as unknowns. Similarly, on plots created using TMHMM’s model, any isoforms lacking TM regions will be classified as extracellular. Again, it is very difficult to tell computationally if this protein is extracellular and as such, isoforms categorized as fully extracellular should also be regarded as unknowns unless there is experimental information on isoforms from this gene being secreted.

*Note: The isoforms pairs seen in the plots produced by surfaltr are not aligned. Therefore, the first amino acid seen in the alternative isoform of one pair may not necessarily correspond to the first amino acid in the principal isoform. In order to facilitate sequence alignment, surfaltr also includes [functions](#MSA) that perform multiple sequence alignment of isoform pairs. When used in combination, this can help with the interpretation of isoform pair plots.*

## **Multiple Sequence Alignment for Genes of Interest**

To enable users to take a closer look at genes of interest from the isoform pair plot, surfaltr also offers users the ability to align amino acid sequences from isoform pairs to easily visualize differences in sequences that may contribute to differences in topology. This functionality can be applied for isoform pairs of interest from a single organism through the function align\_prts(). If the user wants to align isoform pairs from multiple organisms, surfaltr also offers a function to facilitate this through align\_org\_prts() given that the paralog from the other organism was provided as input.

#### **From Isoform Pairs from a Single Organism**

After identifying genes of interest from an isoform pairs plot, surfaltr offers users an easy way to align amino acid sequences from the same gene through the align\_prts() function. Input variables include a vector containing the genes of interest (gene\_names), a string containing the path to the file containing the data to be used (data\_fie), a boolean stating if the data cotnains amino acids (if\_aa), and a string stating which organism the data is from (organism).

The code used to run the align\_prts function is shown below:

```
align_prts(gene_names = c("Crb1", "Adgrl1"), data_file = system.file("extdata", "CRB1.csv", package="surfaltr"),
           if_aa = TRUE, organism = "mouse")
```

This function will produce PDF files containing the aligned sequences and FASTA files containing the sequences and transcript IDs for each gene, which will be saved to a folder named ‘output’ in your working directory.

Troubleshooting tips: This function of sufaltr depends on the msa R package which requires LaTeX. Any errors in msa installation pertaining to LaTeX usage and pdf generation can throw errors. If users run into problems please check msa R package isnatllation.

#### **From Isoform Pairs from Multiple Organisms**

In addition to single organism alignment, surfaltr also provides users an easy way to align amino acid sequences from the same gene from multiple organisms through the align\_org\_prts() function. To use align\_prts(), the user needs to provide the names of the genes they are interested in examining from both organisms (gene\_names), the path to the file cotnaining the human data (hs\_data\_file), the path to the file containing the mouse data (ms\_data\_file), and a boolean stating if the data contains amino acid sequences (if\_aa).

The code used to run the align\_org\_prts function is shown below:

```
align_org_prts(gene_names = c("gene-name"), hs_data_file = "~/path/to/human-dataframe.csv",
               mm_data_file =  "~/path/to/mouse-dataframe.csv", if_aa = FALSE)
```

This function will produce PDF files containing the aligned sequences and FASTA files containing the sequences and transcript IDs for each gene, which will be saved to the working directory.

#### **Interpreting Alignment Results and Isoform Pair Plots**

When used in combination, alignment results and isoform pair plots provide a powerful way to fully understand differences that may exist between principal and alternatively/mis-spliced isoforms. The membrane topology bar plots can be compared to the protein alignment to identify changes in sequence contributing to the changes in topology. An example of this analysis is shown below.

![](data:image/png;base64...) Figure 5: Multiple Sequence Alignment of CD8B Isoforms Compared to Isoforms Plot Output

```
library(surfaltr)
```

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
## [1] kableExtra_1.4.0 knitr_1.50       surfaltr_1.16.0  testthat_3.2.3
## [5] devtools_2.4.6   usethis_3.2.1
##
## loaded via a namespace (and not attached):
##  [1] ade4_1.7-23          tidyselect_1.2.1     viridisLite_0.4.2
##  [4] dplyr_1.1.4          farver_2.1.2         blob_1.2.4
##  [7] filelock_1.0.3       Biostrings_2.78.0    S7_0.2.0
## [10] fastmap_1.2.0        BiocFileCache_3.0.0  digest_0.6.37
## [13] lifecycle_1.0.4      ellipsis_0.3.2       KEGGREST_1.50.0
## [16] RSQLite_2.4.3        magrittr_2.0.4       compiler_4.5.1
## [19] rlang_1.1.6          sass_0.4.10          progress_1.2.3
## [22] tools_4.5.1          yaml_2.3.10          prettyunits_1.2.0
## [25] bit_4.6.0            pkgbuild_1.4.8       curl_7.0.0
## [28] xml2_1.4.1           RColorBrewer_1.1-3   pkgload_1.4.1
## [31] purrr_1.1.0          BiocGenerics_0.56.0  desc_1.4.3
## [34] grid_4.5.1           stats4_4.5.1         msa_1.42.0
## [37] ggplot2_4.0.0        scales_1.4.0         MASS_7.3-65
## [40] dichromat_2.0-0.1    biomaRt_2.66.0       cli_3.6.5
## [43] rmarkdown_2.30       crayon_1.5.3         generics_0.1.4
## [46] remotes_2.5.0        rstudioapi_0.17.1    httr_1.4.7
## [49] tzdb_0.5.0           sessioninfo_1.2.3    DBI_1.2.3
## [52] cachem_1.1.0         stringr_1.5.2        AnnotationDbi_1.72.0
## [55] XVector_0.50.0       vctrs_0.6.5          jsonlite_2.0.0
## [58] IRanges_2.44.0       hms_1.1.4            S4Vectors_0.48.0
## [61] bit64_4.6.0-1        seqinr_4.2-36        systemfonts_1.3.1
## [64] jquerylib_0.1.4      glue_1.8.0           protr_1.7-5
## [67] stringi_1.8.7        gtable_0.3.6         tibble_3.3.0
## [70] pillar_1.11.1        rappdirs_0.3.3       htmltools_0.5.8.1
## [73] Seqinfo_1.0.0        brio_1.1.5           R6_2.6.1
## [76] dbplyr_2.5.1         httr2_1.2.1          textshaping_1.0.4
## [79] rprojroot_2.1.1      evaluate_1.0.5       Biobase_2.70.0
## [82] readr_2.1.5          png_0.1-8            memoise_2.0.1
## [85] bslib_0.9.0          Rcpp_1.1.0           svglite_2.2.2
## [88] xfun_0.53            fs_1.6.6             pkgconfig_2.0.3
```

## **References**

1. Juliano, R. L., Ming, X., Nakagawa, O., Xu, R. & Yoo, H. Integrin Targeted Delivery of Gene Therapeutics. *Theranostics* **1,** 211–219 (2011).

2. Frontiers Adhesion Molecule L1 Agonist Mimetics Protect Against the Pesticide Paraquat-Induced Locomotor Deficits and Biochemical Alterations in Zebrafish Neuroscience. at <<https://www.frontiersin.org/articles/10.3389/fnins.2020.00458/full>>

3. Zhao, J., Santino, F., Giacomini, D. & Gentilucci, L. Integrin-Targeting Peptides for the Design of Functional Cell-Responsive Biomaterials. *Biomedicines* **8,** 307 (2020).

4. Krogh, A., Larsson, B., Heijne, G. von & Sonnhammer, E. L. Predicting transmembrane protein topology with a hidden Markov model: Application to complete genomes. *J Mol Biol* **305,** 567–580 (2001).

5. Rodriguez, J. M., Rodriguez-Rivas, J., Di Domenico, T., Vázquez, J., Valencia, A. & Tress, M. L. APPRIS 2017: Principal isoforms for multiple gene sets. *Nucleic Acids Res* **46,** D213–D217 (2018).

6. Waas, M., Snarrenberg, S. T., Littrell, J., Jones Lipinski, R. A., Hansen, P. A., Corbett, J. A. & Gundry, R. L. SurfaceGenie: A web-based application for prioritizing cell-type-specific marker candidates. *Bioinformatics* **36,** 3447–3456 (2020).

7. Uhlén, M., Fagerberg, L., Hallström, B. M., Lindskog, C., Oksvold, P., Mardinoglu, A., Sivertsson, Å., Kampf, C., Sjöstedt, E., Asplund, A., Olsson, I., Edlund, K., Lundberg, E., Navani, S., Szigyarto, C. A.-K., Odeberg, J., Djureinovic, D., Takanen, J. O., Hober, S., Alm, T., Edqvist, P.-H., Berling, H., Tegel, H., Mulder, J., Rockberg, J., Nilsson, P., Schwenk, J. M., Hamsten, M., Feilitzen, K. von, Forsberg, M., Persson, L., Johansson, F., Zwahlen, M., Heijne, G. von, Nielsen, J. & Pontén, F. Proteomics. Tissue-based map of the human proteome. *Science* **347,** 1260419 (2015).

8. Ray, T. A., Cochran, K., Kozlowski, C., Wang, J., Alexander, G., Cady, M. A., Spencer, W. J., Ruzycki, P. A., Clark, B. S., Laeremans, A., He, M.-X., Wang, X., Park, E., Hao, Y., Iannaccone, A., Hu, G., Fedrigo, O., Skiba, N. P., Arshavsky, V. Y. & Kay, J. N. Comprehensive identification of mRNA isoforms reveals the diversity of neural cell-surface molecules with roles in retinal development and disease. *Nat Commun* **11,** 3328 (2020).

9. Punta, M., Forrest, L. R., Bigelow, H., Kernytsky, A., Liu, J. & Rost, B. Membrane Protein Prediction Methods. *Methods* **41,** 460–474 (2007).

10. SAM - Sequence Analysis Methods for automatic annotation. at <<https://www.uniprot.org/help/sam>>

11. Käll, L., Krogh, A. & Sonnhammer, E. L. L. A combined transmembrane topology and signal peptide prediction method. *J Mol Biol* **338,** 1027–1036 (2004).

12. Systemic Administration of siRNA via cRGD-containing Peptide Scientific Reports. at <<https://www.nature.com/articles/srep12458>>

13. Frontiers Peptide-Drug Conjugates and Their Targets in Advanced Cancer Therapies Chemistry. at <<https://www.frontiersin.org/articles/10.3389/fchem.2020.00571/full>>

14. Xu, J., Hu, C., Jiang, Q., Pan, H., Shen, H. & Schachner, M. Trimebutine, a small molecule mimetic agonist of adhesion molecule L1, contributes to functional recovery after spinal cord injury in mice. *Dis Model Mech* **10,** 1117–1128 (2017).

15. Primiano, T., Chang, B.-D. & Heidel, J. D. Abstract LB-103: L1CAM-targeted delivery of siRNA using elastin-like polypeptide (ELP) nanoparticles inhibits the growth of human tumors implanted in mice. *Cancer Res* **74,** LB–103 (2014).

16. Zhang, R., Qin, X., Kong, F., Chen, P. & Pan, G. Improving cellular uptake of therapeutic entities through interaction with components of cell membrane. *Drug Deliv* **26,** 328–342 (2019).