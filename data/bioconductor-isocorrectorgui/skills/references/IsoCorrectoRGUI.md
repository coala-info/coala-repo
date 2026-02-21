# Introduction to IsoCorrectoR

Paul Heinrich1

1Statistical Bioinformatics Department, Institute of Functional Genomics, University of Regensburg

#### 30 October 2025

#### Package

IsoCorrectoRGUI 1.26.0

# Contents

* [1 Why perform correction for natural stable isotope abundance and tracer purity?](#why-perform-correction-for-natural-stable-isotope-abundance-and-tracer-purity)
* [2 What is IsoCorrectoR?](#what-is-isocorrector)
* [3 IsoCorrectoR packages: IsoCorrectoR and IsoCorrectoRGUI](#isocorrector-packages-isocorrector-and-isocorrectorgui)
* [4 Installing IsoCorrectoR](#installing-isocorrector)
  + [4.1 Requirements](#requirements)
    - [4.1.1 General (IsoCorrectoR and IsoCorrectoRGUI)](#general-isocorrector-and-isocorrectorgui)
    - [4.1.2 Graphical user interface version only (IsoCorrectoRGUI)](#graphical-user-interface-version-only-isocorrectorgui)
  + [4.2 Installation](#installation)
* [5 How to use IsoCorrectoR](#how-to-use-isocorrector)
  + [5.1 Using IsoCorrectoR via the graphical user interface (IsoCorrectoRGUI package)](#using-isocorrector-via-the-graphical-user-interface-isocorrectorgui-package)
  + [5.2 Using IsoCorrectoR via the R console (IsoCorrectoR and IsoCorrectoRGUI package)](#using-isocorrector-via-the-r-console-isocorrector-and-isocorrectorgui-package)
  + [5.3 Result files produced by IsoCorrectoR](#result-files-produced-by-isocorrector)
  + [5.4 Starting IsoCorrectoR GUI directly under Windows (IsoCorrectoRGUI package)](#starting-isocorrector-gui-directly-under-windows-isocorrectorgui-package)
* [6 Input files and parameters](#input-files-and-parameters)
  + [6.1 Input files](#input-files)
    - [6.1.1 Molecule information file](#molecule-information-file)
    - [6.1.2 Measurement file](#measurement-file)
    - [6.1.3 Element information file](#element-information-file)
  + [6.2 Basic correction parameters](#basic-correction-parameters)
    - [6.2.1 Tracer purity correction](#tracer-purity-correction)
    - [6.2.2 Correction of tracer element natural abundance in the core molecule](#correction-of-tracer-element-natural-abundance-in-the-core-molecule)
    - [6.2.3 Normal/High resolution correction](#normalhigh-resolution-correction)
  + [6.3 Advanced correction parameters](#advanced-correction-parameters)
    - [6.3.1 Correction results for monoisotopic species](#correction-results-for-monoisotopic-species)
    - [6.3.2 Calculation thresholds](#calculation-thresholds)
* [SessionInfo](#sessioninfo)
* [References](#references)

# 1 Why perform correction for natural stable isotope abundance and tracer purity?

In metabolomics, stable isotope tracer experiments can provide a wealth of information. The data obtained should however not be interpreted without a preceding data correction procedure: The incorporation of the tracer isotope into metabolites provides a mass shift with respect to the unlabeled species. But isotopes of higher mass also occur naturally, the quantity defined by their natural abundance. This leads to convoluted signals in mass spectrometry that contain contributions from both populations.

In qualitative tracing experiments, this results in a high risk of assuming (pathway) contributions of the tracer substrate when there are none. And in more quantitative tracing approaches, the ratios of a metabolites different isotopologues/isotopomers will be distorted, as will be the fluxes in metabolic flux analysis. A similar effect is observed due to the impurity of the tracer substrate. Therefore, a correction for natural stable isotope abundance and possibly tracer purity should be made prior to data interpretation/modeling (Buescher et al. ([2015](#ref-Buescher2015))). See our publication on IsoCorrectoR (Heinrich et al. ([2018](#ref-Heinrich2018))) for more information on the theory of correction or the impact that correction has on data interpretation.

# 2 What is IsoCorrectoR?

IsoCorrectoR is an R-based tool for the correction of mass spectrometry data from stable isotope labeling experiments with regard to natural abundance and tracer purity. IsoCorrectoR can correct data from both MS and MS/MS experiments with any tracer isotope (13C, 15N, 18O…). Additionally, it is able to correct high resolution data from multiple-tracer experiments (e.g. 13C and 15N used simultaneously).
The tool was designed for a high degree of usability. It takes intuitively structured input files that are easy to build both in csv- and Microsoft Excel-format. The output can also be generated in either of those file formats. An optional graphical user interface makes the handling very simple, even for researchers that have little or no experience with R. Batch-processing is very convenient for anyone with a basic understanding of the R language and usually also very quick, as correction performs fast even on desktop systems. Furthermore, IsoCorrectoR is capable of handling data with missing values while providing useful warnings and error messages to the user regarding inappropriate input or data quality. All relevant information on a correction run, including warnings and errors that may have occured, is stored in a clearly structured logfile.

While many of IsoCorrectoRs correction features can also be found in other programs like IsoCor (Python, MS1-data natural abundance and tracer purity correction), ICT (Perl, features of IsoCor and additional MS/MS-data correction) or PyNAC (Python, natural abundance correction of high resolution data from multiple-tracer experiments, but no tracer purity correction), IsoCorrectoR is the only tool that comprises all the features in a single implementation. Further, to date, no other tool can correct for tracer purity in high resolution data (Buescher et al. ([2015](#ref-Buescher2015)); Millard et al. ([2012](#ref-Millard2012)); Jungreuthmayer et al. ([2016](#ref-Jungreuthmayer2016)); Carreer, Flight, and Moseley ([2013](#ref-Carreer2013))).

| Feature | IsoCorrectoR | ICT | IsoCor | PyNAC |
| --- | --- | --- | --- | --- |
| MS correction (normal resolution) | yes | yes | yes | no |
| MS/MS correction (normal resolution) | yes | yes | no | no |
| Tracers other than 13C | yes | yes | yes | yes |
| Correction for tracer impurity (normal resolution) | yes | yes | yes | no |
| High Resolution multiple tracer correction | yes | no | no | yes |
| Correction for tracer impurity (high Resolution) | yes | no | no | no |
| Graphical User Interface | yes | no | yes | no |

# 3 IsoCorrectoR packages: IsoCorrectoR and IsoCorrectoRGUI

IsoCorrectoR consists of two R packages: **IsoCorrectoR** is the base package that provides a console interface to the correction algorithm. The package **IsoCorrectoRGUI** additionally provides a graphical user interface for using IsoCorrectoR. If you want to use IsoCorrectoR with the graphical user interface (GUI), it is sufficient to install the package IsoCorrectoRGUI. If you do not need a GUI, you can just install the package IsoCorrectoR.

# 4 Installing IsoCorrectoR

## 4.1 Requirements

### 4.1.1 General (IsoCorrectoR and IsoCorrectoRGUI)

If you want IsoCorrectoR to **write correction results as xls files, a Perl installation is required**. If you want your **results written as csv files, a Perl installation is not needed**. To check if Perl is installed on your machine, type **which perl** in the command line of Linux and Mac OS machines or **where perl** in the command line of Windows machines. On Linux distributions, Perl should usually be installed by default. On Windows, the Perl distribution Strawberry Perl (<http://strawberryperl.com/>) can be used.

### 4.1.2 Graphical user interface version only (IsoCorrectoRGUI)

The **graphical user interface (GUI) package of IsoCorrectoR, IsoCorrectoRGUI, additionally requires the R package ‘tcltk’. This package is installed with all standard installations of R**. On **Linux and Mac OS systems (but not on Windows), the X11 window manager is additionally required for running the GUI**. To check if tcltk and (in the case of Linux and Mac OS systems) X11 is available on your system, start an R session and type **capabilities()** in your R console. If the value below tcltk and X11 in the output is TRUE, they are available to your R installation. Otherwise, please refer to the distributors of Tcl/tk and/or X11 for installing the software on your operating system if you wish to use the GUI.

## 4.2 Installation

See <http://bioconductor.org/packages/release/bioc/html/IsoCorrectoR.html> for the base package or <http://bioconductor.org/packages/release/bioc/html/IsoCorrectoRGUI.html> for the GUI package.

# 5 How to use IsoCorrectoR

## 5.1 Using IsoCorrectoR via the graphical user interface (IsoCorrectoRGUI package)

To use IsoCorrectoR with the graphical user interface (GUI), the **IsoCorrectoRGUI package has to be installed** (see section [Installing IsoCorrectoR](#installing-isocorrector)). **Start an R-session (e.g. by starting RStudio)** and **load the IsoCorrectoRGUI package with library(IsoCorrectoRGUI)**. Then you can **start the GUI by typing IsoCorrectionGUI()** in the R console. The IsoCorrectoR GUI will pop up. Sometimes it starts in the background, in that case you have to click on its icon in the taskbar to bring it to front.

In the GUI you can now select the input files and adjust the parameters for your correction task (see section [Input files and parameters](#input-files-and-parameters) for detailed information). By clicking the **Start Correction**-button, the correction is started. If everything is alright, a **Correction successful!**-window will pop up, usually after less than 1 minute. If something is wrong (e.g. with the input files), a window with the corresponding error message will show up. After correction has finished, you will find your corrected data and a log-file of the correction in the output directory you specified.

#### 5.1.0.1 Parameters that can be set in the graphical user interface:

* **Measurement File**: The file that contains the measured data to be corrected. Has to be provided
* **Molecule File**: The file that contains the information on the molecules for which data is to be corrected. Has to be provided
* **Element File**: The file that contains the element information required for correction. Has to be provided
* **Output Directory**: Defines the directory the corrected data and log-file should be written to. Has to be provided
* **Name Outputfile**: Defines the name of the file that contains the corrected data. The name of the file will be IsoCorrectoR\_[Name Outputfile].[Format Outputfile]. If the format is csv, the name will also contain the type of corrected data in the respective file
* **Format Outputfile**: Defines the format of the files that contain the corrected data. Can either be ‘csv’ or ‘xls’. If ‘csv’ is choosen, multiple files will be produced, one for each type of corrected data (corrected data, fractions, mean enrichment…). If ‘xls’ is choosen, all correction results are provided in one excel file in different sheets
* **Correct Tracer Impurity**: If checked, correction for isotopic impurity of the tracer substrate is performed
* **Corr. Tracer Element Core**: If checked, the tracer element atoms in the core molecule (usually the part of the molecule that does not come from derivatization) are considered when correcting. Recommended to be checked
* **Calculate Mean Enrichment**: If checked, mean isotopic enrichment is calculated for each molecule
* **High Resolution Mode**: If checked, performs high resolution correction on the data. Should only be checked if you know that you have high resolution data
* **Advanced Options**: see section [Input files and parameters](#input-files-and-parameters)

## 5.2 Using IsoCorrectoR via the R console (IsoCorrectoR and IsoCorrectoRGUI package)

The function that performs the correction - **IsoCorrection()** - can be **called directly from the R console** or via an R-script. To use IsoCorrectoR directly via the R console, the **IsoCorrectoR package has to be installed**.If you have installed IsoCorrectoRGUI, IsoCorrectoR has been installed automatically in the process (see section [Installing IsoCorrectoR](#installing-isocorrector)). **To use IsoCorrection(), start an R-session (e.g. by starting RStudio)** and **load the IsoCorrectoR base package with library(IsoCorrectoR)**. Then **call the function IsoCorrection() with the desired parameter settings**. Once the correction is finished, the function will write files with the corrected data (csv or xls) and a log file to the desired output directory.

The function requires at least the following parameters:

* Path to a measurement file containing the uncorrected measurements
* Path to an element information file
* Path to a molecule information file

#### 5.2.0.1 Function call:

```
IsoCorrection(MeasurementFile=NA, ElementFile=NA, MoleculeFile=NA,
              CorrectTracerImpurity=FALSE, CorrectTracerElementCore=TRUE,
              CalculateMeanEnrichment=TRUE, UltraHighRes=FALSE,
              DirOut='.', FileOut='result', FileOutFormat='csv',
              ReturnResultsObject=FALSE, CorrectAlsoMonoisotopic=FALSE,
              CalculationThreshold=10^-8, CalculationThreshold_UHR=8,
              verbose=FALSE, Testmode=FALSE)
```

#### 5.2.0.2 Basic arguments:

* **MeasurementFile**: The file that contains the measured data to be corrected. Has to be set
* **ElementFile**: The file that contains the element information required for correction. Has to be set
* **MoleculeFile**: The file that contains the information on the molecules for which data is to be corrected. Has to be set
* **CorrectTracerImpurity**: If TRUE, correction for isotopic impurity of the tracer substrate is performed
* **CorrectTracerElementCore**: If TRUE, the tracer element atoms in the core molecule (usually the part of the molecule that does not come from derivatization) are considered when correcting. Recommended to be set to TRUE
* **CalculateMeanEnrichment**: If TRUE, mean isotopic enrichment is calculated for each molecule
* **UltraHighRes**: If TRUE, performs high resolution correction on the data. Should only be set to TRUE if you know that you have high resolution data
* **DirOut**: String that defines the directory the corrected data and log-file should be written to. Defaults to the current working directory (‘.’)
* **FileOut**: String that defines the name of the file that contains the corrected data. The name of the file will be IsoCorrectoR\_[FileOut].[FileOutFormat]. If the format is csv, the name will also contain the type of corrected data in the respective file
* **FileOutFormat**: Defines the format of the files that contain the corrected data. Can either be ‘csv’ or ‘xls’. If ‘csv’ is choosen, multiple files will be produced, one for each type of corrected data (corrected data, fractions, mean enrichment…). If ‘xls’ is choosen, all correction results are provided in one excel file in different sheets
* **ReturnResultsObject**: If TRUE, returns the correction results as a list in the current R-session in addition to writing the results to file. This is useful if the corrected data has to be processed directly in R
* **verbose**: If TRUE, status messages are sent to standard output.

#### 5.2.0.3 Advanced arguments (usually need not be changed):

* **CorrectAlsoMonoisotopic**: If TRUE, will also provide monoisotopic correction results
* **CalculationThreshold**: Defines a threshold to stop probability calculations at for making correction faster (normal resolution mode). Should be left at default value
* **CalculationThreshold\_UHR**: Defines a threshold to stop probability calculations at for making correction faster (high resolution mode). Should be left at default value
* **Testmode**: If TRUE, starts a testmode for development purposes. Not required for users of IsoCorrectoR

#### 5.2.0.4 Returned value

The IsoCorrection() function returns a list with 4 elements: success, results, log and error.

* **success**: string that is “TRUE” if the correction was successful, “FALSE” if an error occured and “WARNINGS” if warnings occured
* **results**: a list containing a dataframe for each type of corrected data (normal, fractions, mean enrichment…)
* **log**: list containing log information on the correction run (parameters, file names and paths, warnings and errors)
* **error**: contains a string with the associated error message if an error occurred, empty otherwise

The list element **results** only contains the data from correction if ReturnResultsObject is set to TRUE.

See section [Input files and parameters](#input-files-and-parameters) for further information on input files, input file structure and the function parameters.

## 5.3 Result files produced by IsoCorrectoR

IsoCorrectoR writes the correction results either to multiple csv files or to multiple worksheets of a single xls file, depending on user choice. The result csv-files/xls-worksheets generated are:

* **Corrected**: The corrected data
* **CorrectedFractions**: The corrected data, as fractions
* **Residuals**: The residual error of the correction procedure. Values that are high in relation to the corresponding corrected values indicate that correction was problematic in these cases. Errors in measurement/peak integration are usually the cause of correction residuals, especially in the case of measured values that are small in relation to the measured values of other isotopologues of the same molecule
* **RelativeResiduals**: The residuals divided by the corrected values. A measure of goodness of correction
* **RawData**: The uncorrected, measured values
* **MeanEnrichment**: The mean isotopic enrichment for each molecule. Writing of this file can be switched off

Additionally, a log-file will be written, containing information on folders/files and parameters used in the correction procedure.

If the **CorrectAlsoMonoisotopic** parameter is set to TRUE (default FALSE), the following files/worksheets will be produced in addition (but are usually not needed):

* **CorrectedMonoisotopic**: The corrected data considering only the monoisotopic species (see [Correction results for monoisotopic species](#correction-results-for-monoisotopic-species) in the advanced correction parameters for more information)
* **CorrectedMonoisotopicFractions**: The corrected data considering only the monoisotopic species, as fractions

## 5.4 Starting IsoCorrectoR GUI directly under Windows (IsoCorrectoRGUI package)

In approach for using the GUI described before, an R-session had to be started manually before the GUI could be started. **It is also possible to start the GUI directly without manually starting an R-session beforehand**. For Windows users, we provide a setup to do this. The IsoCorrectoRGUI package directory (you can view the default directories for installing packages in R by typing .libPaths() in the R console) contains a folder called **GUI\_direct\_start** in extdata. In this folder you will find a file called **IsoCorrectoR.bat**. Open the file with a text editor, e.g. Editor, Notepad or Notepad++. In this file, you have to exchange the **‘insert\_your\_path\_to\_R.exe\_here’** in the line **SET path\_to\_R=‘insert\_your\_path\_to\_R.exe\_here’** by the **path to your R-executable (R.exe)** in quotation marks, something like ‘C:/Program Files/R/R-3.3.3/bin/R.exe’. Then save the changes you made to the file. You can now create a shortcut of the IsoCorrectoR.bat file and put that shortcut anywhere you like. **Don’t change the position of the original file or of the GUI\_direct\_start.R file**. By double-clicking the shortcut, the IsoCorrectoR GUI can now be started directly.

A similar approach using a bash-script instead of a batch-script can be used to start the GUI directly on Linux and Mac OS operating systems.

# 6 Input files and parameters

## 6.1 Input files

Input files must be either in ‘csv’ or ‘xls’/‘xlsx’ format. You can find examples for input files in the folder **extdata** in the directory where you installed the IsoCorrectoR package (you can view the default paths for installing packages in R by typing .libPaths() in the R console). The **exdata** folder contains input files and results for both normal and high resolution data.

### 6.1.1 Molecule information file

The molecule information file contains all relevant information on the molecules that are to be corrected for natural isotope abundance/tracer purity. The file must contain three columns with the names **Molecule**, **MS ion or MS/MS product ion** and **MS/MS neutral loss**. The names/IDs of the molecules to be corrected are given in the first column of the file.

The file has to be adjusted depending on the molecules measured (taking into account the derivatizations used), the type of measurement performed (MS or MS/MS) and the tracer element used. **For each molecule(-fragment) to be corrected, the number of atoms of all elements relevant for correction needs to be given in a sum formula, for example: C6H12O2N1LabC2** (alanine product ion sum formula from the example table below). The **prefix Lab marks the tracer element**. In the example, C6 indicates that there are in total 6 atoms of carbon in the molecule or fragment considered. Then, **LabC2 provides the information that of those 6 carbons, 2 positions may actually be labeled due to incorporation from the tracer substrate**. The other 4 positions cannot contain tracer from the tracer substrate e.g. because they stem from derivatization.

For **MS1 measurements**, the **second column** of the molecule file, **MS ion or MS/MS product ion** needs to be filled with the **sum formula of the ion** arriving at the detector. The **third column** must remain **empty**. In the case of **MS/MS measurements**, the **second column** needs to be filled with the sum formula of the **product ion** while the **third column**, **MS/MS neutral loss**, must contain the information for the **neutral loss** portion.

**Be aware that also elements that occur only once in the molecule(-fragment) must be assigned a number, e.g. N1** in the example above. Elements that do not occur at all need not be mentioned. If an element is present in the molecule information file but not in the element information file, this will produce an error and the correction is aborted.

In high resolution correction, multiple tracers can be considered in a single molecule. Thus, e.g. C9N1LabC2LabN1 can be written for a glycine molecule that can contains both 13C and 15N tracers. It is important to note that due to the nature of high resolution correction, elements other than the tracer elements are not relevant to the correction and need not be provided. Providing multiple tracers in normal resolution mode will result in an error, as well as providing a neutral loss sum formula in high resolution mode (MS/MS mode is not supported for high resolution correction).

See the tables below for normal and high resolution example setups of the file.

#### 6.1.1.1 Example for molecule information file structure

Table 1: Molecule information for normal resolution data

| Molecule | MS ion or MS/MS product ion | MS/MS neutral loss |
| --- | --- | --- |
| Ala | C6H12O2N1LabC2 | C4H8O2LabC1 |
| Asp | C10H18O4N1LabC3 | C4H8O2LabC1 |
| Glu | C11H20O4N1LabC4 | C4H8O2LabC1 |
| Gly | C6H10O3N1LabC2 |  |
| Orn | C13H23O5N2LabC5 |  |
| Pro | C9H14O3N1LabC5 |  |
| Ser | C7H12O4N1LabC3 |  |

Table 2: Molecule information for high resolution data

| Molecule | MS ion or MS/MS product ion | MS/MS neutral loss |
| --- | --- | --- |
| Gly | C9N1LabC2LabN1 |  |
| Arg | C13N4LabC6LabN4 |  |
| Asn | C11N2LabC4LabN2 |  |

### 6.1.2 Measurement file

This file contains the measured data that needs to be corrected. The row names in the first column of the file define the kind of measurement made (e.g. what kind of transition was measured in an MS/MS experiment), the column names in the first row define the samples. The **entry in row 1/column 1 of the file must be Measurements/Samples**. The measured values must be placed so that they match the measurement and sample they belong to.

The **names of the measurements in the first column** need to be **consistent with the following nomenclature**, where **‘Name’ is the name of the respective molecule specified in the molecule information file: Name\_x.y for MS/MS measurements and Name\_x for non-MS/MS measurements**. Here, **x is the mass shift of the precursor** of a given measurement with respect to the precursor of the completely unlabeled molecule. **y is the mass shift of the product ion**.

An alanine molecule that is named ‘Ala’ in the molecule information file and that shows a mass shift of 2 in the precursor and 1 in the product ion would be named Ala\_2.1. A non-MS/MS-measurement of that alanine species with a mass shift of 2 would be named Ala\_2. See the table below for an example file setup (MS/MS case for molecule Ala and MS1 case for molecule Ser).

If **high resolution measurements** are to be corrected, the measurement names must be specified according to the **following example: Gly\_C2.N1 for the measurement corresponding to a glycine molecule containing two C tracers and one N tracer**. If there are more than two tracers employed in the experiment, the syntax is analogous (e.g. Gly\_C2.N1.O2 if an O tracer is used in addition). The sequence of occurence of the elements in the measurement names must equal the sequence of the tracer elements in the sum formula in the molecule information file (**e.g. sum formula of Gly: C9N1LabC2LabN1, measurement name: Gly\_C2.N1, not Gly\_N1.C2**).

See the tables below for example setups of a measurement file: In the normal resolution case, the molecule Ala was measured in MS/MS mode and can contain up to 2 tracers in the product ion and up to 1 tracer in the neutral loss. Ser was measured in MS1 mode and can contain up to 3 tracers. In the high resolution example, Gly and Asn were measured in a combined 13C and 15N tracing experiment and can contain both 13C and 15N tracer.

#### 6.1.2.1 Example for measurement file structure

Table 3: Measurement information for normal resolution data

| Measurements/Samples | Sample1 | Sample2 | Sample3 | Sample4 | Sample5 |
| --- | --- | --- | --- | --- | --- |
| Ala\_0.0 | 1730000 | 4410000 | 155000 | 11000000 | 2690000 |
| Ala\_1.0 | 57200 | 167000 | 7000 | 436000 | 107000 |
| Ala\_1.1 | 125000 | 299000 | 7300 | 854000 | 195000 |
| Ala\_2.1 | 3610 | 13800 |  | 82000 |  |
| Ala\_2.2 | 9110 | 28500 | 0 | 98200 | 18400 |
| Ala\_3.2 | 0 | 1130 |  | 218000 | 4230 |
| Ser\_0 | 5740000 | 11900000 | 7440000 | 6970000 | 4980000 |
| Ser\_1 | 483000 | 1070000 | 678000 | 620000 | 436000 |
| Ser\_2 |  | 135000 | 85500 | 84600 | 70000 |
| Ser\_3 | 4170 | 6760 | 6000 | 9330 | 135000 |

Table 4: Measurement information for high resolution data

| Measurements/Samples | Sample1 | Sample2 | Sample3 | Sample4 | Sample5 |
| --- | --- | --- | --- | --- | --- |
| Gly\_C0.N0 | 100 | 100.00 | 100 | 100 | 50 |
| Gly\_C0.N1 | 100 | 100.00 | 100 | 100 | 50 |
| Gly\_C1.N0 | 100 | 50.00 | 25 | 50 | 100 |
| Gly\_C1.N1 | 100 | 50.00 | 25 | 50 | 100 |
| Gly\_C2.N0 | 100 | 25.00 | 6.25 | 100 | 50 |
| Gly\_C2.N1 | 100 | 25.00 | 6.25 | 100 | 50 |
| Asn\_C0.N0 | 100 | 100.00 | 100 | 100 | 50 |
| Asn\_C0.N1 | 100 | 100.00 | 100 | 100 | 50 |
| Asn\_C0.N2 | 100 | 100.00 | 100 | 100 | 50 |
| Asn\_C1.N0 | 100 | 50.00 | 25 | 50 | 100 |
| Asn\_C1.N1 | 100 | 50.00 | 25 | 50 | 100 |
| Asn\_C1.N2 | 100 | 50.00 | 25 | 50 | 100 |
| Asn\_C2.N0 | 100 | 25.00 | 6.25 | 50 | 100 |
| Asn\_C2.N1 | 100 | 25.00 | 6.25 | 50 | 100 |
| Asn\_C2.N2 | 100 | 25.00 | 6.25 | 50 | 100 |
| Asn\_C3.N0 | 100 | 12.50 |  | 50 | 100 |
| Asn\_C3.N1 | 100 | 12.50 | 1.5625 | 50 | 100 |
| Asn\_C3.N2 | 100 | 12.50 | 1.5625 | 50 | 100 |
| Asn\_C4.N0 | 100 | 6.25 | 0.390625 | 100 | 50 |
| Asn\_C4.N1 | 100 | 6.25 |  | 100 | 50 |
| Asn\_C4.N2 | 100 | 6.25 | 0 | 100 | 50 |

#### 6.1.2.2 Handling of missing values in the measurement file

Assume e.g. a serine molecule that can be labeled with 13C at 3 positions. What can often be the case is that a signal cannot be measured or integrated properly, e.g. because it is below LOD or because there are peak overlaps. For performing appropriate correction, correction tools require measured data for all possible 13C isotopologues of serine: The species with 0, 1, 2 and 3 13C.

If there are missing values, you may want to perform correction on the species that could be measured properly anyway, as (correctly performed) partial correction is better than no correction at all. You could achieve this by simply including species with a missing value in the data to be corrected with their area value set to 0.

This way however, the correction algorithm may assume something that is not correct: If the value could not be integrated due to overlapping peaks and not because it is e.g. below LOD, a 0 is definitely wrong and will lead to wrong correction results for the other species, too.

IsoCorrectoR circumvents this problem by not expecting you to enter an area value for a species if you do not know it. You can simply leave the associated field in your measurement data file blank. IsoCorrectoR will recognize this and simply limit its correction to the species for which a value was given. It will then issue warnings in the log file for each sample and molecule with missing values, so that you can keep track of what happens. Clearly, performing correction with only a subset of species is usually not as accurate as when using all species, but it avoids the error introduced by assuming that missing values are always 0.

### 6.1.3 Element information file

The element information file contains **all relevant information on the elements important for the correction process**. These are elements that occur in the molecules to be corrected and the stable isotopes of which show a high enough natural abundance to make a recognizable contribution to measurements of higher mass. The file has four columns which must be named **Element**, **Isotope abundance\_Mass shift**, **Tracer isotope mass shift**, and **Tracer purity**. In the **first column**, the file must contain the **element names (e.g. C, N, O…)**. The **second column** contains the **natural isotope abundance (probability of occurrence) and the mass shift of the isotopes** for each element. The mass shift is provided in relation to the isotope with the highest natural abundance. Thus, when considering e.g. C, the mass shift of 12C, which is the most abundant isotope of C, would be 0 and the mass shift of 13C would be 1.For each isotope, abundance and mass shift are separated by an underscore (\_) while the different isotopes of an element are separated by a forward slash (/). For example 0.0107\_1/0.9893\_0 for the C isotopes 13C and 12C, respectively. The order of isotopes is not important.

In the uncommon case of the most abundant isotope not being the stable isotope with the lowest mass (e.g. when considering Se), negative mass shifts have to be employed (see example element file provided with the package).

In the **third column**, the **mass
shift associated with the tracer isotope** is given (e.g. 1 for 13C or 2 for 18O) in the row corresponding to the tracer element. If correction for tracer purity is desired, the **purity of the tracer** has to be
given as a fraction value in **column four**. See the table below for an example setup of the file.

#### 6.1.3.1 Example for element information file structure

Table 5: Element information (resolution independent)

| Element | Isotope abundance\_Mass shift | Tracer isotope mass shift | Tracer purity |
| --- | --- | --- | --- |
| C | 0.0107\_1/0.9893\_0 | 1 | 0.99 |
| O | 0.99757\_0/0.00038\_1/0.00205\_2 | 2 | 0.99 |
| N | 0.99632\_0/0.00368\_1 | 1 | 0.99 |
| S | 0.9493\_0/0.0076\_1/0.0429\_2/0.0002\_4 |  |  |
| H | 0.000115\_1/0.999885\_0 | 1 | 0.99 |
| Si | 0.922297\_0/0.046832\_1/0.030872\_2 |  |  |
| P | 1\_0 |  |  |
| Se | 0.0089\_-6/0.0937\_-4/0.0763\_-3/0.2377\_-2/0.4961\_0/0.0873\_2 |  |  |

## 6.2 Basic correction parameters

### 6.2.1 Tracer purity correction

Tracer purity is the probability that a tracer element atom in the tracer substrate that should be labeled actually is labeled. E.g. a 99.0% isotopic purity 1,2-13C2-Glucose has a 99.0% chance for each of its carbon atom positions 1 and 2 of containing a 13C. Thus, there is a 1.0% chance for each of those carbons that they are not 13C. Consequently, molecules that contain portions of the tracer substrate due to metabolic activity inherit its impurity and contribute to measurements of lower mass according to the impurity of the tracer. This is due to the decrease in mass shift associated with tracer impurity (e.g. 12C instead of 13C at a carbon position). Tracer purity correction should only be performed if the purity information at a hand is reliable. If **CorrectTracerImpurity** is set to TRUE, correction for tracer impurity is performed in addition to natural abundance correction, if it is set to FALSE, no correction for tracer impurity is performed, only correction for natural isotope abundance.

### 6.2.2 Correction of tracer element natural abundance in the core molecule

If **CorrectTracerElementCore** is TRUE, the natural isotope abundance of the core tracer element atoms is taken into account for the correction procedure. The core of a molecule(-fragment) to be corrected is defined as the portion which can incorporate atoms from the tracer substrate (through metabolism).

The maximum number of tracer element atoms expected in the core is given by the user in the Lab[Element-Name] entry in the molecule information file (e.g. LabC or LabN). Usually, Lab[Element-Name] is just set to the amount of tracer element atoms present in the molecule(-fragment) without derivatization (e.g. LabC5 if C is the tracer element and glutamate is the molecule in question, measured in MS1). If possible, **CorrectTracerElementCore** should be active, as the core usually makes a substantial contribution to the natural abundance correction. Switching the functionality off leads to only partially corrected values. This may also be desired, for example if only the natural abundance contribution of derivatization is to be corrected.

Another reason for setting **CorrectTracerElementCore** to FALSE may be that the isotopic abundances of the tracer element in the tracer substrate are unknown. This can occur with partially labeled tracer substrates like 1,2-13C2-Glucose. Part of the molecule is unlabeled. Due to the production process it is however not guaranteed that the unlabeled positions follow natural isotope abundance. This should usually be the case. If there are doubts, however, the manufacturer should be consulted. Abnormality can be checked by measuring the tracer substrates isotopologue distribution and correcting it with **CorrectTracerElementCore** turned on and **CorrectTracerImpurity** turned off. In this case, high correction residuals indicate non-natural isotope abundance, as well as area values at m/z higher than that of the substrate itself which are substantially higher than 0. The core tracer element correction always works with fully labeled tracer substrates like U-13C-Glucose or U-13C-Glutamine.

### 6.2.3 Normal/High resolution correction

The parameter **UltraHighRes** decides whether normal or high resolution correction is performed. FALSE stands for normal resolution, TRUE for high resolution. High resolution correction should only be used for high resolution data, meaning that the incorporation of isotopes that give the same nominal mass shift (e.g. the incorporation of 13C compared to the incorporation of 15N) can be resolved due to mass defect related differences. If this is the case, also data from experiments where multiple tracers were used simultaneously (e.g. 13C and 15N) can be corrected using the high resolution mode.

Be aware that using the high resolution mode on normal resolution data will either abort directly (if measurements are named according to the normal resolution scheme in the measurement file) or provide wrong results as correction is only performed on the tracer element and no other elements. The same is true for performing normal resolution correction on high resolution data. Here, natural abundance contributions are considered that are not present in high resolution data because they can be resolved spectrometrically. Plus, normal resolution correction cannot be used for data of experiments where multiple tracers (e.g. 13C and 15N) have been employed simultaneously.

## 6.3 Advanced correction parameters

These parameters usually need not be changed.

### 6.3.1 Correction results for monoisotopic species

It might at first appear intuitive that the correction for natural isotope abundance and tracer impurity would correspond to a substraction of those contributions from the measured values. But such values would only reflect the quantity of the corrected monoisotopic species, the m/z of which corresponds to the respective m/z windows chosen for the measurements (the monoisotopic species is the respective labeled species where all isotopes (except for the tracers) are present in their most abundant from).

However, the quantity of the monoisotopic species is not a very good measure when trying to compare the different isotopologues of a molecule quantitatively. This is because the ratio between the monoisotopic portion and the total amount of a given labeled species varies with the amount of label incorporated from the tracing experiment. Thus, IsoCorrectoR by default provides the corrected total amount values of the labeled species.

Here, the contributions from other species are removed, while the quantities of the different natural abundance and tracer impurity derived isotopologues of the species to be corrected are added (correcting for natural abundance and tracer impurity means removing contributions from other species, not the natural abundance/tracer purity derived portions of the species to be corrected itself). If corrected monoisotopic values are explicitly wished for, however, this can be achieved by running IsoCorrectoR with the option **CorrectAlsoMonoisotopic** = TRUE. Then, corrected monoisotopic values are provided in addition to the corrected total amount values. By default, **CorrectAlsoMonoisotopic** is set to FALSE.

### 6.3.2 Calculation thresholds

In normal resolution mode, **CalculationThreshold** can be set to omit the calculation of natural abundance/tracer purity contribution probabilities that are lower than the threshold. This saves computational resources. The threshold is set to 10^-8 by default and should only be changed with good consideration. **CalculationThreshold** must be a value between 10^-2 and 0, the lower the value, the more accurate the correction. If set to 0, the threshold is turned off completely.

In high resolution mode **CalculationThreshold\_UHR** can be set to limit the calculation of contribution probabilities. This is done by omitting the calculation of probabilities associated with the total natural abundance incorporation or tracer impurity caused loss of [**CalculationThreshold\_UHR**] tracer isotopes. At **CalculationThreshold\_UHR** = 8 (default), those probabilities can be considered negligible and the threshold should only be changed with good consideration. **CalculationThreshold\_UHR** must be a non-negative integer value, the higher the value, to more accurate the correction. If set to 0, the threshold is turned off completely.

# SessionInfo

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
## [1] IsoCorrectoR_1.28.0 readxl_1.4.5        BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] jsonlite_2.0.0      dplyr_1.1.4         compiler_4.5.1
##  [4] BiocManager_1.30.26 tidyselect_1.2.1    stringr_1.5.2
##  [7] jquerylib_0.1.4     yaml_2.3.10         fastmap_1.2.0
## [10] readr_2.1.5         R6_2.6.1            generics_0.1.4
## [13] knitr_1.50          tibble_3.3.0        bookdown_0.45
## [16] bslib_0.9.0         pillar_1.11.1       tzdb_0.5.0
## [19] rlang_1.1.6         cachem_1.1.0        stringi_1.8.7
## [22] xfun_0.53           quadprog_1.5-8      sass_0.4.10
## [25] WriteXLS_6.8.0      cli_3.6.5           magrittr_2.0.4
## [28] digest_0.6.37       hms_1.1.4           lifecycle_1.0.4
## [31] vctrs_0.6.5         evaluate_1.0.5      pracma_2.4.6
## [34] glue_1.8.0          cellranger_1.1.0    rmarkdown_2.30
## [37] tools_4.5.1         pkgconfig_2.0.3     htmltools_0.5.8.1
```

# References

Buescher, JM, MR Antoniewicz, LG Boros, SC Burgess, H Brunengraber, CB Clish, RJ DeBerardinis, et al. 2015. “A roadmap for interpreting (13)C metabolite labeling patterns from cells.” *Curr Opin Biotechnol* 34 (August): 189–201. <https://doi.org/10.1016/j.copbio.2015.02.003>.

Carreer, WJ, RM Flight, and HN Moseley. 2013. “A Computational Framework for High-Throughput Isotopic Natural Abundance Correction of Omics-Level Ultra-High Resolution FT-MS Datasets.” *Metabolites* 3 (4). <https://doi.org/10.3390/metabo3040853>.

Heinrich, P, C Kohler, L Ellmann, P Kuerner, R Spang, PJ Oefner, and K Dettmer. 2018. “Correcting for natural isotope abundance and tracer impurity in MS-, MS/MS- and high-resolution-multiple-tracer-data from stable isotope labeling experiments with IsoCorrectoR.” *Scientific Reports* 8 (1): 17910. <https://doi.org/10.1038/s41598-018-36293-4>.

Jungreuthmayer, C, S Neubauer, T Mairinger, J Zanghellini, and S Hann. 2016. “ICT: isotope correction toolbox.” *Bioinformatics* 32 (1): 154–6. <https://doi.org/10.1093/bioinformatics/btv514>.

Millard, P, F Letisse, S Sokol, and JC Portais. 2012. “IsoCor: correcting MS data in isotope labeling experiments.” *Bioinformatics* 28 (9): 1294–6. <https://doi.org/10.1093/bioinformatics/bts127>.