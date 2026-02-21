[[![](data:image/png;base64...)](http://bioconductor.org/packages/TCGAbiolinksGUI/)](index.html)

* [Introduction](index.html)
* [Data](data.html)
* [Analysis](analysis.html)
* [Integrative analysis](integrative.html)
* [Case Study](Cases.html)

* + Bioc2017 workshop
  + [Github ELMER/TCGAbiolinks](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER)
  + TCGAbiolinks package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinks)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinks.html)
  + TCGAbiolinksGUI package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinksGUI)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinksGUI.html)
  + ELMER package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + ELMER.data package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
* + University of São Paulo (USP)
  + [fmrp.usp.br](http://www.fmrp.usp.br/?lang=en)
  + Université libre de Bruxelles (ULB)
  + [mlg.ulb.ac.be](http://mlg.ulb.ac.be/)
  + Fundings
  + [FAPESP (16/10436-9)](http://www.bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28instituicao%3A%22Cedars-Sinai+Medical+Center%22%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+abroad%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [FAPESP (16/01389-7)](http://bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28id_pesquisador_exact%3A679917%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+in+Brazil%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [Belgian FNRS PDR T100914F](http://mlg.ulb.ac.be/GENGISCAN)
  + [BridgeIRIS](http://mlg.ulb.ac.be/BridgeIRIS)

# 1 Introduction

TCGAbiolinksGUI was created to help users more comfortable with graphical user interfaces (GUI) to search, download and analyze Cancer data. It offers a graphical user interface to the R/Bioconductor package [TCGAbiolinks](http://bioconductor.org/packages/TCGAbiolinks/) (Colaprico et al. 2016), which is able to access The National Cancer Institute (NCI) Genomic Data Commons (GDC) through its
[GDC Application Programming Interface (API)](https://gdc.cancer.gov/developers/gdc-application-programming-interface-api). Additional packages from Bioconductor are included, such as [ComplexHeatmap](http://bioconductor.org/packages/ComplexHeatmap/) package (Gu, Eils, and Schlesner 2016) to aid in visualizing the data, [ELMER](http://bioconductor.org/packages/ELMER/) (Yao et al. 2015) to identify regulatory enhancers using gene expression + DNA methylation data + motif analysis and [Pathview](http://bioconductor.org/packages/pathview/) (Luo and Brouwer 2013) for pathway-based data integration and visualization.

The GUI was created using [Shiny](https://shiny.rstudio.com/), a Web Application Framework for R, and uses several packages to provide advanced features that can enhance Shiny apps, such as [shinyjs](https://github.com/daattali/shinyjs) to add JavaScript actions for the app, [shinydashboard](https://github.com/rstudio/shinydashboard) to add dashboards and [shinyFiles](https://github.com/thomasp85/shinyFiles) to provide an API for client side access to the server file system. A running version of the GUI is found in <http://tcgabiolinks.fmrp.usp.br:3838/>

This work has been supported by a grant from Henry Ford Hospital (H.N.) and by the São Paulo Research Foundation [FAPESP](http://www.fapesp.br/) (2016/01389-7 to T.C.S. & H.N. and 2015/07925-5 to H.N.) the BridgeIRIS project, funded by INNOVIRIS, Region de Bruxelles Capitale, Brussels, Belgium, and by GENomic profiling of Gastrointestinal Inflammatory-Sensitive CANcers (GENGISCAN), Belgian FNRS PDR (T100914F to A.C., C.O. & G.B.). T.C.S. and B.P.B. were supported by the NCI Informatics Technology for Cancer Research program, NIH/NCI grant 1U01CA184826.

# 2 Starting with TCGAbiolinksGUI

## 2.1 Installation

To install the package from the [Bioconductor repository](http://bioconductor.org/packages/TCGAbiolinksGUI/) please use the following code.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
install.packages("BiocManager")
BiocManager::install("TCGAbiolinksGUI", dependencies = TRUE)
```

To install the development version of the package via GitHub:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
install.packages("BiocManager")
deps <- c("devtools")
BiocManager::install("devtools", dependencies = TRUE)
devtools::install_github("BioinformaticsFMRP/TCGAbiolinksGUI.data",ref = "R_3.4")
devtools::install_github("BioinformaticsFMRP/TCGAbiolinksGUI")
```

### 2.1.1 Increasing loaded DLL

Increasing loaded DLL

If you receive this error message: `maximal number of DLLs reached...` You will need to increase the maximum number of DLL R can load wit the enriroment variable `R_MAX_NUM_DLLS`.

You can check where the Renviron or Renviron.site are located with the following R commnad: `dir(Sys.getenv("R_HOME"),recursive = T,full.names = T,pattern = "Renviron")` and add `R_MAX_NUM_DLLS=150` in the end.

For example, for MACOS you can modify the file `/Library/Frameworks/R.framework/Resources/etc/Renviron` and add `R_MAX_NUM_DLLS=150` in the end. Or you can run in R the following command as R administrator: `system(' echo "R_MAX_NUM_DLLS=150" >> /Library/Frameworks/R.framework/Resources/etc/Renviron')`

For UBUNTU you modify the file `/usr/lib/R/etc/Renviron` and add `R_MAX_NUM_DLLS=150` in the end. Or you can run in R the following command as R administrator: `system(' echo "R_MAX_NUM_DLLS=150" >> /usr/lib/R/etc/Renviron')`

For other OS check <https://stat.ethz.ch/R-manual/R-patched/library/base/html/Startup.html>.

## 2.2 Docker image

TCGAbiolinksGUI is available as Docker image (self-contained environments that contain everything needed to run the software), which can be easily run on Mac OS, Windows and Linux systems.

The image can be obtained from Docker Hub: <https://hub.docker.com/r/tiagochst/tcgabiolinksgui/>

For more information please check: <https://docs.docker.com/> and <https://www.bioconductor.org/help/docker/>

### 2.2.1 Setting up image using graphical user interface (GUI)

This [PDF](https://drive.google.com/open?id=0B0-8N2fjttG-QXp5LVlPQnVQejg) shows how to install and execute the image using [kitematic](https://kitematic.com/), which offers a graphical user interface (GUI) to control your app containers.

### 2.2.2 Setting up image using command-line

* Download image: docker pull tiagochst/tcgabiolinksgui
* To run RStudio Server and shiny-server, but the data is not saved if the container is stopped: `sudo docker run --name tcgabiolinksgui -d -P -v /home/$USER/docker:/home/rstudio -p 3333:8787 -p 3334:3838 tiagochst/tcgabiolinksgui`

1. For more information how data can be saved please read [this wiki](https://github.com/rocker-org/rocker/wiki/How-to-save-data) and see command below

* To run RStudio Server, shiny-server and save the results in the host machine please use the code below: `sudo docker run --name tcgabiolinksgui -d -P -v /home/$USER/docker:/home/rstudio -p 3333:8787 -p 3334:3838 tiagochst/tcgabiolinksgui`

1. In case Rstudio is not accessible please check if the folder created (docker) has the right permission
2. If your system is windows or macOS you will need to change `/home/$USER/docker` to the correct system path. Examples can be found in this [github page](https://github.com/rocker-org/rocker/wiki/Sharing-files-with-host-machine)

* To stop the image:

1. Run `sudo docker stop tcgabiolinksgui` to stop it

* To start the image again (after the first time ran with `docker run` and stopped).

1. Run `sudo docker start tcgabiolinksgui`

### 2.2.3 Accessing the tools after the image is running:

* TCGAbiolinksGUI will be available at :3334/tcgabiolinksgui
* RStudio will be available at :3333 (***username: rstudio*** , ***password:rstudio***)

## 2.3 Quick start

The following commands should be used to start the graphical user interface.

```
library(TCGAbiolinksGUI)
TCGAbiolinksGUI()
```

## 2.4 Video tutorials

To facilitate the use of this package, we have created some tutorial videos demonstrating the tool. Some sections have video tutorials that if clicked will redirect to the video on youtube. For the complete list of videos, please check this [youtube list](https://www.youtube.com/playlist?list=PLoDzAKMJh15m40f7OqOLAW0nJwkVStJIJ).

## 2.5 PDF tutorials

For each section we created some PDFs with detailing the steps of each section: [Link to folder with PDFs](https://drive.google.com/drive/folders/0B0-8N2fjttG-Q25ldVVmUTVOTk0?usp=sharing)

## 2.6 Workshops

* Bioc2017 (Boston, MA) - [workshop link](https://bioinformaticsfmrp.github.io/Bioc2017.TCGAbiolinks.ELMER/index.html)

## 2.7 Question and issues

Please use [Github issues](https://github.com/BioinformaticsFMRP/TCGAbiolinksGUI/issues) if you want to file bug reports or feature requests.

## 2.8 Data input summary

| Menu | Sub-menu | Button | Data input | Example Input |
| --- | --- | --- | --- | --- |
| Clinical analysis | Survival Plot | Select file | A table with at least the following columns: days\_to\_death, days\_to\_last\_followup and one column with a group | [Example input](https://drive.google.com/open?id=1pWYEZsojafQMav8v3MrRVTIkFKyCSGfY) |
| Epigenetic analysis | Differential methylation analysis | Select data (.rda) | A summarizedExperiment object | [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda) |
| Epigenetic analysis | Volcano Plot | Select results | A CSV file with the following pattern: DMR\_results\_GroupCol\_group1\_group2\_pcut\_0.01\_meancut\_0.5.csv (Where GroupCol, group1, group2 are the names of the columns selected in the DMR steps. | [Example input](https://drive.google.com/open?id=1lUS2hEJHP4PC6vfeO-ckLbLe-6xx0ddQ) in which diffmean.group1.group2= mean group 2 - mean group 1 |
| Epigenetic analysis | Heatmap plot | Select file | A summarizedExperiment object | [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda) |
| Epigenetic analysis | Heatmap plot | Select results | Same as Epigenetic analysis >Volcano Plot > Select results |  |
| Epigenetic analysis | Mean DNA methylation | Select file | A summarizedExperiment object | [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda) |
| Transcriptomic Analysis | Volcano Plot | Select results | A CSV file with the following pattern: DEA\_results\_GroupCol\_group1\_group2\_pcut\_0.01\_logFC.cut\_2.csv (Where GroupCol, group1, group2 are the names of the columns selected in the DEA steps. | [Example input](https://drive.google.com/open?id=1lUS2hEJHP4PC6vfeO-ckLbLe-6xx0ddQ) ) in which logFC= loag( group 2/ group1) |
| Transcriptomic Analysis | Heatmap plot | Select file | A summarizedExperiment object | [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda) |
| Transcriptomic Analysis | Heatmap plot | Select results | A CSV file with results of the DMR or DEA | [Example input](https://drive.google.com/open?id=1lUS2hEJHP4PC6vfeO-ckLbLe-6xx0ddQ) in which diffmean.group1.group2= mean group 2 - mean group 1 |
| Transcriptomic Analysis | OncoPrint plot | Select MAF file | A MAF file (columns needed: Hugo\_Symbol,Tumor\_Sample\_Barcode,Variant\_Type) | Deafult GDC MAF files |
| Transcriptomic Analysis | OncoPrint plot | Select Annotation file | A file with at least the following columns: bcr\_patient\_barcode | [Example input](<https://drive.google.com/open?id=1pWYEZsojafQMav8v3MrRVTIkFKyCSGfY> |
| Integrative analysis | Starburst plot | DMR result | A CSV file with the following pattern: DMR\_results\_GroupCol\_group1\_group2\_pcut\_0.01\_meancut\_0.55.csv (Where GroupCol, group1, group2 are the names of the columns selected in the DMR steps. | [Example input](https://drive.google.com/open?id=1lUS2hEJHP4PC6vfeO-ckLbLe-6xx0ddQ) in which diffmean.group1.group2= mean group 2 - mean group 1 |
| Integrative analysis | Starburst plot | DEA result | A CSV file with the following pattern: DEA\_results\_GroupCol\_group1\_group2\_pcut\_0.01\_FC.cut\_2.csv (Where GroupCol, group1, group2 are the names of the columns selected in the DEA steps. | [Example input](https://drive.google.com/open?id=1lUS2hEJHP4PC6vfeO-ckLbLe-6xx0ddQ) ) in which logFC= loag( group 2/ group1) |
| Integrative analysis | ELMER | Create MAE > Select DNA methylation object | An rda file with a summarized Experiment object | [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.met.rda) |
| Integrative analysis | ELMER | Create MAE > Select expression object | An rda file with the RNAseq data frame | [Example input](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER/raw/master/data/lusc.exp.rda) |
| Integrative analysis | ELMER | Select MAE | An rda file with a MAE object | [Example input](https://drive.google.com/open?id=17ovzQ-czPfsAjZ1JJLjLPvdm1aN2_C8r) |
| Integrative analysis | ELMER | Select results | An rda file with the results of the ELMER analysis | [Example input](https://drive.google.com/open?id=1OP8BKoFfkH5knTVjvAHq2lLjfmpub9ei) |

# 3 Citation

Please cite both TCGAbiolinks package and TCGAbiolinksGUI:

* Silva TC, Colaprico A, Olsen C, Bontempi G, Ceccarelli M, Berman BP. , and Noushmehr H. “TCGAbiolinksGUI: A Graphical User Interface to analyze cancer molecular and clinical data.”Bioinformatics - Submitted for review.
* Colaprico A, Silva TC, Olsen C, Garofano L, Cava C, Garolini D, Sabedot T, Malta TM, Pagnotta SM, Castiglioni I, Ceccarelli M, Bontempi G and Noushmehr H. “TCGAbiolinks: an R/Bioconductor package for integrative analysis of TCGA data.” Nucleic acids research (2015): gkv1507.

Other related publications to this package:

* “TCGA Workflow: Analyze cancer genomics and epigenomics data using Bioconductor packages”. F1000Research [10.12688/f1000research.8923.1](http://dx.doi.org/doi%3A10.12688/f1000research.8923.1) (Silva et al. 2016)

If you used ELMER please cite:

* Yao, L., Shen, H., Laird, P. W., Farnham, P. J., & Berman, B. P. “Inferring regulatory element landscapes and transcription factor networks from cancer methylomes.” Genome Biol 16 (2015): 105.
* Yao, Lijing, Benjamin P. Berman, and Peggy J. Farnham. “Demystifying the secret mission of enhancers: linking distal regulatory elements to target genes.” Critical reviews in biochemistry and molecular biology 50.6 (2015): 550-573.

If you used OncoPrint plot and Heatmap Plot please cite:

* Gu, Zuguang, Roland Eils, and Matthias Schlesner. “Complex heatmaps reveal patterns and correlations in multidimensional genomic data.” Bioinformatics (2016): btw313

If you used maftools please also cite:

* Mayakonda, Anand, and H. Phillip Koeffler. “Maftools: Efficient analysis, visualization and summarization of MAF files from large-scale cohort based cancer studies.” bioRxiv (2016): 052662.

If you used Pathway plot please cite:

* Luo, Weijun, Brouwer and Cory (2013). “Pathview: an R/Bioconductor package for pathway-based data integration and visualization.” Bioinformatics, 29(14), pp. 1830-1831.

# References

Colaprico, Antonio, Tiago C. Silva, Catharina Olsen, Luciano Garofano, Claudia Cava, Davide Garolini, Thais S. Sabedot, et al. 2016. “TCGAbiolinks: An R/Bioconductor Package for Integrative Analysis of Tcga Data.” *Nucleic Acids Research* 44 (8):e71. <https://doi.org/10.1093/nar/gkv1507>.

Gu, Zuguang, Roland Eils, and Matthias Schlesner. 2016. “Complex Heatmaps Reveal Patterns and Correlations in Multidimensional Genomic Data.” *Bioinformatics*. <https://doi.org/10.1093/bioinformatics/btw313>.

Luo, Weijun, and Cory Brouwer. 2013. “Pathview: An R/Bioconductor Package for Pathway-Based Data Integration and Visualization.” *Bioinformatics* 29 (14). Oxford Univ Press:1830–1.

Silva, TC, A Colaprico, C Olsen, F D’Angelo, G Bontempi, M Ceccarelli, and H Noushmehr. 2016. “TCGA Workflow: Analyze Cancer Genomics and Epigenomics Data Using Bioconductor Packages [Version 2; Referees: 1 Approved, 1 Approved with Reservations].” *F1000Research* 5 (1542). <https://doi.org/10.12688/f1000research.8923.2>.

Yao, L, H Shen, PW Laird, PJ Farnham, and BP Berman. 2015. “Inferring Regulatory Element Landscapes and Transcription Factor Networks from Cancer Methylomes.” *Genome Biology* 16 (1):105–5.